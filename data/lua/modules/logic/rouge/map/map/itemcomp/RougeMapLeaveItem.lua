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
	if arg_7_0:_checkIsSelectEndingFourth() then
		local var_7_0, var_7_1 = arg_7_0:_getNeedPlayEndingFourthStories()

		if var_7_1 then
			StoryController.instance:playStories(var_7_0, nil, arg_7_0._sendMoveRpc, arg_7_0)

			return
		end
	end

	arg_7_0:_sendMoveRpc()
end

function var_0_0._checkIsSelectEndingFourth(arg_8_0)
	local var_8_0 = RougeMapModel.instance:getPieceList()
	local var_8_1 = lua_rouge_const.configDict[RougeEnum.Const.FourthEndingChoiceIds].value
	local var_8_2 = string.splitToNumber(var_8_1, "#")

	if var_8_2 and var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if iter_8_1.finish and iter_8_1.selectId and tabletool.indexOf(var_8_2, iter_8_1.selectId) then
				return true
			end
		end
	end
end

function var_0_0._getNeedPlayEndingFourthStories(arg_9_0)
	local var_9_0 = string.splitToNumber(lua_rouge_const.configDict[RougeEnum.Const.FourthEndingStoryId].value2, "#")
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if not StoryModel.instance:isStoryFinished(iter_9_1) then
			var_9_1 = var_9_0

			break
		end
	end

	local var_9_2 = var_9_1 and #var_9_1 > 0

	return var_9_1, var_9_2
end

function var_0_0._sendMoveRpc(arg_10_0)
	RougeRpc.instance:sendRougePieceMoveRequest(RougeMapEnum.PathSelectIndex)
end

function var_0_0.isActive(arg_11_0)
	if arg_11_0.onPieceView then
		return false
	end

	local var_11_0 = RougeMapModel.instance:getMiddleLayerCo()
	local var_11_1 = var_11_0.leavePosUnlockType
	local var_11_2 = var_11_0.leavePosUnlockParam

	return RougeMapUnlockHelper.checkIsUnlock(var_11_1, var_11_2)
end

function var_0_0.onMiddleActorBeforeMove(arg_12_0, arg_12_1)
	if arg_12_1.pieceId == RougeMapEnum.LeaveId then
		return
	end

	arg_12_0.onPieceView = true

	arg_12_0:refreshActive()
end

function var_0_0.onExitPieceChoiceEvent(arg_13_0)
	arg_13_0.onPieceView = false

	arg_13_0:refreshActive()
end

return var_0_0
