module("modules.logic.explore.map.unit.ExploreBaseMoveUnit", package.seeall)

slot0 = class("ExploreBaseMoveUnit", ExploreBaseDisplayUnit)

function slot0.canMove(slot0)
	return slot0.mo.isCanMove
end

function slot0.isMoving(slot0)
	return slot0._isMoving
end

function slot0.beginPick(slot0)
end

function slot0.endPick(slot0)
end

function slot0.setMoveDir(slot0, slot1)
	slot0._moveDirKey = slot1

	slot0:tryMoveByDir()
end

function slot0.tryMoveByDir(slot0)
	if slot0:checkUseMoveDir() and not slot0._isMoving and ExploreModel.instance:isHeroInControl() and UIBlockMgr.instance:isBlock() ~= true and ZProj.TouchEventMgr.Fobidden ~= true then
		slot0:_updateRealMoveDir()

		if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos + slot0._realMoveDir)) and slot2:isWalkable(ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)).height) then
			slot0:moveTo(slot4)
		else
			slot0:onCheckDir(slot0.nodePos, slot4)
		end
	end
end

function slot0.moveTo(slot0, slot1, slot2, slot3)
	slot0._tarUnitMO = nil

	slot0:_startMove(slot1, slot2, slot3)
end

function slot0.moveByPath(slot0, slot1, slot2, slot3, slot4, slot5)
	if #slot1 <= 0 then
		if slot4 then
			slot4(slot5, slot0.nodePos, slot0.nodePos)
		end

		return
	end

	slot0._lockDir = slot3
	slot0._moveDir = slot2

	if slot2 then
		slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, slot2)
	end

	slot0._pathArray = slot1
	slot0._walkDistance = slot6
	slot0._gotoCallback = slot4
	slot0._gotoCallbackObj = slot5
	slot0._endPos = slot1[slot0._walkDistance]

	slot0:_startMove2()
	slot0:onStartMove()
end

function slot0.reStartMoving(slot0)
	if slot0._isMoving then
		slot0:_startMove(slot0._endPos, slot0._gotoCallback, slot0._gotoCallbackObj)
	end
end

function slot0.getMoveDistance(slot0)
	if not slot0._isMoving then
		return 0
	end

	return slot0._walkDistance
end

function slot0.getRunTotalTime(slot0)
	if slot0._isMoving then
		return slot0._runTotalTime
	else
		return 0
	end
end

function slot0.stopMoving(slot0, slot1)
	if not slot0._isMoving then
		return
	end

	if not slot1 then
		if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0._nextNodePos)).nodeType == ExploreEnum.NodeType.Ice then
			return
		end

		slot0._isStopMoving = true

		return slot2
	end

	slot0._isMoving = false

	if slot0._moveDir then
		slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	slot0._moveDir = nil
	slot0._lockDir = nil
	slot0._nextWorldPos = nil
	slot0._nextNodePos = nil
	slot0._oldWorldPos = nil

	slot0:onEndMove()

	slot0._walkDistance = 0

	if slot0._tureDir then
		slot0:onDirChange(slot0._tureDir)

		slot0._tureDir = nil
	end

	TaskDispatcher.cancelTask(slot0.onMoveTick, slot0)
end

function slot0.onCheckDir(slot0, slot1, slot2)
end

function slot0.onCheckDirByPos(slot0, slot1, slot2)
end

function slot0.onDirChange(slot0, slot1)
end

function slot0.onMoveTick(slot0)
	slot0:_moving()
end

function slot0.onStartMove(slot0)
end

function slot0.onEndMove(slot0)
end

function slot0.moveSpeed(slot0)
	return ExploreAnimEnum.RoleSpeed.walk
end

function slot0.onDestroy(slot0)
	slot0._gotoCallback = nil
	slot0._gotoCallbackObj = nil
	slot0._endPos = nil
	slot0._exploreMap = nil

	TaskDispatcher.cancelTask(slot0.onMoveTick, slot0)
	uv0.super.onDestroy(slot0)
end

function slot0._startMove(slot0, slot1, slot2, slot3)
	slot0._gotoCallback = slot2
	slot0._gotoCallbackObj = slot3
	slot0._endPos = slot1

	if not slot0.nodePos or ExploreHelper.isPosEqual(slot0.nodePos, slot0._endPos) then
		slot0:_onEndMoveCallback()

		return
	end

	if not slot0._exploreMap then
		slot0._exploreMap = ExploreController.instance:getMap()
	end

	slot0._pathArray = slot0._exploreMap:startFindPath(slot0.nodePos, slot0._endPos)

	if #slot0._pathArray == 0 then
		slot0:_onEndMoveCallback()

		return
	end

	slot0._walkDistance = slot4

	slot0:_startMove2()
	slot0:onStartMove()
