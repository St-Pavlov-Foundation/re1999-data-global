module("modules.logic.rouge.map.map.itemcomp.RougeMapPieceItem", package.seeall)

slot0 = class("RougeMapPieceItem", RougeMapBaseItem)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0)

	slot0.pieceMo = slot1
	slot0.pieceCo = slot0.pieceMo:getPieceCo()
	slot0.map = slot2

	slot0:setId(slot0.pieceMo.id)
	slot0:createPiece()
	slot0:createIcon()
	slot0:createEffect()
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
end

function slot0.createPiece(slot0)
	slot2 = RougeMapModel.instance:getMiddleLayerCo().dayOrNight

	if string.nilorempty(slot0.pieceCo.pieceRes) then
		slot0.isEmpty = true
		slot0.pieceGo = gohelper.create3d(slot0.map.goLayerPiecesContainer, slot0.pieceCo.id)
	else
		slot0.isEmpty = false
		slot0.pieceGo = gohelper.clone(slot0.map.piecePrefabDict[RougeMapHelper.getPieceResPath(slot3, slot2)], slot0.map.goLayerPiecesContainer, slot0.pieceCo.id)
	end

	slot0.pieceTr = slot0.pieceGo.transform

	transformhelper.setLocalPos(slot0.pieceTr, slot0:getMapPos())
	slot0:refreshDirection()
end

function slot0.createIcon(slot0)
	if slot0.pieceCo.entrustType == 0 then
		logError(string.format("棋子id : %s, 没有配置委托类型", slot0.pieceCo.id))

		return
	end

	if slot1 == RougeMapEnum.PieceEntrustType.Boss then
		return
	end

	if not slot0:canShowIcon() then
		return
	end

	slot0.bgGo = gohelper.clone(slot0.map.iconBgPrefabDict[RougeMapEnum.PieceIconBg[slot0.pieceCo.entrustType]], slot0.map.goPieceIconContainer, slot0.pieceCo.id)
	slot0.bgTr = slot0.bgGo.transform
	slot5, slot6, slot7 = slot0:getMapPos()

	transformhelper.setLocalPos(slot0.bgTr, slot5 + RougeMapEnum.PieceIconOffset.x, slot6 + RougeMapEnum.PieceIconOffset.y, slot7)

	slot0.iconGo = gohelper.clone(slot0.map.iconPrefabDict[slot1], slot0.bgGo, "icon")
	slot0.iconTr = slot0.iconGo.transform

	transformhelper.setLocalPos(slot0.iconTr, 0, 0, 0)
end

function slot0.createEffect(slot0)
	if slot0.pieceCo.bossEffect == 0 then
		return
	end

	slot0.effectGo = gohelper.clone(slot0.map.luoLeiLaiEffectPrefab, slot0.pieceGo, "effect")

	slot0:refreshEffect()
end

function slot0.refreshDirection(slot0)
	if slot0.isEmpty then
		return
	end

	slot0:initDirectionMap()

	slot1 = RougeMapModel.instance:getMiddleLayerPathPos(slot0.pieceMo.index + 1)
	slot2, slot3 = slot0:getMapPos()
	slot9 = slot1.y

	for slot9, slot10 in pairs(slot0.directionGoMap) do
		gohelper.setActive(slot10, slot9 == RougeMapHelper.getPieceDir(RougeMapHelper.getAngle(slot2, slot3, slot1.x, slot9)))
	end
end

function slot0.initDirectionMap(slot0)
	if slot0.isEmpty then
		return
	end

	if slot0.directionGoMap then
		return
	end

	slot0.directionGoMap = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(RougeMapEnum.PieceDir) do
		slot0.directionGoMap[slot5] = gohelper.findChild(slot0.pieceGo, slot5)
	end
end

function slot0.getScenePos(slot0)
	return slot0.pieceTr.position
end

function slot0.getMapPos(slot0)
	if not RougeMapModel.instance:getMiddleLayerPosByIndex(slot0.pieceMo.index + 1) then
		return 0, 0, 0
	end

	return slot1.x, slot1.y, RougeMapHelper.getOffsetZ(slot1.y)
end

function slot0.getClickArea(slot0)
	return RougeMapEnum.PieceClickArea
end

function slot0.onClick(slot0)
	logNormal("点击棋子了... " .. slot0.pieceCo.id)

	if slot0.pieceMo.finish then
		return
	end

	if not slot0:canShowIcon() then
		return
	end

	RougeMapController.instance:moveToPieceItem(slot0.pieceMo, slot0.onMoveDone, slot0)
end

function slot0.onMoveDone(slot0)
	slot0.callbackId = RougeRpc.instance:sendRougePieceMoveRequest(slot0.pieceMo.index, slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0)
	slot0.callbackId = nil

	ViewMgr.instance:openView(ViewName.RougeMapPieceChoiceView, slot0.pieceMo)
end

function slot0.onUpdateMapInfo(slot0)
	slot0:refreshIcon()
	slot0:refreshEffect()
end

function slot0.canShowIcon(slot0)
	if slot0.onPieceView then
		return false
	end

	if slot0.pieceMo.finish then
		return false
	end

	if not RougeMapHelper.isEntrustPiece(slot0.pieceCo.entrustType) then
		return true
	end

	return RougeMapModel.instance:getEntrustId() == nil
end

function slot0.refreshIcon(slot0)
	slot1 = slot0:canShowIcon()

	gohelper.setActive(slot0.bgGo, slot1)
	gohelper.setActive(slot0.iconGo, slot1)
end

function slot0.refreshEffect(slot0)
	if not slot0.effectGo then
		return
	end

	gohelper.setActive(slot0.effectGo, not slot0.pieceMo.finish)
end

function slot0.onMiddleActorBeforeMove(slot0, slot1)
	if slot1.pieceId == RougeMapEnum.LeaveId then
		return
	end

	slot0.onPieceView = true

	slot0:refreshIcon()
end

function slot0.onExitPieceChoiceEvent(slot0)
	slot0.onPieceView = false

	slot0:refreshIcon()
end

function slot0.destroy(slot0)
	if slot0.callbackId then
		RougeRpc.instance:removeCallbackById(slot0.callbackId)
	end

	uv0.super.destroy(slot0)
end

return slot0
