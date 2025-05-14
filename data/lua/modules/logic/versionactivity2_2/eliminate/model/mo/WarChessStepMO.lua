module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStepMO", package.seeall)

local var_0_0 = class("WarChessStepMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actionType = arg_1_1.actionType
	arg_1_0.reasonId = arg_1_1.reasonId
	arg_1_0.fromId = arg_1_1.fromId
	arg_1_0.toId = arg_1_1.toId

	if arg_1_1.effect then
		arg_1_0.effect = GameUtil.rpcInfosToList(arg_1_1.effect, WarChessEffectMO)
	end
end

local var_0_1 = {}

function var_0_0.buildSteps(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = FlowParallel.New()
	local var_2_2 = FlowParallel.New()

	if arg_2_0.actionType == EliminateTeamChessEnum.StepActionType.chessSkill then
		local var_2_3 = EliminateConfig.instance:getSoliderSkillConfig(arg_2_0.reasonId)

		if not string.nilorempty(var_2_3.type) then
			tabletool.clear(var_0_1)

			var_0_1.uid = arg_2_0.fromId
			var_0_1.effectType = EliminateTeamChessEnum.StepWorkType.teamChessShowVxEffect

			if var_2_3.type == EliminateTeamChessEnum.SoliderSkillType.Die then
				var_0_1.vxEffectType = EliminateTeamChessEnum.VxEffectType.WangYu
				var_0_1.time = EliminateTeamChessEnum.VxEffectTypePlayTime[var_0_1.vxEffectType]
			end

			if var_2_3.type == EliminateTeamChessEnum.SoliderSkillType.Raw or var_2_3.type == EliminateTeamChessEnum.SoliderSkillType.GrowUp then
				var_0_1.vxEffectType = EliminateTeamChessEnum.VxEffectType.ZhanHou
				var_0_1.time = EliminateTeamChessEnum.VxEffectTypePlayTime[var_0_1.vxEffectType]
			end

			local var_2_4 = arg_2_0.reasonId

			if var_2_4 ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(var_2_4)) then
				var_0_1.time = EliminateTeamChessEnum.teamChessGrowUpZhanHouStepTime
			end

			local var_2_5 = EliminateTeamChessStepUtil.createStep(var_0_1)

			var_2_0[#var_2_0 + 1] = var_2_5
		end
	end

	local var_2_6 = true

	for iter_2_0 = 1, #arg_2_0.effect do
		local var_2_7 = arg_2_0.effect[iter_2_0]

		if var_2_7.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			if arg_2_0.actionType == EliminateTeamChessEnum.StepActionType.chessSkill or arg_2_0.actionType == EliminateTeamChessEnum.StepActionType.strongHoldSkill then
				var_2_7.needShowDamage = true
			else
				var_2_7.needShowDamage = false
			end
		end

		if var_2_7.effectType == EliminateTeamChessEnum.StepWorkType.placeChess then
			local var_2_8 = var_2_7.chessPiece

			if tonumber(var_2_8.uid) < 0 and var_2_6 then
				local var_2_9 = EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessUpdateForecast)

				var_2_0[#var_2_0 + 1] = var_2_9
				var_2_6 = false
			end
		end

		local var_2_10, var_2_11 = var_2_7:buildStep(arg_2_0)

		if var_2_7.effectType == EliminateTeamChessEnum.StepWorkType.chessPowerChange then
			for iter_2_1, iter_2_2 in ipairs(var_2_10) do
				var_2_1:addWork(iter_2_2)
			end

			if #var_2_10 == #var_2_1:getWorkList() then
				var_2_0[#var_2_0 + 1] = var_2_1
			end
		elseif var_2_7.effectType == EliminateTeamChessEnum.StepWorkType.chessGrowUpChange then
			for iter_2_3, iter_2_4 in ipairs(var_2_10) do
				var_2_2:addWork(iter_2_4)
			end

			if #var_2_10 == #var_2_2:getWorkList() then
				var_2_0[#var_2_0 + 1] = var_2_2
			end
		else
			for iter_2_5, iter_2_6 in ipairs(var_2_10) do
				var_2_0[#var_2_0 + 1] = iter_2_6
			end
		end

		if var_2_11 then
			for iter_2_7, iter_2_8 in ipairs(var_2_11) do
				var_2_0[#var_2_0 + 1] = iter_2_8
			end
		end
	end

	return var_2_0
end

return var_0_0
