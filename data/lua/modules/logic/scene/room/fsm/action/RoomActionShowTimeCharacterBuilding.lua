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
	arg_2_0._interactHeroPointName = RoomEnum.EntityChildKey.CritterPointList[1]
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

	arg_16_0._buildingEntity = arg_16_0._scene.buildingmgr:getBuildingEntity(arg_16_0._buildingUid, SceneTag.RoomBuilding)

	local var_16_0 = arg_16_0._buildingEntity

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
	arg_18_0._characterEntity = arg_18_0._scene.charactermgr:getCharacterEntity(arg_18_0._characterId, SceneTag.RoomCharacter)

	local var_18_0 = arg_18_0._characterEntity

	if not var_18_0 then
		return
	end

	local var_18_1
	local var_18_2 = arg_18_0._buildingEntity
	local var_18_3 = var_18_2:getMainEffectKey()
	local var_18_4 = arg_18_0._buildingEntity.effect:getGameObjectsTrsByName(var_18_3, arg_18_0._interactHeroPointName)

	if var_18_4 and #var_18_4 > 0 then
		var_18_1 = var_18_4[1]
	end

	if gohelper.isNil(var_18_1) then
		local var_18_5 = var_18_2 and var_18_2:getPlayerInsideInteractionNode()

		if gohelper.isNil(var_18_5) then
			return
		end

		local var_18_6, var_18_7, var_18_8 = transformhelper.getPos(var_18_5.transform)

		var_18_0:setLocalPos(var_18_6, var_18_7, var_18_8)
	else
		local var_18_9 = arg_18_0:_getShowTime()

		arg_18_0._tweenMoveId = arg_18_0._scene.tween:tweenFloat(0, 1, var_18_9, arg_18_0._framePointCallback, arg_18_0._finishCallback, arg_18_0)
	end

	arg_18_0._roomCharacterMO:setIsFreeze(true)
end

