module("modules.logic.explore.map.unit.ExploreBaseMoveUnit", package.seeall)

local var_0_0 = class("ExploreBaseMoveUnit", ExploreBaseDisplayUnit)

function var_0_0.canMove(arg_1_0)
	return arg_1_0.mo.isCanMove
end

function var_0_0.isMoving(arg_2_0)
	return arg_2_0._isMoving
end

function var_0_0.beginPick(arg_3_0)
	return
end

function var_0_0.endPick(arg_4_0)
	return
end

function var_0_0.setMoveDir(arg_5_0, arg_5_1)
	arg_5_0._moveDirKey = arg_5_1

	arg_5_0:tryMoveByDir()
end

function var_0_0.tryMoveByDir(arg_6_0)
	if arg_6_0:checkUseMoveDir() and not arg_6_0._isMoving and ExploreModel.instance:isHeroInControl() and UIBlockMgr.instance:isBlock() ~= true and ZProj.TouchEventMgr.Fobidden ~= true then
		local var_6_0 = ExploreHelper.getKey(arg_6_0.nodePos)
		local var_6_1 = ExploreMapModel.instance:getNode(var_6_0).height

		arg_6_0:_updateRealMoveDir()

		local var_6_2 = arg_6_0.nodePos + arg_6_0._realMoveDir
		local var_6_3 = ExploreHelper.getKey(var_6_2)
		local var_6_4 = ExploreMapModel.instance:getNode(var_6_3)

		if var_6_4 and var_6_4:isWalkable(var_6_1) then
			arg_6_0:moveTo(var_6_2)
		else
			arg_6_0:onCheckDir(arg_6_0.nodePos, var_6_2)
		end
	end
end

function var_0_0.moveTo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._tarUnitMO = nil

	arg_7_0:_startMove(arg_7_1, arg_7_2, arg_7_3)
end

function var_0_0.moveByPath(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = #arg_8_1

	if var_8_0 <= 0 then
		if arg_8_4 then
			arg_8_4(arg_8_5, arg_8_0.nodePos, arg_8_0.nodePos)
		end

		return
	end

	arg_8_0._lockDir = arg_8_3
	arg_8_0._moveDir = arg_8_2

	if arg_8_2 then
		arg_8_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, arg_8_2)
	end

	arg_8_0._pathArray = arg_8_1
	arg_8_0._walkDistance = var_8_0
	arg_8_0._gotoCallback = arg_8_4
	arg_8_0._gotoCallbackObj = arg_8_5
	arg_8_0._endPos = arg_8_1[arg_8_0._walkDistance]

	arg_8_0:_startMove2()
	arg_8_0:onStartMove()
end

function var_0_0.reStartMoving(arg_9_0)
	if arg_9_0._isMoving then
		arg_9_0:_startMove(arg_9_0._endPos, arg_9_0._gotoCallback, arg_9_0._gotoCallbackObj)
	end
end

function var_0_0.getMoveDistance(arg_10_0)
	if not arg_10_0._isMoving then
		return 0
	end

	return arg_10_0._walkDistance
end

function var_0_0.getRunTotalTime(arg_11_0)
	if arg_11_0._isMoving then
		return arg_11_0._runTotalTime
	else
		return 0
	end
end

function var_0_0.stopMoving(arg_12_0, arg_12_1)
	if not arg_12_0._isMoving then
		return
	end

	if not arg_12_1 then
		local var_12_0 = arg_12_0._nextNodePos
		local var_12_1 = ExploreHelper.getKey(var_12_0)

		if ExploreMapModel.instance:getNode(var_12_1).nodeType == ExploreEnum.NodeType.Ice then
			return
		end

		arg_12_0._isStopMoving = true

		return var_12_0
	end

	arg_12_0._isMoving = false

	if arg_12_0._moveDir then
		arg_12_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	arg_12_0._moveDir = nil
	arg_12_0._lockDir = nil
	arg_12_0._nextWorldPos = nil
	arg_12_0._nextNodePos = nil
	arg_12_0._oldWorldPos = nil

	arg_12_0:onEndMove()

	arg_12_0._walkDistance = 0

	if arg_12_0._tureDir then
		arg_12_0:onDirChange(arg_12_0._tureDir)

		arg_12_0._tureDir = nil
	end

	TaskDispatcher.cancelTask(arg_12_0.onMoveTick, arg_12_0)
