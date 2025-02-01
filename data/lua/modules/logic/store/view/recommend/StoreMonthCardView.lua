module("modules.logic.store.view.recommend.StoreMonthCardView", package.seeall)

slot0 = class("StoreMonthCardView", StoreRecommendBaseSubView)

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
	slot0._txtcosticon = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost/costicon")
	slot0._txtgoodstips = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_goodstips")
	slot0._gomooncardup = gohelper.findChild(slot0.viewGO, "view/#go_mooncardup")
	slot0._txtcosthw = gohelper.findChildText(slot0.viewGO, "view/buy/#txt_cost_hw")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnbuyOnClick(slot0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "711",
		[StatEnum.EventProperties.RecommendPageName] = "月历"
	})
	slot0.viewContainer.storeView:_refreshTabs(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
	StoreController.instance:statSwitchStore(StoreEnum.StoreId.Package)
end

function slot0.onWenHaoClick(slot0)
	ViewMgr.instance:openView(ViewName.StoreTipView, {
		showTop = true
	})
	AudioMgr.instance:trigger(20002004)
end

function slot0._editableInitView(slot0)
	slot0.godecorate = gohelper.findChild(slot0.viewGO, "view/decorateicon")
	slot0.wenhaoClick = gohelper.getClick(slot0.godecorate)

	slot0.wenhaoClick:AddClickListener(slot0.onWenHaoClick, slot0)

	slot0._simageBg = gohelper.findChildSingleImage(slot0.viewGO, "view/#simage_bg")
	slot0._bgClick = gohelper.getClick(slot0._simageBg.gameObject)

	gohelper.addUIClickAudio(slot0._bgClick.gameObject, AudioEnum.UI.play_ui_common_pause)
	slot0._simagegoods:LoadImage(ResUrl.getStoreBottomBgIcon("img_calendar"))
	slot0._simageBg:LoadImage(ResUrl.getStoreBottomBgIcon("deco"))
	slot0._bgClick:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, slot0.onMonthCardInfoChange, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.onDailyRefresh, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._txtgoodstips.text = luaLang("storemonthcard_tips")
	slot0._txtcost.text = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	slot0._txtcosticon.text = PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)
	slot2, slot3 = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	slot4 = ""

	if string.nilorempty(PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)) then
		slot5 = string.reverse(slot3)
		slot6 = string.len(slot5) - string.find(slot5, "%d") + 1
		slot0._txtcosthw.text = string.format("%s<size=30>%s</size>", string.sub(slot3, 1, slot6), string.sub(slot3, slot6 + 1, string.len(slot3)))
	else
		slot0._txtcosthw.text = string.format("<size=30>%s</size>%s", slot1, slot3)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.monthCardInfo = StoreModel.instance:getMonthCardInfo()

	slot0:refreshUI()
	uv0.super.onOpen(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshRemainDay()
	slot0:refreshRewardIcon()
	gohelper.setActive(slot0._gomooncardup, StoreHelper.checkMonthCardLevelUpTagOpen())
end

function slot0.refreshRemainDay(slot0)
	if slot0.monthCardInfo ~= nil then
		if slot0.monthCardInfo:getRemainDay() == StoreEnum.MonthCardStatus.NotPurchase then
			slot0._txtlefttimetips.text = luaLang("not_purchase")
		elseif slot1 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			slot0._txtlefttimetips.text = luaLang("not_enough_one_day") .. (slot0.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
		else
			slot0._txtlefttimetips.text = formatLuaLang("remain_day", slot1) .. (slot0.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
		end
	else
		slot0._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function slot0.refreshRewardIcon(slot0)
	slot1 = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	slot2, slot3 = slot0:getIconUrlAndQuantity(string.split(slot1.onceBonus, "|")[1])
	slot4, slot5 = slot0:getIconUrlAndQuantity(string.split(slot1.onceBonus, "|")[2])
	slot6, slot7 = slot0:getIconUrlAndQuantity(string.split(slot1.dailyBonus, "|")[1])
	slot9 = string.split(string.split(slot1.dailyBonus, "|")[2], "#")
	slot10, slot11 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])
	slot0._txttipnum1.text = luaLang("multiple") .. slot3

	slot0._simageicon1:LoadImage(slot2)

	slot0._txttipnum2.text = luaLang("multiple") .. slot7 * 30

	slot0._simageicon2:LoadImage(slot6)

	slot0._txttipnum3.text = luaLang("multiple") .. slot9[3] * 30

	slot0._simageicon3:LoadImage(slot11)

	slot0._txttipnum4.text = luaLang("multiple") .. slot5

	slot0._simageicon4:LoadImage(slot4)
	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._imglimittime, "img_xianshi2")
	gohelper.setActive(slot0._golimittime, false)

	if slot10.expireTime then
		gohelper.setActive(slot0._golimittime, true)
	end
end

function slot0.getIconUrlAndQuantity(slot0, slot1)
	slot2, slot3, slot4 = nil
	slot5 = string.splitToNumber(slot1, "#")
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot5[1], slot5[2])

	return slot7, slot5[3]
end

function slot0.onMonthCardInfoChange(slot0)
	slot0.monthCardInfo = StoreModel.instance:getMonthCardInfo()

	slot0:refreshRemainDay()
end

function slot0.onDailyRefresh(slot0)
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

function slot0.onDestroyView(slot0)
	slot0._simagegoods:UnLoadImage()
	slot0._simageicon1:UnLoadImage()
	slot0._simageicon2:UnLoadImage()
	slot0._simageicon3:UnLoadImage()
	slot0._simageBg:UnLoadImage()
	slot0._btnbuy:RemoveClickListener()
	slot0._bgClick:RemoveClickListener()
	slot0.wenhaoClick:RemoveClickListener()
	slot0:removeEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, slot0.onMonthCardInfoChange, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.onDailyRefresh, slot0)
end

return slot0
