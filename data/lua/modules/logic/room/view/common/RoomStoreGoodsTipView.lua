module("modules.logic.room.view.common.RoomStoreGoodsTipView", package.seeall)

slot0 = class("RoomStoreGoodsTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._btntheme = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_theme")
	slot0._txttheme = gohelper.findChildText(slot0.viewGO, "left/#btn_theme/txt")
	slot0._gobuyContent = gohelper.findChild(slot0.viewGO, "right/#go_buyContent")
	slot0._goblockInfoItem = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	slot0._golineitemContent = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content")
	slot0._golineitem = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content/#go_blockInfoItem")
	slot0._gochange = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_change")
	slot0._txtchange = gohelper.findChildText(slot0.viewGO, "right/#go_buyContent/#go_change/#txt_desc")
	slot0._imagechangeicon = gohelper.findChildImage(slot0.viewGO, "right/#go_buyContent/#go_change/#txt_desc/simage_icon")
	slot0._gopaynoraml = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_change/go_normalbg")
	slot0._gopayselect = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_change/go_selectbg")
	slot0._btnticket = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_buyContent/#go_change/btn_pay")
	slot0._gopay = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_pay")
	slot0._gopayitem = gohelper.findChild(slot0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	slot0._btninsight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	slot0._txtcostnum = gohelper.findChildText(slot0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	slot0._imagecosticon = gohelper.findChildImage(slot0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	slot0._gosource = gohelper.findChild(slot0.viewGO, "right/#go_source")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntheme:AddClickListener(slot0._btnthemeOnClick, slot0)
	slot0._btninsight:AddClickListener(slot0._btninsightOnClick, slot0)
	slot0._btnticket:AddClickListener(slot0._btnClickUseTicket, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntheme:RemoveClickListener()
	slot0._btninsight:RemoveClickListener()
	slot0._btnticket:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnthemeOnClick(slot0)
	if RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme() then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = slot1.materialType,
			id = slot1.id
		})
	end
end

function slot0._btninsightOnClick(slot0)
	StoreController.instance:dispatchEvent(StoreEvent.SaveVerticalScrollPixel)

	slot3 = RoomStoreItemListModel.instance:getTotalPriceByCostId()
	slot5, slot6 = slot0.viewParam.storeGoodsMO:getAllCostInfo()
	slot8 = ({
		slot5,
		slot6
	})[slot0:_getSelectCostId()][1]
	slot9 = slot8[1]
	slot10 = slot8[2]
	slot11 = ItemModel.instance:getItemQuantity(slot8[1], slot8[2])

	if RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme():checkShowTicket() and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
		slot13 = ItemConfig.instance:getItemCo(slot1:getTicketId()).name
		slot14 = nil

		if slot1.materialType == MaterialEnum.MaterialType.BlockPackage then
			slot14 = RoomConfig.instance:getBlockPackageConfig(slot1.id).name
		elseif slot1.materialType == MaterialEnum.MaterialType.Building then
			slot14 = RoomConfig.instance:getBuildingConfig(slot1.id).name
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTicketCost, MsgBoxEnum.BoxType.Yes_No, slot0._useTicket, nil, , slot0, nil, , slot13, slot14)
	elseif slot9 == MaterialEnum.MaterialType.Currency and slot10 == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(slot3, CurrencyEnum.PayDiamondExchangeSource.Store, nil, slot0._buyGoods, slot0) then
			slot0:_buyGoods()
		end
	elseif slot11 and slot3 <= slot11 then
		slot0:_buyGoods()
	else
		slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot9, slot10)

		if slot12 then
			GameFacade.showToast(ToastEnum.ClickRoomStoreInsight, slot12.name)
		end
	end
end

function slot0._btnClickUseTicket(slot0)
	slot1 = RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme()

	if RoomStoreItemListModel.instance:getIsSelectCurrency() then
		RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	end

	RoomStoreItemListModel.instance:onModelUpdate()
	slot0:_selectTicketBg(true)
	slot0:_refreshUI()
	slot0:_refreshLineItem()
end

function slot0._useTicket(slot0)
	if not RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme() then
		return
	end

	slot2 = {}

	table.insert(slot2, {
		materialId = slot1:getTicketId(),
		quantity = 1
	})
	ItemRpc.instance:sendUseItemRequest(slot2, slot1:getStoreGoodsMO().goodsId)
	slot0:closeThis()
end

