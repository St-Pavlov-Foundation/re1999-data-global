module("modules.logic.room.entity.comp.RoomCharacterInteractActionComp", package.seeall)

slot0 = class("RoomCharacterInteractActionComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._scene = RoomCameraController.instance:getRoomScene()
	slot0._followPathData = RoomVehicleFollowPathData.New(3)
	slot0._roomVectorPool = RoomVectorPool.instance
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._scene = RoomCameraController.instance:getRoomScene()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
	slot0:endIneract()
end

function slot0.startMove(slot0)
end

function slot0._findPath(slot0, slot1, slot2, slot3)
	slot0._moveToHeroPointName = slot3

	if ZProj.AStarPathBridge.HasPossiblePath(slot1, slot2, slot0.entity.charactermove:getSeeker():GetTag()) then
		slot0._scene.path:tryGetPath(slot0.entity:getMO(), slot1, slot2, slot0._onPathCall, slot0)

		return
	else
		slot0:_tryPlacePointByName(slot0._moveToHeroPointName)
	end
end

function slot0._onPathCall(slot0, slot1, slot2, slot3, slot4)
	if not slot3 then
		slot0:_setPathDataPosList(slot0._roomVectorPool:packPosList(slot2))
	else
		slot0:_setPathDataPosList(nil)
		logNormal("Room pathfinding Error : " .. tostring(slot4))
	end

	if slot0._followPathData:getPosCount() > 0 then
		slot0:_killTween()

		slot0._moveFromPosition = slot0._followPathData:getFirstPos()
		slot0._tweenMoveId = slot0._scene.tween:tweenFloat(0, 1, slot0._followPathData:getPathDistance() / (slot0.entity:getMO():getMoveSpeed() * 0.2), slot0._frameMoveCallback, slot0._finishMoveCallback, slot0)

		slot0:_clearResetXYZ()
	else
		slot0:_tryPlacePointByName(slot0._moveToHeroPointName)
	end
end

function slot0._setPathDataPosList(slot0, slot1)
	if slot0._followPathData:getPosCount() > 0 then
		for slot6, slot7 in ipairs(slot0._followPathData._pathPosList) do
			slot0._roomVectorPool:recycle(slot7)
		end

		slot0._followPathData:clear()
	end

	if slot1 and #slot1 > 0 then
		for slot5 = #slot1, 1, -1 do
			slot0._followPathData:addPathPos(slot1[slot5])
		end
	end
end

function slot0._killTween(slot0)
	if slot0._tweenMoveId then
		slot0._scene.tween:killById(slot0._tweenMoveId)

		slot0._tweenMoveId = nil
	end
end

function slot0._framePointCallback(slot0, slot1, slot2)
	if not slot0._buildingEntity.interactComp:getPointGOTrsByName(slot0._interactHeroPointName) then
		return
	end

	slot0._isUpdatePointPiont = true
	slot4, slot5, slot6 = transformhelper.getPos(slot3)

	slot0.entity:setLocalPos(slot4, slot5, slot6)
end

function slot0._frameMoveCallback(slot0, slot1, slot2)
	slot4 = slot0._followPathData:getPosByDistance(slot0._followPathData:getPathDistance() * slot1)
	slot0._moveFromPosition = slot4

	slot0.entity.charactermove:forcePositionAndLookDir(slot4, slot0.entity.charactermove:getMoveToLookDirByPos(slot0._moveFromPosition, slot4), RoomCharacterEnum.CharacterMoveState.Move)
	slot0:_setMOPosXYZ(slot4.x, slot4.y, slot4.z)
end

function slot0._finishMoveCallback(slot0, slot1, slot2)
	slot0.entity.charactermove:clearForcePositionAndLookDir()
	slot0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function slot0._finishCallback(slot0, slot1, slot2)
end

function slot0.startInteract(slot0, slot1, slot2, slot3)
	slot0._siteId = slot2
	slot0._buildingUid = slot1
	slot0._buildingEntity = slot0._scene.buildingmgr:getBuildingEntity(slot1)
	slot0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(slot1)
	slot0._interactHeroPointName = RoomEnum.EntityChildKey.CritterPointList[slot2]
	slot0._interactStartPointName = RoomEnum.EntityChildKey.InteractStartPointList[slot2]
	slot0._interactBuildingMO = slot0._buildingMO:getInteractMO()
	slot0._isFindPath = slot0._interactBuildingMO:isFindPath()
	slot0._showTime = slot3

	if not slot0._resetPosX then
		slot4, slot5, slot6 = slot0.entity:getLocalPosXYZ()

		slot0:_setResetXYZ(slot4, slot5, slot6)
	end

	slot4 = math.random() * 0.5
	slot0._characterMO = slot0.entity:getMO()

	if slot0._characterMO then
		slot0._characterMO:setLockTime(slot3 + slot4)
		slot0._characterMO:setIsFreeze(true)
	end

	slot0:_killTween()
	slot0:_stopFinishTask()
	slot0:_startFinishTask(slot3 + slot4 + 0.1)
	TaskDispatcher.cancelTask(slot0._onStartInteract, slot0)
	TaskDispatcher.runDelay(slot0._onStartInteract, slot0, slot4)
end

function slot0._onStartInteract(slot0)
	if slot0._isFindPath then
		slot1, slot2, slot3 = slot0:_getPosXYZByPointName(slot0._interactStartPointName)
		slot4, slot5, slot6 = slot0:_getPosXYZByPointName(slot0._interactHeroPointName)

		if slot1 and slot4 then
			slot0:_tryPlacePointByName(slot0._interactStartPointName)
			slot0:_findPath(Vector3(slot1, slot2, slot3), Vector3(slot4, slot5, slot6), slot0._interactHeroPointName)
		else
			slot0:_tryPlacePointByName(slot0._interactHeroPointName)
		end
	else
		slot0:_tryPlacePointByName(slot0._interactHeroPointName)

		slot0._tweenMoveId = slot0._scene.tween:tweenFloat(0, 1, slot0._showTime, slot0._framePointCallback, slot0._finishCallback, slot0)
	end
end

function slot0.endIneract(slot0)
	slot0._buildingUid = nil
	slot0._buildingEntity = nil

	if slot0._characterMO then
		slot0._characterMO:setIsFreeze(false)
	end

	slot0:_resetMOPosXYZ()
	slot0:_killTween()
	slot0:_stopFinishTask()
	slot0:_clearResetXYZ()
	TaskDispatcher.cancelTask(slot0._onStartInteract, slot0)
end

function slot0._clearResetXYZ(slot0)
	slot0:_setResetXYZ(nil, , )
end

function slot0._setResetXYZ(slot0, slot1, slot2, slot3)
	slot0._resetPosZ = slot3
	slot0._resetPosY = slot2
	slot0._resetPosX = slot1
end

function slot0._resetMOPosXYZ(slot0)
	if slot0._resetPosX then
		slot0:_setMOPosXYZ(slot0._resetPosX, slot0._resetPosY, slot0._resetPosZ)
	end

	slot0:_clearResetXYZ()
end

function slot0._setMOPosXYZ(slot0, slot1, slot2, slot3)
	if slot0._characterMO then
		slot0._characterMO:setPositionXYZ(slot1, slot2, slot3)
	end
end

function slot0._stopFinishTask(slot0)
	if slot0._isHasInteractFinishTask then
		slot0._isHasInteractFinishTask = false

		TaskDispatcher.cancelTask(slot0._onIneractFinish, slot0)
	end
end

function slot0._startFinishTask(slot0, slot1)
	if not slot0._isHasInteractFinishTask then
		slot0._isHasInteractFinishTask = true

		TaskDispatcher.runDelay(slot0._onIneractFinish, slot0, slot1)
	end
end

function slot0._onIneractFinish(slot0)
	slot0._isHasInteractFinishTask = false

	slot0:_killTween()
	slot0:_resetMOPosXYZ()

	if slot0._isFindPath then
		slot1, slot2, slot3 = transformhelper.getPos(slot0.entity.goTrs)
		slot4, slot5, slot6 = slot0:_getPosXYZByPointName(slot0._interactStartPointName)

		if slot1 and slot4 then
			slot0:_findPath(Vector3(slot1, slot2, slot3), Vector3(slot4, slot5, slot6), slot0._interactStartPointName)
		else
			slot0:_tryPlacePointByName(slot0._interactStartPointName, true)
		end
	else
		slot0:_tryPlacePointByName(slot0._interactStartPointName, true)
	end

	if slot0._characterMO then
		slot0._characterMO:setIsFreeze(false)
	end
end

function slot0.getIneractBuildingUid(slot0)
	return slot0._buildingUid
end

function slot0._getPosXYZByPointName(slot0, slot1)
	if not slot0._buildingEntity then
		return
	end

	if not slot0._buildingEntity.interactComp:getPointGOTrsByName(slot1) then
		return
	end

	return transformhelper.getPos(slot2)
end

function slot0._tryPlacePointByName(slot0, slot1, slot2)
	slot3, slot4, slot5 = slot0:_getPosXYZByPointName(slot1)

	if not slot3 then
		return
	end

	if slot2 ~= true then
		slot0:_setMOPosXYZ(slot3, slot4, slot5)
	end

	slot0._toPosition = Vector3(slot3, slot4, slot5)
	slot0._playingAnimName = "out"

	slot0:_playPlaceEffect(slot3, slot4, slot5, slot0._scene.camera:getCameraRotate() * Mathf.Rad2Deg, "left")
	slot0.entity.characterspine:playAnim(RoomScenePreloader.ResAnim.PlaceCharacter, slot0._playingAnimName, 0, slot0._moveEntity, slot0)
	slot0.entity.charactermove:forcePositionAndLookDir(slot0._toPosition, slot0.entity.characterspine:getLookDir(), RoomCharacterEnum.CharacterMoveState.Move)
end

function slot0._moveEntity(slot0)
	slot0.entity.charactermove:clearForcePositionAndLookDir()
	slot0.entity.characterspine:changeMoveState(RoomCharacterEnum.CharacterMoveState.Idle)
end

function slot0._playPlaceEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._scene.go:spawnEffect(RoomScenePreloader.ResEffectPlaceCharacter, nil, "placeCharacterEffect", nil, 2) then
		slot7 = slot6.transform

		transformhelper.setPos(slot7, slot1, slot2, slot3)
		transformhelper.setLocalRotation(slot7, 0, slot4, 0)

		if not string.nilorempty(slot5) and gohelper.findChildComponent(slot6, "anim", RoomEnum.ComponentType.Animator) then
			slot8:Play(slot5)
		end
	end
end

return slot0
