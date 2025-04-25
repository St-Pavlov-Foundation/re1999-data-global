module("modules.logic.scene.room.fsm.action.RoomActionShowTimeCharacterBuilding", package.seeall)

slot0 = class("RoomActionShowTimeCharacterBuilding", RoomBaseFsmAction)

function slot0.checkInteract(slot0)
	if RoomCharacterController.instance:getPlayingInteractionParam() and slot1.id == slot0._interationId then
		return true
	end

	return false
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot0._heroId = slot1.heroId
	slot0._buildingId = slot1.buildingId
	slot0._buildingUid = slot1.buildingUid
	slot0._interationId = slot1.id
	slot0._cameraId = slot1.cameraId
	slot0._faithOp = slot1.faithOp
	slot0._interaTionCfg = RoomConfig.instance:getCharacterInteractionConfig(slot1.id)
	slot0._roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(slot0._heroId)
	slot0._characterId = slot0._roomCharacterMO.id
	slot0._skinId = slot0._roomCharacterMO.skinId
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._heroAnimName, slot0._heroAnimDelay = slot0:_splitAnimState(slot0._interaTionCfg.heroAnimState)
	slot0._effectCfgList = slot0._heroAnimName and RoomConfig.instance:getCharacterEffectListByAnimName(slot0._skinId, slot0._heroAnimName)
	slot0._interactSpineList = {}

	if not string.nilorempty(slot0._interaTionCfg.buildingInsideSpines) then
		slot0._interactSpineList = string.split(slot2, "#")
	end

	RoomCharacterController.instance:startDialogInteraction(RoomConfig.instance:getCharacterInteractionConfig(slot1.id), slot1.buildingUid)
	slot0:onDone()
	TaskDispatcher.cancelTask(slot0._onInteractionFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayLoadDone, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayNextCamera, slot0)

	slot0._isCameraDone = true

	if slot0:checkInteract() then
		slot0._isCameraDone = false

		slot0:tweenCamera(slot0._heroId, slot0._buildingUid, slot0._cameraId)
		ViewMgr.instance:openView(ViewName.RoomBuildingInteractionView)
	end

	slot0:_loaderEffect()
	slot0:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, true)

	slot0._delayCameraParam = nil
	slot0._nextCameraParams = slot0:_getNextCameraParams(slot0._cameraId)
end

function slot0._splitAnimState(slot0, slot1)
	if string.nilorempty(slot1) then
		return nil, 0
	end

	return slot2[1], #string.split(slot1, "#") > 1 and tonumber(slot2[2]) or 0
end

function slot0._loaderEffect(slot0, slot1)
	slot3 = slot0._interactSpineList and #slot0._interactSpineList > 0

	if slot0._effectCfgList and #slot0._effectCfgList > 0 or slot3 then
		slot0._isLoaderDone = false

		if slot0._loader == nil then
			slot0._loader = SequenceAbLoader.New()
		end

		if slot0._scene.charactermgr:getCharacterEntity(slot0._characterId, SceneTag.RoomCharacter) then
			slot4.characterspine:addResToLoader(slot0._loader)
			slot4.characterspineeffect:addResToLoader(slot0._loader)
		end

		if slot2 then
			for slot8, slot9 in ipairs(slot0._effectCfgList) do
				slot0._loader:addPath(slot0:_getEffecResAb(slot9.effectRes))
			end
		end

		if slot3 then
			for slot8, slot9 in ipairs(slot0._interactSpineList) do
				slot0._loader:addPath(ResUrl.getSpineBxhyPrefab(slot9))
			end
		end

		slot0._loader:setConcurrentCount(10)
		slot0._loader:setLoadFailCallback(slot0._onLoadOneFail)
		slot0._loader:startLoad(slot0._onLoadFinish, slot0)
	elseif slot0._loader == nil then
		slot0._isLoaderDone = true
	end
end

function slot0._onLoadOneFail(slot0, slot1, slot2)
	logError("RoomActionShowTimeCharacterBuilding: 加载失败, url: " .. slot2.ResPath)
end

function slot0._onLoadFinish(slot0, slot1)
	TaskDispatcher.runDelay(slot0._onDelayLoadDone, slot0, 0.001)
