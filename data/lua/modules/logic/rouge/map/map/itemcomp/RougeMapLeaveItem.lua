module("modules.logic.rouge.map.map.itemcomp.RougeMapLeaveItem", package.seeall)

local var_0_0 = class("RougeMapLeaveItem", RougeMapBaseItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0)

	arg_1_0.map = arg_1_1

	arg_1_0:setId(RougeMapEnum.LeaveId)
	arg_1_0:createGo()
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onReceivePieceChoiceEvent, arg_1_0.refreshActive, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onMiddleActorBeforeMove, arg_1_0.onMiddleActorBeforeMove, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, arg_1_0.onExitPieceChoiceEvent, arg_1_0)
end

function var_0_0.createGo(arg_2_0)
	arg_2_0.go = gohelper.clone(arg_2_0.map.middleLayerLeavePrefab, arg_2_0.map.goLayerPiecesContainer)
	arg_2_0.transform = arg_2_0.go.transform

	local var_2_0, var_2_1 = RougeMapModel.instance:getMiddleLayerLeavePos()

	transformhelper.setLocalPos(arg_2_0.transform, var_2_0, var_2_1, RougeMapHelper.getOffsetZ(var_2_1))

	arg_2_0.scenePos = arg_2_0.transform.position

	arg_2_0:refreshActive()
end

function var_0_0.refreshActive(arg_3_0)
	gohelper.setActive(arg_3_0.go, arg_3_0:isActive())
end

function var_0_0.getScenePos(arg_4_0)
	return arg_4_0.scenePos
end

function var_0_0.getClickArea(arg_5_0)
	return RougeMapEnum.LeaveItemClickArea
end

function var_0_0.onClick(arg_6_0)
	logNormal("on click leave item")
	RougeMapController.instance:moveToLeaveItem(arg_6_0.onMoveDone, arg_6_0)
end

function var_0_0.onMoveDone(arg_7_0)
	RougeRpc.instance:sendRougePieceMoveRequest(RougeMapEnum.PathSelectIndex)
end

function var_0_0.isActive(arg_8_0)
	if arg_8_0.onPieceView then
		return false
	end

	local var_8_0 = RougeMapModel.instance:getMiddleLayerCo()
	local var_8_1 = var_8_0.leavePosUnlockType
	local var_8_2 = var_8_0.leavePosUnlockParam

	return RougeMapUnlockHelper.checkIsUnlock(var_8_1, var_8_2)
end

function var_0_0.onMiddleActorBeforeMove(arg_9_0, arg_9_1)
	if arg_9_1.pieceId == RougeMapEnum.LeaveId then
		return
	end

	arg_9_0.onPieceView = true

	arg_9_0:refreshActive()
end

function var_0_0.onExitPieceChoiceEvent(arg_10_0)
	arg_10_0.onPieceView = false

	arg_10_0:refreshActive()
end

return var_0_0
