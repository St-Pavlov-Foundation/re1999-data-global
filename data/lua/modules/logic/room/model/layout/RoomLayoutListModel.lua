module("modules.logic.room.model.layout.RoomLayoutListModel", package.seeall)

local var_0_0 = class("RoomLayoutListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.init(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = RoomLayoutModel.instance
	local var_3_2 = var_3_1:getMaxPlanCount()

	for iter_3_0 = 0, var_3_2 do
		local var_3_3 = var_3_1:getById(iter_3_0)

		if not var_3_3 then
			var_3_3 = RoomLayoutMO.New()

			var_3_3:init(iter_3_0)
			var_3_3:setName("name_" .. iter_3_0)
			var_3_3:setEmpty(true)
		else
			var_3_3:setEmpty(false)
		end

		table.insert(var_3_0, var_3_3)
	end

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

function var_0_0.refreshList(arg_7_0)
	arg_7_0:onModelUpdate()
end

function var_0_0.initScelect(arg_8_0, arg_8_1)
	local var_8_0 = 0

	if arg_8_1 == true then
		local var_8_1 = arg_8_0:getList()

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			if iter_8_1:isEmpty() then
				var_8_0 = iter_8_1.id

				break
			end
		end
	end

	arg_8_0:setSelect(var_8_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
