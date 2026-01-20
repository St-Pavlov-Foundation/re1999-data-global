-- chunkname: @modules/logic/fight/entity/comp/skill/FightTLEventPlayServerEffect.lua

module("modules.logic.fight.entity.comp.skill.FightTLEventPlayServerEffect", package.seeall)

local FightTLEventPlayServerEffect = class("FightTLEventPlayServerEffect", FightTimelineTrackItem)

function FightTLEventPlayServerEffect:onTrackStart(fightStepData, duration, paramsArr)
	self._list = {}
	self.fightStepData = fightStepData

	if paramsArr[1] == "1" then
		self:_playEffect(FightEnum.EffectType.SUMMONEDDELETE)
	end

	if paramsArr[2] == "1" then
		self:_playEffect(FightEnum.EffectType.MAGICCIRCLEDELETE)
	end

	if paramsArr[3] == "1" then
		self:_playEffect(FightEnum.EffectType.MAGICCIRCLEADD)
	end

	if paramsArr[4] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVE)
	end

	if paramsArr[5] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVEFRONT)
	end

	if paramsArr[6] == "1" then
		self:_playEffect(FightEnum.EffectType.MOVEBACK)
	end

	if paramsArr[7] == "1" then
		self:_playEffect(FightEnum.EffectType.AVERAGELIFE)
	end

	if paramsArr[8] == "1" then
		self:_playEffect(FightEnum.EffectType.BUFFADD)
	end

	if paramsArr[9] == "1" then
		self:_playEffect(FightEnum.EffectType.BUFFDEL)
	end

	if not string.nilorempty(paramsArr[10]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.BUFFADD then
				local buffId = v.buff.buddId
				local buffConfig = lua_skill_buff.configDict[buffId]
				local buffTypeConfig = buffConfig and lua_skill_bufftype.configDict[buffConfig.typeId]

				if buffTypeConfig and buffTypeConfig.type == tonumber(paramsArr[10]) then
					local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFADD], self.fightStepData, v)

					class:onStart()
					table.insert(self._list, class)
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[11]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.effectType == FightEnum.EffectType.BUFFDEL then
				local buffId = v.buff.buddId
				local buffConfig = lua_skill_buff.configDict[buffId]
				local buffTypeConfig = buffConfig and lua_skill_bufftype.configDict[buffConfig.typeId]

				if buffTypeConfig and buffTypeConfig.type == tonumber(paramsArr[11]) then
					local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFDEL], self.fightStepData, v)

					class:onStart()
					table.insert(self._list, class)
				end
			end
		end
	end

	if not string.nilorempty(paramsArr[12]) then
		for i, v in ipairs(self.fightStepData.actEffect) do
			if v.configEffect == FightTLEventDefHit.nuoDiKaLostLife then
				local work = self:com_registWork(FightWorkNuoDikaLostLifeTimeline, v, self.fightStepData, paramsArr[12])

				self:addWork2TimelineFinishWork(work)
				work:start()
			end
		end
	end

	if not string.nilorempty(paramsArr[13]) then
		self.timelineItem.workTimelineItem:onDoneAndKeepPlay()
	end

	local noConditionParam = paramsArr[14]

	if not string.nilorempty(noConditionParam) then
		local arr = string.split(noConditionParam, "#")
		local work = self:com_registWork(Work2FightWork, FightWorkNormalDialog, FightViewDialog.Type.NoCondition, tonumber(arr[2]))

		self:addWork2TimelineFinishWork(work)
	end
end

function FightTLEventPlayServerEffect:_playEffect(effectType)
	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.effectType == effectType then
			local class = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[effectType], self.fightStepData, v)

			class:onStart()
			table.insert(self._list, class)
		end
	end
end

function FightTLEventPlayServerEffect:onTrackEnd()
	return
end

function FightTLEventPlayServerEffect:onDestructor()
	if self._list then
		for i, v in ipairs(self._list) do
			v:onStop()
		end

		self._list = nil
	end
end

return FightTLEventPlayServerEffect
