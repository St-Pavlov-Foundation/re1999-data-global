module("modules.logic.backpack.config.ItemIconGetDefine", package.seeall)

local var_0_0 = class("ItemIconGetDefine", BaseConfig)

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
		[MaterialEnum.MaterialType.Season123EquipCard] = var_0_0._getEquipCard,
		[MaterialEnum.MaterialType.NewInsight] = var_0_0._getNewInsight,
		[MaterialEnum.MaterialType.Critter] = var_0_0._getCritterIcon
	}
end

function var_0_0._getItem(arg_2_0)
	return ResUrl.getPropItemIcon(arg_2_0.icon)
end

function var_0_0._getCurrency(arg_3_0)
	return ResUrl.getCurrencyItemIcon(arg_3_0.icon)
end

function var_0_0._getPowerPotion(arg_4_0)
	return ResUrl.getPropItemIcon(arg_4_0.icon)
end

function var_0_0._getHeroSkin(arg_5_0)
	return ResUrl.getHeadIconSmall(arg_5_0.headIcon), ResUrl.getHeroSkinPropIcon(arg_5_0.itemIcon)
end

function var_0_0._getHero(arg_6_0)
	local var_6_0 = SkinConfig.instance:getSkinCo(arg_6_0.skinId)

	return ResUrl.getHeadIconSmall(var_6_0.headIcon), ResUrl.getHeadIconNew(arg_6_0.id)
end

function var_0_0._getEquip(arg_7_0)
	return ResUrl.getEquipIcon(arg_7_0.icon)
end

function var_0_0._getPlayerCloth(arg_8_0)
	return ResUrl.getPlayerClothIcon(arg_8_0.icon)
end

function var_0_0._getBuilding(arg_9_0)
	return ResUrl.getRoomBuildingPropIcon(arg_9_0.icon)
end

function var_0_0._getFormula(arg_10_0)
	return ResUrl.getPropItemIcon(arg_10_0.icon)
end

function var_0_0._getBlockPackage(arg_11_0)
	return ResUrl.getRoomBlockPackagePropIcon(arg_11_0.icon)
end

function var_0_0._getSpecialBlock(arg_12_0)
	return ResUrl.getRoomBlockPropIcon(arg_12_0.icon)
end

function var_0_0._getRoomTheme(arg_13_0)
	return ResUrl.getRoomThemePropIcon(arg_13_0.icon)
end

function var_0_0._getExplore(arg_14_0)
	return ResUrl.getPropItemIcon(arg_14_0.icon)
end

function var_0_0._getEquipCard(arg_15_0)
	return ResUrl.getSeasonCelebrityCard(arg_15_0.icon)
end

function var_0_0._getAntique(arg_16_0)
	return ResUrl.getPropItemIcon(arg_16_0.icon)
end

function var_0_0._getV1a5AiZiLaItem(arg_17_0)
	return ResUrl.getV1a5AiZiLaItemIcon(arg_17_0.icon)
end

function var_0_0._getNewInsight(arg_18_0)
	return ResUrl.getPropItemIcon(arg_18_0.icon)
end

function var_0_0._getCritterIcon(arg_19_0)
	return ResUrl.getCritterItemIcon(arg_19_0.icon)
end

function var_0_0.getItemIconFunc(arg_20_0, arg_20_1)
	arg_20_1 = tonumber(arg_20_1)

	return arg_20_0._defineList[arg_20_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
