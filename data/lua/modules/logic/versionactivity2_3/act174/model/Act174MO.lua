module("modules.logic.versionactivity2_3.act174.model.Act174MO", package.seeall)

slot0 = pureTable("Act174MO")

function slot0.initBadgeInfo(slot0, slot1)
	slot0.badgeMoDic = {}
	slot0.badgeScoreChangeDic = {}

	for slot6, slot7 in pairs(lua_activity174_badge.configDict[slot1]) do
		slot8 = Act174BadgeMO.New()

		slot8:init(slot7)

		slot0.badgeMoDic[slot6] = slot8
	end
end

function slot0.init(slot0, slot1)
	slot0.triggerList = {}
	slot0.season = slot1.season

	for slot5, slot6 in ipairs(slot1.badgeInfoList) do
		slot0.badgeMoDic[slot6.id]:update(slot6)
	end

	slot0:updateGameInfo(slot1.gameInfo)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function slot0.updateGameInfo(slot0, slot1, slot2)
	if not slot0.gameInfo then
		slot0.gameInfo = Act174GameMO.New()
	end

	slot0.gameInfo:init(slot1, slot2)
end

function slot0.updateShopInfo(slot0, slot1)
	slot0.gameInfo:updateShopInfo(slot1)
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0.gameInfo:updateTeamMo(slot1)
end

function slot0.updateIsBet(slot0, slot1)
	slot0.gameInfo:updateIsBet(slot1)
end

function slot0.triggerEffectPush(slot0, slot1, slot2)
	slot0.triggerList[#slot0.triggerList + 1] = {
		effectId = slot1,
		param = slot2
	}
end

function slot0.getTriggerList(slot0)
	return slot0.triggerList
end

function slot0.cleanTriggerEffect(slot0)
	tabletool.clear(slot0.triggerList)
end

function slot0.setEndInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.badgeInfoList) do
		slot7 = slot6.id
		slot0.badgeScoreChangeDic[slot7] = slot6.count - slot0.badgeMoDic[slot7].count

		slot0.badgeMoDic[slot7]:update(slot6)
	end

	slot0.gameEndInfo = slot1

	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateBadgeMo)
end

function slot0.getBadgeScoreChangeDic(slot0)
	return slot0.badgeScoreChangeDic
end

function slot0.clearEndInfo(slot0)
	slot0.gameEndInfo = nil

	tabletool.clear(slot0.badgeScoreChangeDic)
	slot0:cleanTriggerEffect()
end

function slot0.getGameInfo(slot0)
	return slot0.gameInfo
end

function slot0.getGameEndInfo(slot0)
	return slot0.gameEndInfo
end

function slot0.getBadgeMo(slot0, slot1)
	if not slot0.badgeMoDic[slot1] then
		logError("dont exist badgeMo" .. slot1)
	end

	return slot2
end

function slot0.getBadgeMoList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.badgeMoDic) do
		slot1[#slot1 + 1] = slot6
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot1
end

function slot0.getRuleHeroCoList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_activity174_role.configList) do
		if string.find(slot7.season, tostring(slot0.season)) then
			slot1[#slot1 + 1] = slot7
		end
	end

	return slot1
end

function slot0.getRuleCollectionCoList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_activity174_collection.configList) do
		if string.find(slot7.season, tostring(slot0.season)) then
			slot1[#slot1 + 1] = slot7
		end
	end

	return slot1
end

function slot0.getRuleBuffCoList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(lua_activity174_enhance.configList) do
		if string.find(slot7.season, tostring(slot0.season)) then
			slot1[#slot1 + 1] = slot7
		end
	end

	return slot1
end

return slot0
