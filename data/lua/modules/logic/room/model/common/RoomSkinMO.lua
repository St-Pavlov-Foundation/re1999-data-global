module("modules.logic.room.model.common.RoomSkinMO", package.seeall)

local var_0_0 = pureTable("RoomSkinMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
end

function var_0_0.setIsEquipped(arg_2_0, arg_2_1)
	arg_2_0._isEquipped = arg_2_1
end

function var_0_0.getId(arg_3_0)
	return arg_3_0.id
end

function var_0_0.getBelongPartId(arg_4_0)
	local var_4_0 = arg_4_0.id

	return (RoomConfig.instance:getBelongPart(var_4_0))
end

function var_0_0.isUnlock(arg_5_0)
	local var_5_0 = false
	local var_5_1 = RoomConfig.instance:getRoomSkinUnlockItemId(arg_5_0.id)

	if var_5_1 and var_5_1 ~= 0 then
		var_5_0 = ItemModel.instance:getItemCount(var_5_1) > 0
	else
		var_5_0 = true
	end

	return var_5_0
end

function var_0_0.isEquipped(arg_6_0)
	return arg_6_0._isEquipped
end

return var_0_0
