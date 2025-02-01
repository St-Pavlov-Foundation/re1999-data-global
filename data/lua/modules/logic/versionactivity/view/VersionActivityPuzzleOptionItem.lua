module("modules.logic.versionactivity.view.VersionActivityPuzzleOptionItem", package.seeall)

slot0 = class("VersionActivityPuzzleOptionItem", UserDataDispose)

function slot0.onInitView(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.parentView = slot2
	slot0.txtInfo = gohelper.findChildText(slot1, "info")
	slot0.head = gohelper.findChild(slot0.go, "head")
	slot0.txtLineIndex = gohelper.findChildText(slot0.go, "head/txt_index")
	slot0.bgLineIndex = gohelper.findChildImage(slot0.go, "head/bg")

	if not slot2.isFinish then
		slot0.drag = SLFramework.UGUI.UIDragListener.Get(slot0.go)

		slot0.drag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0.drag:AddDragEndListener(slot0._onDragEnd, slot0)
		slot0.drag:AddDragListener(slot0._onDrag, slot0)
	end
end

function slot0.updateInfo(slot0, slot1, slot2)
	gohelper.setActive(slot0.go, true)

	slot0.txtInfo.text = slot1
	slot0.info = slot1
	slot0.answerIndex = slot2

	gohelper.setActive(slot0.head, false)

	if (slot0.answerIndex - 1) % 4 == 2 then
		gohelper.setActive(slot0.head, true)

		slot0.txtLineIndex.text = math.ceil(slot0.answerIndex / 4)

		UISpriteSetMgr.instance:setActivityPuzzle(slot0.bgLineIndex, math.ceil(slot0.answerIndex / 4), true)
	end

	slot5 = 2
	slot6 = 350

	if slot3 == 0 or slot3 == 2 then
		slot6 = 290
		slot5 = 30
	end

	transformhelper.setLocalPosXY(slot0.txtInfo.transform, slot5, 0)
	recthelper.setWidth(slot0.txtInfo.transform, slot6)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0.parentView:onDragItemDragBegin(slot2, slot0.info, slot0.answerIndex)
end

function slot0._onDrag(slot0, slot1, slot2)
	slot0.parentView:onDragItemDragging(slot2)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0.parentView:onDragItemDragEnd(slot2)
end

function slot0.unUse(slot0)
	slot0.txtInfo.text = slot0.info
end

function slot0.matchCorrect(slot0)
	slot0.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, slot0.info)
end

function slot0.matchError(slot0)
	slot0.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchErrorColor, slot0.info)
end

function slot0.getScreenPos(slot0)
	return recthelper.uiPosToScreenPos(slot0.go.transform)
end

function slot0.onDestroy(slot0)
	if slot0.drag then
		slot0.drag:RemoveDragListener()
		slot0.drag:RemoveDragBeginListener()
		slot0.drag:RemoveDragEndListener()

		slot0.drag = nil
	end

	slot0:__onDispose()
end

return slot0