end

function var_0_0.onCheckDir(arg_13_0, arg_13_1, arg_13_2)
	return
end

function var_0_0.onCheckDirByPos(arg_14_0, arg_14_1, arg_14_2)
	return
end

function var_0_0.onDirChange(arg_15_0, arg_15_1)
	return
end

function var_0_0.onMoveTick(arg_16_0)
	arg_16_0:_moving()
end

function var_0_0.onStartMove(arg_17_0)
	return
end

function var_0_0.onEndMove(arg_18_0)
	return
end

function var_0_0.moveSpeed(arg_19_0)
	return ExploreAnimEnum.RoleSpeed.walk
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0._gotoCallback = nil
	arg_20_0._gotoCallbackObj = nil
	arg_20_0._endPos = nil
	arg_20_0._exploreMap = nil

	TaskDispatcher.cancelTask(arg_20_0.onMoveTick, arg_20_0)
	var_0_0.super.onDestroy(arg_20_0)
end

function var_0_0._startMove(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0._gotoCallback = arg_21_2
	arg_21_0._gotoCallbackObj = arg_21_3
	arg_21_0._endPos = arg_21_1

	if not arg_21_0.nodePos or ExploreHelper.isPosEqual(arg_21_0.nodePos, arg_21_0._endPos) then
		arg_21_0:_onEndMoveCallback()

		return
	end

	if not arg_21_0._exploreMap then
		arg_21_0._exploreMap = ExploreController.instance:getMap()
	end

	arg_21_0._pathArray = arg_21_0._exploreMap:startFindPath(arg_21_0.nodePos, arg_21_0._endPos)

	local var_21_0 = #arg_21_0._pathArray

	if var_21_0 == 0 then
		arg_21_0:_onEndMoveCallback()

		return
	end

	arg_21_0._walkDistance = var_21_0

	arg_21_0:_startMove2()
	arg_21_0:onStartMove()
end

function var_0_0._startMove2(arg_22_0)
	arg_22_0._isMoving = true

	TaskDispatcher.runRepeat(arg_22_0.onMoveTick, arg_22_0, 0)
	arg_22_0:onMoveTick()
end

function var_0_0._moving(arg_23_0)
	if arg_23_0._nextWorldPos then
		arg_23_0._runStartTime = arg_23_0._runStartTime + Time.deltaTime

		local var_23_0 = Vector3.Lerp(arg_23_0._oldWorldPos, arg_23_0._nextWorldPos, math.min(1, arg_23_0._runStartTime / arg_23_0._runTotalTime))

		if arg_23_0._runStartTime >= arg_23_0._runTotalTime then
			arg_23_0:setPosByNode(arg_23_0._nextNodePos)

			arg_23_0._nextWorldPos = nil

			if arg_23_0._isStopMoving then
				arg_23_0._pathArray = {}
				arg_23_0._isStopMoving = nil
			end

			arg_23_0:_moving()
		else
			arg_23_0:setPos(var_23_0)
		end

		return
	end

	if #arg_23_0._pathArray == 0 then
		arg_23_0:_addMovePathByDir()
	end

	if #arg_23_0._pathArray > 0 then
		local var_23_1 = arg_23_0.nodePos

		arg_23_0._nextNodePos = table.remove(arg_23_0._pathArray)
		arg_23_0._runTotalTime = arg_23_0:moveSpeed()

		if ExploreHelper.isPosEqual(var_23_1, arg_23_0._nextNodePos) then
			return
		end

		local var_23_2 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(var_23_1))
		local var_23_3 = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_23_0._nextNodePos))

		if not arg_23_0._lockDir and var_23_3:isWalkable(var_23_2.height) == false then
			arg_23_0:_endMove()

			return
		end

		arg_23_0._oldWorldPos = arg_23_0.position
		arg_23_0._nextWorldPos = ExploreHelper.tileToPos(arg_23_0._nextNodePos)
		arg_23_0._nextWorldPos.y = arg_23_0._oldWorldPos.y
		arg_23_0._runStartTime = 0

		arg_23_0:onCheckDir(var_23_1, arg_23_0._nextNodePos)
		arg_23_0:onCheckDirByPos(arg_23_0._oldWorldPos, arg_23_0._nextWorldPos)

		return
	end

	arg_23_0:_endMove()
