module("modules.logic.gift.controller.GiftController", package.seeall)

slot0 = class("GiftController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openGiftMultipleChoiceView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.GiftMultipleChoiceView, slot1, slot2)
end

function slot0.openOptionalGiftMultipleChoiceView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.OptionalGiftMultipleChoiceView, slot1, slot2)
end

function slot0.openGiftInsightHeroChoiceView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.GiftInsightHeroChoiceView, slot1)
end

slot0.instance = slot0.New()

return slot0
