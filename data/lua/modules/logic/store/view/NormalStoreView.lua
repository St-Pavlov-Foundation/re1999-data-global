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
	arg_1_0._btnsort = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "top/#go_sortbtn/btn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsort:AddClickListener(arg_2_0._btsortOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsort:RemoveClickListener()
end

function var_0_0._btsortOnClick(arg_4_0)
	local var_4_0 = StoreNormalGoodsItemListModel.instance:setSortEquip()

	gohelper.setActive(arg_4_0._gounsort, not var_4_0)
	gohelper.setActive(arg_4_0._gosort, var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txtrefreshTime = gohelper.findChildText(arg_5_0.viewGO, "#txt_refreshTime")

	gohelper.setActive(arg_5_0._txtrefreshTime.gameObject, false)
	gohelper.setActive(arg_5_0._gostorecategoryitem, false)

	arg_5_0._lockClick = gohelper.getClickWithAudio(arg_5_0._golock)
	arg_5_0._isLock = false
	arg_5_0._categoryItemContainer = {}

	arg_5_0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function var_0_0._refreshTabs(arg_6_0, arg_6_1, arg_6_2)
	StoreController.instance:readTab(arg_6_1)

	local var_6_0 = arg_6_0._selectSecondTabId
	local var_6_1 = arg_6_0._selectThirdTabId

	arg_6_0._selectSecondTabId = 0
	arg_6_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_6_1) then
		arg_6_1 = arg_6_0.viewContainer:getSelectFirstTabId()
	end

	local var_6_2
	local var_6_3

	var_6_3, arg_6_0._selectSecondTabId, arg_6_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_6_1)

	local var_6_4 = arg_6_0._selectSecondTabId == StoreEnum.StoreId.LimitStore

	if var_6_4 then
		arg_6_0:refreshCurrency()
	else
		local var_6_5 = StoreConfig.instance:getTabConfig(arg_6_0._selectThirdTabId)
		local var_6_6 = StoreConfig.instance:getTabConfig(arg_6_0._selectSecondTabId)
		local var_6_7 = StoreConfig.instance:getTabConfig(arg_6_0.viewContainer:getSelectFirstTabId())

		if var_6_5 and not string.nilorempty(var_6_5.showCost) then
			arg_6_0.viewContainer:setCurrencyType(var_6_5.showCost)
		elseif var_6_6 and not string.nilorempty(var_6_6.showCost) then
			arg_6_0.viewContainer:setCurrencyType(var_6_6.showCost)
		elseif var_6_7 and not string.nilorempty(var_6_7.showCost) then
			arg_6_0.viewContainer:setCurrencyType(var_6_7.showCost)
		else
			arg_6_0.viewContainer:setCurrencyType(nil)
		end
	end

	if not arg_6_2 and var_6_0 == arg_6_0._selectSecondTabId and var_6_1 == arg_6_0._selectThirdTabId then
		return
	end

	local var_6_8 = StoreModel.instance:getSecondTabs(arg_6_0._selectFirstTabId, true, true)

	if var_6_8 and #var_6_8 > 0 then
		for iter_6_0 = 1, #var_6_8 do
			arg_6_0:_refreshSecondTabs(iter_6_0, var_6_8[iter_6_0])
			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_0].go, true)
		end

		gohelper.setActive(arg_6_0._categoryItemContainer[#var_6_8].go_line, false)

		for iter_6_1 = #var_6_8 + 1, #arg_6_0._categoryItemContainer do
			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_1].go, false)
		end

		gohelper.setActive(arg_6_0._lineGo, true)
	else
		for iter_6_2 = 1, #arg_6_0._categoryItemContainer do
			gohelper.setActive(arg_6_0._categoryItemContainer[iter_6_2].go, false)
		end

		gohelper.setActive(arg_6_0._lineGo, false)
	end

	arg_6_0:_onRefreshRedDot()
	arg_6_0:_refreshTabDeadLine()
	arg_6_0:_refreshGoods(true)

	if arg_6_0._selectThirdTabId > 0 then
		arg_6_0._isLock = StoreModel.instance:isStoreTabLock(arg_6_0._selectThirdTabId)

		if arg_6_0._isLock then
			local var_6_9 = StoreConfig.instance:getStoreConfig(arg_6_0._selectThirdTabId)

			arg_6_0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(var_6_9.needClearStore).name)
		end

		gohelper.setActive(arg_6_0._golock, arg_6_0._isLock)
	else
		gohelper.setActive(arg_6_0._golock, false)
	end

	arg_6_0._scrollprop.verticalNormalizedPosition = 1

	gohelper.setActive(arg_6_0._golimit, var_6_4)
	gohelper.setActive(arg_6_0._scrollprop.gameObject, not var_6_4)

	local var_6_10 = arg_6_0.storeId == StoreEnum.StoreId.SummonEquipExchange

	if var_6_10 then
		local var_6_11 = StoreNormalGoodsItemListModel.instance:initSortEquip()

		gohelper.setActive(arg_6_0._gounsort, not var_6_11)
		gohelper.setActive(arg_6_0._gosort, var_6_11)
	end

	gohelper.setActive(arg_6_0._gosortbtn, var_6_10)
