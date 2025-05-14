module("modules.logic.room.entity.comp.RoomBuildingVehicleComp", package.seeall)

local var_0_0 = class("RoomBuildingVehicleComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._vehicleType = arg_2_0:getBuilingMO().config.vehicleType

	arg_2_0:_onSwitchModel()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_3_0._onSwitchModel, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_4_0._onSwitchModel, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0._onSwitchModel(arg_6_0)
	local var_6_0 = RoomController.instance:isEditMode()

	if not var_6_0 and not arg_6_0.entity:getVehicleMO() then
		var_6_0 = true
	end

	if arg_6_0._vehicleType == 1 then
		gohelper.setActive(arg_6_0.entity.containerGO, var_6_0)
		gohelper.setActive(arg_6_0.entity.staticContainerGO, var_6_0)
	end
end

function var_0_0.getBuilingMO(arg_7_0)
	return arg_7_0.entity:getMO()
end

return var_0_0
