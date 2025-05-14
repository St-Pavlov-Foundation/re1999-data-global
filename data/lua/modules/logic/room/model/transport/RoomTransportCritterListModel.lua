module("modules.logic.room.model.transport.RoomTransportCritterListModel", package.seeall)

local var_0_0 = class("RoomTransportCritterListModel", ListScrollModel)

function var_0_0.setCritterList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = CritterModel.instance:getAllCritters()

	for iter_1_0 = 1, #var_1_1 do
		local var_1_2 = var_1_1[iter_1_0]

		if var_1_2 and var_1_2:isMaturity() then
			table.insert(var_1_0, var_1_2)
		end
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.getSelect(arg_2_0)
	return arg_2_0._selectId
end

function var_0_0._refreshSelect(arg_3_0)
	local var_3_0 = arg_3_0:getById(arg_3_0._selectId)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scrollViews) do
		iter_3_1:setSelect(var_3_0)
	end
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	if arg_4_0._selectId ~= arg_4_1 then
		arg_4_0._selectId = arg_4_1

		arg_4_0:_refreshSelect()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
