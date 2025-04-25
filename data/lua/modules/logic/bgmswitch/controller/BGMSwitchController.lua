module("modules.logic.bgmswitch.controller.BGMSwitchController", package.seeall)

slot0 = class("BGMSwitchController", BaseController)

function slot0.onInit(slot0)
	slot0._hasStopMainBgm = nil
	slot0._bgmProgress = BGMSwitchProgress.New()
end

function slot0.reInit(slot0)
	slot0._hasStopMainBgm = nil
	slot0._ppk = nil

	TaskDispatcher.cancelTask(slot0._delayStartAll, slot0)
end

function slot0.addConstEvents(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterScene, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, slot0._onExistScene, slot0)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onStoryFinish, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	AudioMgr.instance:registerCallback(AudioMgr.Evt_Trigger, slot0._onTriggerEvent, slot0)
	slot0:registerCallback(BGMSwitchEvent.SwitchGearByGuide, slot0._switchGearByGuide, slot0)
end

function slot0._isPlayableView(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	if slot1[#slot1] == ViewName.MainSwitchView then
		return true
	end

	return NavigateMgr.instance:isMainViewInTop()
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot1 == SceneType.Main and LoginController.instance:isEnteredGame() and slot0:_isPlayableView() then
		slot0:checkStartAll()
	end
end

function slot0._onExistScene(slot0, slot1, slot2, slot3)
	if slot1 == SceneType.Main then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)

		slot0._hasStopMainBgm = true
	end
end

function slot0._onStoryStart(slot0)
	TaskDispatcher.cancelTask(slot0._delayStartAll, slot0)
	slot0:checkStopAll()
end

function slot0._onStoryFinish(slot0)
	slot0:checkStartAll()
end

slot1 = nil

function slot0._onOpenView(slot0, slot1)
	if not uv0 then
		uv0 = {
			[ViewName.WeekWalkView] = true
		}
	end

	if uv0[slot1] then
		slot0:checkStopAll()
	end

	if slot0:_isPlayableView() then
		slot0:checkStartAll()
	end
end

function slot0._onCloseView(slot0)
	if slot0:_isPlayableView() then
		TaskDispatcher.runDelay(slot0._onCloseViewCheckAgain, slot0, 0.1)
	end
end

function slot0._onCloseViewCheckAgain(slot0)
	if slot0:_isPlayableView() then
		slot0:checkStartAll()
	end
end

slot2 = {
	[AudioEnum.Bgm.Stop_LeiMiTeBeiBgm] = true
}

function slot0._onTriggerEvent(slot0, slot1)
	if uv0[slot1] then
		slot0:checkStopAll()
	end
end

function slot0.checkStopAll(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		AudioMgr.instance:trigger(AudioEnum.UI.Pause_MainMusic)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Replay_Noise_Daytime)
		WeatherController.instance:stopWeatherAudio()

		slot0._hasStopMainBgm = true

		slot0._bgmProgress:stopMainBgm()
	end
end

function slot0.checkStartAll(slot0)
	TaskDispatcher.runDelay(slot0._delayStartAll, slot0, 0.1)
end

function slot0._delayStartAll(slot0)
	if slot0._hasStopMainBgm and GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		slot0._hasStopMainBgm = nil

		slot0:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function slot0.startAllOnLogin(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		BGMSwitchModel.instance:setMechineGear(BGMSwitchModel.instance:getRecordInfoByType(BGMSwitchEnum.RecordInfoType.BGMSwitchGear))
		slot0:checkStartMainBGM(true)
		WeatherController.instance:playWeatherAudio()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Replay_Noise_Daytime)
	end
end

function slot0.checkStartMainBGM(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._delayStartAll, slot0)

	slot2 = slot0:getBgmAudioId()

	if not slot1 and slot2 == slot0._mainAudioId then
		return
	end

	if slot2 then
		slot0:playMainBgm(slot2, slot1, true)
	end

	if isDebugBuild then
		slot6 = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(slot0._preAudioId)

		logNormal("track checkStartMainBGM: " .. cjson.encode({
			[StatEnum.EventProperties.AudioId] = BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(slot2) and tostring(slot5.id) or nil,
			[StatEnum.EventProperties.AudioName] = slot5 and slot5.audioName or nil,
			[StatEnum.EventProperties.BeforeSwitchAudio] = slot6 and slot6.audioName or nil,
			[StatEnum.EventProperties.OperationType] = "background bgm auto next",
			[StatEnum.EventProperties.PlayMode] = BGMSwitchModel.instance:getBGMPlayMode() == BGMSwitchEnum.PlayMode.Random and "Random" or "LoopOne",
			[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(BGMSwitchModel.instance:getCurrentServerUsingBgmList())
		}))
	end
end

function slot0.playMainBgm(slot0, slot1, slot2, slot3)
	if not slot2 and slot1 == slot0._mainAudioId then
		return
	end

	slot0._mainAudioId = slot1

	if not BGMSwitchModel.instance:machineGearIsNeedPlayBgm() then
		return
	end

	slot0:stopMainBgm()
	uv0.instance:resumeMainBgm()

	if slot0._preAudioId ~= nil and slot0._preAudioId ~= slot1 and slot3 and slot0._playingId and BGMSwitchConfig.instance:getBGMSwitchCoByAudioId(slot0._preAudioId) and slot4.isNonLoop == 1 then
		AudioMgr.instance:stopPlayingID(slot0._playingId)
	end

	slot0._playingId = AudioMgr.instance:triggerEx(slot1, bit.bor(AkCallbackEnum.Type.AK_EnableGetSourcePlayPosition, AkCallbackEnum.Type.AK_Duration), nil)
	slot0._preAudioId = slot1

	slot0._bgmProgress:playMainBgm(slot1)
	slot0:dispatchEvent(BGMSwitchEvent.OnPlayMainBgm, slot1)
end

function slot0.getPlayingId(slot0)
	return slot0._playingId
end

function slot0.getMainBgmAudioId(slot0)
	return slot0._mainAudioId
end

function slot0.stopMainBgm(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Replay_Mainmusic1_9)
	slot0._bgmProgress:stopMainBgm()
end

function slot0.pauseMainBgm(slot0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function slot0.resumeMainBgm(slot0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
end

function slot0.backMainBgm(slot0)
	if BGMSwitchModel.instance:getUsedBgmIdFromServer() == BGMSwitchModel.RandomBgmId then
		return
	end

	if slot0:getBgmAudioId() and slot0._preAudioId ~= slot1 then
		slot0:playMainBgm(slot1, true, true)
	end
end

function slot0.getBgmAudioId(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		if BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) then
			slot2 = BGMSwitchModel.instance:nextBgm(1, true)
		end

		return BGMSwitchConfig.instance:getBGMSwitchCO(slot2) and slot3.audio or AudioEnum.UI.Play_Replay_Music_Daytime
	end

	return AudioEnum.UI.Play_Replay_Music_Daytime
end

function slot0.getProgress(slot0)
	return slot0._bgmProgress:getProgress()
end

function slot0.openBGMSwitchView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.BGMSwitchView, slot1)
end

function slot0.openBGMSwitchMusicFilterView(slot0)
	ViewMgr.instance:openView(ViewName.BGMSwitchMusicFilterView)
end

function slot0._switchGearByGuide(slot0, slot1)
	slot2 = BGMSwitchModel.instance:getMechineGear()

	if tonumber(slot1) == BGMSwitchEnum.Gear.OFF then
		slot0:stopMainBgm()
	end

	BGMSwitchModel.instance:setMechineGear(slot3)
	slot0:dispatchEvent(BGMSwitchEvent.SelectPlayGear)
end

function slot0.hasBgmRedDot(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch) then
		return false
	end

	if not GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId) then
		return true
	end

	if BGMSwitchModel.instance:getUnReadCount() == 0 then
		return false
	end

	if not PlayerPrefsHelper.getNumber(slot0:getPlayerPrefKey(), nil) then
		return true
	end

	return slot4 < slot3
end

function slot0.getPlayerPrefKey(slot0)
	if not slot0._ppk then
		slot0._ppk = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.MainBgmUnreadCount)
	end

	return slot0._ppk
end

slot0.instance = slot0.New()

return slot0
