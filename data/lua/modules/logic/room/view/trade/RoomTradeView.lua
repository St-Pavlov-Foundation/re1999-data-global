module("modules.logic.room.view.trade.RoomTradeView", package.seeall)

slot0 = class("RoomTradeView", BaseView)

function slot0.onInitView(slot0)
	slot0._godailyselect = gohelper.findChild(slot0.viewGO, "root/tab/dailytab/#go_dailyselect")
	slot0._txtdaily = gohelper.findChildText(slot0.viewGO, "root/tab/dailytab/#txt_daily")
	slot0._btndailytab = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/tab/dailytab/#btn_dailytab")
	slot0._gowholesaleselect = gohelper.findChild(slot0.viewGO, "root/tab/wholesale /#go_wholesaleselect")
	slot0._txtwholesale = gohelper.findChildText(slot0.viewGO, "root/tab/wholesale /#txt_wholesale")
	slot0._btnwholesaletab = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/tab/wholesale /#btn_wholesaletab")
	slot0._gobarrage = gohelper.findChild(slot0.viewGO, "root/bottom/barrage/#go_barrage")
	slot0._txtweather = gohelper.findChildText(slot0.viewGO, "root/bottom/barrage/#go_barrage/#txt_weather")
	slot0._txtdialogue = gohelper.findChildText(slot0.viewGO, "root/bottom/barrage/#go_barrage/dialogue/#txt_dialogue")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/bottom/time/#txt_time")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndailytab:AddClickListener(slot0._btndailytabOnClick, slot0)
	slot0._btnwholesaletab:AddClickListener(slot0._btnwholesaletabOnClick, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.onRefresh, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, slot0.refreshBarrage, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnCutOrderPage, slot0.onRefreshOrderPage, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFlyCurrency, slot0.onFlyCurrency, slot0)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.PlayCloseTVAnim, slot0._onPlayCloseTvAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndailytab:RemoveClickListener()
	slot0._btnwholesaletab:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, slot0.onRefresh, slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.onRefresh, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, slot0.refreshBarrage, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnCutOrderPage, slot0.onRefreshOrderPage, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFlyCurrency, slot0.onFlyCurrency, slot0)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.PlayCloseTVAnim, slot0._onPlayCloseTvAnim, slot0)
end

function slot0._btndailytabOnClick(slot0)
	slot0:_cutMode(RoomTradeEnum.Mode.DailyOrder)
end

function slot0._btnwholesaletabOnClick(slot0)
	slot0:_cutMode(RoomTradeEnum.Mode.Wholesale)
end

function slot0._onPlayCloseTvAnim(slot0)
	slot0.viewContainer:getAnimatorPlayer():Play(UIAnimationName.Close)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_close)
end

