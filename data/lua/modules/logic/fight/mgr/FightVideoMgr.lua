module("modules.logic.fight.mgr.FightVideoMgr", package.seeall)

local var_0_0 = class("FightVideoMgr")
local var_0_1 = "ui/viewres/fight/fightvideo.prefab"

function var_0_0.ctor(arg_1_0)
	arg_1_0._avProVideoPlayer = nil
	arg_1_0._displauUGUI = nil
	arg_1_0._mediaPlayer = nil
	arg_1_0._videoName = nil
	arg_1_0._isPlaying = false
	arg_1_0._callback = nil
	arg_1_0._callbackObj = nil
	arg_1_0._prefabLoader = nil
end

function var_0_0.init(arg_2_0)
	arg_2_0:_checkVideCopatible()
end

function var_0_0.dispose(arg_3_0)
	arg_3_0:stop()
end

function var_0_0._checkVideCopatible(arg_4_0)
	if arg_4_0._videoCopatible ~= SettingsModel.instance:getVideoCompatible() then
		arg_4_0:stop()

		if arg_4_0._avProVideoPlayer then
			arg_4_0._avProVideoPlayer:Clear()

			arg_4_0._avProVideoPlayer = nil
			arg_4_0._mediaPlayer = nil
			arg_4_0._displauUGUI = nil
		end

		if arg_4_0._prefabLoader then
			arg_4_0._prefabLoader:dispose()

			arg_4_0._prefabLoader = nil
		end

		if arg_4_0._videoRootGO then
			gohelper.destroy(arg_4_0._videoRootGO)

			arg_4_0._videoRootGO = nil
		end
	end
end

function var_0_0.isSameVideo(arg_5_0, arg_5_1)
	return arg_5_1 == arg_5_0._videoName
end

function var_0_0.play(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if string.nilorempty(arg_6_1) then
		logError("video path is nil")

		return
	end

	arg_6_0._pause = false
	arg_6_0._videoName = arg_6_1
	arg_6_0._callback = arg_6_2
	arg_6_0._callbackObj = arg_6_3

	if arg_6_0._videoRootGO then
		arg_6_0:_playVideo()
	else
		arg_6_0._videoCopatible = SettingsModel.instance:getVideoCompatible()
		arg_6_0._prefabLoader = MultiAbLoader.New()

		arg_6_0._prefabLoader:addPath(AvProMgr.instance:getFightUrl())
		arg_6_0._prefabLoader:startLoad(arg_6_0._onVideoPrefabLoaded, arg_6_0)
	end

	FightController.instance:dispatchEvent(FightEvent.OnPlayVideo, arg_6_1)
end

function var_0_0._onVideoPrefabLoaded(arg_7_0, arg_7_1)
	local var_7_0 = ViewMgr.instance:getUILayer(UILayerName.PopUp)

	arg_7_0._videoRootGO = gohelper.clone(arg_7_1:getFirstAssetItem():GetResource(), var_7_0, "FightVideo")

	local var_7_1 = gohelper.findChild(arg_7_0._videoRootGO, "FightVideo")

	if SettingsModel.instance:getVideoEnabled() == false then
		arg_7_0._avProVideoPlayer = AvProUGUIPlayer_adjust.instance
		arg_7_0._mediaPlayer = MediaPlayer_adjust.New()
	else
		arg_7_0._displauUGUI = gohelper.onceAddComponent(var_7_1, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
		arg_7_0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		arg_7_0._avProVideoPlayer = gohelper.onceAddComponent(var_7_1, typeof(ZProj.AvProUGUIPlayer))

		arg_7_0._avProVideoPlayer:AddDisplayUGUI(arg_7_0._displauUGUI)

		arg_7_0._mediaPlayer = gohelper.onceAddComponent(var_7_1, typeof(RenderHeads.Media.AVProVideo.MediaPlayer))
	end

	arg_7_0:_playVideo()
end

function var_0_0._playVideo(arg_8_0)
	arg_8_0:stop()

	arg_8_0._isPlaying = true

	if arg_8_0._avProVideoPlayer then
		gohelper.setActive(arg_8_0._videoRootGO, true)

		local var_8_0 = langVideoUrl(arg_8_0._videoName)

		arg_8_0._avProVideoPlayer:LoadMedia(var_8_0)
		arg_8_0._avProVideoPlayer:Play(arg_8_0._displauUGUI, false)

		arg_8_0._mediaPlayer.PlaybackRate = FightModel.instance:getSpeed() * Time.timeScale

		if arg_8_0._pause then
			arg_8_0:pause()
		end
	end
end

function var_0_0.stop(arg_9_0)
	if arg_9_0._isPlaying then
		arg_9_0._pause = false
		arg_9_0._isPlaying = false

		arg_9_0:_stopVideo()
	end
end

function var_0_0.pause(arg_10_0)
	if arg_10_0._avProVideoPlayer then
		gohelper.setActive(arg_10_0._videoRootGO, false)
	else
		arg_10_0._pause = true
	end
end

function var_0_0.isPause(arg_11_0)
	return arg_11_0._pause
end

function var_0_0.continue(arg_12_0, arg_12_1)
	if arg_12_0._videoName == arg_12_1 and arg_12_0._isPlaying then
		arg_12_0._pause = false

		if arg_12_0._avProVideoPlayer then
			gohelper.setActive(arg_12_0._videoRootGO, true)
		end
	end
end

function var_0_0._stopVideo(arg_13_0)
	if arg_13_0._avProVideoPlayer then
		arg_13_0._avProVideoPlayer:Stop()
		arg_13_0._mediaPlayer:CloseMedia()
		gohelper.setActive(arg_13_0._videoRootGO, false)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
