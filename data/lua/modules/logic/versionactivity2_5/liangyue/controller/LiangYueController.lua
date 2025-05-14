module("modules.logic.versionactivity2_5.liangyue.controller.LiangYueController", package.seeall)

local var_0_0 = class("LiangYueController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.openGameView(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = LiangYueConfig.instance:getEpisodeConfigByActAndId(arg_5_1, arg_5_2)
	local var_5_1 = {
		actId = arg_5_1,
		episodeId = arg_5_2,
		episodeGameId = var_5_0.puzzleId
	}

	LiangYueModel.instance:setCurActId(arg_5_1)
	LiangYueModel.instance:setCurEpisodeId(arg_5_2)
	ViewMgr.instance:openView(ViewName.LiangYueGameView, var_5_1)
end

function var_0_0.enterLevelView(arg_6_0, arg_6_1)
	LiangYueRpc.instance:sendGetAct184InfoRequest(arg_6_1, arg_6_0._onReceiveInfo, arg_6_0)
end

function var_0_0._onReceiveInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == 0 then
		ViewMgr.instance:openView(ViewName.LiangYueLevelView)
	end
end

function var_0_0.finishEpisode(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	LiangYueRpc.instance:sendAct184FinishEpisodeRequest(arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.statExitData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = ServerTime.now() - arg_9_1

	StatController.instance:track(StatEnum.EventName.ExitLiangYueActivity, {
		[StatEnum.EventProperties.LiangYue_UseTime] = var_9_0,
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_9_2),
		[StatEnum.EventProperties.Result] = arg_9_3,
		[StatEnum.EventProperties.LiangYue_Illustration_Result] = arg_9_4
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