end

function slot0._onDelayLoadDone(slot0)
	if not slot0._isLoaderDone then
		slot0._isLoaderDone = true

		slot0:_checkNext(true)
	end
end

function slot0._runTweenCamera(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0._scene
	slot12 = slot0._scene.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding)
	slot13 = slot12:transformPoint(string.splitToNumber(slot0:_getCameraConfig(slot2).focusXYZ, "#") and slot8[1] or 0, slot8 and slot8[2] or 0, slot8 and slot8[3] or 0)
	slot15 = RoomEnum.CameraState.InteractionCharacterBuilding
	slot16 = {
		focusX = slot13.x,
		focusY = slot13.z,
		zoom = slot6.camera:getZoomInitValue(slot15),
		rotate = RoomRotateHelper.getMod(tonumber(slot7.rotate) + slot12:getMO().rotate * 60, 360) * Mathf.Deg2Rad
	}

	slot6.camera:setCharacterbuildingInteractionById(slot2)
	slot6.camera:switchCameraState(slot15, slot16, slot3, slot4, slot5)

	return slot16
end

function slot0._getNextCameraParams(slot0, slot1)
	if not slot0:_getCameraConfig(slot1) or string.nilorempty(slot2.nextCameraParams) then
		return nil
	end

	if not GameUtil.splitString2(slot2.nextCameraParams, true) or #slot3 < 1 then
		return nil
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot3) do
		if slot9 and #slot9 > 0 then
			table.insert(slot4, {
				cameraId = slot9[1],
				delay = slot9[2] or 0
			})
		end
	end

	return slot4
end

function slot0._getCameraConfig(slot0, slot1)
	if slot0._param and slot0._param._debugCameraCfgDict then
		return slot0._param._debugCameraCfgDict[slot1]
	end

	return RoomConfig.instance:getCharacterBuildingInteractCameraConfig(slot1)
end

function slot0._checkNextCamera(slot0)
	if slot0._delayCameraParam == nil and slot0._nextCameraParams and #slot0._nextCameraParams > 0 then
		slot0._delayCameraParam = slot0._nextCameraParams[1]

		table.remove(slot0._nextCameraParams, 1)
		TaskDispatcher.cancelTask(slot0._onDelayNextCamera, slot0)

		if slot0._delayCameraParam.delay and slot0._delayCameraParam.delay > 0 then
			TaskDispatcher.runDelay(slot0._onDelayNextCamera, slot0, slot0._delayCameraParam.delay)
		else
			slot0:_onDelayNextCamera()
		end
	end
end

function slot0._onDelayNextCamera(slot0)
	if slot0._delayCameraParam and slot0:checkInteract() then
		slot0._delayCameraParam = nil

		if slot0._scene.camera:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
			slot0:_runTweenCamera(slot0._buildingUid, slot0._delayCameraParam.cameraId, nil, slot0._checkNextCamera, slot0)
		else
			logNormal(string.format("camera state is [%s], not [%s].", slot2, RoomEnum.CameraState.InteractionCharacterBuilding))
		end
	end
end

function slot0.tweenCamera(slot0, slot1, slot2, slot3)
	slot4 = slot0._scene
	slot7 = RoomCharacterController.instance:getPlayingInteractionParam()

	table.insert(slot7.positionList, RoomCharacterModel.instance:getCharacterMOById(slot1).currentPosition)

	slot7.cameraParam = slot0:_runTweenCamera(slot2, slot3, nil, slot0.interactionCameraDone, slot0)
end

function slot0.interactionCameraDone(slot0)
	slot0._isCameraDone = true

	slot0:_checkNext()
end

function slot0._checkNext(slot0, slot1)
	if not slot0._isLoaderDone then
		return
	end

	if slot0._isCameraDone then
		slot0:playInteraction()
		slot0:playIneteractionEffect()
		slot0:createInteractionSpine()
		slot0:_checkNextCamera()
	end
end

