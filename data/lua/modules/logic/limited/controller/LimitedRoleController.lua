module("modules.logic.limited.controller.LimitedRoleController", package.seeall)

local var_0_0 = class("LimitedRoleController", BaseController)

var_0_0.PlayAction = GameUtil.getEventId()
var_0_0.ManualSkip = GameUtil.getEventId()
var_0_0.VideoState = GameUtil.getEventId()

function var_0_0.onInit(arg_1_0)
	arg_1_0._isPlayingVideo = false
	arg_1_0._isPlayingAction = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._isPlayingVideo = false
	arg_2_0._isPlayingAction = false

	arg_2_0:unregisterCallback(var_0_0.PlayAction, arg_2_0._playAction, arg_2_0)
	arg_2_0:unregisterCallback(var_0_0.ManualSkip, arg_2_0._manualSkip, arg_2_0)
	arg_2_0:unregisterCallback(var_0_0.VideoState, arg_2_0._onVideoState, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._stopMainBgm, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._HideMainView, arg_2_0)
	arg_2_0:_clearEffect()
	arg_2_0:_stopVideoAudio()
end

function var_0_0.play(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_0._isPlayingVideo and isDebugBuild then
		logError("正在播放限定角色入场效果 " .. arg_3_1)

		return
	end

	arg_3_0:_stopVideoAudio()
	arg_3_0:_stopVoice()
	TaskDispatcher.cancelTask(arg_3_0._clearActionState, arg_3_0)

	arg_3_0._isPlayingVideo = true
	arg_3_0._stage = arg_3_1
	arg_3_0._limitedCO = arg_3_2
	arg_3_0._callback = arg_3_3
	arg_3_0._callbackObj = arg_3_4

	arg_3_0:registerCallback(var_0_0.PlayAction, arg_3_0._playAction, arg_3_0)
	arg_3_0:registerCallback(var_0_0.ManualSkip, arg_3_0._manualSkip, arg_3_0)
	ViewMgr.instance:openView(ViewName.LimitedRoleView, {
		limitedCO = arg_3_2
	})
	arg_3_0:_stopMainBgm()
	arg_3_0:_HideMainView()
	AudioBgmManager.instance:registerCallback(AudioBgmEvent.onPlayBgm, arg_3_0._stopMainBgm, arg_3_0, LuaEventSystem.Low)
	TaskDispatcher.runDelay(arg_3_0._HideMainView, arg_3_0, 2)
	arg_3_0:registerCallback(var_0_0.VideoState, arg_3_0._onVideoState, arg_3_0)
end

function var_0_0._onVideoState(arg_4_0, arg_4_1)
	if arg_4_1 == AvProEnum.PlayerStatus.Started then
		arg_4_0:unregisterCallback(var_0_0.VideoState, arg_4_0._onVideoState, arg_4_0)

		if arg_4_0._limitedCO and arg_4_0._limitedCO.audio > 0 then
			AudioMgr.instance:trigger(arg_4_0._limitedCO.audio, nil)
		end
	end
end

function var_0_0.isPlayingVideo(arg_5_0)
	return arg_5_0._isPlayingVideo
end

function var_0_0.isPlayingAction(arg_6_0)
	return arg_6_0._isPlayingAction
end

function var_0_0.isPlaying(arg_7_0)
	return arg_7_0._isPlayingVideo or arg_7_0._isPlayingAction
end

function var_0_0.stop(arg_8_0)
	arg_8_0._isPlayingVideo = false
	arg_8_0._callback = nil
	arg_8_0._callbackObj = nil

	arg_8_0:unregisterCallback(var_0_0.PlayAction, arg_8_0._playAction, arg_8_0)
	arg_8_0:unregisterCallback(var_0_0.ManualSkip, arg_8_0._manualSkip, arg_8_0)
	arg_8_0:unregisterCallback(var_0_0.VideoState, arg_8_0._onVideoState, arg_8_0)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, arg_8_0._stopMainBgm, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._HideMainView, arg_8_0)
	ViewMgr.instance:closeView(ViewName.LimitedRoleView)

	if arg_8_0._stage and arg_8_0._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end
end

function var_0_0._stopMainBgm(arg_9_0)
	AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
end

function var_0_0._HideMainView(arg_10_0)
	if arg_10_0._stage == LimitedRoleEnum.Stage.FirstLogin and ViewMgr.instance:isOpen(ViewName.MainView) then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)
	end
end

function var_0_0._manualSkip(arg_11_0)
	arg_11_0:unregisterCallback(var_0_0.PlayAction, arg_11_0._playAction, arg_11_0)
	arg_11_0:unregisterCallback(var_0_0.ManualSkip, arg_11_0._manualSkip, arg_11_0)
	arg_11_0:unregisterCallback(var_0_0.VideoState, arg_11_0._onVideoState, arg_11_0)

	arg_11_0._isPlayingVideo = false
	arg_11_0._isPlayingAction = false

	arg_11_0:_clearEffect()
	arg_11_0:_clearActionState()
end