end

function slot0._startMove2(slot0)
	slot0._isMoving = true

	TaskDispatcher.runRepeat(slot0.onMoveTick, slot0, 0)
	slot0:onMoveTick()
end

function slot0._moving(slot0)
	if slot0._nextWorldPos then
		slot0._runStartTime = slot0._runStartTime + Time.deltaTime
		slot1 = Vector3.Lerp(slot0._oldWorldPos, slot0._nextWorldPos, math.min(1, slot0._runStartTime / slot0._runTotalTime))

		if slot0._runTotalTime <= slot0._runStartTime then
			slot0:setPosByNode(slot0._nextNodePos)

			slot0._nextWorldPos = nil

			if slot0._isStopMoving then
				slot0._pathArray = {}
				slot0._isStopMoving = nil
			end

			slot0:_moving()
		else
			slot0:setPos(slot1)
		end

		return
	end

	if #slot0._pathArray == 0 then
		slot0:_addMovePathByDir()
	end

	if #slot0._pathArray > 0 then
		slot0._nextNodePos = table.remove(slot0._pathArray)
		slot0._runTotalTime = slot0:moveSpeed()

		if ExploreHelper.isPosEqual(slot0.nodePos, slot0._nextNodePos) then
			return
		end

		if not slot0._lockDir and ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0._nextNodePos)):isWalkable(ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot1)).height) == false then
			slot0:_endMove()

			return
		end

		slot0._oldWorldPos = slot0.position
		slot0._nextWorldPos = ExploreHelper.tileToPos(slot0._nextNodePos)
		slot0._nextWorldPos.y = slot0._oldWorldPos.y
		slot0._runStartTime = 0

		slot0:onCheckDir(slot1, slot0._nextNodePos)
		slot0:onCheckDirByPos(slot0._oldWorldPos, slot0._nextWorldPos)

		return
	end

	slot0:_endMove()
end

function slot0._addMovePathByDir(slot0)
	if slot0:checkUseMoveDir() and ExploreModel.instance:isHeroInControl() and slot0:_checkInUIBlock() == false and ZProj.TouchEventMgr.Fobidden ~= true then
		slot0:_updateRealMoveDir()

		if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos + slot0._realMoveDir)) and slot2:isWalkable(ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)).height) then
			table.insert(slot0._pathArray, slot4)
		end
	end
end

slot0.ExploreMoveRequest = 13574

function slot0._checkInUIBlock(slot0)
	for slot4, slot5 in pairs(UIBlockMgr.instance._blockKeyDict) do
		if slot4 == UIBlockKey.MsgLock then
			for slot9, slot10 in pairs(GameGlobalMgr.instance:getMsgLockState()._blockCmdDict) do
				if uv0.ExploreMoveRequest ~= slot9 then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function slot0._updateRealMoveDir(slot0)
	if ExploreMapModel.instance.nowMapRotate % 360 < 0 then
		slot1 = slot1 + 360
	end

	slot0._realMoveDir = ExploreEnum.RoleMoveRotateDir[(ExploreEnum.RoleMoveRotateDirIndex[slot0._moveDirKey] + Mathf.Round(slot1 / 90)) % 4]
end

function slot0.checkUseMoveDir(slot0)
	return slot0._moveDirKey
end

function slot0._endMove(slot0)
	slot0._walkDistance = 0

	if slot0._tureDir then
		slot0:onDirChange(slot0._tureDir)

		slot0._tureDir = nil
	end

	TaskDispatcher.cancelTask(slot0.onMoveTick, slot0)

	slot0._nextNodePos = nil

	slot0:_onEndMoveCallback()
end

function slot0._onEndMoveCallback(slot0)
	slot0._isMoving = false

	if slot0._moveDir then
		slot0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	slot0._moveDir = nil
	slot0._moveDirKey = nil
	slot0._lockDir = nil

	slot0:onEndMove()

	if slot0._gotoCallback then
		slot0._gotoCallback(slot0._gotoCallbackObj, slot0.nodePos, slot0._endPos)
	end
end

return slot0
