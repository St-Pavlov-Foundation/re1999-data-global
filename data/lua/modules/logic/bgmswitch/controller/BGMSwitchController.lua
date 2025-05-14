module("modules.logic.bgmswitch.controller.BGMSwitchController", package.seeall)

local var_0_0 = class("BGMSwitchController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._hasStopMainBgm = nil
	arg_1_0._bgmProgress = BGMSwitchProgress.New()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._hasStopMainBgm = nil
	arg_2_0._ppk = nil

	TaskDispatcher.cancelTask(arg_2_0._delayStartAll, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_3_0._onEnterScene, arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, arg_3_0._onExistScene, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_3_0._onStoryStart, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_3_0._onStoryFinish, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseView, arg_3_0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, arg_3_0._onTriggerEvent, arg_3_0)
	arg_3_0:registerCallback(BGMSwitchEvent.SwitchGearByGuide, arg_3_0._switchGearByGuide, arg_3_0)
end

function var_0_0._isPlayableView(arg_4_0)
	local var_4_0 = ViewMgr.instance:getOpenViewNameList()

	if var_4_0[#var_4_0] == ViewName.MainSwitchView then
		return true
	end

	return NavigateMgr.instance:isMainViewInTop()
end

function var_0_0._onEnterScene(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == SceneType.Main and LoginController.instance:isEnteredGame() and arg_5_0:_isPlayableView() then
		arg_5_0:checkStartAll()
	end
end

function var_0_0._onExistScene(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == SceneType.Main then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)

		arg_6_0._hasStopMainBgm = true
	end
end

function var_0_0._onStoryStart(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._delayStartAll, arg_7_0)
	arg_7_0:checkStopAll()
end

function var_0_0._onStoryFinish(arg_8_0)
	arg_8_0:checkStartAll()
end

local var_0_1

function var_0_0._onOpenView(arg_9_0, arg_9_1)
	if not var_0_1 then
		var_0_1 = {
			[ViewName.WeekWalkView] = true
		}
	end

	if var_0_1[arg_9_1] then
		arg_9_0:checkStopAll()
	end

	if arg_9_0:_isPlayableView() then
		arg_9_0:checkStartAll()
	end
end

function var_0_0._onCloseView(arg_10_0)
	if arg_10_0:_isPlayableView() then
		TaskDispatcher.runDelay(arg_10_0._onCloseViewCheckAgain, arg_10_0, 0.1)
	end
end

function var_0_0._onCloseViewCheckAgain(arg_11_0)
	if arg_11_0:_isPlayableView() then
		arg_11_0:checkStartAll()
	end
end

local var_0_2 = {
	[AudioEnum.Bgm.Stop_LeiMiTeBeiBgm] = true
}

function var_0_0._onTriggerEvent(arg_12_0, arg_12_1)
	if var_0_2[arg_12_1] then
		arg_12_0:checkStopAll()
	end
end

function var_0_0.checkStopAll(arg_13_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)
		WeatherController.instance:stopWeatherAudio()

		arg_13_0._hasStopMainBgm = true

		arg_13_0._bgmProgress:stopMainBgm()
	end
end

function var_0_0.checkStartAll(arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._delayStartAll, arg_14_0, 0.1)
end

function var_0_0._delayStartAll(arg_15_0)
	local var_15_0 = GameSceneMgr.instance:getCurSceneType() == SceneType.Main

	if arg_15_0._hasStopMainBgm and var_15_0 then
		arg_15_0._hasStopMainBgm = nil

		arg_15_0:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function var_0_0.startAllOnLogin(arg_16_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		local var_16_0 = BGMSwitchModel.instance:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear)

		BGMSwitchModel.instance:setMechineGear(var_16_0)
		arg_16_0:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function var_0_0.checkStartMainBGM(arg_17_0, arg_17_1)
	TaskDispatcher.cancelTask(arg_17_0._delayStartAll, arg_17_0)

	local var_17_0 = arg_17_0:getBgmAudioId()

	if not arg_17_1 and var_17_0 == arg_17_0._mainAudioId then
		return
	end

	if var_17_0 then
		arg_17_0:playMainBgm(var_17_0, arg_17_1, true)
	end

	if isDebugBuild then
		local var_17_1 = BGMSwitchModel.instance:getBGMPlayMode()
		local var_17_2 = BGMSwitchModel.instance:getCurrentServerUsingBgmList()
		local var_17_3 = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(var_17_0)
		local var_17_4 = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(arg_17_0._preAudioId)
		local var_17_5 = {
			[StatEnum.EventProperties.AudioId] = var_17_3 and tostring(var_17_3.id) or nil,
			[StatEnum.EventProperties.AudioName] = var_17_3 and var_17_3.audioName or nil,
			[StatEnum.EventProperties.BeforeSwitchAudio] = var_17_4 and var_17_4.audioName or nil,
			[StatEnum.EventProperties.OperationType] = "background bgm auto next",
			[StatEnum.EventProperties.PlayMode] = var_17_1 == BGMSwitchEnum.PlayMode.Random and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(var_17_2)
		}

		logNormal("track checkStartMainBGM: " .. cjson.encode(var_17_5))
	end
end

function var_0_0.playMainBgm(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_2 and arg_18_1 == arg_18_0._mainAudioId then
		return
	end

	arg_18_0._mainAudioId = arg_18_1

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	arg_18_0:stopMainBgm()
	var_0_0.instance:resumeMainBgm()

	if arg_18_0._preAudioId ~= nil and arg_18_0._preAudioId ~= arg_18_1 and arg_18_3 and arg_18_0._playingId then
		local var_18_0 = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(arg_18_0._preAudioId)

		if var_18_0 and var_18_0.isNonLoop == 1 then
			AudioMgr.instance:stopPlayingID(arg_18_0._playingId)
		end
	end

	arg_18_0._playingId = AudioMgr.instance:triggerEx(arg_18_1, bit.bor(AkCallbackEnum.Type.AK_EnableGetSourcePlayPosition, AkCallbackEnum.Type.AK_Duration), nil)
	arg_18_0._preAudioId = arg_18_1

	arg_18_0._bgmProgress:playMainBgm(arg_18_1)
	arg_18_0:dispatchEvent(BGMSwitchEvent.OnPlayMainBgm, arg_18_1)
end

function var_0_0.getPlayingId(arg_19_0)
	return arg_19_0._playingId
end

function var_0_0.getMainBgmAudioId(arg_20_0)
	return arg_20_0._mainAudioId
end

function var_0_0.stopMainBgm(arg_21_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Replay_Mainmusic1_9)
	arg_21_0._bgmProgress:stopMainBgm()
end

function var_0_0.pauseMainBgm(arg_22_0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function var_0_0.resumeMainBgm(arg_23_0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
end

function var_0_0.backMainBgm(arg_24_0)
	if BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId then
		return
	end

	local var_24_0 = arg_24_0:getBgmAudioId()

	if var_24_0 and arg_24_0._preAudioId ~= var_24_0 then
		arg_24_0:playMainBgm(var_24_0, true, true)
	end
end

function var_0_0.getBgmAudioId(arg_25_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		local var_25_0 = BGMSwitchModel.instance:getUsedBgmIdFromServer()

		if BGMSwitchModel.instance:isRandomBgmId(var_25_0) then
			var_25_0 = BGMSwitchModel.instance:nextBgm(1, true)
		end

		local var_25_1 = BGMSwitchConfig.instance:getBGMSwitchCO(var_25_0)

		return var_25_1 and var_25_1.audio or AudioEnum.UI.Play_Replay_Music_Daytime
	end

	return AudioEnum.UI.Play_Replay_Music_Daytime
end

function var_0_0.getProgress(arg_26_0)
	return arg_26_0._bgmProgress:getProgress()
end

function var_0_0.openBGMSwitchView(arg_27_0, arg_27_1)
	ViewMgr.instance:openView(ViewName.BGMSwitchView, arg_27_1)
end

function var_0_0.openBGMSwitchMusicFilterView(arg_28_0)
	ViewMgr.instance:openView(ViewName.BGMSwitchMusicFilterView)
end

function var_0_0._switchGearByGuide(arg_29_0, arg_29_1)
	local var_29_0 = BGMSwitchModel.instance:getMechineGear()
	local var_29_1 = tonumber(arg_29_1)

	if var_29_1 == BGMSwitchEnum.Gear.OFF then
		arg_29_0:stopMainBgm()
	end

	BGMSwitchModel.instance:setMechineGear(var_29_1)
	arg_29_0:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
end

function var_0_0.hasBgmRedDot(arg_30_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		return false
	end

	if not GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId) then
		return true
	end

	local var_30_0 = BGMSwitchModel.instance:getUnReadCount()

	if var_30_0 == 0 then
		return false
	end

	local var_30_1 = PlayerPrefsHelper.getNumber(arg_30_0:getPlayerPrefKey(), nil)

	if not var_30_1 then
		return true
	end

	return var_30_1 < var_30_0
end

function var_0_0.getPlayerPrefKey(arg_31_0)
	if not arg_31_0._ppk then
		arg_31_0._ppk = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.MainBgmUnreadCount)
	end

	return arg_31_0._ppk
end

var_0_0.instance = var_0_0.New()

return var_0_0
