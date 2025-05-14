module("modules.logic.room.model.layout.RoomLayoutBgResListModel", package.seeall)

local var_0_0 = class("RoomLayoutBgResListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.init(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = RoomConfig.instance:getPlanCoverConfigList()

	for iter_3_0 = 1, #var_3_1 do
		local var_3_2 = RoomLayoutBgResMO.New()
		local var_3_3 = var_3_1[iter_3_0]

		var_3_2:init(var_3_3.id, var_3_3)

		if var_3_3.id == arg_3_1 then
			table.insert(var_3_0, 1, var_3_2)
		else
			table.insert(var_3_0, var_3_2)
		end
	end

	arg_3_0._selectId = nil

	arg_3_0:setList(var_3_0)
end

function var_0_0._refreshSelect(arg_4_0)
	local var_4_0 = arg_4_0:getById(arg_4_0._selectId)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._scrollViews) do
		iter_4_1:setSelect(var_4_0)
	end
end

function var_0_0.getSelectMO(arg_5_0)
	return arg_5_0:getById(arg_5_0._selectId)
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	arg_6_0._selectId = arg_6_1

	arg_6_0:_refreshSelect()
end

var_0_0.instance = var_0_0.New()

return var_0_0