end

function var_0_0.refreshCurrency(arg_7_0)
	local var_7_0 = StoreConfig.instance:getTabConfig(arg_7_0._selectThirdTabId)
	local var_7_1 = StoreConfig.instance:getTabConfig(arg_7_0._selectSecondTabId)
	local var_7_2 = StoreConfig.instance:getTabConfig(arg_7_0.viewContainer:getSelectFirstTabId())

	if var_7_0 and not string.nilorempty(var_7_0.showCost) then
		arg_7_0.viewContainer:setCurrencyByParams(arg_7_0:packShowCostParam(var_7_0.showCost))
	elseif var_7_1 and not string.nilorempty(var_7_1.showCost) then
		arg_7_0.viewContainer:setCurrencyByParams(arg_7_0:packShowCostParam(var_7_1.showCost))
	elseif var_7_2 and not string.nilorempty(var_7_2.showCost) then
		arg_7_0.viewContainer:setCurrencyByParams(arg_7_0:packShowCostParam(var_7_2.showCost))
	else
		arg_7_0.viewContainer:setCurrencyType(nil)
	end
end

function var_0_0.packShowCostParam(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = string.split(arg_8_1, "#")

	for iter_8_0 = #var_8_1, 1, -1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_8_2)

		if var_8_3 then
			table.insert(var_8_0, {
				isCurrencySprite = true,
				id = tonumber(var_8_2),
				icon = var_8_3.icon,
				type = MaterialEnum.MaterialType.Item
			})
		end
	end

	return var_8_0
end

function var_0_0._refreshSecondTabs(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._categoryItemContainer[arg_9_1] or arg_9_0:initCategoryItemTable(arg_9_1)

	var_9_0.tabId = arg_9_2.id
	var_9_0.txt_itemcn1.text = arg_9_2.name
	var_9_0.txt_itemcn2.text = arg_9_2.name
	var_9_0.txt_itemen1.text = arg_9_2.nameEn
	var_9_0.txt_itemen2.text = arg_9_2.nameEn

	local var_9_1 = arg_9_0._selectSecondTabId == arg_9_2.id

	gohelper.setActive(arg_9_0._categoryItemContainer[arg_9_1].go_line, true)

	if var_9_1 and arg_9_0._categoryItemContainer[arg_9_1 - 1] then
		gohelper.setActive(arg_9_0._categoryItemContainer[arg_9_1 - 1].go_line, false)
	end

	gohelper.setActive(var_9_0.go_unselected, not var_9_1)
	gohelper.setActive(var_9_0.go_selected, var_9_1)
end

function var_0_0.initCategoryItemTable(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.go = gohelper.cloneInPlace(arg_10_0._gostorecategoryitem, "item" .. arg_10_1)
	var_10_0.go_unselected = gohelper.findChild(var_10_0.go, "go_unselected")
	var_10_0.go_selected = gohelper.findChild(var_10_0.go, "go_selected")
	var_10_0.go_reddot = gohelper.findChild(var_10_0.go, "#go_tabreddot1")
	var_10_0.go_reddotNormalType = gohelper.findChild(var_10_0.go, "#go_tabreddot1/type1")
	var_10_0.go_reddotActType = gohelper.findChild(var_10_0.go, "#go_tabreddot1/type9")
	var_10_0.txt_itemcn1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemcn1")
	var_10_0.txt_itemen1 = gohelper.findChildText(var_10_0.go, "go_unselected/txt_itemen1")
	var_10_0.txt_itemcn2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemcn2")
	var_10_0.txt_itemen2 = gohelper.findChildText(var_10_0.go, "go_selected/txt_itemen2")
	var_10_0.go_line = gohelper.findChild(var_10_0.go, "#go_line")
	var_10_0.go_deadline = gohelper.findChild(var_10_0.go, "go_deadline")
	var_10_0.imagetimebg = gohelper.findChildImage(var_10_0.go, "go_deadline/timebg")
	var_10_0.godeadlineEffect = gohelper.findChild(var_10_0.go, "go_deadline/#effect")
	var_10_0.imagetimeicon = gohelper.findChildImage(var_10_0.go, "go_deadline/#txt_time/timeicon")
	var_10_0.txttime = gohelper.findChildText(var_10_0.go, "go_deadline/#txt_time")
	var_10_0.txtformat = gohelper.findChildText(var_10_0.go, "go_deadline/#txt_time/#txt_format")
	var_10_0.btn = gohelper.getClickWithAudio(var_10_0.go, AudioEnum.UI.play_ui_bank_open)
	var_10_0.tabId = 0

	var_10_0.btn:AddClickListener(function(arg_11_0)
		local var_11_0 = arg_11_0.tabId

		arg_10_0:_refreshTabs(var_11_0)

		arg_10_0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(var_11_0)
	end, var_10_0)
	table.insert(arg_10_0._categoryItemContainer, var_10_0)
	gohelper.setActive(var_10_0.go_childItem, false)

	return var_10_0
end

function var_0_0._refreshGoods(arg_12_0, arg_12_1)
	arg_12_0.storeId = 0

	local var_12_0 = StoreConfig.instance:getTabConfig(arg_12_0._selectThirdTabId)

	arg_12_0.storeId = var_12_0 and var_12_0.storeId or 0

	if arg_12_0.storeId == 0 then
		local var_12_1 = StoreConfig.instance:getTabConfig(arg_12_0._selectSecondTabId)

		arg_12_0.storeId = var_12_1 and var_12_1.storeId or 0
	end

	if arg_12_0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	else
		local var_12_2 = StoreModel.instance:getStoreMO(arg_12_0.storeId)

		if var_12_2 then
			local var_12_3 = var_12_2:getGoodsList(true)

			StoreNormalGoodsItemListModel.instance:setMOList(var_12_3, arg_12_0.storeId)
		else
			StoreNormalGoodsItemListModel.instance:setMOList(nil, arg_12_0.storeId)
		end

		if arg_12_1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				arg_12_0.storeId
			})
			arg_12_0.viewContainer:playNormalStoreAnimation()
			arg_12_0.viewContainer:playSummonStoreAnimation()
		end
	end
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0._selectFirstTabId = arg_13_0.viewContainer:getSelectFirstTabId()

	local var_13_0 = arg_13_0.viewContainer:getJumpTabId()

	arg_13_0:_refreshTabs(var_13_0, true)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_13_0._updateInfo, arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_13_0._updateInfo, arg_13_0)
	arg_13_0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_13_0._updateInfo, arg_13_0)
	arg_13_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_13_0._onRefreshRedDot, arg_13_0)
	arg_13_0._lockClick:AddClickListener(arg_13_0._onLockClick, arg_13_0)
	arg_13_0:checkCountdownStatus()
