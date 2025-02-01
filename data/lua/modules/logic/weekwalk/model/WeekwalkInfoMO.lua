module("modules.logic.weekwalk.model.WeekwalkInfoMO", package.seeall)

slot0 = pureTable("WeekwalkInfoMO")

function slot0.init(slot0, slot1)
	slot0.time = slot1.time
	slot0.endTime = slot1.endTime
	slot0.maxLayer = slot1.maxLayer
	slot0.issueId = slot1.issueId
	slot0.isPopDeepRule = slot1.isPopDeepRule
	slot0.isOpenDeep = slot1.isOpenDeep
	slot0.isPopShallowSettle = slot1.isPopShallowSettle
	slot0.isPopDeepSettle = slot1.isPopDeepSettle
	slot0.deepProgress = slot1.deepProgress
	slot0._mapInfos = {}
	slot0._mapInfosMap = {}

	if slot1.mapInfo then
		for slot5, slot6 in ipairs(slot1.mapInfo) do
			slot7 = MapInfoMO.New()

			slot7:init(slot6)

			slot0._mapInfosMap[slot6.id] = slot7

			table.insert(slot0._mapInfos, slot7)
		end
	end

	table.sort(slot0._mapInfos, uv0._sort)
end

function slot0._sort(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.getMapInfos(slot0)
	return slot0._mapInfos
end

function slot0.getNotFinishedMap(slot0)
	slot1 = #slot0._mapInfos

	return slot0._mapInfos[slot1], slot1
end

function slot0.getNameIndexByBattleId(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0._mapInfos) do
		if slot7:getBattleInfo(slot1) then
			slot2 = slot7

			break
		end
	end

	if not slot2 then
		return
	end

	for slot6, slot7 in ipairs(lua_weekwalk.configList) do
		if slot7.id == slot2.id then
			return lua_weekwalk_scene.configDict[slot2.sceneId].battleName, slot7.layer
		end
	end
end

function slot0.getMapInfo(slot0, slot1)
	return slot0._mapInfosMap[slot1]
end

function slot0.getMapInfoByLayer(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._mapInfos) do
		if slot6:getLayer() == slot1 then
			return slot6
		end
	end
end

return slot0
