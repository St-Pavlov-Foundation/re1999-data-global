module("modules.logic.versionactivity1_9.fairyland.view.FairyLandOptionView", package.seeall)

local var_0_0 = class("FairyLandOptionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.dialogGO = gohelper.findChild(arg_1_0.viewGO, "dialog")
	arg_1_0.option = FairyLandOption.New()

	arg_1_0.option:init(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshView(arg_4_0.viewParam)
end

function var_0_0._refreshView(arg_5_0, arg_5_1)
	if arg_5_0.dialogId then
		arg_5_0:finished()
	end

	arg_5_0.dialogId = arg_5_1.dialogId
	arg_5_0.dialogType = arg_5_1.dialogType
	arg_5_0.callback = arg_5_1.callback
	arg_5_0.callbackObj = arg_5_1.callbackObj

	arg_5_0.option:startDialog(arg_5_1)
end

function var_0_0.finished(arg_6_0)
	if arg_6_0.dialogId then
		if arg_6_0.dialogId == 22 and not FairyLandModel.instance:isFinishDialog(8) then
			FairyLandRpc.instance:sendRecordDialogRequest(8)
		end

		if not FairyLandModel.instance:isFinishDialog(arg_6_0.dialogId) then
			FairyLandRpc.instance:sendRecordDialogRequest(arg_6_0.dialogId)
		end
	end

	if arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackObj)
	end

	if arg_6_0.option then
		arg_6_0.option:hide()
	end

	arg_6_0.dialogId = nil

	arg_6_0:closeThis()
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0.option then
		arg_7_0.option:dispose()
	end
end

return var_0_0
