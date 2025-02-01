module("modules.logic.rouge.view.RougeCollectionHandBookFavoriteView", package.seeall)

slot0 = class("RougeCollectionHandBookFavoriteView", RougeCollectionHandBookView)

function slot0.onInitView(slot0)
	slot0._btnLayout = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_layout")
	slot0._goUnselectLayout = gohelper.findChild(slot0._btnLayout.gameObject, "unselected")
	slot0._goSelectLayout = gohelper.findChild(slot0._btnLayout.gameObject, "selected")

	uv0.super.onInitView(slot0)
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnLayout:AddClickListener(slot0._btnLayoutOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnLayout:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	gohelper.setActive(slot0._btnLayout, true)
	slot0:_setFilterSelected(false)
end

function slot0._btnLayoutOnClick(slot0)
	if slot0._isAllSelected then
		return
	end

	slot0:_setFilterSelected(false)
end

function slot0._setFilterSelected(slot0, slot1)
	uv0.super._setFilterSelected(slot0, slot1)
	slot0:_setAllSelected(not slot1)
end

function slot0._setAllSelected(slot0, slot1)
	slot0._isAllSelected = slot1

	gohelper.setActive(slot0._goSelectLayout, slot1)
	gohelper.setActive(slot0._goUnselectLayout, not slot1)

	if slot0._isAllSelected then
		slot0._baseTagSelectMap = {}
		slot0._extraTagSelectMap = {}

		RougeCollectionHandBookListModel.instance:onInitData()
	end
end

return slot0
