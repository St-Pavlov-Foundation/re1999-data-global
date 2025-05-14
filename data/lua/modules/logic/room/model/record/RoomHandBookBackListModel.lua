module("modules.logic.room.model.record.RoomHandBookBackListModel", package.seeall)

local var_0_0 = class("RoomHandBookBackListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.UtmStickers)

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = RoomHandBookBackMo.New()

		var_1_2:init(iter_1_1)
		table.insert(var_1_0, var_1_2)
	end

	local var_1_3 = RoomHandBookBackMo.New()

	var_1_3:setEmpty()
	table.insert(var_1_0, var_1_3)
	table.sort(var_1_0, var_0_0.sort)

	local var_1_4 = RoomHandBookModel.instance:getSelectMoBackGroundId()

	for iter_1_2, iter_1_3 in ipairs(var_1_0) do
		if var_1_4 and var_1_4 == iter_1_3.id then
			arg_1_0._selectIndex = iter_1_2

			RoomHandBookBackModel.instance:setSelectMo(iter_1_3)

			break
		elseif iter_1_3:isEmpty() then
			arg_1_0._selectIndex = iter_1_2

			RoomHandBookBackModel.instance:setSelectMo(iter_1_3)

			break
		end
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.sort(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:checkIsUse() and 3 or arg_2_0:isEmpty() and 2 or 1
	local var_2_1 = arg_2_1:checkIsUse() and 3 or arg_2_1:isEmpty() and 2 or 1

	if var_2_0 ~= var_2_1 then
		return var_2_1 < var_2_0
	else
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.getSelectIndex(arg_3_0)
	return arg_3_0._selectIndex or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
