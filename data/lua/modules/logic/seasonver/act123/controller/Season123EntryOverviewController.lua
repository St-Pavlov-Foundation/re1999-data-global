module("modules.logic.seasonver.act123.controller.Season123EntryOverviewController", package.seeall)

slot0 = class("Season123EntryOverviewController", BaseController)

function slot0.onOpenView(slot0, slot1)
	Season123EntryOverviewModel.instance:init(slot1)
end

function slot0.onCloseView(slot0)
end

slot0.instance = slot0.New()

return slot0
