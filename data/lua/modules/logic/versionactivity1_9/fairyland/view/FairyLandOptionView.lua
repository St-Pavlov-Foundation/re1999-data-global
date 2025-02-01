module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionView", package.seeall)

slot0 = class("FairyLandOptionView", BaseView)

function slot0.onInitView(slot0)
	slot0.dialogGO = gohelper.findChild(slot0.viewGO, "dialog")
	slot0.option = FairyLandOption.New()

	slot0.option:init(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshView(slot0.viewParam)
end

function slot0._refreshView(slot0, slot1)
	if slot0.dialogId then
		slot0:finished()
	end

	slot0.dialogId = slot1.dialogId
	slot0.dialogType = slot1.dialogType
	slot0.callback = slot1.callback
	slot0.callbackObj = slot1.callbackObj

	slot0.option:startDialog(slot1)
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

	if slot0.option then
		slot0.option:hide()
	end

	slot0.dialogId = nil

	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	if slot0.option then
		slot0.option:dispose()
	end
end

return slot0
