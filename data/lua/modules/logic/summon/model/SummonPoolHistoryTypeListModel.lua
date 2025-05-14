module("modules.logic.summon.model.SummonPoolHistoryTypeListModel", package.seeall)

local var_0_0 = class("SummonPoolHistoryTypeListModel", ListScrollModel)

function var_0_0.initPoolType(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = SummonPoolHistoryModel.instance:getHistoryValidPools()
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_3 = arg_1_0:getById(iter_1_1.id)

		if var_1_3 == nil then
			var_1_3 = SummonPoolHistoryTypeMO.New()
			var_1_2 = var_1_2 + 1

			var_1_3:init(iter_1_1.id, iter_1_1)
		end

		table.insert(var_1_0, var_1_3)
	end

	if var_1_2 > 0 or arg_1_0:getCount() ~= #var_1_0 then
		arg_1_0:setList(var_1_0)
		arg_1_0:onModelUpdate()
	end

	if not arg_1_0:getById(arg_1_0._poolTypeId) then
		arg_1_0._poolTypeId = arg_1_0:getFirstId()

		arg_1_0:_refreshSelect()
	end
end

function var_0_0.getFirstId(arg_2_0)
	local var_2_0 = arg_2_0:getByIndex(1)

	return var_2_0 and var_2_0.id
end

function var_0_0._refreshSelect(arg_3_0)
	local var_3_0 = arg_3_0:getById(arg_3_0._poolTypeId)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scrollViews) do
		iter_3_1:setSelect(var_3_0)
	end
end

function var_0_0.setSelectId(arg_4_0, arg_4_1)
	arg_4_0._poolTypeId = arg_4_1

	arg_4_0:_refreshSelect()
end

function var_0_0.getSelectId(arg_5_0)
	return arg_5_0._poolTypeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
