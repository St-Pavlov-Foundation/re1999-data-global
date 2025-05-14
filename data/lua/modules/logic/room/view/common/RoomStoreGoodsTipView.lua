module("modules.logic.room.view.common.RoomStoreGoodsTipView", package.seeall)

local var_0_0 = class("RoomStoreGoodsTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_theme")
	arg_1_0._txttheme = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_theme/txt")
	arg_1_0._gocobrand = gohelper.findChild(arg_1_0.viewGO, "left/#go_cobrand")
	arg_1_0._gobuyContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent")
	arg_1_0._goblockInfoItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	arg_1_0._golineitemContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content")
	arg_1_0._golineitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content/#go_blockInfoItem")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change")
	arg_1_0._txtchange = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	arg_1_0._imagechangeicon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	arg_1_0._gopaynoraml = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	arg_1_0._gopayselect = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	arg_1_0._btnticket = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	arg_1_0._gopay = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay")
	arg_1_0._gopayitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	arg_1_0._imagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "right/#go_source")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnticket:AddClickListener(arg_2_0._btnClickUseTicket, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntheme:RemoveClickListener()
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnticket:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnthemeOnClick(arg_4_0)
	local var_4_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if var_4_0 then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = var_4_0.materialType,
			id = var_4_0.id
		})
	end
end

function var_0_0._btninsightOnClick(arg_5_0)
	StoreController.instance:dispatchEvent(StoreEvent.SaveVerticalScrollPixel)

	local var_5_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local var_5_1 = var_5_0:checkShowTicket()
	local var_5_2 = RoomStoreItemListModel.instance:getTotalPriceByCostId()
	local var_5_3 = arg_5_0:_getSelectCostId()
	local var_5_4, var_5_5 = arg_5_0.viewParam.storeGoodsMO:getAllCostInfo()
	local var_5_6 = ({
		var_5_4,
		var_5_5
	})[var_5_3][1]
	local var_5_7 = var_5_6[1]
	local var_5_8 = var_5_6[2]
	local var_5_9 = ItemModel.instance:getItemQuantity(var_5_6[1], var_5_6[2])

	if var_5_1 and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
		local var_5_10 = var_5_0:getTicketId()
		local var_5_11 = ItemConfig.instance:getItemCo(var_5_10).name
		local var_5_12

		if var_5_0.materialType == MaterialEnum.MaterialType.BlockPackage then
			var_5_12 = RoomConfig.instance:getBlockPackageConfig(var_5_0.id).name
		elseif var_5_0.materialType == MaterialEnum.MaterialType.Building then
			var_5_12 = RoomConfig.instance:getBuildingConfig(var_5_0.id).name
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTicketCost, MsgBoxEnum.BoxType.Yes_No, arg_5_0._useTicket, nil, nil, arg_5_0, nil, nil, var_5_11, var_5_12)
	elseif var_5_7 == MaterialEnum.MaterialType.Currency and var_5_8 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(var_5_2, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_5_0._buyGoods, arg_5_0) then
			arg_5_0:_buyGoods()
		end
	elseif var_5_9 and var_5_2 <= var_5_9 then
		arg_5_0:_buyGoods()
	else
		local var_5_13, var_5_14 = ItemModel.instance:getItemConfigAndIcon(var_5_7, var_5_8)

		if var_5_13 then
			GameFacade.showToast(ToastEnum.ClickRoomStoreInsight, var_5_13.name)
		end
	end
end

function var_0_0._btnClickUseTicket(arg_6_0)
	local var_6_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if RoomStoreItemListModel.instance:getIsSelectCurrency() then
		RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	end

	RoomStoreItemListModel.instance:onModelUpdate()
	arg_6_0:_selectTicketBg(true)
	arg_6_0:_refreshUI()
	arg_6_0:_refreshLineItem()
end

function var_0_0._useTicket(arg_7_0)
	local var_7_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if not var_7_0 then
		return
	end

	local var_7_1 = {}
	local var_7_2 = {
		materialId = var_7_0:getTicketId()
	}

	var_7_2.quantity = 1

	table.insert(var_7_1, var_7_2)

	local var_7_3 = var_7_0:getStoreGoodsMO()

	ItemRpc.instance:sendUseItemRequest(var_7_1, var_7_3.goodsId)
	arg_7_0:closeThis()
end

