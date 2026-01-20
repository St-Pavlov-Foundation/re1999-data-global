-- chunkname: @modules/logic/store/view/recommend/StoreMonthCardView.lua

module("modules.logic.store.view.recommend.StoreMonthCardView", package.seeall)

local StoreMonthCardView = class("StoreMonthCardView", StoreRecommendBaseSubView)

function StoreMonthCardView:onInitView()
	self._simagegoods = gohelper.findChildSingleImage(self.viewGO, "view/#simage_goods")
	self._txtlefttimetips = gohelper.findChildText(self.viewGO, "view/#txt_lefttimetips")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "view/layout/#txt_title1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "view/layout/#txt_title2")
	self._txtdec = gohelper.findChildText(self.viewGO, "view/#txt_dec")
	self._txttitleen = gohelper.findChildText(self.viewGO, "view/#txt_titleen")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips1/#simage_icon1")
	self._txttipnum1 = gohelper.findChildText(self.viewGO, "view/tips/tips1/#txt_tipnum1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips2/#simage_icon2")
	self._txttipnum2 = gohelper.findChildText(self.viewGO, "view/tips/tips2/#txt_tipnum2")
	self._simageicon3 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips3/#simage_icon3")
	self._txttipnum3 = gohelper.findChildText(self.viewGO, "view/tips/tips3/#txt_tipnum3")
	self._simageicon4 = gohelper.findChildSingleImage(self.viewGO, "view/tips/tips4/#simage_icon1")
	self._txttipnum4 = gohelper.findChildText(self.viewGO, "view/tips/tips4/#txt_tipnum1")
	self._golimittime = gohelper.findChild(self.viewGO, "view/tips/tips3/#go_limittime")
	self._imglimittime = gohelper.findChildImage(self.viewGO, "view/tips/tips3/#go_limittime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/buy/#btn_buy")
	self._txtcost = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost")
	self._txtcosticon = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost/costicon")
	self._txtgoodstips = gohelper.findChildText(self.viewGO, "view/buy/#txt_goodstips")
	self._gomooncardup = gohelper.findChild(self.viewGO, "view/#go_mooncardup")
	self._gocanpatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_canpatch")
	self._txtcanpatch = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_canpatch/txt")
	self._goyuekapatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch")
	self._gonopatch = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_nopatch")
	self._txtnopatch = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_nopatch/txt")
	self._gosupplementicon = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/itemicon")
	self._btnbuqian = gohelper.findChildButtonWithAudio(self.viewGO, "view/#go_yuekapatch/#btn_buqian")
	self._simagesupplement = gohelper.findChildSingleImage(self.viewGO, "view/tips/patchtips/#txt_propnum/#simage_icon1")
	self._gopatchtips = gohelper.findChild(self.viewGO, "view/#go_patchtips")
	self._gopatchlimittime = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_limittime")
	self._gopatchcurrtime = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/#go_currenttime")
	self._txtpatchcurrtime = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/#go_currenttime/timetxt")
	self._txtpatchday = gohelper.findChildText(self.viewGO, "view/#go_yuekapatch/infobg/#txt_patchday")
	self._gopatchinfo = gohelper.findChild(self.viewGO, "view/#go_yuekapatch/infobg")
	self._txtcosthw = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost_hw")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreMonthCardView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnbuqian:AddClickListener(self._btnbuqianOnClick, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSupplement, self)
end

function StoreMonthCardView:removeEvents()
	self._btnbuqian:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
end

function StoreMonthCardView:_btnbuyOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "711",
		[StatEnum.EventProperties.RecommendPageName] = "月历",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})

	local jumpParams = string.splitToNumber(self.config.systemJumpCode, "#")

	if jumpParams[2] then
		local goodId = jumpParams[2]
		local packageMo = StoreModel.instance:getGoodsMO(goodId)

		StoreController.instance:openPackageStoreGoodsView(packageMo)
	else
		self.viewContainer.storeView:_refreshTabs(StoreEnum.StoreId.Package, StoreEnum.MonthCardGoodsId)
		StoreController.instance:statSwitchStore(StoreEnum.StoreId.Package)
	end
end

function StoreMonthCardView:onWenHaoClick()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.MouthTipsDesc))
end

