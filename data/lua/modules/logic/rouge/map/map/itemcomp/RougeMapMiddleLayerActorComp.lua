module("modules.logic.rouge.map.map.itemcomp.RougeMapMiddleLayerActorComp", package.seeall)

local var_0_0 = class("RougeMapMiddleLayerActorComp", RougeMapBaseActorComp)

function var_0_0.initActor(arg_1_0)
	var_0_0.super.initActor(arg_1_0)

	arg_1_0.pathList = {}
	arg_1_0.lenRateList = {}

	arg_1_0:refreshDir()
end

function var_0_0.refreshDir(arg_2_0)
	arg_2_0:initDirGo()

	local var_2_0 = RougeMapModel.instance:getCurPosIndex()
	local var_2_1
	local var_2_2

	if var_2_0 == 0 then
		var_2_1 = RougeMapModel.instance:getMiddleLayerPosByIndex(1)
		var_2_2 = RougeMapModel.instance:getMiddleLayerPathPos(1)
	else
		local var_2_3 = var_2_0 + 1
		local var_2_4 = RougeMapModel.instance:getPathIndex(var_2_3)

		var_2_1 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(var_2_4)
		var_2_2 = RougeMapModel.instance:getMiddleLayerPosByIndex(var_2_3)
	end

	local var_2_5 = RougeMapHelper.getAngle(var_2_1.x, var_2_1.y, var_2_2.x, var_2_2.y)
	local var_2_6 = RougeMapHelper:getActorDir(var_2_5)

	arg_2_0:_refreshDir(var_2_6)
end

function var_0_0.initDirGo(arg_3_0)
	if arg_3_0.directionGoMap then
		return
	end

	arg_3_0.directionGoMap = arg_3_0:getUserDataTb_()

	for iter_3_0, iter_3_1 in pairs(RougeMapEnum.ActorDir) do
		arg_3_0.directionGoMap[iter_3_1] = gohelper.findChild(arg_3_0.goActor, tostring(iter_3_1))
	end
end

function var_0_0.moveToLeaveItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:clearTween()

	arg_4_0.callback = arg_4_1
	arg_4_0.callbackObj = arg_4_2

	local var_4_0 = RougeMapModel.instance:getMiddleLayerCo()

	if not var_4_0.leavePos then
		arg_4_0:onMovingDone()

		return
	end

	local var_4_1 = RougeMapModel.instance:getCurPosIndex() + 1
	local var_4_2 = RougeMapModel.instance:getPathIndex(var_4_1)
	local var_4_3 = RougeMapModel.instance:getMiddleLayerLeavePathIndex()

	tabletool.clear(arg_4_0.pathList)
	tabletool.clear(arg_4_0.lenRateList)
	RougeMapConfig.instance:getPathIndexList(var_4_0.pathDict, var_4_2, var_4_3, arg_4_0.pathList)

	local var_4_4 = RougeMapHelper.getMiddleLayerPathListLen(var_4_0, arg_4_0.pathList, arg_4_0.lenRateList) / RougeMapEnum.MoveSpeed
	local var_4_5 = RougeMapModel.instance:getMiddleLayerLeavePathIndex()
	local var_4_6 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(var_4_5)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = var_4_6,
		pieceId = RougeMapEnum.LeaveId
	})

	arg_4_0.targetPos = var_4_6
	arg_4_0.targetFacePos = var_4_0.leavePos
	arg_4_0.lastStartIndex = nil
	arg_4_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_4_4, arg_4_0.onMoveToPieceFrameCallback, arg_4_0.onMovingDone, arg_4_0, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	arg_4_0:startBlock()
end

function var_0_0.moveToPieceItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = RougeMapModel.instance:getCurPosIndex() + 1
	local var_5_1 = RougeMapModel.instance:getPathIndex(var_5_0)
	local var_5_2 = RougeMapModel.instance:getPathIndex(arg_5_1.index + 1)

	arg_5_0:clearTween()

	arg_5_0.callback = arg_5_2
	arg_5_0.callbackObj = arg_5_3

	local var_5_3 = arg_5_1.index + 1
	local var_5_4 = RougeMapModel.instance:getPathIndex(var_5_3)
	local var_5_5 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(var_5_4)

	if var_5_1 == var_5_2 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
			focusPos = var_5_5,
			pieceId = arg_5_1.id
		})
		arg_5_0:onMovingDone()

		return
	end

	tabletool.clear(arg_5_0.pathList)
	tabletool.clear(arg_5_0.lenRateList)

	local var_5_6 = RougeMapModel.instance:getMiddleLayerCo()

	RougeMapConfig.instance:getPathIndexList(var_5_6.pathDict, var_5_1, var_5_2, arg_5_0.pathList)

	local var_5_7 = RougeMapHelper.getMiddleLayerPathListLen(var_5_6, arg_5_0.pathList, arg_5_0.lenRateList) / RougeMapEnum.MoveSpeed

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = var_5_5,
		pieceId = arg_5_1.id
	})

	arg_5_0.targetPos = var_5_5
	arg_5_0.targetFacePos = RougeMapModel.instance:getMiddleLayerPosByIndex(var_5_3)
	arg_5_0.lastStartIndex = nil
	arg_5_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_5_7, arg_5_0.onMoveToPieceFrameCallback, arg_5_0.onMovingDone, arg_5_0, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	arg_5_0:startBlock()
end

function var_0_0.onMoveToPieceFrameCallback(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.lenRateList) do
		var_6_0 = iter_6_0

		if arg_6_1 < iter_6_1 then
			break
		end
	end

	local var_6_1 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(arg_6_0.pathList[var_6_0])
	local var_6_2 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(arg_6_0.pathList[var_6_0 + 1])

	if arg_6_0.lastStartIndex ~= var_6_0 then
		arg_6_0.lastStartIndex = var_6_0

		local var_6_3 = RougeMapHelper.getAngle(var_6_1.x, var_6_1.y, var_6_2.x, var_6_2.y)
		local var_6_4 = RougeMapHelper:getActorDir(var_6_3)

		arg_6_0:_refreshDir(var_6_4)
	end

	local var_6_5 = arg_6_0.lenRateList[var_6_0 - 1] or 0
	local var_6_6 = (arg_6_1 - var_6_5) / (arg_6_0.lenRateList[var_6_0] - var_6_5)
	local var_6_7 = Mathf.Lerp(var_6_1.x, var_6_2.x, var_6_6)
	local var_6_8 = Mathf.Lerp(var_6_1.y, var_6_2.y, var_6_6)

	transformhelper.setLocalPos(arg_6_0.trActor, var_6_7, var_6_8, RougeMapHelper.getOffsetZ(var_6_8))
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorPosChange, arg_6_0.trActor.position)
end

function var_0_0.onMovingDone(arg_7_0)
	if arg_7_0.targetFacePos and arg_7_0.targetPos then
		local var_7_0 = RougeMapHelper.getAngle(arg_7_0.targetPos.x, arg_7_0.targetPos.y, arg_7_0.targetFacePos.x, arg_7_0.targetFacePos.y)
		local var_7_1 = RougeMapHelper:getActorDir(var_7_0)

		arg_7_0:_refreshDir(var_7_1)
	end

	var_0_0.super.onMovingDone(arg_7_0)
end

function var_0_0._refreshDir(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.directionGoMap) do
		gohelper.setActive(iter_8_1, iter_8_0 == arg_8_1)
	end
end

return var_0_0
