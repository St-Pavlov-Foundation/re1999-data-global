module("modules.logic.versionactivity1_3.va3chess.model.Va3ChessModel", package.seeall)

slot0 = class("Va3ChessModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0._registerModelIns(slot0)
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Model.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Model.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Model.instance
	}
end

function slot0._getModelIns(slot0, slot1)
	if not slot0._acModelInsMap then
		slot0._acModelInsMap = slot0:_registerModelIns()
		slot2 = {
			"getEpisodeData"
		}

		for slot6, slot7 in pairs(slot0._acModelInsMap) do
			for slot11, slot12 in ipairs(slot2) do
				if not slot7[slot12] or type(slot7[slot12]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", slot7.__cname, slot12))
				end
			end
		end
	end

	if not slot0._acModelInsMap[slot1] then
		logError(string.format("棋盘小游戏Model没注册，activityId[%s]", slot1))
	end

	return slot2
end

function slot0.setEpisodeId(slot0, slot1)
	slot0._currentEpisodeId = slot1

	if not slot1 then
		slot0._currentMapId = nil

		return
	end

	if Va3ChessConfig.instance:getEpisodeCo(slot0._activityId, slot1) then
		if slot2.mapId then
			slot0._currentMapId = slot2.mapId
		elseif slot2.mapIds then
			slot0._currentMapId = tonumber(string.split(slot2.mapIds, "#")[1])
		end
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

function slot0.getEpisodeData(slot0, slot1)
	if slot0:_getModelIns(slot0._activityId) then
		return slot2:getEpisodeData(slot1)
	end
end

slot0.instance = slot0.New()

return slot0
