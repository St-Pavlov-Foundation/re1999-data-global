module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MultiTouchController", package.seeall)

slot0 = class("VersionActivity2_4MultiTouchController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.isMobilePlayer()
	return BootNativeUtil.isMobilePlayer()
end

function slot0.addTouch(slot0, slot1)
	if not uv0.isMobilePlayer() then
		return
	end

	if slot0._touchList then
		table.insert(slot0._touchList, slot1)
	else
		logError("addTouch touchList is nil")
	end
end

function slot0.removeTouch(slot0, slot1)
	if not uv0.isMobilePlayer() then
		return
	end

	if slot0._touchList then
		for slot5, slot6 in ipairs(slot0._touchList) do
			if slot6 == slot1 then
				table.remove(slot0._touchList, slot5)

				break
			end
		end
	end
end

function slot0.startMultiTouch(slot0, slot1)
	if not uv0.isMobilePlayer() then
		return
	end

	slot0._touchList = {}
	slot0._touchCount = 5
	slot0._viewName = slot1

	TaskDispatcher.cancelTask(slot0._frameHandler, slot0)
	TaskDispatcher.runRepeat(slot0._frameHandler, slot0, 0)
end

function slot0._frameHandler(slot0)
	if not slot0._touchList then
		return
	end

	for slot6 = 1, math.min(UnityEngine.Input.touchCount, slot0._touchCount) do
		if UnityEngine.Input.GetTouch(slot6 - 1).phase == TouchPhase.Began then
			if true and not ViewHelper.instance:checkViewOnTheTop(slot0._viewName) then
				return
			end

			slot1 = false

			slot0:_checkTouch(slot8.position)
		end
	end
end

function slot0._checkTouch(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._touchList) do
		if slot6:canTouch() and uv0.isTouchOverGo(slot6.go, slot1) then
			slot6:touchDown()

			break
		end
	end
end

function slot0.isTouchOverGo(slot0, slot1)
	if not slot0 or not slot1 then
		return false
	end

	slot2 = slot0.transform
	slot4 = recthelper.getHeight(slot2)

	if recthelper.screenPosToAnchorPos(slot1, slot2).x >= -recthelper.getWidth(slot2) * slot2.pivot.x and slot5.x <= slot3 * (1 - slot6.x) and slot5.y <= slot4 * slot6.x and slot5.y >= -slot4 * (1 - slot6.x) then
		return true
	end

	return false
end

function slot0.endMultiTouch(slot0)
	if not uv0.isMobilePlayer() then
		return
	end

	TaskDispatcher.cancelTask(slot0._frameHandler, slot0)

	slot0._touchList = nil
end

slot0.instance = slot0.New()

return slot0
