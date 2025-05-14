module("modules.logic.seasonver.act123.controller.Season123EpisodeLoadingController", package.seeall)

local var_0_0 = class("Season123EpisodeLoadingController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	Season123EpisodeLoadingModel.instance:init(arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onCloseView(arg_2_0)
	Season123EpisodeLoadingModel.instance:release()
end

function var_0_0.openEpisodeDetailView(arg_3_0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
		actId = Season123EpisodeLoadingModel.instance.activityId,
		stage = Season123EpisodeLoadingModel.instance.stage,
		layer = Season123EpisodeLoadingModel.instance.layer
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
