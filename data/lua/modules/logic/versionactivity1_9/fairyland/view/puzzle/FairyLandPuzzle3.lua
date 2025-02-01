module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle3", package.seeall)

slot0 = class("FairyLandPuzzle3", FairyLandPuzzleBase)

function slot0.onInitView(slot0)
	slot0._shapeGO = gohelper.findChild(slot0.viewGO, "main/#go_Shape/3")
	slot0.tipAnim = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0._shapeGO, "image_shape/#go_Arrow"))
	slot0._shapeTrs = slot0._shapeGO.transform
	slot0._goImageShape = gohelper.findChild(slot0._shapeGO, "image_shape")

	slot0:addDrag(slot0._goImageShape)
	gohelper.setActive(slot0._shapeGO, true)

	slot0._dragTrs = slot0._goImageShape.transform
	slot2, slot3 = recthelper.getAnchor(slot0._dragTrs)
	slot0.initPos = {
		x = slot2,
		y = slot3
	}
	slot0.minVolume = 0
	slot0.maxVolume = 100
	slot0._canUseSDK = true
	slot0._isUnsupportChangeVolume = nil

	if not slot0:canUseSdk() then
		slot0.initBGMVolume = SettingsModel.instance:getMusicValue()
	end

	slot0.initVolume = slot0:getVolume()

	TaskDispatcher.runDelay(slot0.delaySetFlag, slot0, 0.1)
end

function slot0.isUnsupportChangeVolume(slot0)
	return slot0._isUnsupportChangeVolume == nil or slot0._isUnsupportChangeVolume
end

function slot0.delaySetFlag(slot0)
	if slot0:canUseSdk() then
		slot0._isUnsupportChangeVolume = SDKMgr.instance:isUnsupportChangeVolume()
		slot0.initVolume = slot0:getVolume()
	end
end

function slot0.onStart(slot0)
	slot1 = FairyLandModel.instance:isPassPuzzle(slot0.config.id)
	slot0._canDrag = not slot1

	gohelper.setActive(slot0._puzzleGO, not slot1)
	gohelper.setActive(slot0._shapeGO, not slot1)

	if not slot1 then
		slot0:playAudio()
		slot0:startCheckTips()

		slot2 = FairyLandModel.instance:getDialogElement(0)
		slot0.minPosX = -720
		slot0.maxPosX = slot0:getElementAnchorX(FairyLandModel.instance:getDialogElement(6))

		TaskDispatcher.runDelay(slot0.delayRunTick, slot0, 0.1)
	end
end

function slot0.delayRunTick(slot0)
	TaskDispatcher.runRepeat(slot0._tick, slot0, 0)
end

function slot0.getElementAnchorX(slot0, slot1)
	if not slot1 then
		return 0
	end

	return recthelper.rectToRelativeAnchorPos(slot1.goChess.transform.position, slot0._shapeTrs).x
end

function slot0.addDrag(slot0, slot1)
	if slot0._drag then
		return
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)
end

function slot0._tick(slot0)
	if not slot0._canDrag then
		return
	end

	if slot0.inDrag then
		slot0:updateVolume()
	else
		slot0:updatePos()
	end

	slot0:checkFinish()
end

function slot0.updatePos(slot0)
	if slot0:getVolume() == slot0.volume then
		return
	end

	slot0.volume = slot1
	slot2 = slot0.initPos.x
	slot3 = slot0.minPosX
	slot4 = slot0.initVolume
	slot5 = 0

	if slot0.initVolume < slot1 then
		slot2 = slot0.maxPosX
		slot3 = slot0.initPos.x
		slot4 = slot0.maxVolume
		slot5 = slot0.initVolume
	end

	slot0:_tweenToPosX(slot0._dragTrs, (slot1 - slot5) / (slot4 - slot5) * (slot2 - slot3) + slot3)
end

function slot0.checkFinish(slot0)
	slot0.notIsFirstCheck = true

	if math.abs(recthelper.getAnchorX(slot0._dragTrs) - slot0.minPosX) < 1 and not slot0.inDrag then
		slot0:finished(not slot0.notIsFirstCheck)

		return
	end

	if slot0:getVolume() == 0 and not slot0.inDrag then
		slot0:finished(slot1)
	end
end

function slot0.getVolume(slot0)
	if slot0:canUseSdk() then
		if slot0:isUnsupportChangeVolume() then
			return 0
		end

		return SDKMgr.instance:getSystemMediaVolume()
	else
		return SettingsModel.instance:getEffectValue()
	end
end

function slot0.setVolume(slot0, slot1, slot2)
	if slot0.volume == slot1 and not slot2 then
		return
	end

	if slot0:canUseSdk() then
		if not slot0:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(slot1)
		end
	else
		SettingsModel.instance:setEffectValue(slot1)
	end

	slot0.volume = slot0:getVolume()
