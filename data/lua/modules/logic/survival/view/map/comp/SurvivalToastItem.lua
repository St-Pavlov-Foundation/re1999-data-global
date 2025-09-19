module("modules.logic.survival.view.map.comp.SurvivalToastItem", package.seeall)

local var_0_0 = class("SurvivalToastItem", LuaCompBase)
local var_0_1 = 10000
local var_0_2 = ZProj.TweenHelper

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.width = 0
	arg_1_0.height = 0
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._txt = gohelper.findChildText(arg_1_1, "#txt_desc")
	arg_1_0.canvasGroup = arg_1_1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._duration = 0.3
	arg_1_0._showToastDuration = 1
	arg_1_0.startAnchorPositionY = 0
end

function var_0_0.setMsg(arg_2_0, arg_2_1)
	arg_2_0.canvasGroup.alpha = 1
	arg_2_0._txt.text = arg_2_1

	ZProj.UGUIHelper.RebuildLayout(arg_2_0.tr)

	arg_2_0.width = recthelper.getWidth(arg_2_0.tr)
	arg_2_0.height = recthelper.getHeight(arg_2_0.tr)
end

function var_0_0._delay(arg_3_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.RecycleToast, arg_3_0)
end

function var_0_0.appearAnimation(arg_4_0)
	recthelper.setAnchorX(arg_4_0.tr, arg_4_0.width)
	var_0_2.KillById(arg_4_0.startTweenId or -1)

	arg_4_0.startTweenId = var_0_2.DOAnchorPosX(arg_4_0.tr, 0, arg_4_0._duration, function()
		arg_4_0.startTweenId = nil

		TaskDispatcher.runDelay(arg_4_0._delay, arg_4_0, arg_4_0._showToastDuration)
	end)
end

function var_0_0.upAnimation(arg_6_0, arg_6_1)
	var_0_2.KillById(arg_6_0.upTweenId or -1)

	arg_6_0.upTweenId = var_0_2.DOAnchorPosY(arg_6_0.tr, arg_6_1, arg_6_0._duration, function()
		arg_6_0.upTweenId = nil
	end)
end

function var_0_0.quitAnimation(arg_8_0, arg_8_1, arg_8_2)
	var_0_2.KillById(arg_8_0.quitTweenId or -1)

	arg_8_0.quitAnimationDoneCallback = arg_8_1
	arg_8_0.callbackObj = arg_8_2
	arg_8_0.startAnchorPositionY = arg_8_0.tr.anchoredPosition.y
	arg_8_0.quitTweenId = var_0_2.DOTweenFloat(1, 0, arg_8_0._duration, arg_8_0.quitAnimationFrame, arg_8_0.quitAnimationDone, arg_8_0)
end

function var_0_0.quitAnimationFrame(arg_9_0, arg_9_1)
	local var_9_0 = (1 - arg_9_1) * arg_9_0.height

	recthelper.setAnchorY(arg_9_0.tr, arg_9_0.startAnchorPositionY + var_9_0)

	arg_9_0.canvasGroup.alpha = arg_9_1
end

function var_0_0.quitAnimationDone(arg_10_0)
	if arg_10_0.quitAnimationDoneCallback then
		arg_10_0.quitAnimationDoneCallback(arg_10_0.callbackObj, arg_10_0)
	end

	arg_10_0.quitAnimationDoneCallback = nil
	arg_10_0.callbackObj = nil
	arg_10_0.quitTweenId = nil
end

function var_0_0.clearAllTask(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._delay, arg_11_0)
	var_0_2.KillById(arg_11_0.startTweenId or -1)
	var_0_2.KillById(arg_11_0.upTweenId or -1)
	var_0_2.KillById(arg_11_0.quitTweenId or -1)

	arg_11_0.startTweenId = nil
	arg_11_0.upTweenId = nil
	arg_11_0.quitTweenId = nil
	arg_11_0.quitAnimationDoneCallback = nil
	arg_11_0.callbackObj = nil
end

function var_0_0.reset(arg_12_0)
	arg_12_0.startAnchorPositionY = 0

	recthelper.setAnchor(arg_12_0.tr, var_0_1, var_0_1)
end

function var_0_0.getHeight(arg_13_0)
	return arg_13_0.height
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0:clearAllTask()
end

return var_0_0
