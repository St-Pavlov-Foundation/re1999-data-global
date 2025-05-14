module("modules.logic.room.entity.comp.RoomCharacterInteractActionComp", package.seeall)

local var_0_0 = class("RoomCharacterInteractActionComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._scene = RoomCameraController.instance:getRoomScene()
	arg_1_0._followPathData = RoomVehicleFollowPathData.New(3)
	arg_1_0._roomVectorPool = RoomVectorPool.instance
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._scene = RoomCameraController.instance:getRoomScene()
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
	arg_5_0:endIneract()
end

function var_0_0.startMove(arg_6_0)
	return
end

function var_0_0._findPath(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._moveToHeroPointName = arg_7_3

	local var_7_0 = arg_7_0.entity.charactermove:getSeeker()

	if ZProj.AStarPathBridge.HasPossiblePath(arg_7_1, arg_7_2, var_7_0:GetTag()) then
		arg_7_0._scene.path:tryGetPath(arg_7_0.entity:getMO(), arg_7_1, arg_7_2, arg_7_0._onPathCall, arg_7_0)

		return
	else
		arg_7_0:_tryPlacePointByName(arg_7_0._moveToHeroPointName)
	end
end

function var_0_0._onPathCall(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_3 then
		local var_8_0 = arg_8_0._roomVectorPool:packPosList(arg_8_2)

		arg_8_0:_setPathDataPosList(var_8_0)
	else
		arg_8_0:_setPathDataPosList(nil)
		logNormal("Room pathfinding Error : " .. tostring(arg_8_4))
	end

	if arg_8_0._followPathData:getPosCount() > 0 then
		local var_8_1 = arg_8_0.entity:getMO():getMoveSpeed() * 0.2

		arg_8_0:_killTween()

		local var_8_2 = arg_8_0._followPathData:getPathDistance() / var_8_1

		arg_8_0._moveFromPosition = arg_8_0._followPathData:getFirstPos()
		arg_8_0._tweenMoveId = arg_8_0._scene.tween:tweenFloat(0, 1, var_8_2, arg_8_0._frameMoveCallback, arg_8_0._finishMoveCallback, arg_8_0)

		arg_8_0:_clearResetXYZ()
	else
		arg_8_0:_tryPlacePointByName(arg_8_0._moveToHeroPointName)
	end
end

function var_0_0._setPathDataPosList(arg_9_0, arg_9_1)
	if arg_9_0._followPathData:getPosCount() > 0 then
		local var_9_0 = arg_9_0._followPathData._pathPosList

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_9_0._roomVectorPool:recycle(iter_9_1)
		end

		arg_9_0._followPathData:clear()
	end

	if arg_9_1 and #arg_9_1 > 0 then
		for iter_9_2 = #arg_9_1, 1, -1 do
			arg_9_0._followPathData:addPathPos(arg_9_1[iter_9_2])
		end
	end
end

function var_0_0._killTween(arg_10_0)
	if arg_10_0._tweenMoveId then
		arg_10_0._scene.tween:killById(arg_10_0._tweenMoveId)

		arg_10_0._tweenMoveId = nil
	end
end

function var_0_0._framePointCallback(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._buildingEntity.interactComp:getPointGOTrsByName(arg_11_0._interactHeroPointName)

	if not var_11_0 then
		return
	end

	arg_11_0._isUpdatePointPiont = true

	local var_11_1, var_11_2, var_11_3 = transformhelper.getPos(var_11_0)

	arg_11_0.entity:setLocalPos(var_11_1, var_11_2, var_11_3)
end

function var_0_0._frameMoveCallback(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._followPathData:getPathDistance() * arg_12_1
	local var_12_1 = arg_12_0._followPathData:getPosByDistance(var_12_0)
	local var_12_2 = arg_12_0._moveFromPosition

	arg_12_0._moveFromPosition = var_12_1

	arg_12_0.entity.charactermove:forcePositionAndLookDir(var_12_1, arg_12_0.entity.charactermove:getMoveToLookDirByPos(var_12_2, var_12_1), RoomCharacterEnum.CharacterMoveState.Move)
	arg_12_0:_setMOPosXYZ(var_12_1.x, var_12_1.y, var_12_1.z)
end

function var_0_0._finishMoveCallback(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.entity.charactermove:clearForcePositionAndLookDir()
	arg_13_0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function var_0_0._finishCallback(arg_14_0, arg_14_1, arg_14_2)
	return
end

function var_0_0.startInteract(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._siteId = arg_15_2
	arg_15_0._buildingUid = arg_15_1
	arg_15_0._buildingEntity = arg_15_0._scene.buildingmgr:getBuildingEntity(arg_15_1)
	arg_15_0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(arg_15_1)
	arg_15_0._interactHeroPointName = RoomEnum.EntityChildKey.CritterPointList[arg_15_2]
	arg_15_0._interactStartPointName = RoomEnum.EntityChildKey.InteractStartPointList[arg_15_2]
	arg_15_0._interactBuildingMO = arg_15_0._buildingMO:getInteractMO()
	arg_15_0._isFindPath = arg_15_0._interactBuildingMO:isFindPath()
	arg_15_0._showTime = arg_15_3

	if not arg_15_0._resetPosX then
		local var_15_0, var_15_1, var_15_2 = arg_15_0.entity:getLocalPosXYZ()

		arg_15_0:_setResetXYZ(var_15_0, var_15_1, var_15_2)
	end

	local var_15_3 = math.random() * 0.5

	arg_15_0._characterMO = arg_15_0.entity:getMO()

	if arg_15_0._characterMO then
		arg_15_0._characterMO:setLockTime(arg_15_3 + var_15_3)
		arg_15_0._characterMO:setIsFreeze(true)
	end

	arg_15_0:_killTween()
	arg_15_0:_stopFinishTask()
	arg_15_0:_startFinishTask(arg_15_3 + var_15_3 + 0.1)
	TaskDispatcher.cancelTask(arg_15_0._onStartInteract, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._onStartInteract, arg_15_0, var_15_3)
end

function var_0_0._onStartInteract(arg_16_0)
	if arg_16_0._isFindPath then
		local var_16_0, var_16_1, var_16_2 = arg_16_0:_getPosXYZByPointName(arg_16_0._interactStartPointName)
		local var_16_3, var_16_4, var_16_5 = arg_16_0:_getPosXYZByPointName(arg_16_0._interactHeroPointName)

		if var_16_0 and var_16_3 then
			arg_16_0:_tryPlacePointByName(arg_16_0._interactStartPointName)
			arg_16_0:_findPath(Vector3(var_16_0, var_16_1, var_16_2), Vector3(var_16_3, var_16_4, var_16_5), arg_16_0._interactHeroPointName)
		else
			arg_16_0:_tryPlacePointByName(arg_16_0._interactHeroPointName)
		end
	else
		arg_16_0:_tryPlacePointByName(arg_16_0._interactHeroPointName)

		arg_16_0._tweenMoveId = arg_16_0._scene.tween:tweenFloat(0, 1, arg_16_0._showTime, arg_16_0._framePointCallback, arg_16_0._finishCallback, arg_16_0)
	end
end

function var_0_0.endIneract(arg_17_0)
	arg_17_0._buildingUid = nil
	arg_17_0._buildingEntity = nil

	if arg_17_0._characterMO then
		arg_17_0._characterMO:setIsFreeze(false)
	end

	arg_17_0:_resetMOPosXYZ()
	arg_17_0:_killTween()
	arg_17_0:_stopFinishTask()
	arg_17_0:_clearResetXYZ()
	TaskDispatcher.cancelTask(arg_17_0._onStartInteract, arg_17_0)
end

function var_0_0._clearResetXYZ(arg_18_0)
	arg_18_0:_setResetXYZ(nil, nil, nil)
end

function var_0_0._setResetXYZ(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._resetPosX, arg_19_0._resetPosY, arg_19_0._resetPosZ = arg_19_1, arg_19_2, arg_19_3
end

function var_0_0._resetMOPosXYZ(arg_20_0)
	if arg_20_0._resetPosX then
		arg_20_0:_setMOPosXYZ(arg_20_0._resetPosX, arg_20_0._resetPosY, arg_20_0._resetPosZ)
	end

	arg_20_0:_clearResetXYZ()
end

function var_0_0._setMOPosXYZ(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_0._characterMO then
		arg_21_0._characterMO:setPositionXYZ(arg_21_1, arg_21_2, arg_21_3)
	end
end

function var_0_0._stopFinishTask(arg_22_0)
	if arg_22_0._isHasInteractFinishTask then
		arg_22_0._isHasInteractFinishTask = false

		TaskDispatcher.cancelTask(arg_22_0._onIneractFinish, arg_22_0)
	end
end

function var_0_0._startFinishTask(arg_23_0, arg_23_1)
	if not arg_23_0._isHasInteractFinishTask then
		arg_23_0._isHasInteractFinishTask = true

		TaskDispatcher.runDelay(arg_23_0._onIneractFinish, arg_23_0, arg_23_1)
	end
end

function var_0_0._onIneractFinish(arg_24_0)
	arg_24_0._isHasInteractFinishTask = false

	arg_24_0:_killTween()
	arg_24_0:_resetMOPosXYZ()

	if arg_24_0._isFindPath then
		local var_24_0, var_24_1, var_24_2 = transformhelper.getPos(arg_24_0.entity.goTrs)
		local var_24_3, var_24_4, var_24_5 = arg_24_0:_getPosXYZByPointName(arg_24_0._interactStartPointName)

		if var_24_0 and var_24_3 then
			arg_24_0:_findPath(Vector3(var_24_0, var_24_1, var_24_2), Vector3(var_24_3, var_24_4, var_24_5), arg_24_0._interactStartPointName)
		else
			arg_24_0:_tryPlacePointByName(arg_24_0._interactStartPointName, true)
		end
	else
		arg_24_0:_tryPlacePointByName(arg_24_0._interactStartPointName, true)
	end

	if arg_24_0._characterMO then
		arg_24_0._characterMO:setIsFreeze(false)
	end
end

function var_0_0.getIneractBuildingUid(arg_25_0)
	return arg_25_0._buildingUid
end

function var_0_0._getPosXYZByPointName(arg_26_0, arg_26_1)
	if not arg_26_0._buildingEntity then
		return
	end

	local var_26_0 = arg_26_0._buildingEntity.interactComp:getPointGOTrsByName(arg_26_1)

	if not var_26_0 then
		return
	end

	return transformhelper.getPos(var_26_0)
end

function var_0_0._tryPlacePointByName(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1, var_27_2 = arg_27_0:_getPosXYZByPointName(arg_27_1)

	if not var_27_0 then
		return
	end

	if arg_27_2 ~= true then
		arg_27_0:_setMOPosXYZ(var_27_0, var_27_1, var_27_2)
	end

	arg_27_0._toPosition = Vector3(var_27_0, var_27_1, var_27_2)
	arg_27_0._playingAnimName = "out"

	local var_27_3 = arg_27_0.entity.characterspine:getLookDir()
	local var_27_4 = arg_27_0._scene.camera:getCameraRotate() * Mathf.Rad2Deg

	arg_27_0:_playPlaceEffect(var_27_0, var_27_1, var_27_2, var_27_4, "left")
	arg_27_0.entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, arg_27_0._playingAnimName, 0, arg_27_0._moveEntity, arg_27_0)
	arg_27_0.entity.charactermove:forcePositionAndLookDir(arg_27_0._toPosition, var_27_3, RoomCharacterEnum.CharacterMoveState.Move)
end

function var_0_0._moveEntity(arg_28_0)
	arg_28_0.entity.charactermove:clearForcePositionAndLookDir()
	arg_28_0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function var_0_0._playPlaceEffect(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = arg_29_0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2)

	if var_29_0 then
		local var_29_1 = var_29_0.transform

		transformhelper.setPos(var_29_1, arg_29_1, arg_29_2, arg_29_3)
		transformhelper.setLocalRotation(var_29_1, 0, arg_29_4, 0)

		if not string.nilorempty(arg_29_5) then
			local var_29_2 = gohelper.findChildComponent(var_29_0, "anim", RoomEnum.ComponentType.Animator)

			if var_29_2 then
				var_29_2:Play(arg_29_5)
			end
		end
	end
end

return var_0_0
