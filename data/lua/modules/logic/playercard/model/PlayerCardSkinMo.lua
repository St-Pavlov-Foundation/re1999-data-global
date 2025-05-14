module("modules.logic.playercard.model.PlayerCardSkinMo", package.seeall)

local var_0_0 = class("PlayerCardSkinMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._config = nil
	arg_1_0.id = nil
	arg_1_0.icon = nil
	arg_1_0._isEmpty = false
	arg_1_0._isNew = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0.id = arg_2_1.id
	arg_2_0._config = ItemConfig.instance:getItemCo(arg_2_0.id)
	arg_2_0.icon = arg_2_0._config.icon
end

function var_0_0.getConfig(arg_3_0)
	return arg_3_0._config
end

function var_0_0.checkNew(arg_4_0)
	return arg_4_0._isNew
end

function var_0_0.clearNewState(arg_5_0)
	arg_5_0._isNew = false
end

function var_0_0.isEmpty(arg_6_0)
	return arg_6_0._isEmpty
end

function var_0_0.setEmpty(arg_7_0)
	arg_7_0._isEmpty = true
	arg_7_0.id = 0
end

function var_0_0.isUnLock(arg_8_0)
	if arg_8_0._isEmpty then
		return true
	end

	return ItemModel.instance:getItemCount(arg_8_0.id) > 0
end

function var_0_0.checkIsUse(arg_9_0)
	local var_9_0 = PlayerCardModel.instance:getPlayerCardSkinId()

	if var_9_0 and var_9_0 ~= 0 then
		return var_9_0 == arg_9_0.id
	elseif arg_9_0._isEmpty then
		return true
	end

	return false
end

return var_0_0
