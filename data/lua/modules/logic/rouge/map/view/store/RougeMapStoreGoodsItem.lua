module("modules.logic.rouge.map.view.store.RougeMapStoreGoodsItem", package.seeall)

slot0 = class("RougeMapStoreGoodsItem", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.findChildClickWithDefaultAudio(slot0.go, "click")

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)

	slot0._goenchantlist = gohelper.findChild(slot0.go, "#go_enchantlist")
	slot0._gohole = gohelper.findChild(slot0.go, "#go_enchantlist/#go_hole")
	slot0.goGridContainer = gohelper.findChild(slot0.go, "collection/gridbg")
	slot0.goGridItem = gohelper.findChild(slot0.go, "collection/gridbg/grid")
	slot0._gotagitem = gohelper.findChild(slot0.go, "tags/#go_tagitem")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.go, "collection/#simage_collection")
	slot0._txtname = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._godiscount = gohelper.findChild(slot0.go, "#go_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0.go, "#go_discount/#txt_discount")
	slot0._txtcost = gohelper.findChildText(slot0.go, "layout/#txt_cost")
	slot0._txtoriginalprice = gohelper.findChildText(slot0.go, "layout/#txt_originalprice")
	slot0._gosoldout = gohelper.findChild(slot0.go, "#go_soldout")
	slot0.holeGoList = slot0:getUserDataTb_()
	slot0.gridItemList = slot0:getUserDataTb_()
	slot0.tagGoList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gotagitem, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onBuyGoods, slot0.onBuyGoods, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeInfoCoin, slot0.refreshCost, slot0)
end

function slot0.onBuyGoods(slot0, slot1)
	if slot0.pos == slot1 then
		slot0:refreshSellOut()
	end
end

function slot0.onClickSelf(slot0)
	logNormal("click self")
	ViewMgr.instance:openView(ViewName.RougeStoreGoodsView, {
		collectionId = slot0.collectionId,
		pos = slot0.pos,
		eventMo = slot0.eventMo,
		price = slot0.price
	})
end

function slot0.update(slot0, slot1, slot2, slot3)
	slot0.eventMo = slot1
	slot0.pos = slot2
	slot0.goodsMo = slot3
	slot0.discountRate = slot0.goodsMo.discountRate
	slot0.originalPrice = slot0.goodsMo.originalPrice
	slot0.price = slot0.goodsMo.price
	slot0.collectionId = slot0.goodsMo.collectionId
	slot0.hasDiscount = slot0.discountRate ~= -1 and slot0.discountRate ~= 1000

	slot0:show()
	slot0:refreshHole()
	slot0:refreshTag()
	slot0:refreshCollection()
	slot0:refreshCost()
	slot0:refreshSellOut()
	slot0:refreshDiscount()
end

function slot0.refreshHole(slot0)
	if (RougeCollectionConfig.instance:getCollectionHoleNum(slot0.collectionId) or 0) < 1 then
		gohelper.setActive(slot0._goenchantlist, false)

		return
	end

	for slot5 = 2, slot1 do
		if not slot0.holeGoList[slot5] then
			table.insert(slot0.holeGoList, gohelper.cloneInPlace(slot0._gohole))
		end

		gohelper.setActive(slot6, true)
	end

	for slot5 = slot1 + 1, #slot0.holeGoList do
		gohelper.setActive(slot0.holeGoList[slot5], false)
	end
end

function slot0.refreshTag(slot0)
	RougeCollectionHelper.loadTags(slot0.collectionId, slot0._gotagitem, slot0.tagGoList)
end

function slot0.refreshCollection(slot0)
	if RougeCollectionHelper.getCollectionIconUrl(slot0.collectionId) then
		slot0._simagecollection:LoadImage(slot1)
	end

	slot0._txtname.text = RougeCollectionConfig.instance:getCollectionName(slot0.collectionId)

	RougeCollectionHelper.loadShapeGrid(slot0.collectionId, slot0.goGridContainer, slot0.goGridItem, slot0.gridItemList)
end

function slot0.refreshCost(slot0)
	slot2 = nil
	slot0._txtcost.text = (RougeModel.instance:getRougeInfo().coin >= slot0.price or string.format("<color=#EC6363>%s</color>", slot0.price)) and slot0.price

	gohelper.setActive(slot0._txtoriginalprice.gameObject, slot0.hasDiscount)

	if slot0.hasDiscount then
		slot0._txtoriginalprice.text = slot0.originalPrice
	end
end

function slot0.refreshSellOut(slot0)
	gohelper.setActive(slot0._gosoldout, slot0.eventMo:checkIsSellOut(slot0.pos))
end

function slot0.refreshDiscount(slot0)
	gohelper.setActive(slot0._godiscount, slot0.hasDiscount)

	if slot0.hasDiscount then
		slot0._txtdiscount.text = string.format("%+d%%", (slot0.discountRate - 1000) / 10)
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.destroy(slot0)
	slot0._simagecollection:UnLoadImage()
	slot0.click:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
