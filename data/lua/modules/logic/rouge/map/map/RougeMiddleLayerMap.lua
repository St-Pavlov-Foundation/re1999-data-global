module("modules.logic.rouge.map.map.RougeMiddleLayerMap", package.seeall)

local var_0_0 = class("RougeMiddleLayerMap", RougeBaseMap)

function var_0_0.initMap(arg_1_0)
	var_0_0.super.initMap(arg_1_0)

	local var_1_0 = arg_1_0:getCameraSize()

	RougeMapModel.instance:setCameraSize(var_1_0)
	transformhelper.setLocalPos(arg_1_0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, arg_1_0.onExitPieceChoiceEvent, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, arg_1_0.onMiddleActorBeforeMove, arg_1_0)
end

function var_0_0.getCameraSize(arg_2_0)
	return RougeMapHelper.getMiddleLayerCameraSize()
end

function var_0_0.createMapNodeContainer(arg_3_0)
	var_0_0.super.createMapNodeContainer(arg_3_0)

	arg_3_0.goPieceIconContainer = gohelper.create3d(arg_3_0.mapGo, "pieceIconContainer")

	transformhelper.setLocalPos(arg_3_0.goPieceIconContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PieceIcon)
end

function var_0_0.handleOtherRes(arg_4_0, arg_4_1)
	arg_4_0.middleLayerLeavePrefab = arg_4_1:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
	arg_4_0.luoLeiLaiEffectPrefab = arg_4_1:getAssetItem(RougeMapEnum.PieceBossEffect):GetResource()
	arg_4_0.piecePrefabDict = arg_4_0:getUserDataTb_()

	local var_4_0 = RougeMapModel.instance:getMiddleLayerCo().dayOrNight
	local var_4_1 = RougeMapModel.instance:getPieceList()

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = iter_4_1:getPieceCo().pieceRes

		if not string.nilorempty(var_4_2) then
			local var_4_3 = RougeMapHelper.getPieceResPath(var_4_2, var_4_0)

			if not arg_4_0.piecePrefabDict[var_4_3] then
				arg_4_0.piecePrefabDict[var_4_3] = arg_4_1:getAssetItem(var_4_3):GetResource()
			end
		end
	end

	arg_4_0.iconPrefabDict = arg_4_0:getUserDataTb_()

	for iter_4_2, iter_4_3 in pairs(RougeMapEnum.PieceIconRes) do
		arg_4_0.iconPrefabDict[iter_4_2] = arg_4_1:getAssetItem(iter_4_3):GetResource()
	end

	arg_4_0.iconBgPrefabDict = arg_4_0:getUserDataTb_()

	for iter_4_4, iter_4_5 in pairs(RougeMapEnum.PieceIconBgRes) do
		arg_4_0.iconBgPrefabDict[iter_4_4] = arg_4_1:getAssetItem(iter_4_5):GetResource()
	end

	local var_4_4 = RougeMapHelper.getPieceResPath(RougeMapEnum.ActorPiecePath, var_4_0)

	arg_4_1:addPath(var_4_4)

	arg_4_0.actorPiecePrefab = arg_4_1:getAssetItem(var_4_4):GetResource()
end

function var_0_0.createMap(arg_5_0)
	arg_5_0:createPiece()
	arg_5_0:createLeavePiece()

	arg_5_0.goActor = gohelper.clone(arg_5_0.actorPiecePrefab, arg_5_0.goLayerPiecesContainer, "actor")
	arg_5_0.actorComp = RougeMapMiddleLayerActorComp.New()

	arg_5_0.actorComp:init(arg_5_0.goActor, arg_5_0)

	arg_5_0.animator = arg_5_0.mapGo:GetComponent(gohelper.Type_Animator)
	arg_5_0.animator.speed = 0

	TaskDispatcher.runDelay(arg_5_0.playEnterAnim, arg_5_0, RougeMapEnum.WaitMiddleLayerEnterTime)
	var_0_0.super.createMap(arg_5_0)
end

function var_0_0.playEnterAnim(arg_6_0)
	arg_6_0.animator.speed = 1
end

function var_0_0.createPiece(arg_7_0)
	local var_7_0 = RougeMapModel.instance:getPieceList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = RougeMapPieceItem.New()

		var_7_1:init(iter_7_1, arg_7_0)
		arg_7_0:addMapItem(var_7_1)
	end
end

function var_0_0.createLeavePiece(arg_8_0)
	if not RougeMapModel.instance:hadLeavePos() then
		return
	end

	local var_8_0 = RougeMapLeaveItem.New()

	var_8_0:init(arg_8_0)
	arg_8_0:addMapItem(var_8_0)
end

function var_0_0.onMiddleActorBeforeMove(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.focusPos

	arg_9_0:clearTween()

	arg_9_0.movingTweenId = ZProj.TweenHelper.DOLocalMove(arg_9_0.mapTransform, -var_9_0.x, -var_9_0.y, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, arg_9_0.onMovingDone, arg_9_0)
end

function var_0_0.onExitPieceChoiceEvent(arg_10_0)
	arg_10_0:clearTween()

	arg_10_0.movingTweenId = ZProj.TweenHelper.DOLocalMove(arg_10_0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, arg_10_0.onMovingDone, arg_10_0)
end

function var_0_0.onMovingDone(arg_11_0)
	arg_11_0.movingTweenId = nil
end

function var_0_0.getActorPos(arg_12_0)
	local var_12_0 = RougeMapModel.instance:getCurPosIndex() + 1
	local var_12_1 = RougeMapModel.instance:getPathIndex(var_12_0)
	local var_12_2 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(var_12_1)

	return var_12_2.x, var_12_2.y
end

function var_0_0.getLeaveItem(arg_13_0)
	return arg_13_0:getMapItem(RougeMapEnum.LeaveId)
end

function var_0_0.clearTween(arg_14_0)
	if arg_14_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_14_0.movingTweenId)
	end

	arg_14_0.movingTweenId = nil
end

function var_0_0.destroy(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.playEnterAnim, arg_15_0)
	arg_15_0:clearTween()
	var_0_0.super.destroy(arg_15_0)
end

return var_0_0
