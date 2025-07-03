module("modules.logic.messagebox.controller.MessageBoxController", package.seeall)

local var_0_0 = class("MessageBoxController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._showQueue = {}
	arg_1_0.enableClickAudio = true
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0._showQueue = {}
end

function var_0_0.setEnableClickAudio(arg_5_0, arg_5_1)
	arg_5_0.enableClickAudio = arg_5_1

	local var_5_0 = ViewMgr.instance:getContainer(ViewName.MessageBoxView)

	if var_5_0 and not gohelper.isNil(var_5_0.viewGO) then
		local var_5_1 = gohelper.findChild(var_5_0.viewGO, "#btn_yes")

		if not gohelper.isNil(var_5_1) then
			gohelper.addUIClickAudio(var_5_1, arg_5_1 and AudioEnum.UI.UI_Common_Click or 0)
		end

		local var_5_2 = gohelper.findChild(var_5_0.viewGO, "#btn_no")

		if not gohelper.isNil(var_5_2) then
			gohelper.addUIClickAudio(var_5_2, arg_5_1 and AudioEnum.UI.UI_Common_Click or 0)
		end
	end
end

function var_0_0.showSystemMsgBox(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7, arg_6_8, ...)
	arg_6_0._showQueue = {}
	arg_6_0._isShowSystemMsgBox = true

	local var_6_0 = {
		...
	}
	local var_6_1 = {
		msg = MessageBoxConfig.instance:getMessage(arg_6_1),
		msgBoxType = arg_6_2,
		yesCallback = arg_6_3,
		noCallback = arg_6_4,
		openCallback = arg_6_5,
		yesCallbackObj = arg_6_6,
		noCallbackObj = arg_6_7,
		openCallbackObj = arg_6_8,
		extra = var_6_0
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, var_6_1)
end

function var_0_0.showSystemMsgBoxByStr(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7, arg_7_8, ...)
	arg_7_0._showQueue = {}
	arg_7_0._isShowSystemMsgBox = true

	local var_7_0 = {
		...
	}
	local var_7_1 = {
		msg = arg_7_1,
		msgBoxType = arg_7_2,
		yesCallback = arg_7_3,
		noCallback = arg_7_4,
		openCallback = arg_7_5,
		yesCallbackObj = arg_7_6,
		noCallbackObj = arg_7_7,
		openCallbackObj = arg_7_8,
		extra = var_7_0
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, var_7_1)
end

function var_0_0.showSystemMsgBoxAndSetBtn(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7, arg_8_8, arg_8_9, arg_8_10, arg_8_11, arg_8_12, ...)
	arg_8_0._showQueue = {}
	arg_8_0._isShowSystemMsgBox = true

	local var_8_0 = {
		...
	}
	local var_8_1 = {
		msg = MessageBoxConfig.instance:getMessage(arg_8_1),
		msgBoxType = arg_8_2,
		yesCallback = arg_8_7,
		noCallback = arg_8_8,
		openCallback = arg_8_9,
		yesCallbackObj = arg_8_10,
		noCallbackObj = arg_8_11,
		openCallbackObj = arg_8_12,
		yesStr = arg_8_3,
		noStr = arg_8_5,
		yesStrEn = arg_8_4,
		noStrEn = arg_8_6,
		extra = var_8_0
	}

	ViewMgr.instance:closeView(ViewName.MessageBoxView)
	ViewMgr.instance:openView(ViewName.TopMessageBoxView, var_8_1)
end

function var_0_0.showMsgBoxAndSetBtn(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6, arg_9_7, arg_9_8, arg_9_9, arg_9_10, arg_9_11, arg_9_12, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		arg_9_0._isShowSystemMsgBox = false
	end

	if not arg_9_0._isShowSystemMsgBox then
		local var_9_0 = {
			...
		}

		arg_9_0:_internalShowMsgBox({
			messageBoxId = arg_9_1,
			msg = MessageBoxConfig.instance:getMessage(arg_9_1),
			msgBoxType = arg_9_2,
			yesCallback = arg_9_7,
			noCallback = arg_9_8,
			openCallback = arg_9_9,
			yesCallbackObj = arg_9_10,
			noCallbackObj = arg_9_11,
			openCallbackObj = arg_9_12,
			yesStr = arg_9_3,
			noStr = arg_9_5,
			yesStrEn = arg_9_4,
			noStrEn = arg_9_6,
			extra = var_9_0
		})
	end
end

function var_0_0.showMsgBox(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6, arg_10_7, arg_10_8, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		arg_10_0._isShowSystemMsgBox = false
	end

	if not arg_10_0._isShowSystemMsgBox then
		local var_10_0 = {
			...
		}

		arg_10_0:_internalShowMsgBox({
			messageBoxId = arg_10_1,
			msg = MessageBoxConfig.instance:getMessage(arg_10_1),
			msgBoxType = arg_10_2,
			yesCallback = arg_10_3,
			noCallback = arg_10_4,
			openCallback = arg_10_5,
			yesCallbackObj = arg_10_6,
			noCallbackObj = arg_10_7,
			openCallbackObj = arg_10_8,
			extra = var_10_0
		})
	end
end

function var_0_0.showMsgBoxByStr(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6, arg_11_7, arg_11_8)
	arg_11_0:_internalShowMsgBox({
		msg = arg_11_1,
		msgBoxType = arg_11_2,
		yesCallback = arg_11_3,
		noCallback = arg_11_4,
		openCallback = arg_11_5,
		yesCallbackObj = arg_11_6,
		noCallbackObj = arg_11_7,
		openCallbackObj = arg_11_8
	})
end

function var_0_0._internalShowMsgBox(arg_12_0, arg_12_1)
	table.insert(arg_12_0._showQueue, arg_12_1)

	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	arg_12_0:_showNextMsgBox()
end

function var_0_0._showNextMsgBox(arg_13_0)
	arg_13_0._isShowSystemMsgBox = nil

	if #arg_13_0._showQueue > 0 then
		local var_13_0 = table.remove(arg_13_0._showQueue, 1)

		ViewMgr.instance:openView(ViewName.MessageBoxView, var_13_0)

		return true
	end

	return false
end

function var_0_0.showOptionMsgBox(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6, arg_14_7, arg_14_8, arg_14_9, ...)
	arg_14_0._isShowSystemMsgBox = false

	local var_14_0 = {
		...
	}
	local var_14_1 = {
		msg = MessageBoxConfig.instance:getMessage(arg_14_1),
		messageBoxId = arg_14_1,
		msgBoxType = arg_14_2,
		optionType = arg_14_3,
		yesCallback = arg_14_4,
		noCallback = arg_14_5,
		openCallback = arg_14_6,
		yesCallbackObj = arg_14_7,
		noCallbackObj = arg_14_8,
		openCallbackObj = arg_14_9,
		extra = var_14_0
	}

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, var_14_1)
end

function var_0_0.showOptionAndParamsMsgBox(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8, arg_15_9, arg_15_10, ...)
	arg_15_0._isShowSystemMsgBox = false

	local var_15_0 = {
		...
	}
	local var_15_1 = {
		msg = MessageBoxConfig.instance:getMessage(arg_15_1),
		messageBoxId = arg_15_1,
		msgBoxType = arg_15_2,
		optionType = arg_15_3,
		optionExParam = arg_15_4,
		yesCallback = arg_15_5,
		noCallback = arg_15_6,
		openCallback = arg_15_7,
		yesCallbackObj = arg_15_8,
		noCallbackObj = arg_15_9,
		openCallbackObj = arg_15_10,
		extra = var_15_0
	}

	ViewMgr.instance:openView(ViewName.MessageOptionBoxView, var_15_1)
end

function var_0_0.canShowMessageOptionBoxView(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:getOptionLocalKey(arg_16_1, arg_16_2, arg_16_3)
	local var_16_1 = true

	if arg_16_2 == MsgBoxEnum.optionType.Daily then
		var_16_1 = TimeUtil.getDayFirstLoginRed(var_16_0)
	elseif arg_16_2 == MsgBoxEnum.optionType.NotShow then
		local var_16_2 = PlayerPrefsHelper.getString(var_16_0, "")

		var_16_1 = string.nilorempty(var_16_2)
	end

	return var_16_1
end

function var_0_0.getOptionLocalKey(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3 == nil then
		return string.format("MessageOptionBoxView#%s#%s#%s", arg_17_1, arg_17_2, tostring(PlayerModel.instance:getPlayinfo().userId))
	else
		return string.format("MessageOptionBoxView#%s#%s#%s#%s", arg_17_1, arg_17_2, arg_17_3, tostring(PlayerModel.instance:getPlayinfo().userId))
	end
end

function var_0_0.clearOption(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0:getOptionLocalKey(arg_18_1, arg_18_2, arg_18_3)

	PlayerPrefsHelper.deleteKey(var_18_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
