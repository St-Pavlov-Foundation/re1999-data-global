module("modules.logic.rouge.map.view.store.RougeMapStoreGoodsItem", package.seeall)

local var_0_0 = class("RougeMapStoreGoodsItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.click = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "click")

	arg_2_0.click:AddClickListener(arg_2_0.onClickSelf, arg_2_0)

	arg_2_0._goenchantlist = gohelper.findChild(arg_2_0.go, "#go_enchantlist")
	arg_2_0._gohole = gohelper.findChild(arg_2_0.go, "#go_enchantlist/#go_hole")
	arg_2_0.goGridContainer = gohelper.findChild(arg_2_0.go, "collection/gridbg")
	arg_2_0.goGridItem = gohelper.findChild(arg_2_0.go, "collection/gridbg/grid")
	arg_2_0._gotagitem = gohelper.findChild(arg_2_0.go, "tags/#go_tagitem")
	arg_2_0._simagecollection = gohelper.findChildSingleImage(arg_2_0.go, "collection/#simage_collection")
	arg_2_0._txtname = gohelper.findChildText(arg_2_0.go, "#txt_name")
	arg_2_0._godiscount = gohelper.findChild(arg_2_0.go, "#go_discount")
	arg_2_0._txtdiscount = gohelper.findChildText(arg_2_0.go, "#go_discount/#txt_discount")
	arg_2_0._txtcost = gohelper.findChildText(arg_2_0.go, "layout/#txt_cost")
	arg_2_0._txtoriginalprice = gohelper.findChildText(arg_2_0.go, "layout/#txt_originalprice")
	arg_2_0._gosoldout = gohelper.findChild(arg_2_0.go, "#go_soldout")
	arg_2_0.holeGoList = arg_2_0:getUserDataTb_()
	arg_2_0.gridItemList = arg_2_0:getUserDataTb_()
	arg_2_0.tagGoList = arg_2_0:getUserDataTb_()

	gohelper.setActive(arg_2_0._gotagitem, false)
	arg_2_0:addEventCb(RougeMapController.instance, RougeMapEvent.onBuyGoods, arg_2_0.onBuyGoods, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, arg_2_0.refreshCost, arg_2_0)
end

function var_0_0.onBuyGoods(arg_3_0, arg_3_1)
	if arg_3_0.pos == arg_3_1 then
		arg_3_0:refreshSellOut()
	end
end

function var_0_0.onClickSelf(arg_4_0)
	logNormal("click self")
	ViewMgr.instance:openView(ViewName.RougeStoreGoodsView, {
		collectionId = arg_4_0.collectionId,
		pos = arg_4_0.pos,
		eventMo = arg_4_0.eventMo,
		price = arg_4_0.price
	})
end

function var_0_0.update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.eventMo = arg_5_1
	arg_5_0.pos = arg_5_2
	arg_5_0.goodsMo = arg_5_3
	arg_5_0.discountRate = arg_5_0.goodsMo.discountRate
	arg_5_0.originalPrice = arg_5_0.goodsMo.originalPrice
	arg_5_0.price = arg_5_0.goodsMo.price
	arg_5_0.collectionId = arg_5_0.goodsMo.collectionId
	arg_5_0.hasDiscount = arg_5_0.discountRate ~= -1 and arg_5_0.discountRate ~= 1000

	arg_5_0:show()
	arg_5_0:refreshHole()
	arg_5_0:refreshTag()
	arg_5_0:refreshCollection()
	arg_5_0:refreshCost()
	arg_5_0:refreshSellOut()
	arg_5_0:refreshDiscount()
end

function var_0_0.refreshHole(arg_6_0)
	local var_6_0 = RougeCollectionConfig.instance:getCollectionHoleNum(arg_6_0.collectionId) or 0

	if var_6_0 < 1 then
		gohelper.setActive(arg_6_0._goenchantlist, false)

		return
	end

	for iter_6_0 = 2, var_6_0 do
		local var_6_1 = arg_6_0.holeGoList[iter_6_0]

		if not var_6_1 then
			var_6_1 = gohelper.cloneInPlace(arg_6_0._gohole)

			table.insert(arg_6_0.holeGoList, var_6_1)
		end

		gohelper.setActive(var_6_1, true)
	end

	for iter_6_1 = var_6_0 + 1, #arg_6_0.holeGoList do
		gohelper.setActive(arg_6_0.holeGoList[iter_6_1], false)
	end
end

function var_0_0.refreshTag(arg_7_0)
	RougeCollectionHelper.loadTags(arg_7_0.collectionId, arg_7_0._gotagitem, arg_7_0.tagGoList)
end

function var_0_0.refreshCollection(arg_8_0)
	local var_8_0 = RougeCollectionHelper.getCollectionIconUrl(arg_8_0.collectionId)

	if var_8_0 then
		arg_8_0._simagecollection:LoadImage(var_8_0)
	end

	arg_8_0._txtname.text = RougeCollectionConfig.instance:getCollectionName(arg_8_0.collectionId)

	RougeCollectionHelper.loadShapeGrid(arg_8_0.collectionId, arg_8_0.goGridContainer, arg_8_0.goGridItem, arg_8_0.gridItemList)
end

function var_0_0.refreshCost(arg_9_0)
	local var_9_0 = RougeModel.instance:getRougeInfo().coin
	local var_9_1

	if var_9_0 < arg_9_0.price then
		var_9_1 = string.format("<color=#EC6363>%s</color>", arg_9_0.price)
	else
		var_9_1 = arg_9_0.price
	end

	arg_9_0._txtcost.text = var_9_1

	gohelper.setActive(arg_9_0._txtoriginalprice.gameObject, arg_9_0.hasDiscount)

	if arg_9_0.hasDiscount then
		arg_9_0._txtoriginalprice.text = arg_9_0.originalPrice
	end
end

function var_0_0.refreshSellOut(arg_10_0)
	gohelper.setActive(arg_10_0._gosoldout, arg_10_0.eventMo:checkIsSellOut(arg_10_0.pos))
end

function var_0_0.refreshDiscount(arg_11_0)
	gohelper.setActive(arg_11_0._godiscount, arg_11_0.hasDiscount)

	if arg_11_0.hasDiscount then
		arg_11_0._txtdiscount.text = string.format("%+d%%", (arg_11_0.discountRate - 1000) / 10)
	end
end

function var_0_0.show(arg_12_0)
	gohelper.setActive(arg_12_0.go, true)
end

function var_0_0.hide(arg_13_0)
	gohelper.setActive(arg_13_0.go, false)
end

function var_0_0.destroy(arg_14_0)
	arg_14_0._simagecollection:UnLoadImage()
	arg_14_0.click:RemoveClickListener()
	arg_14_0:__onDispose()
end

return var_0_0
