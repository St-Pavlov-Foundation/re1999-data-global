module("modules.logic.chessgame.model.ChessModel", package.seeall)

slot0 = class("ChessModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.setEpisodeId(slot0, slot1)
	slot0._currentEpisodeId = slot1

	if not slot1 then
		slot0._currentMapId = nil

		return
	end

	if ChessConfig.instance:getEpisodeCo(slot0._activityId, slot1) then
		if slot2.mapIds then
			slot0._currentMapId = slot2.mapIds
		elseif slot2.mapIds then
			slot0._currentMapId = tonumber(string.split(slot2.mapIds, "#")[1])
		end
	else
		slot0._currentMapId = nil
	end
end

function slot0.setActId(slot0, slot1)
	slot0._activityId = slot1
end

function slot0.getActId(slot0)
	return slot0._activityId
end

function slot0.getEpisodeId(slot0)
	return slot0._currentEpisodeId
end

function slot0.getCurrMapId(slot0)
	return slot0._currentMapId
end

function slot0.setNowMapIndex(slot0, slot1)
	slot0._currMapIndex = slot1
end

function slot0.getNowMapIndex(slot0)
	return slot0._currMapIndex
end

function slot0.getEpisodeData(slot0, slot1)
	if slot0:_getModelIns(slot0._activityId) then
		return slot2:getEpisodeData(slot1)
	end
end

slot0.instance = slot0.New()

return slot0
