module("modules.logic.room.view.trade.RoomTradeView", package.seeall)

local var_0_0 = class("RoomTradeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godailyselect = gohelper.findChild(arg_1_0.viewGO, "root/tab/dailytab/#go_dailyselect")
	arg_1_0._txtdaily = gohelper.findChildText(arg_1_0.viewGO, "root/tab/dailytab/#txt_daily")
	arg_1_0._btndailytab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/tab/dailytab/#btn_dailytab")
	arg_1_0._gowholesaleselect = gohelper.findChild(arg_1_0.viewGO, "root/tab/wholesale /#go_wholesaleselect")
	arg_1_0._txtwholesale = gohelper.findChildText(arg_1_0.viewGO, "root/tab/wholesale /#txt_wholesale")
	arg_1_0._btnwholesaletab = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/tab/wholesale /#btn_wholesaletab")
	arg_1_0._gobarrage = gohelper.findChild(arg_1_0.viewGO, "root/bottom/barrage/#go_barrage")
	arg_1_0._txtweather = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/barrage/#go_barrage/#txt_weather")
	arg_1_0._txtdialogue = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/barrage/#go_barrage/dialogue/#txt_dialogue")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/bottom/time/#txt_time")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndailytab:AddClickListener(arg_2_0._btndailytabOnClick, arg_2_0)
	arg_2_0._btnwholesaletab:AddClickListener(arg_2_0._btnwholesaletabOnClick, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_2_0.onRefresh, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.onRefresh, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, arg_2_0.refreshBarrage, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnCutOrderPage, arg_2_0.onRefreshOrderPage, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFlyCurrency, arg_2_0.onFlyCurrency, arg_2_0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.PlayCloseTVAnim, arg_2_0._onPlayCloseTvAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndailytab:RemoveClickListener()
	arg_3_0._btnwholesaletab:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, arg_3_0.onRefresh, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.onRefresh, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, arg_3_0.refreshBarrage, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnCutOrderPage, arg_3_0.onRefreshOrderPage, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFlyCurrency, arg_3_0.onFlyCurrency, arg_3_0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.PlayCloseTVAnim, arg_3_0._onPlayCloseTvAnim, arg_3_0)
end

function var_0_0._btndailytabOnClick(arg_4_0)
	arg_4_0:_cutMode(RoomTradeEnum.Mode.DailyOrder)
end

function var_0_0._btnwholesaletabOnClick(arg_5_0)
	arg_5_0:_cutMode(RoomTradeEnum.Mode.Wholesale)
end

function var_0_0._onPlayCloseTvAnim(arg_6_0)
	arg_6_0.viewContainer:getAnimatorPlayer():Play(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goBottom = gohelper.findChild(arg_7_0.viewGO, "root/bottom")
	arg_7_0._rootBarrage = gohelper.findChild(arg_7_0.viewGO, "root/bottom/barrage")
	arg_7_0._layoutDialogue = gohelper.findChild(arg_7_0.viewGO, "root/bottom/barrage/#go_barrage/dialogue"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
	arg_7_0._goPageRoot = gohelper.findChild(arg_7_0.viewGO, "root/page")
	arg_7_0._goPageItem = gohelper.findChild(arg_7_0.viewGO, "root/page/pointitem")
	arg_7_0._gollyItem = gohelper.findChild(arg_7_0.viewGO, "flyitem/go_flyitem")

	gohelper.setActive(arg_7_0._goPageItem, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	RoomRpc.instance:sendGetOrderInfoRequest(arg_9_0.onRefresh, arg_9_0)
	arg_9_0:_setBarrage()
	arg_9_0:_updateTime()
	arg_9_0:_openDefaultMode()
	TaskDispatcher.runRepeat(arg_9_0._updateTime, arg_9_0, 1)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_open)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0._mode = nil

	TaskDispatcher.cancelTask(arg_10_0._updateTime, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._selectMode, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._hideFlyEffect, arg_10_0)
	arg_10_0:_killAnim()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onClickModalMask(arg_12_0)
	arg_12_0:closeThis()
end

function var_0_0._openDefaultMode(arg_13_0)
	arg_13_0._mode = arg_13_0.viewParam.defaultTab or RoomTradeEnum.Mode.DailyOrder

	arg_13_0:_selectMode()
	arg_13_0:_activeTab()
end

function var_0_0._cutMode(arg_14_0, arg_14_1)
	if arg_14_0._mode == arg_14_1 or arg_14_0._isPlayingSwitchAnim then
		return
	end

	arg_14_0._mode = arg_14_1
	arg_14_0._isPlayingSwitchAnim = true

	arg_14_0.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	arg_14_0:_activeTab()
	TaskDispatcher.cancelTask(arg_14_0._selectMode, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._selectMode, arg_14_0, 0.16)
end

function var_0_0._selectMode(arg_15_0)
	if not arg_15_0._mode then
		return
	end

	arg_15_0._isPlayingSwitchAnim = nil

	arg_15_0.viewContainer:selectTabView(arg_15_0._mode)
	arg_15_0:activeBarrage(arg_15_0._mode)
end

function var_0_0._activeTab(arg_16_0)
	gohelper.setActive(arg_16_0._godailyselect, arg_16_0._mode == RoomTradeEnum.Mode.DailyOrder)
	gohelper.setActive(arg_16_0._gowholesaleselect, arg_16_0._mode == RoomTradeEnum.Mode.Wholesale)
	gohelper.setActive(arg_16_0._goPageRoot, arg_16_0._mode == RoomTradeEnum.Mode.Wholesale)
end

function var_0_0.onFlyCurrency(arg_17_0)
	if not arg_17_0._flyEffect then
		arg_17_0._flyEffect = gohelper.findChild(arg_17_0.viewGO, "vx_vitality/#vitality")
	end

	gohelper.setActive(arg_17_0._flyEffect, true)
	TaskDispatcher.cancelTask(arg_17_0._hideFlyEffect, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0._hideFlyEffect, arg_17_0, 1.1)
end

function var_0_0._hideFlyEffect(arg_18_0)
	gohelper.setActive(arg_18_0._flyEffect, false)
end

function var_0_0.onRefreshOrderPage(arg_19_0, arg_19_1)
	if arg_19_0._mode == RoomTradeEnum.Mode.DailyOrder then
		gohelper.setActive(arg_19_0._goPageRoot, false)

		return
	end

	local var_19_0 = RoomTradeModel.instance:getWholesaleGoodsPageMaxCount()

	for iter_19_0 = 1, var_19_0 do
		local var_19_1 = arg_19_0:getPageItem(iter_19_0)

		gohelper.setActive(var_19_1.cur, arg_19_1 == iter_19_0)
	end

	if arg_19_0._pageItems then
		for iter_19_1, iter_19_2 in ipairs(arg_19_0._pageItems) do
			gohelper.setActive(iter_19_2.go, iter_19_1 <= var_19_0)
		end
	end

	gohelper.setActive(arg_19_0._goPageRoot, true)
end

function var_0_0.getPageItem(arg_20_0, arg_20_1)
	if not arg_20_0._pageItems then
		arg_20_0._pageItems = arg_20_0:getUserDataTb_()
	end

	local var_20_0 = arg_20_0._pageItems[arg_20_1]

	if not var_20_0 then
		local var_20_1 = gohelper.cloneInPlace(arg_20_0._goPageItem, "page_" .. arg_20_1)
		local var_20_2 = gohelper.findChild(var_20_1, "light")

		var_20_0 = {
			go = var_20_1,
			cur = var_20_2
		}
		arg_20_0._pageItems[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0._updateTime(arg_21_0)
	local var_21_0 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())

	arg_21_0._txttime.text = string.format("%02d:%02d", var_21_0.hour, var_21_0.min)
end

var_0_0.iconWidth = 120
var_0_0.timeMul = 0.01

function var_0_0._setBarrage(arg_22_0)
	RoomTradeModel.instance:initBarrage()

	local var_22_0 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Weather)
	local var_22_1 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Dialogue)
	local var_22_2 = var_22_0 and var_22_0.desc or ""
	local var_22_3 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_22_0._txtweather, var_22_2)
	local var_22_4 = arg_22_0._rootBarrage.transform.rect.width
	local var_22_5 = var_22_4 - var_22_3 - var_0_0.iconWidth * 2

	arg_22_0._txtweather.text = var_22_2

	if arg_22_0._layoutDialogue then
		arg_22_0._layoutDialogue.minWidth = var_22_5
	end

	local var_22_6 = var_22_0.icon

	if not string.nilorempty(var_22_6) then
		local var_22_7 = gohelper.findChildImage(arg_22_0._txtweather.gameObject, "icon")

		UISpriteSetMgr.instance:setCritterSprite(var_22_7, var_22_6)
	end

	arg_22_0:_killAnim()

	local var_22_8 = 0

	if var_22_1 then
		local var_22_9 = var_22_1.desc

		var_22_8 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_22_0._txtdialogue, var_22_9)
		arg_22_0._txtdialogue.text = var_22_9

		recthelper.setAnchorX(arg_22_0._txtdialogue.transform, var_0_0.iconWidth)
		gohelper.setActive(arg_22_0._txtdialogue.gameObject, true)

		local var_22_10 = var_22_1.icon

		if not string.nilorempty(var_22_10) then
			local var_22_11 = gohelper.findChildImage(arg_22_0._txtdialogue.gameObject, "icon")

			UISpriteSetMgr.instance:setCritterSprite(var_22_11, var_22_10)
		end
	else
		arg_22_0._txtdialogue.text = ""

		gohelper.setActive(arg_22_0._txtdialogue.gameObject, false)
	end

	recthelper.setAnchorX(arg_22_0._gobarrage.transform, 0)

	local var_22_12 = var_22_3 + var_22_8 + var_0_0.iconWidth * 2
	local var_22_13 = var_22_12 * var_0_0.timeMul

	arg_22_0:_runBarrage(var_22_12, var_22_4, var_22_13)
