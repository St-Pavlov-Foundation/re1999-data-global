module("modules.logic.versionactivity2_3.act174.model.Act174GameMO", package.seeall)

slot0 = pureTable("Act174GameMO")

function slot0.init(slot0, slot1, slot2)
	slot0.hp = slot1.hp
	slot0.coin = slot1.coin
	slot0.gameCount = slot1.gameCount
	slot0.winCount = slot1.winCount
	slot0.score = slot1.score
	slot0.state = slot1.state
	slot0.forceBagInfo = slot1.forceBagInfo
	slot0.shopInfo = slot1.shopInfo

	slot0:updateTeamMo(slot1.teamInfo)
	slot0:updateWareHouseMo(slot1.warehouseInfo, slot2)

	slot0.fightInfo = slot1.fightInfo
	slot0.season = slot1.season
	slot0.param = slot1.param
end

function slot0.updateShopInfo(slot0, slot1)
	slot0.shopInfo = slot1
end

function slot0.updateTeamMo(slot0, slot1)
	slot0.teamMoList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = Act174TeamMO.New()

		slot7:init(slot6)

		slot0.teamMoList[slot5] = slot7
	end
end

function slot0.updateWareHouseMo(slot0, slot1, slot2)
	if slot0.warehouseMo then
		if slot2 then
			slot0.warehouseMo:update(slot1)
		else
			slot0.warehouseMo:init(slot1)
		end
	else
		slot0.warehouseMo = Act174WareHouseMO.New()

		slot0.warehouseMo:init(slot1)
	end
end

function slot0.buyInShopReply(slot0, slot1)
	slot0.shopInfo = slot1.shopInfo

	slot0.warehouseMo:clearNewSign()
	slot0.warehouseMo:update(slot1.warehouseInfo)

	slot0.coin = slot1.coin
end

function slot0.updateIsBet(slot0, slot1)
	slot0.fightInfo.betHp = slot1
end

function slot0.isInGame(slot0)
	return slot0.state ~= Activity174Enum.GameState.None
end

function slot0.getForceBagsInfo(slot0)
	return slot0.forceBagInfo
end

function slot0.getShopInfo(slot0)
	return slot0.shopInfo
end

function slot0.getTeamMoList(slot0)
	return slot0.teamMoList
end

function slot0.getWarehouseInfo(slot0)
	return slot0.warehouseMo
end

function slot0.getFightInfo(slot0)
	return slot0.fightInfo
end

function slot0.setBattleHeroInTeam(slot0, slot1, slot2, slot3)
	if not slot3.heroId and not slot3.itemId then
		slot0:delBattleHeroInTeam(slot1, slot2)

		return
	end

	if Activity174Helper.MatchKeyInArray(slot0.teamMoList, slot1, "index") then
		if Activity174Helper.MatchKeyInArray(slot4.battleHeroInfo, slot2, "index") then
			slot6.index = slot3.index
			slot6.heroId = slot3.heroId
			slot6.itemId = slot3.itemId
			slot6.priorSkill = slot3.priorSkill
		else
			table.insert(slot5, slot3)
		end
	else
		slot5 = Act174TeamMO.New()

		slot5:init({
			index = slot1,
			battleHeroInfo = {
				slot3
			}
		})
		table.insert(slot0.teamMoList, slot5)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function slot0.delBattleHeroInTeam(slot0, slot1, slot2)
	if Activity174Helper.MatchKeyInArray(slot0.teamMoList, slot1, "index") then
		if Activity174Helper.MatchKeyInArray(slot3.battleHeroInfo, slot2, "index") then
			tabletool.removeValue(slot4, slot5)
		end
	else
		logError("teamInfo dont exist" .. slot1)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function slot0.isHeroInTeam(slot0, slot1)
	for slot5 = 1, #slot0.teamMoList do
		for slot10 = 1, #slot0.teamMoList[slot5].battleHeroInfo do
			if slot6.battleHeroInfo[slot10].heroId == slot1 then
				return 1
			end
		end
	end

	return 0
end

function slot0.getCollectionEquipCnt(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.teamMoList) do
		for slot11, slot12 in ipairs(slot7.battleHeroInfo) do
			if slot12.itemId == slot1 then
				slot2 = slot2 + 1
			end
		end
	end

	return slot2
end

function slot0.exchangeTempCollection(slot0, slot1, slot2)
	slot3 = slot0.fightInfo.tempInfo
	slot5 = Activity174Helper.MatchKeyInArray(slot3, slot2, "index")

	if Activity174Helper.MatchKeyInArray(slot3, slot1, "index") and slot5 then
		slot4.index = slot2
		slot5.index = slot1
	end
end

function slot0.getTempCollectionId(slot0, slot1, slot2, slot3)
	if Activity174Helper.MatchKeyInArray(slot3 and slot0.fightInfo.matchInfo.tempInfo or slot0.fightInfo.tempInfo, slot1, "index") then
		return slot5.collectionId[slot2]
	end

	return 0
end

function slot0.getBetScore(slot0)
	slot1 = 0

	if not string.nilorempty(slot0.param) and string.find(slot0.param, "betScore") then
		slot1 = tonumber(string.split(string.split(slot0.param, "#")[1], ":")[2])
	end

	return slot1
end

return slot0