end

function var_0_0._onLockClick(arg_14_0)
	if arg_14_0._isLock then
		local var_14_0 = StoreConfig.instance:getTabConfig(arg_14_0.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, var_14_0)
	end
end

function var_0_0._updateInfo(arg_15_0)
	arg_15_0:_refreshGoods(false)
end

function var_0_0.onClose(arg_16_0)
	arg_16_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_16_0._updateInfo, arg_16_0)
	arg_16_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_16_0._updateInfo, arg_16_0)
	arg_16_0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_16_0._updateInfo, arg_16_0)
	arg_16_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_16_0._onRefreshRedDot, arg_16_0)
	arg_16_0._lockClick:RemoveClickListener()
	arg_16_0:closeTaskCountdown()
end

function var_0_0._onRefreshRedDot(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._categoryItemContainer) do
		local var_17_0, var_17_1 = StoreModel.instance:isTabFirstRedDotShow(iter_17_1.tabId)

		gohelper.setActive(iter_17_1.go_reddot, var_17_0)
		gohelper.setActive(iter_17_1.go_reddotNormalType, not var_17_1)
		gohelper.setActive(iter_17_1.go_reddotActType, var_17_1)
	end
end

function var_0_0.checkCountdownStatus(arg_18_0)
	if arg_18_0._needCountdown then
		TaskDispatcher.cancelTask(arg_18_0._refreshTabDeadLine, arg_18_0)
		TaskDispatcher.runRepeat(arg_18_0._refreshTabDeadLine, arg_18_0, 1)
	end
