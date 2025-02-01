module("modules.logic.notice.view.NoticeTitleItem", package.seeall)

slot0 = class("NoticeTitleItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._click = gohelper.getClickWithAudio(slot1, AudioEnum.UI.UI_Common_Click)
	slot0._redtipGO = gohelper.findChild(slot1, "#go_redtip")
	slot0._normalGO = gohelper.findChild(slot1, "#go_normal")
	slot0._selectGO = gohelper.findChild(slot1, "#go_select")
	slot0._txtTitle1 = gohelper.findChildText(slot0._normalGO, "title")
	slot0._txtTitle2 = gohelper.findChildText(slot0._selectGO, "title")
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickItem, slot0)
	slot0._click:AddClickDownListener(slot0._onClickItemDown, slot0)
	slot0._click:AddClickUpListener(slot0._onClickItemUp, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
	slot0._click:RemoveClickUpListener()
	slot0._click:RemoveClickDownListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtTitle1.text = slot1:getTitle()
	slot0._txtTitle2.text = slot1:getTitle()

	gohelper.setActive(slot0._redtipGO, not NoticeModel.instance:getNoticeMoIsRead(slot0._mo))
end

function slot0.onSelect(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._redtipGO, false)
		NoticeModel.instance:readNoticeMo(slot0._mo)
		NoticeController.instance:dispatchEvent(NoticeEvent.OnSelectNoticeItem, slot0._mo)
	end

	gohelper.setActive(slot0._selectGO, slot1)
	gohelper.setActive(slot0._normalGO, not slot1)
end

function slot0._onClickItem(slot0)
	if NoticeModel.instance:getIndex(slot0._mo) == slot0._view.lastSelectIndex then
		return
	end

	slot0._view:selectCell(slot1, true)

	slot0._view.lastSelectIndex = slot1

	if ViewMgr.instance:getContainer(ViewName.NoticeView) then
		slot2:trackNoticeLoad(slot0._mo)
	end
end

function slot0._onClickItemDown(slot0)
	slot0:_setItemPressState(true)
end

function slot0._onClickItemUp(slot0)
	slot0:_setItemPressState(false)
end

function slot0._setItemPressState(slot0, slot1)
	if not slot0._itemContainer then
		slot0._itemContainer = slot0:getUserDataTb_()
		slot2 = slot0._go:GetComponentsInChildren(gohelper.Type_Image, true)
		slot0._itemContainer.images = slot2
		slot0._itemContainer.tmps = slot0._go:GetComponentsInChildren(gohelper.Type_TextMesh, true)
		slot0._itemContainer.compColor = {}
		slot4 = slot2:GetEnumerator()

		while slot4:MoveNext() do
			slot0._itemContainer.compColor[slot4.Current] = slot4.Current.color
		end

		slot4 = slot3:GetEnumerator()

		while slot4:MoveNext() do
			slot0._itemContainer.compColor[slot4.Current] = slot4.Current.color
		end
	end

	if slot0._itemContainer then
		UIColorHelper.setUIPressState(slot0._itemContainer.images, slot0._itemContainer.compColor, slot1)
		UIColorHelper.setUIPressState(slot0._itemContainer.tmps, slot0._itemContainer.compColor, slot1)
	end
end

return slot0
