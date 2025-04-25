module("modules.logic.limited.controller.LimitedRoleController", package.seeall)

slot0 = class("LimitedRoleController", BaseController)
slot0.PlayAction = GameUtil.getEventId()
slot0.ManualSkip = GameUtil.getEventId()
slot0.VideoState = GameUtil.getEventId()

function slot0.onInit(slot0)
	slot0._isPlayingVideo = false
	slot0._isPlayingAction = false
end

function slot0.reInit(slot0)
	slot0._isPlayingVideo = false
	slot0._isPlayingAction = false

	slot0:unregisterCallback(uv0.PlayAction, slot0._playAction, slot0)
	slot0:unregisterCallback(uv0.ManualSkip, slot0._manualSkip, slot0)
	slot0:unregisterCallback(uv0.VideoState, slot0._onVideoState, slot0)
	TaskDispatcher.cancelTask(slot0._stopMainBgm, slot0)
	TaskDispatcher.cancelTask(slot0._HideMainView, slot0)
	slot0:_clearEffect()
	slot0:_stopVideoAudio()
end

function slot0.play(slot0, slot1, slot2, slot3, slot4)
	if slot0._isPlayingVideo and isDebugBuild then
		logError("正在播放限定角色入场效果 " .. slot1)

		return
	end

	slot0:_stopVideoAudio()
	slot0:_stopVoice()
	TaskDispatcher.cancelTask(slot0._clearActionState, slot0)

	slot0._isPlayingVideo = true
	slot0._stage = slot1
	slot0._limitedCO = slot2
	slot0._callback = slot3
	slot0._callbackObj = slot4

	slot0:registerCallback(uv0.PlayAction, slot0._playAction, slot0)
	slot0:registerCallback(uv0.ManualSkip, slot0._manualSkip, slot0)
	ViewMgr.instance:openView(ViewName.LimitedRoleView, {
		limitedCO = slot2
	})
	slot0:_stopMainBgm()
	slot0:_HideMainView()
	AudioBgmManager.instance:registerCallback(AudioBgmEvent.onPlayBgm, slot0._stopMainBgm, slot0, LuaEventSystem.Low)
	TaskDispatcher.runDelay(slot0._HideMainView, slot0, 2)
	slot0:registerCallback(uv0.VideoState, slot0._onVideoState, slot0)
end

function slot0._onVideoState(slot0, slot1)
	if slot1 == AvProEnum.PlayerStatus.Started then
		slot0:unregisterCallback(uv0.VideoState, slot0._onVideoState, slot0)

		if slot0._limitedCO and slot0._limitedCO.audio > 0 then
			AudioMgr.instance:trigger(slot0._limitedCO.audio, nil)
		end
	end
end

function slot0.isPlayingVideo(slot0)
	return slot0._isPlayingVideo
end

function slot0.isPlayingAction(slot0)
	return slot0._isPlayingAction
end

function slot0.isPlaying(slot0)
	return slot0._isPlayingVideo or slot0._isPlayingAction
end

function slot0.stop(slot0)
	slot0._isPlayingVideo = false
	slot0._callback = nil
	slot0._callbackObj = nil

	slot0:unregisterCallback(uv0.PlayAction, slot0._playAction, slot0)
	slot0:unregisterCallback(uv0.ManualSkip, slot0._manualSkip, slot0)
	slot0:unregisterCallback(uv0.VideoState, slot0._onVideoState, slot0)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, slot0._stopMainBgm, slot0)
	TaskDispatcher.cancelTask(slot0._HideMainView, slot0)
	ViewMgr.instance:closeView(ViewName.LimitedRoleView)

	if slot0._stage and slot0._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end
end

function slot0._stopMainBgm(slot0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function slot0._HideMainView(slot0)
	if slot0._stage == LimitedRoleEnum.Stage.FirstLogin and ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)
	end
end

function slot0._manualSkip(slot0)
	slot0:unregisterCallback(uv0.PlayAction, slot0._playAction, slot0)
	slot0:unregisterCallback(uv0.ManualSkip, slot0._manualSkip, slot0)
	slot0:unregisterCallback(uv0.VideoState, slot0._onVideoState, slot0)

	slot0._isPlayingVideo = false
	slot0._isPlayingAction = false

	slot0:_clearEffect()
	slot0:_clearActionState()
end

