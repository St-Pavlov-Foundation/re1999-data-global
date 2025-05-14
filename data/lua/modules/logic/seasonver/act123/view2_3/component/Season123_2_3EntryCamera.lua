module("modules.logic.seasonver.act123.view2_3.component.Season123_2_3EntryCamera", package.seeall)

local var_0_0 = class("Season123_2_3EntryCamera", UserDataDispose)

function var_0_0.init(arg_1_0)
	arg_1_0:__onInit()
	arg_1_0:initCamera()
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:killTween()
	arg_2_0:__onDispose()
	MainCameraMgr.instance:addView(ViewName.Season123_2_3EntryView, nil, nil, nil)
end

function var_0_0.initCamera(arg_3_0)
	if arg_3_0._isInitCamera then
		return
	end

	arg_3_0._isInitCamera = true
	arg_3_0._seasonSize = SeasonEntryEnum.CameraSize
	arg_3_0._seasonScale = 1

	MainCameraMgr.instance:addView(ViewName.Season123_2_3EntryView, arg_3_0.onScreenResize, arg_3_0.resetCamera, arg_3_0)
	arg_3_0:onScreenResize()
end

function var_0_0.onScreenResize(arg_4_0)
	arg_4_0:killTween()

	local var_4_0 = CameraMgr.instance:getMainCamera()

	var_4_0.orthographic = true
	var_4_0.orthographicSize = arg_4_0:getCurrentOrthographicSize()
end

function var_0_0.setScaleWithoutTween(arg_5_0, arg_5_1)
	local var_5_0 = CameraMgr.instance:getMainCamera()

	arg_5_0._seasonScale = arg_5_1
	var_5_0.orthographicSize = arg_5_0:getCurrentOrthographicSize()
end

function var_0_0.tweenToScale(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0:killTween()

	arg_6_0._seasonScale = arg_6_1
	arg_6_0._isScaleTweening = true
	arg_6_0._tweenScaleId = nil

	local var_6_0 = arg_6_0:getCurrentOrthographicSize()

	if var_6_0 <= 0 then
		var_6_0 = 0.1
	end

	local var_6_1 = CameraMgr.instance:getMainCamera()
	local var_6_2 = var_6_1.orthographicSize / var_6_0

	arg_6_0._focusFinishCallback = arg_6_3
	arg_6_0._focusFinishCallbackObj = arg_6_4
	arg_6_0._tweenScaleId = ZProj.TweenHelper.DOTweenFloat(var_6_1.orthographicSize, var_6_0, arg_6_2, arg_6_0.onTweenSizeUpdate, arg_6_0.onTweenFinish, arg_6_0, nil, EaseType.OutCubic)
end

function var_0_0.killTween(arg_7_0)
	arg_7_0._isScaleTweening = false

	if arg_7_0._tweenScaleId then
		ZProj.TweenHelper.KillById(arg_7_0._tweenScaleId)

		arg_7_0._tweenScaleId = nil
	end
end

function var_0_0.onTweenSizeUpdate(arg_8_0, arg_8_1)
	local var_8_0 = CameraMgr.instance:getMainCamera()

	if var_8_0 then
		var_8_0.orthographicSize = arg_8_1
	end
end

function var_0_0.onTweenFinish(arg_9_0)
	if arg_9_0._focusFinishCallback then
		arg_9_0._focusFinishCallback(arg_9_0._focusFinishCallbackObj)

		arg_9_0._focusFinishCallback = nil
		arg_9_0._focusFinishCallbackObj = nil
	end
end

function var_0_0.getCurrentOrthographicSize(arg_10_0)
	local var_10_0 = GameUtil.getAdapterScale(true)

	return arg_10_0._seasonSize * var_10_0 * arg_10_0._seasonScale
end

return var_0_0
