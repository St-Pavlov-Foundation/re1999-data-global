module("modules.logic.rouge.map.map.itemcomp.RougeMapPieceItem", package.seeall)

local var_0_0 = class("RougeMapPieceItem", RougeMapBaseItem)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0)

	arg_1_0.pieceMo = arg_1_1
	arg_1_0.pieceCo = arg_1_0.pieceMo:getPieceCo()
	arg_1_0.map = arg_1_2

	arg_1_0:setId(arg_1_0.pieceMo.id)
	arg_1_0:createPiece()
	arg_1_0:createIcon()
	arg_1_0:createEffect()
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_1_0.onUpdateMapInfo, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, arg_1_0.onMiddleActorBeforeMove, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, arg_1_0.onExitPieceChoiceEvent, arg_1_0)
end

function var_0_0.createPiece(arg_2_0)
	local var_2_0 = RougeMapModel.instance:getMiddleLayerCo().dayOrNight
	local var_2_1 = arg_2_0.pieceCo.pieceRes

	if string.nilorempty(var_2_1) then
		arg_2_0.isEmpty = true
		arg_2_0.pieceGo = gohelper.create3d(arg_2_0.map.goLayerPiecesContainer, arg_2_0.pieceCo.id)
	else
		arg_2_0.isEmpty = false

		local var_2_2 = RougeMapHelper.getPieceResPath(var_2_1, var_2_0)

		arg_2_0.pieceGo = gohelper.clone(arg_2_0.map.piecePrefabDict[var_2_2], arg_2_0.map.goLayerPiecesContainer, arg_2_0.pieceCo.id)
	end

	arg_2_0.pieceTr = arg_2_0.pieceGo.transform

	transformhelper.setLocalPos(arg_2_0.pieceTr, arg_2_0:getMapPos())
	arg_2_0:refreshDirection()
end

function var_0_0.createIcon(arg_3_0)
	local var_3_0 = arg_3_0.pieceCo.entrustType

	if var_3_0 == 0 then
		logError(string.format("棋子id : %s, 没有配置委托类型", arg_3_0.pieceCo.id))

		return
	end

	if var_3_0 == RougeMapEnum.PieceEntrustType.Boss then
		return
	end

	if not arg_3_0:canShowIcon() then
		return
	end

	local var_3_1 = RougeMapEnum.PieceIconBg[arg_3_0.pieceCo.entrustType]
	local var_3_2 = arg_3_0.map.iconBgPrefabDict[var_3_1]
	local var_3_3 = arg_3_0.map.goPieceIconContainer

	arg_3_0.bgGo = gohelper.clone(var_3_2, var_3_3, arg_3_0.pieceCo.id)
	arg_3_0.bgTr = arg_3_0.bgGo.transform

	local var_3_4, var_3_5, var_3_6 = arg_3_0:getMapPos()

	transformhelper.setLocalPos(arg_3_0.bgTr, var_3_4 + RougeMapEnum.PieceIconOffset.x, var_3_5 + RougeMapEnum.PieceIconOffset.y, var_3_6)

	local var_3_7 = arg_3_0.map.iconPrefabDict[var_3_0]

	arg_3_0.iconGo = gohelper.clone(var_3_7, arg_3_0.bgGo, "icon")
	arg_3_0.iconTr = arg_3_0.iconGo.transform

	transformhelper.setLocalPos(arg_3_0.iconTr, 0, 0, 0)
end

function var_0_0.createEffect(arg_4_0)
	if arg_4_0.pieceCo.bossEffect == 0 then
		return
	end

	arg_4_0.effectGo = gohelper.clone(arg_4_0.map.luoLeiLaiEffectPrefab, arg_4_0.pieceGo, "effect")

	arg_4_0:refreshEffect()
end