function slot0._playAction(slot0)
	slot0:unregisterCallback(uv0.PlayAction, slot0._playAction, slot0)
	slot0:unregisterCallback(uv0.ManualSkip, slot0._manualSkip, slot0)
	slot0:unregisterCallback(uv0.VideoState, slot0._onVideoState, slot0)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, slot0._stopMainBgm, slot0)
	TaskDispatcher.cancelTask(slot0._HideMainView, slot0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	slot1 = slot0._limitedCO and slot0._limitedCO.voice
	slot2 = slot0._limitedCO and slot0._limitedCO.actionTime
	slot3 = slot0._limitedCO and slot0._limitedCO.entranceEffect

	if ViewMgr.instance:getContainer(ViewName.MainView) then
		if not string.nilorempty(slot3) then
			slot0:_playEntranceEffect(slot3, slot0._limitedCO and slot0._limitedCO.effectDuration)
		end

		slot7, slot8 = CharacterSwitchListModel.instance:getMainHero()
		slot9 = tonumber(PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, slot7, 1)) or 1
		slot10 = slot1[slot9] or 0
		slot11 = slot2[slot9] or 0

		if slot5:getMainHeroView() and slot10 > 0 then
			slot6:checkSwitchShowInScene()

			if CharacterDataConfig.instance:getCharacterVoiceCO(lua_skin.configDict[slot0._limitedCO.id] and slot12.characterId, slot10) then
				if slot11 > 0 then
					if slot0._stage == LimitedRoleEnum.Stage.FirstLogin then
						slot0:_blockMainViewClick(slot11)
					end

					slot0._isPlayingAction = true

					TaskDispatcher.runDelay(slot0._clearActionState, slot0, slot11)
				end

				slot6:playVoice(slot14)
			else
				logError("限定角色语音配置不存在 " .. slot10)
			end
		end
	end

	slot0._isPlayingVideo = false
end

function slot0._playEntranceEffect(slot0, slot1, slot2)
	slot0._effectRoot = gohelper.create3d(GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO(), "EntranceEffect")
	slot0._effectPrefabInstantiate = PrefabInstantiate.Create(slot0._effectRoot)

	slot0._effectPrefabInstantiate:startLoad(ResUrl.getEffect(slot1))
	TaskDispatcher.runDelay(slot0._clearEffect, slot0, slot2 or 5)
end

function slot0._clearEffect(slot0)
	TaskDispatcher.cancelTask(slot0._clearEffect, slot0)

	if slot0._effectPrefabInstantiate then
		slot0._effectPrefabInstantiate:dispose()

		slot0._effectPrefabInstantiate = nil
	end

	if not gohelper.isNil(slot0._effectRoot) then
		gohelper.destroy(slot0._effectRoot)

		slot0._effectRoot = nil
	end
end

function slot0._stopVideoAudio(slot0)
	if slot0._limitedCO and slot0._limitedCO.stopAudio > 0 then
		AudioMgr.instance:trigger(slot0._limitedCO.stopAudio)
	end
end

function slot0._stopVoice(slot0)
	slot0._isPlayingAction = false

	MainController.instance:dispatchEvent(MainEvent.ForceStopVoice)
end

function slot0._clearActionState(slot0)
	slot0:_stopVideoAudio()
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	if slot0._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	slot0:_cancelBlockMainViewClick()
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, slot0._stopMainBgm, slot0)
	TaskDispatcher.cancelTask(slot0._HideMainView, slot0)

	slot0._stage = nil
	slot0._isPlayingAction = false
	slot0._limitedCO = nil
	slot0._callback = nil
	slot0._callbackObj = nil

	if slot0._callback then
		slot1(slot0._callbackObj)
	end
end

function slot0.getNeedPlayLimitedCO(slot0)
	if VersionValidator.instance:isInReviewing() then
		return nil
	end

	slot1, slot2 = CharacterSwitchListModel.instance:getMainHero(false)

	if lua_character_limited.configDict[slot2] and not string.nilorempty(slot3.entranceMv) then
		return slot3
	end

	return nil
end

function slot0._blockMainViewClick(slot0, slot1)
	UIBlockMgr.instance:startBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(slot0._cancelBlockMainViewClick, slot0)
	TaskDispatcher.runDelay(slot0._cancelBlockMainViewClick, slot0, slot1 or 10)
end

function slot0._cancelBlockMainViewClick(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0._cancelBlockMainViewClick, slot0)
end

slot0.instance = slot0.New()

return slot0
