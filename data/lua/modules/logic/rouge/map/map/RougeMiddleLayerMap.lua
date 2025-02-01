module("modules.logic.rouge.map.map.RougeMiddleLayerMap", package.seeall)

slot0 = class("RougeMiddleLayerMap", RougeBaseMap)

function slot0.initMap(slot0)
	uv0.super.initMap(slot0)
	RougeMapModel.instance:setCameraSize(slot0:getCameraSize())
	transformhelper.setLocalPos(slot0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
end

function slot0.getCameraSize(slot0)
	return RougeMapHelper.getMiddleLayerCameraSize()
end

function slot0.createMapNodeContainer(slot0)
	uv0.super.createMapNodeContainer(slot0)

	slot0.goPieceIconContainer = gohelper.create3d(slot0.mapGo, "pieceIconContainer")

	transformhelper.setLocalPos(slot0.goPieceIconContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PieceIcon)
end

function slot0.handleOtherRes(slot0, slot1)
	slot0.middleLayerLeavePrefab = slot1:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
	slot0.luoLeiLaiEffectPrefab = slot1:getAssetItem(RougeMapEnum.PieceBossEffect):GetResource()
	slot0.piecePrefabDict = slot0:getUserDataTb_()

	for slot8, slot9 in ipairs(RougeMapModel.instance:getPieceList()) do
		if not string.nilorempty(slot9:getPieceCo().pieceRes) and not slot0.piecePrefabDict[RougeMapHelper.getPieceResPath(slot11, RougeMapModel.instance:getMiddleLayerCo().dayOrNight)] then
			slot0.piecePrefabDict[slot11] = slot1:getAssetItem(slot11):GetResource()
		end
	end

	slot0.iconPrefabDict = slot0:getUserDataTb_()

	for slot8, slot9 in pairs(RougeMapEnum.PieceIconRes) do
		slot0.iconPrefabDict[slot8] = slot1:getAssetItem(slot9):GetResource()
	end

	slot0.iconBgPrefabDict = slot0:getUserDataTb_()

	for slot8, slot9 in pairs(RougeMapEnum.PieceIconBgRes) do
		slot0.iconBgPrefabDict[slot8] = slot1:getAssetItem(slot9):GetResource()
	end

	slot5 = RougeMapHelper.getPieceResPath(RougeMapEnum.ActorPiecePath, slot3)

	slot1:addPath(slot5)

	slot0.actorPiecePrefab = slot1:getAssetItem(slot5):GetResource()
end

function slot0.createMap(slot0)
	slot0:createPiece()
	slot0:createLeavePiece()

	slot0.goActor = gohelper.clone(slot0.actorPiecePrefab, slot0.goLayerPiecesContainer, "actor")
	slot0.actorComp = RougeMapMiddleLayerActorComp.New()

	slot0.actorComp:init(slot0.goActor, slot0)

	slot0.animator = slot0.mapGo:GetComponent(gohelper.Type_Animator)
	slot0.animator.speed = 0

	TaskDispatcher.runDelay(slot0.playEnterAnim, slot0, RougeMapEnum.WaitMiddleLayerEnterTime)
	uv0.super.createMap(slot0)
end

function slot0.playEnterAnim(slot0)
	slot0.animator.speed = 1
end

function slot0.createPiece(slot0)
	for slot5, slot6 in ipairs(RougeMapModel.instance:getPieceList()) do
		slot7 = RougeMapPieceItem.New()

		slot7:init(slot6, slot0)
		slot0:addMapItem(slot7)
	end
end

function slot0.createLeavePiece(slot0)
	if not RougeMapModel.instance:hadLeavePos() then
		return
	end

	slot1 = RougeMapLeaveItem.New()

	slot1:init(slot0)
	slot0:addMapItem(slot1)
end

function slot0.onMiddleActorBeforeMove(slot0, slot1)
	slot2 = slot1.focusPos

	slot0:clearTween()

	slot0.movingTweenId = ZProj.TweenHelper.DOLocalMove(slot0.mapTransform, -slot2.x, -slot2.y, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, slot0.onMovingDone, slot0)
end

function slot0.onExitPieceChoiceEvent(slot0)
	slot0:clearTween()

	slot0.movingTweenId = ZProj.TweenHelper.DOLocalMove(slot0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, slot0.onMovingDone, slot0)
end

function slot0.onMovingDone(slot0)
	slot0.movingTweenId = nil
end

function slot0.getActorPos(slot0)
	slot3 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(RougeMapModel.instance:getPathIndex(RougeMapModel.instance:getCurPosIndex() + 1))

	return slot3.x, slot3.y
end

function slot0.getLeaveItem(slot0)
	return slot0:getMapItem(RougeMapEnum.LeaveId)
end

function slot0.clearTween(slot0)
	if slot0.movingTweenId then
		ZProj.TweenHelper.KillById(slot0.movingTweenId)
	end

	slot0.movingTweenId = nil
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.playEnterAnim, slot0)
	slot0:clearTween()
	uv0.super.destroy(slot0)
end

return slot0
