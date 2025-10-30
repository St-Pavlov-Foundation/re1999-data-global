module("modules.logic.store.view.NormalStoreView", package.seeall)

local var_0_0 = class("NormalStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#scroll_prop/#go_lock")
	arg_1_0._simagelockbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	arg_1_0._gotabreddot1 = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	arg_1_0._golimit = gohelper.findChild(arg_1_0.viewGO, "#go_limit")
	arg_1_0._txtrefreshTime = gohelper.findChildText(arg_1_0.viewGO, "#txt_refreshTime")
	arg_1_0._gosortbtn = gohelper.findChild(arg_1_0.viewGO, "top/#go_sortbtn")
	arg_1_0._gounsort = gohelper.findChild(arg_1_0.viewGO, "top/#go_sortbtn/#go_unsort")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "top/#go_sortbtn/#go_sort")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_sortbtn/txt_sort/btn_tip")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "top/#go_sortbtn/txt_sort/btn_tip/#go_tip")
	arg_1_0._btntipclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_sortbtn/txt_sort/btn_tip/#go_tip/#btn_tipclose")
	arg_1_0._btnsort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_sortbtn/btn_sort")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btntipclose:AddClickListener(arg_2_0._btntipcloseOnClick, arg_2_0)
	arg_2_0._btnsort:AddClickListener(arg_2_0._btsortOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
	arg_3_0._btntipclose:RemoveClickListener()
	arg_3_0._btnsort:RemoveClickListener()
end

function var_0_0._btntipOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotip, true)
end

function var_0_0._btntipcloseOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gotip, false)
end

