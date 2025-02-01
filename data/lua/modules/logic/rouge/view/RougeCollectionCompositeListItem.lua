module("modules.logic.rouge.view.RougeCollectionCompositeListItem", package.seeall)

slot0 = class("RougeCollectionCompositeListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocollectionicon = gohelper.findChild(slot0.viewGO, "go_collectionicon")
	slot0._gocancomposite = gohelper.findChild(slot0.viewGO, "go_cancomposite")
	slot0._goselectframe = gohelper.findChild(slot0.viewGO, "go_selectframe")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionCompositeItem, slot0._mo.id)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0._mo then
		return
	end

	gohelper.setActive(slot0._gocancomposite, slot0:checkIsCanComposite(slot0._mo.id))
	gohelper.setActive(slot0._goselectframe, RougeCollectionCompositeListModel.instance:getCurSelectCellId() == slot0._mo.id)
	slot0:refreshProductIcon(slot0._mo.product)
end

function slot0.refreshProductIcon(slot0, slot1)
	if not slot0._iconItem then
		slot0._iconItem = RougeCollectionIconItem.New(slot0._view:getResInst(slot0._view.viewContainer:getSetting().otherRes[1], slot0._gocollectionicon, "itemicon"))
	end

	slot0._iconItem:onUpdateMO(slot1)
	slot0._iconItem:setHolesVisible(false)
end

function slot0.checkIsCanComposite(slot0, slot1)
	slot3 = true

	if RougeCollectionConfig.instance:getCollectionCompositeIdAndCount(slot1) then
		for slot7, slot8 in pairs(slot2) do
			if RougeCollectionModel.instance:getCollectionCountById(slot7) < slot8 then
				slot3 = false

				break
			end
		end
	end

	return slot3
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselectframe, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._iconItem then
		slot0._iconItem:destroy()

		slot0._iconItem = nil
	end
end

return slot0
