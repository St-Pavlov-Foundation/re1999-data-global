module("modules.logic.store.view.StoreView", package.seeall)

local var_0_0 = class("StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_store/bg/#simage_bg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_store/bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_store/bg/#simage_righticon")
	arg_1_0._gobtnjapan = gohelper.findChild(arg_1_0.viewGO, "#go_btnjapan")
	arg_1_0._btnJp1 = gohelper.getClickWithAudio(gohelper.findChild(arg_1_0._gobtnjapan, "#btn_btn1"))
	arg_1_0._btnJp2 = gohelper.getClickWithAudio(gohelper.findChild(arg_1_0._gobtnjapan, "#btn_btn2"))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnJp1:AddClickListener(arg_2_0._onJpBtn1Click, arg_2_0)
	arg_2_0._btnJp2:AddClickListener(arg_2_0._onJpBtn2Click, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnJp1:RemoveClickListener()
	arg_3_0._btnJp2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewAnim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._gobigTypeItem = gohelper.findChild(arg_4_0.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem")
	arg_4_0._gobigTypeItem1 = gohelper.findChild(arg_4_0.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem1")
	arg_4_0._bigTypeItemContent = gohelper.findChild(arg_4_0.viewGO, "scroll_bigType/viewport/content").transform

	arg_4_0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	arg_4_0._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	arg_4_0._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))

	arg_4_0._scrollbigType = gohelper.findChildScrollRect(arg_4_0.viewGO, "scroll_bigType")
	arg_4_0._tabsContainer = {}

	local var_4_0 = #StoreModel.instance:getFirstTabs(true, true)

	for iter_4_0 = 1, var_4_0 do
		local var_4_1 = arg_4_0:getUserDataTb_()

		var_4_1.go = gohelper.cloneInPlace(arg_4_0._gobigTypeItem, "bigTypeItem" .. iter_4_0)
		var_4_1.reddot = gohelper.findChild(var_4_1.go, "go_tabreddot")
		var_4_1.reddotNormalType = gohelper.findChild(var_4_1.go, "go_tabreddot/type1")
		var_4_1.reddotActType = gohelper.findChild(var_4_1.go, "go_tabreddot/type9")
		var_4_1.goselected = gohelper.findChild(var_4_1.go, "go_selected")
		var_4_1.iconselected = gohelper.findChildImage(var_4_1.goselected, "itemicon2")
		var_4_1.gounselected = gohelper.findChild(var_4_1.go, "go_unselected")
		var_4_1.iconunselected = gohelper.findChildImage(var_4_1.gounselected, "itemicon1")
		var_4_1.txtnamecn1 = gohelper.findChildText(var_4_1.go, "go_selected/txt_itemcn2")
		var_4_1.txtnameen1 = gohelper.findChildText(var_4_1.go, "go_selected/txt_itemen2")
		var_4_1.txtnamecn2 = gohelper.findChildText(var_4_1.go, "go_unselected/txt_itemcn1")
		var_4_1.txtnameen2 = gohelper.findChildText(var_4_1.go, "go_unselected/txt_itemen1")
		var_4_1.clickArea = gohelper.findChild(var_4_1.go, "clickArea")
		var_4_1.godeadline = gohelper.findChild(var_4_1.go, "go_deadline")
		var_4_1.godeadlineEffect = gohelper.findChild(var_4_1.godeadline, "#effect")
		var_4_1.txttime = gohelper.findChildText(var_4_1.godeadline, "#txt_time")
		var_4_1.txtformat = gohelper.findChildText(var_4_1.godeadline, "#txt_time/#txt_format")
		var_4_1.imagetimebg = gohelper.findChildImage(var_4_1.godeadline, "timebg")
		var_4_1.imagetimeicon = gohelper.findChildImage(var_4_1.godeadline, "#txt_time/timeicon")
		var_4_1.btn = gohelper.getClickWithAudio(var_4_1.clickArea, AudioEnum.UI.play_ui_plot_common)

		var_4_1.btn:AddClickListener(function(arg_5_0)
			local var_5_0 = arg_5_0.tabId

			arg_4_0:_refreshTabs(var_5_0)
			StoreController.instance:statSwitchStore(var_5_0)
		end, var_4_1)
		table.insert(arg_4_0._tabsContainer, var_4_1)
	end

	local var_4_2 = arg_4_0:getUserDataTb_()

	var_4_2.go = arg_4_0._gobigTypeItem1
	var_4_2.reddot = gohelper.findChild(var_4_2.go, "go_tabreddot")
	var_4_2.goselected = gohelper.findChild(var_4_2.go, "go_selected")
	var_4_2.iconselected = gohelper.findChildImage(var_4_2.goselected, "itemicon2")
	var_4_2.gounselected = gohelper.findChild(var_4_2.go, "go_unselected")
	var_4_2.iconunselected = gohelper.findChildImage(var_4_2.gounselected, "itemicon1")
	var_4_2.txtnamecn1 = gohelper.findChildText(var_4_2.go, "go_selected/txt_itemcn2")
	var_4_2.txtnameen1 = gohelper.findChildText(var_4_2.go, "go_selected/txt_itemen2")
	var_4_2.txtnamecn2 = gohelper.findChildText(var_4_2.go, "go_unselected/txt_itemcn1")
	var_4_2.txtnameen2 = gohelper.findChildText(var_4_2.go, "go_unselected/txt_itemen1")
	var_4_2.clickArea = gohelper.findChild(var_4_2.go, "clickArea")
	var_4_2.btn = gohelper.getClickWithAudio(var_4_2.clickArea, AudioEnum.UI.play_ui_plot_common)

	var_4_2.btn:AddClickListener(function(arg_6_0)
		local var_6_0 = arg_6_0.tabId

		arg_4_0:_refreshTabs(var_6_0)
		StoreController.instance:statSwitchStore(var_6_0)
	end, var_4_2)

	arg_4_0._tabTableSP1 = var_4_2

	gohelper.setActive(arg_4_0._gobigTypeItem, false)
	gohelper.setActive(arg_4_0._gobigTypeItem1, false)
	gohelper.setActive(arg_4_0._gobtnjapan, false)
end

function var_0_0._refreshTabs(arg_7_0, arg_7_1, arg_7_2)
	StoreController.instance:readTab(arg_7_1)

	local var_7_0

	if StoreModel.instance:isTabOpen(arg_7_1) == false then
		arg_7_2 = nil
		var_7_0 = StoreModel.instance:getFirstTabs(true, true)
		arg_7_1 = var_7_0[1].id
	end

	local var_7_1 = arg_7_0._selectFirstTabId == nil
	local var_7_2 = arg_7_0._selectFirstTabId

	arg_7_0._selectFirstTabId = StoreEnum.DefaultTabId
	arg_7_0._selectFirstTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_7_1)

	arg_7_0.viewContainer:selectTabView(arg_7_1, arg_7_0._selectFirstTabId, arg_7_2, var_7_2 == arg_7_0._selectFirstTabId)

	var_7_0 = var_7_0 or StoreModel.instance:getFirstTabs(true, true)

	local var_7_3 = math.min(#var_7_0, #arg_7_0._tabsContainer)

	if var_7_2 == arg_7_0._selectFirstTabId and arg_7_0._totalTabCount == var_7_3 then
		return
	end

	arg_7_0._totalTabCount = var_7_3

	if var_7_0 and #var_7_0 > 0 then
		arg_7_0._needCountdown = false

		for iter_7_0 = 1, math.min(#var_7_0, #arg_7_0._tabsContainer) do
			local var_7_4 = var_7_0[iter_7_0]
			local var_7_5 = arg_7_0._tabsContainer[iter_7_0]

			if var_7_4.id == StoreEnum.DefaultTabId then
				var_7_5 = arg_7_0._tabTableSP1

				local var_7_6 = gohelper.getSibling(arg_7_0._tabsContainer[iter_7_0].go)

				gohelper.setSibling(var_7_5.go, var_7_6)
				gohelper.setActive(arg_7_0._tabsContainer[iter_7_0].go, false)
			end

			var_7_5.tabId = var_7_4.id

			local var_7_7 = var_7_4.id == arg_7_0._selectFirstTabId

			var_7_5.txtnamecn1.text = var_7_4.name
			var_7_5.txtnamecn2.text = var_7_4.name
			var_7_5.txtnameen1.text = var_7_4.nameEn
			var_7_5.txtnameen2.text = var_7_4.nameEn

			UISpriteSetMgr.instance:setStoreGoodsSprite(var_7_5.iconselected, var_7_5.tabId)
			UISpriteSetMgr.instance:setStoreGoodsSprite(var_7_5.iconunselected, var_7_5.tabId)
			gohelper.setActive(var_7_5.goselected, var_7_7)
			gohelper.setActive(var_7_5.gounselected, not var_7_7)
			gohelper.setActive(var_7_5.go, true)
			arg_7_0:refreshTimeDeadline(var_7_4, var_7_5)

			if var_7_7 then
				arg_7_0:_handleTabSet(iter_7_0, var_7_1)
			end
		end

		arg_7_0:checkCountdownStatus()

		for iter_7_1 = #var_7_0 + 1, #arg_7_0._tabsContainer do
			gohelper.setActive(arg_7_0._tabsContainer[iter_7_1].go, false)
		end
	else
		for iter_7_2 = 1, #arg_7_0._tabsContainer do
			gohelper.setActive(arg_7_0._tabsContainer[iter_7_2].go, false)
		end
	end

	gohelper.setActive(arg_7_0._gobtnjapan, arg_7_0:_isShowBtnJp())
end

function var_0_0._isShowBtnJp(arg_8_0)
	if not SettingsModel.instance:isJpRegion() then
		return false
	end

	local var_8_0 = arg_8_0._selectFirstTabId

	return var_8_0 == StoreEnum.ChargeStoreTabId or var_8_0 == StoreEnum.StoreId.Package
end

function var_0_0.refreshTimeDeadline(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2.godeadline or gohelper.isNil(arg_9_2.godeadline) or arg_9_1 == nil then
		return
	end

	local var_9_0 = false
	local var_9_1 = StoreHelper.getRemainExpireTime(arg_9_1)
	local var_9_2 = StoreModel.instance:isTabMainRedDotShow(arg_9_1.id)
	local var_9_3 = false

	if StoreEnum.SummonExchange == arg_9_1.id then
		var_9_1 = StoreHelper.getRemainExpireTimeDeep(arg_9_1)
	end

	if StoreEnum.SummonExchange == arg_9_1.id and arg_9_1.id ~= arg_9_0._selectFirstTabId and not var_9_2 and var_9_1 and var_9_1 > 0 and var_9_1 <= TimeUtil.OneDaySecond * 7 then
		gohelper.setActive(arg_9_2.godeadline, true)
		gohelper.setActive(arg_9_2.txttime.gameObject, true)

		local var_9_4

		arg_9_2.txttime.text, arg_9_2.txtformat.text, var_9_4 = TimeUtil.secondToRoughTime(math.floor(var_9_1), true)

		UISpriteSetMgr.instance:setCommonSprite(arg_9_2.imagetimebg, var_9_4 and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(arg_9_2.imagetimeicon, var_9_4 and "daojishiicon_01" or "daojishiicon_02")
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_2.txttime, var_9_4 and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_2.txtformat, var_9_4 and "#98D687" or "#E99B56")
		gohelper.setActive(arg_9_2.godeadlineEffect, not var_9_4)

		var_9_3 = true
	elseif StoreEnum.StoreId.Skin == arg_9_1.storeId then
		local var_9_5 = 0
		local var_9_6 = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)

		if var_9_6[1] then
			local var_9_7 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_9_6[1].id)

			if var_9_7 and not string.nilorempty(var_9_7.expireTime) then
				local var_9_8 = TimeUtil.stringToTimestamp(var_9_7.expireTime)
				local var_9_9 = math.floor(var_9_8 - ServerTime.now())

				if var_9_9 >= 0 and var_9_9 <= 259200 then
					var_9_5 = var_9_9
				end
			end
		end

		if var_9_5 > 0 then
			gohelper.setActive(arg_9_2.godeadline, true)
			gohelper.setActive(arg_9_2.txttime.gameObject, true)

			local var_9_10

			arg_9_2.txttime.text, arg_9_2.txtformat.text, var_9_10 = TimeUtil.secondToRoughTime(math.floor(var_9_5), true)

			UISpriteSetMgr.instance:setCommonSprite(arg_9_2.imagetimebg, var_9_10 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(arg_9_2.imagetimeicon, var_9_10 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_2.txttime, var_9_10 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_2.txtformat, var_9_10 and "#98D687" or "#E99B56")
			gohelper.setActive(arg_9_2.godeadlineEffect, not var_9_10)

			var_9_3 = true
		else
			gohelper.setActive(arg_9_2.godeadline, false)
			gohelper.setActive(arg_9_2.txttime.gameObject, false)
		end
	else
		gohelper.setActive(arg_9_2.godeadline, false)
		gohelper.setActive(arg_9_2.txttime.gameObject, false)
	end

	arg_9_0._needCountdown = var_9_3
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.jumpTab or StoreEnum.DefaultTabId

	if not StoreModel.instance:isTabOpen(var_10_0) then
		var_10_0 = StoreEnum.DefaultTabId
	end

	arg_10_0:_refreshTabs(var_10_0, arg_10_0.viewParam.jumpGoodsId)
	arg_10_0:_onRefreshRedDot()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_10_0._OnDailyRefresh, arg_10_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDay, arg_10_0._OnDailyRefresh, arg_10_0)
	arg_10_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_10_0._onRefreshRedDot, arg_10_0)
	arg_10_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_10_0._onStoreInfoChanged, arg_10_0)
	arg_10_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_10_0._onRefreshRedDot, arg_10_0)
	arg_10_0:addEventCb(StoreController.instance, StoreEvent.PlayShowStoreAnim, arg_10_0._onPlayStoreInAnim, arg_10_0)
	arg_10_0:addEventCb(StoreController.instance, StoreEvent.PlayHideStoreAnim, arg_10_0._onPlayStoreOutAnim, arg_10_0)
	StoreController.instance:statSwitchStore(var_10_0)
