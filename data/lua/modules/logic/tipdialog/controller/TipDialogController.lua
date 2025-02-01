module("modules.logic.tipdialog.controller.TipDialogController", package.seeall)

slot0 = class("TipDialogController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openTipDialogView(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	ViewMgr.instance:openView(ViewName.TipDialogView, {
		dialogId = slot1,
		callback = slot2,
		callbackTarget = slot3,
		auto = slot4,
		autoplayTime = slot5,
		widthPercentage = slot6
	})
end

slot0.instance = slot0.New()

return slot0
