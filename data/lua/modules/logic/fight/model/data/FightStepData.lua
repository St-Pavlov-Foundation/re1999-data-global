-- chunkname: @modules/logic/fight/model/data/FightStepData.lua

module("modules.logic.fight.model.data.FightStepData", package.seeall)

local FightStepData = FightDataClass("FightStepData")
local uidCounter = 1

function FightStepData:onConstructor(proto)
	self:initClientParam()

	if not proto then
		return
	end

	self.actType = proto.actType
	self.fromId = proto.fromId
	self.toId = proto.toId
	self.actId = proto.actId
	self.actEffect = self:buildActEffect(proto.actEffect)
	self.cardIndex = proto.cardIndex or 0
	self.supportHeroId = proto.supportHeroId or 0
	self.fakeTimeline = proto.fakeTimeline
	self.realSkillType = proto.realSkillType
	self.realSkinId = proto.realSkinId
end

function FightStepData:initClientParam()
	self.stepUid = uidCounter
	uidCounter = uidCounter + 1
	self.atkAudioId = nil
	self.editorPlaySkill = nil
	self.isParallelStep = false
	self.cusParam_lockTimelineTypes = nil
	self.cus_Param_invokeSpineActTimelineEnd = nil
	self.hasPlay = nil
	self.custom_stepIndex = nil
	self.custom_ingoreParallelSkill = nil
end

function FightStepData:buildActEffect(actEffectProtoList)
	local actEffectList = {}

	for i, oneActEffect in ipairs(actEffectProtoList) do
		local actEffectData = FightActEffectData.New(oneActEffect)

		table.insert(actEffectList, actEffectData)
	end

	return actEffectList
end

return FightStepData
