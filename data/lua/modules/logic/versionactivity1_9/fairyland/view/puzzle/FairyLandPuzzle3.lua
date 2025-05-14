module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle3", package.seeall)

local var_0_0 = class("FairyLandPuzzle3", FairyLandPuzzleBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._shapeGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Shape/3")

	local var_1_0 = gohelper.findChild(arg_1_0._shapeGO, "image_shape/#go_Arrow")

	arg_1_0.tipAnim = SLFramework.AnimatorPlayer.Get(var_1_0)
	arg_1_0._shapeTrs = arg_1_0._shapeGO.transform
	arg_1_0._goImageShape = gohelper.findChild(arg_1_0._shapeGO, "image_shape")

	arg_1_0:addDrag(arg_1_0._goImageShape)
	gohelper.setActive(arg_1_0._shapeGO, true)

	arg_1_0._dragTrs = arg_1_0._goImageShape.transform

	local var_1_1, var_1_2 = recthelper.getAnchor(arg_1_0._dragTrs)

	arg_1_0.initPos = {
		x = var_1_1,
		y = var_1_2
	}
	arg_1_0.minVolume = 0
	arg_1_0.maxVolume = 100
	arg_1_0._canUseSDK = true
	arg_1_0._isUnsupportChangeVolume = nil

	if not arg_1_0:canUseSdk() then
		arg_1_0.initBGMVolume = SettingsModel.instance:getMusicValue()
	end

	arg_1_0.initVolume = arg_1_0:getVolume()

	TaskDispatcher.runDelay(arg_1_0.delaySetFlag, arg_1_0, 0.1)
end

function var_0_0.isUnsupportChangeVolume(arg_2_0)
	return arg_2_0._isUnsupportChangeVolume == nil or arg_2_0._isUnsupportChangeVolume
end

function var_0_0.delaySetFlag(arg_3_0)
	if arg_3_0:canUseSdk() then
		arg_3_0._isUnsupportChangeVolume = SDKMgr.instance:isUnsupportChangeVolume()
		arg_3_0.initVolume = arg_3_0:getVolume()
	end
end

function var_0_0.onStart(arg_4_0)
	local var_4_0 = FairyLandModel.instance:isPassPuzzle(arg_4_0.config.id)

	arg_4_0._canDrag = not var_4_0

	gohelper.setActive(arg_4_0._puzzleGO, not var_4_0)
	gohelper.setActive(arg_4_0._shapeGO, not var_4_0)

	if not var_4_0 then
		arg_4_0:playAudio()
		arg_4_0:startCheckTips()

		local var_4_1 = FairyLandModel.instance:getDialogElement(0)
		local var_4_2 = FairyLandModel.instance:getDialogElement(6)

		arg_4_0.minPosX = -720
		arg_4_0.maxPosX = arg_4_0:getElementAnchorX(var_4_2)

		TaskDispatcher.runDelay(arg_4_0.delayRunTick, arg_4_0, 0.1)
	end
end

function var_0_0.delayRunTick(arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._tick, arg_5_0, 0)
end

function var_0_0.getElementAnchorX(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return 0
	end

	return recthelper.rectToRelativeAnchorPos(arg_6_1.goChess.transform.position, arg_6_0._shapeTrs).x
end

function var_0_0.addDrag(arg_7_0, arg_7_1)
	if arg_7_0._drag then
		return
	end

	arg_7_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_7_1)

	arg_7_0._drag:AddDragBeginListener(arg_7_0._onBeginDrag, arg_7_0, arg_7_1.transform)
	arg_7_0._drag:AddDragListener(arg_7_0._onDrag, arg_7_0)
	arg_7_0._drag:AddDragEndListener(arg_7_0._onEndDrag, arg_7_0, arg_7_1.transform)
end

function var_0_0._tick(arg_8_0)
	if not arg_8_0._canDrag then
		return
	end

	if arg_8_0.inDrag then
		arg_8_0:updateVolume()
	else
		arg_8_0:updatePos()
	end

	arg_8_0:checkFinish()
end

function var_0_0.updatePos(arg_9_0)
	local var_9_0 = arg_9_0:getVolume()

	if var_9_0 == arg_9_0.volume then
		return
	end

	arg_9_0.volume = var_9_0

	local var_9_1 = arg_9_0.initPos.x
	local var_9_2 = arg_9_0.minPosX
	local var_9_3 = arg_9_0.initVolume
	local var_9_4 = 0

	if var_9_0 > arg_9_0.initVolume then
		var_9_1 = arg_9_0.maxPosX
		var_9_2 = arg_9_0.initPos.x
		var_9_3 = arg_9_0.maxVolume
		var_9_4 = arg_9_0.initVolume
	end

	local var_9_5 = (var_9_0 - var_9_4) / (var_9_3 - var_9_4) * (var_9_1 - var_9_2) + var_9_2

	arg_9_0:_tweenToPosX(arg_9_0._dragTrs, var_9_5)
end

function var_0_0.checkFinish(arg_10_0)
	local var_10_0 = not arg_10_0.notIsFirstCheck

	arg_10_0.notIsFirstCheck = true

	local var_10_1 = recthelper.getAnchorX(arg_10_0._dragTrs)

	if math.abs(var_10_1 - arg_10_0.minPosX) < 1 and not arg_10_0.inDrag then
		arg_10_0:finished(var_10_0)

		return
	end

	if arg_10_0:getVolume() == 0 and not arg_10_0.inDrag then
		arg_10_0:finished(var_10_0)
	end
end

function var_0_0.getVolume(arg_11_0)
	if arg_11_0:canUseSdk() then
		if arg_11_0:isUnsupportChangeVolume() then
			return 0
		end

		return SDKMgr.instance:getSystemMediaVolume()
	else
		return SettingsModel.instance:getEffectValue()
	end
end

function var_0_0.setVolume(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.volume == arg_12_1 and not arg_12_2 then
		return
	end

	if arg_12_0:canUseSdk() then
		if not arg_12_0:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(arg_12_1)
		end
	else
		SettingsModel.instance:setEffectValue(arg_12_1)
	end

	arg_12_0.volume = arg_12_0:getVolume()
end

function var_0_0.resetVolume(arg_13_0)
	if arg_13_0:canUseSdk() then
		if not arg_13_0:isUnsupportChangeVolume() then
			SDKMgr.instance:setSystemMediaVolume(arg_13_0.initVolume)
		end
	else
		SettingsModel.instance:setEffectValue(arg_13_0.initVolume)
		SettingsModel.instance:setMusicValue(arg_13_0.initBGMVolume)
	end
end

function var_0_0.canUseSdk(arg_14_0)
	if arg_14_0._canUseSDK then
		return true
	end

	return false
end

function var_0_0.finished(arg_15_0, arg_15_1)
	arg_15_0:stopCheckTips()

	arg_15_0._canDrag = false

	gohelper.setActive(arg_15_0._puzzleGO, false)
	gohelper.setActive(arg_15_0._shapeGO, false)
	arg_15_0:stopTask()
	arg_15_0:killTweenId()
	arg_15_0:stopAudio()

	if arg_15_1 then
		arg_15_0:playSpecialTalk()
	else
		arg_15_0:playSuccessTalk()
	end
end

function var_0_0.playSpecialTalk(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.playTipsTalk, arg_16_0)

	if not FairyLandModel.instance:isPassPuzzle(arg_16_0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(arg_16_0.config.id, arg_16_0.config.answer)
	end

	arg_16_0:playTalk(22, arg_16_0.openCompleteView, arg_16_0)
end

function var_0_0.openCompleteView(arg_17_0)
	arg_17_0:resetVolume()
	var_0_0.super.openCompleteView(arg_17_0)
end

function var_0_0.updateVolume(arg_18_0)
	local var_18_0 = recthelper.getAnchorX(arg_18_0._dragTrs)
	local var_18_1 = arg_18_0.initPos.x
	local var_18_2 = arg_18_0.minPosX
	local var_18_3 = arg_18_0.initVolume
	local var_18_4 = 0

	if var_18_0 > arg_18_0.initPos.x then
		var_18_1 = arg_18_0.maxPosX
		var_18_2 = arg_18_0.initPos.x
		var_18_3 = arg_18_0.maxVolume
		var_18_4 = arg_18_0.initVolume
	end

	local var_18_5 = (var_18_0 - var_18_2) / (var_18_1 - var_18_2)
	local var_18_6 = math.floor(var_18_5 * (var_18_3 - var_18_4) + var_18_4)

	arg_18_0:setVolume(var_18_6)

	if not arg_18_0:canUseSdk() then
		local var_18_7 = arg_18_0.initBGMVolume
		local var_18_8 = 0

		if var_18_0 > arg_18_0.initPos.x then
			var_18_7 = arg_18_0.maxVolume
			var_18_8 = arg_18_0.initBGMVolume
		end

		local var_18_9 = math.floor(var_18_5 * (var_18_7 - var_18_8) + var_18_8)

		if var_18_9 ~= arg_18_0.musicValue then
			arg_18_0.musicValue = var_18_9

			SettingsModel.instance:setMusicValue(arg_18_0.musicValue)
		end
	end
end

function var_0_0.canDrag(arg_19_0)
	return arg_19_0._canDrag
end

function var_0_0.getDragPos(arg_20_0, arg_20_1)
	return (recthelper.screenPosToAnchorPos(arg_20_1, arg_20_0._shapeTrs))
end

function var_0_0._onBeginDrag(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0:canDrag() then
		arg_21_0.inDrag = false

		return
	end

	arg_21_0:killTweenId()

	arg_21_0.inDrag = true
end

function var_0_0._onDrag(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0:canDrag() then
		arg_22_0.inDrag = false

		return
	end

	local var_22_0 = arg_22_0:getDragPos(arg_22_2.position)

	arg_22_0:_tweenToPosX(arg_22_0._dragTrs, var_22_0.x)

	arg_22_0.inDrag = true
end

function var_0_0._onEndDrag(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0:startCheckTips()

	arg_23_0.inDrag = false

	if not arg_23_0:canDrag() then
		return
	end

	arg_23_0:killTweenId()
end

function var_0_0._onDragTweenEnd(arg_24_0)
	return
end

function var_0_0._tweenToPosX(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.tweenId then
		ZProj.TweenHelper.KillById(arg_25_0.tweenId)

		arg_25_0.tweenId = nil
	end

	local var_25_0 = arg_25_0:clampPosX(arg_25_2)
	local var_25_1 = recthelper.getAnchorX(arg_25_1)

	if math.abs(var_25_1 - var_25_0) > 10 then
		arg_25_0.tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_25_1, var_25_0, 0.1, nil, nil, nil, EaseType.Linear)
	else
		recthelper.setAnchorX(arg_25_1, var_25_0)
	end
end

function var_0_0.clampPosX(arg_26_0, arg_26_1)
	return Mathf.Clamp(arg_26_1, arg_26_0.minPosX, arg_26_0.maxPosX)
end

function var_0_0.killTweenId(arg_27_0)
	if arg_27_0.tweenId then
		ZProj.TweenHelper.KillById(arg_27_0.tweenId)

		arg_27_0.tweenId = nil
	end
end

function var_0_0.playTipsAnim(arg_28_0)
	gohelper.setActive(arg_28_0.tipAnim, true)
	arg_28_0.tipAnim:Stop()

	if not arg_28_0.tipAnim.isActiveAndEnabled then
		return
	end

	arg_28_0.tipAnim:Play("open", arg_28_0.startCheckAnim, arg_28_0)
end

function var_0_0.playAudio(arg_29_0)
	if arg_29_0.playingId then
		return
	end

	arg_29_0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_soundwave_loop)
end

function var_0_0.stopAudio(arg_30_0)
	if arg_30_0.playingId then
		AudioMgr.instance:stopPlayingID(arg_30_0.playingId)

		arg_30_0.playingId = nil
	end
end

function var_0_0.stopTask(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.delaySetFlag, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.delayRunTick, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._tick, arg_31_0)
end

function var_0_0.onDestroyView(arg_32_0)
	arg_32_0:stopAudio()

	if arg_32_0._drag then
		arg_32_0._drag:RemoveDragBeginListener()
		arg_32_0._drag:RemoveDragListener()
		arg_32_0._drag:RemoveDragEndListener()
	end

	arg_32_0:resetVolume()
	arg_32_0:stopTask()
	arg_32_0:killTweenId()
	gohelper.setActive(arg_32_0._shapeGO, false)
end

return var_0_0