end

function var_0_0._addMovePathByDir(arg_24_0)
	if arg_24_0:checkUseMoveDir() and ExploreModel.instance:isHeroInControl() and arg_24_0:_checkInUIBlock() == false and ZProj.TouchEventMgr.Fobidden ~= true then
		local var_24_0 = ExploreHelper.getKey(arg_24_0.nodePos)
		local var_24_1 = ExploreMapModel.instance:getNode(var_24_0).height

		arg_24_0:_updateRealMoveDir()

		local var_24_2 = arg_24_0.nodePos + arg_24_0._realMoveDir
		local var_24_3 = ExploreHelper.getKey(var_24_2)
		local var_24_4 = ExploreMapModel.instance:getNode(var_24_3)

		if var_24_4 and var_24_4:isWalkable(var_24_1) then
			table.insert(arg_24_0._pathArray, var_24_2)
		end
	end
end

var_0_0.ExploreMoveRequest = 13574

function var_0_0._checkInUIBlock(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(UIBlockMgr.instance._blockKeyDict) do
		if iter_25_0 == UIBlockKey.MsgLock then
			for iter_25_2, iter_25_3 in pairs(GameGlobalMgr.instance:getMsgLockState()._blockCmdDict) do
				if var_0_0.ExploreMoveRequest ~= iter_25_2 then
					return true
				end
			end
		else
			return true
		end
	end

	return false
end

function var_0_0._updateRealMoveDir(arg_26_0)
	local var_26_0 = ExploreMapModel.instance.nowMapRotate % 360

	if var_26_0 < 0 then
		var_26_0 = var_26_0 + 360
	end

	local var_26_1 = Mathf.Round(var_26_0 / 90)
	local var_26_2 = (ExploreEnum.RoleMoveRotateDirIndex[arg_26_0._moveDirKey] + var_26_1) % 4

	arg_26_0._realMoveDir = ExploreEnum.RoleMoveRotateDir[var_26_2]
end

function var_0_0.checkUseMoveDir(arg_27_0)
	return arg_27_0._moveDirKey
end

function var_0_0._endMove(arg_28_0)
	arg_28_0._walkDistance = 0

	if arg_28_0._tureDir then
		arg_28_0:onDirChange(arg_28_0._tureDir)

		arg_28_0._tureDir = nil
	end

	TaskDispatcher.cancelTask(arg_28_0.onMoveTick, arg_28_0)

	arg_28_0._nextNodePos = nil

	arg_28_0:_onEndMoveCallback()
end

function var_0_0._onEndMoveCallback(arg_29_0)
	arg_29_0._isMoving = false

	if arg_29_0._moveDir then
		arg_29_0.animComp:setInteger(ExploreAnimEnum.RoleAnimKey.MoveDir, -1)
	end

	arg_29_0._moveDir = nil
	arg_29_0._moveDirKey = nil
	arg_29_0._lockDir = nil

	arg_29_0:onEndMove()

	if arg_29_0._gotoCallback then
		arg_29_0._gotoCallback(arg_29_0._gotoCallbackObj, arg_29_0.nodePos, arg_29_0._endPos)
	end
end

return var_0_0