end

function var_0_0._runBarrage(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local function var_23_0()
		arg_23_0:_killAnim()
		recthelper.setAnchorX(arg_23_0._gobarrage.transform, arg_23_2 + var_0_0.iconWidth)

		local var_24_0 = (arg_23_2 + var_0_0.iconWidth + arg_23_1) * var_0_0.timeMul

		arg_23_0:_runBarrage(arg_23_1, arg_23_2, var_24_0)
	end

	arg_23_0._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_23_0._gobarrage.transform, -arg_23_1, arg_23_3, var_23_0, arg_23_0, nil, EaseType.Linear)
end

function var_0_0.dailyRefresh(arg_25_0)
	RoomRpc.instance:sendGetOrderInfoRequest(arg_25_0.onRefresh, arg_25_0)
end

function var_0_0._killAnim(arg_26_0)
	if arg_26_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_26_0._moveTweenId)

		arg_26_0._moveTweenId = nil
	end
end

function var_0_0.onRefresh(arg_27_0)
	arg_27_0:refreshBarrage(arg_27_0._mode)
end

function var_0_0.refreshBarrage(arg_28_0, arg_28_1)
	arg_28_0:activeBarrage(arg_28_1)
end

function var_0_0.activeBarrage(arg_29_0, arg_29_1)
	if arg_29_1 == RoomTradeEnum.Mode.DailyOrder then
		local var_29_0, var_29_1 = RoomTradeModel.instance:getDailyOrderFinishCount()
		local var_29_2 = var_29_1 <= var_29_0

		gohelper.setActive(arg_29_0._goBottom, not var_29_2)
	else
		gohelper.setActive(arg_29_0._goBottom, true)
	end
end

return var_0_0