function slot0._buyGoods(slot0)
	slot2 = RoomStoreItemListModel.instance:getList()

	if RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme() and #slot2 > 1 then
		RoomStoreOrderModel.instance:addByStoreItemMOList(slot2, slot0.viewParam.storeGoodsMO.goodsId, slot1.themeId)
	end

	slot3 = slot0:_getSelectCostId()

	StoreController.instance:recordRoomStoreCurrentCanBuyGoods(slot0.viewParam.storeGoodsMO.goodsId, slot3, RoomStoreItemListModel.instance:getTotalPriceByCostId())
	StoreController.instance:buyGoods(slot0.viewParam.storeGoodsMO, 1, slot0._onBuyCallback, slot0, slot3)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._payItemTbList = {}

	gohelper.setActive(slot0._goblockInfoItem, false)
	gohelper.setActive(slot0._gojumpItem, false)
	gohelper.setActive(slot0._gobuyContent, true)
	gohelper.setActive(slot0._gosource, false)
	slot0:_createPayItemUserDataTb_(slot0._gopayitem)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	gohelper.removeUIClickAudio(slot0._btnclose.gameObject)
	gohelper.addUIClickAudio(slot0._btninsight.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	RoomStoreItemListModel.instance:setIsSelectCurrency(false)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0._onBuyCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if slot0:_checkRoomBuildingRare(slot3.goodsId) then
			slot0:closeThis()
		end

		TaskDispatcher.runDelay(slot0._closeTipView, slot0, 5)
	end
end

function slot0._checkRoomBuildingRare(slot0, slot1)
	slot3 = string.split(StoreConfig.instance:getGoodsConfig(slot1).product, "#")

	if tonumber(slot3[1]) == MaterialEnum.MaterialType.Building and RoomConfig.instance:getBuildingConfig(tonumber(slot3[2])).rare == 1 then
		return true
	end

	return false
end

function slot0._closeTipView(slot0)
	slot0:closeThis()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.RoomBlockPackageGetView then
		slot0:_closeTipView()
	end
end

function slot0._createPayItemUserDataTb_(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2._go = slot1
	slot2._gonormalbg = gohelper.findChild(slot1, "go_normalbg")
	slot2._goselectbg = gohelper.findChild(slot1, "go_selectbg")
	slot2._imageicon = gohelper.findChildImage(slot1, "txt_desc/simage_icon")
	slot2._txtdesc = gohelper.findChildText(slot1, "txt_desc")
	slot2._btnpay = gohelper.findChildButtonWithAudio(slot1, "btn_pay")

	slot2._btnpay:AddClickListener(function (slot0)
		slot0.self:_setSelectCostId(slot0.item.costId)
	end, {
		self = slot0,
		item = slot2
	})
	table.insert(slot0._payItemTbList, slot2)

	return slot2
end

function slot0._refreshPayItemUI(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1
	slot6 = slot5.costId
	slot5.costId = slot2
	slot7 = 0

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot5._imageicon, string.format("%s_1", string.len(slot4) == 1 and slot3 .. "0" .. slot4 or slot3 .. slot4))

	slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot3, slot4, true)
	slot5._txtdesc.text = slot9 and slot9.name or nil
end

function slot0._onSelectPayItemUI(slot0, slot1, slot2)
	slot3 = slot1

	gohelper.setActive(slot3._goselectbg, slot2)
	gohelper.setActive(slot3._gonormalbg, not slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot3._txtdesc, slot2 and "#FFFFFF" or "#4C4341")
end

function slot0._setSelectCostId(slot0, slot1)
	slot2 = slot0:_getSelectCostId()

	RoomStoreItemListModel.instance:setIsSelectCurrency(true)
	RoomStoreItemListModel.instance:setCostId(slot1)

	if RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme():checkShowTicket() then
		slot0:_refreshUI()
		slot0:_selectTicketBg(false)
		slot0:_refreshLineItem()
	elseif slot2 ~= slot0:_getSelectCostId() then
		slot0:_refreshUI()
		slot0:_refreshLineItem()
	end
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._btntheme.gameObject, RoomStoreItemListModel.instance:getRoomStoreItemMOHasTheme() ~= nil)
	gohelper.setActive(slot0._gochange.gameObject, slot1:checkShowTicket())

	if slot1:getTicketId() then
		slot0._txtchange.text = ItemConfig.instance:getItemCo(slot3).name
	end

	if slot2 then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagechangeicon, string.format("%s_1", slot1:getTicketId()))
	end

	if slot1 then
		slot5 = RoomConfig.instance:getThemeIdByItem(slot1.id, slot1.materialType) and lua_room_theme.configDict[slot4]
		slot0._txttheme.text = slot5 and slot5.name or ""
	end

	slot6, slot7 = slot0.viewParam.storeGoodsMO:getAllCostInfo()
	slot9 = ({
		slot6,
		slot7
	})[slot0:_getSelectCostId()][1]
	slot12, slot13 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])
	slot14 = not RoomStoreItemListModel.instance:getIsSelectCurrency() and slot2

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecosticon, string.format("%s_1", slot14 and slot1:getTicketId() or slot12.icon))

	slot17, slot18 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2], true)
	slot19 = ItemModel.instance:getItemQuantity(slot9[1], slot9[2])
	slot0._txtcostnum.text = slot14 and 1 or RoomStoreItemListModel.instance:getTotalPriceByCostId()

	if slot14 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcostnum, "#595959")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcostnum, slot19 and slot4 <= slot19 and "#595959" or "#BF2E11")
	end

	slot20 = 0

	for slot24 = 1, #slot8 do
		if slot8[slot24] then
			slot25 = slot25[1]
			slot26 = slot0._payItemTbList[slot20 + 1] or slot0:_createPayItemUserDataTb_(gohelper.cloneInPlace(slot0._gopayitem, "go_payitem" .. slot20))

			gohelper.setActive(slot26._go, true)
			slot0:_refreshPayItemUI(slot26, slot24, slot25[1], slot25[2])

			if slot2 and not RoomStoreItemListModel.instance:getIsSelectCurrency() then
				slot0:_onSelectPayItemUI(slot26, false)
			else
				slot0:_onSelectPayItemUI(slot26, slot24 == slot5)
			end
		end
	end

	for slot24 = slot20 + 1, #slot0._payItemTbList do
		gohelper.setActive(slot0._payItemTbList[slot24], false)
	end
