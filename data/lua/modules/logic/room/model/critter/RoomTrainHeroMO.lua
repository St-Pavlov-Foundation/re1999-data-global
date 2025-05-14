module("modules.logic.room.model.critter.RoomTrainHeroMO", package.seeall)

local var_0_0 = pureTable("RoomTrainHeroMO")

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = HeroModel.instance:getByHeroId(arg_1_1.heroId)

	arg_1_0:initHeroMO(var_1_0)
end

function var_0_0.initHeroMO(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.heroId
	arg_2_0.heroId = arg_2_0.id
	arg_2_0.heroMO = arg_2_1
	arg_2_0.skinId = arg_2_0.heroMO.skin
	arg_2_0.heroConfig = HeroConfig.instance:getHeroCO(arg_2_0.heroId)
	arg_2_0.skinConfig = SkinConfig.instance:getSkinCo(arg_2_0.skinId)
	arg_2_0.critterHeroConfig = CritterConfig.instance:getCritterHeroPreferenceCfg(arg_2_0.heroId)
	arg_2_0._prefernectType = nil
	arg_2_0._prefernectValueNums = nil

	local var_2_0 = arg_2_0:getAttributeInfoMO()

	if arg_2_0.critterHeroConfig then
		arg_2_0._prefernectType = arg_2_0.critterHeroConfig.preferenceType

		var_2_0:setAttr(arg_2_0.critterHeroConfig.effectAttribute, 0)

		var_2_0.rate = arg_2_0.critterHeroConfig.addIncrRate + 10000

		if not string.nilorempty(arg_2_0.critterHeroConfig.preferenceValue) then
			arg_2_0._prefernectValueNums = string.splitToNumber(arg_2_0.critterHeroConfig.preferenceValue, "#")
		end
	end
end

function var_0_0.updateSkinId(arg_3_0, arg_3_1)
	arg_3_0.skinId = arg_3_1
	arg_3_0.skinConfig = SkinConfig.instance:getSkinCo(arg_3_0.skinId)
end

function var_0_0.getAttributeInfoMO(arg_4_0)
	if not arg_4_0._attributeInfoMO then
		arg_4_0._attributeInfoMO = CritterAttributeInfoMO.New()

		arg_4_0._attributeInfoMO:init()
	end

	return arg_4_0._attributeInfoMO
end

function var_0_0.getPrefernectType(arg_5_0)
	return arg_5_0._prefernectType
end

function var_0_0.getPrefernectIds(arg_6_0)
	return arg_6_0._prefernectValueNums
end

function var_0_0.chcekPrefernectCritterId(arg_7_0, arg_7_1)
	if arg_7_0._prefernectType == CritterEnum.PreferenceType.All then
		return true
	end

	if arg_7_0._prefernectType == CritterEnum.PreferenceType.Catalogue then
		local var_7_0 = CritterConfig.instance
		local var_7_1 = var_7_0:getCritterCatalogue(arg_7_1)

		for iter_7_0 = 1, #arg_7_0._prefernectValueNums do
			local var_7_2 = arg_7_0._prefernectValueNums[iter_7_0]

			if var_7_2 == var_7_1 or var_7_0:isHasCatalogueChildId(var_7_2, var_7_1) then
				return true
			end
		end
	elseif arg_7_0._prefernectType == CritterEnum.PreferenceType.Critter and tabletool.indexOf(arg_7_0._prefernectValueNums, arg_7_1) then
		return true
	end

	return false
end

function var_0_0.getPrefernectName(arg_8_0)
	if arg_8_0._prefernectType == CritterEnum.PreferenceType.All then
		return luaLang("critter_train_hero_prefernect_all_txt")
	elseif arg_8_0._prefernectType == CritterEnum.PreferenceType.Catalogue then
		if arg_8_0._prefernectValueNums and #arg_8_0._prefernectValueNums > 0 then
			local var_8_0 = CritterConfig.instance:getCritterCatalogueCfg(arg_8_0._prefernectValueNums[1])

			return var_8_0 and var_8_0.name or arg_8_0._prefernectValueNums[1]
		end
	elseif arg_8_0._prefernectType == CritterEnum.PreferenceType.Critter and arg_8_0._prefernectValueNums and #arg_8_0._prefernectValueNums > 0 then
		local var_8_1 = CritterConfig.instance:getCritterCfg(arg_8_0._prefernectValueNums[1])

		return var_8_1 and var_8_1.name or arg_8_0._prefernectValueNums[1]
	end

	return ""
end

return var_0_0
