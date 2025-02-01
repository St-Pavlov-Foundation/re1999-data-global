module("modules.logic.dungeon.view.DungeonViewAudio", package.seeall)

slot0 = class("DungeonViewAudio", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollchapter = gohelper.findChildScrollRect(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	slot0._scrollchapterresource = gohelper.findChildScrollRect(slot0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollchapter.gameObject)

	slot0:initScrollDragListener(slot0._drag, slot0._scrollchapter)

	slot0._dragResource = SLFramework.UGUI.UIDragListener.Get(slot0._scrollchapterresource.gameObject)

	slot0:initScrollDragListener(slot0._dragResource, slot0._scrollchapterresource)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapterList, slot0._onChangeChapterList, slot0)
end

function slot0._onChangeChapterList(slot0)
	if slot0._curScroll then
		slot0._curScroll:RemoveOnValueChanged()

		slot0._curScroll = nil
	end
end

function slot0.initScrollDragListener(slot0, slot1, slot2)
	slot1:AddDragBeginListener(slot0._onDragBegin, slot0, slot2)
	slot1:AddDragListener(slot0._onDrag, slot0, slot2)
	slot1:AddDragEndListener(slot0._onDragEnd, slot0, slot2)
end

function slot0.addScrollChangeCallback(slot0, slot1, slot2)
	slot0._scrollChangeCallback = slot1
	slot0._scrollChangeCallbackTarget = slot2
end

function slot0._onScrollValueChanged(slot0, slot1, slot2)
	if slot0._scrollChangeCallback then
		slot0._scrollChangeCallback(slot0._scrollChangeCallbackTarget)
	end

	slot3 = slot0._curScroll.horizontalNormalizedPosition

	if slot0._curNormalizedPos and slot3 >= 0 and slot3 <= 1 and slot0._cellCenterPos <= math.abs(slot3 - slot0._curNormalizedPos) then
		if slot4 > 0 then
			slot0._curNormalizedPos = slot0._curNormalizedPos + slot0._cellCenterPos
		else
			slot0._curNormalizedPos = slot0._curNormalizedPos - slot0._cellCenterPos
		end

		slot0._curNormalizedPos = slot3

		DungeonAudio.instance:cardPass()
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._beginDragScrollNormalizePos = slot1.horizontalNormalizedPosition
	slot0._beginDrag = true

	slot0:initNormalizePos(slot1)
end

function slot0.initNormalizePos(slot0, slot1)
	slot2 = recthelper.getWidth(slot1.content)
	slot3 = recthelper.getWidth(slot1.transform)

	if slot1.content.childCount == 0 then
		return
	end

	if slot2 - slot3 > 0 then
		slot0._cellCenterPos = 1 / (slot8 / recthelper.getWidth(slot4:GetChild(slot5 - 1))) / 2
		slot0._curNormalizedPos = slot1.horizontalNormalizedPosition

		if slot0._curScroll then
			slot0._curScroll:RemoveOnValueChanged()

			slot0._curScroll = nil
		end

		slot0._curScroll = slot1

		slot0._curScroll:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
	else
		slot0._curNormalizedPos = nil
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0._beginDrag then
		slot0._beginDrag = false

		return
	end

	slot3 = slot2.delta.x

	if slot0._beginDragScrollNormalizePos then
		if slot1.horizontalNormalizedPosition == slot0._beginDragScrollNormalizePos then
			DungeonAudio.instance:chapterListBoundary()
		elseif slot3 > 0 and slot4 <= 0 or slot3 < 0 and slot4 >= 1 then
			DungeonAudio.instance:chapterListBoundary()
		end

		slot0._beginDragScrollNormalizePos = nil
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._beginDrag = false
	slot0._beginDragScrollNormalizePos = nil
end

function slot0.removeScrollDragListener(slot0, slot1)
	slot1:RemoveDragBeginListener()
	slot1:RemoveDragEndListener()
	slot1:RemoveDragListener()
end

function slot0.onClose(slot0)
	if slot0._curScroll then
		slot0._curScroll:RemoveOnValueChanged()
	end

	slot0:removeScrollDragListener(slot0._drag)
	slot0:removeScrollDragListener(slot0._dragResource)

	slot0._scrollChangeCallback = nil
	slot0._scrollChangeCallbackTarget = nil
end

return slot0
