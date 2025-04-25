module("modules.logic.store.view.recommend.StoreSeasonCardView", package.seeall)

slot0 = class("StoreSeasonCardView", StoreRecommendBaseSubView)

function slot0.onInitView(slot0)
	slot0._simagegoods = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_goods")
	slot0._txtlefttimetips = gohelper.findChildText(slot0.viewGO, "view/#txt_lefttimetips")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "view/layout/#txt_title1")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "view/layout/#txt_title2")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "view/#txt_dec")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "view/#txt_titleen")
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "view/tips/tips1/#simage_icon1")
	slot0._txttipnum1 = gohelper.findChildText(slot0.viewGO, "view/tips/tips1/#txt_tipnum1")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "view/tips/tips2/#simage_icon2")
	slot0._txttipnum2 = gohelper.findChildText(slot0.viewGO, "view/tips/tips2/#txt_tipnum2")
	slot0._simageicon3 = gohelper.findChildSingleImage(slot0.viewGO, "view/tips/tips3/#simage_icon3")
	slot0._txttipnum3 = gohelper.findChildText(slot0.viewGO, "view/tips/tips3/#txt_tipnum3")
	slot0._simageicon4 = gohelper.findChildSingleImage(slot0.viewGO, "view/tips/tips4/#simage_icon1")
	slot0._txttipnum4 = gohelper.findChildText(slot0.viewGO, "view/tips/tips4/#txt_tipnum1")
	slot0._golimittime = gohelper.findChild(slot0.viewGO, "view/tips/tips3/#go_limittime")
	slot0._imglimittime = gohelper.findChildImage(slot0.viewGO, "view/tips/tips3/#go_limittime")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/buy/#btn_buy")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost")
	slot0._txtcost2 = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost2")
	slot0._txtgoodstips = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_goodstips")
	slot0._gomooncardup = gohelper.findChild(slot0.viewGO, "view/#go_mooncardup")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._txtcosthw = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost2/#txt_cost_hw")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._bgClick:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._wenhaoClick:AddClickListener(slot0._onWenHaoClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuy:RemoveClickListener()
	slot0._bgClick:RemoveClickListener()
	slot0._wenhaoClick:RemoveClickListener()
end

slot1 = string.split
slot2 = StoreEnum.SeasonCardGoodsId

function slot0._btnbuyOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.config and slot0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = slot0.config and slot0.config.name or "StoreSeasonCardView"
	})
	GameFacade.jumpByAdditionParam(slot0.config.systemJumpCode)
end

function slot0._onWenHaoClick(slot0)
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._txtcosticon = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost/costicon")
	slot0._wenhaoClick = gohelper.getClick(gohelper.findChild(slot0.viewGO, "view/decorateicon"))
	slot0._bgClick = gohelper.getClick(slot0._simagebg.gameObject)

	if PayModel.getProductOriginPriceSymbol then
		slot0._txtcost.text, slot3 = PayModel.instance:getProductOriginPriceNum(uv0)
		slot4 = ""

		if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(uv0)) then
			slot5 = string.reverse(slot3)
			slot6 = string.len(slot5) - string.find(slot5, "%d") + 1
			slot0._txtcosthw.text = string.format("%s<size=30>%s</size>", string.sub(slot3, 1, slot6), string.sub(slot3, slot6 + 1, string.len(slot3)))
		else
			slot0._txtcosthw.text = string.format("<size=30>%s</size>%s", slot1, slot3)
		end

		slot0._txtcost2.text = PayModel.instance:getProductPrice(StoreConfig.instance:getChargeGoodsConfig(uv0).originalCostGoodsId)
	end
end

function slot0.onClose(slot0)
	StoreController.instance:unregisterCallback(StoreEvent.MonthCardInfoChanged, slot0._onMonthCardInfoChange, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon1:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
	slot0._simageicon3:UnLoadImage()
	slot0._simageicon4:UnLoadImage()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot0._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	slot0:_refresh()
	StoreController.instance:registerCallback(StoreEvent.MonthCardInfoChanged, slot0._onMonthCardInfoChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0._refresh(slot0)
	slot0:_refreshRemainDay()
	slot0:_refreshRewardIcon()
	gohelper.setActive(slot0._gomooncardup, StoreHelper.checkMonthCardLevelUpTagOpen())
end

function slot0._refreshRemainDay(slot0)
	if slot0._seasonCardInfo then
		if slot0._seasonCardInfo:getRemainDay() == StoreEnum.MonthCardStatus.NotPurchase then
			slot0._txtlefttimetips.text = luaLang("not_purchase")
		elseif slot1 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			slot0._txtlefttimetips.text = luaLang("not_enough_one_day") .. (slot0._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		else
			slot0._txtlefttimetips.text = formatLuaLang("remain_day", slot1) .. (slot0._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		end
	else
		slot0._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function slot0._refreshRewardIcon(slot0)
	slot1 = StoreConfig.instance:getSeasonCardMultiFactor()
	slot2 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	slot3, slot4 = slot0:_getIconUrlAndQuantity(uv0(slot2.onceBonus, "|")[1])
	slot5, slot6 = slot0:_getIconUrlAndQuantity(uv0(slot2.onceBonus, "|")[2])
	slot7, slot8 = slot0:_getIconUrlAndQuantity(uv0(slot2.dailyBonus, "|")[1])
	slot10 = uv0(uv0(slot2.dailyBonus, "|")[2], "#")
	slot11, slot12 = ItemModel.instance:getItemConfigAndIcon(slot10[1], slot10[2])
	slot0._txttipnum1.text = luaLang("multiple") .. slot4 * slot1

	slot0._simageicon1:LoadImage(slot3)

	slot0._txttipnum4.text = luaLang("multiple") .. slot6 * slot1

	slot0._simageicon4:LoadImage(slot5)

	slot0._txttipnum2.text = luaLang("multiple") .. slot8 * 30 * slot1

	slot0._simageicon2:LoadImage(slot7)

	slot0._txttipnum3.text = luaLang("multiple") .. slot10[3] * 30 * slot1

	slot0._simageicon3:LoadImage(slot12)
	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._imglimittime, "img_xianshi2")
	gohelper.setActive(slot0._golimittime, false)

	if slot11.expireTime then
		gohelper.setActive(slot0._golimittime, true)
	end
end

function slot0._getIconUrlAndQuantity(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2])

	return slot7, slot2[3], slot6
end

function slot0._onMonthCardInfoChange(slot0)
	slot0._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	slot0:_refreshRemainDay()
end

function slot0._onDailyRefresh(slot0)
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

return slot0
