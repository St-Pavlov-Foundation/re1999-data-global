module("modules.logic.store.view.StoreLinkGiftGoodsView", package.seeall)

local var_0_0 = class("StoreLinkGiftGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "view/common/title/#txt_goodsNameCn")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/common/#btn_buy")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "view/common/#btn_buy/cost/#txt_materialNum")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "view/common/#btn_buy/cost/#txt_price")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "view/common/#go_hasget")
	arg_1_0._goleftbg = gohelper.findChild(arg_1_0.viewGO, "view/normal/remain/#go_leftbg")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "view/normal/remain/#go_leftbg/#txt_remain")
	arg_1_0._gorightbg = gohelper.findChild(arg_1_0.viewGO, "view/normal/remain/#go_rightbg")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "view/normal/remain/#go_rightbg/#txt_remaintime")
	arg_1_0._txtgoodsUseDesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._simagerewardIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/normal/reward/right/hasget/#simage_rewardIcon")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/#btn_close")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_4_0)
	if StoreConfig.instance:hasNextGood(arg_4_0._mo.id) then
		StoreModel.instance:setCurBuyPackageId(arg_4_0._mo.id)
	end

	if arg_4_0._mo.isChargeGoods then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
		PayController.instance:startPay(arg_4_0._mo.goodsId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

		if arg_4_0._costType == MaterialEnum.MaterialType.Currency and arg_4_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			if CurrencyController.instance:checkFreeDiamondEnough(arg_4_0._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_4_0._buyGoods, arg_4_0, arg_4_0.closeThis, arg_4_0) then
				arg_4_0:_buyGoods()
			end
		elseif arg_4_0._costType == MaterialEnum.MaterialType.Currency and arg_4_0._costId == CurrencyEnum.CurrencyType.Diamond then
			if CurrencyController.instance:checkDiamondEnough(arg_4_0._costQuantity, arg_4_0.closeThis, arg_4_0) then
				arg_4_0:_buyGoods()
			end
		else
			arg_4_0:_buyGoods()
		end
	end
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._gonormal = gohelper.findChild(arg_6_0.viewGO, "view/normal")
	arg_6_0._goremain = gohelper.findChild(arg_6_0._gonormal, "info/remain")
	arg_6_0._gotxtgoodsDesc = gohelper.findChild(arg_6_0.viewGO, "view/normal/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_6_0._imagematerial = gohelper.findChildImage(arg_6_0.viewGO, "view/common/#btn_buy/cost/simage_material")
	arg_6_0._txtnum = gohelper.findChildText(arg_6_0.viewGO, "view/left/num1/txt_num")
	arg_6_0._txtnum2 = gohelper.findChildText(arg_6_0.viewGO, "view/left/num2/txt_num")
	arg_6_0._txtnum3 = gohelper.findChildText(arg_6_0.viewGO, "view/left/num3/txt_num")
	arg_6_0._gonum = gohelper.findChild(arg_6_0.viewGO, "view/left/num1")
	arg_6_0._gonum2 = gohelper.findChild(arg_6_0.viewGO, "view/left/num2")
	arg_6_0._gonum3 = gohelper.findChild(arg_6_0.viewGO, "view/left/num3")
	arg_6_0._goimagedec = gohelper.findChild(arg_6_0.viewGO, "view/left/image_dec")
	arg_6_0._simageicon = gohelper.findChildSingleImage(arg_6_0.viewGO, "view/left/simage_icon")
	arg_6_0._imageicon = gohelper.findChildImage(arg_6_0.viewGO, "view/left/simage_icon")
	arg_6_0._goleftIcon = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/left/normal/#simage_leftIcon")
	arg_6_0._gotxtnormal = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/left/normal/txt_normal")
	arg_6_0._gorightIcon = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/right/lock/#simage_rightIcon")
	arg_6_0._golefthasget = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/left/hasget")
	arg_6_0._gofigithasget = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/right/hasget")
	arg_6_0._txtlock = gohelper.findChildText(arg_6_0.viewGO, "view/normal/reward/right/lock/txt_lock")
	arg_6_0._golockicon = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/right/lock/lockicon")
	arg_6_0._golockBg = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/right/lock/bg")
	arg_6_0._gounlockBg = gohelper.findChild(arg_6_0.viewGO, "view/normal/reward/right/lock/unlockbg")

	gohelper.setActive(arg_6_0._txtgoodsDesc, false)
	gohelper.setActive(arg_6_0._txtgoodsUseDesc, false)

	arg_6_0._canvasGroup = gohelper.onceAddComponent(arg_6_0._gorightIcon, typeof(UnityEngine.CanvasGroup))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_8_0._payFinished, arg_8_0)

	arg_8_0._mo = arg_8_0.viewParam

	arg_8_0:_refreshPriceArea()
	arg_8_0:_updateNormal()
	StoreController.instance:statOpenChargeGoods(arg_8_0._mo.belongStoreId, arg_8_0._mo.config)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageicon:UnLoadImage()
end

function var_0_0._payFinished(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0._updateNormal(arg_12_0)
	local var_12_0 = arg_12_0._mo:isLevelOpen()
	local var_12_1 = arg_12_0._mo.maxBuyCount > arg_12_0._mo.buyCount
	local var_12_2 = arg_12_0._mo.buyCount > 0
	local var_12_3 = StoreCharageConditionalHelper.isCharageCondition(arg_12_0._mo.id)
	local var_12_4 = StoreCharageConditionalHelper.isCharageTaskNotFinish(arg_12_0._mo.id)
	local var_12_5 = StoreConfig.instance:getChargeConditionalConfig(arg_12_0._mo.config.taskid)
	local var_12_6 = var_12_5.bigImg2
	local var_12_7 = true

	gohelper.setActive(arg_12_0._btnbuy, var_12_0 and var_12_1)
	gohelper.setActive(arg_12_0._gohasget, not var_12_1)
	gohelper.setActive(arg_12_0._gotxtnormal, var_12_1)
	gohelper.setActive(arg_12_0._golefthasget, var_12_2)
	gohelper.setActive(arg_12_0._goleftTxt, not var_12_2)
	gohelper.setActive(arg_12_0._golockicon, not var_12_3)
	gohelper.setActive(arg_12_0._golockBg, not var_12_3)
	gohelper.setActive(arg_12_0._gounlockBg, var_12_3)
	gohelper.setActive(arg_12_0._gofigithasget, not var_12_4)
	gohelper.setActive(arg_12_0._txtlock, var_12_4)

	arg_12_0._txtgoodsNameCn.text = arg_12_0._mo.config.name

	if var_12_3 then
		arg_12_0._txtlock.text = luaLang("store_linkfigt_getitnow_txt")
	else
		arg_12_0._txtlock.text = var_12_5 and var_12_5.conDesc
	end

	arg_12_0._canvasGroup.alpha = var_12_3 and 1 or 0.5

	arg_12_0._simageicon:LoadImage(ResUrl.getStorePackageIcon(var_12_6), arg_12_0._onIconLoadFinish, arg_12_0)

	if arg_12_0._mo.offlineTime > 0 then
		local var_12_8 = math.floor(arg_12_0._mo.offlineTime - ServerTime.now())

		arg_12_0._txtremaintime.text = string.format("%s%s", TimeUtil.secondToRoughTime(var_12_8))
	end

	arg_12_0:_updateNormalPackCommon(arg_12_0._goleftbg, arg_12_0._txtremain, arg_12_0._goremain)

	local var_12_9 = arg_12_0._mo.config.detailDesc
	local var_12_10 = string.split(var_12_9, "\n")

	gohelper.CreateObjList(arg_12_0, arg_12_0._onDescItemShow, var_12_10, nil, arg_12_0._gotxtgoodsDesc)

	local var_12_11 = arg_12_0._mo.config.product and GameUtil.splitString2(arg_12_0._mo.config.product, true)
	local var_12_12 = var_12_5 and GameUtil.splitString2(var_12_5.bonus, true)

	gohelper.setActive(arg_12_0._gonum, var_12_7)
	gohelper.setActive(arg_12_0._gonum2, var_12_7)
	gohelper.setActive(arg_12_0._goimagedec, var_12_7)
	gohelper.setActive(arg_12_0._gonum3, not var_12_7)

	if var_12_7 then
		arg_12_0._txtnum.text = arg_12_0:_getNumStr(arg_12_0:_getRewardCount(var_12_11))
		arg_12_0._txtnum2.text = arg_12_0:_getNumStr(arg_12_0:_getRewardCount(var_12_12))
	else
		arg_12_0._txtnum3.text = arg_12_0:_getNumStr(arg_12_0:_getRewardCount(var_12_12) + arg_12_0:_getRewardCount(var_12_11))
	end

	arg_12_0._iconItemList = arg_12_0._iconItemList or arg_12_0:getUserDataTb_()
	arg_12_0._iconItem2List = arg_12_0._iconItem2List or arg_12_0:getUserDataTb_()

	arg_12_0:_setIconBouns(arg_12_0._iconItemList, var_12_11, arg_12_0._goleftIcon)
	arg_12_0:_setIconBouns(arg_12_0._iconItem2List, var_12_12, arg_12_0._gorightIcon)
end

function var_0_0._getNumStr(arg_13_0, arg_13_1)
	return string.format("×<size=32>%s", arg_13_1)
end

function var_0_0._onIconLoadFinish(arg_14_0)
	arg_14_0._imageicon:SetNativeSize()
end

function var_0_0._onDescItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	gohelper.findChildText(arg_15_1, "").text = arg_15_2
end

function var_0_0._refreshPriceArea(arg_16_0)
	local var_16_0 = arg_16_0._mo.cost

	gohelper.setActive(arg_16_0._txtprice.gameObject, arg_16_0._mo.config.originalCost > 0)

	if string.nilorempty(var_16_0) or var_16_0 == 0 then
		arg_16_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_16_0._imagematerial, false)
	elseif arg_16_0._mo.isChargeGoods then
		arg_16_0._txtmaterialNum.text = StoreModel.instance:getCostPriceFull(arg_16_0._mo.id)
		arg_16_0._txtprice.text = StoreModel.instance:getOriginCostPriceFull(arg_16_0._mo.id)

		gohelper.setActive(arg_16_0._imagematerial, false)
	else
		local var_16_1 = GameUtil.splitString2(var_16_0, true)
		local var_16_2 = var_16_1[arg_16_0._mo.buyCount + 1] or var_16_1[#var_16_1]

		arg_16_0._costType = var_16_2[1]
		arg_16_0._costId = var_16_2[2]
		arg_16_0._costQuantity = var_16_2[3]

		local var_16_3, var_16_4 = ItemModel.instance:getItemConfigAndIcon(arg_16_0._costType, arg_16_0._costId)
		local var_16_5 = var_16_3.icon
		local var_16_6 = string.format("%s_1", var_16_5)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imagematerial, var_16_6)

		arg_16_0._txtmaterialNum.text = arg_16_0._costQuantity
		arg_16_0._txtprice.text = arg_16_0._mo.config.originalCost

		gohelper.setActive(arg_16_0._imagematerial, true)

		if ItemModel.instance:getItemQuantity(arg_16_0._costType, arg_16_0._costId) >= arg_16_0._costQuantity then
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtmaterialNum, "#393939")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._txtmaterialNum, "#bf2e11")
		end
	end
