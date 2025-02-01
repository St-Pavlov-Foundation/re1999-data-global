module("modules.logic.rouge.view.RougeCollectionHandBookItem", package.seeall)

slot0 = class("RougeCollectionHandBookItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagebg = gohelper.findChildImage(slot0.viewGO, "normal/#image_bg")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "normal/#txt_index")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "normal/#simage_collection")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "go_selected")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._btnclickOnClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.OnSelectCollectionHandBookItem, slot0._mo.id)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	UISpriteSetMgr.instance:setRougeSprite(slot0._imagebg, "rouge_episode_collectionbg_" .. tostring(RougeCollectionConfig.instance:getCollectionCfg(slot0._mo.product).showRare))
	gohelper.setActive(slot0._goselected, RougeCollectionHandBookListModel.instance:isCurSelectTargetId(slot0._mo.id))
	slot0._simagecollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.product))

	slot0._txtindex.text = slot0._index
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagecollection:UnLoadImage()
end

return slot0
