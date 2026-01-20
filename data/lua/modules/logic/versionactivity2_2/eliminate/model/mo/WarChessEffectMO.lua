-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/mo/WarChessEffectMO.lua

module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessEffectMO", package.seeall)

local WarChessEffectMO = class("WarChessEffectMO")

function WarChessEffectMO:init(info)
	self.effectType = info.effectType
	self.effectNum = info.effectNum
	self.targetId = info.targetId
	self.extraData = info.extraData
	self.chessPiece = info.chessPiece

	if info.nextFightStep then
		self.nextFightStep = WarChessStepMO.New()

		self.nextFightStep:init(info.nextFightStep)
	end
end

function WarChessEffectMO:buildStep(chessStep)
	local steps = {}

	if chessStep.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
		self.reasonId = chessStep.reasonId
	end

	if self.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		local effectData = {}
		local diffValue = tonumber(self.effectNum)

		effectData.uid = self.targetId
		effectData.effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect

		if diffValue < 0 then
			effectData.vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerDown
		else
			effectData.vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerUp
		end

		effectData.time = EliminateTeamChessEnum.VxEffectTypePlayTime[effectData.vxEffectType]

		if chessStep.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
			local reasonId = chessStep.reasonId

			if reasonId ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(reasonId)) then
				effectData.time = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
			end
		end

		local step = EliminateTeamChessStepUtil.createStep(effectData)

		steps[#steps + 1] = step
	end

	if self.effectType ~= EliminateTeamChessEnum.StepWorkType.effectNestStruct then
		local step = EliminateTeamChessStepUtil.createStep(self)

		steps[#steps + 1] = step
	end

	if self.nextFightStep ~= nil then
		return steps, self.nextFightStep:buildSteps()
	end

	return steps, nil
end

return WarChessEffectMO
