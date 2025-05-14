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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtrefreshTime = gohelper.findChildText(arg_4_0.viewGO, "#txt_refreshTime")

	gohelper.setActive(arg_4_0._txtrefreshTime.gameObject, false)
	gohelper.setActive(arg_4_0._gostorecategoryitem, false)

	arg_4_0._lockClick = gohelper.getClickWithAudio(arg_4_0._golock)
	arg_4_0._isLock = false
	arg_4_0._categoryItemContainer = {}

	arg_4_0._simagelockbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_weijiesuodiban"))
end

function var_0_0._refreshTabs(arg_5_0, arg_5_1, arg_5_2)
	StoreController.instance:readTab(arg_5_1)

	local var_5_0 = arg_5_0._selectSecondTabId
	local var_5_1 = arg_5_0._selectThirdTabId

	arg_5_0._selectSecondTabId = 0
	arg_5_0._selectThirdTabId = 0

	if not StoreModel.instance:isTabOpen(arg_5_1) then
		arg_5_1 = arg_5_0.viewContainer:getSelectFirstTabId()
	end

	local var_5_2
	local var_5_3

	var_5_3, arg_5_0._selectSecondTabId, arg_5_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_5_1)

	local var_5_4 = arg_5_0._selectSecondTabId == StoreEnum.StoreId.LimitStore

	if var_5_4 then
		arg_5_0:refreshCurrency()
	else
		local var_5_5 = StoreConfig.instance:getTabConfig(arg_5_0._selectThirdTabId)
		local var_5_6 = StoreConfig.instance:getTabConfig(arg_5_0._selectSecondTabId)
		local var_5_7 = StoreConfig.instance:getTabConfig(arg_5_0.viewContainer:getSelectFirstTabId())

		if var_5_5 and not string.nilorempty(var_5_5.showCost) then
			arg_5_0.viewContainer:setCurrencyType(var_5_5.showCost)
		elseif var_5_6 and not string.nilorempty(var_5_6.showCost) then
			arg_5_0.viewContainer:setCurrencyType(var_5_6.showCost)
		elseif var_5_7 and not string.nilorempty(var_5_7.showCost) then
			arg_5_0.viewContainer:setCurrencyType(var_5_7.showCost)
		else
			arg_5_0.viewContainer:setCurrencyType(nil)
		end
	end

	if not arg_5_2 and var_5_0 == arg_5_0._selectSecondTabId and var_5_1 == arg_5_0._selectThirdTabId then
		return
	end

	local var_5_8 = StoreModel.instance:getSecondTabs(arg_5_0._selectFirstTabId, true, true)

	if var_5_8 and #var_5_8 > 0 then
		for iter_5_0 = 1, #var_5_8 do
			arg_5_0:_refreshSecondTabs(iter_5_0, var_5_8[iter_5_0])
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_0].go, true)
		end

		gohelper.setActive(arg_5_0._categoryItemContainer[#var_5_8].go_line, false)

		for iter_5_1 = #var_5_8 + 1, #arg_5_0._categoryItemContainer do
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_1].go, false)
		end

		gohelper.setActive(arg_5_0._lineGo, true)
	else
		for iter_5_2 = 1, #arg_5_0._categoryItemContainer do
			gohelper.setActive(arg_5_0._categoryItemContainer[iter_5_2].go, false)
		end

		gohelper.setActive(arg_5_0._lineGo, false)
	end

	arg_5_0:_onRefreshRedDot()
	arg_5_0:_refreshTabDeadLine()
	arg_5_0:_refreshGoods(true)

	if arg_5_0._selectThirdTabId > 0 then
		arg_5_0._isLock = StoreModel.instance:isStoreTabLock(arg_5_0._selectThirdTabId)

		if arg_5_0._isLock then
			local var_5_9 = StoreConfig.instance:getStoreConfig(arg_5_0._selectThirdTabId)

			arg_5_0._txtLockText.text = string.format(luaLang("lock_store_text"), StoreConfig.instance:getTabConfig(var_5_9.needClearStore).name)
		end

		gohelper.setActive(arg_5_0._golock, arg_5_0._isLock)
	else
		gohelper.setActive(arg_5_0._golock, false)
	end

	arg_5_0._scrollprop.verticalNormalizedPosition = 1

	gohelper.setActive(arg_5_0._golimit, var_5_4)
	gohelper.setActive(arg_5_0._scrollprop.gameObject, not var_5_4)