end

function var_0_0._onPlayStoreInAnim(arg_11_0)
	arg_11_0._viewAnim:Play("storeview_show", 0, 0)
end

function var_0_0._onPlayStoreOutAnim(arg_12_0)
	arg_12_0._viewAnim:Play("storeview_hide", 0, 0)
end

function var_0_0._onRefreshRedDot(arg_13_0)
	arg_13_0._needCountdown = false

	for iter_13_0, iter_13_1 in pairs(arg_13_0._tabsContainer) do
		local var_13_0, var_13_1 = StoreModel.instance:isTabMainRedDotShow(iter_13_1.tabId)

		gohelper.setActive(iter_13_1.reddot, var_13_0)
		gohelper.setActive(iter_13_1.reddotNormalType, not var_13_1)
		gohelper.setActive(iter_13_1.reddotActType, var_13_1)
		arg_13_0:refreshTimeDeadline(StoreConfig.instance:getTabConfig(iter_13_1.tabId), iter_13_1)
	end

	arg_13_0:checkCountdownStatus()
	gohelper.setActive(arg_13_0._tabTableSP1.reddot, StoreModel.instance:isTabMainRedDotShow(arg_13_0._tabTableSP1.tabId))
end

function var_0_0._OnDailyRefresh(arg_14_0)
	ChargeRpc.instance:sendGetChargeInfoRequest()
	StoreRpc.instance:sendGetStoreInfosRequest(nil, arg_14_0._handleDailyRefreshReceive, arg_14_0)
