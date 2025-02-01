module("modules.logic.activity.model.chessmap.Activity109ChessModel", package.seeall)

slot0 = class("Activity109ChessModel", BaseModel)

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

	if Activity109Config.instance:getEpisodeCo(slot0._activityId, slot1) then
		slot0._currentMapId = slot2.mapId
	else
		logError("activity109_episode not found! id = " .. tostring(slot1) .. ", in act = " .. tostring(slot0._activityId))

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

function slot0.getMapId(slot0)
	return slot0._currentMapId
end

slot0.instance = slot0.New()

return slot0
