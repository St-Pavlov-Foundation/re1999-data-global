module("modules.logic.versionactivity1_9.fairyland.view.FairyLandDialogView", package.seeall)

slot0 = class("FairyLandDialogView", BaseView)

function slot0.onInitView(slot0)
	slot0.dialogGO = gohelper.findChild(slot0.viewGO, "dialog_overseas")
	slot0.bubble = FairyLandBubble.New()

	slot0.bubble:init(slot0)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.CloseDialogView, slot0._onCloseDialogView, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.ShowDialogView, slot0._refreshView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
end

function slot0._onCloseDialogView(slot0)
	slot0:finished()
end

function slot0._refreshView(slot0, slot1)
	if slot0.dialogId == slot1.dialogId then
		return
	end

	slot0.dialogId = slot1.dialogId
	slot0.dialogType = slot1.dialogType
	slot0.callback = slot1.callback
	slot0.callbackObj = slot1.callbackObj

	if slot0.dialogType == FairyLandEnum.DialogType.Bubble then
		gohelper.setActive(slot0.dialogGO, true)
		slot0.bubble:startDialog(slot1)
	else
		gohelper.setActive(slot0.dialogGO, false)
		ViewMgr.instance:openView(ViewName.FairyLandOptionView, slot1)
	end
end

function slot0.finished(slot0)
	if slot0.dialogId then
		if slot0.dialogId == 22 and not FairyLandModel.instance:isFinishDialog(8) then
			FairyLandRpc.instance:sendRecordDialogRequest(8)
		end

		if not FairyLandModel.instance:isFinishDialog(slot0.dialogId) then
			FairyLandRpc.instance:sendRecordDialogRequest(slot0.dialogId)
		end
	end

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end

	if slot0.bubble then
		slot0.bubble:hide()
	end

	slot0.dialogId = nil

	gohelper.setActive(slot0.dialogGO, false)
end

function slot0.onDestroyView(slot0)
	if slot0.bubble then
		slot0.bubble:dispose()
	end
end

return slot0