end

function slot0.onUpdateParam(slot0)
	RoomStoreItemListModel.instance:setStoreGoodsMO(slot0.viewParam.storeGoodsMO)
	slot0:_refreshLineItem()
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.storeGoodsMO

	StoreController.instance:statOpenGoods(slot1.belongStoreId, StoreConfig.instance:getGoodsConfig(slot1.goodsId))
	RoomStoreItemListModel.instance:setStoreGoodsMO(slot0.viewParam.storeGoodsMO)
	RoomStoreItemListModel.instance:setCostId(slot0:_findInitCostId(slot0.viewParam.storeGoodsMO))
	slot0:_refreshLineItem()
	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open2)
end

function slot0._findInitCostId(slot0, slot1)
	slot2, slot3 = slot1:getAllCostInfo()

	for slot8, slot9 in ipairs({
		slot2,
		slot3
	}) do
		if slot9 then
			slot10 = slot9[1]
			slot11 = ItemModel.instance:getItemQuantity(slot10[1], slot10[2])
			slot12 = RoomStoreItemListModel.instance:getTotalPriceByCostId(slot8)

			return slot8
		end
	end

	return 1
end

function slot0._selectTicketBg(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtchange, slot1 and "#FFFFFF" or "#4C4341")
	gohelper.setActive(slot0._gopaynoraml, not slot1)
	gohelper.setActive(slot0._gopayselect, slot1)
end

function slot0._getSelectCostId(slot0)
	return RoomStoreItemListModel.instance:getCostId()
end

function slot0.onClose(slot0)
	for slot4 = 1, #slot0._payItemTbList do
		slot0._payItemTbList[slot4]._btnpay:RemoveClickListener()
	end

	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end

	TaskDispatcher.cancelTask(slot0._closeTipView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

function slot0._refreshLineItem(slot0)
	if slot0._lineitemGOs == nil then
		slot0._lineitemGOs = {}
	end

	slot0.linemolist = RoomStoreItemListModel.instance:getList()

	for slot4 = 1, #slot0.linemolist do
		if not slot0._lineitemGOs[slot4] then
			gohelper.setActive(slot6, true)
			table.insert(slot0._lineitemGOs, MonoHelper.getLuaComFromGo(gohelper.clone(slot0._golineitem, slot0._golineitemContent, "item" .. slot4), RoomStoreGoodsTipItem) or MonoHelper.addNoUpdateLuaComOnceToGo(slot6, RoomStoreGoodsTipItem))
		end

		slot5:onUpdateMO(slot0.linemolist[slot4])

		if slot4 % 2 == 0 then
			slot5._imgbg.enabled = true
		else
			slot5._imgbg.enabled = false
		end
	end
end

return slot0