function var_0_0._playAction(arg_12_0)
	arg_12_0:unregisterCallback(var_0_0.PlayAction, arg_12_0._playAction, arg_12_0)
	arg_12_0:unregisterCallback(var_0_0.ManualSkip, arg_12_0._manualSkip, arg_12_0)
	arg_12_0:unregisterCallback(var_0_0.VideoState, arg_12_0._onVideoState, arg_12_0)
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, arg_12_0._stopMainBgm, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._HideMainView, arg_12_0)
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	local var_12_0 = arg_12_0._limitedCO and arg_12_0._limitedCO.voice
	local var_12_1 = arg_12_0._limitedCO and arg_12_0._limitedCO.actionTime
	local var_12_2 = arg_12_0._limitedCO and arg_12_0._limitedCO.entranceEffect
	local var_12_3 = arg_12_0._limitedCO and arg_12_0._limitedCO.effectDuration
	local var_12_4 = ViewMgr.instance:getContainer(ViewName.MainView)

	if var_12_4 then
		if not string.nilorempty(var_12_2) then
			arg_12_0:_playEntranceEffect(var_12_2, var_12_3)
		end

		local var_12_5 = var_12_4:getMainHeroView()
		local var_12_6, var_12_7 = CharacterSwitchListModel.instance:getMainHero()
		local var_12_8 = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, var_12_6, 1)
		local var_12_9

		var_12_9 = tonumber(var_12_8) or 1

		local var_12_10 = var_12_0[var_12_9] or 0
		local var_12_11 = var_12_1[var_12_9] or 0

		if var_12_5 and var_12_10 > 0 then
			var_12_5:checkSwitchShowInScene()

			local var_12_12 = lua_skin.configDict[arg_12_0._limitedCO.id]
			local var_12_13 = var_12_12 and var_12_12.characterId
			local var_12_14 = CharacterDataConfig.instance:getCharacterVoiceCO(var_12_13, var_12_10)

			if var_12_14 then
				if var_12_11 > 0 then
					if arg_12_0._stage == LimitedRoleEnum.Stage.FirstLogin then
						arg_12_0:_blockMainViewClick(var_12_11)
					end

					arg_12_0._isPlayingAction = true

					TaskDispatcher.runDelay(arg_12_0._clearActionState, arg_12_0, var_12_11)
				end

				var_12_5:playVoice(var_12_14)
			else
				logError("限定角色语音配置不存在 " .. var_12_10)
			end
		end
	end

	arg_12_0._isPlayingVideo = false
end

function var_0_0._playEntranceEffect(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = GameSceneMgr.instance:getScene(SceneType.Main):getSceneContainerGO()

	arg_13_0._effectRoot = gohelper.create3d(var_13_0, "EntranceEffect")
	arg_13_0._effectPrefabInstantiate = PrefabInstantiate.Create(arg_13_0._effectRoot)

	arg_13_0._effectPrefabInstantiate:startLoad(ResUrl.getEffect(arg_13_1))
	TaskDispatcher.runDelay(arg_13_0._clearEffect, arg_13_0, arg_13_2 or 5)
end

function var_0_0._clearEffect(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._clearEffect, arg_14_0)

	if arg_14_0._effectPrefabInstantiate then
		arg_14_0._effectPrefabInstantiate:dispose()

		arg_14_0._effectPrefabInstantiate = nil
	end

	if not gohelper.isNil(arg_14_0._effectRoot) then
		gohelper.destroy(arg_14_0._effectRoot)

		arg_14_0._effectRoot = nil
	end
end

function var_0_0._stopVideoAudio(arg_15_0)
	if arg_15_0._limitedCO and arg_15_0._limitedCO.stopAudio > 0 then
		AudioMgr.instance:trigger(arg_15_0._limitedCO.stopAudio)
	end
end

function var_0_0._stopVoice(arg_16_0)
	arg_16_0._isPlayingAction = false

	MainController.instance:dispatchEvent(MainEvent.ForceStopVoice)
end

function var_0_0._clearActionState(arg_17_0)
	arg_17_0:_stopVideoAudio()
	AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)

	if arg_17_0._stage == LimitedRoleEnum.Stage.FirstLogin then
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end

	arg_17_0:_cancelBlockMainViewClick()
	AudioBgmManager.instance:unregisterCallback(AudioBgmEvent.onPlayBgm, arg_17_0._stopMainBgm, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._HideMainView, arg_17_0)

	arg_17_0._stage = nil
	arg_17_0._isPlayingAction = false
	arg_17_0._limitedCO = nil

	local var_17_0 = arg_17_0._callback
	local var_17_1 = arg_17_0._callbackObj

	arg_17_0._callback = nil
	arg_17_0._callbackObj = nil

	if var_17_0 then
		var_17_0(var_17_1)
	end
end

function var_0_0.getNeedPlayLimitedCO(arg_18_0)
	if VersionValidator.instance:isInReviewing() then
		return nil
	end

	local var_18_0, var_18_1 = CharacterSwitchListModel.instance:getMainHero(false)
	local var_18_2 = lua_character_limited.configDict[var_18_1]

	if var_18_2 and not string.nilorempty(var_18_2.entranceMv) then
		return var_18_2
	end

	return nil
end

function var_0_0._blockMainViewClick(arg_19_0, arg_19_1)
	UIBlockMgr.instance:startBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.cancelTask(arg_19_0._cancelBlockMainViewClick, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0._cancelBlockMainViewClick, arg_19_0, arg_19_1 or 10)
end

function var_0_0._cancelBlockMainViewClick(arg_20_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.LimitedRoleMainView)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_20_0._cancelBlockMainViewClick, arg_20_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
