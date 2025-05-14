module("modules.logic.room.model.record.RoomHandBookListModel", package.seeall)

local var_0_0 = class("RoomHandBookListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = lua_critter.configList

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = RoomHandBookMo.New()

		var_1_2:init(iter_1_1)
		table.insert(var_1_0, var_1_2)
	end

	table.sort(var_1_0, var_0_0.sort)
	arg_1_0:setList(var_1_0)
	RoomHandBookModel.instance:setSelectMo(var_1_0[1])
end

function var_0_0.sort(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:checkGotCritter() and 2 or 1
	local var_2_1 = arg_2_1:checkGotCritter() and 2 or 1

	if var_2_0 ~= var_2_1 then
		return var_2_1 < var_2_0
	else
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.reverseCardBack(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1:setReverse(arg_3_1)
	end
end

function var_0_0.clearItemNewState(arg_4_0, arg_4_1)
	arg_4_0:getById(arg_4_1):clearNewState()
	arg_4_0:onModelUpdate()
end

function var_0_0.setMutate(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0:getById(arg_5_1.id):setSpeicalSkin(arg_5_1.UseSpecialSkin)
end

var_0_0.instance = var_0_0.New()

return var_0_0
