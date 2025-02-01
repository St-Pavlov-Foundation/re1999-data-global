module("modules.logic.summon.model.SummonModel", package.seeall)

slot0 = class("SummonModel", BaseModel)

function slot0.onInit(slot0)
	slot0._summonResult = nil
	slot0._orderedSummonResult = nil
	slot0._duplicateCountList = nil
	slot0._freeEquipSummon = nil
	slot0._isEquipSendFree = nil

	slot0:setIsDrawing(false)
end

function slot0.reInit(slot0)
	slot0._summonResult = nil
	slot0._orderedSummonResult = nil
	slot0._duplicateCountList = nil
	slot0._freeEquipSummon = nil
	slot0._isEquipSendFree = nil

	slot0:setIsDrawing(false)
end

function slot0.updateSummonResult(slot0, slot1, slot2)
	slot0._summonResult = {}
	slot0._orderedSummonResult = {}
	slot0._duplicateCountList = {}

	if slot1 and #slot1 > 0 then
		for slot6, slot7 in ipairs(slot1) do
			SummonResultMO.New():init(slot7)

			if slot7.heroId and slot7.heroId ~= 0 then
				slot0._duplicateCountList[slot7.heroId] = slot0._duplicateCountList[slot7.heroId] or {}

				table.insert(slot0._duplicateCountList[slot7.heroId], slot7.duplicateCount or 0)
			end

			table.insert(slot0._summonResult, slot8)
		end

		slot3 = {
			1,
			10,
			2,
			9,
			3,
			8,
			4,
			7,
			5,
			6
		}
		slot4 = {}

		for slot8 = 1, #slot0._summonResult do
			table.insert(slot4, slot0._summonResult[slot8])
		end

		uv0.sortResult(slot4, slot2)

		slot0._orderedSummonResult = {}

		for slot8 = 1, #slot4 do
			slot0._orderedSummonResult[slot3[slot8]] = slot4[slot8]
		end
	end
end

function slot0.sortResult(slot0, slot1)
	if SummonConfig.poolIsLuckyBag(slot1) then
		table.sort(slot0, uv0.sortResultLuckyBag)
	else
		table.sort(slot0, uv0.sortResultByRare)
	end
end

function slot0.sortResultByRare(slot0, slot1)
	if slot0.heroId ~= 0 and slot1.heroId ~= 0 then
		if HeroConfig.instance:getHeroCO(slot0.heroId).rare ~= HeroConfig.instance:getHeroCO(slot1.heroId).rare then
			return slot3.rare < slot2.rare
		else
			return slot3.id < slot2.id
		end
	elseif EquipConfig.instance:getEquipCo(slot0.equipId).rare ~= EquipConfig.instance:getEquipCo(slot1.equipId).rare then
		return slot3.rare < slot2.rare
	else
		return slot3.id < slot2.id
	end
end

function slot0.sortHeroIsResultByRare(slot0, slot1)
	if slot0 ~= 0 and slot1 ~= 0 then
		if HeroConfig.instance:getHeroCO(slot0).rare ~= HeroConfig.instance:getHeroCO(slot1).rare then
			return slot3.rare < slot2.rare
		else
			return slot3.id < slot2.id
		end
	elseif EquipConfig.instance:getEquipCo(slot0).rare ~= EquipConfig.instance:getEquipCo(slot1).rare then
		return slot3.rare < slot2.rare
	else
		return slot3.id < slot2.id
	end
end

function slot0.sortResultByHeroIds(slot0)
	slot1 = {
		1,
		10,
		2,
		9,
		3,
		8,
		4,
		7,
		5,
		6
	}
	slot2 = {}

	for slot6 = 1, #slot0 do
		table.insert(slot2, slot0[slot6])
	end

	table.sort(slot0, uv0.sortHeroIsResultByRare)

	slot0 = {
		[slot1[slot6]] = slot2[slot6]
	}

	for slot6 = 1, #slot2 do
	end
end

function slot0.sortResultLuckyBag(slot0, slot1)
	if slot0:isLuckyBag() ~= slot1:isLuckyBag() then
		return slot2
	elseif slot2 then
		return slot0.luckyBagId < slot1.luckyBagId
	else
		return uv0.sortResultByRare(slot0, slot1)
	end
end

function slot0.getSummonResult(slot0, slot1)
	if slot1 then
		return slot0._orderedSummonResult
	else
		return slot0._summonResult
	end
end

function slot0.openSummonResult(slot0, slot1)
	if slot0:getSummonResult(true) and slot2[slot1] and not slot2[slot1]:isOpened() then
		slot3 = slot2[slot1]

		slot3:setOpen()

		slot4 = -1
		slot5 = 0

		if not slot3:isLuckyBag() then
			slot6 = slot0._duplicateCountList[slot3.heroId] or {}

			for slot10 = 1, #slot6 do
				if slot6[slot10] < slot4 or slot4 < 0 then
					slot4 = slot6[slot10]
					slot5 = slot10
				end
			end

			if slot5 > 0 then
				table.remove(slot6, slot5)
			end
		end

		return slot3, slot4
	end
