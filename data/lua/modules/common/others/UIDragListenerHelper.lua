module("modules.common.others.UIDragListenerHelper", package.seeall)

slot0 = class("UIDragListenerHelper", UserDataDispose)
slot1 = ZProj.TweenHelper
slot2 = SLFramework.UGUI.UIDragListener
slot0.EventBegin = 1
slot0.EventDragging = 2
slot0.EventEnd = 3
slot3 = {
	Down = -1,
	Up = 1,
	Right = -1,
	Left = 1,
	None = 0
}

function slot0.ctor(slot0)
	slot0:__onInit()
	LuaEventSystem.addEventMechanism(slot0)

	slot0._dragInfo = {
		delta = {
			x = 0,
			y = 0
		}
	}
	slot0._swipeH = uv0.None
	slot0._swipeV = uv0.None

	slot0:clear()
end

function slot0.onDestroyView(slot0)
	slot0:release()
	slot0:__onDispose()
end

function slot0.create(slot0, slot1, slot2)
	slot0:release()

	slot0._transform = slot1.transform
	slot0._csDragObj = uv0.Get(slot1)

	slot0._csDragObj:AddDragBeginListener(slot0._onDragBegin, slot0, slot2)
	slot0._csDragObj:AddDragListener(slot0._onDragging, slot0, slot2)
	slot0._csDragObj:AddDragEndListener(slot0._onDragEnd, slot0, slot2)
end

function slot0.createByScrollRect(slot0, slot1, slot2)
	slot0:create(slot1.gameObject, slot2)

	slot0._scrollRectCmp = slot1
end

function slot0.release(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId_DOAnchorPos")
	slot0:unregisterAllCallback(uv0.EventBegin)
	slot0:unregisterAllCallback(uv0.EventDragging)
	slot0:unregisterAllCallback(uv0.EventEnd)

	if slot0._csDragObj then
		slot0._csDragObj:RemoveDragBeginListener()
		slot0._csDragObj:RemoveDragListener()
		slot0._csDragObj:RemoveDragEndListener()
	end

	slot0._csDragObj = nil
	slot0._scrollRectCmp = nil
end

function slot0.clear(slot0)
	slot1 = slot0._dragInfo
	slot1.hasBegin = false
	slot1.isDragging = false
	slot1.hasEnd = false
	slot1.delta.x = 0
	slot1.delta.y = 0
end

function slot0._refreshSwipeDir(slot0)
	slot1 = slot0._dragInfo
	slot3 = slot1.delta.y

	if slot1.delta.x > 0 then
		slot0._swipeH = uv0.Right
	elseif slot2 < 0 then
		slot0._swipeH = uv0.Left
	else
		slot0._swipeH = uv0.None
	end

	if slot3 < 0 then
		slot0._swipeV = uv0.Down
	elseif slot3 > 0 then
		slot0._swipeV = uv0.Up
	else
		slot0._swipeV = uv0.None
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0:clear()

	slot3 = slot0._dragInfo
	slot3.screenPos = slot2.position
	slot3.hasBegin = true
	slot3.isDragging = true
	slot3.delta.x = slot2.delta.x
	slot3.delta.y = slot2.delta.y

	slot0:_refreshSwipeDir()
	slot0:dispatchEvent(uv0.EventBegin, slot0, slot1)
end

function slot0._onDragging(slot0, slot1, slot2)
	slot3 = slot0._dragInfo
	slot3.screenPos = slot2.position
	slot3.isDragging = true
	slot3.delta.x = slot2.delta.x
	slot3.delta.y = slot2.delta.y

	slot0:_refreshSwipeDir()
	slot0:dispatchEvent(uv0.EventDragging, slot0, slot1)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot3 = slot0._dragInfo
	slot3.screenPos = slot2.position
	slot3.hasEnd = true
	slot3.isDragging = false

	slot0:dispatchEvent(uv0.EventEnd, slot0, slot1)
end

function slot0.isStoped(slot0)
	return slot0._dragInfo.hasEnd == true or slot1.hasEnd == false and slot1.hasBegin == false and slot1.isDragging == false
end

function slot0.isEndedDrag(slot0)
	return slot0._dragInfo.hasEnd
end

function slot0.isDragging(slot0)
	return slot0._dragInfo.isDragging
end

function slot0.isSwipeRight(slot0)
	return slot0._swipeH == uv0.Right
end

function slot0.isSwipeLeft(slot0)
	return slot0._swipeH == uv0.Left
end

function slot0.isSwipeNone(slot0)
	return slot0._swipeH == uv0.None and slot0._swipeV == uv0.None
end

function slot0.isSwipeUp(slot0)
	return slot0._swipeV == uv0.Up
end

function slot0.isSwipeDown(slot0)
	return slot0._swipeV == uv0.Down
end

function slot0.stopMovement(slot0)
	slot0._scrollRectCmp:StopMovement()
	slot0:clear()

	slot0._swipeH = uv0.None
	slot0._swipeV = uv0.None
end

function slot0.isMoveVerticalMajor(slot0)
	if slot0:isSwipeNone() then
		return false
	end

	slot1 = slot0._dragInfo

	return math.abs(slot1.delta.x) < math.abs(slot1.delta.y)
end

function slot0.isMoveHorizontalMajor(slot0)
	if slot0:isSwipeNone() then
		return false
	end

	slot1 = slot0._dragInfo

	return math.abs(slot1.delta.y) < math.abs(slot1.delta.x)
end

function slot0.tweenToAnchorPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1 = slot1 or slot0._transform
	slot6, slot7 = recthelper.getAnchor(slot1)

	uv0.KillByObj(slot1)

	if math.abs(slot6 - slot2.x) > 10 or math.abs(slot7 - slot2.y) > 10 then
		GameUtil.onDestroyViewMember_TweenId(slot0, "_tweenId_DOAnchorPos")

		slot0._tweenId_DOAnchorPos = uv0.DOAnchorPos(slot1, slot2.x, slot2.y, slot3 or 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)
	end
end

function slot0.tweenToScreenPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot1 = slot1 or slot0._transform

	slot0:tweenToAnchorPos(slot1, recthelper.screenPosToAnchorPos(slot2 or slot0._dragInfo.screenPos, slot1.parent), slot3, slot4, slot5)
end

function slot4(slot0, slot1)
	return slot0.x * slot1.x + slot0.y * slot1.y
end

function slot0.tweenToMousePos(slot0)
	slot0:tweenToScreenPos(slot0._transform, slot0._dragInfo.screenPos)
end

function slot0.tweenToMousePosWithConstrainedDirV2(slot0, slot1, slot2)
	assert(tonumber(slot1.x) ~= nil and tonumber(slot1.y) ~= nil)

	slot3 = slot0._transform
	slot5 = recthelper.screenPosToAnchorPos(slot0._dragInfo.screenPos, slot3.parent)
	slot6, slot7 = recthelper.getAnchor(slot3)
	slot8 = Vector2.New(slot6, slot7)
	slot10 = uv0(slot5 - slot8, slot1)
	slot5.x = slot8.x + slot1.x * slot10
	slot5.y = slot8.y + slot1.y * slot10

	if slot2 then
		slot5 = Vector2.MoveTowards(slot8, slot5, Vector2.Distance(recthelper.rectToRelativeAnchorPos(slot2.position, slot3.parent), slot8))
	end

	slot0:tweenToAnchorPos(slot3, slot5)
end

function slot0.dragInfo(slot0)
	return slot0._dragInfo
end

function slot0.transform(slot0)
	return slot0._transform
end

return slot0
