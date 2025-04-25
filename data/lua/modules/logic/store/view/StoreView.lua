module("modules.logic.store.view.StoreView", package.seeall)

slot0 = class("StoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_store/bg/#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_store/bg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_store/bg/#simage_righticon")
	slot0._gobtnjapan = gohelper.findChild(slot0.viewGO, "#go_btnjapan")
	slot0._btnJp1 = gohelper.getClickWithAudio(gohelper.findChild(slot0._gobtnjapan, "#btn_btn1"))
	slot0._btnJp2 = gohelper.getClickWithAudio(gohelper.findChild(slot0._gobtnjapan, "#btn_btn2"))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnJp1:AddClickListener(slot0._onJpBtn1Click, slot0)
	slot0._btnJp2:AddClickListener(slot0._onJpBtn2Click, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnJp1:RemoveClickListener()
	slot0._btnJp2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._gobigTypeItem = gohelper.findChild(slot0.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem")
	slot0._gobigTypeItem1 = gohelper.findChild(slot0.viewGO, "scroll_bigType/viewport/content/#go_bigTypeItem1")
	slot0._bigTypeItemContent = gohelper.findChild(slot0.viewGO, "scroll_bigType/viewport/content").transform

	slot0._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("full/shangcheng_bj"))
	slot0._simagelefticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_leftdown2"))
	slot0._simagerighticon:LoadImage(ResUrl.getStoreBottomBgIcon("bg_right3"))

	slot0._scrollbigType = gohelper.findChildScrollRect(slot0.viewGO, "scroll_bigType")
	slot0._tabsContainer = {}

	for slot5 = 1, #StoreModel.instance:getFirstTabs(true, true) do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.cloneInPlace(slot0._gobigTypeItem, "bigTypeItem" .. slot5)
		slot6.reddot = gohelper.findChild(slot6.go, "go_tabreddot")
		slot6.reddotNormalType = gohelper.findChild(slot6.go, "go_tabreddot/type1")
		slot6.reddotActType = gohelper.findChild(slot6.go, "go_tabreddot/type9")
		slot6.goselected = gohelper.findChild(slot6.go, "go_selected")
		slot6.iconselected = gohelper.findChildImage(slot6.goselected, "itemicon2")
		slot6.gounselected = gohelper.findChild(slot6.go, "go_unselected")
		slot6.iconunselected = gohelper.findChildImage(slot6.gounselected, "itemicon1")
		slot6.txtnamecn1 = gohelper.findChildText(slot6.go, "go_selected/txt_itemcn2")
		slot6.txtnameen1 = gohelper.findChildText(slot6.go, "go_selected/txt_itemen2")
		slot6.txtnamecn2 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemcn1")
		slot6.txtnameen2 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemen1")
		slot6.clickArea = gohelper.findChild(slot6.go, "clickArea")
		slot6.godeadline = gohelper.findChild(slot6.go, "go_deadline")
		slot6.godeadlineEffect = gohelper.findChild(slot6.godeadline, "#effect")
		slot6.txttime = gohelper.findChildText(slot6.godeadline, "#txt_time")
		slot6.txtformat = gohelper.findChildText(slot6.godeadline, "#txt_time/#txt_format")
		slot6.imagetimebg = gohelper.findChildImage(slot6.godeadline, "timebg")
		slot6.imagetimeicon = gohelper.findChildImage(slot6.godeadline, "#txt_time/timeicon")
		slot6.btn = gohelper.getClickWithAudio(slot6.clickArea, AudioEnum.UI.play_ui_plot_common)

		slot6.btn:AddClickListener(function (slot0)
			slot1 = slot0.tabId

			uv0:_refreshTabs(slot1)
			StoreController.instance:statSwitchStore(slot1)
		end, slot6)
		table.insert(slot0._tabsContainer, slot6)
	end

	slot2 = slot0:getUserDataTb_()
	slot2.go = slot0._gobigTypeItem1
	slot2.reddot = gohelper.findChild(slot2.go, "go_tabreddot")
	slot2.goselected = gohelper.findChild(slot2.go, "go_selected")
	slot2.iconselected = gohelper.findChildImage(slot2.goselected, "itemicon2")
	slot2.gounselected = gohelper.findChild(slot2.go, "go_unselected")
	slot2.iconunselected = gohelper.findChildImage(slot2.gounselected, "itemicon1")
	slot2.txtnamecn1 = gohelper.findChildText(slot2.go, "go_selected/txt_itemcn2")
	slot2.txtnameen1 = gohelper.findChildText(slot2.go, "go_selected/txt_itemen2")
	slot2.txtnamecn2 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemcn1")
	slot2.txtnameen2 = gohelper.findChildText(slot2.go, "go_unselected/txt_itemen1")
	slot2.clickArea = gohelper.findChild(slot2.go, "clickArea")
	slot2.btn = gohelper.getClickWithAudio(slot2.clickArea, AudioEnum.UI.play_ui_plot_common)

	slot2.btn:AddClickListener(function (slot0)
		slot1 = slot0.tabId

		uv0:_refreshTabs(slot1)
		StoreController.instance:statSwitchStore(slot1)
	end, slot2)

	slot0._tabTableSP1 = slot2

	gohelper.setActive(slot0._gobigTypeItem, false)
	gohelper.setActive(slot0._gobigTypeItem1, false)
	gohelper.setActive(slot0._gobtnjapan, false)
end

function slot0._refreshTabs(slot0, slot1, slot2)
	StoreController.instance:readTab(slot1)

	slot3 = nil

	if StoreModel.instance:isTabOpen(slot1) == false then
		slot2 = nil
		slot1 = StoreModel.instance:getFirstTabs(true, true)[1].id
	end

	slot4 = slot0._selectFirstTabId == nil
	slot0._selectFirstTabId = StoreEnum.DefaultTabId
	slot0._selectFirstTabId = StoreModel.instance:jumpTabIdToSelectTabId(slot1)

	slot0.viewContainer:selectTabView(slot1, slot0._selectFirstTabId, slot2, slot0._selectFirstTabId == slot0._selectFirstTabId)

	slot6 = math.min(#(slot3 or StoreModel.instance:getFirstTabs(true, true)), #slot0._tabsContainer)

	if slot5 == slot0._selectFirstTabId and slot0._totalTabCount == slot6 then
		return
	end

	slot0._totalTabCount = slot6

	if slot3 and #slot3 > 0 then
		slot0._needCountdown = false
		slot10 = #slot0._tabsContainer

		for slot10 = 1, math.min(#slot3, slot10) do
			slot12 = slot0._tabsContainer[slot10]

			if slot3[slot10].id == StoreEnum.DefaultTabId then
				gohelper.setSibling(slot0._tabTableSP1.go, gohelper.getSibling(slot0._tabsContainer[slot10].go))
				gohelper.setActive(slot0._tabsContainer[slot10].go, false)
			end

			slot12.tabId = slot11.id
			slot13 = slot11.id == slot0._selectFirstTabId
			slot12.txtnamecn1.text = slot11.name
			slot12.txtnamecn2.text = slot11.name
			slot12.txtnameen1.text = slot11.nameEn
			slot12.txtnameen2.text = slot11.nameEn

			UISpriteSetMgr.instance:setStoreGoodsSprite(slot12.iconselected, slot12.tabId)
			UISpriteSetMgr.instance:setStoreGoodsSprite(slot12.iconunselected, slot12.tabId)
			gohelper.setActive(slot12.goselected, slot13)
			gohelper.setActive(slot12.gounselected, not slot13)
			gohelper.setActive(slot12.go, true)
			slot0:refreshTimeDeadline(slot11, slot12)

			if slot13 then
				slot0:_handleTabSet(slot10, slot4)
			end
		end

		slot0:checkCountdownStatus()

		for slot10 = #slot3 + 1, #slot0._tabsContainer do
			gohelper.setActive(slot0._tabsContainer[slot10].go, false)
		end
	else
		for slot10 = 1, #slot0._tabsContainer do
			gohelper.setActive(slot0._tabsContainer[slot10].go, false)
		end
	end

	gohelper.setActive(slot0._gobtnjapan, slot0:_isShowBtnJp())
end

function slot0._isShowBtnJp(slot0)
	if not SettingsModel.instance:isJpRegion() then
		return false
	end

	return slot0._selectFirstTabId == StoreEnum.ChargeStoreTabId or slot1 == StoreEnum.StoreId.Package
end

function slot0.refreshTimeDeadline(slot0, slot1, slot2)
	if not slot2.godeadline or gohelper.isNil(slot2.godeadline) or slot1 == nil then
		return
	end

	slot3 = false
	slot4 = StoreHelper.getRemainExpireTime(slot1)
	slot5 = StoreModel.instance:isTabMainRedDotShow(slot1.id)
	slot6 = false

	if StoreEnum.SummonExchange == slot1.id then
		slot4 = StoreHelper.getRemainExpireTimeDeep(slot1)
	end

	if StoreEnum.SummonExchange == slot1.id and slot1.id ~= slot0._selectFirstTabId and not slot5 and slot4 and slot4 > 0 and slot4 <= TimeUtil.OneDaySecond * 7 then
		gohelper.setActive(slot2.godeadline, true)
		gohelper.setActive(slot2.txttime.gameObject, true)

		slot2.txttime.text, slot2.txtformat.text, slot11 = TimeUtil.secondToRoughTime(math.floor(slot4), true)

		UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimebg, slot11 and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimeicon, slot3 and "daojishiicon_01" or "daojishiicon_02")
		SLFramework.UGUI.GuiHelper.SetColor(slot2.txttime, slot3 and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(slot2.txtformat, slot3 and "#98D687" or "#E99B56")
		gohelper.setActive(slot2.godeadlineEffect, not slot3)

		slot6 = true
	elseif StoreEnum.StoreId.Skin == slot1.storeId then
		slot4 = 0

		if ItemModel.instance:getItemsBySubType(ItemEnum.SubType.SkinTicket)[1] and ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot7[1].id) and not string.nilorempty(slot8.expireTime) and math.floor(TimeUtil.stringToTimestamp(slot8.expireTime) - ServerTime.now()) >= 0 and slot10 <= 259200 then
			slot4 = slot10
		end

		if slot4 > 0 then
			gohelper.setActive(slot2.godeadline, true)
			gohelper.setActive(slot2.txttime.gameObject, true)

			slot2.txttime.text, slot2.txtformat.text, slot12 = TimeUtil.secondToRoughTime(math.floor(slot4), true)

			UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimebg, slot12 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimeicon, slot3 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(slot2.txttime, slot3 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(slot2.txtformat, slot3 and "#98D687" or "#E99B56")
			gohelper.setActive(slot2.godeadlineEffect, not slot3)

			slot6 = true
		else
			gohelper.setActive(slot2.godeadline, false)
			gohelper.setActive(slot2.txttime.gameObject, false)
		end
	else
		gohelper.setActive(slot2.godeadline, false)
		gohelper.setActive(slot2.txttime.gameObject, false)
	end

	slot0._needCountdown = slot6
end

function slot0.onOpen(slot0)
	if not StoreModel.instance:isTabOpen(slot0.viewParam and slot0.viewParam.jumpTab or StoreEnum.DefaultTabId) then
		slot1 = StoreEnum.DefaultTabId
	end

	slot0:_refreshTabs(slot1, slot0.viewParam.jumpGoodsId)
	slot0:_onRefreshRedDot()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._OnDailyRefresh, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDay, slot0._OnDailyRefresh, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._onStoreInfoChanged, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._onRefreshRedDot, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.PlayShowStoreAnim, slot0._onPlayStoreInAnim, slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.PlayHideStoreAnim, slot0._onPlayStoreOutAnim, slot0)
	StoreController.instance:statSwitchStore(slot1)
end

function slot0._onPlayStoreInAnim(slot0)
	slot0._viewAnim:Play("storeview_show", 0, 0)
end

function slot0._onPlayStoreOutAnim(slot0)
	slot0._viewAnim:Play("storeview_hide", 0, 0)
end

function slot0._onRefreshRedDot(slot0)
	slot0._needCountdown = false

	for slot4, slot5 in pairs(slot0._tabsContainer) do
		slot6, slot7 = StoreModel.instance:isTabMainRedDotShow(slot5.tabId)

		gohelper.setActive(slot5.reddot, slot6)
		gohelper.setActive(slot5.reddotNormalType, not slot7)
		gohelper.setActive(slot5.reddotActType, slot7)
		slot0:refreshTimeDeadline(StoreConfig.instance:getTabConfig(slot5.tabId), slot5)
	end

	slot0:checkCountdownStatus()
	gohelper.setActive(slot0._tabTableSP1.reddot, StoreModel.instance:isTabMainRedDotShow(slot0._tabTableSP1.tabId))
end

function slot0._OnDailyRefresh(slot0)
	ChargeRpc.instance:sendGetChargeInfoRequest()
	StoreRpc.instance:sendGetStoreInfosRequest(nil, slot0._handleDailyRefreshReceive, slot0)
end

function slot0._onStoreInfoChanged(slot0)
	slot0:_onRefreshRedDot()

	slot2 = #DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore) <= 0

	if slot0._hasDecorateGoods and slot2 then
		slot0:closeThis()
	end

	slot0._hasDecorateGoods = not slot2
end

function slot0._handleDailyRefreshReceive(slot0)
	slot0:_refreshTabs(slot0._selectFirstTabId)
	slot0:_onRefreshRedDot()
end

function slot0.checkCountdownStatus(slot0)
	if slot0._needCountdown and not slot0._countdownRepeat then
		TaskDispatcher.runRepeat(slot0.refreshCountdown, slot0, 1)

		slot0._countdownRepeat = true
	elseif not slot0._needCountdown and slot0._countdownRepeat then
		TaskDispatcher.cancelTask(slot0.refreshCountdown, slot0)

		slot0._countdownRepeat = false
	end
end

function slot0.refreshCountdown(slot0)
	if not slot0._tabsContainer then
		return
	end

	for slot4, slot5 in pairs(slot0._tabsContainer) do
		if slot5.tabId then
			slot0:refreshTimeDeadline(StoreConfig.instance:getTabConfig(slot5.tabId), slot5)
		end
	end
end

function slot0.onClose(slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0._OnDailyRefresh, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDay, slot0._OnDailyRefresh, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, slot0._onRefreshRedDot, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, slot0._onStoreInfoChanged, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, slot0._onRefreshRedDot, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.PlayShowStoreAnim, slot0._onPlayStoreInAnim, slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.PlayHideStoreAnim, slot0._onPlayStoreOutAnim, slot0)
	StoreController.instance:statExitStore()

	slot0._needCountdown = false

	slot0:checkCountdownStatus()
	slot0:killTween()
end

function slot0.onUpdateParam(slot0)
	if not StoreModel.instance:isTabOpen(slot0.viewParam and slot0.viewParam.jumpTab or StoreEnum.DefaultTabId) then
		slot1 = StoreEnum.DefaultTabId
	end

	slot0:_refreshTabs(slot1, slot0.viewParam.jumpGoodsId)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()

	if slot0._tabsContainer and #slot0._tabsContainer > 0 then
		for slot4 = 1, #slot0._tabsContainer do
			slot0._tabsContainer[slot4].btn:RemoveClickListener()
		end
	end

	slot0._tabTableSP1.btn:RemoveClickListener()
end

slot0.TweenTime = 0.1
slot0.OffY = 19
slot0.ItemH = 120
slot0.ItemSpace = -6.5
slot0.ListH = 764.5

function slot0._handleTabSet(slot0, slot1, slot2)
	slot3 = uv0.OffY + (uv0.ItemH + uv0.ItemSpace) * 6

	if recthelper.getAnchorY(slot0._bigTypeItemContent) > uv0.OffY + (uv0.ItemH + uv0.ItemSpace) * (slot1 - 1) - uv0.OffY or slot5 + uv0.ItemH > slot4 + uv0.ListH then
		if slot4 < slot5 - uv0.OffY then
			slot6 = slot5 - uv0.ListH + uv0.ItemH - uv0.OffY
		end

		if slot2 then
			recthelper.setAnchorY(slot0._bigTypeItemContent, slot6)
		else
			slot0:killTween()

			slot0._tweenIdCategory = ZProj.TweenHelper.DOTweenFloat(slot4, slot6, uv0.TweenTime, slot0.onTweenCategory, slot0.onTweenFinishCategory, slot0)
		end
	end
end

function slot0.onTweenCategory(slot0, slot1)
	if not gohelper.isNil(slot0._scrollbigType) then
		recthelper.setAnchorY(slot0._bigTypeItemContent, slot1)
	end
end

function slot0.onTweenFinishCategory(slot0)
	slot0:killTween()
end

function slot0.killTween(slot0)
	if slot0._tweenIdCategory then
		ZProj.TweenHelper.KillById(slot0._tweenIdCategory)

		slot0._tweenIdCategory = nil
	end
end

function slot0._onJpBtn1Click(slot0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19001
	})
end

function slot0._onJpBtn2Click(slot0)
	ViewMgr.instance:openView(ViewName.LawDescriptionView, {
		id = 19002
	})
end

return slot0