function var_0_0.refreshDirection(arg_5_0)
	if arg_5_0.isEmpty then
		return
	end

	arg_5_0:initDirectionMap()

	local var_5_0 = RougeMapModel.instance:getMiddleLayerPathPos(arg_5_0.pieceMo.index + 1)
	local var_5_1, var_5_2 = arg_5_0:getMapPos()
	local var_5_3 = RougeMapHelper.getAngle(var_5_1, var_5_2, var_5_0.x, var_5_0.y)
	local var_5_4 = RougeMapHelper.getPieceDir(var_5_3)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.directionGoMap) do
		gohelper.setActive(iter_5_1, iter_5_0 == var_5_4)
	end
end

function var_0_0.initDirectionMap(arg_6_0)
	if arg_6_0.isEmpty then
		return
	end

	if arg_6_0.directionGoMap then
		return
	end

	arg_6_0.directionGoMap = arg_6_0:getUserDataTb_()

	for iter_6_0, iter_6_1 in pairs(RougeMapEnum.PieceDir) do
		arg_6_0.directionGoMap[iter_6_1] = gohelper.findChild(arg_6_0.pieceGo, iter_6_1)
	end
end

function var_0_0.getScenePos(arg_7_0)
	return arg_7_0.pieceTr.position
end

function var_0_0.getMapPos(arg_8_0)
	local var_8_0 = RougeMapModel.instance:getMiddleLayerPosByIndex(arg_8_0.pieceMo.index + 1)

	if not var_8_0 then
		return 0, 0, 0
	end

	return var_8_0.x, var_8_0.y, RougeMapHelper.getOffsetZ(var_8_0.y)
end

function var_0_0.getClickArea(arg_9_0)
	return RougeMapEnum.PieceClickArea
end

function var_0_0.onClick(arg_10_0)
	logNormal("点击棋子了... " .. arg_10_0.pieceCo.id)

	if arg_10_0.pieceMo.finish then
		return
	end

	if not arg_10_0:canShowIcon() then
		return
	end

	RougeMapController.instance:moveToPieceItem(arg_10_0.pieceMo, arg_10_0.onMoveDone, arg_10_0)
end

function var_0_0.onMoveDone(arg_11_0)
	arg_11_0.callbackId = RougeRpc.instance:sendRougePieceMoveRequest(arg_11_0.pieceMo.index, arg_11_0.onReceiveMsg, arg_11_0)
end

function var_0_0.onReceiveMsg(arg_12_0)
	arg_12_0.callbackId = nil

	ViewMgr.instance:openView(ViewName.RougeMapPieceChoiceView, arg_12_0.pieceMo)
end

function var_0_0.onUpdateMapInfo(arg_13_0)
	arg_13_0:refreshIcon()
	arg_13_0:refreshEffect()
end

function var_0_0.canShowIcon(arg_14_0)
	if arg_14_0.onPieceView then
		return false
	end

	if arg_14_0.pieceMo.finish then
		return false
	end

	if not RougeMapHelper.isEntrustPiece(arg_14_0.pieceCo.entrustType) then
		return true
	end

	return RougeMapModel.instance:getEntrustId() == nil
end

function var_0_0.refreshIcon(arg_15_0)
	local var_15_0 = arg_15_0:canShowIcon()

	gohelper.setActive(arg_15_0.bgGo, var_15_0)
	gohelper.setActive(arg_15_0.iconGo, var_15_0)
end

function var_0_0.refreshEffect(arg_16_0)
	if not arg_16_0.effectGo then
		return
	end

	local var_16_0 = arg_16_0.pieceMo.finish

	gohelper.setActive(arg_16_0.effectGo, not var_16_0)
end

function var_0_0.onMiddleActorBeforeMove(arg_17_0, arg_17_1)
	if arg_17_1.pieceId == RougeMapEnum.LeaveId then
		return
	end

	arg_17_0.onPieceView = true

	arg_17_0:refreshIcon()
end

function var_0_0.onExitPieceChoiceEvent(arg_18_0)
	arg_18_0.onPieceView = false

	arg_18_0:refreshIcon()
end

function var_0_0.destroy(arg_19_0)
	if arg_19_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_19_0.callbackId)
	end

	var_0_0.super.destroy(arg_19_0)
end

return var_0_0
