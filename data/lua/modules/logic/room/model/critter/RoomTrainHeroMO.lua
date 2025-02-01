module("modules.logic.room.model.critter.RoomTrainHeroMO", package.seeall)

slot0 = pureTable("RoomTrainHeroMO")

function slot0.init(slot0, slot1)
	slot0:initHeroMO(HeroModel.instance:getByHeroId(slot1.heroId))
end

function slot0.initHeroMO(slot0, slot1)
	slot0.id = slot1.heroId
	slot0.heroId = slot0.id
	slot0.heroMO = slot1
	slot0.skinId = slot0.heroMO.skin
	slot0.heroConfig = HeroConfig.instance:getHeroCO(slot0.heroId)
	slot0.skinConfig = SkinConfig.instance:getSkinCo(slot0.skinId)
	slot0.critterHeroConfig = CritterConfig.instance:getCritterHeroPreferenceCfg(slot0.heroId)
	slot0._prefernectType = nil
	slot0._prefernectValueNums = nil
	slot2 = slot0:getAttributeInfoMO()

	if slot0.critterHeroConfig then
		slot0._prefernectType = slot0.critterHeroConfig.preferenceType

		slot2:setAttr(slot0.critterHeroConfig.effectAttribute, 0)

		slot2.rate = slot0.critterHeroConfig.addIncrRate + 10000

		if not string.nilorempty(slot0.critterHeroConfig.preferenceValue) then
			slot0._prefernectValueNums = string.splitToNumber(slot0.critterHeroConfig.preferenceValue, "#")
		end
	end
end

function slot0.updateSkinId(slot0, slot1)
	slot0.skinId = slot1
	slot0.skinConfig = SkinConfig.instance:getSkinCo(slot0.skinId)
end

function slot0.getAttributeInfoMO(slot0)
	if not slot0._attributeInfoMO then
		slot0._attributeInfoMO = CritterAttributeInfoMO.New()

		slot0._attributeInfoMO:init()
	end

	return slot0._attributeInfoMO
end

function slot0.getPrefernectType(slot0)
	return slot0._prefernectType
end

function slot0.getPrefernectIds(slot0)
	return slot0._prefernectValueNums
end

function slot0.chcekPrefernectCritterId(slot0, slot1)
	if slot0._prefernectType == CritterEnum.PreferenceType.All then
		return true
	end

	if slot0._prefernectType == CritterEnum.PreferenceType.Catalogue then
		slot3 = CritterConfig.instance:getCritterCatalogue(slot1)

		for slot7 = 1, #slot0._prefernectValueNums do
			if slot0._prefernectValueNums[slot7] == slot3 or slot2:isHasCatalogueChildId(slot8, slot3) then
				return true
			end
		end
	elseif slot0._prefernectType == CritterEnum.PreferenceType.Critter and tabletool.indexOf(slot0._prefernectValueNums, slot1) then
		return true
	end

	return false
end

function slot0.getPrefernectName(slot0)
	if slot0._prefernectType == CritterEnum.PreferenceType.All then
		return luaLang("critter_train_hero_prefernect_all_txt")
	elseif slot0._prefernectType == CritterEnum.PreferenceType.Catalogue then
		if slot0._prefernectValueNums and #slot0._prefernectValueNums > 0 then
			return CritterConfig.instance:getCritterCatalogueCfg(slot0._prefernectValueNums[1]) and slot1.name or slot0._prefernectValueNums[1]
		end
	elseif slot0._prefernectType == CritterEnum.PreferenceType.Critter and slot0._prefernectValueNums and #slot0._prefernectValueNums > 0 then
		return CritterConfig.instance:getCritterCfg(slot0._prefernectValueNums[1]) and slot1.name or slot0._prefernectValueNums[1]
	end

	return ""
end

return slot0
