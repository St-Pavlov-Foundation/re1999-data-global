module("modules.logic.store.view.DecorateGoodsItem", package.seeall)

slot0 = class("DecorateGoodsItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._mo = slot2
	slot0._goroot = gohelper.findChild(slot0.go, "root")
	slot0._goselect = gohelper.findChild(slot0._goroot, "#go_select")
	slot0._goselectbuy = gohelper.findChild(slot0._goroot, "#go_selectbuy")
	slot0._goItem = gohelper.findChild(slot0._goroot, "#go_Item")
	slot0._simagebanner = gohelper.findChildSingleImage(slot0._goroot, "#go_Item/#simage_banner")
	slot0._simagerareicon = gohelper.findChildSingleImage(slot0._goroot, "#go_Item/#simage_icon")
	slot0._gonewtag = gohelper.findChild(slot0._goroot, "#go_Item/#go_newtag")
	slot0._gotag = gohelper.findChild(slot0._goroot, "#go_Item/#go_tag")
	slot0._godiscount = gohelper.findChild(slot0._goroot, "#go_Item/#go_tag/#go_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0._goroot, "#go_Item/#go_tag/#go_discount/#txt_discount")
	slot0._godiscount2 = gohelper.findChild(slot0._goroot, "#go_Item/#go_tag/#go_discount2")
	slot0._txtdiscount2 = gohelper.findChildText(slot0._goroot, "#go_Item/#go_tag/#go_discount2/#txt_discount")
	slot0._golimit = gohelper.findChild(slot0._goroot, "#go_Item/#go_tag/#go_limit")
	slot0._txtlimit = gohelper.findChildText(slot0._goroot, "#go_Item/#go_tag/#go_limit/txt_limit")
	slot0._txtname = gohelper.findChildText(slot0._goroot, "#go_Item/#txt_name")
	slot0._gosoldout = gohelper.findChild(slot0._goroot, "#go_soldout")
	slot0._goitemowned = gohelper.findChild(slot0._goroot, "#go_owned")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0._goroot, "#btn_buy")
	slot0._gosingle = gohelper.findChild(slot0._goroot, "#btn_buy/cost/#go_single")
	slot0._txtcurprice = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_single/txt_materialNum")
	slot0._simagesingleicon = gohelper.findChildSingleImage(slot0._goroot, "#btn_buy/cost/#go_single/icon/simage_material")
	slot0._txtoriginalprice = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_single/#txt_original_price")
	slot0._godouble = gohelper.findChild(slot0._goroot, "#btn_buy/cost/#go_doubleprice")
	slot0._txtcurprice1 = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	slot0._simagedoubleicon1 = gohelper.findChildSingleImage(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	slot0._txtoriginalprice1 = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price")
	slot0._txtcurprice2 = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	slot0._simagedoubleicon2 = gohelper.findChildSingleImage(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	slot0._txtoriginalprice2 = gohelper.findChildText(slot0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price")
	slot0._gofree = gohelper.findChild(slot0._goroot, "#btn_buy/cost/#go_free")
	slot0._goclick = gohelper.findChild(slot0._goroot, "#go_click")
	slot0._btnClick = gohelper.getClick(slot0._goclick)
	slot0._goreddot = gohelper.findChild(slot0._goroot, "#go_Item/#go_reddot")

	slot0:_addEvents()
	gohelper.setActive(slot0.go, false)

	slot0._anim = slot0._goroot:GetComponent(typeof(UnityEngine.Animator))

	slot0:_refreshUI()
end

function slot0._addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnClick:AddClickListener(slot0._btnClickOnClick, slot0)
end

function slot0._removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._btnClick:RemoveClickListener()
end

function slot0.reset(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0.go, false)
	slot0:_refreshUI()
end

function slot0._btnbuyOnClick(slot0)
	if DecorateStoreModel.instance:getCurGood(slot0._mo.belongStoreId) ~= slot0._mo.goodsId then
		slot0:_btnClickOnClick()

		return
	end

	if slot0._mo.config.maxBuyCount > 0 and slot0._mo.config.maxBuyCount <= slot0._mo.buyCount then
		return
	end

	if DecorateStoreModel.instance:isDecorateGoodItemHas(slot0._mo.goodsId) then
		return
	end

	StoreController.instance:openDecorateStoreGoodsView(slot0._mo)
end

function slot0._btnClickOnClick(slot0)
	if DecorateStoreModel.instance:getCurGood(slot0._mo.belongStoreId) == slot0._mo.goodsId then
		return
	end

	DecorateStoreModel.instance:setGoodRead(slot0._mo.goodsId)
	DecorateStoreModel.instance:setCurGood(slot0._mo.goodsId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0._refreshUI(slot0)
	slot0:_refreshDetail()
	slot0:_refreshCost()
	slot0:_refreshReddot()
end

function slot0._refreshDetail(slot0)
	slot0._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(slot0._mo.goodsId)

	gohelper.setActive(slot0._goselect, slot0._mo.goodsId == DecorateStoreModel.instance:getCurGood(slot0._mo.belongStoreId) and slot0._isFold)
	gohelper.setActive(slot0._goselectbuy, slot0._mo.goodsId == slot1 and not slot0._isFold)

	slot0._txtname.text = slot0._mo.config.name

	if slot0._decorateConfig.rare > 0 then
		gohelper.setActive(slot0._simagerareicon.gameObject, true)
		slot0._simagerareicon:LoadImage(ResUrl.getDecorateStoreImg(slot0._decorateConfig.smalllmg))
		slot0._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(string.format("store_decorate_quality_%s", slot0._decorateConfig.rare)))
	else
		slot0._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(slot0._decorateConfig.smalllmg))
	end

	if DecorateStoreModel.instance:isDecorateGoodItemHas(slot0._mo.goodsId) then
		gohelper.setActive(slot0._goitemowned, true)
		gohelper.setActive(slot0._gosoldout, false)
		gohelper.setActive(slot0._godiscount, false)
		gohelper.setActive(slot0._godiscount2, false)
		gohelper.setActive(slot0._gonewtag, false)
		gohelper.setActive(slot0._golimit, false)
		slot0:_refreshNotClick()

		return
	end

	if (slot0._decorateConfig.offTag > 0 and slot0._decorateConfig.offTag or 100) > 0 and slot3 < 100 then
		gohelper.setActive(slot0._godiscount, true)

		slot0._txtdiscount.text = string.format("-%s%%", slot3)
	else
		gohelper.setActive(slot0._godiscount, false)
	end

	if slot0._decorateConfig.onlineTag == 0 then
		gohelper.setActive(slot0._gonewtag, false)
	else
		gohelper.setActive(slot0._gonewtag, not DecorateStoreModel.instance:isGoodRead(slot0._mo.goodsId))
	end

	if slot0._mo.config.maxBuyCount > 0 and slot0._mo.config.maxBuyCount <= slot0._mo.buyCount then
		gohelper.setActive(slot0._gosoldout, slot0._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
		gohelper.setActive(slot0._goitemowned, slot0._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.Owned)
	else
		gohelper.setActive(slot0._gosoldout, false)
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot0._mo.goodsId) or 100) == 0 then
		slot5 = 100
	end

	if slot5 > 0 and slot5 < 100 then
		gohelper.setActive(slot0._godiscount, false)
		gohelper.setActive(slot0._godiscount2, true)

		slot0._txtdiscount2.text = string.format("-%s%%", slot5)
	else
		gohelper.setActive(slot0._godiscount2, false)
	end

	if string.nilorempty(slot0._decorateConfig.tag1) then
		gohelper.setActive(slot0._golimit, false)
	else
		gohelper.setActive(slot0._golimit, true)

		slot0._txtlimit.text = slot0._decorateConfig.tag1
	end

	slot0:_refreshNotClick()
end

function slot0._refreshNotClick(slot0)
	slot3 = GameUtil.parseColor((slot0._gosoldout.gameObject.activeSelf or slot0._goitemowned.gameObject.activeSelf) and "#808080" or "#FFFFFF")
	slot0._imagebanner = slot0._imagebanner or gohelper.findChildImage(slot0._goroot, "#go_Item/#simage_banner")
	slot0._imagerareicon = slot0._imagerareicon or gohelper.findChildImage(slot0._goroot, "#go_Item/#simage_icon")
	slot0._imagebanner.color = slot3
	slot0._imagerareicon.color = slot3
end

function slot0._refreshCost(slot0)
	gohelper.setActive(slot0._btnbuy.gameObject, not slot0._isFold)

	slot1 = string.splitToNumber(slot0._mo.config.cost, "#")

	if string.nilorempty(slot0._mo.config.cost) then
		gohelper.setActive(slot0._gosingle, false)
		gohelper.setActive(slot0._godouble, false)
		gohelper.setActive(slot0._gofree, true)

		return
	end

	if (DecorateStoreModel.instance:getGoodItemLimitTime(slot0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(slot0._mo.goodsId) or 100) == 0 then
		slot3 = 100
	end

	gohelper.setActive(slot0._gofree, false)

	if slot0._mo.config.cost2 ~= "" then
		gohelper.setActive(slot0._gosingle, false)
		gohelper.setActive(slot0._godouble, true)

		slot0._txtcurprice1.text = 0.01 * slot3 * slot1[3]

		if slot0._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalprice1.gameObject, true)

			slot0._txtoriginalprice1.text = slot0._decorateConfig.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalprice1.gameObject, false)
		end

		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

		slot0._simagedoubleicon1:LoadImage(slot5)

		slot0._txtcurprice2.text = 0.01 * slot3 * string.splitToNumber(slot0._mo.config.cost2, "#")[3]

		if slot0._decorateConfig.originalCost2 > 0 then
			gohelper.setActive(slot0._txtoriginalprice2.gameObject, true)

			slot0._txtoriginalprice2.text = slot0._decorateConfig.originalCost2
		else
			gohelper.setActive(slot0._txtoriginalprice2.gameObject, false)
		end

		slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot6[1], slot6[2])

		slot0._simagedoubleicon2:LoadImage(slot8)
	else
		gohelper.setActive(slot0._gosingle, true)
		gohelper.setActive(slot0._godouble, false)

		slot0._txtcurprice.text = 0.01 * slot3 * slot1[3]

		if slot0._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(slot0._txtoriginalprice.gameObject, true)

			slot0._txtoriginalprice.text = slot0._decorateConfig.originalCost1
		else
			gohelper.setActive(slot0._txtoriginalprice.gameObject, false)
		end

		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

		slot0._simagesingleicon:LoadImage(slot5)
	end
end

function slot0.playIn(slot0, slot1, slot2)
	if slot2 or not slot1 then
		slot0:_startPlayIn(true)

		return
	end

	slot0._index = slot1

	if slot0._isFold then
		slot0:_startPlayIn()

		return
	end

	TaskDispatcher.runDelay(slot0._startPlayIn, slot0, 0.03 * math.ceil(slot0._index / 4))
end

function slot0.playOut(slot0)
	slot0._anim:Play("out", 0, 0)
end

function slot0._startPlayIn(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	if not slot1 then
		slot0._anim:Play("in", 0, 0)
	end
end

function slot0.setFold(slot0, slot1)
	slot0._isFold = slot1

	slot0:_refreshUI()
end

function slot0._refreshReddot(slot0)
	gohelper.setActive(slot0._goreddot, StoreModel.instance:isTabSecondRedDotShow(slot0._mo.belongStoreId) and string.nilorempty(slot0._mo.config.cost) and not DecorateStoreModel.instance:isDecorateGoodItemHas(slot0._mo.goodsId))
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0._startPlayIn, slot0)
	slot0:_removeEvents()
end

return slot0
