module("modules.logic.messagebox.view.MessageOptionBoxView", package.seeall)

slot0 = class("MessageOptionBoxView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "tipContent/#txt_desc")
	slot0._toggleoption = gohelper.findChildToggle(slot0.viewGO, "tipContent/#toggle_option")
	slot0._txtoption = gohelper.findChildText(slot0.viewGO, "tipContent/#toggle_option/#txt_option")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "tipContent/btnContent/#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "tipContent/btnContent/#btn_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._toggleoption:AddOnValueChanged(slot0._toggleOptionOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0._toggleoption:RemoveOnValueChanged()
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
end

slot1 = MsgBoxEnum.CloseType
slot2 = MsgBoxEnum.BoxType

function slot0._btnyesOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.Yes)
end

function slot0._btnnoOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.No)
end

function slot0._toggleOptionOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._closeInvokeCallback(slot0, slot1)
	if slot1 == uv0.Yes then
		if slot0._toggleoption.isOn then
			slot0:saveOptionData()
		end

		if slot0.viewParam.yesCallback then
			slot0.viewParam.yesCallback(slot0.viewParam.yesCallbackObj)
		end
	elseif slot0.viewParam.noCallback then
		slot0.viewParam.noCallback(slot0.viewParam.noCallbackObj)
	end

	slot0:closeThis()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.MessageBoxView or slot1 == ViewName.TopMessageBoxView then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._goNo = slot0._btnno.gameObject
	slot0._goYes = slot0._btnyes.gameObject

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	slot0._txtYes = gohelper.findChildText(slot0._goYes, "yes")
	slot0._txtNo = gohelper.findChildText(slot0._goNo, "no")
	slot0._txtYesen = gohelper.findChildText(slot0._goYes, "yesen")
	slot0._txtNoen = gohelper.findChildText(slot0._goNo, "noen")
	slot0._toggleoption.isOn = false
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	if slot0.viewParam.openCallback then
		if slot0.viewParam.openCallbackObj then
			slot0.viewParam.openCallback(slot0.viewParam.openCallbackObj, slot0)
		else
			slot0.viewParam.openCallback(slot0)
		end
	end

	slot0:refreshDesc()
	slot0:refreshBtn()
	slot0:refreshOptionUI()
end

function slot0.refreshDesc(slot0)
	if not string.nilorempty(slot0.viewParam.msg) and slot0.viewParam.extra and #slot0.viewParam.extra > 0 then
		slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(slot0.viewParam.msg, slot0.viewParam.extra)
	else
		slot0._txtdesc.text = slot0.viewParam.msg or ""
	end
end

function slot0.refreshBtn(slot0)
	slot0._txtYes.text = slot0.viewParam.yesStr or luaLang("confirm")
	slot0._txtNo.text = slot0.viewParam.noStr or luaLang("cancel")
	slot0._txtYesen.text = slot0.viewParam.yesStrEn or "CONFIRM"
	slot0._txtNoen.text = slot0.viewParam.noStrEn or "CANCEL"

	if slot0.viewParam.msgBoxType == uv0.Yes then
		gohelper.setActive(slot0._goNo, false)
		gohelper.setActive(slot0._goYes, true)
	elseif slot0.viewParam.msgBoxType == uv0.NO then
		gohelper.setActive(slot0._goYes, false)
		gohelper.setActive(slot0._goNo, true)
	elseif slot0.viewParam.msgBoxType == uv0.Yes_No then
		gohelper.setActive(slot0._goNo, true)
		gohelper.setActive(slot0._goYes, true)
	end

	NavigateMgr.instance:addEscape(ViewName.MessageOptionBoxView, slot0._onEscapeBtnClick, slot0)
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._goNo.gameObject.activeInHierarchy then
		slot0:_closeInvokeCallback(uv0.No)
	end
end

function slot0.refreshOptionUI(slot0)
	gohelper.setActive(slot0._toggleoption.gameObject, true)

	slot0.optionType = slot0.viewParam.optionType
	slot0.messageBoxId = slot0.viewParam.messageBoxId

	if slot0.optionType == MsgBoxEnum.optionType.Daily then
		slot0._txtoption.text = luaLang("messageoptionbox_daily")
	elseif slot0.viewParam.optionType == MsgBoxEnum.optionType.NotShow then
		slot0._txtoption.text = luaLang("messageoptionbox_notshow")
	else
		gohelper.setActive(slot0._toggleoption.gameObject, false)
	end
end

function slot0.saveOptionData(slot0)
	if slot0.optionType <= 0 or not slot0._toggleoption.isOn then
		return
	end

	if slot0.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(MessageBoxController.instance:getOptionLocalKey(slot0.messageBoxId, slot0.optionType))
	elseif slot0.optionType == MsgBoxEnum.optionType.NotShow then
		PlayerPrefsHelper.setString(slot1, slot0.optionType)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
