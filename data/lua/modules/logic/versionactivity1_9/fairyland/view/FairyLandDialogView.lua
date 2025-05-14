module("modules.logic.versionactivity1_9.fairyland.view.FairyLandDialogView", package.seeall)

local var_0_0 = class("FairyLandDialogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.dialogGO = gohelper.findChild(arg_1_0.viewGO, "dialog_overseas")
	arg_1_0.bubble = FairyLandBubble.New()

	arg_1_0.bubble:init(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.CloseDialogView, arg_2_0._onCloseDialogView, arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.ShowDialogView, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0._onCloseDialogView(arg_5_0)
	arg_5_0:finished()
end

function var_0_0._refreshView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.dialogId

	if arg_6_0.dialogId == var_6_0 then
		return
	end

	arg_6_0.dialogId = arg_6_1.dialogId
	arg_6_0.dialogType = arg_6_1.dialogType
	arg_6_0.callback = arg_6_1.callback
	arg_6_0.callbackObj = arg_6_1.callbackObj

	if arg_6_0.dialogType == FairyLandEnum.DialogType.Bubble then
		gohelper.setActive(arg_6_0.dialogGO, true)
		arg_6_0.bubble:startDialog(arg_6_1)
	else
		gohelper.setActive(arg_6_0.dialogGO, false)
		ViewMgr.instance:openView(ViewName.FairyLandOptionView, arg_6_1)
	end
end

function var_0_0.finished(arg_7_0)
	if arg_7_0.dialogId then
		if arg_7_0.dialogId == 22 and not FairyLandModel.instance:isFinishDialog(8) then
			FairyLandRpc.instance:sendRecordDialogRequest(8)
		end

		if not FairyLandModel.instance:isFinishDialog(arg_7_0.dialogId) then
			FairyLandRpc.instance:sendRecordDialogRequest(arg_7_0.dialogId)
		end
	end

	if arg_7_0.callback then
		arg_7_0.callback(arg_7_0.callbackObj)
	end

	if arg_7_0.bubble then
		arg_7_0.bubble:hide()
	end

	arg_7_0.dialogId = nil

	gohelper.setActive(arg_7_0.dialogGO, false)
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0.bubble then
		arg_8_0.bubble:dispose()
	end
end

return var_0_0
