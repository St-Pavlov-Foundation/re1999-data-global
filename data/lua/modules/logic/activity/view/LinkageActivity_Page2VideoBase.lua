module("modules.logic.activity.view.LinkageActivity_Page2VideoBase", package.seeall)

slot0 = class("LinkageActivity_Page2VideoBase", RougeSimpleItemBase)
slot1 = UnityEngine.Rect

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)

	slot0.__videoPath = false
	slot0._uvRect = {
		w = 1,
		h = 1,
		x = 0,
		y = 0
	}
	slot0._isNeedLoadingCover = false
end

function slot0.getAssetItem_VideoLoadingPng(slot0)
	return slot0:_assetGetViewContainer():getAssetItem_VideoLoadingPng()
end

function slot0.onDestroyView(slot0)
	FrameTimerController.onDestroyViewMember(slot0, "_rewindFrameTimer")
	FrameTimerController.onDestroyViewMember(slot0, "_playFrameTimer")

	if slot0._videoPlayer then
		slot0._videoPlayer:Clear()
	end

	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0.actId(slot0)
	return slot0:_assetGetParent():actId()
end

function slot0.getLinkageActivityCO(slot0)
	return slot0:_assetGetParent():getLinkageActivityCO()
end

slot2 = 5

function slot0.createVideoPlayer(slot0, slot1)
	slot2 = slot1.transform
	slot3 = recthelper.getWidth(slot2)
	slot4 = recthelper.getHeight(slot2)
	slot0._videoPlayer, slot0._displayUGUI, slot0._videoGo = AvProMgr.instance:getVideoPlayer(slot1)

	if slot0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)) then
		slot5.enabled = false
	end

	slot6 = slot0._videoGo.transform

	if slot4 <= slot3 then
		slot8 = slot4
		slot7 = slot4 * recthelper.getWidth(slot6) / math.max(1, recthelper.getHeight(slot6))
	else
		slot7 = slot3
		slot8 = slot3 / slot9
	end

	recthelper.setSize(slot6, slot7 + uv0, slot8 + uv0)
end

function slot0.setDisplayUGUITextureRect(slot0, slot1, slot2, slot3, slot4)
	slot0._uvRect = {
		x = slot1 or 0,
		y = slot2 or 0,
		w = slot3 or 1,
		h = slot4 or 1
	}

	if slot0._displayUGUI then
		slot0:_refreshDisplayUGUITextureRect()
	end
end

function slot0._refreshDisplayUGUITextureRect(slot0, slot1)
	if slot1 then
		slot0._displayUGUI.uvRect = uv0.New(0, 0, 1, 1)
	else
		slot0._displayUGUI.uvRect = uv0.New(slot0._uvRect.x, slot0._uvRect.y, slot0._uvRect.w, slot0._uvRect.h)
	end

	slot0._displayUGUI:SetVerticesDirty()
end

function slot0.loadVideo(slot0, slot1, slot2)
	if slot0.__videoPath == slot1 then
		return
	end

	FrameTimerController.onDestroyViewMember(slot0, "_playFrameTimer")
	slot0:_loadVideo(slot1)
	FrameTimerController.onDestroyViewMember(slot0, "_rewindFrameTimer")

	if slot2 then
		slot0._videoPlayer:Play(slot0._displayUGUI, slot1, false)

		slot0._rewindFrameTimer = FrameTimerController.instance:register(function ()
			if not uv0:_canPlay() then
				return
			end

			uv0:_refreshDisplayUGUITextureRect(true)
			uv0:_rewind(true)
			FrameTimerController.onDestroyViewMember(uv0, "_rewindFrameTimer")
		end, nil, 5, 3)

		slot0._rewindFrameTimer:Start()
	end
end

function slot0._loadVideo(slot0, slot1)
	if slot0._isNeedLoadingCover then
		slot0:_refreshLoadingCover()
		slot0:_setActive_LoadingCover(true)
	end

	slot0.__videoPath = slot1

	slot0._videoPlayer:LoadMedia(slot1)
end

function slot0.play(slot0, slot1, slot2)
	assert(slot0.__videoPath, "please called 'loadVideo' first!!")

	if not slot0:_isPlaying() then
		slot0:_play(slot1, slot2)
	else
		slot0:_rewind(false)
		slot0:_play(slot1, slot2)
	end
end

function slot0.stop(slot0, slot1)
	FrameTimerController.onDestroyViewMember(slot0, "_playFrameTimer")
	FrameTimerController.onDestroyViewMember(slot0, "_rewindFrameTimer")

	if slot1 then
		AudioMgr.instance:trigger(slot1)
	end

	slot0:_rewind(true)
end

function slot0._play(slot0, slot1, slot2)
	FrameTimerController.onDestroyViewMember(slot0, "_playFrameTimer")

	if not slot0:_canPlay() then
		slot0._playFrameTimer = FrameTimerController.instance:register(function ()
			if not uv0:_canPlay() then
				return
			end

			FrameTimerController.onDestroyViewMember(uv0, "_playFrameTimer")
			uv0:_onPlay(uv1, uv2)
		end, nil, 9, 9)

		slot0._playFrameTimer:Start()
	else
		slot0:_onPlay(slot1, slot2)
	end
end

function slot0._onPlay(slot0, slot1, slot2)
	if slot0._isNeedLoadingCover then
		slot0:_setActive_LoadingCover(false)
	end

	slot0._videoPlayer:Play(slot0._displayUGUI, slot2)

	if slot1 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0._rewind(slot0, slot1)
	slot0._videoPlayer:Rewind(slot1)
end

function slot0._canPlay(slot0)
	return slot0._videoPlayer:CanPlay()
end

function slot0._isPlaying(slot0)
	return slot0._videoPlayer:IsPlaying()
end

function slot0._setActive_LoadingCover(slot0, slot1)
	slot0._displayUGUI.enabled = slot1

	slot0:_refreshDisplayUGUITextureRect(not slot1)
end

function slot0.setIsNeedLoadingCover(slot0, slot1)
	slot0._isNeedLoadingCover = slot1

	if slot1 and slot0._displayUGUI then
		slot0:_refreshLoadingCover()
	end
end

function slot0._refreshLoadingCover(slot0)
	slot0._displayUGUI.NoDefaultDisplay = false
	slot0._displayUGUI.DefaultTexture = slot0:getAssetItem_VideoLoadingPng()
end

return slot0