function var_0_0._btsortOnClick(arg_6_0)
	local var_6_0 = StoreNormalGoodsItemListModel.instance:setSortEquip()

	gohelper.setActive(arg_6_0._gounsort, not var_6_0)
	gohelper.setActive(arg_6_0._gosort, var_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._txtrefreshTime = gohelper.findChildText(arg_7_0.viewGO, "#txt_refreshTime")

	gohelper.setActive(arg_7_0._txtrefreshTime.gameObject, false)
	gohelper.setActive(arg_7_0._gostorecategoryitem, false)

	arg_7_0._lockClick = gohelper.getClickWithAudio(arg_7_0._golock)
	arg_7_0._isLock = false
	arg_7_0._categoryItemContainer = {}

	arg_7_0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function var_0_0._refreshTabs(arg_8_0, arg_8_1, arg_8_2)
	StoreController.instance:readTab(arg_8_1)

	local var_8_0 = arg_8_0._selectSecondTabId
	local var_8_1 = arg_8_0._selectThirdTabId

	arg_8_0._selectSecondTabId = 0
	arg_8_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_8_1) then
		arg_8_1 = arg_8_0.viewContainer:getSelectFirstTabId()
	end

	local var_8_2
	local var_8_3

	var_8_3, arg_8_0._selectSecondTabId, arg_8_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_8_1)

	local var_8_4 = arg_8_0._selectSecondTabId == StoreEnum.StoreId.LimitStore

	if var_8_4 then
		arg_8_0:refreshCurrency()
	else
		local var_8_5 = StoreConfig.instance:getTabConfig(arg_8_0._selectThirdTabId)
		local var_8_6 = StoreConfig.instance:getTabConfig(arg_8_0._selectSecondTabId)
		local var_8_7 = StoreConfig.instance:getTabConfig(arg_8_0.viewContainer:getSelectFirstTabId())

		if var_8_5 and not string.nilorempty(var_8_5.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_5.showCost)
		elseif var_8_6 and not string.nilorempty(var_8_6.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_6.showCost)
		elseif var_8_7 and not string.nilorempty(var_8_7.showCost) then
			arg_8_0.viewContainer:setCurrencyType(var_8_7.showCost)
		else
			arg_8_0.viewContainer:setCurrencyType(nil)
		end
	end

	if not arg_8_2 and var_8_0 == arg_8_0._selectSecondTabId and var_8_1 == arg_8_0._selectThirdTabId then
		return
	end

	local var_8_8 = StoreModel.instance:getSecondTabs(arg_8_0._selectFirstTabId, true, true)

	if var_8_8 and #var_8_8 > 0 then
		for iter_8_0 = 1, #var_8_8 do
			arg_8_0:_refreshSecondTabs(iter_8_0, var_8_8[iter_8_0])
			gohelper.setActive(arg_8_0._categoryItemContainer[iter_8_0].go, true)
		end

		gohelper.setActive(arg_8_0._categoryItemContainer[#var_8_8].go_line, false)

		for iter_8_1 = #var_8_8 + 1, #arg_8_0._categoryItemContainer do
			gohelper.setActive(arg_8_0._categoryItemContainer[iter_8_1].go, false)
		end

		gohelper.setActive(arg_8_0._lineGo, true)
	else
		for iter_8_2 = 1, #arg_8_0._categoryItemContainer do
			gohelper.setActive(arg_8_0._categoryItemContainer[iter_8_2].go, false)
		end

		gohelper.setActive(arg_8_0._lineGo, false)
	end

	arg_8_0:_onRefreshRedDot()
	arg_8_0:_refreshTabDeadLine()
	arg_8_0:_refreshGoods(true)

	if arg_8_0._selectThirdTabId > 0 then
		arg_8_0._isLock = StoreModel.instance:isStoreTabLock(arg_8_0._selectThirdTabId)

		if arg_8_0._isLock then
			local var_8_9 = StoreConfig.instance:getStoreConfig(arg_8_0._selectThirdTabId)

			arg_8_0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(var_8_9.needClearStore).name)
		end

		gohelper.setActive(arg_8_0._golock, arg_8_0._isLock)
	else
		gohelper.setActive(arg_8_0._golock, false)
	end

	arg_8_0._scrollprop.verticalNormalizedPosition = 1

	gohelper.setActive(arg_8_0._golimit, var_8_4)
	gohelper.setActive(arg_8_0._scrollprop.gameObject, not var_8_4)

	local var_8_10 = arg_8_0.storeId == StoreEnum.StoreId.SummonEquipExchange

	if var_8_10 then
		local var_8_11 = StoreNormalGoodsItemListModel.instance:initSortEquip()

		gohelper.setActive(arg_8_0._gounsort, not var_8_11)
		gohelper.setActive(arg_8_0._gosort, var_8_11)
	end

	gohelper.setActive(arg_8_0._gosortbtn, var_8_10)
end

function var_0_0.refreshCurrency(arg_9_0)
	local var_9_0 = StoreConfig.instance:getTabConfig(arg_9_0._selectThirdTabId)
	local var_9_1 = StoreConfig.instance:getTabConfig(arg_9_0._selectSecondTabId)
	local var_9_2 = StoreConfig.instance:getTabConfig(arg_9_0.viewContainer:getSelectFirstTabId())

	if var_9_0 and not string.nilorempty(var_9_0.showCost) then
		arg_9_0.viewContainer:setCurrencyByParams(arg_9_0:packShowCostParam(var_9_0.showCost))
	elseif var_9_1 and not string.nilorempty(var_9_1.showCost) then
		arg_9_0.viewContainer:setCurrencyByParams(arg_9_0:packShowCostParam(var_9_1.showCost))
	elseif var_9_2 and not string.nilorempty(var_9_2.showCost) then
		arg_9_0.viewContainer:setCurrencyByParams(arg_9_0:packShowCostParam(var_9_2.showCost))
	else
		arg_9_0.viewContainer:setCurrencyType(nil)
	end
end

function var_0_0.packShowCostParam(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = string.split(arg_10_1, "#")

	for iter_10_0 = #var_10_1, 1, -1 do
		local var_10_2 = var_10_1[iter_10_0]
		local var_10_3 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_10_2)

		if var_10_3 then
			table.insert(var_10_0, {
				isCurrencySprite = true,
				id = tonumber(var_10_2),
				icon = var_10_3.icon,
				type = MaterialEnum.MaterialType.Item
			})
		end
	end

	return var_10_0
end

function var_0_0._refreshSecondTabs(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._categoryItemContainer[arg_11_1] or arg_11_0:initCategoryItemTable(arg_11_1)

	var_11_0.tabId = arg_11_2.id
	var_11_0.txt_itemcn1.text = arg_11_2.name
	var_11_0.txt_itemcn2.text = arg_11_2.name
	var_11_0.txt_itemen1.text = arg_11_2.nameEn
	var_11_0.txt_itemen2.text = arg_11_2.nameEn

	local var_11_1 = arg_11_0._selectSecondTabId == arg_11_2.id

	gohelper.setActive(arg_11_0._categoryItemContainer[arg_11_1].go_line, true)

	if var_11_1 and arg_11_0._categoryItemContainer[arg_11_1 - 1] then
		gohelper.setActive(arg_11_0._categoryItemContainer[arg_11_1 - 1].go_line, false)
	end

	gohelper.setActive(var_11_0.go_unselected, not var_11_1)
	gohelper.setActive(var_11_0.go_selected, var_11_1)
end

function var_0_0.initCategoryItemTable(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = gohelper.cloneInPlace(arg_12_0._gostorecategoryitem, "item" .. arg_12_1)
	var_12_0.go_unselected = gohelper.findChild(var_12_0.go, "go_unselected")
	var_12_0.go_selected = gohelper.findChild(var_12_0.go, "go_selected")
	var_12_0.go_reddot = gohelper.findChild(var_12_0.go, "#go_tabreddot1")
	var_12_0.go_reddotNormalType = gohelper.findChild(var_12_0.go, "#go_tabreddot1/type1")
	var_12_0.go_reddotActType = gohelper.findChild(var_12_0.go, "#go_tabreddot1/type9")
	var_12_0.txt_itemcn1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemcn1")
	var_12_0.txt_itemen1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemen1")
	var_12_0.txt_itemcn2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemcn2")
	var_12_0.txt_itemen2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemen2")
	var_12_0.go_line = gohelper.findChild(var_12_0.go, "#go_line")
	var_12_0.go_deadline = gohelper.findChild(var_12_0.go, "go_deadline")
	var_12_0.imagetimebg = gohelper.findChildImage(var_12_0.go, "go_deadline/timebg")
	var_12_0.godeadlineEffect = gohelper.findChild(var_12_0.go, "go_deadline/#effect")
	var_12_0.imagetimeicon = gohelper.findChildImage(var_12_0.go, "go_deadline/#txt_time/timeicon")
	var_12_0.txttime = gohelper.findChildText(var_12_0.go, "go_deadline/#txt_time")
	var_12_0.txtformat = gohelper.findChildText(var_12_0.go, "go_deadline/#txt_time/#txt_format")
	var_12_0.btn = gohelper.getClickWithAudio(var_12_0.go, AudioEnum.UI.play_ui_bank_open)
	var_12_0.tabId = 0

	var_12_0.btn:AddClickListener(function(arg_13_0)
		local var_13_0 = arg_13_0.tabId

		arg_12_0:_refreshTabs(var_13_0)

		arg_12_0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(var_13_0)
	end, var_12_0)
	table.insert(arg_12_0._categoryItemContainer, var_12_0)
	gohelper.setActive(var_12_0.go_childItem, false)

	return var_12_0
end

function var_0_0._refreshGoods(arg_14_0, arg_14_1)
	arg_14_0.storeId = 0

	local var_14_0 = StoreConfig.instance:getTabConfig(arg_14_0._selectThirdTabId)

	arg_14_0.storeId = var_14_0 and var_14_0.storeId or 0

	if arg_14_0.storeId == 0 then
		local var_14_1 = StoreConfig.instance:getTabConfig(arg_14_0._selectSecondTabId)

		arg_14_0.storeId = var_14_1 and var_14_1.storeId or 0
	end

	if arg_14_0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	else
		local var_14_2 = StoreModel.instance:getStoreMO(arg_14_0.storeId)

		if var_14_2 then
			local var_14_3 = var_14_2:getGoodsList(true)

			StoreNormalGoodsItemListModel.instance:setMOList(var_14_3, arg_14_0.storeId)
		else
			StoreNormalGoodsItemListModel.instance:setMOList(nil, arg_14_0.storeId)
		end

		if arg_14_1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				arg_14_0.storeId
			})
			arg_14_0.viewContainer:playNormalStoreAnimation()
			arg_14_0.viewContainer:playSummonStoreAnimation()
		end
	end
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._selectFirstTabId = arg_15_0.viewContainer:getSelectFirstTabId()

	local var_15_0 = arg_15_0.viewContainer:getJumpTabId()

	arg_15_0:_refreshTabs(var_15_0, true)
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_15_0._onRefreshRedDot, arg_15_0)
	arg_15_0._lockClick:AddClickListener(arg_15_0._onLockClick, arg_15_0)
	arg_15_0:checkCountdownStatus()
