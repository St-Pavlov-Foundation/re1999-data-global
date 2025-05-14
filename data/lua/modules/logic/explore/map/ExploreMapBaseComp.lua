module("modules.logic.explore.map.ExploreMapBaseComp", package.seeall)

local var_0_0 = class("ExploreMapBaseComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._mapGo = arg_1_1
	arg_1_0._mapStatus = ExploreEnum.MapStatus.Normal

	arg_1_0:onInit()
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.setMap(arg_5_0, arg_5_1)
	arg_5_0._map = arg_5_1
end

function var_0_0.setMapStatus(arg_6_0, arg_6_1)
	arg_6_0._mapStatus = arg_6_1
end

function var_0_0.beginStatus(arg_7_0, arg_7_1)
	return arg_7_0._map:setMapStatus(arg_7_0._mapStatus, arg_7_1)
end

function var_0_0.onStatusStart(arg_8_0)
	return
end

function var_0_0.onStatusEnd(arg_9_0)
	return
end

function var_0_0.onMapClick(arg_10_0, arg_10_1)
	arg_10_0._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function var_0_0.canSwitchStatus(arg_11_0, arg_11_1)
	return true
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._mapGo = nil
end

return var_0_0
