module("modules.logic.scene.room.comp.RoomSceneDirector", package.seeall)

local var_0_0 = class("RoomSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	RoomHelper.logElapse("RoomSceneDirector:onSceneStart")

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.Low then
		UnityEngine.QualitySettings.masterTextureLimit = 1
	else
		UnityEngine.QualitySettings.masterTextureLimit = 0
	end

	RoomHelper.logElapse("RoomSceneDirector:set masterTextureLimit")
	RoomPreloadMgr.instance:dispose()

	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._compInitSequence = FlowSequenceRoom.New()

	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.tween))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.timer))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.init))

	local var_2_0 = FlowParallelRoom.New()

	arg_2_0._compInitSequence:addWork(var_2_0)
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.loader))
	arg_2_0._compInitSequence:addWork(WorkWaitSeconds.New(0.01))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.bloom))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.go))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.fog))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.bending))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.ocean))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.light))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.weather))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.mapmgr))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.inventorymgr))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.buildingmgr))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.sitemgr))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.graphics))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.ambient))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.camera))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.cameraFollow))
	arg_2_0._compInitSequence:addWork(RoomPreloadCharacterWork.New())
	arg_2_0._compInitSequence:registerDoneListener(arg_2_0._compInitDone, arg_2_0)
	arg_2_0._compInitSequence:start({
		sceneId = arg_2_1,
		levelId = arg_2_2
	})
end

function var_0_0._compInitDone(arg_3_0)
	arg_3_0:_getInteractionReward()
	GameGlobalMgr.instance:getScreenState():resetMaxFileLoadingCount()
	arg_3_0._scene:onPrepared()
	RoomHelper.logElapse("onPrepared")

	if RoomMapController.instance:isResetEdit() then
		RoomMapController.instance:dispatchEvent(RoomEvent.Reset)
	end

	RoomHelper.initSceneRootTrs()

	if GameSceneMgr.instance:getPreSceneType() == SceneType.Room then
		if RoomController.instance:isObMode() then
			arg_3_0._scene.camera:playCameraAnim("out_show")
		elseif RoomController.instance:isEditMode() then
			arg_3_0._scene.camera:playCameraAnim("out_edit")
		else
			arg_3_0._scene.camera:playCameraAnim("idle")
		end
	else
		arg_3_0._scene.camera:playCameraAnim("idle")
		RoomMapController.instance:statRoomStart()
	end

	arg_3_0._compLateInitFlow = FlowParallelRoom.New()

	local var_3_0 = FlowSequenceRoom.New()
	local var_3_1 = FlowSequenceRoom.New()

	arg_3_0._compLateInitFlow:addWork(var_3_0)
	arg_3_0._compLateInitFlow:addWork(var_3_1)
	var_3_0:addWork(WorkWaitSeconds.New(0.2))
	var_3_0:addWork(RoomSceneWaitEventCompWork.New(arg_3_0._scene.view, RoomSceneViewComp.OnOpenView))

	if arg_3_0._scene.confirmview then
		var_3_0:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.confirmview))
	end

	var_3_0:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.debug))
	var_3_0:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.audio))
	var_3_1:addWork(WorkWaitSeconds.New(0.01))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.touch))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.path))
	var_3_1:addWork(RoomSceneWaitAStarWork.New(arg_3_0._scene))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.character))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.charactermgr))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.fovblock))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.vehiclemgr))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.crittermgr))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.buildingcrittermgr))
	var_3_1:addWork(RoomSceneCommonCompWork.New(arg_3_0._scene.fsm))
	var_3_1:addWork(RoomSceneCharacterInteractionWork.New(arg_3_0._scene))
	var_3_0:addWork(WorkWaitSeconds.New(0.1))
	var_3_0:addWork(RoomSceneWaitEventCompWork.New(arg_3_0._scene.view, RoomSceneViewComp.OnOpenView))
	var_3_1:addWork(WorkWaitSeconds.New(0.5))
	arg_3_0._compLateInitFlow:registerDoneListener(arg_3_0._compLateInitDone, arg_3_0)
	arg_3_0._compLateInitFlow:start({})
end