end

function var_0_0._onStoreInfoChanged(arg_15_0)
	arg_15_0:_onRefreshRedDot()

	local var_15_0 = #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) <= 0

	if arg_15_0._hasDecorateGoods and var_15_0 then
		arg_15_0:closeThis()
	end

	arg_15_0._hasDecorateGoods = not var_15_0
end

function var_0_0._handleDailyRefreshReceive(arg_16_0)
	arg_16_0:_refreshTabs(arg_16_0._selectFirstTabId)
	arg_16_0:_onRefreshRedDot()
end

function var_0_0.checkCountdownStatus(arg_17_0)
	if arg_17_0._needCountdown and not arg_17_0._countdownRepeat then
		TaskDispatcher.runRepeat(arg_17_0.refreshCountdown, arg_17_0, 1)

		arg_17_0._countdownRepeat = true
	elseif not arg_17_0._needCountdown and arg_17_0._countdownRepeat then
		TaskDispatcher.cancelTask(arg_17_0.refreshCountdown, arg_17_0)

		arg_17_0._countdownRepeat = false
	end
end

function var_0_0.refreshCountdown(arg_18_0)
	if not arg_18_0._tabsContainer then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._tabsContainer) do
		if iter_18_1.tabId then
			arg_18_0:refreshTimeDeadline(StoreConfig.instance:getTabConfig(iter_18_1.tabId), iter_18_1)
		end
	end
