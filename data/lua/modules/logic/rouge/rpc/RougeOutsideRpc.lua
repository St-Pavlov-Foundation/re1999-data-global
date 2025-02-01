module("modules.logic.rouge.rpc.RougeOutsideRpc", package.seeall)

slot0 = class("RougeOutsideRpc", BaseRpc)

function slot0.sendGetRougeOutSideInfoRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()
	slot4.season = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetRougeOutsideInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeOutsideModel.instance:onReceiveGetRougeOutsideInfoReply(slot2)
	RougeTalentModel.instance:setOutsideInfo(slot2.rougeInfo)
	RougeRewardModel.instance:setReward(slot2.rougeInfo)
	RougeDLCModel101.instance:initLimiterInfo(slot2.rougeInfo)
end

function slot0.sendRougeActiveGeniusRequest(slot0, slot1, slot2)
	slot3 = RougeOutsideModule_pb.RougeActiveGeniusRequest()
	slot3.season = slot1
	slot3.geniusId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeActiveGeniusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeTalentModel.instance:updateGeniusIDs(slot2)
end

function slot0.onReceiveRougeUpdateGeniusPointPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeTalentModel.instance:setOutsideInfo(slot2)
end

function slot0.sendRougeReceivePointBonusRequest(slot0, slot1, slot2)
	slot3 = RougeOutsideModule_pb.RougeReceivePointBonusRequest()
	slot3.season = slot1
	slot3.bonusId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeReceivePointBonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if slot2.bonusId and slot2.bonusStage then
		RougeRewardModel.instance:updateReward(slot2.bonusStage)
		RougeController.instance:dispatchEvent(RougeEvent.OnGetRougeReward, slot2.bonusId)
	else
		RougeRewardModel.instance:setReward(slot2)
	end
end

function slot0.onReceiveRougeUpdatePointPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeRewardModel.instance:setReward(slot2)
end

function slot0.sendRougeGetUnlockCollectionsRequest(slot0, slot1, slot2, slot3)
	slot4 = RougeOutsideModule_pb.RougeGetUnlockCollectionsRequest()
	slot4.season = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRougeGetUnlockCollectionsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeFavoriteModel.instance:initUnlockCollectionIds(slot2.unlockCollectionIds)
end

function slot0.sendRougeGetNewReddotInfoRequest(slot0, slot1)
	slot2 = RougeOutsideModule_pb.RougeGetNewReddotInfoRequest()
	slot2.season = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeGetNewReddotInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeFavoriteModel.instance:initReddots(slot2.newReddots)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function slot0.sendRougeMarkNewReddotRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = RougeOutsideModule_pb.RougeMarkNewReddotRequest()
	slot6.season = slot1
	slot6.type = slot2
	slot6.id = slot3

	slot0:sendMsg(slot6, slot4, slot5)

	if slot3 == 0 then
		RougeFavoriteModel.instance:deleteReddotId(slot2, slot3)
		RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
	end
end

function slot0.onReceiveRougeMarkNewReddotReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.type

	if slot2.id == 0 then
		return
	end

	RougeFavoriteModel.instance:deleteReddotId(slot4, slot5)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateFavoriteReddot)
end

function slot0.sendRougeMarkGeniusNewStageRequest(slot0, slot1)
	slot2 = RougeOutsideModule_pb.RougeMarkGeniusNewStageRequest()
	slot2.season = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeMarkGeniusNewStageReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeTalentModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentTreeInfo)
end

function slot0.sendRougeMarkBonusNewStageRequest(slot0, slot1)
	slot2 = RougeOutsideModule_pb.RougeMarkBonusNewStageRequest()
	slot2.season = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveRougeMarkBonusNewStageReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	RougeRewardModel.instance:setNewStage(false)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeRewardInfo)
end

function slot0.onReceiveRougeReddotUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.newReddots
end

function slot0.sendRougeUnlockStoryRequest(slot0, slot1, slot2)
	slot3 = RougeOutsideModule_pb.RougeUnlockStoryRequest()
	slot3.season = slot1
	slot3.storyId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeUnlockStoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season
	slot4 = slot2.storyId
end

function slot0.sendRougeLimiterSettingSaveRequest(slot0, slot1, slot2)
	RougeOutsideModule_pb.RougeLimiterSettingSaveRequest().season = slot1

	if slot2 then
		for slot8, slot9 in ipairs(slot2:getLimitIds()) do
			slot3.clientNO.limitIds:append(slot9)
		end

		for slot9, slot10 in ipairs(slot2:getLimitBuffIds()) do
			slot3.clientNO.limitBuffIds:append(slot10)
		end
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeLimiterSettingSaveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeDLCModel101.instance:onGetLimiterClientMo(slot2.clientNO)
end

function slot0.sendRougeDLCSettingSaveRequest(slot0, slot1, slot2)
	RougeOutsideModule_pb.RougeDLCSettingSaveRequest().season = slot1

	for slot7, slot8 in ipairs(slot2 or {}) do
		slot3.dlcVersionIds:append(slot8)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeDLCSettingSaveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeOutsideModel.instance:getRougeGameRecord():_updateVersionIds(slot2.dlcVersionIds)
	RougeDLCController.instance:dispatchEvent(RougeEvent.OnGetVersionInfo)
end

function slot0.sendRougeLimiterUnlockBuffRequest(slot0, slot1, slot2)
	slot3 = RougeOutsideModule_pb.RougeLimiterUnlockBuffRequest()
	slot3.season = slot1
	slot3.limitBuffId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeLimiterUnlockBuffReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeDLCController101.instance:onGetUnlockLimiterBuffInfo(slot2.limitBuffId)
end

function slot0.sendRougeLimiterSpeedUpBuffCdRequest(slot0, slot1, slot2)
	slot3 = RougeOutsideModule_pb.RougeLimiterSpeedUpBuffCdRequest()
	slot3.season = slot1
	slot3.limitBuffId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveRougeLimiterSpeedUpBuffCdReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.season

	RougeDLCController101.instance:onGetSpeedupLimiterBuffInfo(slot2.limitBuffId)
end

slot0.instance = slot0.New()

return slot0
