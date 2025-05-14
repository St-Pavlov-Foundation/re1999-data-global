module("modules.logic.scene.room.fsm.action.RoomActionShowTimeCharacterBuilding", package.seeall)

local var_0_0 = class("RoomActionShowTimeCharacterBuilding", RoomBaseFsmAction)

function var_0_0.checkInteract(arg_1_0)
	local var_1_0 = RoomCharacterController.instance:getPlayingInteractionParam()

	if var_1_0 and var_1_0.id == arg_1_0._interationId then
		return true
	end

	return false
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0._param = arg_2_1
	arg_2_0._heroId = arg_2_1.heroId
	arg_2_0._buildingId = arg_2_1.buildingId
	arg_2_0._buildingUid = arg_2_1.buildingUid
	arg_2_0._interationId = arg_2_1.id
	arg_2_0._cameraId = arg_2_1.cameraId
	arg_2_0._faithOp = arg_2_1.faithOp
	arg_2_0._interaTionCfg = RoomConfig.instance:getCharacterInteractionConfig(arg_2_1.id)
	arg_2_0._roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(arg_2_0._heroId)
	arg_2_0._characterId = arg_2_0._roomCharacterMO.id
	arg_2_0._skinId = arg_2_0._roomCharacterMO.skinId
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
	arg_2_0._heroAnimName, arg_2_0._heroAnimDelay = arg_2_0:_splitAnimState(arg_2_0._interaTionCfg.heroAnimState)
	arg_2_0._effectCfgList = arg_2_0._heroAnimName and RoomConfig.instance:getCharacterEffectListByAnimName(arg_2_0._skinId, arg_2_0._heroAnimName)
	arg_2_0._interactSpineList = {}

	local var_2_0 = arg_2_0._interaTionCfg.buildingInsideSpines

	if not string.nilorempty(var_2_0) then
		arg_2_0._interactSpineList = string.split(var_2_0, "#")
	end

	local var_2_1 = RoomConfig.instance:getCharacterInteractionConfig(arg_2_1.id)

	RoomCharacterController.instance:startDialogInteraction(var_2_1, arg_2_1.buildingUid)
	arg_2_0:onDone()
	TaskDispatcher.cancelTask(arg_2_0._onInteractionFinish, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._onDelayLoadDone, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._onDelayNextCamera, arg_2_0)

	arg_2_0._isCameraDone = true

	if arg_2_0:checkInteract() then
		arg_2_0._isCameraDone = false

		arg_2_0:tweenCamera(arg_2_0._heroId, arg_2_0._buildingUid, arg_2_0._cameraId)
		ViewMgr.instance:openView(ViewName.RoomBuildingInteractionView)
	end

	arg_2_0:_loaderEffect()
	arg_2_0:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, true)

	arg_2_0._delayCameraParam = nil
	arg_2_0._nextCameraParams = arg_2_0:_getNextCameraParams(arg_2_0._cameraId)
end

function var_0_0._splitAnimState(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_1) then
		return nil, 0
	end

	local var_3_0 = string.split(arg_3_1, "#")
	local var_3_1 = #var_3_0 > 1 and tonumber(var_3_0[2]) or 0

	return var_3_0[1], var_3_1
end

function var_0_0._loaderEffect(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._effectCfgList and #arg_4_0._effectCfgList > 0
	local var_4_1 = arg_4_0._interactSpineList and #arg_4_0._interactSpineList > 0

	if var_4_0 or var_4_1 then
		arg_4_0._isLoaderDone = false

		if arg_4_0._loader == nil then
			arg_4_0._loader = SequenceAbLoader.New()
		end

		local var_4_2 = arg_4_0._scene.charactermgr:getCharacterEntity(arg_4_0._characterId, SceneTag.RoomCharacter)

		if var_4_2 then
			var_4_2.characterspine:addResToLoader(arg_4_0._loader)
			var_4_2.characterspineeffect:addResToLoader(arg_4_0._loader)
		end

		if var_4_0 then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0._effectCfgList) do
				arg_4_0._loader:addPath(arg_4_0:_getEffecResAb(iter_4_1.effectRes))
			end
		end

		if var_4_1 then
			for iter_4_2, iter_4_3 in ipairs(arg_4_0._interactSpineList) do
				local var_4_3 = ResUrl.getSpineBxhyPrefab(iter_4_3)

				arg_4_0._loader:addPath(var_4_3)
			end
		end

		arg_4_0._loader:setConcurrentCount(10)
		arg_4_0._loader:setLoadFailCallback(arg_4_0._onLoadOneFail)
		arg_4_0._loader:startLoad(arg_4_0._onLoadFinish, arg_4_0)
	elseif arg_4_0._loader == nil then
		arg_4_0._isLoaderDone = true
	end
