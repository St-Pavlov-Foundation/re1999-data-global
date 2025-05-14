module("modules.logic.scene.room.comp.RoomSceneAudioComp", package.seeall)

local var_0_0 = class("RoomSceneAudioComp", BaseSceneComp)

var_0_0.CameraMaxDistance = -1.5
var_0_0.CameraMinDistance = -3.5

function var_0_0.init(arg_1_0)
	arg_1_0.audioManagerGo = gohelper.find("AudioManager")
	arg_1_0.mainCameraGo = CameraMgr.instance:getMainCameraGO()

	gohelper.enableAkListener(arg_1_0.audioManagerGo, false)
	gohelper.enableAkListener(arg_1_0.mainCameraGo, true)

	arg_1_0.mainCameraFocusPositionY = CameraMgr.instance:getFocusTrs().position.y

	RoomMapController.instance:registerCallback(RoomEvent.TouchScale, arg_1_0.changeRTPCValue, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_1_0._onStoryStart, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._onStoryFinish, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.DialogConFinished, arg_1_0._onStoryFinish, arg_1_0)
	arg_1_0:playRoomAudio(GameSceneMgr.instance:getCurSceneType(), GameSceneMgr.instance:getCurSceneId())
	ManufactureController.instance:registerCallback(ManufactureEvent.PlayCritterBuildingBgm, arg_1_0._onPlayCritterBuildingBgm, arg_1_0)
end

function var_0_0._onPlayCritterBuildingBgm(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._isPlayCritterBuildingBgm = arg_2_2

	if arg_2_0._waitCheck then
		return
	end

	if arg_2_1 and arg_2_1 > 0 then
		arg_2_0._waitCheck = true

		TaskDispatcher.runDelay(arg_2_0._realCheckIsPlayCritterBuildingBgm, arg_2_0, arg_2_1)
	else
		arg_2_0:_realCheckIsPlayCritterBuildingBgm()
	end
end

function var_0_0._realCheckIsPlayCritterBuildingBgm(arg_3_0)
	if arg_3_0._bgmPlayingId then
		AudioMgr.instance:stopPlayingID(arg_3_0._bgmPlayingId)
	end

	local var_3_0 = arg_3_0._isPlayCritterBuildingBgm and AudioEnum.Room.play_ui_home_mojing_music or AudioEnum.Room.bgm_music_home

	if arg_3_0._isPlayCritterBuildingBgm then
		AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
	else
		AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)
	end

	arg_3_0._bgmPlayingId = AudioMgr.instance:trigger(var_3_0)
	arg_3_0._waitCheck = false
end

function var_0_0.playRoomAudio(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= SceneType.Room then
		return
	end

	arg_4_0:changeRTPCValue()
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_closeshot_ocean)

	arg_4_0._bgmPlayingId = AudioMgr.instance:trigger(AudioEnum.Room.bgm_music_home)

	arg_4_0:_playBuildingAudio()
	RoomMapController.instance:dispatchEvent(RoomEvent.StartPlayAmbientAudio)
end

function var_0_0._playBuildingAudio(arg_5_0)
	if RoomController.instance:isEditMode() then
		return
	end

	local var_5_0 = GameSceneMgr.instance:getCurScene()
	local var_5_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = var_5_0.buildingmgr:getBuildingEntity(iter_5_1.id, SceneTag.RoomBuilding)

		if var_5_2 and iter_5_1.config and iter_5_1.config.sound ~= 0 then
			var_5_2:playAudio(iter_5_1.config.sound)
			logNormal(string.format("RoomBuildingEntity:playAudio() ->[%s] [%s] ", iter_5_1.config.name, iter_5_1.config.sound))
		end
	end
end

function var_0_0.changeRTPCValue(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCameraTrs()
	local var_6_1 = arg_6_0:getRtpcValue(var_6_0.position.y - arg_6_0.mainCameraFocusPositionY)

	AudioMgr.instance:setRTPCValue(AudioEnum.RoomRTPC.MainCamera, var_6_1)
end

function var_0_0.getRtpcValue(arg_7_0, arg_7_1)
	local var_7_0 = 0
	local var_7_1

	if arg_7_1 <= var_0_0.CameraMinDistance then
		var_7_1 = 0
	elseif arg_7_1 >= var_0_0.CameraMaxDistance then
		var_7_1 = 1
	else
		local var_7_2 = var_0_0.CameraMaxDistance - var_0_0.CameraMinDistance

		var_7_1 = (arg_7_1 - var_0_0.CameraMinDistance) / var_7_2
	end

	return var_7_1
end

function var_0_0._onStoryStart(arg_8_0, arg_8_1)
	if not RoomTrainCritterModel.instance:isCritterTrainStory(arg_8_1) then
		AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_lower)
	end
end

function var_0_0._onStoryFinish(arg_9_0, arg_9_1)
	AudioMgr.instance:trigger(AudioEnum.Room.set_home_all_normal)
end

function var_0_0.onSceneClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home)
	gohelper.enableAkListener(arg_10_0.audioManagerGo, true)
	gohelper.enableAkListener(arg_10_0.mainCameraGo, false)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchScale, arg_10_0.changeRTPCValue, arg_10_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_10_0.playRoomAudio, arg_10_0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_10_0._onStoryStart, arg_10_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_10_0._onStoryFinish, arg_10_0)
	StoryController.instance:unregisterCallback(StoryEvent.DialogConFinished, arg_10_0._onStoryFinish, arg_10_0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingViewChange, arg_10_0._onPlayCritterBuildingBgm, arg_10_0)
end

return var_0_0