end

function var_0_0.onClose(arg_19_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_19_0._OnDailyRefresh, arg_19_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDay, arg_19_0._OnDailyRefresh, arg_19_0)
	arg_19_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_19_0._onRefreshRedDot, arg_19_0)
	arg_19_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_19_0._onStoreInfoChanged, arg_19_0)
	arg_19_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_19_0._onRefreshRedDot, arg_19_0)
	arg_19_0:removeEventCb(StoreController.instance, StoreEvent.PlayShowStoreAnim, arg_19_0._onPlayStoreInAnim, arg_19_0)
	arg_19_0:removeEventCb(StoreController.instance, StoreEvent.PlayHideStoreAnim, arg_19_0._onPlayStoreOutAnim, arg_19_0)
	StoreController.instance:statExitStore()

	arg_19_0._needCountdown = false

	arg_19_0:checkCountdownStatus()
	arg_19_0:killTween()
end

function var_0_0.onUpdateParam(arg_20_0)
	local var_20_0 = arg_20_0.viewParam and arg_20_0.viewParam.jumpTab or StoreEnum.DefaultTabId

	if not StoreModel.instance:isTabOpen(var_20_0) then
		var_20_0 = StoreEnum.DefaultTabId
	end

	arg_20_0:_refreshTabs(var_20_0, arg_20_0.viewParam.jumpGoodsId)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simagelefticon:UnLoadImage()
	arg_21_0._simagerighticon:UnLoadImage()

	if arg_21_0._tabsContainer and #arg_21_0._tabsContainer > 0 then
		for iter_21_0 = 1, #arg_21_0._tabsContainer do
			arg_21_0._tabsContainer[iter_21_0].btn:RemoveClickListener()
		end
	end

	arg_21_0._tabTableSP1.btn:RemoveClickListener()
