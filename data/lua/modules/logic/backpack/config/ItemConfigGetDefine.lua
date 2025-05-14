module("modules.logic.backpack.config.ItemConfigGetDefine", package.seeall)

local var_0_0 = class("ItemConfigGetDefine", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._defineList = {
		[MaterialEnum.MaterialType.Item] = var_0_0._getItem,
		[MaterialEnum.MaterialType.Currency] = var_0_0._getCurrency,
		[MaterialEnum.MaterialType.PowerPotion] = var_0_0._getPowerPotion,
		[MaterialEnum.MaterialType.HeroSkin] = var_0_0._getHeroSkin,
		[MaterialEnum.MaterialType.Hero] = var_0_0._getHero,
		[MaterialEnum.MaterialType.Equip] = var_0_0._getEquip,
		[MaterialEnum.MaterialType.PlayerCloth] = var_0_0._getPlayerCloth,
		[MaterialEnum.MaterialType.Building] = var_0_0._getBuilding,
		[MaterialEnum.MaterialType.Formula] = var_0_0._getFormula,
		[MaterialEnum.MaterialType.BlockPackage] = var_0_0._getBlockPackage,
		[MaterialEnum.MaterialType.SpecialBlock] = var_0_0._getSpecialBlock,
		[MaterialEnum.MaterialType.RoomTheme] = var_0_0._getRoomTheme,
		[MaterialEnum.MaterialType.Explore] = var_0_0._getExplore,
		[MaterialEnum.MaterialType.EquipCard] = var_0_0._getEquipCard,
		[MaterialEnum.MaterialType.Antique] = var_0_0._getAntique,
		[MaterialEnum.MaterialType.V1a5AiZiLa] = var_0_0._getV1a5AiZiLaItem,
		[MaterialEnum.MaterialType.Season123EquipCard] = var_0_0._getSeason123EquipCard,
		[MaterialEnum.MaterialType.NewInsight] = var_0_0._getNewInsight,
		[MaterialEnum.MaterialType.Critter] = var_0_0._getCritter
	}
end

function var_0_0._getItem(arg_2_0)
	return ItemConfig.instance:getItemCo(arg_2_0)
end

function var_0_0._getCurrency(arg_3_0)
	return CurrencyConfig.instance:getCurrencyCo(arg_3_0)
end

function var_0_0._getPowerPotion(arg_4_0)
	return ItemConfig.instance:getPowerItemCo(arg_4_0)
end

function var_0_0._getHeroSkin(arg_5_0)
	return SkinConfig.instance:getSkinCo(arg_5_0)
end

function var_0_0._getHero(arg_6_0)
	return HeroConfig.instance:getHeroCO(arg_6_0)
end

function var_0_0._getEquip(arg_7_0)
	return EquipConfig.instance:getEquipCo(arg_7_0)
end

function var_0_0._getPlayerCloth(arg_8_0)
	return PlayerConfig.instance:getPlayerClothConfig(arg_8_0)
end

function var_0_0._getBuilding(arg_9_0)
	return RoomConfig.instance:getBuildingConfig(arg_9_0)
end

function var_0_0._getFormula(arg_10_0)
	return RoomConfig.instance:getFormulaConfig(arg_10_0)
end

function var_0_0._getBlockPackage(arg_11_0)
	return RoomConfig.instance:getBlockPackageConfig(arg_11_0)
end

function var_0_0._getSpecialBlock(arg_12_0)
	return RoomConfig.instance:getSpecialBlockConfig(arg_12_0)
end

function var_0_0._getRoomTheme(arg_13_0)
	return RoomConfig.instance:getThemeConfig(arg_13_0)
end

function var_0_0._getV1a5AiZiLaItem(arg_14_0)
	return AiZiLaConfig.instance:getItemCo(arg_14_0)
end

function var_0_0._getExplore(arg_15_0)
	return ExploreConfig.instance:getItemCo(arg_15_0)
end

function var_0_0._getEquipCard(arg_16_0)
	return SeasonConfig.instance:getSeasonEquipCo(arg_16_0)
end

function var_0_0._getAntique(arg_17_0)
	return AntiqueConfig.instance:getAntiqueCo(arg_17_0)
end

function var_0_0._getSeason123EquipCard(arg_18_0)
	return Season123Config.instance:getSeasonEquipCo(arg_18_0)
end

function var_0_0._getNewInsight(arg_19_0)
	return ItemConfig.instance:getInsightItemCo(arg_19_0)
end

function var_0_0._getCritter(arg_20_0)
	return CritterConfig.instance:getCritterCfg(arg_20_0)
end

function var_0_0.getItemConfigFunc(arg_21_0, arg_21_1)
	arg_21_1 = tonumber(arg_21_1)

	return arg_21_0._defineList[arg_21_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
