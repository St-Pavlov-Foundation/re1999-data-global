module("modules.logic.backpack.config.ItemConfigGetDefine", package.seeall)

slot0 = class("ItemConfigGetDefine", BaseConfig)

function slot0.ctor(slot0)
	slot0._defineList = {
		[MaterialEnum.MaterialType.Item] = uv0._getItem,
		[MaterialEnum.MaterialType.Currency] = uv0._getCurrency,
		[MaterialEnum.MaterialType.PowerPotion] = uv0._getPowerPotion,
		[MaterialEnum.MaterialType.HeroSkin] = uv0._getHeroSkin,
		[MaterialEnum.MaterialType.Hero] = uv0._getHero,
		[MaterialEnum.MaterialType.Equip] = uv0._getEquip,
		[MaterialEnum.MaterialType.PlayerCloth] = uv0._getPlayerCloth,
		[MaterialEnum.MaterialType.Building] = uv0._getBuilding,
		[MaterialEnum.MaterialType.Formula] = uv0._getFormula,
		[MaterialEnum.MaterialType.BlockPackage] = uv0._getBlockPackage,
		[MaterialEnum.MaterialType.SpecialBlock] = uv0._getSpecialBlock,
		[MaterialEnum.MaterialType.RoomTheme] = uv0._getRoomTheme,
		[MaterialEnum.MaterialType.Explore] = uv0._getExplore,
		[MaterialEnum.MaterialType.EquipCard] = uv0._getEquipCard,
		[MaterialEnum.MaterialType.Antique] = uv0._getAntique,
		[MaterialEnum.MaterialType.V1a5AiZiLa] = uv0._getV1a5AiZiLaItem,
		[MaterialEnum.MaterialType.Season123EquipCard] = uv0._getSeason123EquipCard,
		[MaterialEnum.MaterialType.NewInsight] = uv0._getNewInsight
	}
end

function slot0._getItem(slot0)
	return ItemConfig.instance:getItemCo(slot0)
end

function slot0._getCurrency(slot0)
	return CurrencyConfig.instance:getCurrencyCo(slot0)
end

function slot0._getPowerPotion(slot0)
	return ItemConfig.instance:getPowerItemCo(slot0)
end

function slot0._getHeroSkin(slot0)
	return SkinConfig.instance:getSkinCo(slot0)
end

function slot0._getHero(slot0)
	return HeroConfig.instance:getHeroCO(slot0)
end

function slot0._getEquip(slot0)
	return EquipConfig.instance:getEquipCo(slot0)
end

function slot0._getPlayerCloth(slot0)
	return PlayerConfig.instance:getPlayerClothConfig(slot0)
end

function slot0._getBuilding(slot0)
	return RoomConfig.instance:getBuildingConfig(slot0)
end

function slot0._getFormula(slot0)
	return RoomConfig.instance:getFormulaConfig(slot0)
end

function slot0._getBlockPackage(slot0)
	return RoomConfig.instance:getBlockPackageConfig(slot0)
end

function slot0._getSpecialBlock(slot0)
	return RoomConfig.instance:getSpecialBlockConfig(slot0)
end

function slot0._getRoomTheme(slot0)
	return RoomConfig.instance:getThemeConfig(slot0)
end

function slot0._getV1a5AiZiLaItem(slot0)
	return AiZiLaConfig.instance:getItemCo(slot0)
end

function slot0._getExplore(slot0)
	return ExploreConfig.instance:getItemCo(slot0)
end

function slot0._getEquipCard(slot0)
	return SeasonConfig.instance:getSeasonEquipCo(slot0)
end

function slot0._getAntique(slot0)
	return AntiqueConfig.instance:getAntiqueCo(slot0)
end

function slot0._getSeason123EquipCard(slot0)
	return Season123Config.instance:getSeasonEquipCo(slot0)
end

function slot0._getNewInsight(slot0)
	return ItemConfig.instance:getInsightItemCo(slot0)
end

function slot0.getItemConfigFunc(slot0, slot1)
	return slot0._defineList[tonumber(slot1)]
end

slot0.instance = slot0.New()

return slot0
