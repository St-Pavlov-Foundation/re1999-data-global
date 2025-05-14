module("modules.logic.room.view.trade.RoomDailyOrderItem", package.seeall)

local var_0_0 = class("RoomDailyOrderItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_normalbg")
	arg_1_0._simagespecialbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_specialbg")
	arg_1_0._simageheadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "customer/#simage_headicon")
	arg_1_0._txtcustomername = gohelper.findChildText(arg_1_0.viewGO, "customer/#txt_customername")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "refresh/#btn_refresh")
	arg_1_0._gocanrefresh = gohelper.findChild(arg_1_0.viewGO, "refresh/#btn_refresh/#go_refresh")
	arg_1_0._golockrefresh = gohelper.findChild(arg_1_0.viewGO, "refresh/#btn_refresh/#go_lock")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "refresh/#go_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "refresh/#go_time/#txt_time")
	arg_1_0._gostuffitem = gohelper.findChild(arg_1_0.viewGO, "stuff/#go_stuffitem")
	arg_1_0._gomaterial = gohelper.findChild(arg_1_0.viewGO, "stuff/#go_material")
	arg_1_0._simagerewardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "reward/#simage_rewardicon")
	arg_1_0._txtrewardcount = gohelper.findChildText(arg_1_0.viewGO, "reward/#txt_rewardcount")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "reward/#go_tips")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "reward/#go_tips/#txt_num")
	arg_1_0._btnlocked = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_lock")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.viewGO, "#btn_lock/#go_locked")
	arg_1_0._gounlocked = gohelper.findChild(arg_1_0.viewGO, "#btn_lock/#go_unlocked")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "btn/traced/#go_unselect")
	arg_1_0._gounselecticon = gohelper.findChild(arg_1_0.viewGO, "btn/traced/#go_unselect/icon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "btn/traced/#go_select")
	arg_1_0._btntraced = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/traced/#btn_traced")
	arg_1_0._btnunconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_unconfirm")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_confirm")
	arg_1_0._btnwrongjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_wrongjump")
	arg_1_0._txtwrongtip = gohelper.findChildText(arg_1_0.viewGO, "btn/#btn_wrongjump/#txt_wrong")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0._btntraced:AddClickListener(arg_2_0._btntracedOnClick, arg_2_0)
	arg_2_0._btnlocked:AddClickListener(arg_2_0._btnlockedOnClick, arg_2_0)
	arg_2_0._btnunconfirm:AddClickListener(arg_2_0._btnunconfirmOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnwrongjump:AddClickListener(arg_2_0._btnwrongjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrefresh:RemoveClickListener()
	arg_3_0._btntraced:RemoveClickListener()
	arg_3_0._btnlocked:RemoveClickListener()
	arg_3_0._btnunconfirm:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnwrongjump:RemoveClickListener()
end

function var_0_0._btntracedOnClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	if arg_4_0.isWrong then
		GameFacade.showToast(ToastEnum.RoomOrderTracedWrong)
	else
		local var_4_0 = not arg_4_0._mo.isTraced

		RoomTradeController.instance:tracedDailyOrder(arg_4_0._mo.orderId, var_4_0)

		if var_4_0 then
			GameFacade.showToast(ToastEnum.RoomOrderTraced)
		else
			GameFacade.showToast(ToastEnum.RoomOrderNotTraced)
		end
	end
end

function var_0_0._btnlockedOnClick(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	local var_5_0 = not arg_5_0._mo:getLocked()

	RoomTradeController.instance:lockedDailyOrder(arg_5_0._mo.orderId, var_5_0)

	if var_5_0 then
		GameFacade.showToast(ToastEnum.RoomOrderLocked)
	else
		GameFacade.showToast(ToastEnum.RoomOrderUnlocked)
	end
end

function var_0_0._btnrefreshOnClick(arg_6_0)
	if not arg_6_0._mo or arg_6_0:isHasRefreshTime() then
		return
	end

	if arg_6_0._mo:getLocked() then
		GameFacade.showToast(ToastEnum.RoomOrderLockedWrong)

		return
	end

	if not RoomTradeModel.instance:isCanRefreshDailyOrder() then
		GameFacade.showToast(ToastEnum.RoomDailyOrderRefreshLimit)

		return
	end

	arg_6_0._mo:setWaitRefresh(true)

	local var_6_0 = GuideModel.instance:getLockGuideId()

	if var_6_0 == GuideEnum.GuideId.RoomDailyOrder then
		local var_6_1 = GuideModel.instance:getById(var_6_0).currStepId

		RoomTradeController.instance:refreshDailyOrder(arg_6_0._mo.orderId, var_6_0, var_6_1)
	else
		RoomTradeController.instance:refreshDailyOrder(arg_6_0._mo.orderId)
	end
end

function var_0_0._btnunconfirmOnClick(arg_7_0)
	GameFacade.showToast(ToastEnum.RoomOrderNotCommit)
end

function var_0_0._btnconfirmOnClick(arg_8_0)
	if not arg_8_0._mo then
		return
	end

	RoomTradeController.instance:finishDailyOrder(RoomTradeEnum.Mode.DailyOrder, arg_8_0._mo.orderId)
end

function var_0_0._btnwrongjumpOnClick(arg_9_0)
	if not arg_9_0.isWrong then
		return
	end

	if arg_9_0.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(arg_9_0.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function var_0_0.init(arg_10_0, arg_10_1)
	arg_10_0.viewGO = arg_10_1

	arg_10_0:onInitView()
end

function var_0_0.addEventListeners(arg_11_0)
	arg_11_0:addEvents()
end

function var_0_0.removeEventListeners(arg_12_0)
	arg_12_0:removeEvents()
	TaskDispatcher.cancelTask(arg_12_0.showItem, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._reallyPlayOpenAnim, arg_12_0)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._imgconfirm = gohelper.findChildImage(arg_13_0.viewGO, "btn/#btn_confirm")
	arg_13_0._gorefresh = gohelper.findChild(arg_13_0.viewGO, "refresh")

	gohelper.setActive(arg_13_0._gostuffitem, false)

	arg_13_0._animator = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onDestroy(arg_14_0)
	arg_14_0._simageheadicon:UnLoadImage()
	arg_14_0._simagerewardicon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeCB, arg_14_0)
end

local var_0_1 = 0.16

function var_0_0.onUpdateMo(arg_15_0, arg_15_1)
	arg_15_0._mo = arg_15_1
	arg_15_0.isWrong = false
	arg_15_0.wrongBuildingUid = nil
	arg_15_0.refreshTime = arg_15_0._mo:getRefreshTime()

	if arg_15_1.isFinish then
		arg_15_0:playFinishAnim()
	elseif arg_15_1.isNewRefresh or arg_15_1:isWaitRefresh() then
		arg_15_0:playRefreshAnim()
		TaskDispatcher.cancelTask(arg_15_0.showItem, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0.showItem, arg_15_0, var_0_1)
		arg_15_1:cancelNewRefresh()
	else
		arg_15_0:showItem()
	end
end

function var_0_0.showItem(arg_16_0)
	local var_16_0 = arg_16_0._mo.buyerId
	local var_16_1 = HeroConfig.instance:getHeroCO(var_16_0)
	local var_16_2 = var_16_1.skinId
	local var_16_3 = SkinConfig.instance:getSkinCo(var_16_2)

	arg_16_0._simageheadicon:LoadImage(ResUrl.getRoomHeadIcon(var_16_3.headIcon))

	arg_16_0._txtcustomername.text = var_16_1.name

	arg_16_0:setPrice()
	arg_16_0:onRefresh()

	local var_16_4 = luaLang("room_wholesaleorder_priceratio")

	arg_16_0._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_16_4, arg_16_0._mo:getAdvancedRate() * 100)

	gohelper.setActive(arg_16_0._simagenormalbg.gameObject, not arg_16_0._mo.isAdvanced)
	gohelper.setActive(arg_16_0._simagespecialbg.gameObject, arg_16_0._mo.isAdvanced)
	gohelper.setActive(arg_16_0._gotips.gameObject, arg_16_0._mo.isAdvanced)

	local var_16_5 = arg_16_0._mo.isAdvanced and "room_trade_btn_spsubmit" or "room_trade_btn_submit"

	UISpriteSetMgr.instance:setRoomSprite(arg_16_0._imgconfirm, var_16_5)
	gohelper.setActive(arg_16_0.viewGO, true)
end

function var_0_0.onRefresh(arg_17_0)
	if not arg_17_0._mo then
		return
	end

	arg_17_0:onRefreshMaterials()
	arg_17_0:refreshConfirmBtn()
	arg_17_0:refreshTraced()
	arg_17_0:refreshLocked()
	arg_17_0:checkRefreshTime()
end

function var_0_0.setPrice(arg_18_0)
	local var_18_0 = string.split(arg_18_0._mo:getPrice(), "#")
	local var_18_1 = var_18_0[1]
	local var_18_2 = var_18_0[2]
	local var_18_3 = var_18_0[3]
	local var_18_4, var_18_5 = ItemModel.instance:getItemConfigAndIcon(var_18_1, var_18_2)

	arg_18_0._simagerewardicon:LoadImage(var_18_5)

	arg_18_0._txtrewardcount.text = arg_18_0._mo:getPriceCount()
end

function var_0_0.getMaterialItem(arg_19_0, arg_19_1)
	if not arg_19_0._materialItem then
		arg_19_0._materialItem = arg_19_0:getUserDataTb_()
	end

	local var_19_0 = arg_19_0._materialItem[arg_19_1]

	if not var_19_0 then
		var_19_0 = {}

		local var_19_1 = gohelper.clone(arg_19_0._gostuffitem, arg_19_0._gomaterial)

		var_19_0.go = var_19_1
		var_19_0.icon = gohelper.findChild(var_19_1, "icon")
		var_19_0.txt = gohelper.findChildText(var_19_1, "count")
		var_19_0.itemIcon = IconMgr.instance:getCommonItemIcon(var_19_0.icon)
		var_19_0.goWrong = gohelper.findChild(var_19_1, "#go_wrong")
		arg_19_0._materialItem[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.onRefreshMaterials(arg_20_0)
	if not arg_20_0._mo then
		return
	end

	local var_20_0 = arg_20_0._mo.goodsInfo

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_1 = arg_20_0:getMaterialItem(iter_20_0)

		transformhelper.setLocalScale(var_20_1.itemIcon.go.transform, 0.5, 0.5, 1)

		local var_20_2, var_20_3, var_20_4 = iter_20_1:getItem()

		var_20_1.itemIcon:setMOValue(var_20_2, var_20_3, var_20_4, nil, true)
		var_20_1.itemIcon:isShowQuality(false)
		var_20_1.itemIcon:isShowCount(false)

		var_20_1.txt.text = iter_20_1:getQuantityStr()

		local var_20_5 = false

		if not iter_20_1:isEnoughCount() then
			var_20_5 = not iter_20_1:isPlacedProduceBuilding() or iter_20_1:checkProduceBuildingLevel()
		end

		gohelper.setActive(var_20_1.goWrong, var_20_5)
	end

	if arg_20_0._materialItem then
		for iter_20_2 = 1, #arg_20_0._materialItem do
			gohelper.setActive(arg_20_0._materialItem[iter_20_2].go, iter_20_2 <= #var_20_0)
		end
	end
end

function var_0_0.refreshConfirmBtn(arg_21_0)
	local var_21_0, var_21_1 = arg_21_0._mo:checkGoodsCanProduct()

	arg_21_0.isWrong = not string.nilorempty(var_21_0)
	arg_21_0.wrongBuildingUid = var_21_1

	local var_21_2 = arg_21_0._mo:isCanConfirm()

	if not var_21_2 and arg_21_0.isWrong then
		gohelper.setActive(arg_21_0._btnunconfirm.gameObject, false)
		gohelper.setActive(arg_21_0._btnconfirm.gameObject, false)

		arg_21_0._txtwrongtip.text = var_21_0

		gohelper.setActive(arg_21_0._btnwrongjump.gameObject, true)
	else
		gohelper.setActive(arg_21_0._btnunconfirm.gameObject, not var_21_2)
		gohelper.setActive(arg_21_0._btnconfirm.gameObject, var_21_2)
		gohelper.setActive(arg_21_0._btnwrongjump.gameObject, false)
	end
end

function var_0_0.refreshTraced(arg_22_0)
	local var_22_0 = arg_22_0._gounselect
	local var_22_1 = arg_22_0._goselect

	if arg_22_0.isWrong then
		gohelper.setActive(var_22_0, true)
		gohelper.setActive(var_22_1, false)
		ZProj.UGUIHelper.SetGrayscale(arg_22_0._gounselecticon, true)
	else
		local var_22_2 = arg_22_0._mo.isTraced

		gohelper.setActive(var_22_0, not var_22_2)
		gohelper.setActive(var_22_1, var_22_2)
		ZProj.UGUIHelper.SetGrayscale(arg_22_0._gounselecticon, false)
	end
end

function var_0_0.refreshLocked(arg_23_0)
	local var_23_0 = arg_23_0._mo:getLocked()

	gohelper.setActive(arg_23_0._golocked, var_23_0)
	gohelper.setActive(arg_23_0._gounlocked, not var_23_0)

	if var_23_0 then
		gohelper.setActive(arg_23_0._gotime, false)
	else
		arg_23_0:checkRefreshTime()
	end

	gohelper.setActive(arg_23_0._gocanrefresh, not var_23_0)
	gohelper.setActive(arg_23_0._golockrefresh, var_23_0)
end

function var_0_0._refreshTimeCB(arg_24_0)
	if not arg_24_0:isHasRefreshTime() then
		if arg_24_0._mo:getRefreshTime() <= 0 then
			TaskDispatcher.cancelTask(arg_24_0._refreshTimeCB, arg_24_0)
			gohelper.setActive(arg_24_0._gotime, false)

			arg_24_0.refreshTime = 0

			return
		else
			arg_24_0.refreshTime = 0
		end
	else
		arg_24_0.refreshTime = arg_24_0.refreshTime - 1
	end

	arg_24_0:_updateTime()
end

function var_0_0._updateTime(arg_25_0)
	arg_25_0._txttime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_dailyorder_refreshtime"), arg_25_0.refreshTime)
end

function var_0_0.isHasRefreshTime(arg_26_0)
	return arg_26_0.refreshTime and arg_26_0.refreshTime > 0
end

function var_0_0.checkRefreshTime(arg_27_0)
	arg_27_0.refreshTime = arg_27_0._mo:getRefreshTime()

	local var_27_0 = arg_27_0:isHasRefreshTime()

	TaskDispatcher.cancelTask(arg_27_0._refreshTimeCB, arg_27_0)
	gohelper.setActive(arg_27_0._gotime, var_27_0)

	if var_27_0 then
		arg_27_0:_updateTime()
		TaskDispatcher.runRepeat(arg_27_0._refreshTimeCB, arg_27_0, 1)
	end

	local var_27_1 = RoomTradeModel.instance:isCanRefreshDailyOrder()

	gohelper.setActive(arg_27_0._gorefresh, var_27_1)
end

function var_0_0.playOpenAnim(arg_28_0, arg_28_1)
	if not arg_28_0._canvasGroup then
		arg_28_0._canvasGroup = arg_28_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	arg_28_0._animator.enabled = false
	arg_28_0._canvasGroup.alpha = 0

	TaskDispatcher.cancelTask(arg_28_0._reallyPlayOpenAnim, arg_28_0)
	TaskDispatcher.runDelay(arg_28_0._reallyPlayOpenAnim, arg_28_0, (arg_28_1 - 1) * 0.06)
end

function var_0_0._reallyPlayOpenAnim(arg_29_0)
	arg_29_0._animator.enabled = true

	arg_29_0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Open, 0, 0)
end

function var_0_0.playRefreshAnim(arg_30_0)
	arg_30_0._animator.enabled = true

	arg_30_0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Update, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

function var_0_0.playFinishAnim(arg_31_0)
	arg_31_0._animator.enabled = true

	arg_31_0._animator:Play(RoomTradeEnum.TradeDailyOrderAnim.Delivery, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_order)
end

var_0_0.ResUrl = "ui/viewres/room/trade/roomdailyorderitem.prefab"

return var_0_0
