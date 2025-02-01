module("modules.logic.rouge.map.map.itemcomp.RougeMapNormalLayerActorComp", package.seeall)

slot0 = class("RougeMapNormalLayerActorComp", RougeMapBaseActorComp)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.goActor)

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeActorMoveToEnd, slot0.moveToEnd, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.moveToMapItem(slot0, slot1, slot2, slot3)
	slot0.targetX, slot0.targetY, slot7 = slot0.map:getMapItem(slot1 or RougeMapModel.instance:getCurNode().nodeId):getActorPos()

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onNormalActorBeforeMove)
	slot0:clearTween()

	slot0.callback = slot2
	slot0.callbackObj = slot3

	AudioMgr.instance:trigger(AudioEnum.UI.NormalLayerMove)
	slot0.animatorPlayer:Play("start", slot0.onStartAnimDone, slot0)
	TaskDispatcher.runDelay(slot0.onStartAnimDone, slot0, 0.5)
	slot0:startBlock()
end

function slot0.onStartAnimDone(slot0)
	TaskDispatcher.cancelTask(slot0.onStartAnimDone, slot0)
	transformhelper.setLocalPos(slot0.trActor, slot0.targetX, slot0.targetY, RougeMapHelper.getOffsetZ(slot0.targetY))
	slot0.animatorPlayer:Play("stop", slot0.onMovingDone, slot0)
	TaskDispatcher.runDelay(slot0.onMovingDone, slot0, 0.8)
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot0.waitViewClose then
		slot0:moveToEnd()
	end
end

function slot0.moveToEnd(slot0)
	if not RougeMapHelper.checkMapViewOnTop() then
		slot0.waitViewClose = true

		return
	end

	slot0.waitViewClose = nil

	if not RougeMapModel.instance:isNormalLayer() then
		logError("不在路线层了？")
		slot0:onMoveToEndDoneCallback()

		return
	end

	slot0.movingToEnd = true

	slot0:moveToMapItem(RougeMapModel.instance:getEndNodeId(), slot0.onMoveToEndDoneCallback, slot0)
end

function slot0.onMovingDone(slot0)
	TaskDispatcher.cancelTask(slot0.onMovingDone, slot0)
	slot0:endBlock()

	slot0.movingTweenId = nil

	if slot0.callback then
		slot0.callback(slot0.callbackObj)
	end

	slot0.callback = nil
	slot0.callbackObj = nil

	if not slot0.movingToEnd then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
	end

	slot0.movingToEnd = nil
end

function slot0.onMoveToEndDoneCallback(slot0)
	slot0:endBlock()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onEndActorMoveToEnd)

	if string.nilorempty(RougeMapModel.instance:getLayerCo().endStoryId) then
		slot0:_updateMapInfo()

		return
	end

	if StoryModel.instance:isStoryFinished(string.splitToNumber(slot2, "|")[1]) then
		slot0:_updateMapInfo()

		return
	end

	StoryController.instance:playStories(slot3, nil, slot0.onStoryPlayDone, slot0)
end

function slot0.onStoryPlayDone(slot0)
	TaskDispatcher.runDelay(slot0._updateMapInfo, slot0, RougeMapEnum.WaitStoryCloseAnim)
end

function slot0._updateMapInfo(slot0)
	RougeMapModel.instance:updateToNewMapInfo()
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.onMovingDone, slot0)
	TaskDispatcher.cancelTask(slot0.onStartAnimDone, slot0)
	slot0.animatorPlayer:Stop()
	TaskDispatcher.cancelTask(slot0._updateMapInfo, slot0)
	uv0.super.destroy(slot0)
end

return slot0
