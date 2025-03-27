module("modules.logic.rouge.view.RougeCollectionOverListItem", package.seeall)

slot0 = class("RougeCollectionOverListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "#txt_dec")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

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
	RougeController.instance:openRougeCollectionTipView({
		interactable = false,
		collectionId = slot0._mo.id,
		viewPosition = RougeEnum.CollectionTipViewPlacePos,
		source = RougeEnum.OpenCollectionTipSource.SlotArea
	})
end

function slot0._editableInitView(slot0)
	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if RougeCollectionConfig.instance:getCollectionCfg(slot0._mo.cfgId) then
		slot0:refreshCollectionIcon()

		slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot0._mo.cfgId, slot0._mo:getAllEnchantCfgId())

		RougeCollectionDescHelper.setCollectionDescInfos4(slot0._mo.id, slot0._txtdec, RougeCollectionDescHelper.getShowDescTypesWithoutText(), RougeCollectionDescHelper.getExtraParams_KeepAllActive())
	end
end

slot1 = 160
slot2 = 160

function slot0.refreshCollectionIcon(slot0)
	if not slot0._itemIcon then
		slot0._itemIcon = RougeCollectionEnchantIconItem.New(slot0._view:getResInst(ViewMgr.instance:getSetting(ViewName.RougeCollectionOverView).otherRes[1], slot0._goicon, "itemicon"))

		slot0._itemIcon:setCollectionIconSize(uv0, uv1)
	end

	slot0._itemIcon:onUpdateMO(slot0._mo)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroyView(slot0)
	if slot0._itemIcon then
		slot0._itemIcon:destroy()

		slot0._itemIcon = nil
	end
end

return slot0
