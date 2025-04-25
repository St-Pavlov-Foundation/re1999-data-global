module("modules.logic.scene.room.comp.RoomSceneDirector", package.seeall)

slot0 = class("RoomSceneDirector", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	RoomHelper.logElapse("RoomSceneDirector:onSceneStart")

	if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.Low then
		UnityEngine.QualitySettings.masterTextureLimit = 1
	else
		UnityEngine.QualitySettings.masterTextureLimit = 0
	end

	RoomHelper.logElapse("RoomSceneDirector:set masterTextureLimit")
	RoomPreloadMgr.instance:dispose()

	slot0._scene = slot0:getCurScene()
	slot0._compInitSequence = FlowSequenceRoom.New()

	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.tween))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.timer))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.init))

	slot4 = FlowParallelRoom.New()

	slot0._compInitSequence:addWork(slot4)
	slot4:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	slot4:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.loader))
	slot0._compInitSequence:addWork(WorkWaitSeconds.New(0.01))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.bloom))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.go))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.fog))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.bending))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.ocean))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.light))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.weather))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.mapmgr))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.inventorymgr))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.buildingmgr))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.sitemgr))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.graphics))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.ambient))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.camera))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.cameraFollow))
	slot0._compInitSequence:addWork(RoomPreloadCharacterWork.New())
	slot0._compInitSequence:registerDoneListener(slot0._compInitDone, slot0)
	slot0._compInitSequence:start({
		sceneId = slot1,
		levelId = slot2
	})
end

function slot0._compInitDone(slot0)
	slot0:_getInteractionReward()
	GameGlobalMgr.instance:getScreenState():resetMaxFileLoadingCount()
	slot0._scene:onPrepared()
	RoomHelper.logElapse("onPrepared")

	if RoomMapController.instance:isResetEdit() then
		RoomMapController.instance:dispatchEvent(RoomEvent.Reset)
	end

	RoomHelper.initSceneRootTrs()

	if GameSceneMgr.instance:getPreSceneType() == SceneType.Room then
		if RoomController.instance:isObMode() then
			slot0._scene.camera:playCameraAnim("out_show")
		elseif RoomController.instance:isEditMode() then
			slot0._scene.camera:playCameraAnim("out_edit")
		else
			slot0._scene.camera:playCameraAnim("idle")
		end
	else
		slot0._scene.camera:playCameraAnim("idle")
		RoomMapController.instance:statRoomStart()
	end

	slot0._compLateInitFlow = FlowParallelRoom.New()
	slot4 = FlowSequenceRoom.New()

	slot0._compLateInitFlow:addWork(slot4)
	slot0._compLateInitFlow:addWork(FlowSequenceRoom.New())
	slot4:addWork(WorkWaitSeconds.New(0.2))
	slot4:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.view, RoomSceneViewComp.OnOpenView))

	if slot0._scene.confirmview then
		slot4:addWork(RoomSceneCommonCompWork.New(slot0._scene.confirmview))
	end

	slot4:addWork(RoomSceneCommonCompWork.New(slot0._scene.debug))
	slot4:addWork(RoomSceneCommonCompWork.New(slot0._scene.audio))
	slot5:addWork(WorkWaitSeconds.New(0.01))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.touch))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.path))
	slot5:addWork(RoomSceneWaitAStarWork.New(slot0._scene))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.character))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.charactermgr))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.fovblock))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.vehiclemgr))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.crittermgr))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.buildingcrittermgr))
	slot5:addWork(RoomSceneCommonCompWork.New(slot0._scene.fsm))
	slot5:addWork(RoomSceneCharacterInteractionWork.New(slot0._scene))
	slot4:addWork(WorkWaitSeconds.New(0.1))
	slot4:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.view, RoomSceneViewComp.OnOpenView))
	slot5:addWork(WorkWaitSeconds.New(0.5))
	slot0._compLateInitFlow:registerDoneListener(slot0._compLateInitDone, slot0)
	slot0._compLateInitFlow:start({})
end

