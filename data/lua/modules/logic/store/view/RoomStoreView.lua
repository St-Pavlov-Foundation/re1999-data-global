module("modules.logic.store.view.RoomStoreView", package.seeall)

local var_0_0 = class("RoomStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "#go_critter")
	arg_1_0._trsviewport = gohelper.findChild(arg_1_0.viewGO, "#scroll_prop/viewport").transform
	arg_1_0._trscontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_prop/viewport/content").transform
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#scroll_prop/#go_lock")
	arg_1_0._simagelockbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_prop/#go_lock/#simage_lockbg")
	arg_1_0._gostorecategoryitem = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	arg_1_0._gotabreddot1 = gohelper.findChild(arg_1_0.viewGO, "top/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	arg_1_0._txtrefreshTime = gohelper.findChildText(arg_1_0.viewGO, "#txt_refreshTime")
	arg_1_0._lineGo = gohelper.findChild(arg_1_0.viewGO, "line")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0.openduration = 0.6
	arg_1_0.closeduration = 0.3
	arg_1_0.moveduration = 0.3
	arg_1_0.rootHeight = 397
	arg_1_0._csPixel = nil
	arg_1_0._categoryItemContainer = {}
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0, arg_5_1)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._selectFirstTabId = arg_6_0.viewContainer:getSelectFirstTabId()

	local var_6_0 = arg_6_0.viewContainer:getJumpTabId()

	arg_6_0.jumpGoodsId = arg_6_0.viewContainer:getJumpGoodsId()
	arg_6_0._csView = arg_6_0.viewContainer._ScrollViewRoomStore
	arg_6_0._csScroll = arg_6_0._csView:getCsScroll()

	arg_6_0:_refreshTabs(var_6_0, true)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_6_0._updateInfo, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.SaveVerticalScrollPixel, arg_6_0._savecsPixel, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_6_0._updateInfo, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.OpenRoomStoreNode, arg_6_0.changeContentPosY, arg_6_0)

	arg_6_0._scrollprop.verticalNormalizedPosition = 1
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0.delaycallBack then
		TaskDispatcher.cancelTask(arg_7_0.delaycallBack, arg_7_0)
	end

	TaskDispatcher.cancelTask(arg_7_0.jumpClickChildGoods, arg_7_0, arg_7_0.openduration)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.SaveVerticalScrollPixel, arg_7_0._savecsPixel, arg_7_0)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.OpenRoomStoreNode, arg_7_0.changeContentPosY, arg_7_0)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.GoodsModelChanged, arg_7_0._updateInfo, arg_7_0)
	arg_7_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_7_0._updateInfo, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._categoryItemContainer and #arg_8_0._categoryItemContainer > 0 then
		for iter_8_0 = 1, #arg_8_0._categoryItemContainer do
			arg_8_0._categoryItemContainer[iter_8_0].btn:RemoveClickListener()
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

function var_0_0._savecsPixel(arg_9_0)
	if arg_9_0._csScroll then
		arg_9_0._csPixel = arg_9_0._csScroll.VerticalScrollPixel
	end
end

function var_0_0._updateInfo(arg_10_0, arg_10_1)
	arg_10_0:_refreshGoods(false, arg_10_1)
	arg_10_0:_refreshRightTop()

	local var_10_0 = arg_10_0._csScroll:GetRenderCellRect(1, -1)

	if var_10_0 then
		local var_10_1 = recthelper.getHeight(var_10_0)

		arg_10_0.firstItemOffsetY = arg_10_0:calculateFirstItemOffsetY(var_10_1)
	else
		return
	end

	if not arg_10_1 then
		if not arg_10_0.jumpGoodsId then
			local var_10_2 = {
				index = 1,
				isFirstOpen = true,
				state = true,
				delay = true,
				itemHeight = arg_10_0.rootHeight
			}

			arg_10_0:changeContentPosY(var_10_2)
		else
			local var_10_3 = arg_10_0:_getRootIndexById(arg_10_0.jumpGoodsId)
			local var_10_4 = {
				isFirstOpen = false,
				state = true,
				delay = true,
				index = var_10_3,
				itemHeight = arg_10_0.rootHeight
			}

			arg_10_0:changeContentPosY(var_10_4)

			arg_10_0.jumpGoodsId = nil
		end
	end
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
	var_12_0.go_reddotNewType = gohelper.findChild(var_12_0.go, "#go_tabreddot1/type5")
	var_12_0.go_reddotActType = gohelper.findChild(var_12_0.go, "#go_tabreddot1/type9")
	var_12_0.txt_itemcn1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemcn1")
	var_12_0.txt_itemen1 = gohelper.findChildText(var_12_0.go, "go_unselected/txt_itemen1")
	var_12_0.txt_itemcn2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemcn2")
	var_12_0.txt_itemen2 = gohelper.findChildText(var_12_0.go, "go_selected/txt_itemen2")
	var_12_0.go_line = gohelper.findChild(var_12_0.go, "#go_line")
	var_12_0.btn = gohelper.getClickWithAudio(var_12_0.go, AudioEnum.UI.play_ui_bank_open)
	var_12_0.tabId = 0

	var_12_0.btn:AddClickListener(function(arg_13_0)
		local var_13_0 = arg_13_0.tabId

		if arg_13_0.tabId == StoreEnum.StoreId.OldRoomStore then
			StoreModel.instance:setNewRedDotKey(arg_13_0.tabId)
		end

		arg_12_0:_refreshTabs(var_13_0)

		arg_12_0.viewContainer.notPlayAnimation = true

		StoreController.instance:statSwitchStore(var_13_0)
	end, var_12_0)
	table.insert(arg_12_0._categoryItemContainer, var_12_0)
	gohelper.setActive(var_12_0.go_childItem, false)

	return var_12_0
