module("modules.logic.room.model.record.RoomHandBookMo", package.seeall)

local var_0_0 = class("RoomHandBookMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._config = nil
	arg_1_0.id = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._config = arg_2_1
	arg_2_0.id = arg_2_1.id
	arg_2_0._isreverse = false
	arg_2_0._mo = RoomHandBookModel.instance:getMoById(arg_2_0.id)
end

function var_0_0.getConfig(arg_3_0)
	return arg_3_0._config
end

function var_0_0.checkGotCritter(arg_4_0)
	return arg_4_0._mo and true or false
end

function var_0_0.getBackGroundId(arg_5_0)
	if arg_5_0._mo and arg_5_0._mo.Background ~= 0 then
		return arg_5_0._mo.Background
	end
end

function var_0_0.setBackGroundId(arg_6_0, arg_6_1)
	arg_6_0._mo.Background = arg_6_1
end

function var_0_0.checkUnlockSpeicalSkinById(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	return arg_7_0._mo.unlockSpecialSkin
end

function var_0_0.setSpeicalSkin(arg_8_0, arg_8_1)
	arg_8_0._mo.UseSpecialSkin = arg_8_1
end

function var_0_0.checkNew(arg_9_0)
	if not arg_9_0._mo then
		return
	end

	return arg_9_0._mo.isNew
end

function var_0_0.clearNewState(arg_10_0)
	arg_10_0._mo.isNew = false
end

function var_0_0.setReverse(arg_11_0, arg_11_1)
	arg_11_0._isreverse = arg_11_1
end

function var_0_0.checkIsReverse(arg_12_0)
	return arg_12_0._isreverse
end

function var_0_0.checkShowMutate(arg_13_0)
	if not arg_13_0._mo then
		return false
	end

	return arg_13_0._mo.unlockSpecialSkin and arg_13_0._mo.unlockNormalSkin
end

function var_0_0.checkShowSpeicalSkin(arg_14_0)
	if not arg_14_0._mo then
		return false
	end

	return arg_14_0._mo.UseSpecialSkin
end

return var_0_0