end

function var_0_0._getRewardCount(arg_17_0, arg_17_1)
	local var_17_0 = 0

	if arg_17_1 and #arg_17_1 > 0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
			if iter_17_1 and #iter_17_1 >= 2 then
				var_17_0 = var_17_0 + iter_17_1[3]
			end
		end
	end

	return var_17_0
end

function var_0_0._updateNormalPackCommon(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0._mo.maxBuyCount
	local var_18_1 = var_18_0 - arg_18_0._mo.buyCount
	local var_18_2

	if arg_18_0._mo.isChargeGoods then
		var_18_2 = StoreConfig.instance:getChargeRemainText(var_18_0, arg_18_0._mo.refreshTime, var_18_1, arg_18_0._mo.offlineTime)
	else
		var_18_2 = StoreConfig.instance:getRemainText(var_18_0, arg_18_0._mo.refreshTime, var_18_1, arg_18_0._mo.offlineTime)
	end

	if string.nilorempty(var_18_2) then
		gohelper.setActive(arg_18_1, false)
		gohelper.setActive(arg_18_2.gameObject, false)
		gohelper.setActive(arg_18_3, arg_18_0._mo.offlineTime > 0)
	else
		gohelper.setActive(arg_18_1, true)
		gohelper.setActive(arg_18_2.gameObject, true)

		arg_18_2.text = var_18_2
	end
end

function var_0_0._get2GOList(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getUserDataTb_()

	table.insert(var_19_0, arg_19_1)
	table.insert(var_19_0, arg_19_2)

	return var_19_0
end

function var_0_0._setIconBouns(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if not arg_20_2 then
		return
	end

	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_2) do
		if iter_20_1 and #iter_20_1 >= 2 then
			var_20_0 = var_20_0 + 1

			local var_20_1 = arg_20_1[var_20_0]

			if not var_20_1 then
				var_20_1 = IconMgr.instance:getCommonItemIcon(arg_20_3)

				table.insert(arg_20_1, var_20_1)
			end

			local var_20_2 = iter_20_1[1]
			local var_20_3 = iter_20_1[2]
			local var_20_4 = iter_20_1[3] or 0

			arg_20_0:_setIcon(var_20_1, var_20_2, var_20_3, var_20_4)
		end
	end
end

function var_0_0._setIcon(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_1:setMOValue(arg_21_2, arg_21_3, arg_21_4, nil, true)
	arg_21_1:setCantJump(true)
	arg_21_1:setCountFontSize(36)
	arg_21_1:setScale(0.7)
	arg_21_1:SetCountLocalY(43.6)
	arg_21_1:SetCountBgHeight(25)
end

function var_0_0._buyCallback(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 == 0 then
		arg_22_0:closeThis()
	end
end

function var_0_0._payFinished(arg_23_0)
	arg_23_0:closeThis()
end

return var_0_0
