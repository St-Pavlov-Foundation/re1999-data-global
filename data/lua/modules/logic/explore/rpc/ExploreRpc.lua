module("modules.logic.explore.rpc.ExploreRpc", package.seeall)

slot0 = class("ExploreRpc", BaseRpc)
slot0.instance = slot0.New()

function slot0.sendChangeMapRequest(slot0, slot1)
	slot2 = ExploreModule_pb.ChangeMapRequest()
	slot2.mapId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveChangeMapReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreModel.instance.isFirstEnterMap = slot2.exploreInfo.exploreMap.isFirstEnter and ExploreEnum.EnterMode.First or ExploreEnum.EnterMode.Normal

		ExploreSimpleModel.instance:setNowMapId(slot2.exploreInfo.exploreMap.mapId)
		ExploreModel.instance:updateExploreInfo(slot2.exploreInfo)
		ExploreController.instance:enterExploreMap(slot2.exploreInfo.exploreMap.mapId)
	end
end

function slot0.sendGetExploreInfoRequest(slot0)
	slot0:sendMsg(ExploreModule_pb.GetExploreInfoRequest())
end

function slot0.onReceiveGetExploreInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreModel.instance:updateExploreInfo(slot2.exploreInfo)
		ExploreController.instance:enterExploreMap(ExploreModel.instance:getMapId())
	end
end

function slot0.sendGetExploreSimpleInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(ExploreModule_pb.GetExploreSimpleInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetExploreSimpleInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreSimpleModel.instance:onGetInfo(slot2)
	end
end

function slot0.sendExploreMoveRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ExploreModule_pb.ExploreMoveRequest()
	slot6.posx = slot1
	slot6.posy = slot2

	if slot3 then
		slot6.interactId = slot3
	end

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveExploreMoveReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		ExploreStepController.instance:forceAsyncPos()
	end
end

function slot0.sendExploreInteractSetStatusRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = ExploreModule_pb.ExploreInteractSetStatusRequest()
	slot6.type = slot1
	slot6.id = slot2
	slot6.status = slot3

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveExploreInteractSetStatusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreModel.instance:updateInteractStatus(slot2.mapId, slot2.id, slot2.status)
	end
end

function slot0.sendExploreInteractRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	ExploreModule_pb.ExploreInteractRequest().id = slot1

	if not string.nilorempty(slot3) then
		slot6.params = slot3
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.BeginInteract)

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveExploreInteractReply(slot0, slot1, slot2)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.BeginInteract)
	ExploreController.instance:dispatchEvent(ExploreEvent.UnitInteractEnd)

	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveStartExplorePush(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendExploreItemInteractRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = ExploreModule_pb.ExploreItemInteractRequest()
	slot5.id = slot1
	slot5.params = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveExploreItemInteractReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.sendExploreUseItemRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = ExploreModule_pb.ExploreUseItemRequest()
	slot7.uid = slot1
	slot7.posx = slot2
	slot7.posy = slot3

	if slot4 then
		slot7.interactId = slot4
	end

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveExploreUseItemReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveExploreItemChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreBackpackModel.instance:updateItems(slot2.exploreItems)
	end
end

function slot0.onReceiveExploreStepPush(slot0, slot1, slot2)
	if slot1 == 0 then
		ExploreStepController.instance:onExploreStepPush(slot2)
	end
end

function slot0.sendResetExploreRequest(slot0)
	ExploreController.instance:getMap():getHero():stopMoving(true)
	ExploreStepController.instance:insertClientStep({
		stepType = ExploreEnum.StepType.ResetBegin
	}, 1)
	ExploreStepController.instance:startStep()
	slot0:sendMsg(ExploreModule_pb.ResetExploreRequest())
end

function slot0.onReceiveResetExploreReply(slot0, slot1, slot2)
	ExploreStepController.instance:insertClientStep({
		stepType = ExploreEnum.StepType.ResetEnd
	})
	ExploreStepController.instance:startStep()
end

return slot0
