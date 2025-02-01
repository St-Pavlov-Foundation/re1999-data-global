module("modules.logic.toast.view.ToastItem", package.seeall)

slot0 = class("ToastItem", LuaCompBase)
slot1 = 10000
slot2 = ZProj.TweenHelper
slot0.ToastType = {
	Achievement = 2,
	Season166 = 3,
	Normal = 1
}

function slot0.init(slot0, slot1)
	slot0.tr = slot1.transform
	slot0._gonormal = gohelper.findChild(slot1, "#go_normal")
	slot0._txt = gohelper.findChildText(slot1, "#go_normal/content/contentText")
	slot0._icon = gohelper.findChildImage(slot1, "#go_normal/icon")
	slot0._sicon = gohelper.findChildSingleImage(slot1, "#go_normal/sicon")
	slot0._goachievement = gohelper.findChild(slot1, "#go_achievement")
	slot0._goseason166 = gohelper.findChild(slot1, "#go_season166")

	if slot0._txt == nil then
		slot0._txt = gohelper.findChildText(slot1, "bg/content/contentText")
		slot0._icon = gohelper.findChildImage(slot1, "icon")
		slot0._sicon = gohelper.findChildSingleImage(slot1, "sicon")
	end

	slot0.canvasGroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._duration = 0.5
	slot0._showToastDuration = 3
	slot0.startAnchorPositionY = 0
end

function slot0.setMsg(slot0, slot1)
	slot0.msg = slot1
	slot0.canvasGroup.alpha = 1
	slot0._txt.text = slot0:getTip()

	slot0:setToastType(uv0.ToastType.Normal)

	if not slot1.co.icon or slot1.co.icon == 0 or not string.nilorempty(slot1.sicon) then
		gohelper.setActive(slot0._icon.gameObject, false)
	else
		gohelper.setActive(slot0._icon.gameObject, true)
		UISpriteSetMgr.instance:setToastSprite(slot0._icon, tostring(slot1.co.icon), false)
	end

	if string.nilorempty(slot1.sicon) then
		gohelper.setActive(slot0._sicon.gameObject, false)
	else
		gohelper.setActive(slot0._sicon.gameObject, true)
		slot0._sicon:LoadImage(slot1.sicon)
	end

	if slot0.msg and slot0.msg.callbackGroup then
		slot0.msg.callbackGroup:tryOnOpen(slot0)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0.tr)

	slot0.height = recthelper.getHeight(slot0.tr)
	slot0.width = recthelper.getWidth(slot0.tr)
end

function slot0._delay(slot0)
	ToastController.instance:dispatchEvent(ToastEvent.RecycleToast, slot0)
end

function slot0.appearAnimation(slot0)
	if slot0.msg and slot0.msg.co.audioId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_no_requirement)
	end

	recthelper.setAnchorX(slot0.tr, slot0.width)
	uv0.KillById(slot0.startTweenId or -1)

	slot0.startTweenId = uv0.DOAnchorPosX(slot0.tr, 0, slot0._duration, function ()
		uv0.startTweenId = nil

		TaskDispatcher.runDelay(uv0._delay, uv0, uv0._showToastDuration)
	end)
end

function slot0.upAnimation(slot0, slot1)
	uv0.KillById(slot0.upTweenId or -1)

	slot0.upTweenId = uv0.DOAnchorPosY(slot0.tr, slot1, slot0._duration, function ()
		uv0.upTweenId = nil
	end)
end

function slot0.quitAnimation(slot0, slot1, slot2)
	uv0.KillById(slot0.quitTweenId or -1)

	slot0.quitAnimationDoneCallback = slot1
	slot0.callbackObj = slot2
	slot0.startAnchorPositionY = slot0.tr.anchoredPosition.y
	slot0.quitTweenId = uv0.DOTweenFloat(1, 0, slot0._duration, slot0.quitAnimationFrame, slot0.quitAnimationDone, slot0)
end

function slot0.quitAnimationFrame(slot0, slot1)
	recthelper.setAnchorY(slot0.tr, slot0.startAnchorPositionY + (1 - slot1) * slot0.height)

	slot0.canvasGroup.alpha = slot1
end

function slot0.quitAnimationDone(slot0)
	if slot0.msg and slot0.msg.callbackGroup then
		slot0.msg.callbackGroup:tryOnClose(slot0)
	end

	if slot0.quitAnimationDoneCallback then
		slot0.quitAnimationDoneCallback(slot0.callbackObj, slot0)
	end

	slot0.quitAnimationDoneCallback = nil
	slot0.callbackObj = nil
	slot0.quitTweenId = nil
end

function slot0.getToastItemHeight(slot0)
	return slot0.height
end

function slot0.clearAllTask(slot0)
	TaskDispatcher.cancelTask(slot0._delay, slot0)
	uv0.KillById(slot0.startTweenId or -1)
	uv0.KillById(slot0.upTweenId or -1)
	uv0.KillById(slot0.quitTweenId or -1)

	slot0.startTweenId = nil
	slot0.upTweenId = nil
	slot0.quitTweenId = nil
	slot0.quitAnimationDoneCallback = nil
	slot0.callbackObj = nil
end

function slot0.setToastType(slot0, slot1)
	if slot1 == uv0.ToastType.Normal then
		gohelper.setActive(slot0._gonormal, true)
		gohelper.setActive(slot0._goachievement, false)
		gohelper.setActive(slot0._goseason166, false)
	elseif slot1 == uv0.ToastType.Achievement then
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._goachievement, true)
		gohelper.setActive(slot0._goseason166, false)
	elseif slot1 == uv0.ToastType.Season166 then
		gohelper.setActive(slot0._gonormal, false)
		gohelper.setActive(slot0._goachievement, false)
		gohelper.setActive(slot0._goseason166, true)
	end
end

function slot0.getToastRootByType(slot0, slot1)
	if slot1 == uv0.ToastType.Normal then
		return slot0._gonormal
	elseif slot1 == uv0.ToastType.Achievement then
		return slot0._goachievement
	elseif slot1 == uv0.ToastType.Season166 then
		return slot0._goseason166
	end
end

function slot0.getTip(slot0)
	slot1 = ""

	return ServerTime.ReplaceUTCStr((not slot0.msg.extra or #slot0.msg.extra <= 0 or GameUtil.getSubPlaceholderLuaLang(slot0.msg.co.tips, slot0.msg.extra)) and slot0.msg.co.tips)
end

function slot0.reset(slot0)
	slot0.msg = nil
	slot0.startAnchorPositionY = 0

	recthelper.setAnchor(slot0.tr, uv0, uv0)
end

function slot0.onDestroy(slot0)
	slot0._sicon:UnLoadImage()
	slot0:clearAllTask()
end

return slot0
