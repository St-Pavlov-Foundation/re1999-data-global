module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateTeamChessItem", package.seeall)

slot0 = class("EliminateTeamChessItem", EliminateTeamChessDetailItem)
slot1 = SLFramework.UGUI.UILongPressListener
slot2 = SLFramework.UGUI.UIDragListener

function slot0._editableInitView(slot0)
	slot0._longClick = uv0.Get(slot0.viewGO)

	slot0._longClick:SetLongPressTime({
		0.5,
		99999
	})

	slot0._dragClick = uv1.Get(slot0.viewGO)
end

function slot0._editableAddEvents(slot0)
	slot0._longClick:AddClickListener(slot0._onLongClick, slot0)
	slot0._longClick:AddLongPressListener(slot0._onLongPress, slot0)
	slot0._dragClick:AddDragListener(slot0._onDrag, slot0)
	slot0._dragClick:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._dragClick:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0._editableRemoveEvents(slot0)
	if slot0._longClick then
		slot0._longClick:RemoveClickListener()
		slot0._longClick:RemoveLongPressListener()
	end

	if slot0._dragClick then
		slot0._dragClick:RemoveDragBeginListener()
		slot0._dragClick:RemoveDragEndListener()
		slot0._dragClick:RemoveDragListener()
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not slot0._canUse or not slot0._isLongPress then
		return
	end

	slot0._beginDragX = slot2.position.x
	slot0._beginDragY = slot2.position.y

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_drag)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemBeginDrag, slot0._soliderId, slot0._beginDragX, slot0._beginDragY)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._canUse or not slot0._isLongPress or not slot0._beginDragX or not slot0._beginDragY then
		return
	end

	slot3 = slot2.position

	if math.abs(slot3.x - slot0._beginDragX) < 10 and math.abs(slot3.y - slot0._beginDragY) < 10 then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDrag, slot0._soliderId, nil, , slot4, slot5)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0._canUse or not slot0._isLongPress or not slot0._beginDragX or not slot0._beginDragY then
		return
	end

	slot3 = slot2.position

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessItemDragEnd, slot0._soliderId, nil, , slot3.x, slot3.y)
end

function slot0._onLongClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessView, slot0._soliderId, nil, , EliminateTeamChessEnum.ChessTipType.showDesc, slot0, {
		soliderTipOffsetX = EliminateTeamChessEnum.soliderItemTipOffsetX,
		soliderTipOffsetY = EliminateTeamChessEnum.soliderItemTipOffsetY
	})
end

function slot0.getPosXYZ(slot0)
	return transformhelper.getPos(slot0.viewGO.transform)
end

function slot0._onLongPress(slot0)
	if not slot0._canUse then
		return
	end

	logNormal("EliminateTeamChessItem:_onLongPress")
end

function slot0.setSoliderId(slot0, slot1)
	uv0.super.setSoliderId(slot0, slot1)

	slot0._isLongPress = true
end

function slot0.setChildIndex(slot0, slot1)
	slot0.viewGO.transform:SetSiblingIndex(slot1)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)

	slot0._effectCollection = nil
end

return slot0
