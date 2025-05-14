module("modules.logic.room.model.record.RoomTradeTaskListModel", package.seeall)

local var_0_0 = class("RoomTradeTaskListModel", ListScrollModel)

function var_0_0.setMoList(arg_1_0, arg_1_1)
	local var_1_0 = RoomTradeTaskModel.instance:getLevelTaskMo(arg_1_1) or {}

	if LuaUtil.tableNotEmpty(var_1_0) then
		table.sort(var_1_0, arg_1_0.sort)
	end

	arg_1_0:setList(var_1_0)

	return var_1_0
end

function var_0_0.sort(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.co
	local var_2_1 = arg_2_1.co

	if arg_2_0.hasFinish ~= arg_2_1.hasFinish then
		return arg_2_1.hasFinish
	end

	if var_2_0 and var_2_1 then
		return var_2_0.sortId < var_2_1.sortId
	end

	return arg_2_0.id < arg_2_1.id
end

function var_0_0.getNewFinishTaskIds(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = RoomTradeTaskModel.instance:getLevelTaskMo(arg_3_1)

	if var_3_1 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			if iter_3_1.new then
				table.insert(var_3_0, iter_3_1.id)
			end
		end
	end

	return var_3_0
end

function var_0_0.getFinishOrNotTaskIds(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = RoomTradeTaskModel.instance:getLevelTaskMo(arg_4_1)

	if var_4_1 then
		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if iter_4_1:isFinish() == arg_4_2 then
				table.insert(var_4_0, iter_4_1.id)
			end
		end
	end

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
