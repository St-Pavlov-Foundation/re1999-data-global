module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

slot0 = class("FightHandCardDataMgr")

function slot0.ctor(slot0)
	slot0.handCard = {}
	slot0.redealCardProto = {}
end

function slot0.coverHandCard(slot0, slot1)
	tabletool.clear(slot0.handCard)

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.handCard, FightHelper.deepCopySimpleWithMeta(slot6))
	end
end

function slot0.cacheDistributeCard(slot0, slot1)
	slot0.beforeCards1 = slot1.beforeCards1
	slot0.teamACards1 = slot1.teamACards1
	slot0.beforeCards2 = slot1.beforeCards2
	slot0.teamACards2 = slot1.teamACards2
end

function slot0.cacheRedealProto(slot0, slot1)
	table.insert(slot0.redealCardProto, slot1)
end

function slot0.getRedealProto(slot0)
	return table.remove(slot0.redealCardProto, 1)
end

function slot0.getHandCard(slot0)
	return slot0.handCard
end

function slot0.distribute(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		slot9 = FightCardInfoMO.New()

		slot9:init(slot8)
		table.insert(slot3, slot9)
	end

	slot4 = true

	if #slot3 ~= #slot0.handCard then
		slot4 = false
	else
		slot5, slot6, slot7, slot8 = FightHelper.compareData(slot3, slot0.handCard)

		if not slot5 then
			slot4 = false
		end
	end

	if not slot4 then
		tabletool.clear(slot0.handCard)
		tabletool.addValues(slot0.handCard, slot3)
	end

	for slot8, slot9 in ipairs(slot2) do
		slot10 = FightCardInfoMO.New()

		slot10:init(slot9)
		table.insert(slot0.handCard, slot10)
	end

	uv0.combineCardList(slot0.handCard)
end

function slot0.combineCardList(slot0)
	slot1 = 1

	while true do
		if uv0.canCombineCard(slot0[slot1], slot0[slot1 + 1]) then
			slot3 = slot0[slot1]
			slot3.skillId = FightCardModel.instance:getSkillNextLvId(slot3.uid, slot3.skillId)
			slot3.tempCard = false

			uv0.enchantsAfterCombine(slot3, table.remove(slot0, slot1 + 1))
		else
			slot1 = slot1 + 1
		end

		if slot1 >= #slot0 then
			break
		end
	end

	return slot0
end

function slot0.canCombineCard(slot0, slot1)
	if not slot0 or not slot1 then
		return false
	end

	if FightEnum.UniversalCard[slot0.skillId] or FightEnum.UniversalCard[slot1.skillId] then
		return true
	end

	if uv0.isSpecialCard(slot0) or uv0.isSpecialCard(slot1) then
		return false
	end

	if slot0.uid ~= slot1.uid then
		return false
	end

	if slot0.skillId ~= slot1.skillId then
		return false
	end

	slot3 = lua_skill.configDict[slot1.skillId]

	if not lua_skill.configDict[slot0.skillId] or not slot3 then
		return false
	end

	if slot2.isBigSkill == 1 or slot3.isBigSkill == 1 then
		return false
	end

	if not FightCardModel.instance:getSkillNextLvId(slot0.uid, slot0.skillId) then
		return false
	end

	return true
end

function slot0.canCombineWithUniversal(slot0, slot1)
	if not slot0 or not slot1 then
		return false
	end

	if uv0.isSpecialCard(slot1) then
		return false
	end

	if slot1.skillId == FightEnum.UniversalCard1 or slot2 == FightEnum.UniversalCard2 then
		return false
	end

	if slot0.skillId == FightEnum.UniversalCard1 then
		if FightCardModel.instance:getSkillLv(slot1.uid, slot2) ~= 1 then
			return false
		end
	elseif slot0.skillId == FightEnum.UniversalCard2 and slot3 ~= 1 and slot3 ~= 2 then
		return false
	end

	return true
end

function slot0.enchantsAfterCombine(slot0, slot1)
	for slot6, slot7 in ipairs(slot1.enchants) do
		if uv0.canAddEnchant(slot0, slot7.enchantId) then
			uv0.addEnchant(slot0.enchants or {}, slot7)
		end
	end
end

function slot0.canAddEnchant(slot0, slot1)
	slot3 = uv0.excludeEnchants(slot1)
	slot4 = true

	for slot8, slot9 in ipairs(slot0.enchants or {}) do
		if slot9.enchantId == slot1 then
			return true
		end

		if uv0.rejectEnchant(slot9, slot1) then
			return false
		end

		if slot3[slot9.enchantId] then
			slot4 = false
		end
	end

	if slot4 then
		return #slot2 < FightEnum.EnchantNumLimit
	end

	return true
end

function slot0.addEnchant(slot0, slot1)
	for slot7 = #slot0, 1, -1 do
		if uv0.excludeEnchants(slot1.enchantId)[slot0[slot7].enchantId] then
			table.remove(slot0, slot7)
		end
	end

	slot4 = false

	for slot8, slot9 in ipairs(slot0) do
		if slot9.enchantId == slot2 then
			slot4 = true

			if slot9.duration == -1 or slot1.duration == -1 then
				slot9.duration = -1
			else
				slot9.duration = math.max(slot9.duration, slot1.duration)
			end
		end
	end

	if not slot4 then
		table.insert(slot0, slot1)
	end
end

function slot0.excludeEnchants(slot0)
	slot2 = {}

	if not string.nilorempty(lua_card_enchant.configDict[slot0].excludeTypes) then
		for slot7, slot8 in ipairs(string.splitToNumber(slot1.excludeTypes, "#")) do
			slot2[slot8] = true
		end
	end

	return slot2
end

function slot0.rejectEnchant(slot0, slot1)
	for slot8, slot9 in ipairs(string.splitToNumber(lua_card_enchant.configDict[slot0.enchantId].rejectTypes, "#")) do
		if slot9 == lua_card_enchant.configDict[slot1].id then
			return true
		end
	end
end

function slot0.isFrozenCard(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Frozen then
			return true
		end
	end
end

function slot0.isBurnCard(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Burn then
			return true
		end
	end
end

function slot0.isChaosCard(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Chaos then
			return true
		end
	end
end

function slot0.isDiscard(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Discard then
			return true
		end
	end
end

function slot0.isBlockade(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Blockade then
			return true
		end
	end
end

function slot0.isPrecision(slot0)
	for slot5, slot6 in ipairs(slot0.enchants or {}) do
		if slot6.enchantId == FightEnum.EnchantedType.Precision then
			return true
		end
	end
end

function slot0.isSpecialCard(slot0)
	if not slot0 then
		return
	end

	return uv0.isSpecialCardById(slot0.uid, slot0.skillId)
end

function slot0.isSpecialCardById(slot0, slot1)
	if (slot0 == FightEntityScene.MySideId or slot0 == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[slot1] then
		return true
	end
end

function slot0.isNoCostSpecialCard(slot0)
	if not slot0 then
		return
	end

	if uv0.isSpecialCard(slot0) and slot0.cardType ~= FightEnum.CardType.ROUGE_SP and slot0.cardType ~= FightEnum.CardType.USE_ACT_POINT then
		return true
	end
end

function slot0.canPlayCard(slot0)
	if not slot0 then
		return false
	end

	if FightCardMOHelper.isFrozenCard(slot0) then
		return false
	end

	if FightCardMOHelper.isBlockade(slot0) and slot0.custom_handCardIndex then
		return slot1 == 1 or slot1 == #FightCardModel.instance:getHandCards()
	end

	return true
end

function slot0.canMoveCard(slot0)
	if not slot0 then
		return false
	end

	if uv0.isSpecialCard(slot0) then
		return false
	end

	if uv0.isFrozenCard(slot0) then
		return false
	end

	return true
end

function slot0.playCanAddExpoint(slot0, slot1)
	if not slot1 then
		return false
	end

	if uv0.isSpecialCard(slot1) then
		return false
	end

	return true
end

function slot0.moveCanAddExpoint(slot0, slot1)
	if not slot1 then
		return false
	end

	if FightEnum.UniversalCard[slot1.skillId] then
		return false
	end

	if FightCardModel.instance:isUnlimitMoveCard() then
		return false
	end

	if FightCardModel.instance:getCardMO().extraMoveAct > 0 and slot2 > #FightCardModel.instance:getMoveCardOpCostActList() then
		return false
	end

	return true
end

function slot0.combineCanAddExpoint(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return false
	end

	return true
end

function slot0.allFrozenCard(slot0)
	for slot5, slot6 in ipairs(slot0) do
		if uv0.isFrozenCard(slot6) then
			slot1 = 0 + 1
		end
	end

	return slot1 == #slot0
end

function slot0.composeCards(slot0, slot1)
	slot2, slot3, slot4 = FightCardModel.calcCardsAfterCombine(slot0, slot1)

	FightCardModel.instance:coverCard(slot2)
	FightController.instance:dispatchEvent(FightEvent.CardsCompose)

	return slot4
end

function slot0.calcRemoveCardTime(slot0, slot1, slot2)
	slot3 = 0.033
	slot5 = #slot0
	slot6 = #slot1

	for slot10, slot11 in ipairs(slot1) do
		if slot11 < slot5 then
			slot4 = (slot2 or 1.2) + slot3 * 7 + 3 * slot3 * (slot5 - slot1[slot6] - slot6)

			break
		end
	end

	return slot4
end

function slot0.calcRemoveCardTime2(slot0, slot1, slot2)
	slot3 = 0.033
	slot4 = slot2 or 1.2
	slot5 = tabletool.copy(slot0)

	for slot9, slot10 in ipairs(slot1) do
		table.remove(slot5, slot10)
	end

	for slot9, slot10 in ipairs(slot5) do
		if slot10 ~= slot0[slot9] then
			slot4 = slot4 + slot3 * 7 + 3 * slot3 * (#slot5 - slot9)

			break
		end
	end

	return slot4
end

function slot0.cardChangeIsMySide(slot0)
	if FightModel.instance:getVersion() >= 1 then
		if not slot0 then
			return false
		end

		if slot0 and slot0.teamType ~= FightEnum.TeamType.MySide then
			return false
		end
	end

	return true
end

return slot0