function StoreMonthCardView:_editableInitView()
	self.godecorate = gohelper.findChild(self.viewGO, "view/decorateicon")
	self.wenhaoClick = gohelper.getClick(self.godecorate)

	self.wenhaoClick:AddClickListener(self.onWenHaoClick, self)

	self._simageBg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._bgClick = gohelper.getClick(self._simageBg.gameObject)

	gohelper.addUIClickAudio(self._bgClick.gameObject, AudioEnum.UI.play_ui_common_pause)
	self._simagegoods:LoadImage(ResUrl.getStoreBottomBgIcon("img_calendar"))
	self._simageBg:LoadImage(ResUrl.getStoreBottomBgIcon("deco"))
	self._bgClick:AddClickListener(self._btnbuyOnClick, self)
	self:addEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, self.onMonthCardInfoChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._txtgoodstips.text = luaLang("storemonthcard_tips")

	self._simagesupplement:LoadImage(ResUrl.getSpecialPropItemIcon(StoreEnum.SupplementMonthCardItemId))

	self._txtcost.text = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	self._txtcosticon.text = PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)

	local symbol = PayModel.instance:getProductOriginPriceSymbol(StoreEnum.MonthCardGoodsId)
	local num, numStr = PayModel.instance:getProductOriginPriceNum(StoreEnum.MonthCardGoodsId)
	local symbol2 = ""

	if string.nilorempty(symbol) then
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex + 1
		symbol2 = string.sub(numStr, lastIndex + 1, string.len(numStr))
		numStr = string.sub(numStr, 1, lastIndex)
		self._txtcosthw.text = string.format("%s<size=30>%s</size>", numStr, symbol2)
	else
		self._txtcosthw.text = string.format("<size=30>%s</size>%s", symbol, numStr)
	end
end

function StoreMonthCardView:onUpdateParam()
	return
end

function StoreMonthCardView:_initCurrency()
	local currencyConfig = StoreConfig.instance:getTabConfig(StoreEnum.RecommendSubStoreId.MonthCardId)

	if currencyConfig and not string.nilorempty(currencyConfig.showCost) then
		local param = {}
		local temp = string.splitToNumber(currencyConfig.showCost, "#")

		for i = #temp, 1, -1 do
			table.insert(param, temp[i])
		end

		local item = {
			id = StoreEnum.SupplementMonthCardItemId,
			type = MaterialEnum.MaterialType.SpecialExpiredItem
		}

		table.insert(param, item)
		self.viewContainer:setCurrencyByParams(param)
	end
end

function StoreMonthCardView:onOpen()
	self.monthCardInfo = StoreModel.instance:getMonthCardInfo()
	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.MonthCardId)

	self:_tryPatFaceMonthCardView()
	self:refreshUI()
	self:_initCurrency()
	StoreMonthCardView.super.onOpen(self)
end

function StoreMonthCardView:refreshUI()
	self:refreshRemainDay()
	self:refreshRewardIcon()
	self:_refreshSupplement()

	local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(self._gomooncardup, showtag)

	if SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
		StoreController.instance:dispatchEvent(StoreEvent.StopRecommendViewAuto)
	end
end

