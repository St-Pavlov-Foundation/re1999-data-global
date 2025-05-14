module("modules.logic.messagebox.view.MessageBoxView", package.seeall)

local var_0_0 = class("MessageBoxView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagehuawen1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "tipbg/#simage_huawen1")
	arg_1_0._simagehuawen2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "tipbg/#simage_huawen2")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")

	if MessageBoxController.instance.enableClickAudio then
		arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_yes")
		arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_no")
	else
		arg_1_0._btnyes = gohelper.findChildButton(arg_1_0.viewGO, "#btn_yes")
		arg_1_0._btnno = gohelper.findChildButton(arg_1_0.viewGO, "#btn_no")
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0:addEventCb(MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, arg_2_0._onCloseSpecificMessageBoxView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, arg_3_0._btnnoOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, arg_3_0._btnyesOnClick, arg_3_0)
	arg_3_0:removeEventCb(MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, arg_3_0._onCloseSpecificMessageBoxView, arg_3_0)
end

local var_0_1 = MsgBoxEnum.CloseType
local var_0_2 = MsgBoxEnum.BoxType

function var_0_0._btnyesOnClick(arg_4_0)
	arg_4_0:_closeInvokeCallback(var_0_1.Yes)
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:_closeInvokeCallback(var_0_1.No)
end

function var_0_0._closeInvokeCallback(arg_6_0, arg_6_1)
	if not MessageBoxController.instance:_showNextMsgBox() then
		arg_6_0:closeThis()
	end

	if arg_6_1 == var_0_1.Yes then
		if arg_6_0.viewParam.yesCallback then
			arg_6_0.viewParam.yesCallback(arg_6_0.viewParam.yesCallbackObj)
		end
	elseif arg_6_0.viewParam.noCallback then
		arg_6_0.viewParam.noCallback(arg_6_0.viewParam.noCallbackObj)
	end
end

function var_0_0._onCloseSpecificMessageBoxView(arg_7_0, arg_7_1)
	if not arg_7_1 or not arg_7_0.viewParam or not arg_7_0.viewParam.messageBoxId then
		return
	end

	if arg_7_0.viewParam.messageBoxId == arg_7_1 then
		arg_7_0:_btnnoOnClick()
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	arg_8_0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	arg_8_0._goNo = arg_8_0._btnno.gameObject
	arg_8_0._goYes = arg_8_0._btnyes.gameObject
	arg_8_0._keyTipsNo = gohelper.findChild(arg_8_0._goNo, "#go_pcbtn")
	arg_8_0._keyTipsYes = gohelper.findChild(arg_8_0._goYes, "#go_pcbtn")

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(arg_8_0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(arg_8_0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	arg_8_0._txtYes = gohelper.findChildText(arg_8_0._goYes, "yes")
	arg_8_0._txtNo = gohelper.findChildText(arg_8_0._goNo, "no")
	arg_8_0._txtYesen = gohelper.findChildText(arg_8_0._goYes, "yesen")
	arg_8_0._txtNoen = gohelper.findChildText(arg_8_0._goNo, "noen")

	PCInputController.instance:showkeyTips(arg_8_0._keyTipsNo, nil, nil, "Esc")
	PCInputController.instance:showkeyTips(arg_8_0._keyTipsYes, nil, nil, "Return")
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:onOpen()
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagehuawen1:UnLoadImage()
	arg_10_0._simagehuawen2:UnLoadImage()
end

function var_0_0.onOpen(arg_11_0)
	if not string.nilorempty(arg_11_0.viewParam.msg) and arg_11_0.viewParam.extra and #arg_11_0.viewParam.extra > 0 then
		local var_11_0 = arg_11_0.viewParam.msg
		local var_11_1 = GameUtil.getSubPlaceholderLuaLang(var_11_0, arg_11_0.viewParam.extra)

		arg_11_0._txtdesc.text = var_11_1
	else
		arg_11_0._txtdesc.text = arg_11_0.viewParam.msg or ""
	end

	if arg_11_0.viewParam.openCallback then
		if arg_11_0.viewParam.openCallbackObj then
			arg_11_0.viewParam.openCallback(arg_11_0.viewParam.openCallbackObj, arg_11_0)
		else
			arg_11_0.viewParam.openCallback(arg_11_0)
		end
	end

	local var_11_2 = arg_11_0.viewParam.yesStr or luaLang("confirm")
	local var_11_3 = arg_11_0.viewParam.noStr or luaLang("cancel")
	local var_11_4 = arg_11_0.viewParam.yesStrEn or "CONFIRM"
	local var_11_5 = arg_11_0.viewParam.noStrEn or "CANCEL"

	arg_11_0._txtYes.text = var_11_2
	arg_11_0._txtNo.text = var_11_3
	arg_11_0._txtYesen.text = var_11_4
	arg_11_0._txtNoen.text = var_11_5

	if arg_11_0.viewParam.msgBoxType == var_0_2.Yes then
		gohelper.setActive(arg_11_0._goNo, false)
		gohelper.setActive(arg_11_0._goYes, true)
		recthelper.setAnchorX(arg_11_0._goYes.transform, 0)
	elseif arg_11_0.viewParam.msgBoxType == var_0_2.NO then
		gohelper.setActive(arg_11_0._goYes, false)
		gohelper.setActive(arg_11_0._goNo, true)
		recthelper.setAnchorX(arg_11_0._goNo.transform, 0)
	elseif arg_11_0.viewParam.msgBoxType == var_0_2.Yes_No then
		gohelper.setActive(arg_11_0._goNo, true)
		gohelper.setActive(arg_11_0._goYes, true)
		recthelper.setAnchorX(arg_11_0._goYes.transform, 248)
		recthelper.setAnchorX(arg_11_0._goNo.transform, -248)
	end

	NavigateMgr.instance:addEscape(ViewName.MessageBoxView, arg_11_0._onEscapeBtnClick, arg_11_0)
end

function var_0_0._onEscapeBtnClick(arg_12_0)
	if arg_12_0._goNo.gameObject.activeInHierarchy then
		arg_12_0:_closeInvokeCallback(var_0_1.No)
	end
end

function var_0_0.onClose(arg_13_0)
	return
end

return var_0_0
