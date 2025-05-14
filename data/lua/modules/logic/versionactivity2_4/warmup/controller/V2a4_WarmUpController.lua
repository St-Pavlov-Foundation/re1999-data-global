module("modules.logic.versionactivity2_4.warmup.controller.V2a4_WarmUpController", package.seeall)

local var_0_0 = class("V2a4_WarmUpController", BaseController)
local var_0_1 = table.insert

function var_0_0.onInit(arg_1_0)
	arg_1_0._battle = V2a4_WarmUpBattleModel.instance
	arg_1_0._gacha = V2a4_WarmUpGachaModel.instance

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._gacha:clean()
end

function var_0_0.config(arg_3_0)
	return V2a4_WarmUpConfig.instance
end

function var_0_0.actId(arg_4_0)
	return arg_4_0:config():actId()
end

function var_0_0.addConstEvents(arg_5_0)
	return
end

function var_0_0.isTimeout(arg_6_0)
	return arg_6_0._battle:isTimeout()
end

function var_0_0.restart(arg_7_0, arg_7_1)
	arg_7_0._gacha:restart(arg_7_1)
	arg_7_0._battle:restart(arg_7_1)
	arg_7_0:waveStart(arg_7_1)
end

function var_0_0.abort(arg_8_0)
	local var_8_0 = arg_8_0._battle:getResultInfo()
	local var_8_1 = var_8_0.isWin
	local var_8_2 = {
		V2a4_WarmUpConfig.instance:getDurationSec(),
		var_8_0.totWaveCnt,
		var_8_0.totAnsYesCnt,
		var_8_0.totAnsNoCnt,
		var_8_0.sucHelpCnt
	}
	local var_8_3 = V2a4_WarmUpConfig.instance:getConstStr(var_8_1 and 4 or 3)
	local var_8_4 = GameUtil.getSubPlaceholderLuaLang(var_8_3, var_8_2)
	local var_8_5 = {
		isSucc = var_8_1,
		desc = var_8_4,
		closeCb = arg_8_0._onCloseV2a4_WarmUp_ResultView,
		closeCbObj = arg_8_0
	}

	ViewMgr.instance:openView(ViewName.V2a4_WarmUp_ResultView, var_8_5)

	if var_8_1 then
		arg_8_0:_sendFinishAct125EpisodeRequest()
	end
end

function var_0_0._onCloseV2a4_WarmUp_ResultView(arg_9_0)
	local var_9_0 = ViewName.V2a4_WarmUp_DialogueView

	if ViewMgr.instance:isOpen(var_9_0) then
		ViewMgr.instance:closeView(var_9_0, nil, true)
	end
end