end

function var_0_0.refreshCurrency(arg_6_0)
	local var_6_0 = StoreConfig.instance:getTabConfig(arg_6_0._selectThirdTabId)
	local var_6_1 = StoreConfig.instance:getTabConfig(arg_6_0._selectSecondTabId)
	local var_6_2 = StoreConfig.instance:getTabConfig(arg_6_0.viewContainer:getSelectFirstTabId())

	if var_6_0 and not string.nilorempty(var_6_0.showCost) then
		arg_6_0.viewContainer:setCurrencyByParams(arg_6_0:packShowCostParam(var_6_0.showCost))
	elseif var_6_1 and not string.nilorempty(var_6_1.showCost) then
		arg_6_0.viewContainer:setCurrencyByParams(arg_6_0:packShowCostParam(var_6_1.showCost))
	elseif var_6_2 and not string.nilorempty(var_6_2.showCost) then
		arg_6_0.viewContainer:setCurrencyByParams(arg_6_0:packShowCostParam(var_6_2.showCost))
	else
		arg_6_0.viewContainer:setCurrencyType(nil)
	end
end

function var_0_0.packShowCostParam(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = string.split(arg_7_1, "#")

	for iter_7_0 = #var_7_1, 1, -1 do
		local var_7_2 = var_7_1[iter_7_0]
		local var_7_3 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_7_2)

		if var_7_3 then
			table.insert(var_7_0, {
				isCurrencySprite = true,
				id = tonumber(var_7_2),
				icon = var_7_3.icon,
				type = MaterialEnum.MaterialType.Item
			})
		end
	end

	return var_7_0
end

