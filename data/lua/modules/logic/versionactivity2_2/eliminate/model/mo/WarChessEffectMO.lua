module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessEffectMO", package.seeall)

local var_0_0 = class("WarChessEffectMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.effectType = arg_1_1.effectType
	arg_1_0.effectNum = arg_1_1.effectNum
	arg_1_0.targetId = arg_1_1.targetId
	arg_1_0.extraData = arg_1_1.extraData
	arg_1_0.chessPiece = arg_1_1.chessPiece

	if arg_1_1.nextFightStep then
		arg_1_0.nextFightStep = WarChessStepMO.New()

		arg_1_0.nextFightStep:init(arg_1_1.nextFightStep)
	end
end

function var_0_0.buildStep(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if arg_2_1.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
		arg_2_0.reasonId = arg_2_1.reasonId
	end

	if arg_2_0.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
		local var_2_1 = {}
		local var_2_2 = tonumber(arg_2_0.effectNum)

		var_2_1.uid = arg_2_0.targetId
		var_2_1.effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect

		if var_2_2 < 0 then
			var_2_1.vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerDown
		else
			var_2_1.vxEffectType = EliminateTeamChessEnum.VxEffectType.PowerUp
		end

		var_2_1.time = EliminateTeamChessEnum.VxEffectTypePlayTime[var_2_1.vxEffectType]

		if arg_2_1.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
			local var_2_3 = arg_2_1.reasonId

			if var_2_3 ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(var_2_3)) then
				var_2_1.time = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
			end
		end

		local var_2_4 = EliminateTeamChessStepUtil.createStep(var_2_1)

		var_2_0[#var_2_0 + 1] = var_2_4
	end

	if arg_2_0.effectType ~= EliminateTeamChessEnum.StepWorkType.effectNestStruct then
		local var_2_5 = EliminateTeamChessStepUtil.createStep(arg_2_0)

		var_2_0[#var_2_0 + 1] = var_2_5
	end

	if arg_2_0.nextFightStep ~= nil then
		return var_2_0, arg_2_0.nextFightStep:buildSteps()
	end

	return var_2_0, nil
end

return var_0_0
