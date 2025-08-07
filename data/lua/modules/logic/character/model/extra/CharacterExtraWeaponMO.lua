module("modules.logic.character.model.extra.CharacterExtraWeaponMO", package.seeall)

local var_0_0 = class("CharacterExtraWeaponMO")

function var_0_0.isUnlockSystem(arg_1_0)
	return arg_1_0:isUnlockWeapon(CharacterExtraEnum.WeaponType.First)
end

function var_0_0.isUnlockWeapon(arg_2_0, arg_2_1)
	return arg_2_0:getUnlockWeaponRank(arg_2_1) <= arg_2_0.heroMo.rank
end

function var_0_0.getUnlockSystemRank(arg_3_0)
	return arg_3_0:getUnlockWeaponRank(CharacterExtraEnum.WeaponType.First)
end

function var_0_0.getUnlockWeaponRank(arg_4_0, arg_4_1)
	local var_4_0 = CharacterExtraEnum.WeaponParams[arg_4_1].UnlockConst
	local var_4_1 = lua_fight_const.configDict[var_4_0]

	return (tonumber(var_4_1.value))
end

function var_0_0.refreshMo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroMo = arg_5_2

	arg_5_0:initConfig()

	if not string.nilorempty(arg_5_1) then
		local var_5_0 = string.splitToNumber(arg_5_1, "#")

		for iter_5_0, iter_5_1 in pairs(CharacterExtraEnum.WeaponType) do
			arg_5_0:setCurEquipWeapon(iter_5_1, var_5_0[iter_5_1])
		end
	end

	arg_5_0:refreshStatus()
end

function var_0_0.initConfig(arg_6_0)
	if not arg_6_0._weaponMos then
		arg_6_0._weaponMos = {}

		local var_6_0 = CharacterExtraConfig.instance:getEzioWeaponConfigs()

		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			if not arg_6_0._weaponMos[iter_6_0] then
				arg_6_0._weaponMos[iter_6_0] = {}
			end

			for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
				local var_6_1 = CharacterWeaponShowMO.New()

				var_6_1:initMo(arg_6_0.heroMo.heroId, iter_6_3)

				arg_6_0._weaponMos[iter_6_0][iter_6_3.weaponId] = var_6_1
			end
		end
	end
end

function var_0_0.refreshStatus(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._weaponMos) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			local var_7_0 = CharacterExtraEnum.WeaponStatus.Normal
			local var_7_1 = arg_7_0:getCurEquipWeapon(iter_7_0) == iter_7_3.weaponId

			if not arg_7_0:isUnlockWeapon(iter_7_0) then
				var_7_0 = CharacterExtraEnum.WeaponStatus.Lock
			elseif var_7_1 then
				var_7_0 = CharacterExtraEnum.WeaponStatus.Equip
			end

			iter_7_3:setStatus(var_7_0)
		end
	end
end

function var_0_0.getWeaponMosByType(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_0._weaponMos[arg_8_1] then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._weaponMos[arg_8_1]) do
			table.insert(var_8_0, iter_8_1)
		end

		table.sort(var_8_0, var_0_0.sortWeaponMo)
	end

	return var_8_0
end

function var_0_0.sortWeaponMo(arg_9_0, arg_9_1)
	return arg_9_0.weaponId < arg_9_1.weaponId
end

