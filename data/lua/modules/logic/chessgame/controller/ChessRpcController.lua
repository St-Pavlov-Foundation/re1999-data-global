module("modules.logic.chessgame.controller.ChessRpcController", package.seeall)

slot0 = class("ChessRpcController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0._registerRcp(slot0)
	return {
		[VersionActivity2_1Enum.ActivityId.LanShouPa] = Activity164Rpc.instance
	}
end

function slot0._getActiviyXRcpIns(slot0, slot1)
	if not slot0._acXRcpInsMap then
		slot0._acXRcpInsMap = slot0:_registerRcp()
		slot2 = {
			"sendGetActInfoRequest",
			"sendActStartEpisodeRequest",
			"sendActReStartEpisodeRequest",
			"sendActBeginRoundRequest",
			"sendActAbortRequest",
			"sendActRollBackRequest"
		}

		for slot6, slot7 in pairs(slot0._acXRcpInsMap) do
			for slot11, slot12 in ipairs(slot2) do
				if not slot7[slot12] or type(slot7[slot12]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", slot7.__cname, slot12))
				end
			end
		end
	end

	if not slot0._acXRcpInsMap[slot1] then
		logError(string.format("棋盘小游戏Rpc没注册，activityId[%s]", slot1))
	end

	return slot2
end

function slot0.sendGetActInfoRequest(slot0, slot1, slot2, slot3)
	if slot0:_getActiviyXRcpIns(slot1) then
		slot4:sendGetActInfoRequest(slot1, slot2, slot3)
	end
end

function slot0.sendActStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	if slot0:_getActiviyXRcpIns(slot1) then
		slot5:sendActStartEpisodeRequest(slot1, slot2, slot3, slot4)
	end
end

function slot0.onReceiveActStartEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ChessController.instance:initMapData(slot2.activityId, slot2.episodeId, slot2.scene)
	end
end

function slot0.sendActReStartEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	if slot0:_getActiviyXRcpIns(slot1) then
		slot5:sendActReStartEpisodeRequest(slot1, slot2, slot3, slot4)
	end
end

function slot0.sendActBeginRoundRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:_getActiviyXRcpIns(slot1) then
		slot6:sendActBeginRoundRequest(slot1, slot2, slot3, slot4, slot5)
	end
end

function slot0.onReceiveActBeginRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end

	ChessGameModel.instance:cleanOptList()
end

function slot0.onReceiveActStepPush(slot0, slot1, slot2)
	if slot1 == 0 and Va3ChessModel.instance:getActId() == slot2.activityId and Va3ChessGameController.instance.event then
		slot3:insertStepList(slot2.steps)
	end
end

function slot0.sendActEventEndRequest(slot0, slot1, slot2, slot3)
	if slot0:_getActiviyXRcpIns(slot1) then
		slot4:sendActEventEndRequest(slot1, slot2, slot3)
	end
end

function slot0.onReceiveActEventEndReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendActAbortRequest(slot0, slot1, slot2, slot3, slot4)
	if slot0:_getActiviyXRcpIns(slot1, slot2) then
		slot5:sendActAbortRequest(slot1, slot2, slot3, slot4)
	end
end

function slot0.onReceiveActAbortReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendActRollBackRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0:_getActiviyXRcpIns(slot1) then
		slot6:sendActRollBackRequest(slot1, slot2, slot3, slot4, slot5)
	end
end

slot0.instance = slot0.New()

return slot0
