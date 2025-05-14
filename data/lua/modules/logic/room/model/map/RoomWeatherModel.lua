module("modules.logic.room.model.map.RoomWeatherModel", package.seeall)

local var_0_0 = class("RoomWeatherModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.setIsNight(arg_5_0, arg_5_1)
	arg_5_0._isNight = arg_5_1 == true
end

function var_0_0.getIsNight(arg_6_0)
	return arg_6_0._isNight
end

var_0_0.instance = var_0_0.New()

return var_0_0
