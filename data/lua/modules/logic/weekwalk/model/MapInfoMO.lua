module("modules.logic.weekwalk.model.MapInfoMO", package.seeall)

slot0 = pureTable("MapInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.sceneId = slot1.sceneId
	slot0.isFinish = slot1.isFinish
	slot0.isFinished = slot1.isFinished
	slot0.buffId = slot1.buffId
	slot0.isShowBuff = slot1.isShowBuff
	slot0.isShowFinished = slot1.isShowFinished
	slot0.isShowSelectCd = slot1.isShowSelectCd
	slot0.battleIds = {}
	slot0.battleInfos = {}
	slot0.battleInfoMap = {}

	for slot5, slot6 in ipairs(slot1.battleInfos) do
		if not slot0.battleInfoMap[slot6.battleId] then
			slot7 = BattleInfoMO.New()

			slot7:init(slot6)
			slot7:setIndex(slot5)
			table.insert(slot0.battleIds, slot6.battleId)
			table.insert(slot0.battleInfos, slot7)

			slot0.battleInfoMap[slot7.battleId] = slot7
		end
	end

	slot0.elementInfos = {}
	slot0.elementInfoMap = {}

	for slot5, slot6 in ipairs(slot1.elementInfos) do
		slot7 = WeekwalkElementInfoMO.New()

		slot7:init(slot6)
		slot7:setMapInfo(slot0)
		table.insert(slot0.elementInfos, slot7)

		slot0.elementInfoMap[slot7.elementId] = slot7
	end

	slot0._heroInfos = {}
	slot0._heroInfoList = {}

	if slot1.heroInfos then
		for slot5, slot6 in ipairs(slot1.heroInfos) do
			slot7 = WeekwalkHeroInfoMO.New()

			slot7:init(slot6)

			slot0._heroInfos[slot6.heroId] = slot7

			table.insert(slot0._heroInfoList, slot7)
		end
	end

	slot0._storyIds = {}

	for slot5, slot6 in ipairs(slot1.storyIds) do
		slot0._storyIds[slot6] = slot6
	end

	slot0._mapConfig = WeekWalkConfig.instance:getMapConfig(slot0.id)

	if slot0._mapConfig then
		slot0._typeConfig = lua_weekwalk_type.configDict[slot0._mapConfig.type]
	end
end

function slot0.getBattleInfoByIndex(slot0, slot1)
	return slot0.battleInfos[slot1]
end

function slot0.getLayer(slot0)
	return slot0._mapConfig.layer
end

function slot0.getMapConfig(slot0)
	return slot0._mapConfig
end

function slot0.storyIsFinished(slot0, slot1)
	return slot0._storyIds[slot1]
end

function slot0.getElementInfo(slot0, slot1)
	return slot0.elementInfoMap[slot1]
end

function slot0.getBattleInfo(slot0, slot1)
	return slot0.battleInfoMap[slot1]
end

function slot0.getHasStarIndex(slot0)
	for slot4 = #slot0.battleInfos, 1, -1 do
		if slot0.battleInfos[slot4].star > 0 then
			return slot4
		end
	end

	return 0
end

function slot0.getStarInfo(slot0)
	for slot5, slot6 in ipairs(slot0.battleInfos) do
		slot1 = 0 + slot6.maxStar
	end

	return slot1, #slot0.battleInfos * slot0._typeConfig.starNum
end

function slot0.getCurStarInfo(slot0)
	for slot5, slot6 in ipairs(slot0.battleInfos) do
		slot1 = 0 + slot6.star
	end

	return slot1, #slot0.battleInfos * slot0._typeConfig.starNum
end

function slot0.getStarNumConfig(slot0)
	return slot0._typeConfig.starNum
end

function slot0.getNoStarBattleInfo(slot0)
	for slot4, slot5 in ipairs(slot0.battleInfos) do
		if slot5.star <= 0 then
			return slot5
		end
	end
end

function slot0.getNoStarBattleIndex(slot0)
	for slot4, slot5 in ipairs(slot0.battleInfos) do
		if slot5.maxStar <= 0 then
			return slot4
		end
	end

	return #slot0.battleInfos
end

function slot0.getHeroInfoList(slot0)
	return slot0._heroInfoList
end

function slot0.getHeroCd(slot0, slot1)
	return slot0._heroInfos[slot1] and slot2.cd or 0
end

function slot0.clearHeroCd(slot0, slot1)
	slot0.isShowSelectCd = false

	for slot5, slot6 in ipairs(slot1) do
		slot0._heroInfos[slot6] = nil
	end
end

return slot0
