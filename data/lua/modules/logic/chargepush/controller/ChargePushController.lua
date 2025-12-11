module("modules.logic.chargepush.controller.ChargePushController", package.seeall)

local var_0_0 = class("ChargePushController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._pushViewOpenHandler = {
		[ChargePushEnum.PushViewType.MonthCard] = arg_1_0._onMonthCardPushViewOpen,
		[ChargePushEnum.PushViewType.LevelGoods] = arg_1_0._onLevelGoodsPushViewOpen
	}
end

function var_0_0.reInit(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.showCachePushView, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_3_0._onMainPopupFlowFinish, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0._onDailyRefresh(arg_4_0)
	ChargePushRpc.instance:sendGetChargePushInfoRequest()
end

function var_0_0._onMainPopupFlowFinish(arg_5_0)
	ChargePushRpc.instance:sendGetChargePushInfoRequest()
end

function var_0_0._onCloseViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.curPushView then
		arg_6_0.curPushView = nil
	end

	arg_6_0:_viewChangeCheckIsInMainView()
end

function var_0_0._onOpenViewFinish(arg_7_0, arg_7_1)
	arg_7_0:_viewChangeCheckIsInMainView()
end

function var_0_0._viewChangeCheckIsInMainView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.showCachePushView, arg_8_0)

	if not arg_8_0:isCanPushView() then
		return
	end

	TaskDispatcher.runDelay(arg_8_0.showCachePushView, arg_8_0, 1.6)
end

function var_0_0.isCanPushView(arg_9_0)
	local var_9_0 = ChargePushModel.instance:getCount()

	if not var_9_0 or var_9_0 <= 0 then
		return
	end

	if not MainController.instance:isInMainView() then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
		return
	end

	if arg_9_0:checkInGuide() then
		return
	end

	return true
end

function var_0_0.checkInGuide(arg_10_0)
	if GuideController.instance:isForbidGuides() then
		return false
	end

	local var_10_0 = false
	local var_10_1 = ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2)
	local var_10_2 = GuideModel.instance:lastForceGuideId()
	local var_10_3 = GuideModel.instance:isGuideFinish(var_10_2)

	if var_10_1 or not var_10_3 then
		var_10_0 = true
	end

	return var_10_0
end

function var_0_0.showCachePushView(arg_11_0)
	if not arg_11_0:isCanPushView() then
		return
	end

	local var_11_0 = ChargePushModel.instance:popNextPushInfo()

	if not var_11_0 then
		return
	end

	arg_11_0:showPushViewByConfig(var_11_0.config)
end

function var_0_0.showPushViewByConfig(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0._pushViewOpenHandler[arg_12_1.className]

	if not var_12_0 then
		return
	end

	ChargePushRpc.instance:sendRecordchargePushRequest(arg_12_1.goodpushsId)
	var_12_0(arg_12_0, arg_12_1)

	return true
end

function var_0_0._onMonthCardPushViewOpen(arg_13_0, arg_13_1)
	local var_13_0 = StoreModel.instance:getMonthCardInfo()
	local var_13_1 = var_13_0 and var_13_0:getRemainDay2() or StoreEnum.MonthCardStatus.NotPurchase
	local var_13_2 = tonumber(arg_13_1.listenerType)
	local var_13_3 = string.splitToNumber(arg_13_1.listenerParam, ",")
	local var_13_4 = false

	if var_13_2 == ChargePushEnum.ListenerType.MonthCardBefore then
		var_13_1 = var_13_1 + 1
		var_13_4 = var_13_1 >= var_13_3[1] and var_13_1 <= var_13_3[2]
	elseif var_13_2 == ChargePushEnum.ListenerType.MonthCardAfter then
		var_13_4 = var_13_1 <= 0
	else
		logError(string.format("ChargePushController:_onMonthCardPushViewOpen listenerType error [%s] [%s]", arg_13_1.listenerType, arg_13_1.listenerParam))
	end

	if not var_13_4 then
		return
	end

	arg_13_0:openPushView(ViewName.ChargePushMonthCardView, {
		config = arg_13_1
	})
end

function var_0_0._onLevelGoodsPushViewOpen(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = string.splitToNumber(arg_14_1.containedgoodsId, "#")

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		local var_14_2 = StoreModel.instance:getGoodsMO(iter_14_1)

		if var_14_2 and not var_14_2:isSoldOut() then
			table.insert(var_14_0, iter_14_1)
		end
	end

	if #var_14_0 <= 0 then
		return
	end

	arg_14_0:openPushView(ViewName.ChargePushLevelGoodsView, {
		config = arg_14_1
	})
end

function var_0_0.openPushView(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.curPushView = arg_15_1

	ChargePushStatController.instance:statShow(arg_15_2.config)
	ViewMgr.instance:openView(arg_15_1, arg_15_2)
end

function var_0_0.tryShowNextPush(arg_16_0, arg_16_1)
	local var_16_0 = ChargePushModel.instance:getList()

	if not var_16_0 or #var_16_0 <= 0 then
		return
	end

	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1.config.className == arg_16_1 then
			table.insert(var_16_1, iter_16_1)
		end
	end

	table.sort(var_16_1, ChargePushMO.sortFunction)

	if #var_16_1 <= 0 then
		return
	end

	local var_16_2 = var_16_1[1]

	ChargePushModel.instance:remove(var_16_2)

	return arg_16_0:showPushViewByConfig(var_16_2.config)
end

function var_0_0.isInPushViewShow(arg_17_0)
	return arg_17_0.curPushView and ViewMgr.instance:isOpen(arg_17_0.curPushView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