end

function slot0.resetVolume(slot0)
	if slot0:canUseSdk() then
		if not slot0:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(slot0.initVolume)
		end
	else
		SettingsModel.instance:setEffectValue(slot0.initVolume)
		SettingsModel.instance:setMusicValue(slot0.initBGMVolume)
	end
end

function slot0.canUseSdk(slot0)
	if slot0._canUseSDK then
		return true
	end

	return false
end

function slot0.finished(slot0, slot1)
	slot0:stopCheckTips()

	slot0._canDrag = false

	gohelper.setActive(slot0._puzzleGO, false)
	gohelper.setActive(slot0._shapeGO, false)
	slot0:stopTask()
	slot0:killTweenId()
	slot0:stopAudio()

	if slot1 then
		slot0:playSpecialTalk()
	else
		slot0:playSuccessTalk()
	end
end

function slot0.playSpecialTalk(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsTalk, slot0)

	if not FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(slot0.config.id, slot0.config.answer)
	end

	slot0:playTalk(22, slot0.openCompleteView, slot0)
end

function slot0.openCompleteView(slot0)
	slot0:resetVolume()
	uv0.super.openCompleteView(slot0)
end

function slot0.updateVolume(slot0)
	slot2 = slot0.initPos.x
	slot3 = slot0.minPosX
	slot4 = slot0.initVolume
	slot5 = 0

	if slot0.initPos.x < recthelper.getAnchorX(slot0._dragTrs) then
		slot2 = slot0.maxPosX
		slot3 = slot0.initPos.x
		slot4 = slot0.maxVolume
		slot5 = slot0.initVolume
	end

	slot0:setVolume(math.floor((slot1 - slot3) / (slot2 - slot3) * (slot4 - slot5) + slot5))

	if not slot0:canUseSdk() then
		slot4 = slot0.initBGMVolume
		slot5 = 0

		if slot0.initPos.x < slot1 then
			slot4 = slot0.maxVolume
			slot5 = slot0.initBGMVolume
		end

		if math.floor(slot6 * (slot4 - slot5) + slot5) ~= slot0.musicValue then
			slot0.musicValue = slot7

			SettingsModel.instance:setMusicValue(slot0.musicValue)
		end
	end
end

function slot0.canDrag(slot0)
	return slot0._canDrag
end

function slot0.getDragPos(slot0, slot1)
	return recthelper.screenPosToAnchorPos(slot1, slot0._shapeTrs)
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:killTweenId()

	slot0.inDrag = true
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0:canDrag() then
		slot0.inDrag = false

		return
	end

	slot0:_tweenToPosX(slot0._dragTrs, slot0:getDragPos(slot2.position).x)

	slot0.inDrag = true
end

function slot0._onEndDrag(slot0, slot1, slot2)
	slot0:startCheckTips()

	slot0.inDrag = false

	if not slot0:canDrag() then
		return
	end

	slot0:killTweenId()
end

function slot0._onDragTweenEnd(slot0)
end

function slot0._tweenToPosX(slot0, slot1, slot2)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if math.abs(recthelper.getAnchorX(slot1) - slot0:clampPosX(slot2)) > 10 then
		slot0.tweenId = ZProj.TweenHelper.DOAnchorPosX(slot1, slot3, 0.1, nil, , , EaseType.Linear)
	else
		recthelper.setAnchorX(slot1, slot3)
	end
end

function slot0.clampPosX(slot0, slot1)
	return Mathf.Clamp(slot1, slot0.minPosX, slot0.maxPosX)
end

function slot0.killTweenId(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end
end

function slot0.playTipsAnim(slot0)
	gohelper.setActive(slot0.tipAnim, true)
	slot0.tipAnim:Stop()

	if not slot0.tipAnim.isActiveAndEnabled then
		return
	end

	slot0.tipAnim:Play("open", slot0.startCheckAnim, slot0)
end

function slot0.playAudio(slot0)
	if slot0.playingId then
		return
	end

	slot0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_soundwave_loop)
end

function slot0.stopAudio(slot0)
	if slot0.playingId then
		AudioMgr.instance:stopPlayingID(slot0.playingId)

		slot0.playingId = nil
	end
end

function slot0.stopTask(slot0)
	TaskDispatcher.cancelTask(slot0.delaySetFlag, slot0)
	TaskDispatcher.cancelTask(slot0.delayRunTick, slot0)
	TaskDispatcher.cancelTask(slot0._tick, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:stopAudio()

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragListener()
		slot0._drag:RemoveDragEndListener()
	end

	slot0:resetVolume()
	slot0:stopTask()
	slot0:killTweenId()
	gohelper.setActive(slot0._shapeGO, false)
end

return slot0
