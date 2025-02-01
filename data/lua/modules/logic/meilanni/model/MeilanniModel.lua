module("modules.logic.meilanni.model.MeilanniModel", package.seeall)

slot0 = class("MeilanniModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clear()
end

function slot0.reInit(slot0)
	slot0:_clear()
end

function slot0._clear(slot0)
	slot0._mapInfoList = {}
	slot0._curMapId = nil
end

function slot0.setCurMapId(slot0, slot1)
	slot0._curMapId = slot1
end

function slot0.getCurMapId(slot0)
	return slot0._curMapId
end

function slot0.setBattleElementId(slot0, slot1)
	slot0._battleElementId = slot1
end

function slot0.getBattleElementId(slot0)
	return slot0._battleElementId
end

function slot0.updateMapList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:updateMapInfo(slot6)
	end
end

function slot0.updateMapInfo(slot0, slot1)
	slot2 = slot0._mapInfoList[slot1.mapId] or MeilanniMapInfoMO.New()

	slot2:init(slot1)

	slot0._mapInfoList[slot1.mapId] = slot2
end

function slot0.updateMapExcludeRules(slot0, slot1)
	if slot0._mapInfoList[slot1.mapId] then
		slot2:updateExcludeRules(slot1)
	end
end

function slot0.getMapInfo(slot0, slot1)
	return slot0._mapInfoList[slot1]
end

function slot0.getMapHighestScore(slot0, slot1)
	return slot0._mapInfoList[slot1] and slot2.highestScore or 0
end

function slot0.updateEpisodeInfo(slot0, slot1)
	if slot0:getMapInfo(slot1.mapId) then
		slot3:updateEpisodeInfo(slot1)
	end
end

function slot0.getEventInfo(slot0, slot1, slot2)
	return slot0:getMapInfo(slot1) and slot3:getEventInfo(slot2)
end

function slot0.getMapIdByBattleId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._mapInfoList) do
		if slot6:getEpisodeByBattleId(slot1) then
			return slot6.mapId
		end
	end
end

function slot0.setDialogItemFadeIndex(slot0, slot1)
	slot0._dialogItemFadeIndex = slot1
end

function slot0.getDialogItemFadeIndex(slot0)
	if slot0._dialogItemFadeIndex and slot0._dialogItemFadeIndex >= 0 then
		slot0._dialogItemFadeIndex = slot0._dialogItemFadeIndex + 1
	end

	return slot0._dialogItemFadeIndex
end

function slot0.setStatResult(slot0, slot1)
	slot0.statResult = slot1
end

function slot0.getStatResult(slot0)
	return slot0.statResult
end

slot0.instance = slot0.New()

return slot0
