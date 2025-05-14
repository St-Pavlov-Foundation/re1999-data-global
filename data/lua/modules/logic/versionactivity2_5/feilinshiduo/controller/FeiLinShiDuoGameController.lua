module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoGameController", package.seeall)

local var_0_0 = class("FeiLinShiDuoGameController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openTaskView(arg_3_0, arg_3_1)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoTaskView, arg_3_1)
end

function var_0_0.openGameView(arg_4_0, arg_4_1)
	FeiLinShiDuoGameModel.instance:setCurMapId(arg_4_1.mapId)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoGameView, arg_4_1)
end

function var_0_0.enterEpisodeLevelView(arg_5_0, arg_5_1)
	Activity185Rpc.instance:sendGetAct185InfoRequest(arg_5_1, arg_5_0._onReceiveInfo, arg_5_0)
end

function var_0_0._onReceiveInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == 0 then
		local var_6_0 = arg_6_3.activityId
		local var_6_1 = ActivityModel.instance:getActMO(var_6_0)
		local var_6_2 = var_6_1 and var_6_1.config and var_6_1.config.storyId

		if var_6_2 and not StoryModel.instance:isStoryFinished(var_6_2) then
			local var_6_3 = {}

			var_6_3.mark = true

			StoryController.instance:playStory(var_6_2, var_6_3, arg_6_0.openEpisodeLevelView, arg_6_0)
		else
			ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
		end
	end
end

function var_0_0.openEpisodeLevelView(arg_7_0)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoEpisodeLevelView)
end

function var_0_0.finishEpisode(arg_8_0, arg_8_1, arg_8_2)
	Activity185Rpc.instance:sendAct185FinishEpisodeRequest(arg_8_1, arg_8_2)
end

function var_0_0.openGameResultView(arg_9_0, arg_9_1)
	ViewMgr.instance:openView(ViewName.FeiLinShiDuoResultView, arg_9_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