end

function var_0_0._refreshTabs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._selectSecondTabId
	local var_14_1 = arg_14_0._selectThirdTabId

	arg_14_0._selectSecondTabId = 0
	arg_14_0._selectThirdTabId = 0
	arg_14_0.openUpdate = arg_14_2
	arg_14_0._scrollprop.verticalNormalizedPosition = 1

	if not StoreModel.instance:isTabOpen(arg_14_1) then
		arg_14_1 = arg_14_0.viewContainer:getSelectFirstTabId()
	end

	local var_14_2
	local var_14_3

	var_14_3, arg_14_0._selectSecondTabId, arg_14_0._selectThirdTabId = StoreModel.instance:jumpTabIdToSelectTabId(arg_14_1)

	arg_14_0:_refreshRightTop()

	local var_14_4 = StoreModel.instance:getSecondTabs(arg_14_0._selectFirstTabId, true, true)

	if var_14_4 and #var_14_4 > 0 then
		for iter_14_0 = 1, #var_14_4 do
			arg_14_0:_refreshSecondTabs(iter_14_0, var_14_4[iter_14_0])
			gohelper.setActive(arg_14_0._categoryItemContainer[iter_14_0].go, true)
		end

		gohelper.setActive(arg_14_0._categoryItemContainer[#var_14_4].go_line, false)

		for iter_14_1 = #var_14_4 + 1, #arg_14_0._categoryItemContainer do
			gohelper.setActive(arg_14_0._categoryItemContainer[iter_14_1].go, false)
		end

		gohelper.setActive(arg_14_0._lineGo, true)
	else
		for iter_14_2 = 1, #arg_14_0._categoryItemContainer do
			gohelper.setActive(arg_14_0._categoryItemContainer[iter_14_2].go, false)
		end

		gohelper.setActive(arg_14_0._lineGo, false)
	end

	arg_14_0:_onRefreshRedDot()

	if not arg_14_2 and var_14_0 == arg_14_0._selectSecondTabId and var_14_1 == arg_14_0._selectThirdTabId then
		return
	end

	local var_14_5 = arg_14_0._selectSecondTabId == StoreEnum.StoreId.CritterStore

	gohelper.setActive(arg_14_0._gocritter.gameObject, var_14_5)
	gohelper.setActive(arg_14_0._scrollprop.gameObject, not var_14_5)

	if var_14_5 then
		arg_14_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 5, 1)
	end

	arg_14_0:_refreshGoods(true)
end

function var_0_0._refreshRightTop(arg_15_0)
	local var_15_0 = StoreConfig.instance:getTabConfig(arg_15_0._selectThirdTabId)
	local var_15_1 = StoreConfig.instance:getTabConfig(arg_15_0._selectSecondTabId)
	local var_15_2 = StoreConfig.instance:getTabConfig(arg_15_0.viewContainer:getSelectFirstTabId())

	if var_15_0 and not string.nilorempty(var_15_0.showCost) then
		arg_15_0.viewContainer:setCurrencyByParams(arg_15_0:packShowCostParam(var_15_0.showCost))
	elseif var_15_1 and not string.nilorempty(var_15_1.showCost) then
		arg_15_0.viewContainer:setCurrencyByParams(arg_15_0:packShowCostParam(var_15_1.showCost))
	elseif var_15_2 and not string.nilorempty(var_15_2.showCost) then
		arg_15_0.viewContainer:setCurrencyByParams(arg_15_0:packShowCostParam(var_15_2.showCost))
	else
		arg_15_0.viewContainer:setCurrencyByParams(nil)
	end
end

function var_0_0._refreshGoods(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_2 then
		var_16_0 = arg_16_2
	end

	arg_16_0.storeId = 0

	local var_16_1 = StoreConfig.instance:getTabConfig(arg_16_0._selectThirdTabId)

	arg_16_0.storeId = var_16_1 and var_16_1.storeId or 0

	if arg_16_0.storeId == 0 then
		local var_16_2 = StoreConfig.instance:getTabConfig(arg_16_0._selectSecondTabId)

		arg_16_0.storeId = var_16_2 and var_16_2.storeId or 0
	end

	if arg_16_0.storeId == 0 then
		StoreNormalGoodsItemListModel.instance:setMOList()
	elseif arg_16_0.storeId == StoreEnum.StoreId.CritterStore then
		gohelper.setActive(arg_16_0._goempty, false)

		if arg_16_1 then
			arg_16_0.viewContainer:playCritterStoreAnimation()
		end
	else
		local var_16_3 = StoreModel.instance:getStoreMO(arg_16_0.storeId)

		if var_16_3 then
			local var_16_4 = var_16_3:getGoodsList(true)

			if not next(var_16_4) then
				gohelper.setActive(arg_16_0._goempty, true)
			else
				gohelper.setActive(arg_16_0._goempty, false)
			end

			arg_16_0.rootGoodsList = {}

			local var_16_5 = {}

			for iter_16_0, iter_16_1 in pairs(var_16_4) do
				local var_16_6 = {}

				if iter_16_1:getOffTab() then
					local var_16_7 = GameUtil.splitString2(iter_16_1:getOffTab())

					iter_16_1.goodscn = var_16_7[1][2]
					iter_16_1.goodsen = var_16_7[1][3]

					if arg_16_0.jumpGoodsId then
						iter_16_1.isjump = true
					end
				end

				if not string.nilorempty(iter_16_1.config.nameEn) then
					iter_16_1.update = arg_16_1

					table.insert(arg_16_0.rootGoodsList, iter_16_1)
				elseif iter_16_1:checkJumpGoodCanOpen() then
					table.insert(var_16_5, iter_16_1)
				end
			end

			for iter_16_2, iter_16_3 in pairs(arg_16_0.rootGoodsList) do
				for iter_16_4, iter_16_5 in pairs(var_16_5) do
					if iter_16_5.goodsen == iter_16_3.config.nameEn then
						if iter_16_3.children == nil then
							iter_16_3.children = {}

							table.insert(iter_16_3.children, iter_16_5)
						else
							if var_16_0 and iter_16_5.goodsId == var_16_0 then
								iter_16_3.isExpand = true
							end

							if not tabletool.indexOf(iter_16_3.children, iter_16_5) then
								table.insert(iter_16_3.children, iter_16_5)
							end
						end
					end
				end
			end

			for iter_16_6, iter_16_7 in ipairs(arg_16_0.rootGoodsList) do
				if iter_16_7.children == nil then
					table.remove(arg_16_0.rootGoodsList, iter_16_6)
				end
			end

			StoreRoomGoodsItemListModel.instance:setMOList(arg_16_0.rootGoodsList)

			if arg_16_0._csPixel then
				arg_16_0._csScroll.VerticalScrollPixel = arg_16_0._csPixel
				arg_16_0._csPixel = nil
			end
		end

		if arg_16_1 then
			StoreRpc.instance:sendGetStoreInfosRequest({
				arg_16_0.storeId
			})
		end
	end
end

function var_0_0.changeContentPosY(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1.index
	local var_17_1 = arg_17_1.state
	local var_17_2 = arg_17_1.itemHeight
	local var_17_3 = arg_17_1.delay
	local var_17_4 = arg_17_1.isFirstOpen

	if not var_17_0 then
		return
	end

	local var_17_5 = StoreRoomGoodsItemListModel.instance:getRootCount() - 1

	if arg_17_0.storeId == StoreEnum.StoreId.NewRoomStore then
		if var_17_5 >= 2 and var_17_4 then
			return
		end
	elseif arg_17_0.storeId == StoreEnum.StoreId.OldRoomStore and var_17_4 then
		return
	end

	local var_17_6 = #StoreRoomGoodsItemListModel.instance:getByIndex(var_17_0, 0).children

	arg_17_0.openduration = Mathf.Ceil(var_17_6 / 4) * 0.2

	local var_17_7 = arg_17_0.moveduration * var_17_0

	function arg_17_0.delaycallBack()
		if var_17_0 and arg_17_0._csView then
			arg_17_0._csView:expand(var_17_0, nil, arg_17_0.openduration)

			if arg_17_0.jumpClickChildGoodsId then
				TaskDispatcher.runDelay(arg_17_0.jumpClickChildGoods, arg_17_0, arg_17_0.openduration)
			end
		end
	end

	local var_17_8

	if var_17_1 then
		local var_17_9 = arg_17_0:calculateFirstItemOffsetY(var_17_2)

		if var_17_3 then
			function var_17_8()
				TaskDispatcher.runDelay(arg_17_0.delaycallBack, arg_17_0, var_17_7)
			end
		else
			function var_17_8()
				arg_17_0._csView:expand(var_17_0, nil, arg_17_0.openduration)
			end
		end

		if arg_17_0.jumpGoodsId then
			TaskDispatcher.runDelay(arg_17_0.delaycallBack, arg_17_0, var_17_7)
		else
			arg_17_0:checkOtherItemIsExpand(var_17_8)
		end

		if var_17_0 == 1 then
			ZProj.TweenHelper.DOLocalMoveY(arg_17_0._trscontent, 0, arg_17_0.moveduration)

			return
		end

		if arg_17_0.firstItemOffsetY == nil then
			arg_17_0.firstItemOffsetY = arg_17_0:calculateFirstItemOffsetY(arg_17_0.rootHeight)
		end

		local var_17_10 = arg_17_0.firstItemOffsetY - var_17_9
		local var_17_11 = var_17_2 * (var_17_0 - 1)

		ZProj.TweenHelper.DOLocalMoveY(arg_17_0._trscontent, var_17_11 + var_17_10, var_17_3 and var_17_7 or arg_17_0.moveduration)
	else
		arg_17_0._csView:shrink(var_17_0, nil, arg_17_0.closeduration)
	end
end

function var_0_0.jumpClickChildGoods(arg_21_0)
	if not arg_21_0.jumpClickChildGoodsId then
		return
	end

	StoreController.instance:dispatchEvent(StoreEvent.jumpClickRoomChildGoods, arg_21_0.jumpClickChildGoodsId)

	arg_21_0.jumpClickChildGoodsId = nil
end

function var_0_0.calculateFirstItemOffsetY(arg_22_0, arg_22_1)
	local var_22_0 = 25

	return (recthelper.getHeight(arg_22_0._trsviewport) + var_22_0 - arg_22_1) / 2
end

function var_0_0.checkOtherItemIsExpand(arg_23_0, arg_23_1)
	local var_23_0 = StoreRoomGoodsItemListModel.instance:getInfoList()
	local var_23_1 = false

	for iter_23_0 = 1, #var_23_0 do
		var_23_1 = arg_23_0._csView:isExpand(iter_23_0)

		if var_23_1 then
			arg_23_0._csView:shrink(iter_23_0, nil, 0.3, arg_23_1, arg_23_0)

			break
		end
	end

	if not var_23_1 then
		arg_23_1()
	end
end

function var_0_0._getRootIndexById(arg_24_0, arg_24_1)
	if not arg_24_0.rootGoodsList then
		return
	end

	local var_24_0 = StoreConfig.instance:getGoodsConfig(arg_24_1)
	local var_24_1 = var_24_0 and GameUtil.splitString2(var_24_0.product, true) or {}

	for iter_24_0 = 1, #arg_24_0.rootGoodsList do
		local var_24_2 = false
		local var_24_3 = arg_24_0.rootGoodsList[iter_24_0]

		if var_24_3.goodsId == arg_24_1 then
			var_24_2 = true
		elseif var_24_3:hasProduct(var_24_1[1][1], var_24_1[1][2]) then
			var_24_2 = true
			arg_24_0.jumpClickChildGoodsId = arg_24_1
		end

		if var_24_2 then
			return iter_24_0
		end
	end
end

function var_0_0._onRefreshRedDot(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0._categoryItemContainer) do
		local var_25_0, var_25_1 = StoreModel.instance:isTabFirstRedDotShow(iter_25_1.tabId)
		local var_25_2 = false

		if iter_25_1.tabId == StoreEnum.StoreId.OldRoomStore then
			var_25_2 = StoreModel.instance:checkShowNewRedDot(iter_25_1.tabId)
		end

		if var_25_2 then
			var_25_0 = true
		end

		gohelper.setActive(iter_25_1.go_reddot, var_25_0)
		gohelper.setActive(iter_25_1.go_reddotNewType, var_25_2)
		gohelper.setActive(iter_25_1.go_reddotNormalType, not var_25_2 and not var_25_1)
		gohelper.setActive(iter_25_1.go_reddotActType, not var_25_2 and var_25_1)
	end
end

function var_0_0.packShowCostParam(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = string.split(arg_26_1, "#")

	for iter_26_0 = #var_26_1, 1, -1 do
		local var_26_2 = tonumber(var_26_1[iter_26_0])

		if ItemModel.instance:getItemCount(var_26_2) > 0 and not CurrencyModel.instance:getCurrency(var_26_2) then
			table.insert(var_26_0, {
				isCurrencySprite = true,
				id = var_26_2,
				type = MaterialEnum.MaterialType.Item
			})
		elseif CurrencyModel.instance:getCurrency(var_26_2) then
			table.insert(var_26_0, var_26_2)
		end
	end

	return var_26_0
end

return var_0_0
