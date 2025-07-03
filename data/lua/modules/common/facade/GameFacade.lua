module("modules.common.facade.GameFacade", package.seeall)

local var_0_0 = {
	openInputBox = function(arg_1_0)
		ViewMgr.instance:openView(ViewName.CommonInputView, arg_1_0)
	end,
	closeInputBox = function()
		ViewMgr.instance:closeView(ViewName.CommonInputView)
	end,
	jump = function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		return JumpController.instance:jump(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	end,
	jumpByAdditionParam = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		return JumpController.instance:jumpByAdditionParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	end,
	jumpByStr = function(arg_5_0)
		CommonJumpUtil.jump(arg_5_0)
	end,
	showMessageBox = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, ...)
		MessageBoxController.instance:showMsgBox(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, ...)
	end,
	showToastWithTableParam = function(arg_7_0, arg_7_1)
		if arg_7_1 then
			ToastController.instance:showToast(arg_7_0, unpack(arg_7_1))
		else
			ToastController.instance:showToast(arg_7_0)
		end
	end,
	showToast = function(arg_8_0, ...)
		ToastController.instance:showToast(arg_8_0, ...)
	end,
	showToastString = function(arg_9_0)
		ToastController.instance:showToastWithString(arg_9_0)
	end,
	showToastWithIcon = function(arg_10_0, arg_10_1, ...)
		ToastController.instance:showToastWithIcon(arg_10_0, arg_10_1, ...)
	end
}

function var_0_0.showIconToastWithTableParam(arg_11_0, arg_11_1, arg_11_2)
	if type(arg_11_2) == "table" then
		var_0_0.showToastWithIcon(arg_11_0, arg_11_1, unpack(arg_11_2))
	else
		var_0_0.showToastWithIcon(arg_11_0, arg_11_1)
	end
end

function var_0_0.isExternalTest()
	return GameConfig:GetCurServerType() == 6 and SettingsModel.instance:isZhRegion()
end

function var_0_0.isKOLTest()
	local var_13_0 = GameConfig:GetCurServerType()

	return var_13_0 == GameUrlConfig.ServerType.OutExperience or var_13_0 == 8
end

function var_0_0.showOptionMessageBox(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7, arg_14_8, ...)
	if not MessageBoxController.instance:canShowMessageOptionBoxView(arg_14_0, arg_14_2) then
		if arg_14_3 then
			arg_14_3(arg_14_6)
		end

		return
	end

	MessageBoxController.instance:showOptionMsgBox(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7, arg_14_8, ...)
end

function var_0_0.showOptionAndParamsMessageBox(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9, ...)
	if not MessageBoxController.instance:canShowMessageOptionBoxView(arg_15_0, arg_15_2, arg_15_3) then
		if arg_15_4 then
			arg_15_4(arg_15_7)
		end

		return
	end

	MessageBoxController.instance:showOptionAndParamsMsgBox(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9, ...)
end

return var_0_0