end

function slot0.openSummonEquipResult(slot0, slot1)
	if slot0:getSummonResult(true) and slot2[slot1] and not slot2[slot1]:isOpened() then
		slot3 = slot2[slot1]

		slot3:setOpen()

		return slot3, slot3.isNew
	end
end

function slot0.isAllOpened(slot0)
	if not slot0._summonResult or #slot0._summonResult <= 0 then
		return true
	end

	for slot4, slot5 in ipairs(slot0._summonResult) do
		if not slot5:isOpened() then
			return false
		end
	end

	return true
end

function slot0.setFreeEquipSummon(slot0, slot1)
	slot0._freeEquipSummon = slot1
end

function slot0.getFreeEquipSummon(slot0)
	return slot0._freeEquipSummon
end

function slot0.setSendEquipFreeSummon(slot0, slot1)
	slot0._isEquipSendFree = slot1
end

function slot0.getSendEquipFreeSummon(slot0)
	return slot0._isEquipSendFree
end

function slot0.getBestRare(slot0)
	if not slot0 then
		return 2
	end

	for slot5, slot6 in pairs(slot0) do
		slot7 = 2

		if slot6.heroId and slot6.heroId ~= 0 then
			slot7 = HeroConfig.instance:getHeroCO(slot6.heroId).rare
		elseif slot6.equipId and slot6.equipId ~= 0 then
			slot7 = EquipConfig.instance:getEquipCo(slot6.equipId).rare
		elseif slot6.luckyBagId and slot6.luckyBagId ~= 0 then
			slot7 = SummonEnum.LuckyBagRare
		end

		slot1 = math.max(slot1, slot7)
	end

	return slot1
end

function slot0.getRewardList(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot7 = 1, #slot0 do
		slot9 = nil
		slot9 = (slot0[slot7].heroId == 0 or SummonConfig.instance:getRewardItems(slot8.heroId, slot8.duplicateCount, slot1)) and uv0.getEquipRewardItem(slot8)

		for slot13 = 1, #slot9 do
			slot14 = slot9[slot13]
			slot3[slot14.type] = slot3[slot14.type] or {}
			slot3[slot14.type][slot14.id] = (slot3[slot14.type][slot14.id] or 0) + slot14.quantity
		end
	end

	for slot7, slot8 in pairs(slot3) do
		for slot12, slot13 in pairs(slot8) do
			slot14 = MaterialDataMO.New()

			slot14:initValue(slot7, slot12, slot13)

			slot14.config = ItemModel.instance:getItemConfig(slot7, slot12)

			table.insert(slot2, slot14)
		end
	end

	return slot2
end

function slot0.appendRewardTicket(slot0, slot1, slot2)
	if #slot0 > 0 then
		slot4 = MaterialDataMO.New()

		slot4:initValue(MaterialEnum.MaterialType.Item, slot2, slot3)

		slot4.config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, slot2)

		table.insert(slot1, slot4)
	end
end

function slot0.getEquipRewardItem(slot0)
	slot1 = {}

	if slot0.returnMaterials then
		for slot5, slot6 in ipairs(slot0.returnMaterials) do
			table.insert(slot1, {
				type = slot6.materilType,
				id = slot6.materilId,
				quantity = slot6.quantity
			})
		end
	end

	return slot1
end

function slot0.sortRewards(slot0, slot1)
	slot2 = nil

	if slot0.config.rare == slot1.config.rare then
		return nil
	else
		slot2 = slot1.config.rare < slot0.config.rare
	end

	if slot2 ~= nil then
		return slot2
	end

	if ((slot0.materilType ~= slot1.materilType or nil) and slot1.materilType < slot0.materilType) ~= nil then
		return slot2
	end

	return (slot0.materilId ~= slot1.materilId or nil) and slot1.materilId < slot0.materilId
end

function slot0.formatRemainTime(slot0)
	if slot0 <= 0 then
		return string.format(luaLang("summonmain_deadline_time_min"), 0, 0)
	end

	slot0 = math.floor(slot0)

	if math.floor(slot0 / 86400) > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time_day"), {
			slot1,
			math.floor(slot0 % 86400 / 3600),
			math.floor(slot0 % 3600 / 60)
		})
	elseif slot2 < 1 and slot3 < 1 then
		return luaLang("summonmain_deadline_time_min")
	else
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			slot2,
			slot3
		})
	end
end

function slot0.setIsDrawing(slot0, slot1)
	slot0._isDrawing = slot1
end

function slot0.getIsDrawing(slot0)
	return slot0._isDrawing
end

slot0.instance = slot0.New()

return slot0
