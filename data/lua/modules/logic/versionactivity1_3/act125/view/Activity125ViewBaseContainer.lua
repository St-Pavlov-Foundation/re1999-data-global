module("modules.logic.versionactivity1_3.act125.view.Activity125ViewBaseContainer", package.seeall)

local var_0_0 = class("Activity125ViewBaseContainer", BaseViewContainer)
local var_0_1 = "Activity125|"

function var_0_0.getPrefsKeyPrefix(arg_1_0)
	return var_0_1 .. tostring(arg_1_0:actId())
end

function var_0_0.saveInt(arg_2_0, arg_2_1, arg_2_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_2_1, arg_2_2)
end

function var_0_0.getInt(arg_3_0, arg_3_1, arg_3_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_3_1, arg_3_2)
end

function var_0_0.getActivityRemainTimeStr(arg_4_0)
	return ActivityHelper.getActivityRemainTimeStr(arg_4_0:actId())
end

function var_0_0.getEpisodeCount(arg_5_0)
	return Activity125Config.instance:getEpisodeCount(arg_5_0:actId())
end

function var_0_0.hasEpisodeCanCheck(arg_6_0)
	return Activity125Model.instance:hasEpisodeCanCheck(arg_6_0:actId())
end

function var_0_0.getH5BaseUrl(arg_7_0)
	return Activity125Config.instance:getH5BaseUrl(arg_7_0:actId())
end

function var_0_0.setCurSelectEpisodeIdSlient(arg_8_0, arg_8_1)
	if arg_8_0:getCurSelectedEpisode() == arg_8_1 then
		return
	end

	arg_8_0:setSelectEpisodeId(arg_8_1)

	if arg_8_1 then
		arg_8_0:setOldEpisode(arg_8_1)
	end
end

function var_0_0.sendFinishAct125EpisodeRequest(arg_9_0)
	local var_9_0 = arg_9_0:getEpisodeConfigCur()
	local var_9_1 = var_9_0.id

	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_9_0:actId(), var_9_1, var_9_0.targetFrequency)
end

function var_0_0.getCurSelectedEpisode(arg_10_0)
	return Activity125Model.instance:getSelectEpisodeId(arg_10_0:actId())
end

function var_0_0.getEpisodeConfig(arg_11_0, arg_11_1)
	return Activity125Config.instance:getEpisodeConfig(arg_11_0:actId(), arg_11_1)
end

function var_0_0.setSelectEpisodeId(arg_12_0, arg_12_1)
	return Activity125Model.instance:setSelectEpisodeId(arg_12_0:actId(), arg_12_1)
end

function var_0_0.isEpisodeFinished(arg_13_0, arg_13_1)
	return Activity125Model.instance:isEpisodeFinished(arg_13_0:actId(), arg_13_1)
end

function var_0_0.checkIsOldEpisode(arg_14_0, arg_14_1)
	return Activity125Model.instance:checkIsOldEpisode(arg_14_0:actId(), arg_14_1)
end

function var_0_0.isFirstCheckEpisode(arg_15_0, arg_15_1)
	return Activity125Model.instance:isFirstCheckEpisode(arg_15_0:actId(), arg_15_1)
end

function var_0_0.isEpisodeDayOpen(arg_16_0, arg_16_1)
	return Activity125Model.instance:isEpisodeDayOpen(arg_16_0:actId(), arg_16_1)
end

function var_0_0.isEpisodeUnLock(arg_17_0, arg_17_1)
	return Activity125Model.instance:isEpisodeUnLock(arg_17_0:actId(), arg_17_1)
end

function var_0_0.setLocalIsPlay(arg_18_0, arg_18_1)
	return Activity125Model.instance:setLocalIsPlay(arg_18_0:actId(), arg_18_1)
end

function var_0_0.checkLocalIsPlay(arg_19_0, arg_19_1)
	return Activity125Model.instance:checkLocalIsPlay(arg_19_0:actId(), arg_19_1)
end

function var_0_0.isEpisodeReallyOpen(arg_20_0, arg_20_1)
	return Activity125Model.instance:isEpisodeReallyOpen(arg_20_0:actId(), arg_20_1)
end

function var_0_0.setOldEpisode(arg_21_0, arg_21_1)
	return Activity125Model.instance:setOldEpisode(arg_21_0:actId(), arg_21_1)
