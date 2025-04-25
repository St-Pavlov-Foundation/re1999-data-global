module("modules.logic.room.entity.comp.RoomVehicleMoveComp", package.seeall)

slot0 = class("RoomVehicleMoveComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.moveSpeed = 0.2
	slot0.rotationSpeed = 90
	slot0.maxRotationAngle = 150
	slot0.endPathWaitTime = 0
	slot0.radius = 0.1
	slot0.crossloadMaxWaitTime = 15
	slot0._crossloadEndTime = 0
	slot0._endNodeResourcePointOffest = 0.42
	slot0._isStop = false
	slot0._isWalking = false
	slot0._moveParams = {}
	slot0._rotationParams = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.targetTrs = slot0.go.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._seeker = ZProj.AStarSeekWrap.Get(slot0.go)

	slot0:initVehicleParam()

	for slot5 = 0, 31 do
		slot0._seeker:SetTagTraversable(slot5, RoomAStarHelper.walkableTag(slot0._resId, slot5))
	end

	slot0:_delayFindPath()
end

function slot0.initVehicleParam(slot0)
	slot0._mo = slot0:getVehicleMO()
	slot0._resId = slot0._mo and slot0._mo.resourceId

	if slot0._mo and slot0._mo:getReplaceDefideCfg() then
		slot0.moveSpeed = slot1.moveSpeed * 0.01
		slot0.rotationSpeed = slot1.rotationSpeed
		slot0.endPathWaitTime = slot1.endPathWaitTime and slot1.endPathWaitTime * 0.001 or slot0.endPathWaitTime or 0
		slot0._useType = slot1.useType

		if slot1.radius and slot1.radius > 0 then
			slot2 = RoomBlockEnum.BlockSize * math.sqrt(3) * 0.5
			slot0._endNodeResourcePointOffest = math.max(0.1, (1 - math.min(slot1.radius * 0.01, slot2) / slot2) * 0.5)
		end
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
	if not gohelper.isNil(slot0._seeker) then
		slot0._seeker:RemoveOnPathCall()
	end

	slot0._seeker = nil
end

function slot0._reset(slot0)
	slot0._isInitPosition = false
	slot0._mo = slot0:getVehicleMO()
	slot0._resId = slot0._mo and slot0._mo.resourceId or slot0._resId

	if slot0.pathList and #slot0.pathList > 0 then
		for slot4 = #slot0.pathList, 1, -1 do
			RoomVectorPool.instance:recycle(slot0.pathList[slot4])
			table.remove(slot0.pathList, slot4)
		end
	end
end

function slot0._delayFindPath(slot0, slot1)
	slot0:_returnFindPath()

	slot0._delayFindPathing = true
	slot2 = slot1 or 0.5

	TaskDispatcher.runDelay(slot0._onDelayFindPath, slot0, slot2)

	if slot2 > 0 and (not slot0.pathList or #slot0.pathList <= 0) then
		slot0:_setIsWalking(false, slot1)
	end
end

function slot0._setIsWalking(slot0, slot1, slot2)
	if slot0._isWalking == slot1 then
		return
	end

	slot0._isWalking = slot1
	slot3 = slot0:getVehicleMO() or slot0._mo

	if slot3 and slot3:getReplaceDefideCfg() then
		slot5 = slot4.audioStop

		if slot0._isWalking then
			slot5 = slot4.audioWalk
		end

		if slot5 and slot5 ~= 0 then
			RoomHelper.audioExtendTrigger(slot5, slot0.go)
		end
	end

	if slot0.entity then
		slot0.entity:dispatchEvent(slot0._isWalking and RoomEvent.VehicleStartMove or RoomEvent.VehicleStopMove, slot2)
	end
end

function slot0._onDelayFindPath(slot0)
	slot0._delayFindPathing = false

	slot0:findPath()
end

function slot0._returnFindPath(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayFindPath, slot0)
end

function slot0.findPath(slot0)
	if not slot0._seeker then
		return
	end

	if not (slot0:getVehicleMO() or slot0._mo) then
		slot0:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有MO数据")

		return
	end

	slot3 = slot2:getCurNode()
	slot4 = slot2.enterDirection
	slot5, slot6, slot7 = slot2:findNextWeightNode()

	if not (slot5 and slot5.hexPoint) then
		slot0:_delayFindPath()
		logError("RoomVehicleMoveComp: 没有位置信息")

		return
	end

	if slot2:getAreaNode() and #slot9 > 1 and tabletool.indexOf(slot9, slot5) then
		slot0:_followTrunAround()
		slot0:_delayFindPath()

		return
	end

	slot10 = slot6

	if slot5:isEndNode() then
		if slot5 == slot3 then
			if slot2:findEndDir(slot5, slot6) == slot6 then
				slot10 = 0
			end

			slot6 = slot10
		end
	end

	slot11, slot12 = slot0:_isCrossload(slot3, slot4, slot7)

	if not slot11 then
		slot11, slot12 = slot0:_isCrossload(slot5, slot6, slot10)
	end

	if slot11 then
		slot13, slot14 = RoomCrossLoadController.instance:crossload(slot12, slot0._resId)
		slot15 = slot13 == slot0._resId

		if slot0._crossloadEndTime <= 0 then
			slot0._crossloadEndTime = Time.time + 15
		end

		if slot13 ~= slot0._resId and slot0._crossloadEndTime < Time.time then
			slot0._crossloadEndTime = 0

			slot2:moveToNode(slot5, slot6, true)
		end

		if slot13 ~= slot0._resId or not slot14 then
			slot0:_delayFindPath()

			return
		end
	else
		slot0._crossloadEndTime = 0
	end

	if slot5:isEndNode() and slot10 ~= slot6 then
		table.insert({
			slot10
		}, slot6)
	end

	if slot0._useType == RoomVehicleEnum.UseType.Aircraft then
		slot15 = slot5.hexPoint
		slot16, slot17 = HexMath.hexXYToPosXY(slot15.x, slot15.y, RoomBlockEnum.BlockSize)

		slot0:_setPathV3ListParam({
			nextNode = slot5,
			nextEnterDire = slot6,
			direList = slot13,
			isCrossLoad = slot11,
			buildingUid = slot12
		}, {
			Vector3(slot16, RoomBuildingEnum.VehicleInitOffestY, slot17)
		})
	else
		slot0:_startFindPath(slot14, slot5:isEndNode() and slot0._endNodeResourcePointOffest)
	end
end

function slot0._startFindPath(slot0, slot1, slot2)
	if slot0._seeker and slot1 and #slot1.direList > 0 then
		table.remove(slot1.direList, 1)

		slot5 = HexMath.resourcePointToPosition(ResourcePoint.New(slot1.nextNode.hexPoint, slot1.direList[1]), RoomBlockEnum.BlockSize, slot2 or 0.4)

		slot3:RemoveOnPathCall()
		slot3:AddOnPathCall(slot0._onPathCall, slot0, slot1)
		slot3:StartPath(slot0.targetTrs.localPosition, Vector3(slot5.x, 0, slot5.y))
	end
end

function slot0._onPathCall(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil

	if not slot3 then
		slot5 = RoomVectorPool.instance:packPosList(slot2)
	end

	slot0:_setPathV3ListParam(slot1, slot5, slot3)

	if slot3 then
		if #slot1.direList > 0 then
			slot0:_startFindPath(slot1)
		else
			slot0:_delayFindPath()
		end
	end
end

function slot0._setPathV3ListParam(slot0, slot1, slot2, slot3)
	if slot1 and slot1.nextNode and (#slot1.direList < 1 or not slot3) then
		slot4 = slot0:getVehicleMO() or slot0._mo
		slot5 = slot4.enterDirection

		slot4:moveToNode(slot1.nextNode, slot1.nextEnterDire, slot3 and true or false)

		slot6 = slot4:getReplaceDefideCfg()

		if slot1.isCrossLoad and RoomConfig.instance:getAudioExtendConfig(slot6.audioCrossload) then
			RoomHelper.audioExtendTrigger(slot6.audioCrossload, slot0.go)
		elseif slot1.nextEnterDire ~= slot5 and RoomConfig.instance:getAudioExtendConfig(slot6.audioTurn) then
			RoomHelper.audioExtendTrigger(slot6.audioTurn, slot0.go)
		end
	end

	if not slot3 then
		slot0.pathList = slot2

		slot0:_moveNext()
	end
end

function slot0._isCrossload(slot0, slot1, slot2, slot3)
	if slot1 then
		return RoomCrossLoadController.instance:isEnterBuilingCrossLoad(slot1.hexPoint.x, slot1.hexPoint.y, slot2, slot3)
	end
end

function slot0._moveNext(slot0)
	if not slot0._isInitPosition and #slot0.pathList > 1 then
		slot0._isInitPosition = true
		slot1 = slot0.pathList[1]
		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0.targetTrs)

		transformhelper.setLocalPos(slot0.targetTrs, slot2, slot1.y, slot4)

		if Vector3.Distance(Vector3(slot2, slot1.y, slot4), slot1) <= 0.001 then
			table.remove(slot0.pathList, 1)
			RoomVectorPool.instance:recycle(slot1)
		end
	end

	if #slot0.pathList > 0 then
		slot1 = slot0.pathList[1]

		table.remove(slot0.pathList, 1)
		slot0:_moveTo(slot1.x, slot1.y, slot1.z)
		RoomVectorPool.instance:recycle(slot1)
	end
end

function slot0._moveTo(slot0, slot1, slot2, slot3)
	slot0:_killMoveToTween()

	slot4 = slot0.targetTrs.position
	slot8 = slot0._moveParams
	slot8.originalX = slot4.x
	slot8.originalY = slot4.y
	slot8.originalZ = slot4.z
	slot8.x = slot1
	slot8.y = slot2
	slot8.z = slot3
	slot0._tweenId = slot0._scene.tween:tweenFloat(0, 1, Vector3.Distance(slot4, Vector3(slot1, slot2, slot3)) / slot0.moveSpeed, slot0._frameCallback, slot0._finishCallback, slot0, slot8)

	if math.abs(slot1 - slot8.originalX) > 1e-06 or math.abs(slot3 - slot8.originalZ) > 1e-06 then
		if Quaternion.Angle(slot0.targetTrs.rotation, Quaternion.LookRotation(Vector3(slot1 - slot8.originalX, slot2 - slot8.originalY, slot3 - slot8.originalZ), Vector3.up)) < slot0.maxRotationAngle then
			slot14 = slot0._rotationParams
			slot14.fromRotation = slot11
			slot14.toRotation = slot10
			slot14.angle = slot12
			slot0._tweenRotionId = slot0._scene.tween:tweenFloat(0, 1, slot12 / slot0.rotationSpeed, slot0._frameRotationCallback, nil, slot0, slot14)
		else
			slot0.targetTrs:LookAt(slot5)
			slot0.entity.vehiclefollow:updateFollower()

			if slot0._mo and slot0._mo:getReplaceDefideCfg() then
				RoomHelper.audioExtendTrigger(slot13.audioTurnAround, slot0.go)
			end
		end
	else
		slot0.targetTrs:LookAt(slot5)
	end

	slot0:_setIsWalking(true)
end

function slot0._killMoveToTween(slot0)
	if slot0._tweenId then
		slot0._scene.tween:killById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._tweenRotionId then
		slot0._scene.tween:killById(slot0._tweenRotionId)

		slot0._tweenRotionId = nil
	end
end

function slot0._frameCallback(slot0, slot1, slot2)
	transformhelper.setPos(slot0.targetTrs, slot2.originalX + (slot2.x - slot2.originalX) * slot1, slot2.originalY + (slot2.y - slot2.originalY) * slot1, slot2.originalZ + (slot2.z - slot2.originalZ) * slot1)
	slot0.entity.vehiclefollow:updateFollower()
end

function slot0._frameRotationCallback(slot0, slot1, slot2)
	slot0.targetTrs.rotation = Quaternion.RotateTowards(slot2.fromRotation, slot2.toRotation, slot1 * slot2.angle)
end

function slot0._finishCallback(slot0, slot1)
	transformhelper.setPos(slot0.targetTrs, slot1.x, slot1.y, slot1.z)
	slot0.entity.vehiclefollow:addFollerPathPos(slot1.x, slot1.y, slot1.z)

	if #slot0.pathList <= 0 then
		if slot0:_isCurNodeIsEndNode() then
			slot0:_followTrunAround()
		end

		if slot0.endPathWaitTime > 0 and slot2 then
			slot0:_delayFindPath(slot0.endPathWaitTime)
		else
			slot0:findPath()
		end
	else
		slot0:_moveNext()
	end
end

function slot0._followTrunAround(slot0)
	if slot0.entity.vehiclefollow:turnAround() then
		slot0._isInitPosition = false
	end
end

function slot0._isCurNodeIsEndNode(slot0)
	if (slot0:getVehicleMO() or slot0._mo) and slot1:getCurNode() and slot2:isEndNode() then
		return true
	end

	return false
end

function slot0.getIsStop(slot0)
	return slot0._isStop
end

function slot0.stop(slot0)
	if slot0._isStop then
		return
	end

	slot0._isStop = true

	if not gohelper.isNil(slot0._seeker) then
		slot0._seeker:RemoveOnPathCall()
	end

	slot0:_killMoveToTween()
	slot0:_returnFindPath()
	slot0:_setIsWalking(false)
end

function slot0.restart(slot0)
	if not slot0._isStop then
		return
	end

	slot0._isStop = false

	slot0:_reset()
	slot0:_delayFindPath()
end

function slot0.getVehicleMO(slot0)
	return slot0.entity:getVehicleMO()
end

function slot0.getSeeker(slot0)
	return slot0._seeker
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
	slot0:_returnFindPath()
	slot0:_killMoveToTween()
end

return slot0
