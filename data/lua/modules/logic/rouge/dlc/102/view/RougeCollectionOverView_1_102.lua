module("modules.logic.rouge.dlc.102.view.RougeCollectionOverView_1_102", package.seeall)

slot0 = class("RougeCollectionOverView_1_102", BaseViewExtended)
slot0.ParentObjPath = "#go_rougemapdetailcontainer"
slot0.AssetUrl = "ui/viewres/rouge/dlc/102/rougeequiptipsview.prefab"
slot1 = -62
slot2 = -18.6
slot3 = -38.06
slot4 = 25.5
slot5 = -78
slot6 = 0
slot7 = 0
slot8 = 800

function slot0.onInitView(slot0)
	slot0._btntips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_tips")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._scrolloverview = gohelper.findChildScrollRect(slot0.viewGO, "#go_tips/#scroll_overview")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#go_collectionitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_close")
	slot0._collectionItemTab = slot0:getUserDataTb_()

	recthelper.setAnchor(slot0._gotips.transform, uv0, uv1)
	recthelper.setAnchor(slot0._btntips.transform, uv2, uv3)
	gohelper.setActive(slot0._btntips, true)
	gohelper.setActive(slot0._gotips, false)
end

function slot0.addEvents(slot0)
	slot0._btntips:AddClickListener(slot0._btntipOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntips:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btntipOnClick(slot0)
	gohelper.setActive(slot0._gotips, true)
	slot0:refreshUI()
end

function slot0._btncloseOnClick(slot0)
	gohelper.setActive(slot0._gotips, false)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function slot0.onUpdateDLC(slot0)
end

function slot0.onOpen(slot0)
	slot0._spCollections = RougeDLCModel102.instance:getCanLevelUpSpCollectionsInSlotArea()

	gohelper.setActive(slot0._btntips.gameObject, (slot0._spCollections and #slot0._spCollections or 0) > 0)
end

function slot0.refreshUI(slot0)
	slot1 = {
		[slot7] = true
	}

	for slot5, slot6 in ipairs(slot0._spCollections) do
		slot0:_refreshCollectionItem(slot0:_getOrCreateCollectionItem(slot5), slot6)
	end

	for slot5, slot6 in pairs(slot0._collectionItemTab) do
		if not slot1[slot6] then
			gohelper.setActive(slot6.viewGO, false)
		end
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._gocontent.transform)
	recthelper.setHeight(slot0._scrolloverview.transform, Mathf.Clamp(recthelper.getHeight(slot0._gocontent.transform), uv0, uv1))
end

function slot0._getOrCreateCollectionItem(slot0, slot1)
	if not slot0._collectionItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gocollectionitem, "item_" .. slot1)
		slot2.desccontent = gohelper.findChild(slot2.viewGO, "go_desccontent")
		slot2.descList = slot0:getUserDataTb_()
		slot2.txtname = gohelper.findChildText(slot2.viewGO, "name/txt_name")
		slot2.txtDec = gohelper.findChild(slot2.viewGO, "#txt_dec")
		slot2.simageicon = gohelper.findChildSingleImage(slot2.viewGO, "image_collection")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._btnclickCollectionItem, slot0, slot1)

		slot0._collectionItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._btnclickCollectionItem(slot0, slot1)
	if not (slot0._spCollections and slot0._spCollections[slot1]) then
		return
	end

	RougeController.instance:openRougeCollectionTipView({
		interactable = false,
		useCloseBtn = false,
		collectionId = slot2:getCollectionId(),
		viewPosition = Vector2.New(uv0, uv1)
	})
end

function slot0._refreshCollectionItem(slot0, slot1, slot2)
	slot4 = slot2:getCollectionCfgId()
	slot1.txtname.text = RougeCollectionConfig.instance:getCollectionName(slot4)

	slot1.simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot4))
	RougeCollectionDescHelper.setCollectionDescInfos(slot2:getCollectionId(), slot1.desccontent, slot1.descList, slot0:_getOrCreateShowDescTypes(), slot0:_getOrCreateExtraParams())
	gohelper.setActive(slot1.viewGO, true)
end

function slot0._getOrCreateShowDescTypes(slot0)
	if not slot0._showTypes then
		slot0._showTypes = {
			RougeEnum.CollectionDescType.SpecialText
		}
	end

	return slot0._showTypes
end

function slot0._getOrCreateExtraParams(slot0)
	if not slot0._extraParams then
		slot0._extraParams = {
			showDescFuncMap = {
				[RougeEnum.CollectionDescType.SpecialText] = slot0._showSpCollectionLevelUp
			}
		}
	end

	return slot0._extraParams
end

slot9 = "#A08156"
slot10 = "#616161"
slot11 = 1
slot12 = 0.6

function slot0._showSpCollectionLevelUp(slot0, slot1)
	slot2 = slot0:GetComponent(gohelper.Type_TextMesh)
	slot2.text = slot1.condition

	gohelper.setActive(gohelper.findChild(slot0, "finish"), slot1.isActive)
	gohelper.setActive(gohelper.findChild(slot0, "unfinish"), not slot1.isActive)
	SLFramework.UGUI.GuiHelper.SetColor(slot2, slot1.isActive and uv0 or uv1)
	ZProj.UGUIHelper.SetColorAlpha(slot2, slot1.isActive and uv2 or uv3)
end

function slot0.unloadCollectionItems(slot0)
	if slot0._collectionItemTab then
		for slot4, slot5 in pairs(slot0._collectionItemTab) do
			slot5.simageicon:UnLoadImage()
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.onDestroyView(slot0)
	slot0:unloadCollectionItems()
end

return slot0
