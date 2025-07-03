module("modules.logic.messagebox.view.MessageOptionBoxView", package.seeall)

local var_0_0 = class("MessageOptionBoxView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "tipContent/#txt_desc")
	arg_1_0._toggleoption = gohelper.findChildToggle(arg_1_0.viewGO, "tipContent/#toggle_option")
	arg_1_0._txtoption = gohelper.findChildText(arg_1_0.viewGO, "tipContent/#toggle_option/#txt_option")
	arg_1_0._btnyes = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "tipContent/btnContent/#btn_yes")
	arg_1_0._btnno = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "tipContent/btnContent/#btn_no")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
	arg_2_0._toggleoption:AddOnValueChanged(arg_2_0._toggleOptionOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
	arg_3_0._toggleoption:RemoveOnValueChanged()
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0, LuaEventSystem.Low)
end

local var_0_1 = MsgBoxEnum.CloseType
local var_0_2 = MsgBoxEnum.BoxType

function var_0_0._btnyesOnClick(arg_4_0)
	arg_4_0:_closeInvokeCallback(var_0_1.Yes)
end

function var_0_0._btnnoOnClick(arg_5_0)
	arg_5_0:_closeInvokeCallback(var_0_1.No)
end

function var_0_0._toggleOptionOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._closeInvokeCallback(arg_7_0, arg_7_1)
	if arg_7_1 == var_0_1.Yes then
		if arg_7_0._toggleoption.isOn then
			arg_7_0:saveOptionData()
		end

		if arg_7_0.viewParam.yesCallback then
			arg_7_0.viewParam.yesCallback(arg_7_0.viewParam.yesCallbackObj)
		end
	elseif arg_7_0.viewParam.noCallback then
		arg_7_0.viewParam.noCallback(arg_7_0.viewParam.noCallbackObj)
	end

	arg_7_0:closeThis()
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.MessageBoxView or arg_8_1 == ViewName.TopMessageBoxView then
		arg_8_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._goNo = arg_9_0._btnno.gameObject
	arg_9_0._goYes = arg_9_0._btnyes.gameObject

	if MessageBoxController.instance.enableClickAudio then
		gohelper.addUIClickAudio(arg_9_0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(arg_9_0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	end

	arg_9_0._txtYes = gohelper.findChildText(arg_9_0._goYes, "yes")
	arg_9_0._txtNo = gohelper.findChildText(arg_9_0._goNo, "no")
	arg_9_0._txtYesen = gohelper.findChildText(arg_9_0._goYes, "yesen")
	arg_9_0._txtNoen = gohelper.findChildText(arg_9_0._goNo, "noen")
	arg_9_0._toggleoption.isOn = false
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:onOpen()
end

function var_0_0.onOpen(arg_11_0)
	if arg_11_0.viewParam.openCallback then
		if arg_11_0.viewParam.openCallbackObj then
			arg_11_0.viewParam.openCallback(arg_11_0.viewParam.openCallbackObj, arg_11_0)
		else
			arg_11_0.viewParam.openCallback(arg_11_0)
		end
	end

	arg_11_0:refreshDesc()
	arg_11_0:refreshBtn()
	arg_11_0:refreshOptionUI()
end

function var_0_0.refreshDesc(arg_12_0)
	if not string.nilorempty(arg_12_0.viewParam.msg) and arg_12_0.viewParam.extra and #arg_12_0.viewParam.extra > 0 then
		local var_12_0 = arg_12_0.viewParam.msg
		local var_12_1 = GameUtil.getSubPlaceholderLuaLang(var_12_0, arg_12_0.viewParam.extra)

		arg_12_0._txtdesc.text = var_12_1
	else
		arg_12_0._txtdesc.text = arg_12_0.viewParam.msg or ""
	end
end

function var_0_0.refreshBtn(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.yesStr or luaLang("confirm")
	local var_13_1 = arg_13_0.viewParam.noStr or luaLang("cancel")
	local var_13_2 = arg_13_0.viewParam.yesStrEn or "CONFIRM"
	local var_13_3 = arg_13_0.viewParam.noStrEn or "CANCEL"

	arg_13_0._txtYes.text = var_13_0
	arg_13_0._txtNo.text = var_13_1
	arg_13_0._txtYesen.text = var_13_2
	arg_13_0._txtNoen.text = var_13_3

	if arg_13_0.viewParam.msgBoxType == var_0_2.Yes then
		gohelper.setActive(arg_13_0._goNo, false)
		gohelper.setActive(arg_13_0._goYes, true)
	elseif arg_13_0.viewParam.msgBoxType == var_0_2.NO then
		gohelper.setActive(arg_13_0._goYes, false)
		gohelper.setActive(arg_13_0._goNo, true)
	elseif arg_13_0.viewParam.msgBoxType == var_0_2.Yes_No then
		gohelper.setActive(arg_13_0._goNo, true)
		gohelper.setActive(arg_13_0._goYes, true)
	end

	NavigateMgr.instance:addEscape(ViewName.MessageOptionBoxView, arg_13_0._onEscapeBtnClick, arg_13_0)
end

function var_0_0._onEscapeBtnClick(arg_14_0)
	if arg_14_0._goNo.gameObject.activeInHierarchy then
		arg_14_0:_closeInvokeCallback(var_0_1.No)
	end
end

function var_0_0.refreshOptionUI(arg_15_0)
	gohelper.setActive(arg_15_0._toggleoption.gameObject, true)

	arg_15_0.optionType = arg_15_0.viewParam.optionType
	arg_15_0.optionExParam = arg_15_0.viewParam.optionExParam
	arg_15_0.messageBoxId = arg_15_0.viewParam.messageBoxId

	if arg_15_0.optionType == MsgBoxEnum.optionType.Daily then
		arg_15_0._txtoption.text = luaLang("messageoptionbox_daily")
	elseif arg_15_0.viewParam.optionType == MsgBoxEnum.optionType.NotShow then
		arg_15_0._txtoption.text = luaLang("messageoptionbox_notshow")
	else
		gohelper.setActive(arg_15_0._toggleoption.gameObject, false)
	end
end

function var_0_0.saveOptionData(arg_16_0)
	if arg_16_0.optionType <= 0 or not arg_16_0._toggleoption.isOn then
		return
	end

	local var_16_0 = MessageBoxController.instance:getOptionLocalKey(arg_16_0.messageBoxId, arg_16_0.optionType, arg_16_0.optionExParam)

	if arg_16_0.optionType == MsgBoxEnum.optionType.Daily then
		TimeUtil.setDayFirstLoginRed(var_16_0)
	elseif arg_16_0.optionType == MsgBoxEnum.optionType.NotShow then
		PlayerPrefsHelper.setString(var_16_0, arg_16_0.optionType)
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
