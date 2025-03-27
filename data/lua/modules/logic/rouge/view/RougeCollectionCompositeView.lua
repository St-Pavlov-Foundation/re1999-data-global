module("modules.logic.rouge.view.RougeCollectionCompositeView", package.seeall)

slot0 = class("RougeCollectionCompositeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "right/collection/#txt_collectionname")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "right/collection/#scroll_desc/Viewport/#go_descContent/#go_descitem")
	slot0._goenchantlist = gohelper.findChild(slot0.viewGO, "right/collection/#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.viewGO, "right/collection/#go_enchantlist/#go_hole")
	slot0._gocollectionicon = gohelper.findChild(slot0.viewGO, "right/collection/#go_collectionicon")
	slot0._gotags = gohelper.findChild(slot0.viewGO, "right/collection/#go_tags")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "right/collection/#go_tags/#go_tagitem")
	slot0._goframe = gohelper.findChild(slot0.viewGO, "right/composite/#go_frame")
	slot0._goline = gohelper.findChild(slot0.viewGO, "right/composite/#go_frame/#go_line")
	slot0._gocompositecontainer = gohelper.findChild(slot0.viewGO, "right/composite/#go_frame/#go_compositecontainer")
	slot0._gocompositeitem = gohelper.findChild(slot0.viewGO, "right/composite/#go_frame/#go_compositecontainer/#go_compositeitem")
	slot0._btncomposite = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_composite")
	slot0._golist = gohelper.findChild(slot0.viewGO, "left/#go_list")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#go_list/#btn_filter")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gocompositeeffect = gohelper.findChild(slot0.viewGO, "right/collection/#go_compositeeffect")
	slot0._gorougefunctionitem2 = gohelper.findChild(slot0.viewGO, "#go_rougefunctionitem2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncomposite:AddClickListener(slot0._btncompositeOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncomposite:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
end

function slot0._btncompositeOnClick(slot0)
	if not RougeCollectionModel.instance:checkIsCanCompositeCollection(RougeCollectionCompositeListModel.instance:getCurSelectCellId()) then
		GameFacade.showToast(ToastEnum.RougeCompositeFailed)

		return
	end

	slot0._consumeIds, slot0._placeSlotCollections = slot0:getNeedCostConsumeIds(slot1)

	if slot0._placeSlotCollections and #slot0._placeSlotCollections > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RougeCollectionCompositeConfirm, MsgBoxEnum.BoxType.Yes_No, slot0.confirm2CompositeCollection, slot0.cancel2CompositeCollection, nil, slot0, slot0)

		return
	end

	slot0:confirm2CompositeCollection()
end

function slot0.confirm2CompositeCollection(slot0)
	slot0:playCompositeEffect()
	RougeRpc.instance:sendRougeComposeRequest(RougeModel.instance:getSeason(), RougeCollectionCompositeListModel.instance:getCurSelectCellId(), slot0._consumeIds)
end

function slot0.cancel2CompositeCollection(slot0)
end

function slot0._btnfilterOnClick(slot0)
	RougeController.instance:openRougeCollectionFilterView({
		confirmCallback = slot0.onConfirmTagFilterCallback,
		confirmCallbackObj = slot0,
		baseSelectMap = slot0._baseTagSelectMap,
		extraSelectMap = slot0._extraTagSelectMap
	})
end

function slot0.onConfirmTagFilterCallback(slot0, slot1, slot2)
	slot0:filterCompositeList(slot1, slot2)
	slot0:refreshFilterButtonUI()
end

slot0.CompositeEffectDuration = 1.2

function slot0.playCompositeEffect(slot0)
	gohelper.setActive(slot0._gocompositeeffect, true)
	TaskDispatcher.cancelTask(slot0._hideCompositeEffect, slot0)
	TaskDispatcher.runDelay(slot0._hideCompositeEffect, slot0, uv0.CompositeEffectDuration)
end

function slot0._hideCompositeEffect(slot0)
	gohelper.setActive(slot0._gocompositeeffect, false)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnSelectCollectionCompositeItem, slot0._onSelectCompositeItem, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.CompositeCollectionSucc, slot0._compositeCollectionSucc, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)

	slot0._compositeItemTab = slot0:getUserDataTb_()
	slot0._baseTagSelectMap = {}
	slot0._extraTagSelectMap = {}
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0._descParams = {
		isAllActive = true
	}
	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._gorougefunctionitem2)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RougeCollectionCompositeListModel.instance:onInitData()
	RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
	slot0:updateSelectCollectionInfo()
	slot0.collectionComp:onOpen()
end

function slot0.updateSelectCollectionInfo(slot0)
	if not RougeCollectionCompositeListModel.instance:getById(RougeCollectionCompositeListModel.instance:getCurSelectCellId()) then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot2.product) then
		return
	end

	slot0._productId = slot3
	slot0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(slot3)

	slot0:refreshCollectionDesc()
	slot0:refreshSelectProductIcon(slot3)
	gohelper.setActive(slot0._goline, RougeCollectionConfig.instance:getCollectionCompositeIds(slot1) and #slot5 > 1)
	slot0:buildCollectionCountMap(slot5)
	gohelper.CreateObjList(slot0, slot0.refreshCompositeCollectionItem, slot5, slot0._gocompositecontainer, slot0._gocompositeitem)
	gohelper.CreateObjList(slot0, slot0.refreshCollectionBaseTag, slot4.tags, slot0._gotags, slot0._gotagitem)
	gohelper.CreateNumObjList(slot0._goenchantlist, slot0._gohole, slot4.holeNum)
end

function slot0.refreshCollectionDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos2(slot0._productId, nil, slot0._godescContent, slot0._itemInstTab, RougeCollectionDescHelper.getShowDescTypesWithoutText(), slot0._descParams)
end

function slot0.buildCollectionCountMap(slot0, slot1)
	slot0._collectionCountMap = {}

	if slot1 then
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot2[slot7]

			if not slot2[slot7] then
				slot2[slot7] = RougeCollectionModel.instance:getCollectionCountById(slot7) or 0
			end

			slot0._collectionCountMap[slot6] = slot8 > 0 and 1 or 0
			slot2[slot7] = slot2[slot7] - 1
		end
	end
end

slot1 = 160
slot2 = 160

function slot0.refreshSelectProductIcon(slot0, slot1)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot1) then
		return
	end

	if not slot0._productIconItem then
		slot0._productIconItem = RougeCollectionIconItem.New(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocollectionicon, "productItemIcon"))

		slot0._productIconItem:setHolesVisible(false)
		slot0._productIconItem:setCollectionIconSize(uv0, uv1)
	end

	slot0._productIconItem:onUpdateMO(slot1)
