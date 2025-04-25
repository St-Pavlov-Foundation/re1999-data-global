module("modules.logic.room.view.trade.RoomDailyOrderItem", package.seeall)

slot0 = class("RoomDailyOrderItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_normalbg")
	slot0._simagespecialbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_specialbg")
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.viewGO, "customer/#simage_headicon")
	slot0._txtcustomername = gohelper.findChildText(slot0.viewGO, "customer/#txt_customername")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "refresh/#btn_refresh")
	slot0._gocanrefresh = gohelper.findChild(slot0.viewGO, "refresh/#btn_refresh/#go_refresh")
	slot0._golockrefresh = gohelper.findChild(slot0.viewGO, "refresh/#btn_refresh/#go_lock")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "refresh/#go_time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "refresh/#go_time/#txt_time")
	slot0._gostuffitem = gohelper.findChild(slot0.viewGO, "stuff/#go_stuffitem")
	slot0._gomaterial = gohelper.findChild(slot0.viewGO, "stuff/#go_material")
	slot0._simagerewardicon = gohelper.findChildSingleImage(slot0.viewGO, "reward/#simage_rewardicon")
	slot0._txtrewardcount = gohelper.findChildText(slot0.viewGO, "reward/#txt_rewardcount")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "reward/#go_tips")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "reward/#go_tips/#txt_num")
	slot0._btnlocked = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_lock")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#btn_lock/#go_locked")
	slot0._gounlocked = gohelper.findChild(slot0.viewGO, "#btn_lock/#go_unlocked")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "btn/traced/#go_unselect")
	slot0._gounselecticon = gohelper.findChild(slot0.viewGO, "btn/traced/#go_unselect/icon")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "btn/traced/#go_select")
	slot0._btntraced = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/traced/#btn_traced")
	slot0._btnunconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_unconfirm")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_confirm")
	slot0._btnwrongjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_wrongjump")
	slot0._txtwrongtip = gohelper.findChildText(slot0.viewGO, "btn/#btn_wrongjump/#txt_wrong")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0._btntraced:AddClickListener(slot0._btntracedOnClick, slot0)
	slot0._btnlocked:AddClickListener(slot0._btnlockedOnClick, slot0)
	slot0._btnunconfirm:AddClickListener(slot0._btnunconfirmOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnwrongjump:AddClickListener(slot0._btnwrongjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrefresh:RemoveClickListener()
	slot0._btntraced:RemoveClickListener()
	slot0._btnlocked:RemoveClickListener()
	slot0._btnunconfirm:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnwrongjump:RemoveClickListener()
end

function slot0._btntracedOnClick(slot0)
	if not slot0._mo then
		return
	end

	if slot0.isWrong then
		GameFacade.showToast(ToastEnum.RoomOrderTracedWrong)
	else
		slot1 = not slot0._mo.isTraced

		RoomTradeController.instance:tracedDailyOrder(slot0._mo.orderId, slot1)

		if slot1 then
			GameFacade.showToast(ToastEnum.RoomOrderTraced)
		else
			GameFacade.showToast(ToastEnum.RoomOrderNotTraced)
		end
	end
end

function slot0._btnlockedOnClick(slot0)
	if not slot0._mo then
		return
	end

	slot1 = not slot0._mo:getLocked()

	RoomTradeController.instance:lockedDailyOrder(slot0._mo.orderId, slot1)

	if slot1 then
		GameFacade.showToast(ToastEnum.RoomOrderLocked)
	else
		GameFacade.showToast(ToastEnum.RoomOrderUnlocked)
	end
end

function slot0._btnrefreshOnClick(slot0)
	if not slot0._mo or slot0:isHasRefreshTime() then
		return
	end

	if slot0._mo:getLocked() then
		GameFacade.showToast(ToastEnum.RoomOrderLockedWrong)

		return
	end

	if not RoomTradeModel.instance:isCanRefreshDailyOrder() then
		GameFacade.showToast(ToastEnum.RoomDailyOrderRefreshLimit)

		return
	end

	slot0._mo:setWaitRefresh(true)

	if GuideModel.instance:getLockGuideId() == GuideEnum.GuideId.RoomDailyOrder then
		RoomTradeController.instance:refreshDailyOrder(slot0._mo.orderId, slot1, GuideModel.instance:getById(slot1).currStepId)
	else
		RoomTradeController.instance:refreshDailyOrder(slot0._mo.orderId)
	end
end

function slot0._btnunconfirmOnClick(slot0)
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function slot0._btnconfirmOnClick(slot0)
	if not slot0._mo then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.DailyOrder, slot0._mo.orderId)
end

function slot0._btnwrongjumpOnClick(slot0)
	if not slot0.isWrong then
		return
	end

	if slot0.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(slot0.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
	TaskDispatcher.cancelTask(slot0.showItem, slot0)
	TaskDispatcher.cancelTask(slot0._reallyPlayOpenAnim, slot0)
end

function slot0._editableInitView(slot0)
	slot0._imgconfirm = gohelper.findChildImage(slot0.viewGO, "btn/#btn_confirm")
	slot0._gorefresh = gohelper.findChild(slot0.viewGO, "refresh")

	gohelper.setActive(slot0._gostuffitem, false)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onDestroy(slot0)
	slot0._simageheadicon:UnLoadImage()
	slot0._simagerewardicon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._refreshTimeCB, slot0)
end

slot1 = 0.16

function slot0.onUpdateMo(slot0, slot1)
	slot0._mo = slot1
	slot0.isWrong = false
	slot0.wrongBuildingUid = nil
	slot0.refreshTime = slot0._mo:getRefreshTime()

	if slot1.isFinish then
		slot0:playFinishAnim()
	elseif slot1.isNewRefresh or slot1:isWaitRefresh() then
		slot0:playRefreshAnim()
		TaskDispatcher.cancelTask(slot0.showItem, slot0)
		TaskDispatcher.runDelay(slot0.showItem, slot0, uv0)
		slot1:cancelNewRefresh()
	else
		slot0:showItem()
	end
end

function slot0.showItem(slot0)
	slot2 = HeroConfig.instance:getHeroCO(slot0._mo.buyerId)

	slot0._simageheadicon:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot2.skinId).headIcon))

	slot0._txtcustomername.text = slot2.name

	slot0:setPrice()
	slot0:onRefresh()

	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_wholesaleorder_priceratio"), slot0._mo:getAdvancedRate() * 100)

	gohelper.setActive(slot0._simagenormalbg.gameObject, not slot0._mo.isAdvanced)
	gohelper.setActive(slot0._simagespecialbg.gameObject, slot0._mo.isAdvanced)
	gohelper.setActive(slot0._gotips.gameObject, slot0._mo.isAdvanced)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imgconfirm, slot0._mo.isAdvanced and "room_trade_btn_spsubmit" or "room_trade_btn_submit")
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.onRefresh(slot0)
	if not slot0._mo then
		return
	end

	slot0:onRefreshMaterials()
	slot0:refreshConfirmBtn()
	slot0:refreshTraced()
	slot0:refreshLocked()
	slot0:checkRefreshTime()