end

function var_0_0.closeTaskCountdown(arg_19_0)
	if arg_19_0._needCountdown then
		TaskDispatcher.cancelTask(arg_19_0._refreshTabDeadLine, arg_19_0)
	end
end

function var_0_0._refreshTabDeadLine(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._categoryItemContainer) do
		if iter_20_1 ~= nil or iter_20_1.tabId ~= nil then
			local var_20_0 = StoreConfig.instance:getTabConfig(iter_20_1.tabId)
			local var_20_1 = StoreHelper.getRemainExpireTime(var_20_0)

			if var_20_1 > 0 then
				local var_20_2 = false
				local var_20_3

				iter_20_1.txttime.text, iter_20_1.txtformat.text, var_20_3 = TimeUtil.secondToRoughTime(math.floor(var_20_1), true)

				if arg_20_0._refreshTabDeadlineHasDay == nil then
					arg_20_0._refreshTabDeadlineHasDay = {}
				end

				if arg_20_0._refreshTabDeadlineHasDay[iter_20_1.tabId] == nil or arg_20_0._refreshTabDeadlineHasDay[iter_20_1.tabId] ~= var_20_3 then
					UISpriteSetMgr.instance:setCommonSprite(iter_20_1.imagetimebg, var_20_3 and "daojishi_01" or "daojishi_02")
					UISpriteSetMgr.instance:setCommonSprite(iter_20_1.imagetimeicon, var_20_3 and "daojishiicon_01" or "daojishiicon_02")
					SLFramework.UGUI.GuiHelper.SetColor(iter_20_1.txttime, var_20_3 and "#98D687" or "#E99B56")
					SLFramework.UGUI.GuiHelper.SetColor(iter_20_1.txtformat, var_20_3 and "#98D687" or "#E99B56")
					gohelper.setActive(iter_20_1.godeadlineEffect, not var_20_3)

					arg_20_0._refreshTabDeadlineHasDay[iter_20_1.tabId] = var_20_3
				end

				arg_20_0._needCountdown = true
			end

			gohelper.setActive(iter_20_1.go_deadline, var_20_1 > 0)
			gohelper.setActive(iter_20_1.txttime.gameObject, var_20_1 > 0)
		end
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0._selectFirstTabId = arg_21_0.viewContainer:getSelectFirstTabId()

	local var_21_0 = arg_21_0.viewContainer:getJumpTabId()

	arg_21_0:_refreshTabs(var_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._categoryItemContainer and #arg_22_0._categoryItemContainer > 0 then
		for iter_22_0 = 1, #arg_22_0._categoryItemContainer do
			arg_22_0._categoryItemContainer[iter_22_0].btn:RemoveClickListener()
		end
	end

	arg_22_0._simagelockbg:UnLoadImage()
end

return var_0_0
