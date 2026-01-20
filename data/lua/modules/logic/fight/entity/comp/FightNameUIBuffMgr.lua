-- chunkname: @modules/logic/fight/entity/comp/FightNameUIBuffMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIBuffMgr", package.seeall)

local FightNameUIBuffMgr = class("FightNameUIBuffMgr")
local BuffCount1Line = 4
local canPlaySpecialConfigEffectIdDict = {
	[20004] = true,
	[20003] = true,
	[30003] = true,
	[30004] = true
}

function FightNameUIBuffMgr:init(entity, goBuffItem, opContainerTr)
	self.entity = entity
	self.goBuffItem = goBuffItem
	self.opContainerTr = opContainerTr
	self.buffItemList = {}
	self.buffLineCount = 0

	gohelper.setActive(self.goBuffItem, false)
	self:refreshBuffList()
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, self.updateBuff, self)
	FightController.instance:registerCallback(FightEvent.SkillHideBuffLayer, self.updateBuff, self)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, self.updateBuff, self)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, self._onMultiHpChange, self)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self.updateBuff, self)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, self.updateBuff, self)
	FightController.instance:registerCallback(FightEvent.GMForceRefreshNameUIBuff, self._onGMForceRefreshNameUIBuff, self)
	FightController.instance:registerCallback(FightEvent.AfterForceUpdatePerformanceData, self._onAfterForceUpdatePerformanceData, self)
	FightController.instance:registerCallback(FightEvent.CoverPerformanceEntityData, self._onCoverPerformanceEntityData, self)
end

function FightNameUIBuffMgr:beforeDestroy()
	self.goBuffItem = nil
	self.opContainerTr = nil
	self.buffItemList = nil
	self.deleteBuffItemList = nil

	TaskDispatcher.cancelTask(self.playDeleteAniDone, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, self.updateBuff, self)
	FightController.instance:unregisterCallback(FightEvent.SkillHideBuffLayer, self.updateBuff, self)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, self.updateBuff, self)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, self._onMultiHpChange, self)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self.updateBuff, self)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, self.updateBuff, self)
	FightController.instance:unregisterCallback(FightEvent.GMForceRefreshNameUIBuff, self._onGMForceRefreshNameUIBuff, self)
	FightController.instance:unregisterCallback(FightEvent.AfterForceUpdatePerformanceData, self._onAfterForceUpdatePerformanceData, self)
	FightController.instance:unregisterCallback(FightEvent.CoverPerformanceEntityData, self._onCoverPerformanceEntityData, self)
end

function FightNameUIBuffMgr:updateBuff(entityId, effectType, buffId, buff_uid, configEffect)
	if entityId and entityId ~= self.entity.id then
		return
	end

	if effectType == FightEnum.EffectType.BUFFDEL then
		if not self.deleteBuffItemList then
			self.deleteBuffItemList = {}
		end

		for i, v in ipairs(self.buffItemList) do
			if v.buffMO.uid == buff_uid then
				local buffItem = table.remove(self.buffItemList, i)
				local ani_duration = 1

				if canPlaySpecialConfigEffectIdDict[configEffect] then
					ani_duration = buffItem:playAni("close")
				else
					ani_duration = buffItem:playAni("disappear")
				end

				table.insert(self.deleteBuffItemList, buffItem)
				TaskDispatcher.runDelay(self.playDeleteAniDone, self, ani_duration)

				break
			end
		end
	end

	self:refreshBuffList()

	if effectType == FightEnum.EffectType.BUFFADD then
		local buffCO = lua_skill_buff.configDict[buffId]

		if buffCO and buffCO.isNoShow == 0 and self.curBuffItemCount ~= 0 then
			self.buffItemList[self.curBuffItemCount]:playAni("appear")
		end
	end

	if effectType == FightEnum.EffectType.BUFFUPDATE then
		for i, buffItem in ipairs(self.buffItemList) do
			if buff_uid == buffItem.buffMO.uid then
				local lastDuration = FightDataHelper.tempMgr.buffDurationDic[entityId]

				lastDuration = lastDuration and lastDuration[buff_uid]

				if lastDuration and lastDuration < buffItem.buffMO.duration then
					buffItem:playAni("text")
				end
			end
		end
	end
