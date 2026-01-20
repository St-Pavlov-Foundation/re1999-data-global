-- chunkname: @modules/logic/fight/model/data/FightRoundData.lua

module("modules.logic.fight.model.data.FightRoundData", package.seeall)

local FightRoundData = FightDataClass("FightRoundData")

function FightRoundData:onConstructor(proto)
	if not proto then
		return
	end

	self.fightStep = self:buildFightStep(proto.fightStep)

	if proto:HasField("actPoint") then
		self.actPoint = proto.actPoint
	end

	self.isFinish = proto.isFinish

	if proto:HasField("moveNum") then
		self.moveNum = proto.moveNum
	end

	self.exPointInfo = {}

	for i, v in ipairs(proto.exPointInfo) do
		table.insert(self.exPointInfo, FightExPointInfoData.New(v))
	end

	self.aiUseCards = {}
	self.entityAiUseCards = {}

	for i, v in ipairs(proto.aiUseCards) do
		local entityId = v.uid
		local data = FightCardInfoData.New(v)

		data.clientData.custom_enemyCardIndex = i
		self.entityAiUseCards[entityId] = self.entityAiUseCards[entityId] or {}

		table.insert(self.entityAiUseCards[entityId], data)
		table.insert(self.aiUseCards, data)
	end

	self.power = proto.power
	self.skillInfos = {}

	for i, v in ipairs(proto.skillInfos) do
		table.insert(self.skillInfos, FightPlayerSkillInfoData.New(v))
	end

	self.beforeCards1 = {}

	for i, v in ipairs(proto.beforeCards1) do
		table.insert(self.beforeCards1, FightCardInfoData.New(v))
	end

	self.teamACards1 = {}

	for i, v in ipairs(proto.teamACards1) do
		table.insert(self.teamACards1, FightCardInfoData.New(v))
	end

	self.beforeCards2 = {}

	for i, v in ipairs(proto.beforeCards2) do
		table.insert(self.beforeCards2, FightCardInfoData.New(v))
	end

	self.teamACards2 = {}

	for i, v in ipairs(proto.teamACards2) do
		table.insert(self.teamACards2, FightCardInfoData.New(v))
	end

	self.nextRoundBeginStep = self:buildFightStep(proto.nextRoundBeginStep)
	self.useCardList = {}

	for i, v in ipairs(proto.useCardList) do
		table.insert(self.useCardList, v)
	end

	self.curRound = proto.curRound
	self.heroSpAttributes = {}

	for i, v in ipairs(proto.heroSpAttributes) do
		table.insert(self.heroSpAttributes, FightHeroSpAttributeInfoData.New(v))
	end

	self.lastChangeHeroUid = proto.lastChangeHeroUid
end

function FightRoundData:buildFightStep(stepProtoList)
	local stepList = {}

	for i, oneStep in ipairs(stepProtoList) do
		local fightStepData = FightStepData.New(oneStep)

		table.insert(stepList, fightStepData)
	end

	return stepList
end

function FightRoundData:processRoundData()
	self.fightStep = self:processStepList(self.fightStep)
	self.nextRoundBeginStep = self:processStepList(self.nextRoundBeginStep)
end

function FightRoundData:processStepList(stepList)
	self.stepIndex = 0
	self.stepList = {}
	self.effectSplitIndex = 0
	self.effectStepDeep = 0

	for i, v in ipairs(stepList) do
		self:addStep(v)
	end

	return self.stepList
end

function FightRoundData:addStep(step)
	self.stepIndex = self.stepIndex + 1
	step.custom_stepIndex = self.stepIndex

	table.insert(self.stepList, step)
	self:detectStepEffect(step.actEffect)
end

function FightRoundData:detectStepEffect(actEffect)
	local index = 1

	while actEffect[index] do
		local actEffectData = actEffect[index]

		self:processNuoDiKaUniqueDamage(actEffect, index, actEffectData)

		if actEffectData.effectType == FightEnum.EffectType.SPLITSTART then
			self.effectSplitIndex = self.effectSplitIndex + 1
		elseif actEffectData.effectType == FightEnum.EffectType.SPLITEND then
			self.effectSplitIndex = self.effectSplitIndex - 1
		end

		if actEffectData.effectType == FightEnum.EffectType.FIGHTSTEP then
			if self.effectSplitIndex > 0 then
				table.remove(actEffect, index)

				index = index - 1
				self.effectStepDeep = self.effectStepDeep + 1

				self:addStep(actEffectData.fightStep)

				self.effectStepDeep = self.effectStepDeep - 1
			else
				local fightStepData = actEffectData.fightStep

				if FightRoundData.needAddRoundStep(fightStepData) then
					table.remove(actEffect, index)

					index = index - 1

					self:addStep(fightStepData)
				else
					self:detectStepEffect(fightStepData.actEffect)
				end
			end
		elseif self.effectSplitIndex > 0 and self.effectStepDeep == 0 then
			table.remove(actEffect, index)

			index = index - 1

			local stepData = FightStepData.New()

			stepData.actType = FightEnum.ActType.EFFECT
			stepData.fromId = "0"
			stepData.toId = "0"
			stepData.actId = 0
			stepData.actEffect = {
				actEffectData
			}
			stepData.cardIndex = 0
			stepData.supportHeroId = 0
			stepData.fakeTimeline = false

			table.insert(self.stepList, stepData)
		end

		index = index + 1
	end
end

function FightRoundData:getEnemyActPoint()
	return #self.aiUseCards
end

function FightRoundData:getAIUseCardMOList()
	return self.aiUseCards
end

function FightRoundData:getEntityAIUseCardMOList(entityId)
	return self.entityAiUseCards[entityId] or {}
end

function FightRoundData.needAddRoundStep(fightStep)
	if FightHelper.isTimelineStep(fightStep) then
		return true
	end

	if fightStep.actType == FightEnum.ActType.CHANGEHERO then
		return true
	elseif fightStep.actType == FightEnum.ActType.CHANGEWAVE then
		return true
	end

	if fightStep.fakeTimeline then
		return true
	end
end

function FightRoundData:processNuoDiKaUniqueDamage(actEffect, index, actEffectData)
	if (actEffectData.effectType == FightEnum.EffectType.NUODIKARANDOMATTACK or actEffectData.effectType == FightEnum.EffectType.NUODIKATEAMATTACK) and not actEffectData.custom_nuoDiKaDamageSign then
		local configEffect = actEffectData.configEffect

		for i = #actEffect, index, -1 do
			local tempEffectData = actEffect[i]

			if tempEffectData.effectType == FightEnum.EffectType.DAMAGE and tempEffectData.configEffect == configEffect then
				tempEffectData.custom_nuoDiKaDamageSign = true
			end

			if tempEffectData.effectType == FightEnum.EffectType.SHIELD and tempEffectData.configEffect == configEffect then
				tempEffectData.custom_nuoDiKaDamageSign = true
			end
		end
	end
end

return FightRoundData
