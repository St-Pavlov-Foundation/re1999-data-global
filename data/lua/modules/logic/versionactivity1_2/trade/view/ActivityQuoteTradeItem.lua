module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteTradeItem", package.seeall)

slot0 = class("ActivityQuoteTradeItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.viewGO = slot1
	slot0._godemanditem = gohelper.findChild(slot1, "#go_demanditem")
	slot0.content = gohelper.findChild(slot1, "mask/content")
	slot0.scroll = gohelper.findChild(slot0.content, "#scroll_trade"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0.scrollMask = gohelper.findChild(slot0.content, "#scroll_trade/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot0.scrollcontent = gohelper.findChild(slot0.content, "#scroll_trade/Viewport/Content")
	slot0.txtTips = gohelper.findChildTextMesh(slot0.content, "#go_tips/#txt_tips")
	slot0._simagetipsbg = gohelper.findChildSingleImage(slot0.content, "#go_tips/#simage_tipsbg")

	slot0._simagetipsbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_datiao9"))

	slot0.goClose = gohelper.findChild(slot1, "#go_close")
	slot0._simageclosebg = gohelper.findChildSingleImage(slot1, "#go_close/#simage_closebg")

	slot0._simageclosebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_dayang"))

	slot0._gobargain = gohelper.findChild(slot1, "mask/content/#scroll_trade/Viewport/Content/#go_bargain")
	slot0._animbargain = slot0._gobargain:GetComponent(typeof(UnityEngine.Animator))
	slot0._goquoteitem = gohelper.findChild(slot0._gobargain, "#scroll_info/Viewport/Content/#go_quoteitem")
	slot0._items = {}

	slot0:addEvents()
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refresh(slot0, slot1)
	slot0.actId = slot1

	slot0:refreshTrade(slot0.refreshQuote, slot0)
end

function slot0.refreshTrade(slot0, slot1)
	slot0.refreshCallback = slot1

	TaskDispatcher.cancelTask(slot0.onAllAnimFinish, slot0)

	slot2, slot3 = Activity117Model.instance:getFinishOrderCount(slot0.actId)
	slot0.allFinish = slot3 <= slot2

	if slot0.allFinish then
		slot0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips2"), {
			slot2,
			slot3
		})
	else
		slot0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips1"), slot4)
	end

	gohelper.setActive(slot0.goClose, slot0.allFinish or false)

	slot5 = Activity117Model.instance:getOrderList(slot0.actId)
	slot0.dataList = slot5
	slot0.index = 0
	slot6 = math.max(#slot5, #slot0._items)

	TaskDispatcher.cancelTask(slot0.refreshIndex, slot0)

	if #slot0._items >= #slot5 then
		for slot10 = 1, slot6 do
			slot0:refreshIndex(slot10)
		end
	else
		TaskDispatcher.runRepeat(slot0.refreshIndex, slot0, 0.02, slot6)
	end
end

function slot0.refreshIndex(slot0, slot1)
	slot1 = slot1 or slot0.index + 1
	slot0.index = slot1

	if not slot0._items[slot1] then
		slot0._items[slot1] = ActivityQuoteDemandItem.New(gohelper.clone(slot0._godemanditem, slot0.scrollcontent, "trade_item" .. tostring(slot1)))
	end

	slot3 = slot0.dataList[slot1]

	slot2:setData(slot3, slot0.allFinish, slot1, #slot0.dataList, slot0._onAllAnimFinish, slot0)

	if slot3 and slot3.id == slot0:getSelectOrderId() then
		slot0.selectIndex = slot1

		slot0._gobargain.transform:SetSiblingIndex(slot1)
	end

	if slot0.index == #slot0.dataList and slot0.refreshCallback then
		slot0:refreshCallback()
	end
end

function slot0.onAllAnimFinish(slot0)
	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:onAllAnimFinish()
		end
	end
end

function slot0._onAllAnimFinish(slot0)
	TaskDispatcher.runDelay(slot0.onAllAnimFinish, slot0, 1)
end

function slot0.refreshQuote(slot0)
	TaskDispatcher.cancelTask(slot0._animCallback, slot0)

	slot2 = false

	if slot0.inSelect ~= not slot0:noSelectOrder() then
		slot2 = true
		slot0.inSelect = slot1

		if slot1 then
			slot0:playShowQuoteAnim()
		else
			slot0:playHideQuoteAnim()
		end
	end

	if not slot1 then
		return
	end

	slot0.scroll.enabled = false
	slot0.scrollMask.enabled = false

	gohelper.setActive(slot0._gobargain, true)

	slot3 = Activity117Model.instance:getOrderDataById(slot0.actId, slot0:getSelectOrderId())

	if not slot0.quoteItem then
		slot0.quoteItem = ActivityQuoteItem.New(slot0._goquoteitem)
	end

	if slot2 then
		slot0.quoteItem:resetData()
	end

	slot0.quoteItem:setData(slot3)
end

function slot0.playShowQuoteAnim(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.content.transform, -recthelper.getAnchorY(slot0._items[slot0.selectIndex].go.transform) + 215 - recthelper.getAnchorY(slot0.scrollcontent.transform), 0.3)

	slot0._animbargain:Play(UIAnimationName.Open)
end

function slot0.playHideQuoteAnim(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._tweenId = ZProj.TweenHelper.DOAnchorPosY(slot0.content.transform, 0, 0.3)

	slot0._animbargain:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(slot0._animCallback, slot0, 0.6)

	slot0.scroll.enabled = true
	slot0.scrollMask.enabled = true
end

function slot0._animCallback(slot0)
	if not slot0.inSelect then
		gohelper.setActive(slot0._gobargain, false)
	end
end

function slot0.getSelectOrderId(slot0)
	return Activity117Model.instance:getSelectOrder(slot0.actId)
end

function slot0.noSelectOrder(slot0)
	return not slot0:getSelectOrderId()
end

function slot0.onNegotiate(slot0)
	slot0:refreshTrade()

	if slot0.quoteItem then
		slot0.quoteItem:onNegotiate(Activity117Model.instance:getOrderDataById(slot0.actId, slot0:getSelectOrderId()))
	end
end

function slot0.destory(slot0)
	TaskDispatcher.cancelTask(slot0.refreshIndex, slot0)
	TaskDispatcher.cancelTask(slot0.onAllAnimFinish, slot0)
	TaskDispatcher.cancelTask(slot0._animCallback, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._simagetipsbg:UnLoadImage()
	slot0._simageclosebg:UnLoadImage()

	for slot4, slot5 in pairs(slot0._items) do
		slot5:destory()
	end

	slot0._items = nil

	if slot0.quoteItem then
		slot0.quoteItem:destory()

		slot0.quoteItem = nil
	end

	slot0:removeEvents()
	slot0:__onDispose()
end

return slot0
