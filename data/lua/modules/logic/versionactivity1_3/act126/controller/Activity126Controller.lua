module("modules.logic.versionactivity1_3.act126.controller.Activity126Controller", package.seeall)

local var_0_0 = class("Activity126Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRefresh, arg_3_0, LuaEventSystem.Low)
end

function var_0_0.dailyRefresh(arg_4_0)
	if not Activity126Model.instance.isInit then
		return
	end

	if not ActivityModel.instance:isActOnLine(VersionActivity1_3Enum.ActivityId.Act310) then
		return
	end

	Activity126Rpc.instance:sendGet126InfosRequest(VersionActivity1_3Enum.ActivityId.Act310)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
