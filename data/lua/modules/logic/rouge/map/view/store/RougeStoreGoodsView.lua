module("modules.logic.rouge.map.view.store.RougeStoreGoodsView", package.seeall)

local var_0_0 = class("RougeStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#image_icon")
	arg_1_0._txtcollectionname = gohelper.findChildText(arg_1_0.viewGO, "Left/#txt_collectionname")
	arg_1_0._scrollcollectiondesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_collectiondesc")
	arg_1_0._godescContent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_collectiondesc/Viewport/#go_descContent")
	arg_1_0._goGrid = gohelper.findChild(arg_1_0.viewGO, "Left/#go_grid")
	arg_1_0._goGridItem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_grid/#go_griditem")
	arg_1_0._gotagitem = gohelper.findChild(arg_1_0.viewGO, "Left/tags/#go_tagitem")
	arg_1_0._goshapecell = gohelper.findChild(arg_1_0.viewGO, "Left/shape/#go_shapecell")
	arg_1_0._goholetool = gohelper.findChild(arg_1_0.viewGO, "Left/#go_holetool")
	arg_1_0._goholeitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_holetool/#go_holeitem")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "#btn_confirm/ani/#txt_cost")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tips")
	arg_1_0._gotagnameitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tips/#go_tagnameitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if arg_4_0.sellOut then
		GameFacade.showToast(ToastEnum.RougeStoreSellOut)

		return
	end

	if RougeModel.instance:getRougeInfo().coin < arg_4_0.price then
		GameFacade.showToast(ToastEnum.RougeCoinNotEnough)

		return
	end

	arg_4_0.callbackId = RougeRpc.instance:sendRougeBuyGoodsRequest(arg_4_0.eventId, arg_4_0.pos, arg_4_0.onReceiveMsg, arg_4_0)
end

function var_0_0.onReceiveMsg(arg_5_0)
	arg_5_0.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onBuyGoods, arg_5_0.pos)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goholeitem, false)

	arg_6_0.bgClick = gohelper.findChildClickWithDefaultAudio(arg_6_0.viewGO, "mask")

	arg_6_0.bgClick:AddClickListener(arg_6_0.closeThis, arg_6_0)

	arg_6_0.gridList = arg_6_0:getUserDataTb_()
	arg_6_0.tagGoList = arg_6_0:getUserDataTb_()
	arg_6_0.goHoleList = arg_6_0:getUserDataTb_()
	arg_6_0._itemInstTab = arg_6_0:getUserDataTb_()
	arg_6_0.rectDesc = arg_6_0._scrollcollectiondesc:GetComponent(gohelper.Type_RectTransform)
	arg_6_0.animator = arg_6_0.viewGO:GetComponent(gohelper.Type_Animator)

	arg_6_0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, arg_6_0._onSwitchCollectionInfoType, arg_6_0)
end

function var_0_0.initData(arg_7_0)
	arg_7_0.collectionId = arg_7_0.viewParam.collectionId
	arg_7_0.price = arg_7_0.viewParam.price
	arg_7_0.collectionCo = RougeCollectionConfig.instance:getCollectionCfg(arg_7_0.collectionId)
	arg_7_0.pos = arg_7_0.viewParam.pos
	arg_7_0.eventMo = arg_7_0.viewParam.eventMo
	arg_7_0.eventId = arg_7_0.eventMo.eventId
	arg_7_0.sellOut = arg_7_0.eventMo:checkIsSellOut(arg_7_0.pos)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:initData()
	arg_8_0:refreshUI()
	arg_8_0.animator:Play("open", 0, 0)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.animator:Play("open", 0, 0)
	arg_9_0:initData()
	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshCollection()
	arg_10_0:refreshCost()
end

function var_0_0.refreshCollection(arg_11_0)
	local var_11_0 = arg_11_0.collectionId

	arg_11_0._simageicon:LoadImage(RougeCollectionHelper.getCollectionIconUrl(var_11_0))

	arg_11_0._txtcollectionname.text = RougeCollectionConfig.instance:getCollectionName(var_11_0)

	RougeCollectionHelper.loadShapeGrid(var_11_0, arg_11_0._goGrid, arg_11_0._goGridItem, arg_11_0.gridList, false)
	arg_11_0:refreshDesc()
	arg_11_0:refreshHole()
	arg_11_0:refreshTag()
end

function var_0_0.refreshDesc(arg_12_0)
	RougeCollectionDescHelper.setCollectionDescInfos2(arg_12_0.collectionId, nil, arg_12_0._godescContent, arg_12_0._itemInstTab)
end

function var_0_0.refreshHole(arg_13_0)
	local var_13_0 = arg_13_0.collectionCo.holeNum

	gohelper.setActive(arg_13_0._goholetool, var_13_0 > 0)

	if var_13_0 > 0 then
		recthelper.setHeight(arg_13_0.rectDesc, RougeMapEnum.StoreGoodsDescHeight.WithHole)
		RougeMapHelper.loadGoItem(arg_13_0._goholeitem, var_13_0, arg_13_0.goHoleList)
	else
		recthelper.setHeight(arg_13_0.rectDesc, RougeMapEnum.StoreGoodsDescHeight.NoHole)
	end
end

function var_0_0.refreshTag(arg_14_0)
	RougeCollectionHelper.loadTags(arg_14_0.collectionId, arg_14_0._gotagitem, arg_14_0.tagGoList)
	RougeCollectionHelper.loadCollectionAndEnchantTagNames(arg_14_0.collectionId, nil, arg_14_0._gotips, arg_14_0._gotagnameitem, RougeCollectionHelper._loadCollectionTagNameCallBack)
end

function var_0_0.refreshCost(arg_15_0)
	local var_15_0 = RougeModel.instance:getRougeInfo().coin
	local var_15_1

	if var_15_0 < arg_15_0.price then
		var_15_1 = string.format("<color=#EC6363>%s</color>", arg_15_0.price)
	else
		var_15_1 = arg_15_0.price
	end

	arg_15_0._txtcost.text = var_15_1
end

function var_0_0._onSwitchCollectionInfoType(arg_16_0)
	arg_16_0:refreshDesc()
end

function var_0_0.onClose(arg_17_0)
	if arg_17_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_17_0.callbackId)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simageicon:UnLoadImage()
	arg_18_0.bgClick:RemoveClickListener()
end

return var_0_0