function slot0.switchMode(slot0)
	if RoomController.instance:isObMode() then
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		slot0._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	slot1 = RoomController.instance:isObMode() and (RoomModel.instance:hasEdit() or RoomController.instance:isReset())

	RoomModel.instance:clearEditFlag()
	slot0._scene.view:onSceneClose()
	slot0._scene.camera:onSceneClose()
	slot0._scene.init:onSceneClose()
	slot0._scene.audio:onSceneClose()

	if RoomController.instance:isReset() then
		RoomMapController.instance:initMap()
		slot0._scene.mapmgr:onSwitchMode()
		slot0._scene.inventorymgr:onSceneClose()
		slot0._scene.buildingmgr:onSwitchMode()
		slot0._scene.sitemgr:onSwitchMode()
		slot0._scene.vehiclemgr:onStopMode()
	end

	if slot1 then
		slot0._scene.path:doNeedPathGOs()
		slot0._scene.path:onSceneClose()
	end

	slot0._scene.character:onSceneClose()
	slot0._scene.charactermgr:onSceneClose()
	slot0._scene.fovblock:onSceneClose()
	slot0._scene.crittermgr:onSceneClose()
	slot0._scene.buildingcrittermgr:onSceneClose()
	slot0._scene.fsm:onSceneClose()
	slot0._scene.preloader:clearPools()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, slot0)

	slot0._switchModeInitFlow = FlowSequenceRoom.New()

	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.init))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.camera))

	if RoomController.instance:isReset() then
		slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.mapmgr))
		slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.inventorymgr))
		slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.buildingmgr))
		slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.sitemgr))
		slot0._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	end

	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.audio))
	slot0._switchModeInitFlow:addWork(RoomPreloadCharacterWork.New())

	if slot1 then
		slot0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
		slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.path))
	end

	slot0._switchModeInitFlow:addWork(RoomSceneWaitAStarWork.New(slot0._scene))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.character))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.charactermgr))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.fovblock))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.fsm))
	slot0._switchModeInitFlow:addWork(RoomSceneCharacterInteractionWork.New(slot0._scene))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.ambient))
	slot0._compInitSequence:addWork(RoomSceneCommonCompWork.New(slot0._scene.cameraFollow))
	slot0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.crittermgr))
	slot0._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(slot0._scene.buildingcrittermgr))
	slot0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	slot0._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(slot0._scene.view, RoomSceneViewComp.OnOpenView))
	slot0._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.1))
	slot0._switchModeInitFlow:registerDoneListener(slot0._switchModeInitDone, slot0)
	slot0._switchModeInitFlow:start({})
end

function slot0._compLateInitDone(slot0)
	RoomHelper.logElapse("late init done")
	RoomController.instance:dispatchEvent(RoomEvent.OnLateInitDone)
end

function slot0._switchModeInitDone(slot0)
	RoomHelper.logElapse("switch mode init done")

	if RoomController.instance:isObMode() then
		slot0._scene.camera:playCameraAnim("out_show")
	elseif RoomController.instance:isEditMode() then
		slot0._scene.camera:playCameraAnim("out_edit")
	else
		slot0._scene.camera:playCameraAnim("idle")
	end

	slot0._scene.vehiclemgr:onSwitchMode()
	RoomController.instance:dispatchEvent(RoomEvent.OnSwitchModeDone)
end

function slot0._getInteractionReward(slot0)
	if not RoomController.instance:isObMode() then
		return
	end

	for slot5, slot6 in pairs(RoomModel.instance:getExistInteractionDict()) do
		if slot6 == RoomCharacterEnum.InteractionState.Start and not RoomCharacterHelper.interactionIsDialogWithSelect(slot5) then
			RoomRpc.instance:sendGetCharacterInteractionBonusRequest(slot5)
		end
	end
end

function slot0.onSceneClose(slot0)
	ViewMgr.instance:closeAllPopupViews()
	slot0._compInitSequence:unregisterDoneListener(slot0._compInitDone, slot0)
	slot0._compInitSequence:stop()

	slot0._compInitSequence = nil

	if slot0._compLateInitFlow then
		slot0._compLateInitFlow:unregisterDoneListener(slot0._compInitDone, slot0)
		slot0._compLateInitFlow:stop()

		slot0._compLateInitFlow = nil
	end

	if slot0._switchModeInitFlow then
		slot0._switchModeInitFlow:unregisterDoneListener(slot0._switchModeInitDone, slot0)
		slot0._switchModeInitFlow:stop()

		slot0._switchModeInitFlow = nil
	end

	ZProj.RoomHelper.ReleaseRaycastHitsAlloc()
end

return slot0