function var_0_0.getWeaponMoByTypeId(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._weaponMos[arg_10_1] and arg_10_0._weaponMos[arg_10_1][arg_10_2]
end

function var_0_0.getCurEquipWeapon(arg_11_0, arg_11_1)
	return arg_11_0._curEquipWeapon and arg_11_0._curEquipWeapon[arg_11_1] or 0
end

function var_0_0.setCurEquipWeapon(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._curEquipWeapon then
		arg_12_0._curEquipWeapon = {}
	end

	arg_12_0._curEquipWeapon[arg_12_1] = arg_12_2
end

function var_0_0.getWeaponGroupCo(arg_13_0)
	local var_13_0 = arg_13_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local var_13_1 = arg_13_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return (CharacterExtraConfig.instance:getEzioWeaponGroupCos(var_13_0, var_13_1, arg_13_0.heroMo.exSkillLevel))
end

function var_0_0.isConfirmWeaponGroup(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local var_14_1 = arg_14_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return var_14_0 == arg_14_1 and var_14_1 == arg_14_2
end

function var_0_0.setChoiceHero3123WeaponRequest(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0
	local var_15_1

	if not arg_15_0._curEquipWeapon then
		arg_15_0._curEquipWeapon = {}
	end

	if arg_15_1 == CharacterExtraEnum.WeaponType.First then
		var_15_0 = arg_15_2
		var_15_1 = arg_15_0._curEquipWeapon[CharacterExtraEnum.WeaponType.Second] or 0
	else
		var_15_0 = arg_15_0._curEquipWeapon[CharacterExtraEnum.WeaponType.First] or 0
		var_15_1 = arg_15_2
	end

	HeroRpc.instance:setChoiceHero3123WeaponRequest(arg_15_0.heroMo.heroId, var_15_0, var_15_1)
end

function var_0_0.confirmWeaponGroup(arg_16_0, arg_16_1, arg_16_2)
	HeroRpc.instance:setChoiceHero3123WeaponRequest(arg_16_0.heroMo.heroId, arg_16_1 or 0, arg_16_2 or 0)
end

function var_0_0.getUnlockRankStr(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = luaLang("character_rankup_unlock_system")

	for iter_17_0, iter_17_1 in ipairs(CharacterExtraEnum.WeaponParams) do
		if arg_17_0:getUnlockWeaponRank(iter_17_0) == arg_17_1 then
			local var_17_2 = GameUtil.getSubPlaceholderLuaLangOneParam(var_17_1, luaLang(iter_17_1.RankupShow))

			table.insert(var_17_0, var_17_2)
		end
	end

	return var_17_0
end

function var_0_0.isShowWeaponReddot(arg_18_0, arg_18_1)
	if arg_18_0:isUnlockWeapon(arg_18_1) then
		local var_18_0 = arg_18_0:_getReddotKey(arg_18_1)

		return GameUtil.playerPrefsGetNumberByUserId(var_18_0, 0) == 0
	end

	return false
end

function var_0_0.checkReddot(arg_19_0)
	local var_19_0 = false

	for iter_19_0, iter_19_1 in ipairs(CharacterExtraEnum.WeaponParams) do
		if arg_19_0:isShowWeaponReddot(iter_19_0) then
			local var_19_1 = arg_19_0:_getReddotKey(iter_19_0)

			GameUtil.playerPrefsSetNumberByUserId(var_19_1, 1)

			var_19_0 = true
		end
	end

	if var_19_0 then
		RedDotController.instance:dispatchEvent(RedDotEvent.RefreshClientCharacterDot)
	end
end

function var_0_0._getReddotKey(arg_20_0, arg_20_1)
	return (string.format("%s_%s_%s", CharacterExtraEnum.WeaponTypeReddot, arg_20_0.heroMo.heroId, arg_20_1))
end

function var_0_0.getCurEquipGroupCo(arg_21_0)
	local var_21_0 = arg_21_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.First)
	local var_21_1 = arg_21_0:getCurEquipWeapon(CharacterExtraEnum.WeaponType.Second)

	return (CharacterExtraConfig.instance:getEzioWeaponGroupCos(var_21_0, var_21_1, arg_21_0.heroMo.exSkillLevel))
end

function var_0_0.getReplaceSkill(arg_22_0)
	local var_22_0 = arg_22_0:getCurEquipGroupCo()

	if var_22_0 then
		return string.format("1#%s|2#%s", var_22_0.skillGroup1, var_22_0.skillGroup2), var_22_0.skillEx, var_22_0.passiveSkill
	end
end

function var_0_0.getReplacePassiveSkills(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getCurEquipGroupCo()

	if var_23_0 and not string.nilorempty(var_23_0.exchangeSkills) then
		local var_23_1 = GameUtil.splitString2(var_23_0.exchangeSkills, true, "|", "#")

		for iter_23_0, iter_23_1 in pairs(arg_23_1) do
			for iter_23_2, iter_23_3 in ipairs(var_23_1) do
				local var_23_2 = iter_23_3[1]
				local var_23_3 = iter_23_3[2]

				if iter_23_1 == var_23_2 then
					arg_23_1[iter_23_0] = var_23_3
				end
			end
		end
	end

	return arg_23_1
end

return var_0_0