function slot0.playInteraction(slot0)
	slot0:endState()

	if slot0._scene.buildingmgr:getBuildingEntity(slot0._buildingUid, SceneTag.RoomBuilding) and not string.nilorempty(slot0._interaTionCfg.buildingAnimState) then
		slot1:playAnimator(slot0._interaTionCfg.buildingAnimState)
	end

	if slot0._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithAll then
		RoomCharacterController.instance:gainAllCharacterFaith(nil, , slot0._characterId)
	elseif slot0._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithOne then
		RoomCharacterController.instance:gainCharacterFaith({
			slot0._characterId
		})
	end

	TaskDispatcher.cancelTask(slot0._onInteractionFinish, slot0)
	TaskDispatcher.runDelay(slot0._onInteractionFinish, slot0, slot0:_getShowTime())
	TaskDispatcher.cancelTask(slot0._onPlayHeroAnimState, slot0)

	if slot0._heroAnimDelay and slot0._heroAnimDelay > 0 then
		TaskDispatcher.runDelay(slot0._onPlayHeroAnimState, slot0, slot0._heroAnimDelay)
	else
		slot0:_onPlayHeroAnimState()
	end

	if slot0._interaTionCfg.buildingAudio and slot0._interaTionCfg.buildingAudio ~= 0 and slot1 then
		slot1:playAudio(slot0._interaTionCfg.buildingAudio)
	end

	if slot0._interaTionCfg.buildingInside then
		TaskDispatcher.cancelTask(slot0.moveCharacterInsideBuilding, slot0)

		if slot0._interaTionCfg.delayEnterBuilding and slot0._interaTionCfg.delayEnterBuilding > 0 then
			TaskDispatcher.runDelay(slot0.moveCharacterInsideBuilding, slot0, slot0._interaTionCfg.delayEnterBuilding)
		else
			slot0:moveCharacterInsideBuilding()
		end
	end
end

function slot0._onPlayHeroAnimState(slot0)
	if slot0._scene.charactermgr:getCharacterEntity(slot0._characterId, SceneTag.RoomCharacter) and not string.nilorempty(slot0._heroAnimName) then
		slot1.characterspine:play(slot0._heroAnimName, false, true)
	end
end

function slot0.moveCharacterInsideBuilding(slot0)
	slot3 = slot0._scene.buildingmgr:getBuildingEntity(slot0._buildingUid, SceneTag.RoomBuilding) and slot2:getPlayerInsideInteractionNode()

	if not slot0._scene.charactermgr:getCharacterEntity(slot0._characterId, SceneTag.RoomCharacter) or gohelper.isNil(slot3) then
		return
	end

	slot4, slot5, slot6 = transformhelper.getPos(slot3.transform)

	slot1:setLocalPos(slot4, slot5, slot6)
	slot0._roomCharacterMO:setIsFreeze(true)
end

function slot0.setInteractBuildingSideIsActive(slot0, slot1, slot2)
	if slot0._scene.buildingmgr:getBuildingEntity(slot0._buildingUid, SceneTag.RoomBuilding) then
		slot3:setSideIsActive(slot1, slot2)
	end
end

function slot0._getShowTime(slot0)
	if slot0._interaTionCfg and slot0._interaTionCfg.showtime and slot0._interaTionCfg.showtime ~= 0 then
		return slot0._interaTionCfg.showtime * 0.001
	end

	return 8
end

function slot0.playIneteractionEffect(slot0)
	if not slot0._effectCfgList then
		return
	end

	slot3 = slot0._scene.charactermgr:getCharacterEntity(slot0._characterId, SceneTag.RoomCharacter)
	slot4 = slot3.characterspine:getCharacterGO()
	slot0._interationGOs = slot0._interationGOs or {}
	slot0._interationGODict = slot0._interationGODict or {}

	for slot9, slot10 in ipairs(slot1) do
		if not slot3.characterspineeffect:isHasEffectGO(slot10.animName) then
			if gohelper.isNil(slot0._interationGODict["effect_" .. slot10.id]) then
				slot12 = gohelper.clone(slot0._loader:getAssetItem(slot0:_getEffecResAb(slot10.effectRes)):GetResource(slot0:_getEffecRes(slot10.effectRes)), gohelper.findChild(slot4, RoomCharacterHelper.getSpinePointPath(slot10.point)) or slot4 or slot3.containerGO, slot11)

				table.insert(slot0._interationGOs, slot12)

				slot0._interationGODict[slot11] = slot12
			else
				gohelper.setActive(slot12, false)
				gohelper.setActive(slot12, true)
			end
		end
	end