end

function slot0.setPrice(slot0)
	slot1 = string.split(slot0._mo:getPrice(), "#")
	slot4 = slot1[3]
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot1[1], slot1[2])

	slot0._simagerewardicon:LoadImage(slot6)

	slot0._txtrewardcount.text = slot0._mo:getPriceCount()
end

function slot0.getMaterialItem(slot0, slot1)
	if not slot0._materialItem then
		slot0._materialItem = slot0:getUserDataTb_()
	end

	if not slot0._materialItem[slot1] then
		slot2 = {
			go = slot3,
			icon = gohelper.findChild(slot3, "icon"),
			txt = gohelper.findChildText(slot3, "count")
		}
		slot2.itemIcon = IconMgr.instance:getCommonItemIcon(slot2.icon)
		slot2.goWrong = gohelper.findChild(gohelper.clone(slot0._gostuffitem, slot0._gomaterial), "#go_wrong")
		slot0._materialItem[slot1] = slot2
	end

	return slot2
end

function slot0.onRefreshMaterials(slot0)
	if not slot0._mo then
		return
	end

	for slot5, slot6 in ipairs(slot0._mo.goodsInfo) do
		slot7 = slot0:getMaterialItem(slot5)

		transformhelper.setLocalScale(slot7.itemIcon.go.transform, 0.5, 0.5, 1)

		slot8, slot9, slot10 = slot6:getItem()

		slot7.itemIcon:setMOValue(slot8, slot9, slot10, nil, true)
		slot7.itemIcon:isShowQuality(false)
		slot7.itemIcon:isShowCount(false)

		slot7.txt.text = slot6:getQuantityStr()
		slot11 = false

		if not slot6:isEnoughCount() then
			slot11 = not slot6:isPlacedProduceBuilding() or slot6:checkProduceBuildingLevel()
		end

		gohelper.setActive(slot7.goWrong, slot11)
	end

	if slot0._materialItem then
		for slot5 = 1, #slot0._materialItem do
			gohelper.setActive(slot0._materialItem[slot5].go, slot5 <= #slot1)
		end
	end
end

function slot0.refreshConfirmBtn(slot0)
	slot1, slot0.wrongBuildingUid = slot0._mo:checkGoodsCanProduct()
	slot0.isWrong = not string.nilorempty(slot1)

	if not slot0._mo:isCanConfirm() and slot0.isWrong then
		gohelper.setActive(slot0._btnunconfirm.gameObject, false)
		gohelper.setActive(slot0._btnconfirm.gameObject, false)

		slot0._txtwrongtip.text = slot1

		gohelper.setActive(slot0._btnwrongjump.gameObject, true)
	else
		gohelper.setActive(slot0._btnunconfirm.gameObject, not slot3)
		gohelper.setActive(slot0._btnconfirm.gameObject, slot3)
		gohelper.setActive(slot0._btnwrongjump.gameObject, false)
	end
end

function slot0.refreshTraced(slot0)
	if slot0.isWrong then
		gohelper.setActive(slot0._gounselect, true)
		gohelper.setActive(slot0._goselect, false)
		ZProj.UGUIHelper.SetGrayscale(slot0._gounselecticon, true)
	else
		slot3 = slot0._mo.isTraced

		gohelper.setActive(slot1, not slot3)
		gohelper.setActive(slot2, slot3)
		ZProj.UGUIHelper.SetGrayscale(slot0._gounselecticon, false)
	end
end

function slot0.refreshLocked(slot0)
	slot1 = slot0._mo:getLocked()

	gohelper.setActive(slot0._golocked, slot1)
	gohelper.setActive(slot0._gounlocked, not slot1)

	if slot1 then
		gohelper.setActive(slot0._gotime, false)
	else
		slot0:checkRefreshTime()
	end

	gohelper.setActive(slot0._gocanrefresh, not slot1)
	gohelper.setActive(slot0._golockrefresh, slot1)
end

function slot0._refreshTimeCB(slot0)
	if not slot0:isHasRefreshTime() then
		if slot0._mo:getRefreshTime() <= 0 then
			TaskDispatcher.cancelTask(slot0._refreshTimeCB, slot0)
			gohelper.setActive(slot0._gotime, false)

			slot0.refreshTime = 0

			return
		else
			slot0.refreshTime = 0
		end
	else
		slot0.refreshTime = slot0.refreshTime - 1
	end

	slot0:_updateTime()
end

function slot0._updateTime(slot0)
	slot0._txttime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_dailyorder_refreshtime"), slot0.refreshTime)
end

function slot0.isHasRefreshTime(slot0)
	return slot0.refreshTime and slot0.refreshTime > 0
end

function slot0.checkRefreshTime(slot0)
	slot0.refreshTime = slot0._mo:getRefreshTime()
	slot1 = slot0:isHasRefreshTime()

	TaskDispatcher.cancelTask(slot0._refreshTimeCB, slot0)
	gohelper.setActive(slot0._gotime, slot1)

	if slot1 then
		slot0:_updateTime()
		TaskDispatcher.runRepeat(slot0._refreshTimeCB, slot0, 1)
	end

	gohelper.setActive(slot0._gorefresh, RoomTradeModel.instance:isCanRefreshDailyOrder())
end

function slot0.playOpenAnim(slot0, slot1)
	if not slot0._canvasGroup then
		slot0._canvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	slot0._animator.enabled = false
	slot0._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(slot0._reallyPlayOpenAnim, slot0)
	TaskDispatcher.runDelay(slot0._reallyPlayOpenAnim, slot0, (slot1 - 1) * 0.06)
end

function slot0._reallyPlayOpenAnim(slot0)
	slot0._animator.enabled = true

	slot0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Open, 0, 0)
end

function slot0.playRefreshAnim(slot0)
	slot0._animator.enabled = true

	slot0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Update, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

function slot0.playFinishAnim(slot0)
	slot0._animator.enabled = true

	slot0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Delivery, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

slot0.ResUrl = "ui/viewres/room/trade/roomdailyorderitem.prefab"

return slot0