end

function var_0_0.getFirstRewardEpisode(arg_22_0)
	return Activity125Model.instance:getById(arg_22_0:actId()):getFirstRewardEpisode()
end

function var_0_0.getRLOC(arg_23_0, arg_23_1)
	return Activity125Model.instance:getById(arg_23_0:actId()):getRLOC(arg_23_1)
end

function var_0_0.getEpisodeConfigCur(arg_24_0)
	return arg_24_0:getEpisodeConfig(arg_24_0:getCurSelectedEpisode())
end

function var_0_0.isEpisodeFinishedCur(arg_25_0)
	return arg_25_0:isEpisodeFinished(arg_25_0:getCurSelectedEpisode())
end

function var_0_0.checkIsOldEpisodeCur(arg_26_0)
	return arg_26_0:checkIsOldEpisode(arg_26_0:getCurSelectedEpisode())
end

function var_0_0.isFirstCheckEpisodeCur(arg_27_0)
	return arg_27_0:isFirstCheckEpisode(arg_27_0:getCurSelectedEpisode())
end

function var_0_0.isEpisodeDayOpenCur(arg_28_0)
	return arg_28_0:isEpisodeDayOpen(arg_28_0:getCurSelectedEpisode())
end

function var_0_0.isEpisodeUnLockCur(arg_29_0)
	return arg_29_0:isEpisodeUnLock(arg_29_0:getCurSelectedEpisode())
end

function var_0_0.setLocalIsPlayCur(arg_30_0)
	return arg_30_0:setLocalIsPlay(arg_30_0:getCurSelectedEpisode())
end

function var_0_0.checkLocalIsPlayCur(arg_31_0)
	return arg_31_0:checkLocalIsPlay(arg_31_0:getCurSelectedEpisode())
end

function var_0_0.getLocalIsPlayCur(arg_32_0)
	return arg_32_0:checkLocalIsPlayCur()
end

function var_0_0.isEpisodeReallyOpenCur(arg_33_0)
	return arg_33_0:isEpisodeReallyOpen(arg_33_0:getCurSelectedEpisode())
end

function var_0_0.getRLOCCur(arg_34_0)
	return arg_34_0:getRLOC(arg_34_0:getCurSelectedEpisode())
end

function var_0_0.setOldEpisodeCur(arg_35_0)
	return arg_35_0:setOldEpisode(arg_35_0:getCurSelectedEpisode())
end

function var_0_0.sendGetTaskInfoRequest(arg_36_0, arg_36_1, arg_36_2)
	Activity125Controller.instance:sendGetTaskInfoRequest(arg_36_1, arg_36_2)
end

function var_0_0.sendFinishAllTaskRequest(arg_37_0, arg_37_1, arg_37_2)
	Activity125Controller.instance:sendFinishAllTaskRequest(arg_37_0:actId(), arg_37_1, arg_37_2)
end

function var_0_0.sendFinishTaskRequest(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	TaskRpc.instance:sendFinishTaskRequest(arg_38_1, arg_38_2, arg_38_3)
end

function var_0_0.getTaskCO_sum_help_npc(arg_39_0, arg_39_1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(arg_39_0:actId(), ActivityWarmUpEnum.Activity125TaskTag.sum_help_npc, arg_39_1)
end

function var_0_0.getTaskCO_help_npc(arg_40_0, arg_40_1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(arg_40_0:actId(), ActivityWarmUpEnum.Activity125TaskTag.help_npc, arg_40_1)
end

function var_0_0.getTaskCO_perfect_win(arg_41_0, arg_41_1)
	return Activity125Config.instance:getTaskCO_ReadTask_Tag_TaskId(arg_41_0:actId(), ActivityWarmUpEnum.Activity125TaskTag.perfect_win, arg_41_1)
end

function var_0_0.isTimeToActiveH5Btn(arg_42_0)
	local var_42_0 = CommonConfig.instance:getConstStr(ConstEnum.V2a4_WarmUp_btnplay_openTs)

	if string.nilorempty(var_42_0) then
		return true
	end

	local var_42_1 = SettingsModel.instance:extractByRegion(var_42_0)

	return ServerTime.now() >= TimeUtil.stringToTimestamp(var_42_1)
end

function var_0_0.actId(arg_43_0)
	assert(false, "please override this function")
end

return var_0_0
