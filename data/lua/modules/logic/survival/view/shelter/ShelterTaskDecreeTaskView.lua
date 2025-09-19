module("modules.logic.survival.view.shelter.ShelterTaskDecreeTaskView", package.seeall)

local var_0_0 = class("ShelterTaskDecreeTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.tabList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_2_0.refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnTaskViewUpdate, arg_3_0.refreshView, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.refreshView(arg_5_0, arg_5_1)
	return
end

function var_0_0.onClose(arg_6_0)
	return
end

return var_0_0
