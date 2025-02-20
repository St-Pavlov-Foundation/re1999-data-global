module("modules.logic.fight.model.datahelper.FightCardDataHelper", package.seeall)

return {
	combineCardList = function (slot0)
		slot1 = 1

		while not false do
			slot3 = false

			while true do
				if uv0.canCombineCard(slot0[slot1], slot0[slot1 + 1]) then
					slot5 = slot0[slot1]
					slot5.skillId = FightCardModel.instance:getSkillNextLvId(slot5.uid, slot5.skillId)
					slot5.tempCard = false

					uv0.enchantsAfterCombine(slot5, table.remove(slot0, slot1 + 1))

					slot3 = true
				else
					slot1 = slot1 + 1
				end

				if slot1 >= #slot0 then
					break
				end
			end

			if not slot3 then
				slot2 = true
			else
				slot1 = 1
			end
		end

		return slot0
	end,
	canCombineCard = function (slot0, slot1)
		if not slot0 or not slot1 then
			return false
		end

		if FightEnum.UniversalCard[slot0.skillId] or FightEnum.UniversalCard[slot1.skillId] then
			return false
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
	end,
	canCombineWithUniversal = function (slot0, slot1)
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
	end,
	enchantsAfterCombine = function (slot0, slot1)
		for slot6, slot7 in ipairs(slot1.enchants) do
			if uv0.canAddEnchant(slot0, slot7.enchantId) then
				uv0.addEnchant(slot0.enchants or {}, slot7)
			end
		end
	end,
	canAddEnchant = function (slot0, slot1)
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
	end,
	addEnchant = function (slot0, slot1)
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
	end,
	excludeEnchants = function (slot0)
		slot2 = {}

		if not string.nilorempty(lua_card_enchant.configDict[slot0].excludeTypes) then
			for slot7, slot8 in ipairs(string.splitToNumber(slot1.excludeTypes, "#")) do
				slot2[slot8] = true
			end
		end

		return slot2
	end,
	rejectEnchant = function (slot0, slot1)
		for slot8, slot9 in ipairs(string.splitToNumber(lua_card_enchant.configDict[slot0.enchantId].rejectTypes, "#")) do
			if slot9 == lua_card_enchant.configDict[slot1].id then
				return true
			end
		end
	end,
	isFrozenCard = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Frozen then
				return true
			end
		end
	end,
	isBurnCard = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Burn then
				return true
			end
		end
	end,
	isChaosCard = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Chaos then
				return true
			end
		end
	end,
	isDiscard = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Discard then
				return true
			end
		end
	end,
	isBlockade = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Blockade then
				return true
			end
		end
	end,
	isPrecision = function (slot0)
		for slot5, slot6 in ipairs(slot0.enchants or {}) do
			if slot6.enchantId == FightEnum.EnchantedType.Precision then
				return true
			end
		end
	end,
	isSpecialCard = function (slot0)
		if not slot0 then
			return
		end

		return uv0.isSpecialCardById(slot0.uid, slot0.skillId)
	end,
	isSpecialCardById = function (slot0, slot1)
		if (slot0 == FightEntityScene.MySideId or slot0 == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[slot1] then
			return true
		end
	end,
	isNoCostSpecialCard = function (slot0)
		if not slot0 then
			return
		end

		if uv0.isSpecialCard(slot0) and slot0.cardType ~= FightEnum.CardType.ROUGE_SP and slot0.cardType ~= FightEnum.CardType.USE_ACT_POINT then
			return true
		end
	end,
	canPlayCard = function (slot0)
		if not slot0 then
			return false
		end

		if uv0.isFrozenCard(slot0) then
			return false
		end

		if uv0.isBlockade(slot0) and slot0.custom_handCardIndex then
			return slot1 == 1 or slot1 == #FightCardModel.instance:getHandCards()
		end

		return true
	end,
	canMoveCard = function (slot0)
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
	end,
	playCanAddExpoint = function (slot0, slot1)
		if not slot1 then
			return false
		end

		if uv0.isSpecialCard(slot1) then
			return false
		end

		return true
	end,
	moveCanAddExpoint = function (slot0, slot1)
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
	end,
	combineCanAddExpoint = function (slot0, slot1, slot2)
		if not slot1 or not slot2 then
			return false
		end

		return true
	end,
	allFrozenCard = function (slot0)
		for slot5, slot6 in ipairs(slot0) do
			if uv0.isFrozenCard(slot6) then
				slot1 = 0 + 1
			end
		end

		return slot1 == #slot0
	end,
	composeCards = function (slot0, slot1)
		slot2, slot3, slot4 = FightCardModel.calcCardsAfterCombine(slot0, slot1)

		FightCardModel.instance:coverCard(slot2)
		FightController.instance:dispatchEvent(FightEvent.CardsCompose)

		return slot4
	end,
	calcRemoveCardTime = function (slot0, slot1, slot2)
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
	end,
	calcRemoveCardTime2 = function (slot0, slot1, slot2)
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
	end,
	cardChangeIsMySide = function (slot0)
		if FightModel.instance:getVersion() >= 1 then
			if not slot0 then
				return false
			end

			if slot0 and slot0.teamType ~= FightEnum.TeamType.MySide then
				return false
			end
		end

		return true
	end,
	newCardList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insert(slot1, FightCardData.New(slot6))
		end

		return slot1
	end,
	newPlayCardList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insert(slot1, FightClientPlayCardData.New(slot6, slot5))
		end

		return slot1
	end
}
