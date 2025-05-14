module("modules.logic.settings.view.KeyMapAlertView", package.seeall)

local var_0_0 = class("KeyMapAlertView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._toastConfig = lua_toast.configDict

	arg_1_0.viewGO:SetActive(false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btncancelOnClick(arg_4_0)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	arg_5_0:save()
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	if arg_7_0.viewParam then
		arg_7_0._mo = arg_7_0.viewParam.value
		arg_7_0._modifyKey = arg_7_0._mo[PCInputModel.Configfield.key]

		arg_7_0:setInputKey()
	end
end

function var_0_0.onBtnReset(arg_8_0)
	SettingsKeyListModel.instance:Reset(arg_8_0._mo[PCInputModel.Configfield.hud])
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.getKey, arg_9_0)
end

function var_0_0.listenInputKey(arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0.getKey, arg_10_0, 0)
	PCInputController.instance:PauseListen()
end

function var_0_0.getKey(arg_11_0)
	local var_11_0 = arg_11_0._mo[PCInputModel.Configfield.hud]

	if UnityEngine.Input.anyKeyDown and not UnityEngine.Input.GetMouseButton(0) then
		TaskDispatcher.cancelTask(arg_11_0.getKey, arg_11_0)
		TaskDispatcher.runDelay(PCInputController.resumeListen, PCInputController.instance, 0.5)

		local var_11_1 = PCInputController.instance:getCurrentPresskey()

		if PCInputModel.instance:checkKeyCanModify(var_11_0, var_11_1) then
			local var_11_2 = arg_11_0:checkedKey(var_11_1)

			if var_11_2 then
				arg_11_0:setKeyOccupied(var_11_2, var_11_1)
			else
				arg_11_0:setKey(var_11_1)
			end
		else
			arg_11_0:setCantModify(var_11_1)
		end
	end
end

function var_0_0.checkedKey(arg_12_0, arg_12_1)
	return SettingsKeyListModel.instance:checkDunplicateKey(arg_12_0._mo[PCInputModel.Configfield.hud], arg_12_1)
end

function var_0_0.setInputKey(arg_13_0)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyChange, MsgBoxEnum.BoxType.NO, arg_13_0._btnconfirmOnClick, arg_13_0._btncancelOnClick, nil, arg_13_0, arg_13_0, nil, arg_13_0._mo.description)
	arg_13_0:listenInputKey()
end

function var_0_0.setKey(arg_14_0, arg_14_1)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeyConfirm, MsgBoxEnum.BoxType.Yes_No, arg_14_0._btnconfirmOnClick, arg_14_0._btncancelOnClick, nil, arg_14_0, arg_14_0, nil, arg_14_0._mo.description, PCInputController.instance:KeyNameToDescName(arg_14_1))

	arg_14_0._modifyKey = arg_14_1
end

function var_0_0.setCantModify(arg_15_0, arg_15_1)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

	if not arg_15_1 then
		return
	end

	ToastController.instance:showToast(ToastEnum.PCKeyCantModify, PCInputController.instance:KeyNameToDescName(arg_15_1))
end

function var_0_0.setKeyOccupied(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)

	if arg_16_1[PCInputModel.Configfield.hud] == arg_16_0._mo[PCInputModel.Configfield.hud] and arg_16_1[PCInputModel.Configfield.id] == arg_16_0._mo[PCInputModel.Configfield.id] then
		ToastController.instance:showToast(ToastEnum.pcKeyTipsOccupied)
		ViewMgr.instance:closeView(ViewName.KeyMapAlertView)

		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.PCInputKeySwap, MsgBoxEnum.BoxType.Yes_No, function()
		arg_16_0:swapKey(arg_16_1, arg_16_2)
	end, arg_16_0._btncancelOnClick, nil, nil, nil, nil, PCInputController.instance:KeyNameToDescName(arg_16_2), arg_16_1.description)
end

function var_0_0.swapKey(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._mo[PCInputModel.Configfield.key]

	SettingsKeyListModel.instance:modifyKey(arg_18_0._mo[PCInputModel.Configfield.hud], arg_18_0._mo[PCInputModel.Configfield.id], arg_18_2)
	SettingsKeyListModel.instance:modifyKey(arg_18_1[PCInputModel.Configfield.hud], arg_18_1[PCInputModel.Configfield.id], var_18_0)
	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:closeView(ViewName.KeyMapAlertView)
end

function var_0_0.save(arg_19_0)
	SettingsKeyListModel.instance:modifyKey(arg_19_0._mo[PCInputModel.Configfield.hud], arg_19_0._mo[PCInputModel.Configfield.id], arg_19_0._modifyKey)
end

return var_0_0
