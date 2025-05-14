module("modules.logic.toast.view.ToastItem", package.seeall)

local var_0_0 = class("ToastItem", LuaCompBase)
local var_0_1 = 10000
local var_0_2 = ZProj.TweenHelper

var_0_0.ToastType = {
	Achievement = 2,
	Season166 = 3,
	Normal = 1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1.transform
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "#go_normal")
	arg_1_0._txt = gohelper.findChildText(arg_1_1, "#go_normal/content/contentText")
	arg_1_0._icon = gohelper.findChildImage(arg_1_1, "#go_normal/icon")
	arg_1_0._sicon = gohelper.findChildSingleImage(arg_1_1, "#go_normal/sicon")
	arg_1_0._goachievement = gohelper.findChild(arg_1_1, "#go_achievement")
	arg_1_0._goseason166 = gohelper.findChild(arg_1_1, "#go_season166")

	if arg_1_0._txt == nil then
		arg_1_0._txt = gohelper.findChildText(arg_1_1, "bg/content/contentText")
		arg_1_0._icon = gohelper.findChildImage(arg_1_1, "icon")
		arg_1_0._sicon = gohelper.findChildSingleImage(arg_1_1, "sicon")
	end

	arg_1_0.canvasGroup = arg_1_1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._duration = 0.5
	arg_1_0._showToastDuration = 3
	arg_1_0.startAnchorPositionY = 0
end

function var_0_0.setMsg(arg_2_0, arg_2_1)
	arg_2_0.msg = arg_2_1
	arg_2_0.canvasGroup.alpha = 1
	arg_2_0._txt.text = arg_2_0:getTip()

	arg_2_0:setToastType(var_0_0.ToastType.Normal)

	if not arg_2_1.co.icon or arg_2_1.co.icon == 0 or not string.nilorempty(arg_2_1.sicon) then
		gohelper.setActive(arg_2_0._icon.gameObject, false)
	else
		gohelper.setActive(arg_2_0._icon.gameObject, true)
		UISpriteSetMgr.instance:setToastSprite(arg_2_0._icon, tostring(arg_2_1.co.icon), false)
	end

	if string.nilorempty(arg_2_1.sicon) then
		gohelper.setActive(arg_2_0._sicon.gameObject, false)
	else
		gohelper.setActive(arg_2_0._sicon.gameObject, true)
		arg_2_0._sicon:LoadImage(arg_2_1.sicon)
	end

	if arg_2_0.msg and arg_2_0.msg.callbackGroup then
		arg_2_0.msg.callbackGroup:tryOnOpen(arg_2_0)
	end

	ZProj.UGUIHelper.RebuildLayout(arg_2_0.tr)

	arg_2_0.height = recthelper.getHeight(arg_2_0.tr)
	arg_2_0.width = recthelper.getWidth(arg_2_0.tr)
end

function var_0_0._delay(arg_3_0)
	ToastController.instance:dispatchEvent(ToastEvent.RecycleToast, arg_3_0)
end

function var_0_0.appearAnimation(arg_4_0)
	if arg_4_0.msg and arg_4_0.msg.co.audioId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end

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
	if arg_10_0.msg and arg_10_0.msg.callbackGroup then
		arg_10_0.msg.callbackGroup:tryOnClose(arg_10_0)
	end

	if arg_10_0.quitAnimationDoneCallback then
		arg_10_0.quitAnimationDoneCallback(arg_10_0.callbackObj, arg_10_0)
	end

	arg_10_0.quitAnimationDoneCallback = nil
	arg_10_0.callbackObj = nil
	arg_10_0.quitTweenId = nil
end

function var_0_0.getToastItemHeight(arg_11_0)
	return arg_11_0.height
end

function var_0_0.clearAllTask(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delay, arg_12_0)
	var_0_2.KillById(arg_12_0.startTweenId or -1)
	var_0_2.KillById(arg_12_0.upTweenId or -1)
	var_0_2.KillById(arg_12_0.quitTweenId or -1)

	arg_12_0.startTweenId = nil
	arg_12_0.upTweenId = nil
	arg_12_0.quitTweenId = nil
	arg_12_0.quitAnimationDoneCallback = nil
	arg_12_0.callbackObj = nil
end

function var_0_0.setToastType(arg_13_0, arg_13_1)
	if arg_13_1 == var_0_0.ToastType.Normal then
		gohelper.setActive(arg_13_0._gonormal, true)
		gohelper.setActive(arg_13_0._goachievement, false)
		gohelper.setActive(arg_13_0._goseason166, false)
	elseif arg_13_1 == var_0_0.ToastType.Achievement then
		gohelper.setActive(arg_13_0._gonormal, false)
		gohelper.setActive(arg_13_0._goachievement, true)
		gohelper.setActive(arg_13_0._goseason166, false)
	elseif arg_13_1 == var_0_0.ToastType.Season166 then
		gohelper.setActive(arg_13_0._gonormal, false)
		gohelper.setActive(arg_13_0._goachievement, false)
		gohelper.setActive(arg_13_0._goseason166, true)
	end
end

function var_0_0.getToastRootByType(arg_14_0, arg_14_1)
	if arg_14_1 == var_0_0.ToastType.Normal then
		return arg_14_0._gonormal
	elseif arg_14_1 == var_0_0.ToastType.Achievement then
		return arg_14_0._goachievement
	elseif arg_14_1 == var_0_0.ToastType.Season166 then
		return arg_14_0._goseason166
	end
end

function var_0_0.getTip(arg_15_0)
	local var_15_0 = ""

	if arg_15_0.msg.extra and #arg_15_0.msg.extra > 0 then
		var_15_0 = GameUtil.getSubPlaceholderLuaLang(arg_15_0.msg.co.tips, arg_15_0.msg.extra)
	else
		var_15_0 = arg_15_0.msg.co.tips
	end

	return ServerTime.ReplaceUTCStr(var_15_0)
end

function var_0_0.reset(arg_16_0)
	arg_16_0.msg = nil
	arg_16_0.startAnchorPositionY = 0

	recthelper.setAnchor(arg_16_0.tr, var_0_1, var_0_1)
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0._sicon:UnLoadImage()
	arg_17_0:clearAllTask()
end

return var_0_0
