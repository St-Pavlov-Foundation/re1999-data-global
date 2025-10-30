module("modules.logic.store.view.recommend.StoreMonthCardView", package.seeall)

local var_0_0 = class("StoreMonthCardView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagegoods = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_goods")
	arg_1_0._txtlefttimetips = gohelper.findChildText(arg_1_0.viewGO, "view/#txt_lefttimetips")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "view/layout/#txt_title1")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "view/layout/#txt_title2")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "view/#txt_dec")
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "view/#txt_titleen")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/tips/tips1/#simage_icon1")
	arg_1_0._txttipnum1 = gohelper.findChildText(arg_1_0.viewGO, "view/tips/tips1/#txt_tipnum1")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/tips/tips2/#simage_icon2")
	arg_1_0._txttipnum2 = gohelper.findChildText(arg_1_0.viewGO, "view/tips/tips2/#txt_tipnum2")
	arg_1_0._simageicon3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/tips/tips3/#simage_icon3")
	arg_1_0._txttipnum3 = gohelper.findChildText(arg_1_0.viewGO, "view/tips/tips3/#txt_tipnum3")
	arg_1_0._simageicon4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/tips/tips4/#simage_icon1")
	arg_1_0._txttipnum4 = gohelper.findChildText(arg_1_0.viewGO, "view/tips/tips4/#txt_tipnum1")
	arg_1_0._golimittime = gohelper.findChild(arg_1_0.viewGO, "view/tips/tips3/#go_limittime")
	arg_1_0._imglimittime = gohelper.findChildImage(arg_1_0.viewGO, "view/tips/tips3/#go_limittime")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/buy/#btn_buy")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_cost")
	arg_1_0._txtcosticon = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_cost/costicon")
	arg_1_0._txtgoodstips = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_goodstips")
	arg_1_0._gomooncardup = gohelper.findChild(arg_1_0.viewGO, "view/#go_mooncardup")
	arg_1_0._txtcosthw = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_cost_hw")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._btnbuyOnClick(arg_4_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "711",
		[StatEnum.EventProperties.RecommendPageName] = "月历",
		[StatEnum.EventProperties.RecommendPageRank] = arg_4_0:getTabIndex()
	})

	local var_4_0 = string.splitToNumber(arg_4_0.config.systemJumpCode, "#")

	if var_4_0[2] then
		local var_4_1 = var_4_0[2]
		local var_4_2 = StoreModel.instance:getGoodsMO(var_4_1)

		StoreController.instance:openPackageStoreGoodsView(var_4_2)
	else
		arg_4_0.viewContainer.storeView:_refreshTabs(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
		StoreController.instance:statSwitchStore(StoreEnum.StoreId.Package)
	end
end

function var_0_0.onWenHaoClick(arg_5_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.godecorate = gohelper.findChild(arg_6_0.viewGO, "view/decorateicon")
	arg_6_0.wenhaoClick = gohelper.getClick(arg_6_0.godecorate)

	arg_6_0.wenhaoClick:AddClickListener(arg_6_0.onWenHaoClick, arg_6_0)

	arg_6_0._simageBg = gohelper.findChildSingleImage(arg_6_0.viewGO, "view/#simage_bg")
	arg_6_0._bgClick = gohelper.getClick(arg_6_0._simageBg.gameObject)

	gohelper.addUIClickAudio(arg_6_0._bgClick.gameObject, AudioEnum.UI.play_ui_common_pause)
	arg_6_0._simagegoods:LoadImage(ResUrl.getStoreBottomBgIcon("img_calendar"))
	arg_6_0._simageBg:LoadImage(ResUrl.getStoreBottomBgIcon("deco"))
	arg_6_0._bgClick:AddClickListener(arg_6_0._btnbuyOnClick, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, arg_6_0.onMonthCardInfoChange, arg_6_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_6_0.onDailyRefresh, arg_6_0)

	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)
	arg_6_0._txtgoodstips.text = luaLang("storemonthcard_tips")
	arg_6_0._txtcost.text = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	arg_6_0._txtcosticon.text = PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)

	local var_6_0 = PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)
	local var_6_1, var_6_2 = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	local var_6_3 = ""

	if string.nilorempty(var_6_0) then
		local var_6_4 = string.reverse(var_6_2)
		local var_6_5 = string.find(var_6_4, "%d")
		local var_6_6 = string.len(var_6_4) - var_6_5 + 1
		local var_6_7 = string.sub(var_6_2, var_6_6 + 1, string.len(var_6_2))

		var_6_2 = string.sub(var_6_2, 1, var_6_6)
		arg_6_0._txtcosthw.text = string.format("%s<size=30>%s</size>", var_6_2, var_6_7)
	else
		arg_6_0._txtcosthw.text = string.format("<size=30>%s</size>%s", var_6_0, var_6_2)
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.monthCardInfo = StoreModel.instance:getMonthCardInfo()
	arg_8_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.MonthCardId)

	arg_8_0:refreshUI()
	var_0_0.super.onOpen(arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshRemainDay()
	arg_9_0:refreshRewardIcon()

	local var_9_0 = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(arg_9_0._gomooncardup, var_9_0)
end

function var_0_0.refreshRemainDay(arg_10_0)
	if arg_10_0.monthCardInfo ~= nil then
		local var_10_0 = arg_10_0.monthCardInfo:getRemainDay()

		if var_10_0 == StoreEnum.MonthCardStatus.NotPurchase then
			arg_10_0._txtlefttimetips.text = luaLang("not_purchase")
		elseif var_10_0 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			arg_10_0._txtlefttimetips.text = luaLang("not_enough_one_day") .. (arg_10_0.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
		else
			arg_10_0._txtlefttimetips.text = formatLuaLang("remain_day", var_10_0) .. (arg_10_0.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
		end
	else
		arg_10_0._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function var_0_0.refreshRewardIcon(arg_11_0)
	local var_11_0 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local var_11_1, var_11_2 = arg_11_0:getIconUrlAndQuantity(string.split(var_11_0.onceBonus, "|")[1])
	local var_11_3, var_11_4 = arg_11_0:getIconUrlAndQuantity(string.split(var_11_0.onceBonus, "|")[2])
	local var_11_5, var_11_6 = arg_11_0:getIconUrlAndQuantity(string.split(var_11_0.dailyBonus, "|")[1])
	local var_11_7 = string.split(var_11_0.dailyBonus, "|")[2]
	local var_11_8 = string.split(var_11_7, "#")
	local var_11_9, var_11_10 = ItemModel.instance:getItemConfigAndIcon(var_11_8[1], var_11_8[2])

	arg_11_0._txttipnum1.text = luaLang("multiple") .. var_11_2

	arg_11_0._simageicon1:LoadImage(var_11_1)

	arg_11_0._txttipnum2.text = luaLang("multiple") .. var_11_6 * 30

	arg_11_0._simageicon2:LoadImage(var_11_5)

	arg_11_0._txttipnum3.text = luaLang("multiple") .. var_11_8[3] * 30

	arg_11_0._simageicon3:LoadImage(var_11_10)

	arg_11_0._txttipnum4.text = luaLang("multiple") .. var_11_4

	arg_11_0._simageicon4:LoadImage(var_11_3)
	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_11_0._imglimittime, "img_xianshi2")
	gohelper.setActive(arg_11_0._golimittime, false)

	if var_11_9.expireTime then
		gohelper.setActive(arg_11_0._golimittime, true)
	end
end

function var_0_0.getIconUrlAndQuantity(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1
	local var_12_2
	local var_12_3 = string.splitToNumber(arg_12_1, "#")
	local var_12_4 = var_12_3[1]
	local var_12_5 = var_12_3[2]
	local var_12_6 = var_12_3[3]
	local var_12_7, var_12_8 = ItemModel.instance:getItemConfigAndIcon(var_12_4, var_12_5)

	return var_12_8, var_12_6
end

function var_0_0.onMonthCardInfoChange(arg_13_0)
	arg_13_0.monthCardInfo = StoreModel.instance:getMonthCardInfo()

	arg_13_0:refreshRemainDay()
end

function var_0_0.onDailyRefresh(arg_14_0)
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagegoods:UnLoadImage()
	arg_15_0._simageicon1:UnLoadImage()
	arg_15_0._simageicon2:UnLoadImage()
	arg_15_0._simageicon3:UnLoadImage()
	arg_15_0._simageBg:UnLoadImage()
	arg_15_0._btnbuy:RemoveClickListener()
	arg_15_0._bgClick:RemoveClickListener()
	arg_15_0.wenhaoClick:RemoveClickListener()
	arg_15_0:removeEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, arg_15_0.onMonthCardInfoChange, arg_15_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_15_0.onDailyRefresh, arg_15_0)
end

return var_0_0
