module("modules.logic.rouge.map.map.RougePathSelectMap", package.seeall)

slot0 = class("RougePathSelectMap", RougeBaseMap)

function slot0.initMap(slot0)
	uv0.super.initMap(slot0)
	RougeMapModel.instance:setCameraSize(RougeMapConfig.instance:getPathSelectInitCameraSize())

	slot2 = RougeMapModel.instance:getMapSize()

	transformhelper.setLocalPos(slot0.mapTransform, -slot2.x / 2, slot2.y / 2, RougeMapEnum.OffsetZ.Map)
end

function slot0.createMap(slot0)
	slot0.actorComp = nil

	uv0.super.createMap(slot0)
	TaskDispatcher.runDelay(slot0.focusToTarget, slot0, RougeMapEnum.PathSelectMapWaitTime)
end

function slot0.focusToTarget(slot0)
	slot0:clearTween()

	slot1 = RougeMapModel.instance:getPathSelectCo()
	slot2 = string.splitToNumber(slot1.focusMapPos, "#")
	slot0.movingTweenId = ZProj.TweenHelper.DOLocalMove(slot0.mapTransform, slot2[1], slot2[2], RougeMapEnum.OffsetZ.Map, RougeMapEnum.RevertDuration, slot0.onMovingDone, slot0)

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocus, slot1.focusCameraSize)
end

function slot0.onMovingDone(slot0)
	slot0.movingTweenId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onPathSelectMapFocusDone)
end

function slot0.clearTween(slot0)
	if slot0.movingTweenId then
		ZProj.TweenHelper.KillById(slot0.movingTweenId)
	end

	slot0.movingTweenId = nil
end

function slot0.destroy(slot0)
	slot0:clearTween()
	TaskDispatcher.cancelTask(slot0.focusToTarget, slot0)
	uv0.super.destroy(slot0)
end

return slot0
