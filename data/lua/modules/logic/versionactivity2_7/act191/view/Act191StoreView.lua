module("modules.logic.versionactivity2_7.act191.view.Act191StoreView", package.seeall)

local var_0_0 = class("Act191StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/image_LimitTimeBG/#txt_time")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "righttop/#txt_Coin")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_2_0.refreshCurrency, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.actId = VersionActivity3_1Enum.ActivityId.DouQuQu3Store

	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.storeItemList = arg_4_0:getUserDataTb_()
	arg_4_0.rectTrContent = arg_4_0._goContent:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.onOpen(arg_5_0)
	Act191StatController.instance:onViewOpen(arg_5_0.viewName)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	arg_5_0:refreshTime()
	TaskDispatcher.runRepeat(arg_5_0.refreshTime, arg_5_0, TimeUtil.OneMinuteSecond)
	arg_5_0:refreshStoreContent()
	arg_5_0:scrollToFirstNoSellOutStore()
	arg_5_0:refreshCurrency()
end

function var_0_0.refreshCurrency(arg_6_0)
	local var_6_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a1DouQuQu)

	arg_6_0._txtCoin.text = var_6_0.quantity
end

function var_0_0.refreshTime(arg_7_0)
	local var_7_0 = ActivityModel.instance:getActivityInfo()[arg_7_0.actId]:getRemainTimeStr3(false, false)

	arg_7_0._txttime.text = var_7_0
end

function var_0_0.refreshStoreContent(arg_8_0)
	local var_8_0 = arg_8_0.actId and ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_8_0.actId)

	if not var_8_0 then
		return
	end

	local var_8_1

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = arg_8_0.storeItemList[iter_8_0]

		if not var_8_2 then
			local var_8_3 = gohelper.cloneInPlace(arg_8_0._gostoreItem)

			var_8_2 = Act191StoreItem.New()

			var_8_2:onInitView(var_8_3)
			table.insert(arg_8_0.storeItemList, var_8_2)
		end

		var_8_2:updateInfo(iter_8_0, var_8_0[iter_8_0])
	end
end

function var_0_0.scrollToFirstNoSellOutStore(arg_9_0)
	local var_9_0 = arg_9_0:getFirstNoSellOutGroup()

	if var_9_0 <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_9_0.rectTrContent)

	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.storeItemList) do
		if var_9_0 <= iter_9_0 then
			break
		end

		var_9_1 = var_9_1 + iter_9_1:getHeight()
	end

	local var_9_2 = gohelper.findChildComponent(arg_9_0.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local var_9_3 = recthelper.getHeight(var_9_2)
	local var_9_4 = recthelper.getHeight(arg_9_0.rectTrContent) - var_9_3

	recthelper.setAnchorY(arg_9_0.rectTrContent, math.min(var_9_1, var_9_4))
end

function var_0_0.getFirstNoSellOutGroup(arg_10_0)
	local var_10_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_10_0.actId)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			if iter_10_3.maxBuyCount == 0 then
				return iter_10_0
			end

			if iter_10_3.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_10_0.actId, iter_10_3.id) > 0 then
				return iter_10_0
			end
		end
	end

	return 1
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshTime, arg_11_0)

	local var_11_0 = arg_11_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_11_0.viewName, var_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.storeItemList) do
		iter_12_1:onDestroy()
	end
end

return var_0_0