function var_0_0.switchMode(arg_4_0)
	if RoomController.instance:isObMode() then
		arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		arg_4_0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	local var_4_0 = RoomController.instance:isObMode() and (RoomModel.instance:hasEdit() or RoomController.instance:isReset())

	RoomModel.instance:clearEditFlag()
	arg_4_0._scene.view:onSceneClose()
	arg_4_0._scene.camera:onSceneClose()
	arg_4_0._scene.init:onSceneClose()
	arg_4_0._scene.audio:onSceneClose()

	if RoomController.instance:isReset() then
		RoomMapController.instance:initMap()
		arg_4_0._scene.mapmgr:onSwitchMode()
		arg_4_0._scene.inventorymgr:onSceneClose()
		arg_4_0._scene.buildingmgr:onSwitchMode()
		arg_4_0._scene.sitemgr:onSwitchMode()
		arg_4_0._scene.vehiclemgr:onStopMode()
	end

	if var_4_0 then
		arg_4_0._scene.path:doNeedPathGOs()
		arg_4_0._scene.path:onSceneClose()
	end

	arg_4_0._scene.character:onSceneClose()
	arg_4_0._scene.charactermgr:onSceneClose()
	arg_4_0._scene.fovblock:onSceneClose()
	arg_4_0._scene.crittermgr:onSceneClose()
	arg_4_0._scene.buildingcrittermgr:onSceneClose()
	arg_4_0._scene.fsm:onSceneClose()
	arg_4_0._scene.preloader:clearPools()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_4_0)

	arg_4_0._switchModeInitFlow = FlowSequenceRoom.New()

	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.init))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.camera))

	if RoomController.instance:isReset() then
		arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.mapmgr))
		arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.inventorymgr))
		arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.buildingmgr))
		arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.sitemgr))
		arg_4_0._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(arg_4_0._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	end

	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.audio))
	arg_4_0._switchModeInitFlow:addWork(RoomPreloadCharacterWork.New())

	if var_4_0 then
		arg_4_0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
		arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.path))
	end

	arg_4_0._switchModeInitFlow:addWork(RoomSceneWaitAStarWork.New(arg_4_0._scene))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.character))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.charactermgr))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.fovblock))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.fsm))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCharacterInteractionWork.New(arg_4_0._scene))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.ambient))
	arg_4_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.cameraFollow))
	arg_4_0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.crittermgr))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(arg_4_0._scene.buildingcrittermgr))
	arg_4_0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_4_0._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(arg_4_0._scene.view, RoomSceneViewComp.OnOpenView))
	arg_4_0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.1))
	arg_4_0._switchModeInitFlow:registerDoneListener(arg_4_0._switchModeInitDone, arg_4_0)
	arg_4_0._switchModeInitFlow:start({})
end

function var_0_0._compLateInitDone(arg_5_0)
	RoomHelper.logElapse("late init done")
	RoomController.instance:dispatchEvent(RoomEvent.OnLateInitDone)
end

function var_0_0._switchModeInitDone(arg_6_0)
	RoomHelper.logElapse("switch mode init done")

	if RoomController.instance:isObMode() then
		arg_6_0._scene.camera:playCameraAnim("out_show")
	elseif RoomController.instance:isEditMode() then
		arg_6_0._scene.camera:playCameraAnim("out_edit")
	else
		arg_6_0._scene.camera:playCameraAnim("idle")
	end

	arg_6_0._scene.vehiclemgr:onSwitchMode()
	RoomController.instance:dispatchEvent(RoomEvent.OnSwitchModeDone)
end

function var_0_0._getInteractionReward(arg_7_0)
	if not RoomController.instance:isObMode() then
		return
	end

	local var_7_0 = RoomModel.instance:getExistInteractionDict()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if iter_7_1 == RoomCharacterEnum.InteractionState.Start and not RoomCharacterHelper.interactionIsDialogWithSelect(iter_7_0) then
			RoomRpc.instance:sendGetCharacterInteractionBonusRequest(iter_7_0)
		end
	end
end

function var_0_0.onSceneClose(arg_8_0)
	ViewMgr.instance:closeAllPopupViews()
	arg_8_0._compInitSequence:unregisterDoneListener(arg_8_0._compInitDone, arg_8_0)
	arg_8_0._compInitSequence:stop()

	arg_8_0._compInitSequence = nil

	if arg_8_0._compLateInitFlow then
		arg_8_0._compLateInitFlow:unregisterDoneListener(arg_8_0._compInitDone, arg_8_0)
		arg_8_0._compLateInitFlow:stop()

		arg_8_0._compLateInitFlow = nil
	end

	if arg_8_0._switchModeInitFlow then
		arg_8_0._switchModeInitFlow:unregisterDoneListener(arg_8_0._switchModeInitDone, arg_8_0)
		arg_8_0._switchModeInitFlow:stop()

		arg_8_0._switchModeInitFlow = nil
	end

	ZProj.RoomHelper.ReleaseRaycastHitsAlloc()
end

return var_0_0
