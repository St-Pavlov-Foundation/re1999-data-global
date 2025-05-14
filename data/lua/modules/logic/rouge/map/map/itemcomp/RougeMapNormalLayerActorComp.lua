module("modules.logic.rouge.map.map.itemcomp.RougeMapNormalLayerActorComp", package.seeall)

local var_0_0 = class("RougeMapNormalLayerActorComp", RougeMapBaseActorComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0.goActor)

	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, arg_1_0.moveToEnd, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_1_0.onCloseViewFinish, arg_1_0)
end

function var_0_0.moveToMapItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_1 = arg_2_1 or RougeMapModel.instance:getCurNode().nodeId

	local var_2_0, var_2_1, var_2_2 = arg_2_0.map:getMapItem(arg_2_1):getActorPos()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNormalActorBeforeMove)
	arg_2_0:clearTween()

	arg_2_0.callback = arg_2_2
	arg_2_0.callbackObj = arg_2_3
	arg_2_0.targetX, arg_2_0.targetY = var_2_0, var_2_1

	AudioMgr.instance:trigger(AudioEnum.UI.NormalLayerMove)
	arg_2_0.animatorPlayer:Play("start", arg_2_0.onStartAnimDone, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.onStartAnimDone, arg_2_0, 0.5)
	arg_2_0:startBlock()
end

function var_0_0.onStartAnimDone(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.onStartAnimDone, arg_3_0)
	transformhelper.setLocalPos(arg_3_0.trActor, arg_3_0.targetX, arg_3_0.targetY, RougeMapHelper.getOffsetZ(arg_3_0.targetY))
	arg_3_0.animatorPlayer:Play("stop", arg_3_0.onMovingDone, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.onMovingDone, arg_3_0, 0.8)
end

function var_0_0.onCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_0.waitViewClose then
		arg_4_0:moveToEnd()
	end
end

function var_0_0.moveToEnd(arg_5_0)
	if not RougeMapHelper.checkMapViewOnTop() then
		arg_5_0.waitViewClose = true

		return
	end

	arg_5_0.waitViewClose = nil

	if not RougeMapModel.instance:isNormalLayer() then
		logError("不在路线层了？")
		arg_5_0:onMoveToEndDoneCallback()

		return
	end

	local var_5_0 = RougeMapModel.instance:getEndNodeId()

	arg_5_0.movingToEnd = true

	arg_5_0:moveToMapItem(var_5_0, arg_5_0.onMoveToEndDoneCallback, arg_5_0)
end

function var_0_0.onMovingDone(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onMovingDone, arg_6_0)
	arg_6_0:endBlock()

	arg_6_0.movingTweenId = nil

	if arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackObj)
	end

	arg_6_0.callback = nil
	arg_6_0.callbackObj = nil

	if not arg_6_0.movingToEnd then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
	end

	arg_6_0.movingToEnd = nil
end

function var_0_0.onMoveToEndDoneCallback(arg_7_0)
	arg_7_0:endBlock()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndActorMoveToEnd)

	local var_7_0 = RougeMapModel.instance:getLayerCo().endStoryId

	if string.nilorempty(var_7_0) then
		arg_7_0:_updateMapInfo()

		return
	end

	local var_7_1 = string.splitToNumber(var_7_0, "|")

	if StoryModel.instance:isStoryFinished(var_7_1[1]) then
		arg_7_0:_updateMapInfo()

		return
	end

	StoryController.instance:playStories(var_7_1, nil, arg_7_0.onStoryPlayDone, arg_7_0)
end

function var_0_0.onStoryPlayDone(arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._updateMapInfo, arg_8_0, RougeMapEnum.WaitStoryCloseAnim)
end

function var_0_0._updateMapInfo(arg_9_0)
	RougeMapModel.instance:updateToNewMapInfo()
end

function var_0_0.destroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onMovingDone, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onStartAnimDone, arg_10_0)
	arg_10_0.animatorPlayer:Stop()
	TaskDispatcher.cancelTask(arg_10_0._updateMapInfo, arg_10_0)
	var_0_0.super.destroy(arg_10_0)
end

return var_0_0
