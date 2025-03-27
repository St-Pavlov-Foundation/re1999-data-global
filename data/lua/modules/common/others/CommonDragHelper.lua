module("modules.common.others.CommonDragHelper", package.seeall)

slot0 = class("CommonDragHelper")

function slot0.ctor(slot0)
	slot0._list = {}
	slot0._nowDragData = nil
	slot0.enabled = true
end

function slot0.registerDragObj(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11)
	if not slot1 or gohelper.isNil(slot1) then
		logError("go can not be nil")

		return
	end

	if slot0:getDragData(slot1) then
		logWarn("repeat register")
		slot0:unregisterDragObj(slot1)
	end

	slot12 = {}
	slot13 = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot13:AddDragBeginListener(slot0._onBeginDrag, slot0, slot12)
	slot13:AddDragListener(slot0._onDrag, slot0, slot12)
	slot13:AddDragEndListener(slot0._onEndDrag, slot0, slot12)

	slot12.go = slot1
	slot12.transform = slot1.transform
	slot12.parent = slot1.transform.parent
	slot12.beginCallBack = slot2
	slot12.dragCallBack = slot3
	slot12.endCallBack = slot4
	slot12.checkCallBack = slot5
	slot12.callObj = slot6
	slot12.drag = slot13
	slot12.params = slot7
	slot12.enabled = true
	slot12.isNoMove = slot8
	slot12.moveOffset = slot9
	slot12.dragScale = slot10 or 1
	slot12.dragDefaultScale = slot11 or 1

	table.insert(slot0._list, slot12)
end

function slot0.setCallBack(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not slot0:getDragData(slot1) then
		return
	end

	slot8.beginCallBack = slot2
	slot8.dragCallBack = slot3
	slot8.endCallBack = slot4
	slot8.checkCallBack = slot5
	slot8.callObj = slot6
	slot8.params = slot7
end

function slot0.refreshParent(slot0, slot1)
	if not slot0:getDragData(slot1) then
		return
	end

	slot2.parent = slot2.transform.parent

	ZProj.TweenHelper.KillByObj(slot2.transform)
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot1.enabled or not slot0.enabled then
		return
	end

	if slot1.checkCallBack and slot1.checkCallBack(slot1.callObj, slot1.params) then
		return
	end

	if slot0._nowDragData then
		return
	end

	slot0._nowDragData = slot1

	if not slot1.isNoMove then
		slot0:_tweenToPos(slot1, slot2.position)
		gohelper.setAsLastSibling(slot1.go)
	end

	if slot1.dragScale ~= slot1.dragDefaultScale then
		ZProj.TweenHelper.KillByObj(slot1.transform)
		ZProj.TweenHelper.DOScale(slot1.transform, slot1.dragScale, slot1.dragScale, slot1.dragScale, 0.16)
	end

	if slot1.beginCallBack then
		slot1.beginCallBack(slot1.callObj, slot1.params, slot2)
	end
end

function slot0._tweenToPos(slot0, slot1, slot2)
	if slot1.moveOffset then
		slot2 = slot2 + slot1.moveOffset
	end

	slot5, slot6 = recthelper.getAnchor(slot1.transform)

	if math.abs(slot5 - recthelper.screenPosToAnchorPos(slot2, slot1.parent).x) > 10 or math.abs(slot6 - slot3.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(slot4, slot3.x, slot3.y, 0.2)
	else
		recthelper.setAnchor(slot4, slot3.x, slot3.y)
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0._nowDragData ~= slot1 then
		return
	end

	if not slot1.isNoMove then
		slot0:_tweenToPos(slot1, slot2.position)
	end

	if slot1.dragCallBack then
		slot1.dragCallBack(slot1.callObj, slot1.params, slot2)
	end
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if slot0._nowDragData ~= slot1 then
		return
	end

	if slot1.dragScale ~= slot1.dragDefaultScale then
		ZProj.TweenHelper.DOScale(slot1.transform, slot1.dragDefaultScale, slot1.dragDefaultScale, slot1.dragDefaultScale, 0.16)
	end

	if slot1.endCallBack then
		slot1.endCallBack(slot1.callObj, slot1.params, slot2)
	end

	slot0._nowDragData = nil
end

function slot0.setDragEnabled(slot0, slot1, slot2)
	if not slot0:getDragData(slot1) then
		return
	end

	slot3.enabled = slot2

	if not slot2 and slot0._nowDragData == slot3 then
		slot0:stopDrag(slot1)
	end
end

function slot0.setGlobalEnabled(slot0, slot1)
	slot0.enabled = slot1

	if not slot1 and slot0._nowDragData then
		slot0:stopDrag(slot0._nowDragData.go)
	end
end

function slot0.getDragData(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._list) do
		if slot6.go == slot1 then
			return slot6, slot5
		end
	end
end

function slot0.stopDrag(slot0, slot1, slot2)
	if slot0._nowDragData and slot0._nowDragData.go == slot1 then
		if slot2 then
			slot0._nowDragData.endCallBack(slot0._nowDragData.callObj, slot0._nowDragData.params, GamepadController.instance:getMousePosition())
		end

		slot0._nowDragData = nil
	end
end

function slot0.unregisterDragObj(slot0, slot1)
	slot2, slot3 = slot0:getDragData(slot1)

	if not slot2 then
		return
	end

	if not gohelper.isNil(slot2.drag) then
		slot4:RemoveDragListener()
		slot4:RemoveDragBeginListener()
		slot4:RemoveDragEndListener()
	end

	table.remove(slot0._list, slot3)

	if slot0._nowDragData == slot2 then
		slot0._nowDragData = nil
	end
end

function slot0.clear(slot0)
	for slot4, slot5 in ipairs(slot0._list) do
		if not gohelper.isNil(slot5.drag) then
			slot6:RemoveDragListener()
			slot6:RemoveDragBeginListener()
			slot6:RemoveDragEndListener()
		end
	end

	slot0._list = {}
	slot0._nowDragData = nil
end

slot0.instance = slot0.New()

return slot0