function var_0_0.waveStart(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:genWave(arg_10_1)

	arg_10_0:dispatchEvent(V2a4_WarmUpEvent.onWaveStart, var_10_0)
end

function var_0_0.postWaveStart(arg_11_0, arg_11_1)
	if arg_11_1:nextRound() then
		local var_11_0 = arg_11_1:curRound()

		arg_11_0:roundStart(arg_11_1, var_11_0)
	else
		arg_11_0:waveEnd(arg_11_1)
	end
end

function var_0_0.roundStart(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:dispatchEvent(V2a4_WarmUpEvent.onRoundStart, arg_12_1, arg_12_2)
end

function var_0_0.postRoundStart(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0:isTimeout() then
		arg_13_0:roundEnd(arg_13_1, arg_13_2)

		return
	end

	arg_13_0:moveStep(arg_13_1, arg_13_2)
end

function var_0_0.moveStep(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1 = arg_14_2:moveStep()

	if var_14_0 and not arg_14_0:isTimeout() then
		arg_14_0:dispatchEvent(V2a4_WarmUpEvent.onMoveStep, arg_14_1, arg_14_2, var_14_1)
	else
		arg_14_0:roundEnd(arg_14_1, arg_14_2)
	end
end

function var_0_0.stepEnd(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:moveStep(arg_15_1, arg_15_2)
end

function var_0_0.roundEnd(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0:isTimeout() then
		arg_16_0:abort()

		return
	end

	if arg_16_2:isWin() and arg_16_1:nextRound() then
		arg_16_0:roundStart(arg_16_1, arg_16_1:curRound())

		return
	end

	arg_16_0:waveEnd(arg_16_1)
end

function var_0_0.waveEnd(arg_17_0, arg_17_1)
	arg_17_0:dispatchEvent(V2a4_WarmUpEvent.onWaveEnd, arg_17_1)
end

function var_0_0.genWave(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._gacha:genWave(arg_18_1)

	return (arg_18_0._battle:genWave(var_18_0))
end

function var_0_0.timeout(arg_19_0)
	arg_19_0:abort()
end

function var_0_0.commitAnswer(arg_20_0, arg_20_1)
	if arg_20_0:isTimeout() then
		return
	end

	local var_20_0 = arg_20_0._battle:curWave()
	local var_20_1 = var_20_0:curRound()

	if not var_20_1 then
		return
	end

	var_20_1:answer(arg_20_1)
	arg_20_0:moveStep(var_20_0, var_20_1)
end

function var_0_0.log(arg_21_0)
	local var_21_0 = {}

	arg_21_0._battle:dump(var_21_0)
	logError(table.concat(var_21_0, "\n"))
end

function var_0_0.uploadToServer(arg_22_0)
	local var_22_0 = Activity125Controller.instance:get_V2a4_WarmUp_sum_help_npc(0)
	local var_22_1 = arg_22_0._battle:getResultInfo()
	local var_22_2 = var_22_1.sucHelpCnt
	local var_22_3 = var_22_1.isPerfectWin and 1 or 0

	if var_22_2 > 0 then
		var_22_0 = var_22_0 + var_22_2

		Activity125Controller.instance:set_V2a4_WarmUp_sum_help_npc(var_22_0)
	end

	local var_22_4 = {}
	local var_22_5 = ActivityWarmUpEnum.Activity125TaskTag

	arg_22_0:_checkSingleClientlistenerParam(var_22_4, var_22_5.sum_help_npc, var_22_0)
	arg_22_0:_checkSingleClientlistenerParam(var_22_4, var_22_5.perfect_win, var_22_3)
	arg_22_0:_checkSingleClientlistenerParam(var_22_4, var_22_5.help_npc, var_22_2)
	arg_22_0:sendFinishReadTaskRequest(var_22_4)
end

function var_0_0._checkSingleClientlistenerParam(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = TaskEnum.TaskType.Activity125
	local var_23_1 = Activity125Config.instance:getTaskCO_ReadTask_Tag(arg_23_0:actId(), arg_23_2)

	for iter_23_0, iter_23_1 in pairs(var_23_1 or {}) do
		local var_23_2 = iter_23_1.clientlistenerParam
		local var_23_3 = tonumber(var_23_2) or arg_23_3 + 1

		arg_23_0:appendCompleteTask(arg_23_1, var_23_0, iter_23_0, arg_23_3, var_23_3)
	end
end

function var_0_0.appendCompleteTask(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if not TaskModel.instance:isTaskUnlock(arg_24_2, arg_24_3) then
		return
	end

	if TaskModel.instance:taskHasFinished(arg_24_2, arg_24_3) then
		return
	end

	if arg_24_4 < arg_24_5 then
		return
	end

	var_0_1(arg_24_1, arg_24_3)
end

function var_0_0._sendFinishAct125EpisodeRequest(arg_25_0)
	local var_25_0 = arg_25_0._battle:levelId()

	if Activity125Model.instance:isEpisodeFinished(arg_25_0:actId(), var_25_0) then
		return
	end

	local var_25_1 = Activity125Config.instance:getEpisodeConfig(arg_25_0:actId(), var_25_0)

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_25_0:actId(), var_25_0, var_25_1.targetFrequency)
end

function var_0_0.sendFinishReadTaskRequest(arg_26_0, arg_26_1)
	if not arg_26_1 or #arg_26_1 == 0 then
		return
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		TaskRpc.instance:sendFinishReadTaskRequest(iter_26_1)
	end

	arg_26_0:dispatchEventUpdateActTag()
end

local var_0_2 = "V2a4_WarmUpController|"

function var_0_0.getPrefsKeyPrefix(arg_27_0)
	return var_0_2 .. tostring(arg_27_0:actId())
end

function var_0_0.saveInt(arg_28_0, arg_28_1, arg_28_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_28_1, arg_28_2)
end

function var_0_0.getInt(arg_29_0, arg_29_1, arg_29_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_29_1, arg_29_2)
end

local var_0_3 = "Preface"

function var_0_0.setIsShownPreface(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getPrefsKeyPrefix() .. var_0_3

	arg_30_0:saveInt(var_30_0, arg_30_1 and 1 or 0)
end

function var_0_0.getIsShownPreface(arg_31_0)
	local var_31_0 = arg_31_0:getPrefsKeyPrefix() .. var_0_3

	return arg_31_0:getInt(var_31_0, 0) ~= 0
end

function var_0_0.dispatchEventUpdateActTag(arg_32_0)
	local var_32_0 = ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)
	local var_32_1 = RedDotConfig.instance:getParentRedDotId(var_32_0)
	local var_32_2 = ActivityConfig.instance:getActivityRedDotId(arg_32_0:actId())

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(var_32_1)] = true,
		[tonumber(var_32_2)] = true,
		[RedDotEnum.DotNode.Activity125Task] = true
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
