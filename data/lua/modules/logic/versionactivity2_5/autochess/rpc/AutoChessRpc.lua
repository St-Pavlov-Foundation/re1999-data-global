module("modules.logic.versionactivity2_5.autochess.rpc.AutoChessRpc", package.seeall)

slot0 = class("AutoChessRpc", BaseRpc)

function slot0.sendAutoChessGetSceneRequest(slot0, slot1, slot2, slot3)
	slot4 = AutoChessModule_pb.AutoChessGetSceneRequest()
	slot4.moduleId = 1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAutoChessGetSceneReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendAutoChessEnterSceneRequest(slot0, slot1, slot2, slot3)
	slot4 = AutoChessModule_pb.AutoChessEnterSceneRequest()
	slot4.moduleId = slot1
	slot4.episodeId = slot2
	slot4.masterId = slot3
	slot0.episodeId = slot2

	slot0:sendMsg(slot4)
end

function slot0.onReceiveAutoChessEnterSceneReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AutoChessModel.instance:enterSceneReply(slot2.moduleId, slot2.scene)
		AutoChessController.instance:enterGame(slot0.episodeId)
	end

	slot0.episodeId = nil
end

function slot0.sendAutoChessEnterFightRequest(slot0, slot1, slot2, slot3)
	slot4 = AutoChessModule_pb.AutoChessEnterFightRequest()
	slot4.moduleId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAutoChessEnterFightReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)
	slot3.sceneRound = slot2.sceneRound

	slot3:cacheSvrFight()
	slot3:updateSvrTurn(slot2.turn)
	slot3:updateSvrMall(slot2.mall)
	slot3:updateSvrBaseInfo(slot2.baseInfo)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.EnterFightReply)
end

function slot0.sendAutoChessBuyChessRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = AutoChessModule_pb.AutoChessBuyChessRequest()
	slot6.moduleId = slot1
	slot6.mallId = slot2
	slot6.itemUid = slot3
	slot6.warZoneId = slot4
	slot6.position = slot5

	slot0:sendMsg(slot6)
end

function slot0.onReceiveAutoChessBuyChessReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)

	slot3:updateSvrTurn(slot2.turn)
	slot3:updateSvrMall(slot2.mall)
	slot3:updateSvrBaseInfo(slot2.baseInfo)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuyChessReply)
end

function slot0.sendAutoChessBuildRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	AutoChessController.instance:setGuideEventFlag(slot2)

	slot10 = AutoChessModule_pb.AutoChessBuildRequest()
	slot10.moduleId = slot1
	slot10.type = slot2
	slot10.fromWarZoneId = slot3
	slot10.fromPosition = slot4
	slot10.fromUid = slot5
	slot10.toWarZoneId = slot6 or 0
	slot10.toPosition = slot7 or 0
	slot10.toUid = slot8 or 0
	slot10.extraParam = slot9 or 0

	slot0:sendMsg(slot10)
end

function slot0.onReceiveAutoChessBuildReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessController.instance:checkGuideEventFlag()

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)

	slot3:updateSvrTurn(slot2.turn)
	slot3:updateSvrMall(slot2.mall)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.BuildReply)
end

function slot0.sendAutoChessRefreshMallRequest(slot0, slot1)
	slot2 = AutoChessModule_pb.AutoChessRefreshMallRequest()
	slot2.moduleId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAutoChessRefreshMallReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)

	slot3:updateSvrMall(slot2.mall, true)
	slot3:updateSvrTurn(slot2.turn)
end

function slot0.sendAutoChessFreezeItemRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = AutoChessModule_pb.AutoChessFreezeItemRequest()
	slot7.moduleId = slot1
	slot7.mallId = slot2
	slot7.itemUid = slot3
	slot7.type = slot4

	slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveAutoChessFreezeItemReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo(slot2.moduleId):freezeReply(slot2.mallId, slot2.type)
end

function slot0.sendAutoChessMallRegionSelectItemRequest(slot0, slot1, slot2)
	slot0.select = slot2 ~= 0
	slot3 = AutoChessModule_pb.AutoChessMallRegionSelectItemRequest()
	slot3.moduleId = slot1
	slot3.itemId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAutoChessMallRegionSelectItemReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo(slot2.moduleId):updateSvrMallRegion(slot2.region)

	if slot0.select then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickReply)

		slot0.select = nil
	end
end

function slot0.sendAutoChessUseMasterSkillRequest(slot0, slot1, slot2)
	slot3 = AutoChessModule_pb.AutoChessUseMasterSkillRequest()
	slot3.moduleId = slot1
	slot3.skillId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAutoChessUseMasterSkillReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)

	slot3:updateSvrTurn(slot2.turn)
	slot3.svrFight:updateMasterSkill(slot2.skill)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ZUseSkill)
end

function slot0.sendAutoChessPreviewFightRequest(slot0, slot1, slot2, slot3)
	slot4 = AutoChessModule_pb.AutoChessPreviewFightRequest()
	slot4.moduleId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAutoChessPreviewFightReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = AutoChessModel.instance:getChessMo(slot2.moduleId)
	slot3.preview = true

	if slot3.previewCoin ~= 0 then
		slot3:updateSvrMallCoin(slot3.svrMall.coin - slot3.previewCoin)
	end
end

function slot0.sendAutoChessGiveUpRequest(slot0, slot1, slot2, slot3)
	slot4 = AutoChessModule_pb.AutoChessGiveUpRequest()
	slot4.moduleId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAutoChessGiveUpReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if AutoChessModel.instance:getChessMo(slot2.moduleId, true) then
		slot3:clearData()
	end
end

function slot0.onReceiveAutoChessScenePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessModel.instance:getChessMo(slot2.moduleId):updateSvrScene(slot2.scene)
end

function slot0.onReceiveAutoChessRoundSettlePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessModel.instance:svrResultData(slot2)
end

function slot0.onReceiveAutoChessSettlePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	AutoChessModel.instance:svrSettleData(slot2)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SettlePush)
end

slot0.instance = slot0.New()

return slot0
