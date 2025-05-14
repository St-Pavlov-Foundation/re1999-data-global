module("modules.logic.room.model.map.path.RoomMapPathPlanModel", package.seeall)

local var_0_0 = class("RoomMapPathPlanModel", BaseModel)

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

function var_0_0.init(arg_5_0)
	arg_5_0:clear()
end

function var_0_0.initPath(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = RoomConfig.instance:getVehicleConfigList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		table.insert(var_6_0, iter_6_1.resId)
	end

	local var_6_2 = RoomResourceHelper.getResourcePointAreaMODict(nil, var_6_0)
	local var_6_3 = {}

	for iter_6_2, iter_6_3 in pairs(var_6_2) do
		local var_6_4 = iter_6_3:findeArea()

		for iter_6_4, iter_6_5 in ipairs(var_6_4) do
			local var_6_5 = iter_6_2 * 1000 + iter_6_4
			local var_6_6 = RoomMapPathPlanMO.New()

			var_6_6:init(var_6_5, iter_6_2, iter_6_5)
			table.insert(var_6_3, var_6_6)
		end
	end

	arg_6_0:setList(var_6_3)
end

function var_0_0.getPlanMOByXY(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getList()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0]

		if var_7_1.resourceId == arg_7_3 and var_7_1:getNodeByXY(arg_7_1, arg_7_2) then
			return var_7_1
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
