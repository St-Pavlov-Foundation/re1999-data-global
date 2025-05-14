module("modules.logic.room.model.transport.quicklink.RoomTransportNodeMO", package.seeall)

local var_0_0 = pureTable("RoomTransportNodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.hexPoint = arg_1_1

	arg_1_0:resetParam()
end

function var_0_0.resetParam(arg_2_0)
	arg_2_0.isBuilding = false
	arg_2_0.linkNum = 0
	arg_2_0.searchIndex = -1
	arg_2_0.isBlock = false
	arg_2_0.isSelectPath = false
end

return var_0_0
