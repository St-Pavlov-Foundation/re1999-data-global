module("modules.logic.versionactivity2_8.nuodika.controller.NuoDiKaController", package.seeall)

local var_0_0 = class("NuoDiKaController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.enterLevelView(arg_4_0, arg_4_1)
	arg_4_0._levelData = arg_4_1

	Activity180Rpc.instance:sendGet180InfosRequest(VersionActivity2_8Enum.ActivityId.NuoDiKa, arg_4_0._onRecInfo, arg_4_0)
end

function var_0_0._onRecInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 == 0 and arg_5_3.activityId == VersionActivity2_8Enum.ActivityId.NuoDiKa then
		NuoDiKaModel.instance:initInfos(arg_5_3.act180EpisodeNO)
		ViewMgr.instance:openView(ViewName.NuoDiKaLevelView, arg_5_0._levelData)
	end
end

function var_0_0.enterEpisode(arg_6_0, arg_6_1)
	arg_6_0:dispatchEvent(NuoDiKaEvent.JumpToEpisode, arg_6_1.episodeId)
end

function var_0_0.enterGameView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameView, arg_7_1)
end

function var_0_0.enterInfosView(arg_8_0)
	ViewMgr.instance:openView(ViewName.NuoDiKaInfosView)
end

function var_0_0.enterEnemyDetailView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameUnitDetailView, arg_9_1)
end

function var_0_0.enterGameResultView(arg_10_0, arg_10_1)
	ViewMgr.instance:openView(ViewName.NuoDiKaGameResultView, arg_10_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
