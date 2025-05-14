module("modules.logic.activity.view.LinkageActivity_Page2VideoBase", package.seeall)

local var_0_0 = class("LinkageActivity_Page2VideoBase", RougeSimpleItemBase)
local var_0_1 = UnityEngine.Rect

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0.__videoPath = false
	arg_1_0._uvRect = {
		w = 1,
		h = 1,
		x = 0,
		y = 0
	}
	arg_1_0._isNeedLoadingCover = false
end

function var_0_0.getAssetItem_VideoLoadingPng(arg_2_0)
	return arg_2_0:_assetGetViewContainer():getAssetItem_VideoLoadingPng()
end

function var_0_0.onDestroyView(arg_3_0)
	FrameTimerController.onDestroyViewMember(arg_3_0, "_rewindFrameTimer")
	FrameTimerController.onDestroyViewMember(arg_3_0, "_playFrameTimer")

	if arg_3_0._videoPlayer then
		arg_3_0._videoPlayer:Clear()
	end

	var_0_0.super.onDestroyView(arg_3_0)
	arg_3_0:__onDispose()
end

function var_0_0.actId(arg_4_0)
	return arg_4_0:_assetGetParent():actId()
end

function var_0_0.getLinkageActivityCO(arg_5_0)
	return arg_5_0:_assetGetParent():getLinkageActivityCO()
end

local var_0_2 = 5

function var_0_0.createVideoPlayer(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.transform
	local var_6_1 = recthelper.getWidth(var_6_0)
	local var_6_2 = recthelper.getHeight(var_6_0)

	arg_6_0._videoPlayer, arg_6_0._displayUGUI, arg_6_0._videoGo = AvProMgr.instance:getVideoPlayer(arg_6_1)

	local var_6_3 = arg_6_0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

	if var_6_3 then
		var_6_3.enabled = false
	end

	local var_6_4 = arg_6_0._videoGo.transform
	local var_6_5 = recthelper.getWidth(var_6_4)
	local var_6_6 = math.max(1, recthelper.getHeight(var_6_4))
	local var_6_7 = var_6_5 / var_6_6

	if var_6_2 <= var_6_1 then
		var_6_6 = var_6_2
		var_6_5 = var_6_2 * var_6_7
	else
		var_6_5 = var_6_1
		var_6_6 = var_6_1 / var_6_7
	end

	recthelper.setSize(var_6_4, var_6_5 + var_0_2, var_6_6 + var_0_2)
end

function var_0_0.setDisplayUGUITextureRect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0._uvRect = {
		x = arg_7_1 or 0,
		y = arg_7_2 or 0,
		w = arg_7_3 or 1,
		h = arg_7_4 or 1
	}

	if arg_7_0._displayUGUI then
		arg_7_0:_refreshDisplayUGUITextureRect()
	end
end

function var_0_0._refreshDisplayUGUITextureRect(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0._displayUGUI.uvRect = var_0_1.New(0, 0, 1, 1)
	else
		arg_8_0._displayUGUI.uvRect = var_0_1.New(arg_8_0._uvRect.x, arg_8_0._uvRect.y, arg_8_0._uvRect.w, arg_8_0._uvRect.h)
	end

	arg_8_0._displayUGUI:SetVerticesDirty()
end

function var_0_0.loadVideo(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.__videoPath == arg_9_1 then
		return
	end

	FrameTimerController.onDestroyViewMember(arg_9_0, "_playFrameTimer")
	arg_9_0:_loadVideo(arg_9_1)
	FrameTimerController.onDestroyViewMember(arg_9_0, "_rewindFrameTimer")

	if arg_9_2 then
		arg_9_0._videoPlayer:Play(arg_9_0._displayUGUI, arg_9_1, false)

		arg_9_0._rewindFrameTimer = FrameTimerController.instance:register(function()
			if not arg_9_0:_canPlay() then
				return
			end

			arg_9_0:_refreshDisplayUGUITextureRect(true)
			arg_9_0:_rewind(true)
			FrameTimerController.onDestroyViewMember(arg_9_0, "_rewindFrameTimer")
		end, nil, 5, 3)

		arg_9_0._rewindFrameTimer:Start()
	end
end

function var_0_0._loadVideo(arg_11_0, arg_11_1)
	if arg_11_0._isNeedLoadingCover then
		arg_11_0:_refreshLoadingCover()
		arg_11_0:_setActive_LoadingCover(true)
	end

	arg_11_0.__videoPath = arg_11_1

	arg_11_0._videoPlayer:LoadMedia(arg_11_1)
end

function var_0_0.play(arg_12_0, arg_12_1, arg_12_2)
	assert(arg_12_0.__videoPath, "please called 'loadVideo' first!!")

	if not arg_12_0:_isPlaying() then
		arg_12_0:_play(arg_12_1, arg_12_2)
	else
		arg_12_0:_rewind(false)
		arg_12_0:_play(arg_12_1, arg_12_2)
	end
end

function var_0_0.stop(arg_13_0, arg_13_1)
	FrameTimerController.onDestroyViewMember(arg_13_0, "_playFrameTimer")
	FrameTimerController.onDestroyViewMember(arg_13_0, "_rewindFrameTimer")

	if arg_13_1 then
		AudioMgr.instance:trigger(arg_13_1)
	end

	arg_13_0:_rewind(true)
end

function var_0_0._play(arg_14_0, arg_14_1, arg_14_2)
	FrameTimerController.onDestroyViewMember(arg_14_0, "_playFrameTimer")

	if not arg_14_0:_canPlay() then
		arg_14_0._playFrameTimer = FrameTimerController.instance:register(function()
			if not arg_14_0:_canPlay() then
				return
			end

			FrameTimerController.onDestroyViewMember(arg_14_0, "_playFrameTimer")
			arg_14_0:_onPlay(arg_14_1, arg_14_2)
		end, nil, 9, 9)

		arg_14_0._playFrameTimer:Start()
	else
		arg_14_0:_onPlay(arg_14_1, arg_14_2)
	end
end

function var_0_0._onPlay(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._isNeedLoadingCover then
		arg_16_0:_setActive_LoadingCover(false)
	end

	arg_16_0._videoPlayer:Play(arg_16_0._displayUGUI, arg_16_2)

	if arg_16_1 then
		AudioMgr.instance:trigger(arg_16_1)
	end
end

function var_0_0._rewind(arg_17_0, arg_17_1)
	arg_17_0._videoPlayer:Rewind(arg_17_1)
end

function var_0_0._canPlay(arg_18_0)
	return arg_18_0._videoPlayer:CanPlay()
end

function var_0_0._isPlaying(arg_19_0)
	return arg_19_0._videoPlayer:IsPlaying()
end

function var_0_0._setActive_LoadingCover(arg_20_0, arg_20_1)
	arg_20_0._displayUGUI.enabled = arg_20_1

	arg_20_0:_refreshDisplayUGUITextureRect(not arg_20_1)
end

function var_0_0.setIsNeedLoadingCover(arg_21_0, arg_21_1)
	arg_21_0._isNeedLoadingCover = arg_21_1

	if arg_21_1 and arg_21_0._displayUGUI then
		arg_21_0:_refreshLoadingCover()
	end
end

function var_0_0._refreshLoadingCover(arg_22_0)
	arg_22_0._displayUGUI.NoDefaultDisplay = false
	arg_22_0._displayUGUI.DefaultTexture = arg_22_0:getAssetItem_VideoLoadingPng()
end

return var_0_0
