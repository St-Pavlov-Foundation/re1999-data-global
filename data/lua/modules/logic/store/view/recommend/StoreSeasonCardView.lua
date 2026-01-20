-- chunkname: @modules/logic/store/view/recommend/StoreSeasonCardView.lua

module("modules.logic.store.view.recommend.StoreSeasonCardView", package.seeall)

local StoreSeasonCardView = class("StoreSeasonCardView", StoreRecommendBaseSubView)

function StoreSeasonCardView:onInitView()
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
	self._txtcost2 = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost2")
	self._txtgoodstips = gohelper.findChildText(self.viewGO, "view/buy/#txt_goodstips")
	self._gomooncardup = gohelper.findChild(self.viewGO, "view/#go_mooncardup")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
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
	self._txtcosthw = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost2/#txt_cost_hw")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSeasonCardView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._bgClick:AddClickListener(self._btnbuyOnClick, self)
	self._wenhaoClick:AddClickListener(self._onWenHaoClick, self)
	self._btnbuqian:AddClickListener(self._btnbuqianOnClick, self)
	SignInController.instance:registerCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSupplement, self)
end

function StoreSeasonCardView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._bgClick:RemoveClickListener()
	self._wenhaoClick:RemoveClickListener()
	self._btnbuqian:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
end

local split = string.split
local kGoodsId = StoreEnum.SeasonCardGoodsId