end

var_0_0.TweenTime = 0.1
var_0_0.OffY = 19
var_0_0.ItemH = 120
var_0_0.ItemSpace = -6.5
var_0_0.ListH = 764.5

function var_0_0._handleTabSet(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = var_0_0.OffY + (var_0_0.ItemH + var_0_0.ItemSpace) * 6
	local var_22_1 = recthelper.getAnchorY(arg_22_0._bigTypeItemContent)
	local var_22_2 = var_0_0.OffY + (var_0_0.ItemH + var_0_0.ItemSpace) * (arg_22_1 - 1)

	if var_22_1 > var_22_2 - var_0_0.OffY or var_22_2 + var_0_0.ItemH > var_22_1 + var_0_0.ListH then
		local var_22_3 = var_22_2 - var_0_0.OffY

		if var_22_1 < var_22_3 then
			var_22_3 = var_22_2 - var_0_0.ListH + var_0_0.ItemH - var_0_0.OffY
		end

		if arg_22_2 then
			recthelper.setAnchorY(arg_22_0._bigTypeItemContent, var_22_3)
		else
			arg_22_0:killTween()

			arg_22_0._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(var_22_1, var_22_3, var_0_0.TweenTime, arg_22_0.onTweenCategory, arg_22_0.onTweenFinishCategory, arg_22_0)
		end
	end
end

function var_0_0.onTweenCategory(arg_23_0, arg_23_1)
	if not gohelper.isNil(arg_23_0._scrollbigType) then
		recthelper.setAnchorY(arg_23_0._bigTypeItemContent, arg_23_1)
	end
end

function var_0_0.onTweenFinishCategory(arg_24_0)
	arg_24_0:killTween()
end

function var_0_0.killTween(arg_25_0)
	if arg_25_0._tweenIdCategory then
		ZProj.TweenHelper.KillById(arg_25_0._tweenIdCategory)

		arg_25_0._tweenIdCategory = nil
	end
end

function var_0_0._onJpBtn1Click(arg_26_0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19001
	})
end

function var_0_0._onJpBtn2Click(arg_27_0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19002
	})
end

return var_0_0
