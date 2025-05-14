module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundXFail", package.seeall)

local var_0_0 = class("WaitGuideActionFightRoundXFail", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._waveRoundDict = nil

	if #var_1_0 > 2 then
		for iter_1_0 = 1, #var_1_0, 2 do
			if var_1_0[iter_1_0 + 1] then
				local var_1_1 = var_1_0[iter_1_0] .. "#" .. var_1_0[iter_1_0 + 1]

				arg_1_0._waveRoundDict = arg_1_0._waveRoundDict or {}
				arg_1_0._waveRoundDict[var_1_1] = true
			else
				logError(string.format("guide_%d_%d 等待战斗第m波次第n回合失败 配置错误 参数数量应为1或者偶数", arg_1_0.guideId, arg_1_0.stepId))
			end
		end
	elseif #var_1_0 == 2 then
		local var_1_2 = var_1_0[1] .. "#" .. var_1_0[2]

		arg_1_0._waveRoundDict = arg_1_0._waveRoundDict or {}
		arg_1_0._waveRoundDict[var_1_2] = true
	elseif #var_1_0 == 1 then
		local var_1_3 = 1 .. "#" .. var_1_0[1]

		arg_1_0._waveRoundDict = arg_1_0._waveRoundDict or {}
		arg_1_0._waveRoundDict[var_1_3] = true
	end

	arg_1_0._roundIdInWave = 0

	FightController.instance:registerCallback(FightEvent.OnBeginWave, arg_1_0._onBeginWave, arg_1_0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, arg_1_0._onBeginRound, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
end

function var_0_0._onBeginWave(arg_2_0)
	arg_2_0._roundIdInWave = 0
end

function var_0_0._onBeginRound(arg_3_0)
	arg_3_0._roundIdInWave = arg_3_0._roundIdInWave + 1
end

function var_0_0._onStageChange(arg_4_0)
	if FightModel.instance:getCurStage() == FightEnum.Stage.EndRound then
		local var_4_0 = FightModel.instance:getRecordMO()

		if var_4_0 and var_4_0.fightResult == FightEnum.FightResult.Fail then
			local var_4_1 = FightModel.instance:getCurWaveId() .. "#" .. arg_4_0._roundIdInWave

			if not arg_4_0._waveRoundDict or arg_4_0._waveRoundDict[var_4_1] then
				arg_4_0:onDone(true)
			end
		end
	end
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnBeginWave, arg_5_0._onBeginWave, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.RespBeginRound, arg_5_0._onBeginRound, arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_5_0._onStageChange, arg_5_0)
end

return var_0_0
