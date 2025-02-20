module("modules.logic.fight.model.FightPlayCardModel", package.seeall)

slot0 = class("FightPlayCardModel", BaseModel)

function slot0.onInit(slot0)
	slot0._clientSkillOpAll = {}
	slot0._clientSkillOpList = {}
	slot0._serverSkillOpList = {}
	slot0._usedCards = {}
	slot0._curIndex = 0
end

function slot0.getCurIndex(slot0)
	return slot0._curIndex
end

function slot0.playCard(slot0, slot1)
	slot0._curIndex = slot1
end

function slot0.clearUsedCards(slot0)
	slot0._usedCards = {}
	slot0._curIndex = 0
end

function slot0.setUsedCard(slot0, slot1)
	slot0:clearUsedCards()

	for slot5, slot6 in ipairs(slot1) do
		slot7 = FightCardInfoMO.New()

		slot7:init(slot6)
		table.insert(slot0._usedCards, slot7)
	end
end

function slot0.addUseCard(slot0, slot1, slot2)
	if slot0._usedCards then
		slot3 = FightCardInfoMO.New()

		slot3:init(slot2)
		table.insert(slot0._usedCards, slot1, slot3)
	end
end

function slot0.getUsedCards(slot0)
	return slot0._usedCards
end

function slot0.updateClientOps(slot0)
	slot0._clientSkillOpAll = {}
	slot0._clientSkillOpList = {}

	for slot5, slot6 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot6:isPlayCard() then
			slot0:buildDisplayMOByOp(slot6)

			if slot6:needCopyCard() then
				slot0:buildDisplayMOByOp(slot6).isCopyCard = true
			end
		end
	end
end

function slot0.buildDisplayMOByOp(slot0, slot1)
	slot2 = FightSkillDisplayMO.New()
	slot2.entityId = slot1.belongToEntityId
	slot2.skillId = slot1.skillId
	slot2.targetId = slot1.toId

	table.insert(slot0._clientSkillOpAll, 1, slot2)
	table.insert(slot0._clientSkillOpList, 1, slot2)

	return slot2
end

function slot0.updateFightRound(slot0, slot1)
	slot0._serverSkillOpList = {}

	for slot5, slot6 in ipairs(slot1.fightStepMOs) do
		if FightDataHelper.entityMgr:getById(slot6.fromId) and slot7.side == FightEnum.EntitySide.MySide and slot9 and (slot6.actType == FightEnum.ActType.SKILL and FightCardModel.instance:isActiveSkill(slot6.fromId, slot6.actId) or false) then
			slot11 = FightSkillDisplayMO.New()
			slot11.entityId = slot6.fromId
			slot11.skillId = slot6.actId
			slot11.targetId = slot6.toId

			table.insert(slot0._serverSkillOpList, 1, slot11)
		end
	end
end

function slot0.onEndRound(slot0)
	slot0._clientSkillOpAll = {}
	slot0._clientSkillOpList = {}
	slot0._serverSkillOpList = {}
end

function slot0.checkClientSkillMatch(slot0, slot1, slot2)
	if slot0._clientSkillOpList[#slot0._clientSkillOpList] and slot3.entityId == slot1 and slot3.skillId == slot2 then
		return true
	end

	return false
end

function slot0.removeClientSkillOnce(slot0)
	return table.remove(slot0._clientSkillOpList, #slot0._clientSkillOpList)
end

function slot0.onPlayOneSkillId(slot0, slot1, slot2)
	if slot0:checkClientSkillMatch(slot1, slot2) then
		table.remove(slot0._clientSkillOpList, #slot0._clientSkillOpList)
	else
		logError("Play skill card not match: " .. slot2 .. " " .. (slot0._clientSkillOpList[#slot0._clientSkillOpList] and slot3.skillId or "nil"))
	end

	table.remove(slot0._serverSkillOpList, #slot0._serverSkillOpList)
end

function slot0.getClientSkillOpAll(slot0)
	return slot0._clientSkillOpAll
end

function slot0.getClientLeftSkillOpList(slot0)
	return slot0._clientSkillOpList
end

function slot0.clearClientLeftSkillOpList(slot0)
	slot0._clientSkillOpList = {}
end

function slot0.getServerLeftSkillOpList(slot0)
	return slot0._serverSkillOpList
end

function slot0.isPlayerHasSkillToPlay(slot0, slot1)
	if FightModel.instance:getVersion() >= 1 then
		for slot6 = slot0._curIndex + 1, #slot0._usedCards do
			if slot0._usedCards[slot6].uid == slot1 then
				return true
			end
		end

		return
	end

	for slot6, slot7 in ipairs(slot0._serverSkillOpList) do
		if slot7.entityId == slot1 then
			return true
		end
	end
end

slot0.instance = slot0.New()

return slot0
