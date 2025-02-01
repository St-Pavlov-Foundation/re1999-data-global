module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordView", package.seeall)

slot0 = class("Role37PuzzleRecordView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnCloseMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_CloseMask")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_Title")
	slot0._scrollList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_List")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "#go_Empty")
	slot0._txtEmpty = gohelper.findChildText(slot0.viewGO, "#go_Empty/#txt_Empty")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._itemPrefab = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content/RecordItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnCloseMask:AddClickListener(slot0._btnCloseMaskOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnCloseMask:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	Role37PuzzleController.instance:registerCallback(Role37PuzzleEvent.RecordCntChange, slot0.onRecordChange, slot0)
	slot0:onRecordChange(PuzzleRecordListModel.instance:getCount())
	slot0:initRecordItem()
end

function slot0.onDestroyView(slot0)
	Role37PuzzleController.instance:unregisterCallback(Role37PuzzleEvent.RecordCntChange, slot0.onRecordChange, slot0)
end

function slot0.onRecordChange(slot0, slot1)
	gohelper.setActive(slot0._goEmpty, slot1 <= 0)
end

function slot0.initRecordItem(slot0)
	for slot5, slot6 in pairs(PuzzleRecordListModel.instance:getList()) do
		slot7 = gohelper.cloneInPlace(slot0._itemPrefab)

		gohelper.setActive(slot7, true)
		MonoHelper.addNoUpdateLuaComOnceToGo(slot7, PuzzleRecordViewItem):onUpdateMO(slot6)
	end
end

return slot0
