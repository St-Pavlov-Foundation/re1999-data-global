module("modules.logic.seasonver.act123.view2_0.component.Season123_2_0EntryCamera", package.seeall)

slot0 = class("Season123_2_0EntryCamera", UserDataDispose)

function slot0.init(slot0)
	slot0:__onInit()
	slot0:initCamera()
end

function slot0.dispose(slot0)
	slot0:killTween()
	slot0:__onDispose()
	MainCameraMgr.instance:addView(ViewName.Season123_2_0EntryView, nil, , )
end

function slot0.initCamera(slot0)
	if slot0._isInitCamera then
		return
	end

	slot0._isInitCamera = true
	slot0._seasonSize = SeasonEntryEnum.CameraSize
	slot0._seasonScale = 1

	MainCameraMgr.instance:addView(ViewName.Season123_2_0EntryView, slot0.onScreenResize, slot0.resetCamera, slot0)
	slot0:onScreenResize()
end

function slot0.onScreenResize(slot0)
	slot0:killTween()

	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = slot0:getCurrentOrthographicSize()
end

function slot0.setScaleWithoutTween(slot0, slot1)
	slot0._seasonScale = slot1
	CameraMgr.instance:getMainCamera().orthographicSize = slot0:getCurrentOrthographicSize()
end

function slot0.tweenToScale(slot0, slot1, slot2, slot3, slot4)
	slot0:killTween()

	slot0._seasonScale = slot1
	slot0._isScaleTweening = true
	slot0._tweenScaleId = nil

	if slot0:getCurrentOrthographicSize() <= 0 then
		slot5 = 0.1
	end

	slot6 = CameraMgr.instance:getMainCamera()
	slot7 = slot6.orthographicSize / slot5
	slot0._focusFinishCallback = slot3
	slot0._focusFinishCallbackObj = slot4
	slot0._tweenScaleId = ZProj.TweenHelper.DOTweenFloat(slot6.orthographicSize, slot5, slot2, slot0.onTweenSizeUpdate, slot0.onTweenFinish, slot0, nil, EaseType.OutCubic)
end

function slot0.killTween(slot0)
	slot0._isScaleTweening = false

	if slot0._tweenScaleId then
		ZProj.TweenHelper.KillById(slot0._tweenScaleId)

		slot0._tweenScaleId = nil
	end
end

function slot0.onTweenSizeUpdate(slot0, slot1)
	if CameraMgr.instance:getMainCamera() then
		slot2.orthographicSize = slot1
	end
end

function slot0.onTweenFinish(slot0)
	if slot0._focusFinishCallback then
		slot0._focusFinishCallback(slot0._focusFinishCallbackObj)

		slot0._focusFinishCallback = nil
		slot0._focusFinishCallbackObj = nil
	end
end

function slot0.getCurrentOrthographicSize(slot0)
	return slot0._seasonSize * GameUtil.getAdapterScale(true) * slot0._seasonScale
end

return slot0
