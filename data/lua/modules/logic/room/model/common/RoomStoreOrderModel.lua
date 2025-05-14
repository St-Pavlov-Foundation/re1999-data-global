module("modules.logic.room.model.common.RoomStoreOrderModel", package.seeall)

local var_0_0 = class("RoomStoreOrderModel", BaseModel)

function var_0_0.getMOByList(arg_1_0, arg_1_1)
	if arg_1_1 and #arg_1_1 > 0 then
		local var_1_0 = arg_1_0:getList()

		for iter_1_0 = 1, #var_1_0 do
			local var_1_1 = var_1_0[iter_1_0]

			if var_1_1:isSameValue(arg_1_1) then
				return var_1_1
			end
		end
	end

	return nil
end

function var_0_0.addByStoreItemMOList(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0:getById(arg_2_2)

	if not var_2_0 then
		var_2_0 = RoomStoreOrderMO.New()

		arg_2_0:addAtLast(var_2_0)
	end

	var_2_0:init(arg_2_2, arg_2_3)

	for iter_2_0 = 1, #arg_2_1 do
		local var_2_1 = arg_2_1[iter_2_0]
		local var_2_2 = var_2_1:getCanBuyNum()

		if var_2_2 > 0 then
			var_2_0:addValue(var_2_1.materialType, var_2_1.itemId, var_2_2)
		end
	end

	return var_2_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
