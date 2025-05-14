module("modules.logic.versionactivity1_3.astrology.controller.VersionActivity1_3AstrologyController", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openVersionActivity1_3AstrologyView(arg_3_0)
	local var_3_0 = {
		defaultTabIds = {
			[2] = 1
		}
	}
	local var_3_1 = Activity126Model.instance:receiveHoroscope()

	if var_3_1 and var_3_1 > 0 then
		var_3_0.defaultTabIds[3] = 2
	else
		var_3_0.defaultTabIds[3] = 1
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologyView, var_3_0)
end

function var_0_0.openVersionActivity1_3AstrologySuccessView(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:openView(ViewName.VersionActivity1_3AstrologySuccessView, arg_4_1, arg_4_2)
end

function var_0_0.openVersionActivity1_3AstrologyPropView(arg_5_0, arg_5_1)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.VersionActivity1_3AstrologyPropView, arg_5_1)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
