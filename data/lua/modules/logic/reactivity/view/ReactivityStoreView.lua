module("modules.logic.reactivity.view.ReactivityStoreView", package.seeall)

local var_0_0 = class("ReactivityStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/timebg/#txt_time")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Exchange")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollstore:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)

	if arg_2_0._btnExchange then
		arg_2_0:addClickCb(arg_2_0._btnExchange, arg_2_0._onClickExchange, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollstore:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.rectTrContent = arg_4_0._goContent:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.storeItemList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onScrollValueChanged(arg_6_0)
	if #arg_6_0.storeItemList > 0 then
		local var_6_0 = arg_6_0.storeItemList[1]

		if var_6_0 then
			var_6_0:refreshTagClip(arg_6_0._scrollstore)
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(arg_7_0.refreshTime, arg_7_0, TimeUtil.OneMinuteSecond)

	arg_7_0.actId = arg_7_0.viewParam.actId

	arg_7_0:refreshTime()
	arg_7_0:refreshStoreContent()
	arg_7_0:_onScrollValueChanged()
	arg_7_0:scrollToFirstNoSellOutStore()
end

function var_0_0.refreshStoreContent(arg_8_0)
	local var_8_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_8_0.actId)
	local var_8_1

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = arg_8_0.storeItemList[iter_8_0]

		if not var_8_2 then
			var_8_2 = ReactivityStoreItem.New()

			var_8_2:onInitView(gohelper.cloneInPlace(arg_8_0._gostoreItem))
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

			local var_10_1 = ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_10_0.actId, iter_10_3.id)

			if iter_10_3.maxBuyCount - var_10_1 > 0 then
				return iter_10_0
			end
		end
	end

	return 1
end

function var_0_0.refreshTime(arg_11_0)
	local var_11_0 = ActivityModel.instance:getActMO(arg_11_0.actId):getRealEndTimeStamp() - ServerTime.now()

	if var_11_0 > 0 then
		local var_11_1 = TimeUtil.SecondToActivityTimeFormat(var_11_0)

		arg_11_0._txttime.text = var_11_1
	else
		arg_11_0._txttime.text = luaLang("ended")
	end
end

function var_0_0._onClickExchange(arg_12_0)
	ViewMgr.instance:openView(ViewName.ReactivityRuleView)
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.refreshTime, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.storeItemList) do
		iter_14_1:onDestroy()
	end
end

return var_0_0
