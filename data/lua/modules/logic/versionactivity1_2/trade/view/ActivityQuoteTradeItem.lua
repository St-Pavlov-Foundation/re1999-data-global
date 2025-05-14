module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteTradeItem", package.seeall)

local var_0_0 = class("ActivityQuoteTradeItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0._godemanditem = gohelper.findChild(arg_1_1, "#go_demanditem")
	arg_1_0.content = gohelper.findChild(arg_1_1, "mask/content")
	arg_1_0.scroll = gohelper.findChild(arg_1_0.content, "#scroll_trade"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0.scrollMask = gohelper.findChild(arg_1_0.content, "#scroll_trade/Viewport"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	arg_1_0.scrollcontent = gohelper.findChild(arg_1_0.content, "#scroll_trade/Viewport/Content")
	arg_1_0.txtTips = gohelper.findChildTextMesh(arg_1_0.content, "#go_tips/#txt_tips")
	arg_1_0._simagetipsbg = gohelper.findChildSingleImage(arg_1_0.content, "#go_tips/#simage_tipsbg")

	arg_1_0._simagetipsbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_datiao9"))

	arg_1_0.goClose = gohelper.findChild(arg_1_1, "#go_close")
	arg_1_0._simageclosebg = gohelper.findChildSingleImage(arg_1_1, "#go_close/#simage_closebg")

	arg_1_0._simageclosebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_dayang"))

	arg_1_0._gobargain = gohelper.findChild(arg_1_1, "mask/content/#scroll_trade/Viewport/Content/#go_bargain")
	arg_1_0._animbargain = arg_1_0._gobargain:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goquoteitem = gohelper.findChild(arg_1_0._gobargain, "#scroll_info/Viewport/Content/#go_quoteitem")
	arg_1_0._items = {}

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refresh(arg_4_0, arg_4_1)
	arg_4_0.actId = arg_4_1

	arg_4_0:refreshTrade(arg_4_0.refreshQuote, arg_4_0)
end

function var_0_0.refreshTrade(arg_5_0, arg_5_1)
	arg_5_0.refreshCallback = arg_5_1

	TaskDispatcher.cancelTask(arg_5_0.onAllAnimFinish, arg_5_0)

	local var_5_0, var_5_1 = Activity117Model.instance:getFinishOrderCount(arg_5_0.actId)

	arg_5_0.allFinish = var_5_1 <= var_5_0

	local var_5_2 = {
		var_5_0,
		var_5_1
	}

	if arg_5_0.allFinish then
		arg_5_0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips2"), var_5_2)
	else
		arg_5_0.txtTips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_tips1"), var_5_2)
	end

	gohelper.setActive(arg_5_0.goClose, arg_5_0.allFinish or false)

	local var_5_3 = Activity117Model.instance:getOrderList(arg_5_0.actId)

	arg_5_0.dataList = var_5_3
	arg_5_0.index = 0

	local var_5_4 = math.max(#var_5_3, #arg_5_0._items)

	TaskDispatcher.cancelTask(arg_5_0.refreshIndex, arg_5_0)

	if #arg_5_0._items >= #var_5_3 then
		for iter_5_0 = 1, var_5_4 do
			arg_5_0:refreshIndex(iter_5_0)
		end
	else
		TaskDispatcher.runRepeat(arg_5_0.refreshIndex, arg_5_0, 0.02, var_5_4)
	end
end

function var_0_0.refreshIndex(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or arg_6_0.index + 1
	arg_6_0.index = arg_6_1

	local var_6_0 = arg_6_0._items[arg_6_1]

	if not var_6_0 then
		local var_6_1 = gohelper.clone(arg_6_0._godemanditem, arg_6_0.scrollcontent, "trade_item" .. tostring(arg_6_1))

		var_6_0 = ActivityQuoteDemandItem.New(var_6_1)
		arg_6_0._items[arg_6_1] = var_6_0
	end

	local var_6_2 = arg_6_0.dataList[arg_6_1]

	var_6_0:setData(var_6_2, arg_6_0.allFinish, arg_6_1, #arg_6_0.dataList, arg_6_0._onAllAnimFinish, arg_6_0)

	if var_6_2 and var_6_2.id == arg_6_0:getSelectOrderId() then
		arg_6_0.selectIndex = arg_6_1

		arg_6_0._gobargain.transform:SetSiblingIndex(arg_6_1)
	end

	if arg_6_0.index == #arg_6_0.dataList and arg_6_0.refreshCallback then
		arg_6_0.refreshCallback(arg_6_0)
	end
end

function var_0_0.onAllAnimFinish(arg_7_0)
	if arg_7_0._items then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._items) do
			iter_7_1:onAllAnimFinish()
		end
	end
end

function var_0_0._onAllAnimFinish(arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.onAllAnimFinish, arg_8_0, 1)
end

function var_0_0.refreshQuote(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._animCallback, arg_9_0)

	local var_9_0 = not arg_9_0:noSelectOrder()
	local var_9_1 = false

	if arg_9_0.inSelect ~= var_9_0 then
		var_9_1 = true
		arg_9_0.inSelect = var_9_0

		if var_9_0 then
			arg_9_0:playShowQuoteAnim()
		else
			arg_9_0:playHideQuoteAnim()
		end
	end

	if not var_9_0 then
		return
	end

	arg_9_0.scroll.enabled = false
	arg_9_0.scrollMask.enabled = false

	gohelper.setActive(arg_9_0._gobargain, true)

	local var_9_2 = Activity117Model.instance:getOrderDataById(arg_9_0.actId, arg_9_0:getSelectOrderId())

	if not arg_9_0.quoteItem then
		arg_9_0.quoteItem = ActivityQuoteItem.New(arg_9_0._goquoteitem)
	end

	if var_9_1 then
		arg_9_0.quoteItem:resetData()
	end

	arg_9_0.quoteItem:setData(var_9_2)
end

function var_0_0.playShowQuoteAnim(arg_10_0)
	if arg_10_0._tweenId then
		ZProj.TweenHelper.KillById(arg_10_0._tweenId)

		arg_10_0._tweenId = nil
	end

	local var_10_0 = arg_10_0._items[arg_10_0.selectIndex]
	local var_10_1 = recthelper.getAnchorY(arg_10_0.scrollcontent.transform)
	local var_10_2 = -recthelper.getAnchorY(var_10_0.go.transform) + 215 - var_10_1

	arg_10_0._tweenId = ZProj.TweenHelper.DOAnchorPosY(arg_10_0.content.transform, var_10_2, 0.3)

	arg_10_0._animbargain:Play(UIAnimationName.Open)
end

function var_0_0.playHideQuoteAnim(arg_11_0)
	if arg_11_0._tweenId then
		ZProj.TweenHelper.KillById(arg_11_0._tweenId)

		arg_11_0._tweenId = nil
	end

	arg_11_0._tweenId = ZProj.TweenHelper.DOAnchorPosY(arg_11_0.content.transform, 0, 0.3)

	arg_11_0._animbargain:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_11_0._animCallback, arg_11_0, 0.6)

	arg_11_0.scroll.enabled = true
	arg_11_0.scrollMask.enabled = true
end

function var_0_0._animCallback(arg_12_0)
	if not arg_12_0.inSelect then
		gohelper.setActive(arg_12_0._gobargain, false)
	end
end

function var_0_0.getSelectOrderId(arg_13_0)
	return Activity117Model.instance:getSelectOrder(arg_13_0.actId)
end

function var_0_0.noSelectOrder(arg_14_0)
	return not arg_14_0:getSelectOrderId()
end

function var_0_0.onNegotiate(arg_15_0)
	arg_15_0:refreshTrade()

	local var_15_0 = Activity117Model.instance:getOrderDataById(arg_15_0.actId, arg_15_0:getSelectOrderId())

	if arg_15_0.quoteItem then
		arg_15_0.quoteItem:onNegotiate(var_15_0)
	end
end

function var_0_0.destory(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.refreshIndex, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.onAllAnimFinish, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._animCallback, arg_16_0)

	if arg_16_0._tweenId then
		ZProj.TweenHelper.KillById(arg_16_0._tweenId)

		arg_16_0._tweenId = nil
	end

	arg_16_0._simagetipsbg:UnLoadImage()
	arg_16_0._simageclosebg:UnLoadImage()

	for iter_16_0, iter_16_1 in pairs(arg_16_0._items) do
		iter_16_1:destory()
	end

	arg_16_0._items = nil

	if arg_16_0.quoteItem then
		arg_16_0.quoteItem:destory()

		arg_16_0.quoteItem = nil
	end

	arg_16_0:removeEvents()
	arg_16_0:__onDispose()
end

return var_0_0
