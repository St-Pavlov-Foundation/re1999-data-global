module("modules.logic.seasonver.act123.controller.Season123ShowHeroController", package.seeall)

slot0 = class("Season123ShowHeroController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3)
	Season123ShowHeroModel.instance:init(slot1, slot2, slot3)
end

function slot0.onCloseView(slot0)
	Season123ShowHeroModel.instance:release()
end

function slot0.openReset(slot0)
	Season123Controller.instance:openResetView({
		actId = Season123ShowHeroModel.instance.activityId,
		stage = Season123ShowHeroModel.instance.stage
	})
end

function slot0.notifyView(slot0)
end

slot0.instance = slot0.New()

return slot0
