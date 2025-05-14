module("modules.logic.versionactivity2_3.act174.view.outside.Act174StoreView", package.seeall)

local var_0_0 = class("Act174StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/image_LimitTimeBG/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_3_0.closeThis, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.storeItemList = arg_4_0:getUserDataTb_()
	arg_4_0.rectTrContent = arg_4_0._goContent:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	arg_5_0:refreshTime()
	TaskDispatcher.runRepeat(arg_5_0.refreshTime, arg_5_0, TimeUtil.OneMinuteSecond)
	arg_5_0:refreshStoreContent()
	arg_5_0:scrollToFirstNoSellOutStore()
end

function var_0_0.refreshTime(arg_6_0)
	local var_6_0 = ActivityModel.instance:getActivityInfo()[arg_6_0.actId]:getRemainTimeStr3(false, false)

	arg_6_0._txttime.text = var_6_0
end

function var_0_0.refreshStoreContent(arg_7_0)
	local var_7_0 = arg_7_0.actId and ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_7_0.actId)

	if not var_7_0 then
		return
	end

	local var_7_1

	for iter_7_0 = 1, #var_7_0 do
		local var_7_2 = arg_7_0.storeItemList[iter_7_0]

		if not var_7_2 then
			local var_7_3 = gohelper.cloneInPlace(arg_7_0._gostoreItem)

			var_7_2 = Act174StoreItem.New()

			var_7_2:onInitView(var_7_3)
			table.insert(arg_7_0.storeItemList, var_7_2)
		end

		var_7_2:updateInfo(iter_7_0, var_7_0[iter_7_0])
	end
end

function var_0_0.scrollToFirstNoSellOutStore(arg_8_0)
	local var_8_0 = arg_8_0:getFirstNoSellOutGroup()

	if var_8_0 <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_8_0.rectTrContent)

	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.storeItemList) do
		if var_8_0 <= iter_8_0 then
			break
		end

		var_8_1 = var_8_1 + iter_8_1:getHeight()
	end

	local var_8_2 = gohelper.findChildComponent(arg_8_0.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local var_8_3 = recthelper.getHeight(var_8_2)
	local var_8_4 = recthelper.getHeight(arg_8_0.rectTrContent) - var_8_3

	recthelper.setAnchorY(arg_8_0.rectTrContent, math.min(var_8_1, var_8_4))
end

function var_0_0.getFirstNoSellOutGroup(arg_9_0)
	local var_9_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(arg_9_0.actId)

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			if iter_9_3.maxBuyCount == 0 then
				return iter_9_0
			end

			if iter_9_3.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_9_0.actId, iter_9_3.id) > 0 then
				return iter_9_0
			end
		end
	end

	return 1
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.storeItemList) do
		iter_11_1:onDestroy()
	end
end

return var_0_0