function var_0_0._framePointCallback(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0
	local var_19_1 = arg_19_0._buildingEntity:getMainEffectKey()
	local var_19_2 = arg_19_0._buildingEntity.effect:getGameObjectsTrsByName(var_19_1, arg_19_0._interactHeroPointName)

	if var_19_2 and #var_19_2 > 0 then
		var_19_0 = var_19_2[1]
	end

	if gohelper.isNil(var_19_0) then
		return
	end

	local var_19_3, var_19_4, var_19_5 = transformhelper.getPos(var_19_0)

	arg_19_0._characterEntity:setLocalPos(var_19_3, var_19_4, var_19_5)
end

function var_0_0._finishCallback(arg_20_0, arg_20_1, arg_20_2)
	return
end

function var_0_0._killTween(arg_21_0)
	if arg_21_0._tweenMoveId then
		arg_21_0._scene.tween:killById(arg_21_0._tweenMoveId)

		arg_21_0._tweenMoveId = nil
	end
end

function var_0_0.setInteractBuildingSideIsActive(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0._scene.buildingmgr:getBuildingEntity(arg_22_0._buildingUid, SceneTag.RoomBuilding)

	if var_22_0 then
		var_22_0:setSideIsActive(arg_22_1, arg_22_2)
	end
end

function var_0_0._getShowTime(arg_23_0)
	if arg_23_0._interaTionCfg and arg_23_0._interaTionCfg.showtime and arg_23_0._interaTionCfg.showtime ~= 0 then
		return arg_23_0._interaTionCfg.showtime * 0.001
	end

	return 8
end

function var_0_0.playIneteractionEffect(arg_24_0)
	local var_24_0 = arg_24_0._effectCfgList

	if not var_24_0 then
		return
	end

	local var_24_1 = arg_24_0._scene.charactermgr:getCharacterEntity(arg_24_0._characterId, SceneTag.RoomCharacter)
	local var_24_2 = var_24_1.characterspine:getCharacterGO()
	local var_24_3 = var_24_1.characterspineeffect

	arg_24_0._interationGOs = arg_24_0._interationGOs or {}
	arg_24_0._interationGODict = arg_24_0._interationGODict or {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if not var_24_3:isHasEffectGO(iter_24_1.animName) then
			local var_24_4 = "effect_" .. iter_24_1.id
			local var_24_5 = arg_24_0._interationGODict[var_24_4]

			if gohelper.isNil(var_24_5) then
				local var_24_6 = RoomCharacterHelper.getSpinePointPath(iter_24_1.point)
				local var_24_7 = gohelper.findChild(var_24_2, var_24_6) or var_24_2 or var_24_1.containerGO
				local var_24_8 = arg_24_0:_getEffecRes(iter_24_1.effectRes)
				local var_24_9 = arg_24_0:_getEffecResAb(iter_24_1.effectRes)
				local var_24_10 = arg_24_0._loader:getAssetItem(var_24_9):GetResource(var_24_8)

				var_24_5 = gohelper.clone(var_24_10, var_24_7, var_24_4)

				table.insert(arg_24_0._interationGOs, var_24_5)

				arg_24_0._interationGODict[var_24_4] = var_24_5
			else
				gohelper.setActive(var_24_5, false)
				gohelper.setActive(var_24_5, true)
			end
		end
	end
end

function var_0_0.createInteractionSpine(arg_25_0)
	local var_25_0 = arg_25_0._interactSpineList
	local var_25_1 = arg_25_0._scene.buildingmgr:getBuildingEntity(arg_25_0._buildingUid, SceneTag.RoomBuilding)

	if not var_25_0 or #var_25_0 <= 0 or not var_25_1 then
		return
	end

	arg_25_0._interactionSpineGODict = arg_25_0._interactionSpineGODict or {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		local var_25_2 = arg_25_0._interactionSpineGODict[iter_25_1]

		if gohelper.isNil(var_25_2) then
			local var_25_3 = var_25_1:getSpineWidgetNode(iter_25_0)
			local var_25_4 = ResUrl.getSpineBxhyPrefab(iter_25_1)
			local var_25_5 = arg_25_0._loader:getAssetItem(var_25_4)
			local var_25_6 = var_25_5 and var_25_5:GetResource(var_25_4)

			if var_25_6 then
				var_25_2 = gohelper.clone(var_25_6, var_25_3, iter_25_1)
				arg_25_0._interactionSpineGODict[iter_25_1] = var_25_2

				local var_25_7 = var_25_2:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

				if var_25_7 then
					var_25_7:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
				end
			end
		else
			gohelper.setActive(var_25_2, false)
			gohelper.setActive(var_25_2, true)
		end
	end
end

function var_0_0.playInteractionSpineAnim(arg_26_0)
	local var_26_0 = arg_26_0._interactSpineList

	if not var_26_0 or #var_26_0 <= 0 then
		return
	end

	arg_26_0._interactionSpineGODict = arg_26_0._interactionSpineGODict or {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_1
		local var_26_2 = arg_26_0._interactionSpineGODict[iter_26_1]

		if not gohelper.isNil(var_26_2) then
			var_26_1 = var_26_2:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
		end

		if var_26_1 then
			var_26_1:PlayAnim(RoomEnum.InteractSpineAnimName, true, true)
		end
	end
end

function var_0_0._clearLoader(arg_27_0)
	if arg_27_0._loader then
		arg_27_0._loader:dispose()

		arg_27_0._loader = nil
	end

	if arg_27_0._interationGOs then
		local var_27_0 = #arg_27_0._interationGOs

		for iter_27_0 = 1, var_27_0 do
			local var_27_1 = arg_27_0._interationGOs[iter_27_0]

			arg_27_0._interationGOs[iter_27_0] = nil

			gohelper.destroy(var_27_1)
		end

		arg_27_0._interationGOs = nil
	end

	if arg_27_0._interationGODict then
		for iter_27_1, iter_27_2 in pairs(arg_27_0._interationGODict) do
			arg_27_0._interationGODict[iter_27_1] = nil
		end

		arg_27_0._interationGODict = nil
	end

	if arg_27_0._interactionSpineGODict then
		for iter_27_3, iter_27_4 in pairs(arg_27_0._interactionSpineGODict) do
			gohelper.destroy(iter_27_4)
		end

		arg_27_0._interactionSpineGODict = nil
	end
end

function var_0_0._getEffecRes(arg_28_0, arg_28_1)
	return RoomResHelper.getCharacterEffectPath(arg_28_1)
end

function var_0_0._getEffecResAb(arg_29_0, arg_29_1)
	return RoomResHelper.getCharacterEffectABPath(arg_29_1)
end

function var_0_0._onInteractionFinish(arg_30_0)
	arg_30_0:_killTween()

	local var_30_0 = arg_30_0:checkInteract()

	if var_30_0 then
		RoomCharacterController.instance:endInteraction()
		ViewMgr.instance:closeView(ViewName.RoomBuildingInteractionView)
	end

	local var_30_1 = arg_30_0._scene.camera

	if var_30_0 and var_30_1:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		local var_30_2 = arg_30_0._roomCharacterMO.currentPosition

		var_30_1:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = var_30_2.x,
			focusY = var_30_2.z
		}, nil, arg_30_0.insideBuildingInteractFinish, arg_30_0)
	else
		arg_30_0:insideBuildingInteractFinish()
	end

	arg_30_0:_clearLoader()

	if arg_30_0._interaTionCfg.buildingInside then
		arg_30_0._roomCharacterMO:setIsFreeze(false)
		RoomCharacterController.instance:correctCharacterHeight(arg_30_0._roomCharacterMO)
	end
end

function var_0_0.insideBuildingInteractFinish(arg_31_0)
	if not arg_31_0._interaTionCfg.buildingInside then
		return
	end

	arg_31_0:setInteractBuildingSideIsActive(RoomEnum.EntityChildKey.InSideKey, false)
end

function var_0_0.onDone(arg_32_0)
	return
end

function var_0_0.endState(arg_33_0)
	arg_33_0:_killTween()

	if arg_33_0.fsmTransition then
		arg_33_0.fsmTransition:endState()
	end
end

function var_0_0.stop(arg_34_0)
	arg_34_0:endState()
end

function var_0_0.clear(arg_35_0)
	arg_35_0:endState()
	arg_35_0:_clearLoader()
	TaskDispatcher.cancelTask(arg_35_0._onInteractionFinish, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onDelayLoadDone, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onDelayNextCamera, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onPlayHeroAnimState, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0.moveCharacterInsideBuilding)
end

return var_0_0