end

function slot0.createInteractionSpine(slot0)
	if not slot0._interactSpineList or #slot1 <= 0 or not slot0._scene.buildingmgr:getBuildingEntity(slot0._buildingUid, SceneTag.RoomBuilding) then
		return
	end

	slot0._interactionSpineGODict = slot0._interactionSpineGODict or {}

	for slot6, slot7 in ipairs(slot1) do
		if gohelper.isNil(slot0._interactionSpineGODict[slot7]) then
			if slot0._loader:getAssetItem(ResUrl.getSpineBxhyPrefab(slot7)) and slot11:GetResource(slot10) then
				slot8 = gohelper.clone(slot12, slot2:getSpineWidgetNode(slot6), slot7)
				slot0._interactionSpineGODict[slot7] = slot8

				if slot8:GetComponent(typeof(Spine.Unity.SkeletonAnimation)) then
					slot13:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
				end
			end
		else
			gohelper.setActive(slot8, false)
			gohelper.setActive(slot8, true)
		end
	end
end

function slot0.playInteractionSpineAnim(slot0)
	if not slot0._interactSpineList or #slot1 <= 0 then
		return
	end

	slot0._interactionSpineGODict = slot0._interactionSpineGODict or {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = nil

		if not gohelper.isNil(slot0._interactionSpineGODict[slot6]) then
			slot7 = slot8:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		end

		if slot7 then
			slot7:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
		end
	end
end

function slot0._clearLoader(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	if slot0._interationGOs then
		for slot5 = 1, #slot0._interationGOs do
			slot0._interationGOs[slot5] = nil

			gohelper.destroy(slot0._interationGOs[slot5])
		end

		slot0._interationGOs = nil
	end

	if slot0._interationGODict then
		for slot4, slot5 in pairs(slot0._interationGODict) do
			slot0._interationGODict[slot4] = nil
		end

		slot0._interationGODict = nil
	end

	if slot0._interactionSpineGODict then
		for slot4, slot5 in pairs(slot0._interactionSpineGODict) do
			gohelper.destroy(slot5)
		end

		slot0._interactionSpineGODict = nil
	end
end

function slot0._getEffecRes(slot0, slot1)
	return RoomResHelper.getCharacterEffectPath(slot1)
end

function slot0._getEffecResAb(slot0, slot1)
	return RoomResHelper.getCharacterEffectABPath(slot1)
end

function slot0._onInteractionFinish(slot0)
	if slot0:checkInteract() then
		RoomCharacterController.instance:endInteraction()
		ViewMgr.instance:closeView(ViewName.RoomBuildingInteractionView)
	end

	slot2 = slot0._scene.camera

	if slot1 and slot2:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		slot3 = slot0._roomCharacterMO.currentPosition

		slot2:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = slot3.x,
			focusY = slot3.z
		}, nil, slot0.insideBuildingInteractFinish, slot0)
	else
		slot0:insideBuildingInteractFinish()
	end

	slot0:_clearLoader()

	if slot0._interaTionCfg.buildingInside then
		slot0._roomCharacterMO:setIsFreeze(false)
		RoomCharacterController.instance:correctCharacterHeight(slot0._roomCharacterMO)
	end
end

function slot0.insideBuildingInteractFinish(slot0)
	if not slot0._interaTionCfg.buildingInside then
		return
	end

	slot0:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)
end

function slot0.onDone(slot0)
end

function slot0.endState(slot0)
	if slot0.fsmTransition then
		slot0.fsmTransition:endState()
	end
end

function slot0.stop(slot0)
	slot0:endState()
end

function slot0.clear(slot0)
	slot0:endState()
	slot0:_clearLoader()
	TaskDispatcher.cancelTask(slot0._onInteractionFinish, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayLoadDone, slot0)
	TaskDispatcher.cancelTask(slot0._onDelayNextCamera, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayHeroAnimState, slot0)
	TaskDispatcher.cancelTask(slot0.moveCharacterInsideBuilding)
end

return slot0
