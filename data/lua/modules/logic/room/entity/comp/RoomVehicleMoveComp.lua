module("modules.logic.room.entity.comp.RoomVehicleMoveComp", package.seeall)

local var_0_0 = class("RoomVehicleMoveComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.moveSpeed = 0.2
	arg_1_0.rotationSpeed = 90
	arg_1_0.maxRotationAngle = 150
	arg_1_0.endPathWaitTime = 0
	arg_1_0.radius = 0.1
	arg_1_0.crossloadMaxWaitTime = 15
	arg_1_0._crossloadEndTime = 0
	arg_1_0._endNodeResourcePointOffest = 0.42
	arg_1_0._isStop = false
	arg_1_0._isWalking = false
	arg_1_0._moveParams = {}
	arg_1_0._rotationParams = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.targetTrs = arg_2_0.go.transform
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._seeker = ZProj.AStarSeekWrap.Get(arg_2_0.go)

	arg_2_0:initVehicleParam()

	for iter_2_0 = 0, 31 do
		arg_2_0._seeker:SetTagTraversable(iter_2_0, RoomAStarHelper.walkableTag(arg_2_0._resId, iter_2_0))
	end

	arg_2_0:_delayFindPath()
end

function var_0_0.initVehicleParam(arg_3_0)
	arg_3_0._mo = arg_3_0:getVehicleMO()
	arg_3_0._resId = arg_3_0._mo and arg_3_0._mo.resourceId

	local var_3_0 = arg_3_0._mo and arg_3_0._mo:getReplaceDefideCfg()

	if var_3_0 then
		arg_3_0.moveSpeed = var_3_0.moveSpeed * 0.01
		arg_3_0.rotationSpeed = var_3_0.rotationSpeed
		arg_3_0.endPathWaitTime = var_3_0.endPathWaitTime and var_3_0.endPathWaitTime * 0.001 or arg_3_0.endPathWaitTime or 0
		arg_3_0._useType = var_3_0.useType

		if var_3_0.radius and var_3_0.radius > 0 then
			local var_3_1 = RoomBlockEnum.BlockSize * math.sqrt(3) * 0.5
			local var_3_2 = (1 - math.min(var_3_0.radius * 0.01, var_3_1) / var_3_1) * 0.5

			arg_3_0._endNodeResourcePointOffest = math.max(0.1, var_3_2)
		end
	end
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	if not gohelper.isNil(arg_5_0._seeker) then
		arg_5_0._seeker:RemoveOnPathCall()
	end

	arg_5_0._seeker = nil
end

function var_0_0._reset(arg_6_0)
	arg_6_0._isInitPosition = false
	arg_6_0._mo = arg_6_0:getVehicleMO()
	arg_6_0._resId = arg_6_0._mo and arg_6_0._mo.resourceId or arg_6_0._resId

	if arg_6_0.pathList and #arg_6_0.pathList > 0 then
		for iter_6_0 = #arg_6_0.pathList, 1, -1 do
			RoomVectorPool.instance:recycle(arg_6_0.pathList[iter_6_0])
			table.remove(arg_6_0.pathList, iter_6_0)
		end
	end
end

function var_0_0._delayFindPath(arg_7_0, arg_7_1)
	arg_7_0:_returnFindPath()

	arg_7_0._delayFindPathing = true

	local var_7_0 = arg_7_1 or 0.5

	TaskDispatcher.runDelay(arg_7_0._onDelayFindPath, arg_7_0, var_7_0)

	if var_7_0 > 0 and (not arg_7_0.pathList or #arg_7_0.pathList <= 0) then
		arg_7_0:_setIsWalking(false, arg_7_1)
	end
end

function var_0_0._setIsWalking(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._isWalking == arg_8_1 then
		return
	end

	arg_8_0._isWalking = arg_8_1

	local var_8_0 = arg_8_0:getVehicleMO() or arg_8_0._mo
	local var_8_1 = var_8_0 and var_8_0:getReplaceDefideCfg()

	if var_8_1 then
		local var_8_2 = var_8_1.audioStop

		if arg_8_0._isWalking then
			var_8_2 = var_8_1.audioWalk
		end

		if var_8_2 and var_8_2 ~= 0 then
			RoomHelper.audioExtendTrigger(var_8_2, arg_8_0.go)
		end
	end

	if arg_8_0.entity then
		local var_8_3 = arg_8_0._isWalking and RoomEvent.VehicleStartMove or RoomEvent.VehicleStopMove

		arg_8_0.entity:dispatchEvent(var_8_3, arg_8_2)
	end
end

function var_0_0._onDelayFindPath(arg_9_0)
	arg_9_0._delayFindPathing = false

	arg_9_0:findPath()
end

function var_0_0._returnFindPath(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onDelayFindPath, arg_10_0)
end

function var_0_0.findPath(arg_11_0)
	if not arg_11_0._seeker then
		return
	end

	local var_11_0 = arg_11_0:getVehicleMO() or arg_11_0._mo

	if not var_11_0 then
		arg_11_0:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有MO数据")

		return
	end

	local var_11_1 = var_11_0:getCurNode()
	local var_11_2 = var_11_0.enterDirection
	local var_11_3, var_11_4, var_11_5 = var_11_0:findNextWeightNode()

	if not (var_11_3 and var_11_3.hexPoint) then
		arg_11_0:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有位置信息")

		return
	end

	local var_11_6 = var_11_0:getAreaNode()

	if var_11_6 and #var_11_6 > 1 and tabletool.indexOf(var_11_6, var_11_3) then
		arg_11_0:_followTrunAround()
		arg_11_0:_delayFindPath()

		return
	end

	local var_11_7 = var_11_4

	if var_11_3:isEndNode() then
		var_11_7 = var_11_0:findEndDir(var_11_3, var_11_4)

		if var_11_3 == var_11_1 then
			if var_11_7 == var_11_4 then
				var_11_7 = 0
			end

			var_11_4 = var_11_7
		end
	end

	local var_11_8, var_11_9 = arg_11_0:_isCrossload(var_11_1, var_11_2, var_11_5)

	if not var_11_8 then
		var_11_8, var_11_9 = arg_11_0:_isCrossload(var_11_3, var_11_4, var_11_7)
	end

	if var_11_8 then
		local var_11_10, var_11_11 = RoomCrossLoadController.instance:crossload(var_11_9, arg_11_0._resId)
		local var_11_12

		var_11_12 = var_11_10 == arg_11_0._resId

		if arg_11_0._crossloadEndTime <= 0 then
			arg_11_0._crossloadEndTime = Time.time + 15
		end

		if var_11_10 ~= arg_11_0._resId and arg_11_0._crossloadEndTime < Time.time then
			arg_11_0._crossloadEndTime = 0

			var_11_0:moveToNode(var_11_3, var_11_4, true)
		end

		if var_11_10 ~= arg_11_0._resId or not var_11_11 then
			arg_11_0:_delayFindPath()

			return
		end
	else
		arg_11_0._crossloadEndTime = 0
	end

	local var_11_13 = {
		var_11_7
	}

	if var_11_3:isEndNode() and var_11_7 ~= var_11_4 then
		table.insert(var_11_13, var_11_4)
	end

	local var_11_14 = {
		nextNode = var_11_3,
		nextEnterDire = var_11_4,
		direList = var_11_13,
		isCrossLoad = var_11_8,
		buildingUid = var_11_9
	}

	if arg_11_0._useType == RoomVehicleEnum.UseType.Aircraft then
		local var_11_15 = var_11_3.hexPoint
		local var_11_16, var_11_17 = HexMath.hexXYToPosXY(var_11_15.x, var_11_15.y, RoomBlockEnum.BlockSize)
		local var_11_18 = {
			Vector3(var_11_16, RoomBuildingEnum.VehicleInitOffestY, var_11_17)
		}

		arg_11_0:_setPathV3ListParam(var_11_14, var_11_18)
	else
		arg_11_0:_startFindPath(var_11_14, var_11_3:isEndNode() and arg_11_0._endNodeResourcePointOffest)
	end
end

function var_0_0._startFindPath(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._seeker

	if var_12_0 and arg_12_1 and #arg_12_1.direList > 0 then
		local var_12_1 = arg_12_1.direList[1]

		table.remove(arg_12_1.direList, 1)

		local var_12_2 = HexMath.resourcePointToPosition(ResourcePoint.New(arg_12_1.nextNode.hexPoint, var_12_1), RoomBlockEnum.BlockSize, arg_12_2 or 0.4)

		var_12_0:RemoveOnPathCall()
		var_12_0:AddOnPathCall(arg_12_0._onPathCall, arg_12_0, arg_12_1)
		var_12_0:StartPath(arg_12_0.targetTrs.localPosition, Vector3(var_12_2.x, 0, var_12_2.y))
	end
end

function var_0_0._onPathCall(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0

	if not arg_13_3 then
		var_13_0 = RoomVectorPool.instance:packPosList(arg_13_2)
	end

	arg_13_0:_setPathV3ListParam(arg_13_1, var_13_0, arg_13_3)

	if arg_13_3 then
		if #arg_13_1.direList > 0 then
			arg_13_0:_startFindPath(arg_13_1)
		else
			arg_13_0:_delayFindPath()
		end
	end
end

function var_0_0._setPathV3ListParam(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 and arg_14_1.nextNode and (#arg_14_1.direList < 1 or not arg_14_3) then
		local var_14_0 = arg_14_0:getVehicleMO() or arg_14_0._mo
		local var_14_1 = var_14_0.enterDirection

		var_14_0:moveToNode(arg_14_1.nextNode, arg_14_1.nextEnterDire, arg_14_3 and true or false)

		local var_14_2 = var_14_0:getReplaceDefideCfg()

		if arg_14_1.isCrossLoad and RoomConfig.instance:getAudioExtendConfig(var_14_2.audioCrossload) then
			RoomHelper.audioExtendTrigger(var_14_2.audioCrossload, arg_14_0.go)
		elseif arg_14_1.nextEnterDire ~= var_14_1 and RoomConfig.instance:getAudioExtendConfig(var_14_2.audioTurn) then
			RoomHelper.audioExtendTrigger(var_14_2.audioTurn, arg_14_0.go)
		end
	end

	if not arg_14_3 then
		arg_14_0.pathList = arg_14_2

		arg_14_0:_moveNext()
	end
end

function var_0_0._isCrossload(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		return RoomCrossLoadController.instance:isEnterBuilingCrossLoad(arg_15_1.hexPoint.x, arg_15_1.hexPoint.y, arg_15_2, arg_15_3)
	end
end

function var_0_0._moveNext(arg_16_0)
	if not arg_16_0._isInitPosition and #arg_16_0.pathList > 1 then
		arg_16_0._isInitPosition = true

		local var_16_0 = arg_16_0.pathList[1]
		local var_16_1, var_16_2, var_16_3 = transformhelper.getLocalPos(arg_16_0.targetTrs)

		transformhelper.setLocalPos(arg_16_0.targetTrs, var_16_1, var_16_0.y, var_16_3)

		if Vector3.Distance(Vector3(var_16_1, var_16_0.y, var_16_3), var_16_0) <= 0.001 then
			table.remove(arg_16_0.pathList, 1)
			RoomVectorPool.instance:recycle(var_16_0)
		end
	end

	if #arg_16_0.pathList > 0 then
		local var_16_4 = arg_16_0.pathList[1]

		table.remove(arg_16_0.pathList, 1)
		arg_16_0:_moveTo(var_16_4.x, var_16_4.y, var_16_4.z)
		RoomVectorPool.instance:recycle(var_16_4)
	end
end

function var_0_0._moveTo(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0:_killMoveToTween()

	local var_17_0 = arg_17_0.targetTrs.position
	local var_17_1 = Vector3(arg_17_1, arg_17_2, arg_17_3)
	local var_17_2 = Vector3.Distance(var_17_0, var_17_1) / arg_17_0.moveSpeed
	local var_17_3 = arg_17_0._moveParams

	var_17_3.originalX = var_17_0.x
	var_17_3.originalY = var_17_0.y
	var_17_3.originalZ = var_17_0.z
	var_17_3.x = arg_17_1
	var_17_3.y = arg_17_2
	var_17_3.z = arg_17_3
	arg_17_0._tweenId = arg_17_0._scene.tween:tweenFloat(0, 1, var_17_2, arg_17_0._frameCallback, arg_17_0._finishCallback, arg_17_0, var_17_3)

	if math.abs(arg_17_1 - var_17_3.originalX) > 1e-06 or math.abs(arg_17_3 - var_17_3.originalZ) > 1e-06 then
		local var_17_4 = Vector3(arg_17_1 - var_17_3.originalX, arg_17_2 - var_17_3.originalY, arg_17_3 - var_17_3.originalZ)
		local var_17_5 = Quaternion.LookRotation(var_17_4, Vector3.up)
		local var_17_6 = arg_17_0.targetTrs.rotation
		local var_17_7 = Quaternion.Angle(var_17_6, var_17_5)

		if var_17_7 < arg_17_0.maxRotationAngle then
			local var_17_8 = var_17_7 / arg_17_0.rotationSpeed
			local var_17_9 = arg_17_0._rotationParams

			var_17_9.fromRotation = var_17_6
			var_17_9.toRotation = var_17_5
			var_17_9.angle = var_17_7
			arg_17_0._tweenRotionId = arg_17_0._scene.tween:tweenFloat(0, 1, var_17_8, arg_17_0._frameRotationCallback, nil, arg_17_0, var_17_9)
		else
			arg_17_0.targetTrs:LookAt(var_17_1)
			arg_17_0.entity.vehiclefollow:updateFollower()

			local var_17_10 = arg_17_0._mo and arg_17_0._mo:getReplaceDefideCfg()

			if var_17_10 then
				RoomHelper.audioExtendTrigger(var_17_10.audioTurnAround, arg_17_0.go)
			end
		end
	else
		arg_17_0.targetTrs:LookAt(var_17_1)
	end

	arg_17_0:_setIsWalking(true)
end

function var_0_0._killMoveToTween(arg_18_0)
	if arg_18_0._tweenId then
		arg_18_0._scene.tween:killById(arg_18_0._tweenId)

		arg_18_0._tweenId = nil
	end

	if arg_18_0._tweenRotionId then
		arg_18_0._scene.tween:killById(arg_18_0._tweenRotionId)

		arg_18_0._tweenRotionId = nil
	end
end

function var_0_0._frameCallback(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.originalX + (arg_19_2.x - arg_19_2.originalX) * arg_19_1
	local var_19_1 = arg_19_2.originalY + (arg_19_2.y - arg_19_2.originalY) * arg_19_1
	local var_19_2 = arg_19_2.originalZ + (arg_19_2.z - arg_19_2.originalZ) * arg_19_1

	transformhelper.setPos(arg_19_0.targetTrs, var_19_0, var_19_1, var_19_2)
	arg_19_0.entity.vehiclefollow:updateFollower()
end

function var_0_0._frameRotationCallback(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = Quaternion.RotateTowards(arg_20_2.fromRotation, arg_20_2.toRotation, arg_20_1 * arg_20_2.angle)

	arg_20_0.targetTrs.rotation = var_20_0
end

function var_0_0._finishCallback(arg_21_0, arg_21_1)
	transformhelper.setPos(arg_21_0.targetTrs, arg_21_1.x, arg_21_1.y, arg_21_1.z)
	arg_21_0.entity.vehiclefollow:addFollerPathPos(arg_21_1.x, arg_21_1.y, arg_21_1.z)

	if #arg_21_0.pathList <= 0 then
		local var_21_0 = arg_21_0:_isCurNodeIsEndNode()

		if var_21_0 then
			arg_21_0:_followTrunAround()
		end

		if arg_21_0.endPathWaitTime > 0 and var_21_0 then
			arg_21_0:_delayFindPath(arg_21_0.endPathWaitTime)
		else
			arg_21_0:findPath()
		end
	else
		arg_21_0:_moveNext()
	end
end

function var_0_0._followTrunAround(arg_22_0)
	if arg_22_0.entity.vehiclefollow:turnAround() then
		arg_22_0._isInitPosition = false
	end
end

function var_0_0._isCurNodeIsEndNode(arg_23_0)
	local var_23_0 = arg_23_0:getVehicleMO() or arg_23_0._mo

	if var_23_0 then
		local var_23_1 = var_23_0:getCurNode()

		if var_23_1 and var_23_1:isEndNode() then
			return true
		end
	end

	return false
end

function var_0_0.getIsStop(arg_24_0)
	return arg_24_0._isStop
end

function var_0_0.stop(arg_25_0)
	if arg_25_0._isStop then
		return
	end

	arg_25_0._isStop = true

	if not gohelper.isNil(arg_25_0._seeker) then
		arg_25_0._seeker:RemoveOnPathCall()
	end

	arg_25_0:_killMoveToTween()
	arg_25_0:_returnFindPath()
	arg_25_0:_setIsWalking(false)
end

function var_0_0.restart(arg_26_0)
	if not arg_26_0._isStop then
		return
	end

	arg_26_0._isStop = false

	arg_26_0:_reset()
	arg_26_0:_delayFindPath()
end

function var_0_0.getVehicleMO(arg_27_0)
	return arg_27_0.entity:getVehicleMO()
end

function var_0_0.getSeeker(arg_28_0)
	return arg_28_0._seeker
end

function var_0_0.beforeDestroy(arg_29_0)
	arg_29_0:removeEventListeners()
	arg_29_0:_returnFindPath()
	arg_29_0:_killMoveToTween()
end

return var_0_0
