module("modules.logic.messagebox.view.MessageBoxView", package.seeall)

slot0 = class("MessageBoxView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagehuawen1 = gohelper.findChildSingleImage(slot0.viewGO, "tipbg/#simage_huawen1")
	slot0._simagehuawen2 = gohelper.findChildSingleImage(slot0.viewGO, "tipbg/#simage_huawen2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")

	if MessageBoxController.instance.enableClickAudio then
		slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
		slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")
	else
		slot0._btnyes = gohelper.findChildButton(slot0.viewGO, "#btn_yes")
		slot0._btnno = gohelper.findChildButton(slot0.viewGO, "#btn_no")
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btnnoOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._btnyesOnClick, slot0)
	slot0:addEventCb(MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, slot0._onCloseSpecificMessageBoxView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonCancel, slot0._btnnoOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyCommonConfirm, slot0._btnyesOnClick, slot0)
	slot0:removeEventCb(MessageBoxController.instance, MessageBoxEvent.CloseSpecificMessageBoxView, slot0._onCloseSpecificMessageBoxView, slot0)
end

slot1 = MsgBoxEnum.CloseType
slot2 = MsgBoxEnum.BoxType

function slot0._btnyesOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.Yes)
end

function slot0._btnnoOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.No)
end

function slot0._closeInvokeCallback(slot0, slot1)
	if not MessageBoxController.instance:_showNextMsgBox() then
		slot0:closeThis()
	end

	if slot1 == uv0.Yes then
		if slot0.viewParam.yesCallback then
			slot0.viewParam.yesCallback(slot0.viewParam.yesCallbackObj)
		end
	elseif slot0.viewParam.noCallback then
		slot0.viewParam.noCallback(slot0.viewParam.noCallbackObj)
	end
end

function slot0._onCloseSpecificMessageBoxView(slot0, slot1)
	if not slot1 or not slot0.viewParam or not slot0.viewParam.messageBoxId then
		return
	end

	if slot0.viewParam.messageBoxId == slot1 then
		slot0:_btnnoOnClick()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	slot0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	slot0._goNo = slot0._btnno.gameObject
	slot0._goYes = slot0._btnyes.gameObject
	slot0._keyTipsNo = gohelper.findChild(slot0._goNo, "#go_pcbtn")
	slot0._keyTipsYes = gohelper.findChild(slot0._goYes, "#go_pcbtn")

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	slot0._txtYes = gohelper.findChildText(slot0._goYes, "yes")
	slot0._txtNo = gohelper.findChildText(slot0._goNo, "no")
	slot0._txtYesen = gohelper.findChildText(slot0._goYes, "yesen")
	slot0._txtNoen = gohelper.findChildText(slot0._goNo, "noen")

	PCInputController.instance:showkeyTips(slot0._keyTipsNo, nil, , "Esc")
	PCInputController.instance:showkeyTips(slot0._keyTipsYes, nil, , "Return")
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onDestroyView(slot0)
	slot0._simagehuawen1:UnLoadImage()
	slot0._simagehuawen2:UnLoadImage()
end

function slot0.onOpen(slot0)
	if not string.nilorempty(slot0.viewParam.msg) and slot0.viewParam.extra and #slot0.viewParam.extra > 0 then
		slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(slot0.viewParam.msg, slot0.viewParam.extra)
	else
		slot0._txtdesc.text = slot0.viewParam.msg or ""
	end

	if slot0.viewParam.openCallback then
		if slot0.viewParam.openCallbackObj then
			slot0.viewParam.openCallback(slot0.viewParam.openCallbackObj, slot0)
		else
			slot0.viewParam.openCallback(slot0)
		end
	end

	slot0._txtYes.text = slot0.viewParam.yesStr or luaLang("confirm")
	slot0._txtNo.text = slot0.viewParam.noStr or luaLang("cancel")
	slot0._txtYesen.text = slot0.viewParam.yesStrEn or "CONFIRM"
	slot0._txtNoen.text = slot0.viewParam.noStrEn or "CANCEL"

	if slot0.viewParam.msgBoxType == uv0.Yes then
		gohelper.setActive(slot0._goNo, false)
		gohelper.setActive(slot0._goYes, true)
		recthelper.setAnchorX(slot0._goYes.transform, 0)
	elseif slot0.viewParam.msgBoxType == uv0.NO then
		gohelper.setActive(slot0._goYes, false)
		gohelper.setActive(slot0._goNo, true)
		recthelper.setAnchorX(slot0._goNo.transform, 0)
	elseif slot0.viewParam.msgBoxType == uv0.Yes_No then
		gohelper.setActive(slot0._goNo, true)
		gohelper.setActive(slot0._goYes, true)
		recthelper.setAnchorX(slot0._goYes.transform, 248)
		recthelper.setAnchorX(slot0._goNo.transform, -248)
	end

	NavigateMgr.instance:addEscape(ViewName.MessageBoxView, slot0._onEscapeBtnClick, slot0)
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._goNo.gameObject.activeInHierarchy then
		slot0:_closeInvokeCallback(uv0.No)
	end
end

function slot0.onClose(slot0)
end

return slot0
