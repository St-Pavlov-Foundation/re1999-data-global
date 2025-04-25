module("modules.common.others.UIDragListenerHelper", package.seeall)

slot0 = class("UIDragListenerHelper", UserDataDispose)
slot1 = math.pi
slot2 = 1e-05
slot3 = math.abs
slot4 = math.sqrt
slot5 = math.acos
slot6 = 180
slot7 = ZProj.TweenHelper
slot8 = SLFramework.UGUI.UIDragListener
slot0.EventBegin = 1
slot0.EventDragging = 2
slot0.EventEnd = 3
slot9 = {
	Down = -1,
	Up = 1,
	Right = -1,
	Left = 1,
	None = 0
}

function slot10(slot0)
	return slot0 * uv0 / uv1
end

function slot11(slot0)
	return uv0 / uv1 * slot0
end

function slot12(slot0)
	return uv0(slot0) <= uv1
end

function slot13(slot0, slot1)
	return slot0.x * slot1.x + slot0.y * slot1.y
end

function slot14(slot0, slot1)
	return slot0.x * slot1.x + slot0.y * slot1.y + slot0.z * slot1.z
end

function slot15(slot0, slot1)
	return Vector3.New(slot0.y * slot1.z - slot0.z * slot1.y, slot0.z * slot1.x - slot0.x * slot1.z, slot0.x * slot1.y - slot0.y * slot1.x)
end

function slot16(slot0, slot1)
	slot3 = uv0(slot1, slot1)

	if uv1(uv0(slot0, slot0)) or uv1(slot3) then
		return 0
	end

	return uv3(uv0(slot0, slot1) / uv2(slot2 * slot3))
end

function slot17(slot0, slot1)
	slot2 = Mathf.Cos(slot1)
	slot3 = Mathf.Sin(slot1)

	return Vector2.New(slot0.x * slot2 - slot0.y * slot3, slot0.x * slot3 + slot0.y * slot2)
end

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
end

function slot0.dragInfo(slot0)
	return slot0._dragInfo
end

function slot0.transform(slot0)
	return slot0._transform
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
	slot3.delta = slot2.delta
	slot3.screenPos_st = slot3.screenPos

	slot0:_refreshSwipeDir()
	slot0:dispatchEvent(uv0.EventBegin, slot0, slot1)
end

function slot0._onDragging(slot0, slot1, slot2)
	slot3 = slot0._dragInfo
	slot3.screenPos = slot2.position
	slot3.isDragging = true
	slot3.delta = slot2.delta

	slot0:_refreshSwipeDir()
	slot0:dispatchEvent(uv0.EventDragging, slot0, slot1)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot3 = slot0._dragInfo
	slot3.screenPos = slot2.position
	slot3.delta = slot2.delta
	slot3.hasEnd = true
	slot3.isDragging = false
	slot3.screenPos_ed = slot3.screenPos

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

function slot0.isSwipeNone(slot0)
	return slot0._swipeH == uv0.None and slot0._swipeV == uv0.None
end

function slot0.isSwipeRight(slot0)
	return slot0._swipeH == uv0.Right
end

function slot0.isSwipeLeft(slot0)
	return slot0._swipeH == uv0.Left
end

function slot0.isSwipeUp(slot0)
	return slot0._swipeV == uv0.Up
end

function slot0.isSwipeDown(slot0)
	return slot0._swipeV == uv0.Down
end

function slot0.isSwipeLT(slot0)
	return slot0:isSwipeLeft() and slot0:isSwipeUp()
end

function slot0.isSwipeRT(slot0)
	return slot0:isSwipeRight() and slot0:isSwipeUp()
end

function slot0.isSwipeLB(slot0)
	return slot0:isSwipeLeft() and slot0:isSwipeDown()
end

function slot0.isSwipeRB(slot0)
	return slot0:isSwipeRight() and slot0:isSwipeDown()
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

function slot0.quaternionToMouse(slot0, slot1, slot2)
	slot2 = slot2 or recthelper.uiPosToScreenPos(slot1)
	slot3 = slot0._dragInfo
	slot4 = slot3.screenPos
	slot6 = slot4 - slot3.delta - slot2
	slot7 = slot4 - slot2
	slot11, slot12 = Quaternion.FromToRotation(Vector3.New(slot6.x, slot6.y, 0), Vector3.New(slot7.x, slot7.y, 0)):ToAngleAxis()
	slot14 = nil

	if slot12.z < 0 then
		slot14 = true
	elseif slot13 > 0 then
		slot14 = false
	end

	return slot10, slot11, slot14
end

function slot0.rotateZToMousePos(slot0, slot1, slot2)
	slot3, slot4, slot5 = slot0:quaternionToMouse(slot1, slot2)
	slot1.rotation = slot1.rotation * slot3

	return slot3, slot4, slot5
end

function slot0.rotateZToMousePosWithCenterTrans(slot0, slot1, slot2)
	slot0:rotateZToMousePos(slot1, recthelper.uiPosToScreenPos(slot2))
end

function slot0.degreesFromBeginDrag(slot0, slot1, slot2)
	if not slot0._dragInfo.screenPos_st then
		return 0
	end

	slot2 = slot2 or recthelper.uiPosToScreenPos(slot1 or slot0:transform())

	return uv0(uv1(slot3.screenPos_st - slot2, slot3.screenPos - slot2))
end

return slot0
