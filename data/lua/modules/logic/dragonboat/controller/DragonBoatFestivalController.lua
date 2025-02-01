module("modules.logic.dragonboat.controller.DragonBoatFestivalController", package.seeall)

slot0 = class("DragonBoatFestivalController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0._checkActivityInfo(slot0)
end

function slot0.openQuestionTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalQuestionTipView, slot1)
end

function slot0.openDragonBoatFestivalView(slot0)
	ViewMgr.instance:openView(ViewName.DragonBoatFestivalView)
end

slot0.instance = slot0.New()

return slot0