function var_0_0._refreshSecondTabs(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._categoryItemContainer[arg_8_1] or arg_8_0:initCategoryItemTable(arg_8_1)

	var_8_0.tabId = arg_8_2.id
	var_8_0.txt_itemcn1.text = arg_8_2.name
	var_8_0.txt_itemcn2.text = arg_8_2.name
	var_8_0.txt_itemen1.text = arg_8_2.nameEn
	var_8_0.txt_itemen2.text = arg_8_2.nameEn

	local var_8_1 = arg_8_0._selectSecondTabId == arg_8_2.id

	gohelper.setActive(arg_8_0._categoryItemContainer[arg_8_1].go_line, true)

	if var_8_1 and arg_8_0._categoryItemContainer[arg_8_1 - 1] then
		gohelper.setActive(arg_8_0._categoryItemContainer[arg_8_1 - 1].go_line, false)
	end

	gohelper.setActive(var_8_0.go_unselected, not var_8_1)
	gohelper.setActive(var_8_0.go_selected, var_8_1)
end

function var_0_0.initCategoryItemTable(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0._gostorecategoryitem, "item" .. arg_9_1)
	var_9_0.go_unselected = gohelper.findChild(var_9_0.go, "go_unselected")
	var_9_0.go_selected = gohelper.findChild(var_9_0.go, "go_selected")
	var_9_0.go_reddot = gohelper.findChild(var_9_0.go, "#go_tabreddot1")
	var_9_0.go_reddotNormalType = gohelper.findChild(var_9_0.go, "#go_tabreddot1/type1")
	var_9_0.go_reddotActType = gohelper.findChild(var_9_0.go, "#go_tabreddot1/type9")
	var_9_0.txt_itemcn1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemcn1")
	var_9_0.txt_itemen1 = gohelper.findChildText(var_9_0.go, "go_unselected/txt_itemen1")
	var_9_0.txt_itemcn2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemcn2")
	var_9_0.txt_itemen2 = gohelper.findChildText(var_9_0.go, "go_selected/txt_itemen2")
	var_9_0.go_line = gohelper.findChild(var_9_0.go, "#go_line")
	var_9_0.go_deadline = gohelper.findChild(var_9_0.go, "go_deadline")
	var_9_0.imagetimebg = gohelper.findChildImage(var_9_0.go, "go_deadline/timebg")
	var_9_0.godeadlineEffect = gohelper.findChild(var_9_0.go, "go_deadline/#effect")
	var_9_0.imagetimeicon = gohelper.findChildImage(var_9_0.go, "go_deadline/#txt_time/timeicon")
	var_9_0.txttime = gohelper.findChildText(var_9_0.go, "go_deadline/#txt_time")
	var_9_0.txtformat = gohelper.findChildText(var_9_0.go, "go_deadline/#txt_time/#txt_format")
	var_9_0.btn = gohelper.getClickWithAudio(var_9_0.go, AudioEnum.UI.play_ui_bank_open)
	var_9_0.tabId = 0

	var_9_0.btn:AddClickListener(function(arg_10_0)
		local var_10_0 = arg_10_0.tabId

		arg_9_0:_refreshTabs(var_10_0)

		arg_9_0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(var_10_0)
	end, var_9_0)
	table.insert(arg_9_0._categoryItemContainer, var_9_0)
	gohelper.setActive(var_9_0.go_childItem, false)

	return var_9_0
end

function var_0_0._refreshGoods(arg_11_0, arg_11_1)
	arg_11_0.storeId = 0

	local var_11_0 = StoreConfig.instance:getTabConfig(arg_11_0._selectThirdTabId)

	arg_11_0.storeId = var_11_0 and var_11_0.storeId or 0

	if arg_11_0.storeId == 0 then
		local var_11_1 = StoreConfig.instance:getTabConfig(arg_11_0._selectSecondTabId)

		arg_11_0.storeId = var_11_1 and var_11_1.storeId or 0
	end

	if arg_11_0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	else
		local var_11_2 = StoreModel.instance:getStoreMO(arg_11_0.storeId)

		if var_11_2 then
			local var_11_3 = var_11_2:getGoodsList(true)

			StoreNormalGoodsItemListModel.instance:setMOList(var_11_3, arg_11_0.storeId)
		else
			StoreNormalGoodsItemListModel.instance:setMOList(nil, arg_11_0.storeId)
		end

		if arg_11_1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				arg_11_0.storeId
			})
			arg_11_0.viewContainer:playNormalStoreAnimation()
			arg_11_0.viewContainer:playSummonStoreAnimation()
		end
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._selectFirstTabId = arg_12_0.viewContainer:getSelectFirstTabId()

	local var_12_0 = arg_12_0.viewContainer:getJumpTabId()

	arg_12_0:_refreshTabs(var_12_0, true)
	arg_12_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_12_0._updateInfo, arg_12_0)
	arg_12_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_12_0._updateInfo, arg_12_0)
	arg_12_0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_12_0._updateInfo, arg_12_0)
	arg_12_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_12_0._onRefreshRedDot, arg_12_0)
	arg_12_0._lockClick:AddClickListener(arg_12_0._onLockClick, arg_12_0)
	arg_12_0:checkCountdownStatus()
end

function var_0_0._onLockClick(arg_13_0)
	if arg_13_0._isLock then
		local var_13_0 = StoreConfig.instance:getTabConfig(arg_13_0.storeId).name

		GameFacade.showToast(ToastEnum.NormalStoreIsLock, var_13_0)
	end
end

