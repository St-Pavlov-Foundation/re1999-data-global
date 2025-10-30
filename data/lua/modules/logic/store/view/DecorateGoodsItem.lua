module("modules.logic.store.view.DecorateGoodsItem", package.seeall)

local var_0_0 = class("DecorateGoodsItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._mo = arg_1_2
	arg_1_0._goroot = gohelper.findChild(arg_1_0.go, "root")
	arg_1_0._goselect = gohelper.findChild(arg_1_0._goroot, "#go_select")
	arg_1_0._goselectbuy = gohelper.findChild(arg_1_0._goroot, "#go_selectbuy")
	arg_1_0._goItem = gohelper.findChild(arg_1_0._goroot, "#go_Item")
	arg_1_0._simagebanner = gohelper.findChildSingleImage(arg_1_0._goroot, "#go_Item/#simage_banner")
	arg_1_0._simagerareicon = gohelper.findChildSingleImage(arg_1_0._goroot, "#go_Item/#simage_icon")
	arg_1_0._godeadline = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_deadline")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#go_deadline/#txt_time")
	arg_1_0._godeadlineEffect = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_deadline/#effect")
	arg_1_0._imagetimebg = gohelper.findChildImage(arg_1_0._goroot, "#go_Item/#go_deadline/timebg")
	arg_1_0._imagetimeicon = gohelper.findChildImage(arg_1_0._goroot, "#go_Item/#go_deadline/#txt_time/timeicon")
	arg_1_0._txtformat = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#go_deadline/#txt_time/#txt_format")
	arg_1_0._gonewtag = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_newtag")
	arg_1_0._gotag = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_tag")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_tag/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#go_tag/#go_discount/#txt_discount")
	arg_1_0._godiscount2 = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_tag/#go_discount2")
	arg_1_0._txtdiscount2 = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#go_tag/#go_discount2/#txt_discount")
	arg_1_0._golimit = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_tag/#go_limit")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#go_tag/#go_limit/txt_limit")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._goroot, "#go_Item/#txt_name")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_0._goroot, "#go_soldout")
	arg_1_0._goitemowned = gohelper.findChild(arg_1_0._goroot, "#go_owned")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0._goroot, "#btn_buy")
	arg_1_0._gosingle = gohelper.findChild(arg_1_0._goroot, "#btn_buy/cost/#go_single")
	arg_1_0._txtcurprice = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_single/txt_materialNum")
	arg_1_0._simagesingleicon = gohelper.findChildSingleImage(arg_1_0._goroot, "#btn_buy/cost/#go_single/icon/simage_material")
	arg_1_0._txtoriginalprice = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_single/#txt_original_price")
	arg_1_0._godouble = gohelper.findChild(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice")
	arg_1_0._txtcurprice1 = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	arg_1_0._simagedoubleicon1 = gohelper.findChildSingleImage(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	arg_1_0._txtoriginalprice1 = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price")
	arg_1_0._txtcurprice2 = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	arg_1_0._simagedoubleicon2 = gohelper.findChildSingleImage(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	arg_1_0._txtoriginalprice2 = gohelper.findChildText(arg_1_0._goroot, "#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price")
	arg_1_0._gofree = gohelper.findChild(arg_1_0._goroot, "#btn_buy/cost/#go_free")
	arg_1_0._goclick = gohelper.findChild(arg_1_0._goroot, "#go_click")
	arg_1_0._btnClick = gohelper.getClick(arg_1_0._goclick)
	arg_1_0._goreddot = gohelper.findChild(arg_1_0._goroot, "#go_Item/#go_reddot")

	arg_1_0:_addEvents()
	gohelper.setActive(arg_1_0.go, false)

	arg_1_0._anim = arg_1_0._goroot:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:_refreshUI()
end

function var_0_0._addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
end

function var_0_0._removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0.reset(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	gohelper.setActive(arg_4_0.go, false)
	arg_4_0:_refreshUI()
end

function var_0_0._btnbuyOnClick(arg_5_0)
	if DecorateStoreModel.instance:getCurGood(arg_5_0._mo.belongStoreId) ~= arg_5_0._mo.goodsId then
		arg_5_0:_btnClickOnClick()

		return
	end

	if arg_5_0._mo.config.maxBuyCount > 0 and arg_5_0._mo.buyCount >= arg_5_0._mo.config.maxBuyCount then
		return
	end

	if DecorateStoreModel.instance:isDecorateGoodItemHas(arg_5_0._mo.goodsId) then
		return
	end

	StoreController.instance:openDecorateStoreGoodsView(arg_5_0._mo)
end

function var_0_0._btnClickOnClick(arg_6_0)
	if DecorateStoreModel.instance:getCurGood(arg_6_0._mo.belongStoreId) == arg_6_0._mo.goodsId then
		return
	end

	DecorateStoreModel.instance:setGoodRead(arg_6_0._mo.goodsId)
	DecorateStoreModel.instance:setCurGood(arg_6_0._mo.goodsId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0:_refreshDetail()
	arg_7_0:_refreshCost()
	arg_7_0:_refreshDeadline()
	arg_7_0:_refreshReddot()
end

function var_0_0._refreshDetail(arg_8_0)
	local var_8_0 = DecorateStoreModel.instance:getCurGood(arg_8_0._mo.belongStoreId)

	arg_8_0._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(arg_8_0._mo.goodsId)

	gohelper.setActive(arg_8_0._goselect, arg_8_0._mo.goodsId == var_8_0 and arg_8_0._isFold)
	gohelper.setActive(arg_8_0._goselectbuy, arg_8_0._mo.goodsId == var_8_0 and not arg_8_0._isFold)

	arg_8_0._txtname.text = arg_8_0._mo.config.name

	if arg_8_0._decorateConfig.rare > 0 then
		gohelper.setActive(arg_8_0._simagerareicon.gameObject, true)
		arg_8_0._simagerareicon:LoadImage(ResUrl.getDecorateStoreImg(arg_8_0._decorateConfig.smalllmg))
		arg_8_0._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(string.format("store_decorate_quality_%s", arg_8_0._decorateConfig.rare)))
	else
		arg_8_0._simagebanner:LoadImage(ResUrl.getDecorateStoreImg(arg_8_0._decorateConfig.smalllmg))
	end

	if DecorateStoreModel.instance:isDecorateGoodItemHas(arg_8_0._mo.goodsId) then
		gohelper.setActive(arg_8_0._goitemowned, true)
		gohelper.setActive(arg_8_0._gosoldout, false)
		gohelper.setActive(arg_8_0._godiscount, false)
		gohelper.setActive(arg_8_0._godiscount2, false)
		gohelper.setActive(arg_8_0._gonewtag, false)
		gohelper.setActive(arg_8_0._golimit, false)
		arg_8_0:_refreshNotClick()

		return
	end

	local var_8_1 = arg_8_0._decorateConfig.offTag > 0 and arg_8_0._decorateConfig.offTag or 100

	if var_8_1 > 0 and var_8_1 < 100 then
		gohelper.setActive(arg_8_0._godiscount, true)

		arg_8_0._txtdiscount.text = string.format("-%s%%", var_8_1)
	else
		gohelper.setActive(arg_8_0._godiscount, false)
	end

	if arg_8_0._decorateConfig.onlineTag == 0 then
		gohelper.setActive(arg_8_0._gonewtag, false)
	else
		local var_8_2 = arg_8_0:_isShowReddot()
		local var_8_3 = DecorateStoreModel.instance:isGoodRead(arg_8_0._mo.goodsId)

		gohelper.setActive(arg_8_0._gonewtag, not var_8_3 and not var_8_2)
	end

	if arg_8_0._mo.config.maxBuyCount > 0 and arg_8_0._mo.buyCount >= arg_8_0._mo.config.maxBuyCount then
		gohelper.setActive(arg_8_0._gosoldout, arg_8_0._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
		gohelper.setActive(arg_8_0._goitemowned, arg_8_0._decorateConfig.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.Owned)
	else
		gohelper.setActive(arg_8_0._gosoldout, false)
	end

	local var_8_4 = DecorateStoreModel.instance:getGoodItemLimitTime(arg_8_0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(arg_8_0._mo.goodsId) or 100

	var_8_4 = var_8_4 == 0 and 100 or var_8_4

	if var_8_4 > 0 and var_8_4 < 100 then
		gohelper.setActive(arg_8_0._godiscount, false)
		gohelper.setActive(arg_8_0._godiscount2, true)

		arg_8_0._txtdiscount2.text = string.format("-%s%%", var_8_4)
	else
		gohelper.setActive(arg_8_0._godiscount2, false)
	end

	if string.nilorempty(arg_8_0._decorateConfig.tag1) then
		gohelper.setActive(arg_8_0._golimit, false)
	else
		gohelper.setActive(arg_8_0._golimit, true)

		arg_8_0._txtlimit.text = arg_8_0._decorateConfig.tag1
	end

	arg_8_0:_refreshNotClick()
end

function var_0_0._refreshNotClick(arg_9_0)
	local var_9_0 = (arg_9_0._gosoldout.gameObject.activeSelf or arg_9_0._goitemowned.gameObject.activeSelf) and "#808080" or "#FFFFFF"
	local var_9_1 = GameUtil.parseColor(var_9_0)

	arg_9_0._imagebanner = arg_9_0._imagebanner or gohelper.findChildImage(arg_9_0._goroot, "#go_Item/#simage_banner")
	arg_9_0._imagerareicon = arg_9_0._imagerareicon or gohelper.findChildImage(arg_9_0._goroot, "#go_Item/#simage_icon")
	arg_9_0._imagebanner.color = var_9_1
	arg_9_0._imagerareicon.color = var_9_1
end

function var_0_0._refreshCost(arg_10_0)
	gohelper.setActive(arg_10_0._btnbuy.gameObject, not arg_10_0._isFold)

	local var_10_0 = string.splitToNumber(arg_10_0._mo.config.cost, "#")

	if string.nilorempty(arg_10_0._mo.config.cost) then
		gohelper.setActive(arg_10_0._gosingle, false)
		gohelper.setActive(arg_10_0._godouble, false)
		gohelper.setActive(arg_10_0._gofree, true)

		return
	end

	local var_10_1 = DecorateStoreModel.instance:getGoodItemLimitTime(arg_10_0._mo.goodsId) > 0 and DecorateStoreModel.instance:getGoodDiscount(arg_10_0._mo.goodsId) or 100

	var_10_1 = var_10_1 == 0 and 100 or var_10_1

	gohelper.setActive(arg_10_0._gofree, false)

	if arg_10_0._mo.config.cost2 ~= "" then
		gohelper.setActive(arg_10_0._gosingle, false)
		gohelper.setActive(arg_10_0._godouble, true)

		arg_10_0._txtcurprice1.text = 0.01 * var_10_1 * var_10_0[3]

		if arg_10_0._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(arg_10_0._txtoriginalprice1.gameObject, true)

			arg_10_0._txtoriginalprice1.text = arg_10_0._decorateConfig.originalCost1
		else
			gohelper.setActive(arg_10_0._txtoriginalprice1.gameObject, false)
		end

		local var_10_2, var_10_3 = ItemModel.instance:getItemConfigAndIcon(var_10_0[1], var_10_0[2])

		arg_10_0._simagedoubleicon1:LoadImage(var_10_3)

		local var_10_4 = string.splitToNumber(arg_10_0._mo.config.cost2, "#")

		arg_10_0._txtcurprice2.text = 0.01 * var_10_1 * var_10_4[3]

		if arg_10_0._decorateConfig.originalCost2 > 0 then
			gohelper.setActive(arg_10_0._txtoriginalprice2.gameObject, true)

			arg_10_0._txtoriginalprice2.text = arg_10_0._decorateConfig.originalCost2
		else
			gohelper.setActive(arg_10_0._txtoriginalprice2.gameObject, false)
		end

		local var_10_5, var_10_6 = ItemModel.instance:getItemConfigAndIcon(var_10_4[1], var_10_4[2])

		arg_10_0._simagedoubleicon2:LoadImage(var_10_6)
	else
		gohelper.setActive(arg_10_0._gosingle, true)
		gohelper.setActive(arg_10_0._godouble, false)

		arg_10_0._txtcurprice.text = 0.01 * var_10_1 * var_10_0[3]

		if arg_10_0._decorateConfig.originalCost1 > 0 then
			gohelper.setActive(arg_10_0._txtoriginalprice.gameObject, true)

			arg_10_0._txtoriginalprice.text = arg_10_0._decorateConfig.originalCost1
		else
			gohelper.setActive(arg_10_0._txtoriginalprice.gameObject, false)
		end

		local var_10_7, var_10_8 = ItemModel.instance:getItemConfigAndIcon(var_10_0[1], var_10_0[2])

		arg_10_0._simagesingleicon:LoadImage(var_10_8)
	end
end

function var_0_0._isShowReddot(arg_11_0)
	local var_11_0 = StoreModel.instance:isTabSecondRedDotShow(arg_11_0._mo.belongStoreId)
	local var_11_1 = string.nilorempty(arg_11_0._mo.config.cost)
	local var_11_2 = arg_11_0._mo.config.maxBuyCount > 0 and arg_11_0._mo.buyCount >= arg_11_0._mo.config.maxBuyCount

	return var_11_0 and var_11_1 and not var_11_2
end

function var_0_0._refreshDeadline(arg_12_0)
	local var_12_0 = arg_12_0:_isShowReddot()
	local var_12_1 = DecorateStoreModel.instance:isGoodRead(arg_12_0._mo.goodsId)

	if var_12_0 or not var_12_1 then
		gohelper.setActive(arg_12_0._godeadline, false)

		return
	end

	local var_12_2 = 0
	local var_12_3 = false

	if not string.nilorempty(arg_12_0._mo.config.offlineTime) and type(arg_12_0._mo.config.offlineTime) == "string" then
		local var_12_4 = TimeUtil.stringToTimestamp(arg_12_0._mo.config.offlineTime) - ServerTime.now()

		var_12_2 = var_12_4 > 0 and var_12_4 or 0
	end

	local var_12_5 = var_12_2 > 0 and var_12_2 < TimeUtil.OneWeekSecond

	if var_12_5 then
		local var_12_6

		arg_12_0._txttime.text, arg_12_0._txtformat.text, var_12_6 = TimeUtil.secondToRoughTime(math.floor(var_12_2), true)

		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txttime, var_12_6 and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._txtformat, var_12_6 and "#98D687" or "#E99B56")
		gohelper.setActive(arg_12_0._godeadlineEffect, not var_12_6)
		UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imagetimebg, var_12_6 and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(arg_12_0._imagetimeicon, var_12_6 and "daojishiicon_01" or "daojishiicon_02")
	end

	gohelper.setActive(arg_12_0._godeadline, var_12_5)
end

function var_0_0.playIn(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 or not arg_13_1 then
		arg_13_0:_startPlayIn(true)

		return
	end

	arg_13_0._index = arg_13_1

	if arg_13_0._isFold then
		arg_13_0:_startPlayIn()

		return
	end

	TaskDispatcher.runDelay(arg_13_0._startPlayIn, arg_13_0, 0.03 * math.ceil(arg_13_0._index / 4))
end

function var_0_0.playOut(arg_14_0)
	arg_14_0._anim:Play("out", 0, 0)
end

function var_0_0._startPlayIn(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0.go, true)

	if not arg_15_1 then
		arg_15_0._anim:Play("in", 0, 0)
	end
end

function var_0_0.setFold(arg_16_0, arg_16_1)
	arg_16_0._isFold = arg_16_1

	arg_16_0:_refreshUI()
end

function var_0_0._refreshReddot(arg_17_0)
	local var_17_0 = arg_17_0:_isShowReddot()

	gohelper.setActive(arg_17_0._goreddot, var_17_0)
end

function var_0_0.hide(arg_18_0)
	gohelper.setActive(arg_18_0.go, false)
end

function var_0_0.destroy(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._startPlayIn, arg_19_0)
	arg_19_0:_removeEvents()
end

return var_0_0