end

function var_0_0._onLockClick(arg_16_0)
	if arg_16_0._isLock then
		local var_16_0 = StoreConfig.instance:getTabConfig(arg_16_0.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, var_16_0)
	end
end

function var_0_0._updateInfo(arg_17_0)
	arg_17_0:_refreshGoods(false)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_18_0._updateInfo, arg_18_0)
	arg_18_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_18_0._onRefreshRedDot, arg_18_0)
	arg_18_0._lockClick:RemoveClickListener()
	arg_18_0:closeTaskCountdown()
end

function var_0_0._onRefreshRedDot(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._categoryItemContainer) do
		local var_19_0, var_19_1 = StoreModel.instance:isTabFirstRedDotShow(iter_19_1.tabId)

		gohelper.setActive(iter_19_1.go_reddot, var_19_0)
		gohelper.setActive(iter_19_1.go_reddotNormalType, not var_19_1)
		gohelper.setActive(iter_19_1.go_reddotActType, var_19_1)
	end
end

function var_0_0.checkCountdownStatus(arg_20_0)
	if arg_20_0._needCountdown then
		TaskDispatcher.cancelTask(arg_20_0._refreshTabDeadLine, arg_20_0)
		TaskDispatcher.runRepeat(arg_20_0._refreshTabDeadLine, arg_20_0, 1)
	end