function StoreMonthCardView:refreshRemainDay()
	if self.monthCardInfo ~= nil then
		local remainDay = self.monthCardInfo:getRemainDay()

		if remainDay == StoreEnum.MonthCardStatus.NotPurchase then
			self._txtlefttimetips.text = luaLang("not_purchase")
		elseif remainDay == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			local str = luaLang("not_enough_one_day")

			if LangSettings.instance:isEn() then
				str = str .. " "
			end

			str = str .. (self.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
			self._txtlefttimetips.text = str
		else
			local str = formatLuaLang("remain_day", remainDay)

			if LangSettings.instance:isEn() then
				str = str .. " "
			end

			str = str .. (self.monthCardInfo.hasGetBonus and luaLang("today_reward") or "")
			self._txtlefttimetips.text = str
		end
	else
		self._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function StoreMonthCardView:refreshRewardIcon()
	local monthCardCo = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceIconUrl, onceQuantity = self:getIconUrlAndQuantity(string.split(monthCardCo.onceBonus, "|")[1])
	local onceIcon2Url, onceQuan2tity = self:getIconUrlAndQuantity(string.split(monthCardCo.onceBonus, "|")[2])
	local dayIconUrl, dayQuantity = self:getIconUrlAndQuantity(string.split(monthCardCo.dailyBonus, "|")[1])
	local powertable = string.split(monthCardCo.dailyBonus, "|")[2]
	local power = string.split(powertable, "#")
	local powerconfig, powericon = ItemModel.instance:getItemConfigAndIcon(power[1], power[2])

	self._txttipnum1.text = luaLang("multiple") .. onceQuantity

	self._simageicon1:LoadImage(onceIconUrl)

	self._txttipnum2.text = luaLang("multiple") .. dayQuantity * 30

	self._simageicon2:LoadImage(dayIconUrl)

	self._txttipnum3.text = luaLang("multiple") .. power[3] * 30

	self._simageicon3:LoadImage(powericon)

	self._txttipnum4.text = luaLang("multiple") .. onceQuan2tity

	self._simageicon4:LoadImage(onceIcon2Url)
	UISpriteSetMgr.instance:setStoreGoodsSprite(self._imglimittime, "img_xianshi2")
	gohelper.setActive(self._golimittime, false)

	if powerconfig.expireTime then
		gohelper.setActive(self._golimittime, true)
	end
end

function StoreMonthCardView:getIconUrlAndQuantity(iconStr)
	local type, id, quantity
	local temp = string.splitToNumber(iconStr, "#")

	type = temp[1]
	id = temp[2]
	quantity = temp[3]

	local _, icon = ItemModel.instance:getItemConfigAndIcon(type, id)

	return icon, quantity
end

function StoreMonthCardView:onMonthCardInfoChange()
	self.monthCardInfo = StoreModel.instance:getMonthCardInfo()

	self:refreshRemainDay()
end

function StoreMonthCardView:onDailyRefresh()
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

function StoreMonthCardView:_onReceiveSupplementMonthCardReply()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	self:_refreshSupplement()
end

function StoreMonthCardView:_refreshSupplement()
	if StoreModel.instance:hasPurchaseMonthCard() then
		gohelper.setActive(self._goyuekapatch, true)
		gohelper.setActive(self._gopatchtips, false)

		local showBtn = SignInModel.instance:getCanSupplementMonthCardDays() > 0

		gohelper.setActive(self._gocanpatch, showBtn)
		gohelper.setActive(self._gonopatch, not showBtn)
	else
		gohelper.setActive(self._goyuekapatch, false)
		gohelper.setActive(self._gopatchtips, true)
	end

	if not self._supplementItem then
		self._supplementItem = IconMgr.instance:getCommonItemIcon(self._gosupplementicon)

		self._supplementItem:setMOValue(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId, 1)
		self._supplementItem:isShowCount(false)
		self._supplementItem:setCanShowDeadLine(false)
	end

	local nosigninday = SignInModel.instance:getSupplementMonthCardDays()
	local itemcount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)
	local showtips = false
	local showlimiticon = false

	if nosigninday and nosigninday > 0 then
		showtips = true

		if itemcount > 0 then
			self._txtpatchday.text = formatLuaLang("p_monthcard_reappear_txt_04", SignInModel.instance:getCanSupplementMonthCardDays())
		else
			self._txtpatchday.text = luaLang("p_monthcard_reappear_txt_01")
		end
	end

	if itemcount < 1 then
		showlimiticon = true
	else
		local itemDeadline = CurrencyController.instance:getExpireItemDeadLineTime()

		if itemDeadline and itemDeadline > 0 then
			local limitSec = itemDeadline - ServerTime.now()
			local date, dateFormat, hasDay = TimeUtil.secondToRoughTime(limitSec, true)

			self._txtpatchcurrtime.text = string.format("%s%s", date, dateFormat)
		end
	end

	gohelper.setActive(self._gopatchlimittime, showlimiticon)
	gohelper.setActive(self._gopatchcurrtime, not showlimiticon)
	gohelper.setActive(self._gopatchinfo, showtips)
end

function StoreMonthCardView:_btnbuqianOnClick()
	if StoreModel.instance:hasPurchaseMonthCard() then
		local nosigninday = SignInModel.instance:getSupplementMonthCardDays()
		local itemcount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)

		if itemcount < 1 then
			MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.SpecialExpiredItem, StoreEnum.SupplementMonthCardItemId)
		elseif nosigninday < 1 then
			GameFacade.showToastString(luaLang("p_monthcard_reappear_tips_02"))
		else
			local currencyParam = {}
			local item = {
				isHideAddBtn = true,
				id = StoreEnum.SupplementMonthCardItemId,
				type = MaterialEnum.MaterialType.SpecialExpiredItem
			}

			table.insert(currencyParam, item)
			SignInController.instance:showPatchpropUseView(MessageBoxIdDefine.SupplementMonthCardUseTip, MsgBoxEnum.BoxType.Yes_No, currencyParam, self._useSupplementMonthCard, nil, nil, self, nil, nil, SignInModel.instance:getCanSupplementMonthCardDays())
		end
	end
end

function StoreMonthCardView:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function StoreMonthCardView:_tryPatFaceMonthCardView()
	local config = StoreConfig.instance:getTabConfig(self.config.id)

	if not config.toprecommend then
		return
	end

	local num = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0)

	if num == 0 then
		ViewMgr.instance:openView(ViewName.StoreSupplementMonthCardTipView)
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 1)
	end
end

function StoreMonthCardView:onDestroyView()
	self._simagegoods:UnLoadImage()
	self._simageicon1:UnLoadImage()
	self._simageicon2:UnLoadImage()
	self._simageicon3:UnLoadImage()
	self._simageBg:UnLoadImage()
	self._btnbuy:RemoveClickListener()
	self._bgClick:RemoveClickListener()
	self.wenhaoClick:RemoveClickListener()
	self:removeEventCb(StoreController.instance, StoreEvent.MonthCardInfoChanged, self.onMonthCardInfoChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

return StoreMonthCardView