end

function var_0_0._onLoadOneFail(arg_5_0, arg_5_1, arg_5_2)
	logError("RoomActionShowTimeCharacterBuilding: 加载失败, url: " .. arg_5_2.ResPath)
end

function var_0_0._onLoadFinish(arg_6_0, arg_6_1)
	TaskDispatcher.runDelay(arg_6_0._onDelayLoadDone, arg_6_0, 0.001)
end

function var_0_0._onDelayLoadDone(arg_7_0)
	if not arg_7_0._isLoaderDone then
		arg_7_0._isLoaderDone = true

		arg_7_0:_checkNext(true)
	end
end

function var_0_0._runTweenCamera(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_0._scene
	local var_8_1 = arg_8_0:_getCameraConfig(arg_8_2)
	local var_8_2 = string.splitToNumber(var_8_1.focusXYZ, "#")
	local var_8_3 = var_8_2 and var_8_2[1] or 0
	local var_8_4 = var_8_2 and var_8_2[2] or 0
	local var_8_5 = var_8_2 and var_8_2[3] or 0
	local var_8_6 = arg_8_0._scene.buildingmgr:getBuildingEntity(arg_8_1, SceneTag.RoomBuilding)
	local var_8_7 = var_8_6:transformPoint(var_8_3, var_8_4, var_8_5)
	local var_8_8 = tonumber(var_8_1.rotate) + var_8_6:getMO().rotate * 60
	local var_8_9 = RoomRotateHelper.getMod(var_8_8, 360) * Mathf.Deg2Rad
	local var_8_10 = RoomEnum.CameraState.InteractionCharacterBuilding
	local var_8_11 = {
		focusX = var_8_7.x,
		focusY = var_8_7.z,
		zoom = var_8_0.camera:getZoomInitValue(var_8_10),
		rotate = var_8_9
	}

	var_8_0.camera:setCharacterbuildingInteractionById(arg_8_2)
	var_8_0.camera:switchCameraState(var_8_10, var_8_11, arg_8_3, arg_8_4, arg_8_5)

	return var_8_11
end

function var_0_0._getNextCameraParams(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_getCameraConfig(arg_9_1)

	if not var_9_0 or string.nilorempty(var_9_0.nextCameraParams) then
		return nil
	end

	local var_9_1 = GameUtil.splitString2(var_9_0.nextCameraParams, true)

	if not var_9_1 or #var_9_1 < 1 then
		return nil
	end

	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if iter_9_1 and #iter_9_1 > 0 then
			table.insert(var_9_2, {
				cameraId = iter_9_1[1],
				delay = iter_9_1[2] or 0
			})
		end
	end

	return var_9_2
end

function var_0_0._getCameraConfig(arg_10_0, arg_10_1)
	if arg_10_0._param and arg_10_0._param._debugCameraCfgDict then
		return arg_10_0._param._debugCameraCfgDict[arg_10_1]
	end

	return (RoomConfig.instance:getCharacterBuildingInteractCameraConfig(arg_10_1))
end

function var_0_0._checkNextCamera(arg_11_0)
	if arg_11_0._delayCameraParam == nil and arg_11_0._nextCameraParams and #arg_11_0._nextCameraParams > 0 then
		arg_11_0._delayCameraParam = arg_11_0._nextCameraParams[1]

		table.remove(arg_11_0._nextCameraParams, 1)
		TaskDispatcher.cancelTask(arg_11_0._onDelayNextCamera, arg_11_0)

		if arg_11_0._delayCameraParam.delay and arg_11_0._delayCameraParam.delay > 0 then
			TaskDispatcher.runDelay(arg_11_0._onDelayNextCamera, arg_11_0, arg_11_0._delayCameraParam.delay)
		else
			arg_11_0:_onDelayNextCamera()
		end
	end
end

function var_0_0._onDelayNextCamera(arg_12_0)
	if arg_12_0._delayCameraParam and arg_12_0:checkInteract() then
		local var_12_0 = arg_12_0._delayCameraParam.cameraId

		arg_12_0._delayCameraParam = nil

		local var_12_1 = arg_12_0._scene.camera:getCameraState()

		if var_12_1 == RoomEnum.CameraState.InteractionCharacterBuilding then
			arg_12_0:_runTweenCamera(arg_12_0._buildingUid, var_12_0, nil, arg_12_0._checkNextCamera, arg_12_0)
		else
			logNormal(string.format("camera state is [%s], not [%s].", var_12_1, RoomEnum.CameraState.InteractionCharacterBuilding))
		end
	end
end

function var_0_0.tweenCamera(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0._scene
	local var_13_1 = RoomCharacterModel.instance:getCharacterMOById(arg_13_1).currentPosition
	local var_13_2 = RoomCharacterController.instance:getPlayingInteractionParam()

	table.insert(var_13_2.positionList, var_13_1)

	var_13_2.cameraParam = arg_13_0:_runTweenCamera(arg_13_2, arg_13_3, nil, arg_13_0.interactionCameraDone, arg_13_0)
end

function var_0_0.interactionCameraDone(arg_14_0)
	arg_14_0._isCameraDone = true

	arg_14_0:_checkNext()
end

function var_0_0._checkNext(arg_15_0, arg_15_1)
	if not arg_15_0._isLoaderDone then
		return
	end

	if arg_15_0._isCameraDone then
		arg_15_0:playInteraction()
		arg_15_0:playIneteractionEffect()
		arg_15_0:createInteractionSpine()
		arg_15_0:_checkNextCamera()
	end
end

function var_0_0.playInteraction(arg_16_0)
	arg_16_0:endState()

	local var_16_0 = arg_16_0._scene.buildingmgr:getBuildingEntity(arg_16_0._buildingUid, SceneTag.RoomBuilding)

	if var_16_0 and not string.nilorempty(arg_16_0._interaTionCfg.buildingAnimState) then
		var_16_0:playAnimator(arg_16_0._interaTionCfg.buildingAnimState)
	end

	if arg_16_0._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithAll then
		RoomCharacterController.instance:gainAllCharacterFaith(nil, nil, arg_16_0._characterId)
	elseif arg_16_0._faithOp == RoomCharacterEnum.ShowTimeFaithOp.FaithOne then
		RoomCharacterController.instance:gainCharacterFaith({
			arg_16_0._characterId
		})
	end

	local var_16_1 = arg_16_0:_getShowTime()

	TaskDispatcher.cancelTask(arg_16_0._onInteractionFinish, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._onInteractionFinish, arg_16_0, var_16_1)
	TaskDispatcher.cancelTask(arg_16_0._onPlayHeroAnimState, arg_16_0)

	if arg_16_0._heroAnimDelay and arg_16_0._heroAnimDelay > 0 then
		TaskDispatcher.runDelay(arg_16_0._onPlayHeroAnimState, arg_16_0, arg_16_0._heroAnimDelay)
	else
		arg_16_0:_onPlayHeroAnimState()
	end

	if arg_16_0._interaTionCfg.buildingAudio and arg_16_0._interaTionCfg.buildingAudio ~= 0 and var_16_0 then
		var_16_0:playAudio(arg_16_0._interaTionCfg.buildingAudio)
	end

	if arg_16_0._interaTionCfg.buildingInside then
		TaskDispatcher.cancelTask(arg_16_0.moveCharacterInsideBuilding, arg_16_0)

		if arg_16_0._interaTionCfg.delayEnterBuilding and arg_16_0._interaTionCfg.delayEnterBuilding > 0 then
			TaskDispatcher.runDelay(arg_16_0.moveCharacterInsideBuilding, arg_16_0, arg_16_0._interaTionCfg.delayEnterBuilding)
		else
			arg_16_0:moveCharacterInsideBuilding()
		end
	end
end

function var_0_0._onPlayHeroAnimState(arg_17_0)
	local var_17_0 = arg_17_0._scene.charactermgr:getCharacterEntity(arg_17_0._characterId, SceneTag.RoomCharacter)

	if var_17_0 and not string.nilorempty(arg_17_0._heroAnimName) then
		var_17_0.characterspine:play(arg_17_0._heroAnimName, false, true)
	end
end

function var_0_0.moveCharacterInsideBuilding(arg_18_0)
	local var_18_0 = arg_18_0._scene.charactermgr:getCharacterEntity(arg_18_0._characterId, SceneTag.RoomCharacter)
	local var_18_1 = arg_18_0._scene.buildingmgr:getBuildingEntity(arg_18_0._buildingUid, SceneTag.RoomBuilding)
	local var_18_2 = var_18_1 and var_18_1:getPlayerInsideInteractionNode()

	if not var_18_0 or gohelper.isNil(var_18_2) then
		return
	end

	local var_18_3, var_18_4, var_18_5 = transformhelper.getPos(var_18_2.transform)

	var_18_0:setLocalPos(var_18_3, var_18_4, var_18_5)
	arg_18_0._roomCharacterMO:setIsFreeze(true)
end

function var_0_0.setInteractBuildingSideIsActive(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._scene.buildingmgr:getBuildingEntity(arg_19_0._buildingUid, SceneTag.RoomBuilding)

	if var_19_0 then
		var_19_0:setSideIsActive(arg_19_1, arg_19_2)
	end
end

function var_0_0._getShowTime(arg_20_0)
	if arg_20_0._interaTionCfg and arg_20_0._interaTionCfg.showtime and arg_20_0._interaTionCfg.showtime ~= 0 then
		return arg_20_0._interaTionCfg.showtime * 0.001
	end

	return 8
end

function var_0_0.playIneteractionEffect(arg_21_0)
	local var_21_0 = arg_21_0._effectCfgList

	if not var_21_0 then
		return
	end

	local var_21_1 = arg_21_0._scene.charactermgr:getCharacterEntity(arg_21_0._characterId, SceneTag.RoomCharacter)
	local var_21_2 = var_21_1.characterspine:getCharacterGO()
	local var_21_3 = var_21_1.characterspineeffect

	arg_21_0._interationGOs = arg_21_0._interationGOs or {}
	arg_21_0._interationGODict = arg_21_0._interationGODict or {}

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if not var_21_3:isHasEffectGO(iter_21_1.animName) then
			local var_21_4 = "effect_" .. iter_21_1.id
			local var_21_5 = arg_21_0._interationGODict[var_21_4]

			if gohelper.isNil(var_21_5) then
				local var_21_6 = RoomCharacterHelper.getSpinePointPath(iter_21_1.point)
				local var_21_7 = gohelper.findChild(var_21_2, var_21_6) or var_21_2 or var_21_1.containerGO
				local var_21_8 = arg_21_0:_getEffecRes(iter_21_1.effectRes)
				local var_21_9 = arg_21_0:_getEffecResAb(iter_21_1.effectRes)
				local var_21_10 = arg_21_0._loader:getAssetItem(var_21_9):GetResource(var_21_8)

				var_21_5 = gohelper.clone(var_21_10, var_21_7, var_21_4)

				table.insert(arg_21_0._interationGOs, var_21_5)

				arg_21_0._interationGODict[var_21_4] = var_21_5
			else
				gohelper.setActive(var_21_5, false)
				gohelper.setActive(var_21_5, true)
			end
		end
	end
end

function var_0_0.createInteractionSpine(arg_22_0)
	local var_22_0 = arg_22_0._interactSpineList
	local var_22_1 = arg_22_0._scene.buildingmgr:getBuildingEntity(arg_22_0._buildingUid, SceneTag.RoomBuilding)

	if not var_22_0 or #var_22_0 <= 0 or not var_22_1 then
		return
	end

	arg_22_0._interactionSpineGODict = arg_22_0._interactionSpineGODict or {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_2 = arg_22_0._interactionSpineGODict[iter_22_1]

		if gohelper.isNil(var_22_2) then
			local var_22_3 = var_22_1:getSpineWidgetNode(iter_22_0)
			local var_22_4 = ResUrl.getSpineBxhyPrefab(iter_22_1)
			local var_22_5 = arg_22_0._loader:getAssetItem(var_22_4)
			local var_22_6 = var_22_5 and var_22_5:GetResource(var_22_4)

			if var_22_6 then
				var_22_2 = gohelper.clone(var_22_6, var_22_3, iter_22_1)
				arg_22_0._interactionSpineGODict[iter_22_1] = var_22_2

				local var_22_7 = var_22_2:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

				if var_22_7 then
					var_22_7:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
				end
			end
		else
			gohelper.setActive(var_22_2, false)
			gohelper.setActive(var_22_2, true)
		end
	end
end

function var_0_0.playInteractionSpineAnim(arg_23_0)
	local var_23_0 = arg_23_0._interactSpineList

	if not var_23_0 or #var_23_0 <= 0 then
		return
	end

	arg_23_0._interactionSpineGODict = arg_23_0._interactionSpineGODict or {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		local var_23_1
		local var_23_2 = arg_23_0._interactionSpineGODict[iter_23_1]

		if not gohelper.isNil(var_23_2) then
			var_23_1 = var_23_2:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		end

		if var_23_1 then
			var_23_1:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
		end
	end
end

function var_0_0._clearLoader(arg_24_0)
	if arg_24_0._loader then
		arg_24_0._loader:dispose()

		arg_24_0._loader = nil
	end

	if arg_24_0._interationGOs then
		local var_24_0 = #arg_24_0._interationGOs

		for iter_24_0 = 1, var_24_0 do
			local var_24_1 = arg_24_0._interationGOs[iter_24_0]

			arg_24_0._interationGOs[iter_24_0] = nil

			gohelper.destroy(var_24_1)
		end

		arg_24_0._interationGOs = nil
	end

	if arg_24_0._interationGODict then
		for iter_24_1, iter_24_2 in pairs(arg_24_0._interationGODict) do
			arg_24_0._interationGODict[iter_24_1] = nil
		end

		arg_24_0._interationGODict = nil
	end

	if arg_24_0._interactionSpineGODict then
		for iter_24_3, iter_24_4 in pairs(arg_24_0._interactionSpineGODict) do
			gohelper.destroy(iter_24_4)
		end

		arg_24_0._interactionSpineGODict = nil
	end
end

function var_0_0._getEffecRes(arg_25_0, arg_25_1)
	return RoomResHelper.getCharacterEffectPath(arg_25_1)
end

function var_0_0._getEffecResAb(arg_26_0, arg_26_1)
	return RoomResHelper.getCharacterEffectABPath(arg_26_1)
end

function var_0_0._onInteractionFinish(arg_27_0)
	local var_27_0 = arg_27_0:checkInteract()

	if var_27_0 then
		RoomCharacterController.instance:endInteraction()
		ViewMgr.instance:closeView(ViewName.RoomBuildingInteractionView)
	end

	local var_27_1 = arg_27_0._scene.camera

	if var_27_0 and var_27_1:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		local var_27_2 = arg_27_0._roomCharacterMO.currentPosition

		var_27_1:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = var_27_2.x,
			focusY = var_27_2.z
		}, nil, arg_27_0.insideBuildingInteractFinish, arg_27_0)
	else
		arg_27_0:insideBuildingInteractFinish()
	end

	arg_27_0:_clearLoader()

	if arg_27_0._interaTionCfg.buildingInside then
		arg_27_0._roomCharacterMO:setIsFreeze(false)
		RoomCharacterController.instance:correctCharacterHeight(arg_27_0._roomCharacterMO)
	end
end

function var_0_0.insideBuildingInteractFinish(arg_28_0)
	if not arg_28_0._interaTionCfg.buildingInside then
		return
	end

	arg_28_0:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)
end

function var_0_0.onDone(arg_29_0)
	return
end

function var_0_0.endState(arg_30_0)
	if arg_30_0.fsmTransition then
		arg_30_0.fsmTransition:endState()
	end
end

function var_0_0.stop(arg_31_0)
	arg_31_0:endState()
end

function var_0_0.clear(arg_32_0)
	arg_32_0:endState()
	arg_32_0:_clearLoader()
	TaskDispatcher.cancelTask(arg_32_0._onInteractionFinish, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onDelayLoadDone, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onDelayNextCamera, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onPlayHeroAnimState, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0.moveCharacterInsideBuilding)
end

return var_0_0