end

function var_0_0.closeTaskCountdown(arg_21_0)
	if arg_21_0._needCountdown then
		TaskDispatcher.cancelTask(arg_21_0._refreshTabDeadLine, arg_21_0)
	end
end

function var_0_0._refreshTabDeadLine(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._categoryItemContainer) do
		if iter_22_1 ~= nil or iter_22_1.tabId ~= nil then
			local var_22_0 = StoreConfig.instance:getTabConfig(iter_22_1.tabId)
			local var_22_1 = StoreHelper.getRemainExpireTime(var_22_0)

			if var_22_1 > 0 then
				local var_22_2 = false
				local var_22_3

				iter_22_1.txttime.text, iter_22_1.txtformat.text, var_22_3 = TimeUtil.secondToRoughTime(math.floor(var_22_1), true)

				if arg_22_0._refreshTabDeadlineHasDay == nil then
					arg_22_0._refreshTabDeadlineHasDay = {}
				end

				if arg_22_0._refreshTabDeadlineHasDay[iter_22_1.tabId] == nil or arg_22_0._refreshTabDeadlineHasDay[iter_22_1.tabId] ~= var_22_3 then
					UISpriteSetMgr.instance:setCommonSprite(iter_22_1.imagetimebg, var_22_3 and "daojishi_01" or "daojishi_02")
					UISpriteSetMgr.instance:setCommonSprite(iter_22_1.imagetimeicon, var_22_3 and "daojishiicon_01" or "daojishiicon_02")
					SLFramework.UGUI.GuiHelper.SetColor(iter_22_1.txttime, var_22_3 and "#98D687" or "#E99B56")
					SLFramework.UGUI.GuiHelper.SetColor(iter_22_1.txtformat, var_22_3 and "#98D687" or "#E99B56")
					gohelper.setActive(iter_22_1.godeadlineEffect, not var_22_3)

					arg_22_0._refreshTabDeadlineHasDay[iter_22_1.tabId] = var_22_3
				end

				arg_22_0._needCountdown = true
			end

			gohelper.setActive(iter_22_1.go_deadline, var_22_1 > 0)
			gohelper.setActive(iter_22_1.txttime.gameObject, var_22_1 > 0)
		end
	end
end

function var_0_0.onUpdateParam(arg_23_0)
	arg_23_0._selectFirstTabId = arg_23_0.viewContainer:getSelectFirstTabId()

	local var_23_0 = arg_23_0.viewContainer:getJumpTabId()

	arg_23_0:_refreshTabs(var_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._categoryItemContainer and #arg_24_0._categoryItemContainer > 0 then
		for iter_24_0 = 1, #arg_24_0._categoryItemContainer do
			arg_24_0._categoryItemContainer[iter_24_0].btn:RemoveClickListener()
		end
	end

	arg_24_0._simagelockbg:UnLoadImage()
end

return var_0_0
