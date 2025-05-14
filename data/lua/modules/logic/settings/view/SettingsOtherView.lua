module("modules.logic.settings.view.SettingsOtherView", package.seeall)

local var_0_0 = class("SettingsOtherView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscreenshot = gohelper.findChild(arg_1_0.viewGO, "#go_screenshot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._itemTableDict = {}

	arg_4_0:_initItem(arg_4_0._goscreenshot, "screenshot")
end

function var_0_0._initItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.btn = gohelper.findChildButtonWithAudio(arg_5_1, "switch/btn")
	var_5_0.off = gohelper.findChild(arg_5_1, "switch/btn/off")
	var_5_0.on = gohelper.findChild(arg_5_1, "switch/btn/on")

	var_5_0.btn:AddClickListener(arg_5_0._onSwitchClick, arg_5_0, arg_5_2)

	arg_5_0._itemTableDict[arg_5_2] = var_5_0
end

function var_0_0._onSwitchClick(arg_6_0, arg_6_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_6_1 == "screenshot" then
		local var_6_0 = not SettingsModel.instance:getScreenshotSwitch()

		SettingsModel.instance:setScreenshotSwitch(var_6_0)
	end

	arg_6_0:_refreshSwitchUI(arg_6_1)
end

function var_0_0._refreshSwitchUI(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._itemTableDict[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1 = false

	if arg_7_1 == "screenshot" then
		var_7_1 = SettingsModel.instance:getScreenshotSwitch()
	end

	gohelper.setActive(var_7_0.on, var_7_1)
	gohelper.setActive(var_7_0.off, not var_7_1)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_refreshUI()
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0:_refreshSwitchUI("screenshot")
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._itemTableDict) do
		iter_12_1.btn:RemoveClickListener()
	end
end

return var_0_0
