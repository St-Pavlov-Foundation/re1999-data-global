module("modules.logic.rouge.map.view.choice.RougeMapChoiceTipView", package.seeall)

slot0 = class("RougeMapChoiceTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._gochoicetips = gohelper.findChild(slot0.viewGO, "#go_choicetips")
	slot0._gocollectiontips = gohelper.findChild(slot0.viewGO, "#go_collectiontips")
	slot0._goclosetip = gohelper.findChild(slot0.viewGO, "#go_choicetips/#go_closetip")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_choicetips/Scroll View/Viewport/Content/title/#txt_title")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "#go_choicetips/Scroll View/Viewport/Content/#go_collectionitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gochoicetips, false)
	gohelper.setActive(slot0._gocollectionitem, false)

	slot0.rectViewPort = gohelper.findChild(slot0.viewGO, "#go_choicetips/Scroll View/Viewport"):GetComponent(gohelper.Type_RectTransform)
	slot0.rectCollectionTip = slot0._gocollectiontips:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrContent = gohelper.findChild(slot0.viewGO, "#go_choicetips/Scroll View/Viewport/Content"):GetComponent(gohelper.Type_RectTransform)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0._goclosetip)

	slot0.click:AddClickListener(slot0.onClickThis, slot0)

	slot0.collectionItemList = {}

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onClickChoiceDetail, slot0.onClickChoiceDetail, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onClickPieceStoreDetail, slot0.onClickPieceStoreDetail, slot0)
end

function slot0.onClickThis(slot0)
	slot0:hideTip()
end

function slot0.onClickChoiceDetail(slot0, slot1)
	slot0.collectionIdList = slot1

	slot0:showTip()
end

function slot0.onClickPieceStoreDetail(slot0, slot1)
	slot0.collectionIdList = slot1

	slot0:showTip()
end

function slot0.showTip(slot0)
	gohelper.setActive(slot0._gochoicetips, true)
	slot0:refreshUI()
end

function slot0.hideTip(slot0)
	gohelper.setActive(slot0._gochoicetips, false)
end

function slot0.refreshUI(slot0)
	slot0._txttitle.text = luaLang("rouge_may_get_collections")

	slot0:refreshCollectionList()
end

function slot0.refreshCollectionList(slot0)
	for slot5, slot6 in ipairs(slot0.collectionIdList) do
		slot7 = slot0:getCollectionItem(slot5)

		gohelper.setActive(slot7.go, true)
		RougeCollectionDescHelper.setCollectionDescInfos3(slot6, nil, slot7.txtDesc, nil, slot0:_getOrCreateExtraParams())

		slot7.txtName.text = RougeCollectionConfig.instance:getCollectionName(slot6)

		slot7.sImageCollection:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot6))
		slot0:refreshHole(slot7, RougeCollectionConfig.instance:getCollectionCfg(slot6).holeNum)
	end

	for slot5 = #slot0.collectionIdList + 1, #slot0.collectionItemList do
		gohelper.setActive(slot0.collectionItemList[slot5].go, false)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0.rectTrContent)
	recthelper.setHeight(slot0.rectViewPort, math.min(recthelper.getHeight(slot0.rectTrContent), RougeMapEnum.MaxTipHeight))
end

function slot0._getOrCreateExtraParams(slot0)
	if not slot0._extraParams then
		slot0._extraParams = {
			isAllActive = true,
			showDescToListFunc = slot0._ShowDescToListFunc
		}
	end

	return slot0._extraParams
end

slot1 = "#352E24"

function slot0._ShowDescToListFunc(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = slot3 and slot3.isAllActive

	for slot9, slot10 in ipairs(slot0) do
		if slot1[slot10] then
			for slot15, slot16 in ipairs(slot11) do
				slot17 = slot5 or slot16.isActive

				table.insert(slot4, RougeCollectionDescHelper._decorateCollectionEffectStr(slot16.content, slot17, uv0))
				table.insert(slot4, RougeCollectionDescHelper._decorateCollectionEffectStr(slot16.condition, slot17, uv0))
			end
		end
	end

	slot2.text = table.concat(slot4, "\n")
end

function slot0.getCollectionItem(slot0, slot1)
	if slot0.collectionItemList[slot1] then
		return slot2
	end

	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gocollectionitem)
	slot2.txtDesc = gohelper.findChildText(slot2.go, "#txt_desc")
	slot2.sImageCollection = gohelper.findChildSingleImage(slot2.go, "other/#simage_collection")
	slot2.txtName = gohelper.findChildText(slot2.go, "other/layout_name/#txt_name")
	slot2.goEnchant = gohelper.findChild(slot2.go, "other/layout/#go_enchant")
	slot2.goEnchantList = slot0:getUserDataTb_()
	slot2.click = gohelper.findChildClickWithDefaultAudio(slot2.go, "#btn_detail")

	slot2.click:AddClickListener(slot0.onClickCollection, slot0, slot1)
	table.insert(slot2.goEnchantList, slot2.goEnchant)
	table.insert(slot0.collectionItemList, slot2)

	return slot2
end

function slot0.refreshHole(slot0, slot1, slot2)
	for slot6 = 1, slot2 do
		if not slot1.goEnchantList[slot6] then
			table.insert(slot1.goEnchantList, gohelper.cloneInPlace(slot1.goEnchant))
		end

		gohelper.setActive(slot7, true)
	end

	for slot6 = slot2 + 1, #slot1.goEnchantList do
		gohelper.setActive(slot1.goEnchantList[slot6], false)
	end
end

function slot0.onClickCollection(slot0, slot1)
	RougeController.instance:openRougeCollectionTipView({
		interactable = false,
		collectionCfgId = slot0.collectionIdList[slot1],
		viewPosition = recthelper.uiPosToScreenPos(slot0.rectCollectionTip),
		source = RougeEnum.OpenCollectionTipSource.ChoiceView
	})
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5.sImageCollection:UnLoadImage()
		slot5.click:RemoveClickListener()
	end

	slot0.click:RemoveClickListener()
end

return slot0