function var_0_0._updateInfo(arg_14_0)
	arg_14_0:_refreshGoods(false)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_15_0._updateInfo, arg_15_0)
	arg_15_0:removeEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_15_0._onRefreshRedDot, arg_15_0)
	arg_15_0._lockClick:RemoveClickListener()
	arg_15_0:closeTaskCountdown()
end

function var_0_0._onRefreshRedDot(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._categoryItemContainer) do
		local var_16_0, var_16_1 = StoreModel.instance:isTabFirstRedDotShow(iter_16_1.tabId)

		gohelper.setActive(iter_16_1.go_reddot, var_16_0)
		gohelper.setActive(iter_16_1.go_reddotNormalType, not var_16_1)
		gohelper.setActive(iter_16_1.go_reddotActType, var_16_1)
	end
end

function var_0_0.checkCountdownStatus(arg_17_0)
	if arg_17_0._needCountdown then
		TaskDispatcher.cancelTask(arg_17_0._refreshTabDeadLine, arg_17_0)
		TaskDispatcher.runRepeat(arg_17_0._refreshTabDeadLine, arg_17_0, 1)
	end
end

function var_0_0.closeTaskCountdown(arg_18_0)
	if arg_18_0._needCountdown then
		TaskDispatcher.cancelTask(arg_18_0._refreshTabDeadLine, arg_18_0)
	end
end

function var_0_0._refreshTabDeadLine(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._categoryItemContainer) do
		if iter_19_1 ~= nil or iter_19_1.tabId ~= nil then
			local var_19_0 = StoreConfig.instance:getTabConfig(iter_19_1.tabId)
			local var_19_1 = StoreHelper.getRemainExpireTime(var_19_0)

			if var_19_1 > 0 then
				local var_19_2 = false
				local var_19_3

				iter_19_1.txttime.text, iter_19_1.txtformat.text, var_19_3 = TimeUtil.secondToRoughTime(math.floor(var_19_1), true)

				if arg_19_0._refreshTabDeadlineHasDay == nil then
					arg_19_0._refreshTabDeadlineHasDay = {}
				end

				if arg_19_0._refreshTabDeadlineHasDay[iter_19_1.tabId] == nil or arg_19_0._refreshTabDeadlineHasDay[iter_19_1.tabId] ~= var_19_3 then
					UISpriteSetMgr.instance:setCommonSprite(iter_19_1.imagetimebg, var_19_3 and "daojishi_01" or "daojishi_02")
					UISpriteSetMgr.instance:setCommonSprite(iter_19_1.imagetimeicon, var_19_3 and "daojishiicon_01" or "daojishiicon_02")
					SLFramework.UGUI.GuiHelper.SetColor(iter_19_1.txttime, var_19_3 and "#98D687" or "#E99B56")
					SLFramework.UGUI.GuiHelper.SetColor(iter_19_1.txtformat, var_19_3 and "#98D687" or "#E99B56")
					gohelper.setActive(iter_19_1.godeadlineEffect, not var_19_3)

					arg_19_0._refreshTabDeadlineHasDay[iter_19_1.tabId] = var_19_3
				end

				arg_19_0._needCountdown = true
			end

			gohelper.setActive(iter_19_1.go_deadline, var_19_1 > 0)
			gohelper.setActive(iter_19_1.txttime.gameObject, var_19_1 > 0)
		end
	end
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0._selectFirstTabId = arg_20_0.viewContainer:getSelectFirstTabId()

	local var_20_0 = arg_20_0.viewContainer:getJumpTabId()

	arg_20_0:_refreshTabs(var_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	if arg_21_0._categoryItemContainer and #arg_21_0._categoryItemContainer > 0 then
		for iter_21_0 = 1, #arg_21_0._categoryItemContainer do
			arg_21_0._categoryItemContainer[iter_21_0].btn:RemoveClickListener()
		end
	end

	arg_21_0._simagelockbg:UnLoadImage()
end

return var_0_0
