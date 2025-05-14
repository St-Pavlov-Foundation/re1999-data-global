module("modules.logic.sdk.view.SDKExitGameView", package.seeall)

local var_0_0 = class("SDKExitGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "txt_desc")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._btnlogout = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_logout")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#btn_cancel/#go_pcbtn")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "#btn_logout/#go_pcbtn")

	PCInputController.instance:showkeyTips(var_1_0, nil, nil, "Esc")
	PCInputController.instance:showkeyTips(var_1_1, nil, nil, "Return")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnlogout:AddClickListener(arg_2_0._btnlogoutOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_2_0._btnlogoutOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnlogout:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_3_0._btncancelOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_3_0._btnlogoutOnClick, arg_3_0)
end

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnlogoutOnClick(arg_5_0)
	arg_5_0:closeThis()

	if arg_5_0.viewParam.exitCallback then
		arg_5_0.viewParam.exitCallback()
	else
		LoginController.instance:logout()
	end
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	NavigateMgr.instance:addEscape(ViewName.SDKExitGameView, arg_8_0.closeThis, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
