module("modules.logic.dungeon.view.rolestory.RoleStoryReviewItem", package.seeall)

slot0 = class("RoleStoryReviewItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "selectbg")
	slot0.txtSelectOrder = gohelper.findChildTextMesh(slot0.goSelect, "#txt_selectorder")
	slot0.goNormal = gohelper.findChild(slot0.viewGO, "normalbg")
	slot0.txtNormalOrder = gohelper.findChildTextMesh(slot0.goNormal, "#txt_normalorder")
	slot0.txtStoryName = gohelper.findChildTextMesh(slot0.viewGO, "#txt_storyname")
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClickBtnClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickBtnClick(slot0)
	if not slot0.data then
		return
	end

	if slot0.selectDispatchId == slot0.data.id then
		return
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickReviewItem, slot0.data.id)
end

function slot0.refreshItem(slot0)
	if not slot0.data then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0.txtSelectOrder.text = string.format("%02d", slot0.index)
	slot0.txtNormalOrder.text = string.format("%02d", slot0.index)
	slot0.txtStoryName.text = slot0.data.name
	slot1 = slot0.selectDispatchId == slot0.data.id

	gohelper.setActive(slot0.goSelect, slot1)
	gohelper.setActive(slot0.goNormal, not slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2

	slot0:refreshItem()
end

function slot0.updateSelect(slot0, slot1)
	slot0.selectDispatchId = slot1

	slot0:refreshItem()
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