function StoreSeasonCardView:_btnbuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(self.config and self.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = self.config and self.config.name or "StoreSeasonCardView",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
	GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
end

function StoreSeasonCardView:_onWenHaoClick()
	HelpController.instance:openStoreTipView(CommonConfig.instance:getConstStr(ConstEnum.SeasonCardTipsDesc))
end

function StoreSeasonCardView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._txtcosticon = gohelper.findChildText(self.viewGO, "view/buy/#txt_cost/costicon")
	self._wenhaoClick = gohelper.getClick(gohelper.findChild(self.viewGO, "view/decorateicon"))
	self._bgClick = gohelper.getClick(self._simagebg.gameObject)

	local symbol = PayModel.instance:getProductOriginPriceSymbol(kGoodsId)
	local num, numStr = PayModel.instance:getProductOriginPriceNum(kGoodsId)

	self._txtcost.text = num

	self._simagesupplement:LoadImage(ResUrl.getSpecialPropItemIcon(StoreEnum.SupplementMonthCardItemId))

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

	local shopCo = StoreConfig.instance:getChargeGoodsConfig(kGoodsId)
	local originalPrice = PayModel.instance:getProductPrice(shopCo.originalCostGoodsId)

	self._txtcost2.text = originalPrice

	if SDKModel.instance:isDmm() then
		self._txtcost2.text = "1830pt"
	end
end

function StoreSeasonCardView:onClose()
	StoreController.instance:unregisterCallback(StoreEvent.MonthCardInfoChanged, self._onMonthCardInfoChange, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function StoreSeasonCardView:onDestroyView()
	self._simageicon1:UnLoadImage()
	self._simageicon2:UnLoadImage()
	self._simageicon3:UnLoadImage()
	self._simageicon4:UnLoadImage()
end

function StoreSeasonCardView:onOpen()
	StoreSeasonCardView.super.onOpen(self)

	self._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	self:_refresh()
	self:_initCurrency()
	StoreController.instance:registerCallback(StoreEvent.MonthCardInfoChanged, self._onMonthCardInfoChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)

	if SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
		StoreController.instance:dispatchEvent(StoreEvent.StopRecommendViewAuto)
	end
end

function StoreSeasonCardView:_initCurrency()
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

function StoreSeasonCardView:_refresh()
	self:_refreshRemainDay()
	self:_refreshRewardIcon()
	self:_refreshSupplement()

	local showtag = StoreHelper.checkMonthCardLevelUpTagOpen()

	gohelper.setActive(self._gomooncardup, showtag)
end

function StoreSeasonCardView:_refreshRemainDay()
	if self._seasonCardInfo then
		local remainDay = self._seasonCardInfo:getRemainDay()

		if remainDay == StoreEnum.MonthCardStatus.NotPurchase then
			self._txtlefttimetips.text = luaLang("not_purchase")
		elseif remainDay == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			if self._seasonCardInfo.hasGetBonus then
				self._txtlefttimetips.text = luaLang("StoreSeasonCardView_not_enough_one_day")
			else
				self._txtlefttimetips.text = luaLang("not_enough_one_day")
			end
		elseif LangSettings.instance:isEn() then
			self._txtlefttimetips.text = formatLuaLang("remain_day", remainDay) .. " " .. (self._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		else
			self._txtlefttimetips.text = formatLuaLang("remain_day", remainDay) .. (self._seasonCardInfo.hasGetBonus and luaLang("today_reward") or "")
		end
	else
		self._txtlefttimetips.text = luaLang("not_purchase")
	end
end

function StoreSeasonCardView:_refreshRewardIcon()
	local f = StoreConfig.instance:getSeasonCardMultiFactor()
	local monthCardCO = StoreConfig.instance:getMonthCardConfig(StoreEnum.MonthCardGoodsId)
	local onceIconUrl, onceQuantity = self:_getIconUrlAndQuantity(split(monthCardCO.onceBonus, "|")[1])
	local onceIcon2Url, onceQuan2tity = self:_getIconUrlAndQuantity(split(monthCardCO.onceBonus, "|")[2])
	local dayIconUrl, dayQuantity = self:_getIconUrlAndQuantity(split(monthCardCO.dailyBonus, "|")[1])
	local powertable = split(monthCardCO.dailyBonus, "|")[2]
	local power = split(powertable, "#")
	local powerconfig, powericon = ItemModel.instance:getItemConfigAndIcon(power[1], power[2])

	self._txttipnum1.text = luaLang("multiple") .. onceQuantity * f

	self._simageicon1:LoadImage(onceIconUrl)

	self._txttipnum4.text = luaLang("multiple") .. onceQuan2tity * f

	self._simageicon4:LoadImage(onceIcon2Url)

	self._txttipnum2.text = luaLang("multiple") .. dayQuantity * 30 * f

	self._simageicon2:LoadImage(dayIconUrl)

	self._txttipnum3.text = luaLang("multiple") .. power[3] * 30 * f

	self._simageicon3:LoadImage(powericon)
	UISpriteSetMgr.instance:setStoreGoodsSprite(self._imglimittime, "img_xianshi2")
	gohelper.setActive(self._golimittime, false)

	if powerconfig.expireTime then
		gohelper.setActive(self._golimittime, true)
	end
end

function StoreSeasonCardView:_getIconUrlAndQuantity(iconStr)
	local strList = string.splitToNumber(iconStr, "#")
	local itemType = strList[1]
	local itemId = strList[2]
	local quantity = strList[3]
	local itemCO, icon = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	return icon, quantity, itemCO
end

function StoreSeasonCardView:_onMonthCardInfoChange()
	self._seasonCardInfo = StoreModel.instance:getMonthCardInfo()

	self:_refreshRemainDay()
end

function StoreSeasonCardView:_onDailyRefresh()
	ChargeRpc.instance:sendGetMonthCardInfoRequest()
end

function StoreSeasonCardView:_refreshSupplement()
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

function StoreSeasonCardView:_btnbuqianOnClick()
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

function StoreSeasonCardView:_onReceiveSupplementMonthCardReply()
	StoreController.instance:dispatchEvent(StoreEvent.SetAutoToNextPage, true)
	self:_refreshSupplement()
end

function StoreSeasonCardView:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function StoreSeasonCardView:_tryPatFaceMonthCardView()
	local num = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 0)

	if num == 0 then
		ViewMgr.instance:openView(ViewName.StoreSupplementMonthCardTipView)
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.StoreSupplementMonthCardTipView), 1)
	end
end

return StoreSeasonCardView
