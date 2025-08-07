module("modules.logic.character.model.extra.CharacterWeaponShowMO", package.seeall)

local var_0_0 = class("CharacterWeaponShowMO")

function var_0_0.initMo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.heroId = arg_1_1
	arg_1_0.weaponId = arg_1_2.weaponId
	arg_1_0.type = arg_1_2.type
	arg_1_0.co = arg_1_2

	if arg_1_0:isEquip() then
		arg_1_0:cancelNew()
	end
end

function var_0_0.setStatus(arg_2_0, arg_2_1)
	arg_2_0.status = arg_2_1
end

function var_0_0.isEquip(arg_3_0)
	return arg_3_0.status == CharacterExtraEnum.WeaponStatus.Equip
end

function var_0_0.isLock(arg_4_0)
	return arg_4_0.status == CharacterExtraEnum.WeaponStatus.Lock
end

function var_0_0.isNormal(arg_5_0)
	return arg_5_0.status == CharacterExtraEnum.WeaponStatus.Normal
end

function var_0_0.isNew(arg_6_0)
	local var_6_0 = arg_6_0:_getReddotKey()

	arg_6_0._isNew = arg_6_0:isNormal() and GameUtil.playerPrefsGetNumberByUserId(var_6_0, 0) == 0

	return arg_6_0._isNew
end

function var_0_0.cancelNew(arg_7_0)
	if arg_7_0._isNew then
		local var_7_0 = arg_7_0:_getReddotKey()

		GameUtil.playerPrefsSetNumberByUserId(var_7_0, 1)

		arg_7_0._isNew = false
	end
end

function var_0_0._getReddotKey(arg_8_0)
	return (string.format("%s_%s_%s", CharacterExtraEnum.WeaponReddot, arg_8_0.heroId, arg_8_0.weaponId))
end

return var_0_0
