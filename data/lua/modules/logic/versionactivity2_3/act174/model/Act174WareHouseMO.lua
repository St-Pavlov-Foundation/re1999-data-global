module("modules.logic.versionactivity2_3.act174.model.Act174WareHouseMO", package.seeall)

slot0 = pureTable("Act174WareHouseMO")

function slot0.init(slot0, slot1)
	slot0.newHeroDic = {}
	slot0.newItemDic = {}
	slot0.heroId = slot1.heroId
	slot0.enhanceId = slot1.enhanceId

	slot0:caculateEnhanceRole(slot0.enhanceId)

	slot0.endEnhanceId = slot1.endEnhanceId
	slot0.itemId = slot1.itemId
end

function slot0.update(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.heroId) do
		if not tabletool.indexOf(slot0.heroId, slot6) then
			slot0.newHeroDic[slot6] = 1
		end
	end

	slot2 = uv0.getItemCntDic(slot1.itemId)

	for slot6, slot7 in ipairs(slot0.itemId) do
		if slot2[slot7] then
			slot2[slot7] = slot2[slot7] - 1

			if slot2[slot7] == 0 then
				slot2[slot7] = nil
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		if slot0.newItemDic[slot6] then
			slot0.newItemDic[slot6] = slot8 + slot7
		else
			slot0.newItemDic[slot6] = slot7
		end
	end

	slot0.heroId = slot1.heroId
	slot0.itemId = slot1.itemId
	slot0.enhanceId = slot1.enhanceId

	slot0:caculateEnhanceRole(slot0.enhanceId)

	slot0.endEnhanceId = slot1.endEnhanceId
end

function slot0.getHeroData(slot0)
	slot2 = {
		[slot6] = {
			id = slot7,
			isEquip = Activity174Model.instance:getActInfo():getGameInfo():isHeroInTeam(slot7)
		}
	}

	for slot6, slot7 in ipairs(slot0.heroId) do
		-- Nothing
	end

	table.sort(slot2, uv0.SortRoleFunc)

	return slot2
end

function slot0.getItemData(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in ipairs(slot0.itemId) do
		if not slot3[slot8] then
			slot3[slot8] = Activity174Model.instance:getActInfo():getGameInfo():getCollectionEquipCnt(slot8)
		end

		slot10 = 0

		if slot3[slot8] > 0 then
			slot10 = 1
			slot3[slot8] = slot9 - 1
		end

		slot2[slot7] = {
			id = slot8,
			isEquip = slot10
		}
	end

	table.sort(slot2, uv0.SortItemFunc)

	return slot2
end

function slot0.SortRoleFunc(slot0, slot1)
	if slot0.isEquip == slot1.isEquip then
		if Activity174Config.instance:getRoleCo(slot0.id).rare == Activity174Config.instance:getRoleCo(slot1.id).rare then
			return slot1.id < slot0.id
		else
			return slot3.rare < slot2.rare
		end
	else
		return slot1.isEquip < slot0.isEquip
	end
end

function slot0.SortItemFunc(slot0, slot1)
	if slot0.isEquip == slot1.isEquip then
		if Activity174Config.instance:getCollectionCo(slot0.id).rare == Activity174Config.instance:getCollectionCo(slot1.id).rare then
			return slot1.id < slot0.id
		else
			return slot3.rare < slot2.rare
		end
	else
		return slot1.isEquip < slot0.isEquip
	end
end

function slot0.getItemCntDic(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		if not slot1[slot6] then
			slot1[slot6] = 1
		else
			slot1[slot6] = slot1[slot6] + 1
		end
	end

	return slot1
end

function slot0.getNewIdDic(slot0, slot1)
	if slot1 == Activity174Enum.WareType.Hero then
		return tabletool.copy(slot0.newHeroDic)
	else
		return tabletool.copy(slot0.newItemDic)
	end
end

function slot0.deleteNewSign(slot0, slot1, slot2)
	slot3 = nil

	if ((slot1 ~= Activity174Enum.WareType.Hero or slot0.newHeroDic) and slot0.newItemDic)[slot2] then
		slot3[slot2] = slot3[slot2] - 1

		if slot3[slot2] == 0 then
			slot3[slot2] = nil
		end
	end
end

function slot0.clearNewSign(slot0)
	tabletool.clear(slot0.newHeroDic)
	tabletool.clear(slot0.newItemDic)
end

function slot0.caculateEnhanceRole(slot0, slot1)
	slot0.enhanceRoleList = {}
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if lua_activity174_enhance.configDict[slot7] then
			if not string.nilorempty(slot8.effects) then
				tabletool.addValues(slot2, string.splitToNumber(slot8.effects, "|"))
			end
		else
			logError("dont exist enhanceCo" .. slot7)
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		if lua_activity174_effect.configDict[slot7] then
			if slot8.type == Activity174Enum.EffectType.EnhanceRole then
				slot0.enhanceRoleList[#slot0.enhanceRoleList + 1] = tonumber(slot8.typeParam)
			end
		else
			logError("dont exist enhanceCo" .. slot7)
		end
	end
end

return slot0
