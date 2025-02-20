module("modules.logic.fight.entity.comp.FightNameUIBuffMgr", package.seeall)

slot0 = class("FightNameUIBuffMgr")
slot1 = 4
slot2 = {
	[20004.0] = true,
	[20003.0] = true,
	[30003.0] = true,
	[30004.0] = true
}

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.entity = slot1
	slot0.goBuffItem = slot2
	slot0.opContainerTr = slot3
	slot0.buffItemList = {}
	slot0.buffLineCount = 0

	gohelper.setActive(slot0.goBuffItem, false)
	slot0:refreshBuffList()
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceStart, slot0.updateBuff, slot0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0.updateBuff, slot0)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0.updateBuff, slot0)
	FightController.instance:registerCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0.updateBuff, slot0)
	FightController.instance:registerCallback(FightEvent.GMForceRefreshNameUIBuff, slot0._onGMForceRefreshNameUIBuff, slot0)
	FightController.instance:registerCallback(FightEvent.AfterForceUpdatePerformanceData, slot0._onAfterForceUpdatePerformanceData, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0.goBuffItem = nil
	slot0.opContainerTr = nil
	slot0.buffItemList = nil
	slot0.deleteBuffItemList = nil

	TaskDispatcher.cancelTask(slot0.playDeleteAniDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceStart, slot0.updateBuff, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0.updateBuff, slot0)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0.updateBuff, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnClothSkillRoundSequenceFinish, slot0.updateBuff, slot0)
	FightController.instance:unregisterCallback(FightEvent.GMForceRefreshNameUIBuff, slot0._onGMForceRefreshNameUIBuff, slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterForceUpdatePerformanceData, slot0._onAfterForceUpdatePerformanceData, slot0)
end

function slot0.updateBuff(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 and slot1 ~= slot0.entity.id then
		return
	end

	if slot2 == FightEnum.EffectType.BUFFDEL then
		if not slot0.deleteBuffItemList then
			slot0.deleteBuffItemList = {}
		end

		for slot9, slot10 in ipairs(slot0.buffItemList) do
			if slot10.buffMO.uid == slot4 then
				slot11 = table.remove(slot0.buffItemList, slot9)
				slot12 = 1

				table.insert(slot0.deleteBuffItemList, slot11)
				TaskDispatcher.runDelay(slot0.playDeleteAniDone, slot0, (not uv0[slot5] or slot11:playAni("close")) and slot11:playAni("disappear"))

				break
			end
		end
	end

	slot0:refreshBuffList()

	if slot2 == FightEnum.EffectType.BUFFADD and lua_skill_buff.configDict[slot3] and slot6.isNoShow == 0 and slot0.curBuffItemCount ~= 0 then
		slot0.buffItemList[slot0.curBuffItemCount]:playAni("appear")
	end

	if slot2 == FightEnum.EffectType.BUFFUPDATE then
		for slot9, slot10 in ipairs(slot0.buffItemList) do
			if slot4 == slot10.buffMO.uid and slot10.buffMO._last_clone_mo and slot10.buffMO._last_clone_mo.duration < slot10.buffMO.duration then
				slot10:playAni("text")
			end
		end
	end
end

function slot0.playDeleteAniDone(slot0)
	if slot0.deleteBuffItemList then
		for slot4, slot5 in ipairs(slot0.deleteBuffItemList) do
			slot5:closeAni()
			gohelper.setActive(slot5.go, false)
			table.insert(slot0.buffItemList, slot5)
		end

		slot0.deleteBuffItemList = {}
	end

	table.sort(slot0.buffItemList, uv0.sortBuffItem)
	slot0:refreshBuffList()
end

function slot0.sortBuffItem(slot0, slot1)
	return slot0.originIndex < slot1.originIndex
end

function slot0.sortBuffMo(slot0, slot1)
	if slot0.time ~= slot1.time then
		return slot0.time < slot1.time
	end

	return slot0.id < slot1.id
end

function slot0.refreshBuffList(slot0)
	if not slot0.entity:getMO() then
		return
	end

	slot2 = FightBuffHelper.filterBuffType(slot1:getBuffList(), FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(slot2)
	table.sort(slot2, uv0.sortBuffMo)

	slot4 = 0
	slot0.buffItemOriginIndex = slot0.buffItemOriginIndex or 0

	for slot9 = 1, slot2 and #slot2 or 0 do
		if lua_skill_buff.configDict[slot2[slot9].buffId] and slot11.isNoShow == 0 and slot4 + (slot0.deleteBuffItemList and #slot0.deleteBuffItemList or 0) < FightEnum.MaxBuffIconCount then
			if not slot0.buffItemList[slot4 + 1] then
				slot12 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.goBuffItem, "buff" .. slot4), FightBuffItem)

				slot12:setTipsOffset(435, 0)
				table.insert(slot0.buffItemList, slot12)

				slot0.buffItemOriginIndex = slot0.buffItemOriginIndex + 1
				slot12.originIndex = slot0.buffItemOriginIndex
			end

			gohelper.setActive(slot12.go, true)
			slot12:updateBuffMO(slot10)
		end
	end

	slot0.curBuffItemCount = slot4

	for slot9 = slot4 + 1, #slot0.buffItemList do
		slot0.buffItemList[slot9]:closeAni()
		gohelper.setActive(slot0.buffItemList[slot9].go, false)
	end

	slot0.buffLineCount = Mathf.Ceil((slot4 + slot5) / uv1)

	recthelper.setAnchorY(slot0.opContainerTr, slot0.buffLineCount * 34.5 - 24)
end

function slot0.getBuffLineCount(slot0)
	return slot0.buffLineCount
end

function slot0.showPoisoningEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.buffItemList) do
		if slot6.buffMO.buffId == slot1.id then
			slot6:showPoisoningEffect()
		end
	end
end

function slot0._onMultiHpChange(slot0, slot1)
	if slot0.entity and slot0.entity.id == slot1 then
		slot0:refreshBuffList()
	end
end

function slot0._onGMForceRefreshNameUIBuff(slot0, slot1)
	if slot0.entity and slot0.entity.id == slot1 then
		slot0:refreshBuffList()
	end
end

function slot0._onAfterForceUpdatePerformanceData(slot0)
	slot0:refreshBuffList()
end

return slot0
