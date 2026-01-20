-- chunkname: @modules/logic/fight/system/work/FightWorkNuoDikaLostLifeTimeline.lua

module("modules.logic.fight.system.work.FightWorkNuoDikaLostLifeTimeline", package.seeall)

local FightWorkNuoDikaLostLifeTimeline = class("FightWorkNuoDikaLostLifeTimeline", FightWorkItem)

function FightWorkNuoDikaLostLifeTimeline:onConstructor(actEffectData, fightStepData, timelineName)
	self.actEffectData = actEffectData
	self.fightStepData = fightStepData
	self.timelineName = timelineName
end

function FightWorkNuoDikaLostLifeTimeline:onStart()
	local actEffectData = self.actEffectData
	local targetId = actEffectData.targetId
	local fightStepData = self.fightStepData

	FightDataHelper.playEffectData(actEffectData)

	local floatType = FightEnum.FloatType.damage

	if actEffectData.effectType == FightEnum.EffectType.CRIT then
		floatType = FightEnum.FloatType.crit_damage
	end

	local entity = FightHelper.getEntity(targetId)

	if entity then
		local effectNum = actEffectData.effectNum

		if effectNum > 0 then
			local floatNum = entity:isMySide() and -effectNum or effectNum

			FightFloatMgr.instance:float(entity.id, floatType, floatNum)

			if entity.nameUI then
				entity.nameUI:addHp(-effectNum)
			end

			FightController.instance:dispatchEvent(FightEvent.OnHpChange, entity, -effectNum)
		end
	end

	local toId = targetId

	for i, v in ipairs(self.fightStepData.actEffect) do
		if v.configEffect == 60216 then
			toId = v.targetId

			break
		end
	end

	local fakeStepData = FightStepData.New(FightDef_pb.FightStep())

	fakeStepData.isFakeStep = true
	fakeStepData.fromId = targetId
	fakeStepData.toId = toId
	fakeStepData.actType = FightEnum.ActType.SKILL
	actEffectData.targetId = toId

	table.insert(fakeStepData.actEffect, actEffectData)

	local work = entity.skill:registTimelineWork(self.timelineName, fakeStepData)

	work.CALLBACK_EVEN_IF_UNFINISHED = true

	self:playWorkAndDone(work)
end

return FightWorkNuoDikaLostLifeTimeline
