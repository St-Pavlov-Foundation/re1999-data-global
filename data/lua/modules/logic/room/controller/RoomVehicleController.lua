module("modules.logic.room.controller.RoomVehicleController", package.seeall)

local var_0_0 = class("RoomVehicleController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	RoomMapVehicleModel.instance:clear()
	RoomMapPathPlanModel.instance:clear()
end

function var_0_0.init(arg_4_0)
	RoomMapPathPlanModel.instance:initPath()
	RoomMapVehicleModel.instance:initVehicle()
end

function var_0_0.addConstEvents(arg_5_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