end

function slot0.refreshCollectionBaseTag(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagicon"), lua_rouge_tag.configDict[slot2].iconUrl)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagframe"), "rouge_collection_tagframe_1")
end

slot3 = "#A36431"
slot4 = "#9A3C27"
slot5 = 160
slot6 = 160

function slot0.refreshCompositeCollectionItem(slot0, slot1, slot2, slot3)
	if not RougeCollectionConfig.instance:getCollectionCfg(tonumber(slot2)) then
		logError("找不到合成基底造物配置, 合成基底造物id = " .. tostring(slot2))

		return
	end

	slot5 = slot0._collectionCountMap[slot3] or 0
	gohelper.findChildText(slot1, "txt_num").text = string.format("<%s>%s</color>/%s", slot5 > 0 and uv0 or uv1, slot5, RougeEnum.CompositeCollectionCostCount)
	slot0._compositeItemTab[slot3] = slot0._compositeItemTab[slot3] or slot0:getUserDataTb_()

	if not slot0._compositeItemTab[slot3].item then
		slot9 = RougeCollectionIconItem.New(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot1, "go_icon"), "itemicon"))

		slot9:setHolesVisible(false)
		slot9:setCollectionIconSize(uv2, uv3)

		slot0._compositeItemTab[slot3].item = slot9
	end

	slot10 = gohelper.findChildButtonWithAudio(slot1, "btn_click")

	slot10:RemoveClickListener()
	slot10:AddClickListener(slot0.clickCompositeItem, slot0, slot2)

	slot0._compositeItemTab[slot3].btnclick = slot10

	slot9:onUpdateMO(slot2)
end

function slot0.clickCompositeItem(slot0, slot1)
	RougeController.instance:openRougeCollectionTipView({
		collectionCfgId = slot1,
		viewPosition = RougeEnum.CollectionTipPos.CompositeBaseCollection
	})
end

function slot0._onSelectCompositeItem(slot0, slot1)
	if slot1 == RougeCollectionCompositeListModel.instance:getCurSelectCellId() then
		return
	end

	RougeCollectionCompositeListModel.instance:selectCell(RougeCollectionCompositeListModel.instance:getIndex(RougeCollectionCompositeListModel.instance:getById(slot1)), true)
	slot0:updateSelectCollectionInfo()
	gohelper.setActive(slot0._gocompositeeffect, false)
	TaskDispatcher.cancelTask(slot0._hideCompositeEffect, slot0)
end

function slot0.filterCompositeList(slot0, slot1, slot2)
	RougeCollectionCompositeListModel.instance:onInitData(slot1, slot2)

	if not RougeCollectionCompositeListModel.instance:getById(RougeCollectionCompositeListModel.instance:getCurSelectCellId()) then
		RougeCollectionCompositeListModel.instance:selectFirstOrDefault()
		slot0:updateSelectCollectionInfo()
	end
end

function slot0.getNeedCostConsumeIds(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = {}

	if RougeCollectionConfig.instance:getCollectionCompositeIds(slot1) then
		for slot9, slot10 in ipairs(slot2) do
			slot0:selectNeedCostConsumeIds(slot10, slot3, slot4, slot5)
		end
	end

	return slot3, slot5
end

function slot0.selectNeedCostConsumeIds(slot0, slot1, slot2, slot3, slot4)
	if RougeCollectionModel.instance:getCollectionByCfgId(slot1) then
		for slot10 = 1, #slot5 do
			if slot5[slot10] and slot5[slot10].id and not slot3[slot11] then
				table.insert(slot2, slot11)

				slot3[slot11] = true
				slot6 = 0 + 1

				if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot11) then
					table.insert(slot4, slot11)
				end
			end

			if RougeEnum.CompositeCollectionCostCount <= slot6 then
				break
			end
		end
	end
end

function slot0._compositeCollectionSucc(slot0)
	RougeCollectionCompositeListModel.instance:onModelUpdate()
	slot0:updateSelectCollectionInfo()
end

function slot0.refreshFilterButtonUI(slot0)
	slot1 = RougeCollectionCompositeListModel.instance:isFiltering()

	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "select"), slot1)
	gohelper.setActive(gohelper.findChild(slot0._btnfilter.gameObject, "unselect"), not slot1)
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshCollectionDesc()
end

function slot0.onClose(slot0)
	slot0.collectionComp:onClose()
end

function slot0.onDestroyView(slot0)
	if slot0._compositeItemTab then
		for slot4, slot5 in pairs(slot0._compositeItemTab) do
			if slot5.item then
				slot5.item:destroy()
			end

			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end

	if slot0._productIconItem then
		slot0._productIconItem:destroy()

		slot0._productIconItem = nil
	end

	TaskDispatcher.cancelTask(slot0._hideCompositeEffect, slot0)
	slot0.collectionComp:destroy()
end

return slot0
