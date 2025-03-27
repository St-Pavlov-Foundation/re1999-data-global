module("modules.logic.rouge.map.view.store.RougeStoreGoodsView", package.seeall)

slot0 = class("RougeStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#image_icon")
	slot0._txtcollectionname = gohelper.findChildText(slot0.viewGO, "Left/#txt_collectionname")
	slot0._scrollcollectiondesc = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_collectiondesc")
	slot0._godescContent = gohelper.findChild(slot0.viewGO, "Left/#scroll_collectiondesc/Viewport/#go_descContent")
	slot0._goGrid = gohelper.findChild(slot0.viewGO, "Left/#go_grid")
	slot0._goGridItem = gohelper.findChild(slot0.viewGO, "Left/#go_grid/#go_griditem")
	slot0._gotagitem = gohelper.findChild(slot0.viewGO, "Left/tags/#go_tagitem")
	slot0._goshapecell = gohelper.findChild(slot0.viewGO, "Left/shape/#go_shapecell")
	slot0._goholetool = gohelper.findChild(slot0.viewGO, "Left/#go_holetool")
	slot0._goholeitem = gohelper.findChild(slot0.viewGO, "Left/#go_holetool/#go_holeitem")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "#btn_confirm/ani/#txt_cost")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "Left/#go_tips")
	slot0._gotagnameitem = gohelper.findChild(slot0.viewGO, "Left/#go_tips/#go_tagnameitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0.sellOut then
		GameFacade.showToast(ToastEnum.RougeStoreSellOut)

		return
	end

	if RougeModel.instance:getRougeInfo().coin < slot0.price then
		GameFacade.showToast(ToastEnum.RougeCoinNotEnough)

		return
	end

	slot0.callbackId = RougeRpc.instance:sendRougeBuyGoodsRequest(slot0.eventId, slot0.pos, slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0)
	slot0.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBuyGoods, slot0.pos)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goholeitem, false)

	slot0.bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "mask")

	slot0.bgClick:AddClickListener(slot0.closeThis, slot0)

	slot0.gridList = slot0:getUserDataTb_()
	slot0.tagGoList = slot0:getUserDataTb_()
	slot0.goHoleList = slot0:getUserDataTb_()
	slot0._itemInstTab = slot0:getUserDataTb_()
	slot0.rectDesc = slot0._scrollcollectiondesc:GetComponent(gohelper.Type_RectTransform)
	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.initData(slot0)
	slot0.collectionId = slot0.viewParam.collectionId
	slot0.price = slot0.viewParam.price
	slot0.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(slot0.collectionId)
	slot0.pos = slot0.viewParam.pos
	slot0.eventMo = slot0.viewParam.eventMo
	slot0.eventId = slot0.eventMo.eventId
	slot0.sellOut = slot0.eventMo:checkIsSellOut(slot0.pos)
end

function slot0.onUpdateParam(slot0)
	slot0:initData()
	slot0:refreshUI()
	slot0.animator:Play("open", 0, 0)
end

function slot0.onOpen(slot0)
	slot0.animator:Play("open", 0, 0)
	slot0:initData()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshCollection()
	slot0:refreshCost()
end

function slot0.refreshCollection(slot0)
	slot1 = slot0.collectionId

	slot0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot1))

	slot0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(slot1)

	RougeCollectionHelper.loadShapeGrid(slot1, slot0._goGrid, slot0._goGridItem, slot0.gridList, false)
	slot0:refreshDesc()
	slot0:refreshHole()
	slot0:refreshTag()
end

function slot0.refreshDesc(slot0)
	RougeCollectionDescHelper.setCollectionDescInfos2(slot0.collectionId, nil, slot0._godescContent, slot0._itemInstTab)
end

function slot0.refreshHole(slot0)
	gohelper.setActive(slot0._goholetool, slot0.collectionCo.holeNum > 0)

	if slot1 > 0 then
		recthelper.setHeight(slot0.rectDesc, RougeMapEnum.StoreGoodsDescHeight.WithHole)
		RougeMapHelper.loadGoItem(slot0._goholeitem, slot1, slot0.goHoleList)
	else
		recthelper.setHeight(slot0.rectDesc, RougeMapEnum.StoreGoodsDescHeight.NoHole)
	end
end

function slot0.refreshTag(slot0)
	RougeCollectionHelper.loadTags(slot0.collectionId, slot0._gotagitem, slot0.tagGoList)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(slot0.collectionId, nil, slot0._gotips, slot0._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack)
end

function slot0.refreshCost(slot0)
	slot2 = nil
	slot0._txtcost.text = (RougeModel.instance:getRougeInfo().coin >= slot0.price or string.format("<color=#EC6363>%s</color>", slot0.price)) and slot0.price
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshDesc()
end

function slot0.onClose(slot0)
	if slot0.callbackId then
		RougeRpc.instance:removeCallbackById(slot0.callbackId)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0.bgClick:RemoveClickListener()
end

return slot0