end

function FightNameUIBuffMgr:playDeleteAniDone()
	if self.deleteBuffItemList then
		for _, buffItem in ipairs(self.deleteBuffItemList) do
			buffItem:closeAni()
			gohelper.setActive(buffItem.go, false)
			table.insert(self.buffItemList, buffItem)
		end

		self.deleteBuffItemList = {}
	end

	table.sort(self.buffItemList, FightNameUIBuffMgr.sortBuffItem)
	self:refreshBuffList()
end

function FightNameUIBuffMgr.sortBuffItem(item1, item2)
	return item1.originIndex < item2.originIndex
end

function FightNameUIBuffMgr.sortBuffMo(buffMO1, buffMO2)
	if buffMO1.time ~= buffMO2.time then
		return buffMO1.time < buffMO2.time
	end

	return buffMO1.id < buffMO2.id
end

function FightNameUIBuffMgr:refreshBuffList()
	local entityMO = self.entity:getMO()

	if not entityMO then
		return
	end

	local buffMOs = entityMO:getBuffList()

	buffMOs = FightBuffHelper.filterBuffType(buffMOs, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(buffMOs)
	table.sort(buffMOs, FightNameUIBuffMgr.sortBuffMo)

	local count = buffMOs and #buffMOs or 0
	local itemCount = 0

	self.buffItemOriginIndex = self.buffItemOriginIndex or 0

	local del_item_list_count = self.deleteBuffItemList and #self.deleteBuffItemList or 0

	for i = 1, count do
		local buffMO = buffMOs[i]
		local buffCO = lua_skill_buff.configDict[buffMO.buffId]

		if buffCO and buffCO.isNoShow == 0 and itemCount + del_item_list_count < FightEnum.MaxBuffIconCount then
			itemCount = itemCount + 1

			local buffItem = self.buffItemList[itemCount]

			if not buffItem then
				local buffGO = gohelper.cloneInPlace(self.goBuffItem, "buff" .. itemCount)

				buffItem = MonoHelper.addNoUpdateLuaComOnceToGo(buffGO, FightBuffItem)

				buffItem:setTipsOffset(435, 0)
				table.insert(self.buffItemList, buffItem)

				self.buffItemOriginIndex = self.buffItemOriginIndex + 1
				buffItem.originIndex = self.buffItemOriginIndex
			end

			gohelper.setActive(buffItem.go, true)
			buffItem:updateBuffMO(buffMO)
		end
	end

	self.curBuffItemCount = itemCount

	for i = itemCount + 1, #self.buffItemList do
		self.buffItemList[i]:closeAni()
		gohelper.setActive(self.buffItemList[i].go, false)
	end

	self.buffLineCount = Mathf.Ceil((itemCount + del_item_list_count) / BuffCount1Line)

	local height = self.buffLineCount * 34.5 - 24

	recthelper.setAnchorY(self.opContainerTr, height)
end

function FightNameUIBuffMgr:getBuffLineCount()
	return self.buffLineCount
end

function FightNameUIBuffMgr:showPoisoningEffect(buffCO)
	for _, buffItem in ipairs(self.buffItemList) do
		if buffItem.buffMO.buffId == buffCO.id then
			buffItem:showPoisoningEffect()
		end
	end
end

function FightNameUIBuffMgr:_onMultiHpChange(entityId)
	if self.entity and self.entity.id == entityId then
		self:refreshBuffList()
	end
end

function FightNameUIBuffMgr:_onGMForceRefreshNameUIBuff(entityId)
	if self.entity and self.entity.id == entityId then
		self:refreshBuffList()
	end
end

function FightNameUIBuffMgr:_onAfterForceUpdatePerformanceData()
	self:refreshBuffList()
end

function FightNameUIBuffMgr:_onCoverPerformanceEntityData(entityId)
	if entityId ~= self.entity.id then
		return
	end

	self:refreshBuffList()
end

return FightNameUIBuffMgr
