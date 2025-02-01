module("modules.logic.scene.room.comp.RoomSceneAudioComp", package.seeall)

slot0 = class("RoomSceneAudioComp", BaseSceneComp)
slot0.CameraMaxDistance = -1.5
slot0.CameraMinDistance = -3.5

function slot0.init(slot0)
	slot0.audioManagerGo = gohelper.find("AudioManager")
	slot0.mainCameraGo = CameraMgr.instance:getMainCameraGO()

	gohelper.enableAkListener(slot0.audioManagerGo, false)
	gohelper.enableAkListener(slot0.mainCameraGo, true)

	slot0.mainCameraFocusPositionY = CameraMgr.instance:getFocusTrs().position.y

	RoomMapController.instance:registerCallback(RoomEvent.TouchScale, slot0.changeRTPCValue, slot0)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, slot0._onStoryFinish, slot0)
	slot0:playRoomAudio(GameSceneMgr.instance:getCurSceneType(), GameSceneMgr.instance:getCurSceneId())
	ManufactureController.instance:registerCallback(ManufactureEvent.PlayCritterBuildingBgm, slot0._onPlayCritterBuildingBgm, slot0)
end

function slot0._onPlayCritterBuildingBgm(slot0, slot1, slot2)
	slot0._isPlayCritterBuildingBgm = slot2

	if slot0._waitCheck then
		return
	end

	if slot1 and slot1 > 0 then
		slot0._waitCheck = true

		TaskDispatcher.runDelay(slot0._realCheckIsPlayCritterBuildingBgm, slot0, slot1)
	else
		slot0:_realCheckIsPlayCritterBuildingBgm()
	end
end

function slot0._realCheckIsPlayCritterBuildingBgm(slot0)
	if slot0._bgmPlayingId then
		AudioMgr.instance:stopPlayingID(slot0._bgmPlayingId)
	end

	slot1 = slot0._isPlayCritterBuildingBgm and AudioEnum.Room.play_ui_home_mojing_music or AudioEnum.Room.bgm_music_home

	if slot0._isPlayCritterBuildingBgm then
		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
	else
		AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)
	end

	slot0._bgmPlayingId = AudioMgr.instance:trigger(slot1)
	slot0._waitCheck = false
end

function slot0.playRoomAudio(slot0, slot1, slot2)
	if slot1 ~= SceneType.Room then
		return
	end

	slot0:changeRTPCValue()
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)

	slot0._bgmPlayingId = AudioMgr.instance:trigger(AudioEnum.Room.bgm_music_home)

	slot0:_playBuildingAudio()
	RoomMapController.instance:dispatchEvent(RoomEvent.StartPlayAmbientAudio)
end

function slot0._playBuildingAudio(slot0)
	if RoomController.instance:isEditMode() then
		return
	end

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if GameSceneMgr.instance:getCurScene().buildingmgr:getBuildingEntity(slot7.id, SceneTag.RoomBuilding) and slot7.config and slot7.config.sound ~= 0 then
			slot8:playAudio(slot7.config.sound)
			logNormal(string.format("RoomBuildingEntity:playAudio() ->[%s] [%s] ", slot7.config.name, slot7.config.sound))
		end
	end
end

function slot0.changeRTPCValue(slot0)
	AudioMgr.instance:setRTPCValue(AudioEnum.RoomRTPC.MainCamera, slot0:getRtpcValue(CameraMgr.instance:getMainCameraTrs().position.y - slot0.mainCameraFocusPositionY))
end

function slot0.getRtpcValue(slot0, slot1)
	slot2 = 0

	return slot1 <= uv0.CameraMinDistance and 0 or uv0.CameraMaxDistance <= slot1 and 1 or (slot1 - uv0.CameraMinDistance) / (uv0.CameraMaxDistance - uv0.CameraMinDistance)
end

function slot0._onStoryStart(slot0, slot1)
	if not RoomTrainCritterModel.instance:isCritterTrainStory(slot1) then
		AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_lower)
	end
end

function slot0._onStoryFinish(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_normal)
end

function slot0.onSceneClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
	gohelper.enableAkListener(slot0.audioManagerGo, true)
	gohelper.enableAkListener(slot0.mainCameraGo, false)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchScale, slot0.changeRTPCValue, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0.playRoomAudio, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, slot0._onStoryFinish, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingViewChange, slot0._onPlayCritterBuildingBgm, slot0)
end

return slot0
