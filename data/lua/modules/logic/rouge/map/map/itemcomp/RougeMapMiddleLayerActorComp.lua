module("modules.logic.rouge.map.map.itemcomp.RougeMapMiddleLayerActorComp", package.seeall)

slot0 = class("RougeMapMiddleLayerActorComp", RougeMapBaseActorComp)

function slot0.initActor(slot0)
	uv0.super.initActor(slot0)

	slot0.pathList = {}
	slot0.lenRateList = {}

	slot0:refreshDir()
end

function slot0.refreshDir(slot0)
	slot0:initDirGo()

	slot2, slot3 = nil

	if RougeMapModel.instance:getCurPosIndex() == 0 then
		slot2 = RougeMapModel.instance:getMiddleLayerPosByIndex(1)
		slot3 = RougeMapModel.instance:getMiddleLayerPathPos(1)
	else
		slot4 = slot1 + 1
		slot2 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(RougeMapModel.instance:getPathIndex(slot4))
		slot3 = RougeMapModel.instance:getMiddleLayerPosByIndex(slot4)
	end

	slot0:_refreshDir(RougeMapHelper:getActorDir(RougeMapHelper.getAngle(slot2.x, slot2.y, slot3.x, slot3.y)))
end

function slot0.initDirGo(slot0)
	if slot0.directionGoMap then
		return
	end

	slot0.directionGoMap = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(RougeMapEnum.ActorDir) do
		slot0.directionGoMap[slot5] = gohelper.findChild(slot0.goActor, tostring(slot5))
	end
end

function slot0.moveToLeaveItem(slot0, slot1, slot2)
	slot0:clearTween()

	slot0.callback = slot1
	slot0.callbackObj = slot2

	if not RougeMapModel.instance:getMiddleLayerCo().leavePos then
		slot0:onMovingDone()

		return
	end

	tabletool.clear(slot0.pathList)
	tabletool.clear(slot0.lenRateList)
	RougeMapConfig.instance:getPathIndexList(slot3.pathDict, RougeMapModel.instance:getPathIndex(RougeMapModel.instance:getCurPosIndex() + 1), RougeMapModel.instance:getMiddleLayerLeavePathIndex(), slot0.pathList)

	slot9 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(RougeMapModel.instance:getMiddleLayerLeavePathIndex())

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = slot9,
		pieceId = RougeMapEnum.LeaveId
	})

	slot0.targetPos = slot9
	slot0.targetFacePos = slot3.leavePos
	slot0.lastStartIndex = nil
	slot0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapHelper.getMiddleLayerPathListLen(slot3, slot0.pathList, slot0.lenRateList) / RougeMapEnum.MoveSpeed, slot0.onMoveToPieceFrameCallback, slot0.onMovingDone, slot0, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	slot0:startBlock()
end

function slot0.moveToPieceItem(slot0, slot1, slot2, slot3)
	slot0:clearTween()

	slot0.callback = slot2
	slot0.callbackObj = slot3
	slot8 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(RougeMapModel.instance:getPathIndex(slot1.index + 1))

	if RougeMapModel.instance:getPathIndex(RougeMapModel.instance:getCurPosIndex() + 1) == RougeMapModel.instance:getPathIndex(slot1.index + 1) then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
			focusPos = slot8,
			pieceId = slot1.id
		})
		slot0:onMovingDone()

		return
	end

	tabletool.clear(slot0.pathList)
	tabletool.clear(slot0.lenRateList)

	slot9 = RougeMapModel.instance:getMiddleLayerCo()

	RougeMapConfig.instance:getPathIndexList(slot9.pathDict, slot4, slot5, slot0.pathList)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onMiddleActorBeforeMove, {
		focusPos = slot8,
		pieceId = slot1.id
	})

	slot0.targetPos = slot8
	slot0.targetFacePos = RougeMapModel.instance:getMiddleLayerPosByIndex(slot6)
	slot0.lastStartIndex = nil
	slot0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapHelper.getMiddleLayerPathListLen(slot9, slot0.pathList, slot0.lenRateList) / RougeMapEnum.MoveSpeed, slot0.onMoveToPieceFrameCallback, slot0.onMovingDone, slot0, nil, RougeMapEnum.CameraTweenLine)

	AudioMgr.instance:trigger(AudioEnum.UI.MoveAudio)
	slot0:startBlock()
end

function slot0.onMoveToPieceFrameCallback(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.lenRateList) do
		slot2 = slot6

		if slot1 < slot7 then
			break
		end
	end

	slot3 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(slot0.pathList[slot2])
	slot4 = RougeMapModel.instance:getMiddleLayerPathPosByPathIndex(slot0.pathList[slot2 + 1])

	if slot0.lastStartIndex ~= slot2 then
		slot0.lastStartIndex = slot2

		slot0:_refreshDir(RougeMapHelper:getActorDir(RougeMapHelper.getAngle(slot3.x, slot3.y, slot4.x, slot4.y)))
	end

	slot5 = slot0.lenRateList[slot2 - 1] or 0
	slot6 = (slot1 - slot5) / (slot0.lenRateList[slot2] - slot5)
	slot8 = Mathf.Lerp(slot3.y, slot4.y, slot6)

	transformhelper.setLocalPos(slot0.trActor, Mathf.Lerp(slot3.x, slot4.x, slot6), slot8, RougeMapHelper.getOffsetZ(slot8))
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorPosChange, slot0.trActor.position)
end

function slot0.onMovingDone(slot0)
	if slot0.targetFacePos and slot0.targetPos then
		slot0:_refreshDir(RougeMapHelper:getActorDir(RougeMapHelper.getAngle(slot0.targetPos.x, slot0.targetPos.y, slot0.targetFacePos.x, slot0.targetFacePos.y)))
	end

	uv0.super.onMovingDone(slot0)
end

function slot0._refreshDir(slot0, slot1)
	for slot5, slot6 in pairs(slot0.directionGoMap) do
		gohelper.setActive(slot6, slot5 == slot1)
	end
end

return slot0
