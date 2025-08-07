module("modules.logic.mainuiswitch.view.SwitchMainUIView", package.seeall)

local var_0_0 = class("SwitchMainUIView", MainUIPartView)

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_1_0.refreshMainUI, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, arg_2_0.refreshMainUI, arg_2_0)
end

return var_0_0
