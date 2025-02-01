module("modules.logic.seasonver.act123.controller.Season123EpisodeLoadingController", package.seeall)

slot0 = class("Season123EpisodeLoadingController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	Season123EpisodeLoadingModel.instance:init(slot1, slot2, slot3)
end

function slot0.onCloseView(slot0)
	Season123EpisodeLoadingModel.instance:release()
end

function slot0.openEpisodeDetailView(slot0)
	ViewMgr.instance:openView(Season123Controller.instance:getEpisodeMarketViewName(), {
		actId = Season123EpisodeLoadingModel.instance.activityId,
		stage = Season123EpisodeLoadingModel.instance.stage,
		layer = Season123EpisodeLoadingModel.instance.layer
	})
end

slot0.instance = slot0.New()

return slot0
