module("modules.logic.story.view.StoryDialogSlideItem", package.seeall)

slot0 = class("StoryDialogSlideItem")

function slot0.init(slot0, slot1)
	slot2 = ViewMgr.instance:getContainer(ViewName.StoryView)
	slot0._dialogGo = slot2:getResInst(slot2:getSetting().otherRes[3], slot1)
	slot0._simagedialog = gohelper.findChildSingleImage(slot0._dialogGo, "#simage_dialog")
	slot0._imagedialog = gohelper.findChildImage(slot0._dialogGo, "#simage_dialog")
end

function slot0.clearSlideDialog(slot0)
	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0.startShowDialog(slot0, slot1, slot2, slot3)
	slot0._speed = slot1.speed
	slot0._showTime = slot1.showTime
	slot0._callback = slot2
	slot0._callbackObj = slot3

	gohelper.setActive(slot0._dialogGo, true)
	slot0._simagedialog:LoadImage(ResUrl.getStoryLangPath(slot1.img), slot0._imgLoaded, slot0)
end

function slot0.hideDialog(slot0)
	gohelper.setActive(slot0._dialogGo, false)
	slot0._simagedialog:UnLoadImage()
end

function slot0._imgLoaded(slot0)
	gohelper.setActive(slot0._imagedialog.gameObject, false)
	TaskDispatcher.runDelay(function ()
		gohelper.setActive(uv0._imagedialog.gameObject, true)
		uv0._imagedialog:SetNativeSize()
		uv0:_startMove()
	end, nil, 0.05)
end

function slot0._moveUpdate(slot0, slot1)
	slot2, slot3 = transformhelper.getLocalPos(slot0._simagedialog.transform)

	transformhelper.setLocalPosXY(slot0._simagedialog.transform, slot1, slot3)
end

function slot0._startMove(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot1 = recthelper.getWidth(slot0._simagedialog.transform)
	slot2 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot3 = 0.5 * (slot2 + slot1)
	slot4 = slot0._showTime
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot3, slot3 - 0.2 * (slot2 + slot1) * slot0._speed * slot4, slot4, slot0._moveUpdate, slot0._moveDone, slot0, nil, EaseType.Linear)
end

function slot0._moveDone(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end

	TaskDispatcher.runDelay(slot0._startMove, slot0, 3)
end

function slot0.destroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._startMove, slot0)
	slot0._simagedialog:UnLoadImage()
end

return slot0