function slot0._editableInitView(slot0)
	slot0._goBottom = gohelper.findChild(slot0.viewGO, "root/bottom")
	slot0._rootBarrage = gohelper.findChild(slot0.viewGO, "root/bottom/barrage")
	slot0._layoutDialogue = gohelper.findChild(slot0.viewGO, "root/bottom/barrage/#go_barrage/dialogue"):GetComponent(typeof(UnityEngine.UI.LayoutElement))
	slot0._goPageRoot = gohelper.findChild(slot0.viewGO, "root/page")
	slot0._goPageItem = gohelper.findChild(slot0.viewGO, "root/page/pointitem")
	slot0._gollyItem = gohelper.findChild(slot0.viewGO, "flyitem/go_flyitem")

	gohelper.setActive(slot0._goPageItem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RoomRpc.instance:sendGetOrderInfoRequest(slot0.onRefresh, slot0)
	slot0:_setBarrage()
	slot0:_updateTime()
	slot0:_openDefaultMode()
	TaskDispatcher.runRepeat(slot0._updateTime, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_jiaoyi_open)
end

function slot0.onClose(slot0)
	slot0._mode = nil

	TaskDispatcher.cancelTask(slot0._updateTime, slot0)
	TaskDispatcher.cancelTask(slot0._selectMode, slot0)
	TaskDispatcher.cancelTask(slot0._hideFlyEffect, slot0)
	slot0:_killAnim()
end

function slot0.onDestroyView(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._openDefaultMode(slot0)
	slot0._mode = slot0.viewParam.defaultTab or RoomTradeEnum.Mode.DailyOrder

	slot0:_selectMode()
	slot0:_activeTab()
end

function slot0._cutMode(slot0, slot1)
	if slot0._mode == slot1 or slot0._isPlayingSwitchAnim then
		return
	end

	slot0._mode = slot1
	slot0._isPlayingSwitchAnim = true

	slot0.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	slot0:_activeTab()
	TaskDispatcher.cancelTask(slot0._selectMode, slot0)
	TaskDispatcher.runDelay(slot0._selectMode, slot0, 0.16)
end

function slot0._selectMode(slot0)
	if not slot0._mode then
		return
	end

	slot0._isPlayingSwitchAnim = nil

	slot0.viewContainer:selectTabView(slot0._mode)
	slot0:activeBarrage(slot0._mode)
end

function slot0._activeTab(slot0)
	gohelper.setActive(slot0._godailyselect, slot0._mode == RoomTradeEnum.Mode.DailyOrder)
	gohelper.setActive(slot0._gowholesaleselect, slot0._mode == RoomTradeEnum.Mode.Wholesale)
	gohelper.setActive(slot0._goPageRoot, slot0._mode == RoomTradeEnum.Mode.Wholesale)
end

function slot0.onFlyCurrency(slot0)
	if not slot0._flyEffect then
		slot0._flyEffect = gohelper.findChild(slot0.viewGO, "vx_vitality/#vitality")
	end

	gohelper.setActive(slot0._flyEffect, true)
	TaskDispatcher.cancelTask(slot0._hideFlyEffect, slot0)
	TaskDispatcher.runDelay(slot0._hideFlyEffect, slot0, 1.1)
end

function slot0._hideFlyEffect(slot0)
	gohelper.setActive(slot0._flyEffect, false)
end

function slot0.onRefreshOrderPage(slot0, slot1)
	if slot0._mode == RoomTradeEnum.Mode.DailyOrder then
		gohelper.setActive(slot0._goPageRoot, false)

		return
	end

	for slot6 = 1, RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() do
		gohelper.setActive(slot0:getPageItem(slot6).cur, slot1 == slot6)
	end

	if slot0._pageItems then
		for slot6, slot7 in ipairs(slot0._pageItems) do
			gohelper.setActive(slot7.go, slot6 <= slot2)
		end
	end

	gohelper.setActive(slot0._goPageRoot, true)
end

function slot0.getPageItem(slot0, slot1)
	if not slot0._pageItems then
		slot0._pageItems = slot0:getUserDataTb_()
	end

	if not slot0._pageItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goPageItem, "page_" .. slot1)
		slot0._pageItems[slot1] = {
			go = slot3,
			cur = gohelper.findChild(slot3, "light")
		}
	end

	return slot2
end

function slot0._updateTime(slot0)
	slot1 = os.date("!*t", ServerTime.now() + ServerTime.serverUtcOffset())
	slot0._txttime.text = string.format("%02d:%02d", slot1.hour, slot1.min)
end

slot0.iconWidth = 120
slot0.timeMul = 0.01

function slot0._setBarrage(slot0)
	RoomTradeModel.instance:initBarrage()

	slot2 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Dialogue)
	slot3 = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.Weather) and slot1.desc or ""
	slot0._txtweather.text = slot3

	if slot0._layoutDialogue then
		slot0._layoutDialogue.minWidth = slot0._rootBarrage.transform.rect.width - SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtweather, slot3) - uv0.iconWidth * 2
	end

	if not string.nilorempty(slot1.icon) then
		UISpriteSetMgr.instance:setCritterSprite(gohelper.findChildImage(slot0._txtweather.gameObject, "icon"), slot7)
	end

	slot0:_killAnim()

	slot8 = 0

	if slot2 then
		slot9 = slot2.desc
		slot8 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtdialogue, slot9)
		slot0._txtdialogue.text = slot9

		recthelper.setAnchorX(slot0._txtdialogue.transform, uv0.iconWidth)
		gohelper.setActive(slot0._txtdialogue.gameObject, true)

		if not string.nilorempty(slot2.icon) then
			UISpriteSetMgr.instance:setCritterSprite(gohelper.findChildImage(slot0._txtdialogue.gameObject, "icon"), slot10)
		end
	else
		slot0._txtdialogue.text = ""

		gohelper.setActive(slot0._txtdialogue.gameObject, false)
	end

	recthelper.setAnchorX(slot0._gobarrage.transform, 0)

	slot9 = slot4 + slot8 + uv0.iconWidth * 2

	slot0:_runBarrage(slot9, slot5, slot9 * uv0.timeMul)
end

function slot0._runBarrage(slot0, slot1, slot2, slot3)
	slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._gobarrage.transform, -slot1, slot3, function ()
		uv0:_killAnim()
		recthelper.setAnchorX(uv0._gobarrage.transform, uv1 + uv2.iconWidth)
		uv0:_runBarrage(uv3, uv1, (uv1 + uv2.iconWidth + uv3) * uv2.timeMul)
	end, slot0, nil, EaseType.Linear)
end

function slot0.dailyRefresh(slot0)
	RoomRpc.instance:sendGetOrderInfoRequest(slot0.onRefresh, slot0)
end

function slot0._killAnim(slot0)
	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end
end

function slot0.onRefresh(slot0)
	slot0:refreshBarrage(slot0._mode)
end

function slot0.refreshBarrage(slot0, slot1)
	slot0:activeBarrage(slot1)
end

function slot0.activeBarrage(slot0, slot1)
	if slot1 == RoomTradeEnum.Mode.DailyOrder then
		slot2, slot3 = RoomTradeModel.instance:getDailyOrderFinishCount()

		gohelper.setActive(slot0._goBottom, not (slot3 <= slot2))
	else
		gohelper.setActive(slot0._goBottom, true)
	end
end

return slot0
