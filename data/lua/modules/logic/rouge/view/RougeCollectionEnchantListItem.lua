module("modules.logic.rouge.view.RougeCollectionEnchantListItem", package.seeall)

slot0 = class("RougeCollectionEnchantListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "image_rare")
	slot0._simagecollectionicon = gohelper.findChildSingleImage(slot0.viewGO, "simage_collectionicon")
	slot0._goenchant = gohelper.findChild(slot0.viewGO, "go_enchant")
	slot0._simageenchanticon = gohelper.findChildSingleImage(slot0.viewGO, "go_enchant/simage_enchanticon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "go_select")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "btn_click")

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
	RougeCollectionEnchantController.instance:onSelectEnchantItem(RougeCollectionUnEnchantListModel.instance:getCurSelectCollectionId(), slot0._mo.id, RougeCollectionUnEnchantListModel.instance:getCurSelectHoleIndex())
	AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if RougeCollectionConfig.instance:getCollectionCfg(slot0._mo.cfgId) then
		slot0._simagecollectionicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.cfgId))
		UISpriteSetMgr.instance:setRougeSprite(slot0._imagerare, string.format("rouge_collection_grid_big_%s", slot1.showRare))
		slot0:refreshCollectionUI()
	end
end

function slot0.refreshCollectionUI(slot0)
	gohelper.setActive(slot0._goenchant, RougeCollectionModel.instance:getCollectionByUid(slot0._mo:getEnchantTargetId()) ~= nil)

	if slot2 then
		slot0._simageenchanticon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot2.cfgId))
	end
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._simagecollectionicon:UnLoadImage()
	slot0._simageenchanticon:UnLoadImage()
end

return slot0