function var_0_0._buyGoods(arg_8_0)
	local var_8_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local var_8_1 = RoomStoreItemListModel.instance:getList()

	if var_8_0 and #var_8_1 > 1 then
		RoomStoreOrderModel.instance:addByStoreItemMOList(var_8_1, arg_8_0.viewParam.storeGoodsMO.goodsId, var_8_0.themeId)
	end

	local var_8_2 = arg_8_0:_getSelectCostId()
	local var_8_3 = RoomStoreItemListModel.instance:getTotalPriceByCostId()

	StoreController.instance:recordRoomStoreCurrentCanBuyGoods(arg_8_0.viewParam.storeGoodsMO.goodsId, var_8_2, var_8_3)
	StoreController.instance:buyGoods(arg_8_0.viewParam.storeGoodsMO, 1, arg_8_0._onBuyCallback, arg_8_0, var_8_2)
end

function var_0_0._btncloseOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._payItemTbList = {}

	gohelper.setActive(arg_10_0._goblockInfoItem, false)
	gohelper.setActive(arg_10_0._gojumpItem, false)
	gohelper.setActive(arg_10_0._gobuyContent, true)
	gohelper.setActive(arg_10_0._gosource, false)
	arg_10_0:_createPayItemUserDataTb_(arg_10_0._gopayitem)
	arg_10_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_10_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_10_0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._gocobrand, RoomSourcesCobrandLogoItem, arg_10_0)

	gohelper.removeUIClickAudio(arg_10_0._btnclose.gameObject)
	gohelper.addUIClickAudio(arg_10_0._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_10_0._onOpenViewFinish, arg_10_0)
end

