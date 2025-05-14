module("modules.logic.store.view.recommend.StoreSeasonCardView", package.seeall)

local var_0_0 = class("StoreSeasonCardView", StoreRecommendBaseSubView)

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
	arg_1_0._txtcost2 = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_cost2")
	arg_1_0._txtgoodstips = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_goodstips")
	arg_1_0._gomooncardup = gohelper.findChild(arg_1_0.viewGO, "view/#go_mooncardup")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._txtcosthw = gohelper.findChildText(arg_1_0.viewGO, "view/buy/#txt_cost2/#txt_cost_hw")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._bgClick:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._wenhaoClick:AddClickListener(arg_2_0._onWenHaoClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._bgClick:RemoveClickListener()
	arg_3_0._wenhaoClick:RemoveClickListener()
end

local var_0_1 = string.split
local var_0_2 = StoreEnum.SeasonCardGoodsId

function var_0_0._btnbuyOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_4_0.config and arg_4_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_4_0.config and arg_4_0.config.name or "StoreSeasonCardView"
	})
	GameFacade.jumpByAdditionParam(arg_4_0.config.systemJumpCode)
end

function var_0_0._onWenHaoClick(arg_5_0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_6_0.viewGO)
	arg_6_0._txtcosticon = gohelper.findChildText(arg_6_0.viewGO, "view/buy/#txt_cost/costicon")
	arg_6_0._wenhaoClick = gohelper.getClick(gohelper.findChild(arg_6_0.viewGO, "view/decorateicon"))
	arg_6_0._bgClick = gohelper.getClick(arg_6_0._simagebg.gameObject)

	if PayModel.getProductOriginPriceSymbol then
		local var_6_0 = PayModel.instance:getProductOriginPriceSymbol(var_0_2)
		local var_6_1, var_6_2 = PayModel.instance:getProductOriginPriceNum(var_0_2)

		arg_6_0._txtcost.text = var_6_1

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

		local var_6_8 = StoreConfig.instance:getChargeGoodsConfig(var_0_2)
		local var_6_9 = PayModel.instance:getProductPrice(var_6_8.originalCostGoodsId)

		arg_6_0._txtcost2.text = var_6_9
	end
end

function var_0_0.onClose(arg_7_0)
	StoreController.instance:unregisterCallback(StoreEvent.MonthCardInfoChanged, arg_7_0._onMonthCardInfoChange, arg_7_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_7_0._onDailyRefresh, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simageicon1:UnLoadImage()
	arg_8_0._simageicon2:UnLoadImage()
	arg_8_0._simageicon3:UnLoadImage()
	arg_8_0._simageicon4:UnLoadImage()
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)

	arg_9_0._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	arg_9_0:_refresh()
	StoreController.instance:registerCallback(StoreEvent.MonthCardInfoChanged, arg_9_0._onMonthCardInfoChange, arg_9_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_9_0._onDailyRefresh, arg_9_0)
end

function var_0_0._refresh(arg_10_0)
	arg_10_0:_refreshRemainDay()
	arg_10_0:_refreshRewardIcon()

	local var_10_0 = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(arg_10_0._gomooncardup, var_10_0)
end

function var_0_0._refreshRemainDay(arg_11_0)
	if arg_11_0._seasonCardInfo then
		local var_11_0 = arg_11_0._seasonCardInfo:getRemainDay()

		if var_11_0 == StoreEnum.MonthCardStatus.NotPurchase then
			arg_11_0._txtlefttimetips.text = luaLang("not_purchase")
		elseif var_11_0 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			arg_11_0._txtlefttimetips.text = luaLang("not_enough_one_day") .. (arg_11_0._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		else
			arg_11_0._txtlefttimetips.text = formatLuaLang("remain_day", var_11_0) .. (arg_11_0._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		end
	else
		arg_11_0._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function var_0_0._refreshRewardIcon(arg_12_0)
	local var_12_0 = StoreConfig.instance:getSeasonCardMultiFactor()
	local var_12_1 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local var_12_2, var_12_3 = arg_12_0:_getIconUrlAndQuantity(var_0_1(var_12_1.onceBonus, "|")[1])
	local var_12_4, var_12_5 = arg_12_0:_getIconUrlAndQuantity(var_0_1(var_12_1.onceBonus, "|")[2])
	local var_12_6, var_12_7 = arg_12_0:_getIconUrlAndQuantity(var_0_1(var_12_1.dailyBonus, "|")[1])
	local var_12_8 = var_0_1(var_12_1.dailyBonus, "|")[2]
	local var_12_9 = var_0_1(var_12_8, "#")
	local var_12_10, var_12_11 = ItemModel.instance:getItemConfigAndIcon(var_12_9[1], var_12_9[2])

	arg_12_0._txttipnum1.text = luaLang("multiple") .. var_12_3 * var_12_0

	arg_12_0._simageicon1:LoadImage(var_12_2)

	arg_12_0._txttipnum4.text = luaLang("multiple") .. var_12_5 * var_12_0

	arg_12_0._simageicon4:LoadImage(var_12_4)

	arg_12_0._txttipnum2.text = luaLang("multiple") .. var_12_7 * 30 * var_12_0

	arg_12_0._simageicon2:LoadImage(var_12_6)

	arg_12_0._txttipnum3.text = luaLang("multiple") .. var_12_9[3] * 30 * var_12_0

	arg_12_0._simageicon3:LoadImage(var_12_11)
	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_12_0._imglimittime, "img_xianshi2")
	gohelper.setActive(arg_12_0._golimittime, false)

	if var_12_10.expireTime then
		gohelper.setActive(arg_12_0._golimittime, true)
	end
end

function var_0_0._getIconUrlAndQuantity(arg_13_0, arg_13_1)
	local var_13_0 = string.splitToNumber(arg_13_1, "#")
	local var_13_1 = var_13_0[1]
	local var_13_2 = var_13_0[2]
	local var_13_3 = var_13_0[3]
	local var_13_4, var_13_5 = ItemModel.instance:getItemConfigAndIcon(var_13_1, var_13_2)

	return var_13_5, var_13_3, var_13_4
end

function var_0_0._onMonthCardInfoChange(arg_14_0)
	arg_14_0._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	arg_14_0:_refreshRemainDay()
end

function var_0_0._onDailyRefresh(arg_15_0)
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

return var_0_0