function var_0_0._onBuyCallback(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 == 0 then
		if arg_11_0:_checkRoomBuildingRare(arg_11_3.goodsId) then
			arg_11_0:closeThis()
		end

		TaskDispatcher.runDelay(arg_11_0._closeTipView, arg_11_0, 5)
	end
end

function var_0_0._checkRoomBuildingRare(arg_12_0, arg_12_1)
	local var_12_0 = StoreConfig.instance:getGoodsConfig(arg_12_1)
	local var_12_1 = string.split(var_12_0.product, "#")
	local var_12_2 = tonumber(var_12_1[1])
	local var_12_3 = tonumber(var_12_1[2])

	if var_12_2 == MaterialEnum.MaterialType.Building and RoomConfig.instance:getBuildingConfig(var_12_3).rare == 1 then
		return true
	end

	return false
end

function var_0_0._closeTipView(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0._onOpenViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.RoomBlockPackageGetView then
		arg_14_0:_closeTipView()
	end
end

function var_0_0._createPayItemUserDataTb_(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0._go = arg_15_1
	var_15_0._gonormalbg = gohelper.findChild(arg_15_1, "go_normalbg")
	var_15_0._goselectbg = gohelper.findChild(arg_15_1, "go_selectbg")
	var_15_0._imageicon = gohelper.findChildImage(arg_15_1, "txt_desc/simage_icon")
	var_15_0._txtdesc = gohelper.findChildText(arg_15_1, "txt_desc")
	var_15_0._btnpay = gohelper.findChildButtonWithAudio(arg_15_1, "btn_pay")

	var_15_0._btnpay:AddClickListener(function(arg_16_0)
		arg_16_0.self:_setSelectCostId(arg_16_0.item.costId)
	end, {
		self = arg_15_0,
		item = var_15_0
	})
	table.insert(arg_15_0._payItemTbList, var_15_0)

	return var_15_0
end

function var_0_0._refreshPayItemUI(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = arg_17_1
	local var_17_1 = var_17_0.costId

	var_17_0.costId = arg_17_2

	local var_17_2 = 0

	if string.len(arg_17_4) == 1 then
		var_17_2 = arg_17_3 .. "0" .. arg_17_4
	else
		var_17_2 = arg_17_3 .. arg_17_4
	end

	local var_17_3 = string.format("%s_1", var_17_2)

	UISpriteSetMgr.instance:setCurrencyItemSprite(var_17_0._imageicon, var_17_3)

	local var_17_4, var_17_5 = ItemModel.instance:getItemConfigAndIcon(arg_17_3, arg_17_4, true)

	var_17_0._txtdesc.text = var_17_4 and var_17_4.name or nil
end

function var_0_0._onSelectPayItemUI(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_1

	gohelper.setActive(var_18_0._goselectbg, arg_18_2)
	gohelper.setActive(var_18_0._gonormalbg, not arg_18_2)
	SLFramework.UGUI.GuiHelper.SetColor(var_18_0._txtdesc, arg_18_2 and "#FFFFFF" or "#4C4341")
end

function var_0_0._setSelectCostId(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:_getSelectCostId()
	local var_19_1 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	RoomStoreItemListModel.instance:setIsSelectCurrency(true)
	RoomStoreItemListModel.instance:setCostId(arg_19_1)

	if var_19_1:checkShowTicket() then
		arg_19_0:_refreshUI()
		arg_19_0:_selectTicketBg(false)
		arg_19_0:_refreshLineItem()
	elseif var_19_0 ~= arg_19_0:_getSelectCostId() then
		arg_19_0:_refreshUI()
		arg_19_0:_refreshLineItem()
	end
end

function var_0_0._refreshUI(arg_20_0)
	local var_20_0 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()
	local var_20_1 = var_20_0 and var_20_0:checkShowTicket()

	gohelper.setActive(arg_20_0._gochange.gameObject, var_20_1)

	local var_20_2 = var_20_0 and var_20_0:getTicketId()

	if var_20_2 then
		local var_20_3 = ItemConfig.instance:getItemCo(var_20_2).name

		arg_20_0._txtchange.text = var_20_3
	end

	if var_20_1 then
		local var_20_4 = string.format("%s_1", var_20_0:getTicketId())

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0._imagechangeicon, var_20_4)
	end

	local var_20_5

	if var_20_0 then
		local var_20_6 = RoomConfig.instance:getThemeIdByItem(var_20_0.id, var_20_0.materialType)
		local var_20_7 = var_20_6 and lua_room_theme.configDict[var_20_6]

		arg_20_0._txttheme.text = var_20_7 and var_20_7.name or ""
		var_20_5 = var_20_7.sourcesType
	end

	if RoomStoreItemListModel.instance:getCount() == 1 then
		local var_20_8 = RoomStoreItemListModel.instance:getByIndex(1)
		local var_20_9 = var_20_8 and var_20_8:getItemConfig()

		var_20_5 = var_20_9 and var_20_9.sourcesType or nil
	end

	arg_20_0.cobrandLogoItem:setSourcesTypeStr(var_20_5)
	gohelper.setActive(arg_20_0._btntheme, var_20_0 ~= nil and not arg_20_0.cobrandLogoItem:getIsShow())

	local var_20_10 = RoomStoreItemListModel.instance:getTotalPriceByCostId()
	local var_20_11 = arg_20_0:_getSelectCostId()
	local var_20_12, var_20_13 = arg_20_0.viewParam.storeGoodsMO:getAllCostInfo()
	local var_20_14 = {
		var_20_12,
		var_20_13
	}
	local var_20_15 = var_20_14[var_20_11][1]
	local var_20_16 = var_20_15[1]
	local var_20_17 = var_20_15[2]
	local var_20_18, var_20_19 = ItemModel.instance:getItemConfigAndIcon(var_20_16, var_20_17)
	local var_20_20 = not RoomStoreItemListModel.instance:getIsSelectCurrency() and var_20_1
	local var_20_21 = var_20_20 and var_20_0:getTicketId() or var_20_18.icon
	local var_20_22 = string.format("%s_1", var_20_21)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0._imagecosticon, var_20_22)

	local var_20_23, var_20_24 = ItemModel.instance:getItemConfigAndIcon(var_20_15[1], var_20_15[2], true)
	local var_20_25 = ItemModel.instance:getItemQuantity(var_20_15[1], var_20_15[2])

	arg_20_0._txtcostnum.text = var_20_20 and 1 or var_20_10

	if var_20_20 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._txtcostnum, "#595959")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._txtcostnum, var_20_25 and var_20_10 <= var_20_25 and "#595959" or "#BF2E11")
	end

	local var_20_26 = 0

	for iter_20_0 = 1, #var_20_14 do
		local var_20_27 = var_20_14[iter_20_0]

		if var_20_27 then
			local var_20_28 = var_20_27[1]

			var_20_26 = var_20_26 + 1

			local var_20_29 = arg_20_0._payItemTbList[var_20_26]

			if not var_20_29 then
				local var_20_30 = gohelper.cloneInPlace(arg_20_0._gopayitem, "go_payitem" .. var_20_26)

				var_20_29 = arg_20_0:_createPayItemUserDataTb_(var_20_30)
			end

			gohelper.setActive(var_20_29._go, true)
			arg_20_0:_refreshPayItemUI(var_20_29, iter_20_0, var_20_28[1], var_20_28[2])

			if var_20_1 and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
				arg_20_0:_onSelectPayItemUI(var_20_29, false)
			else
				arg_20_0:_onSelectPayItemUI(var_20_29, iter_20_0 == var_20_11)
			end
		end
	end

	for iter_20_1 = var_20_26 + 1, #arg_20_0._payItemTbList do
		gohelper.setActive(arg_20_0._payItemTbList[iter_20_1], false)
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	RoomStoreItemListModel.instance:setStoreGoodsMO(arg_21_0.viewParam.storeGoodsMO)
	arg_21_0:_refreshLineItem()
	arg_21_0:_refreshUI()
end

function var_0_0.onOpen(arg_22_0)
	local var_22_0 = arg_22_0.viewParam.storeGoodsMO
	local var_22_1 = StoreConfig.instance:getGoodsConfig(var_22_0.goodsId)

	StoreController.instance:statOpenGoods(var_22_0.belongStoreId, var_22_1)
	RoomStoreItemListModel.instance:setStoreGoodsMO(arg_22_0.viewParam.storeGoodsMO)

	local var_22_2 = arg_22_0:_findInitCostId(arg_22_0.viewParam.storeGoodsMO)

	RoomStoreItemListModel.instance:setCostId(var_22_2)
	arg_22_0:_refreshLineItem()
	arg_22_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open2)
end

function var_0_0._findInitCostId(arg_23_0, arg_23_1)
	local var_23_0, var_23_1 = arg_23_1:getAllCostInfo()
	local var_23_2 = {
		var_23_0,
		var_23_1
	}

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if iter_23_1 then
			local var_23_3 = iter_23_1[1]
			local var_23_4 = ItemModel.instance:getItemQuantity(var_23_3[1], var_23_3[2])
			local var_23_5 = RoomStoreItemListModel.instance:getTotalPriceByCostId(iter_23_0)

			return iter_23_0
		end
	end

	return 1
end

function var_0_0._selectTicketBg(arg_24_0, arg_24_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_24_0._txtchange, arg_24_1 and "#FFFFFF" or "#4C4341")
	gohelper.setActive(arg_24_0._gopaynoraml, not arg_24_1)
	gohelper.setActive(arg_24_0._gopayselect, arg_24_1)
end

function var_0_0._getSelectCostId(arg_25_0)
	return RoomStoreItemListModel.instance:getCostId()
end

function var_0_0.onClose(arg_26_0)
	for iter_26_0 = 1, #arg_26_0._payItemTbList do
		arg_26_0._payItemTbList[iter_26_0]._btnpay:RemoveClickListener()
	end

	if arg_26_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end

	TaskDispatcher.cancelTask(arg_26_0._closeTipView, arg_26_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_26_0._onOpenViewFinish, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0._simagebg1:UnLoadImage()
	arg_27_0._simagebg2:UnLoadImage()
	arg_27_0.cobrandLogoItem:onDestroy()
end

function var_0_0._refreshLineItem(arg_28_0)
	if arg_28_0._lineitemGOs == nil then
		arg_28_0._lineitemGOs = {}
	end

	arg_28_0.linemolist = RoomStoreItemListModel.instance:getList()

	for iter_28_0 = 1, #arg_28_0.linemolist do
		local var_28_0 = arg_28_0._lineitemGOs[iter_28_0]

		if not var_28_0 then
			local var_28_1 = gohelper.clone(arg_28_0._golineitem, arg_28_0._golineitemContent, "item" .. iter_28_0)

			var_28_0 = MonoHelper.getLuaComFromGo(var_28_1, RoomStoreGoodsTipItem)
			var_28_0 = var_28_0 or MonoHelper.addNoUpdateLuaComOnceToGo(var_28_1, RoomStoreGoodsTipItem)

			gohelper.setActive(var_28_1, true)
			table.insert(arg_28_0._lineitemGOs, var_28_0)
		end

		var_28_0:onUpdateMO(arg_28_0.linemolist[iter_28_0])

		if iter_28_0 % 2 == 0 then
			var_28_0._imgbg.enabled = true
		else
			var_28_0._imgbg.enabled = false
		end
	end
end

return var_0_0
