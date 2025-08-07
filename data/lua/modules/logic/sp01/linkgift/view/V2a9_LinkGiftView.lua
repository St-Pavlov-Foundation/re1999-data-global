module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftView", package.seeall)

local var_0_0 = class("V2a9_LinkGiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_time/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._linkGiftItemList = {}

	for iter_5_0 = 1, 2 do
		local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "root/gift" .. iter_5_0)
		local var_5_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_0, V2a9_LinkGiftItem, arg_5_0)

		table.insert(arg_5_0._linkGiftItemList, var_5_1)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_7_0._onRefreshEvent, arg_7_0)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_7_0._onRefreshEvent, arg_7_0)

	arg_7_0._poolId = arg_7_0.viewParam and arg_7_0.viewParam.poolId
	arg_7_0._goodsCdfList = {}

	tabletool.addValues(arg_7_0._goodsCdfList, StoreConfig.instance:getCharageGoodsCfgListByPoolId(arg_7_0._poolId))
	table.sort(arg_7_0._goodsCdfList, var_0_0._sortGoodsCfgList)
	arg_7_0:_refreshUI()
	arg_7_0:_refreshOpenTime()
	TaskDispatcher.runRepeat(arg_7_0.repeatCallCountdown, arg_7_0, 10)
	StoreGoodsTaskController.instance:autoFinishTaskByPoolId(arg_7_0._poolId)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.repeatCallCountdown, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onTopRefreshUI, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._linkGiftItemList) do
		iter_9_1:onDestroy()
	end
end

function var_0_0._onRefreshEvent(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onTopRefreshUI, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._onTopRefreshUI, arg_10_0, 0.2)
end

function var_0_0._onTopRefreshUI(arg_11_0, arg_11_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_11_0.viewName) then
		arg_11_0:_refreshUI()
	end
end

function var_0_0._refreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._linkGiftItemList) do
		iter_12_1:onUpdateMO(arg_12_0._goodsCdfList[iter_12_0])
	end
end

function var_0_0.repeatCallCountdown(arg_13_0)
	arg_13_0:_refreshOpenTime()
end

function var_0_0._refreshOpenTime(arg_14_0)
	local var_14_0 = SummonMainModel.instance:getPoolServerMO(arg_14_0._poolId)

	if var_14_0 ~= nil and var_14_0.offlineTime ~= 0 and var_14_0.offlineTime < TimeUtil.maxDateTimeStamp then
		local var_14_1 = var_14_0.offlineTime - ServerTime.now()

		arg_14_0._txttime.text = SummonModel.formatRemainTime(var_14_1)
	else
		arg_14_0._txttime.text = ""
	end
end

function var_0_0._sortGoodsCfgList(arg_15_0, arg_15_1)
	if arg_15_0.price ~= arg_15_1.price then
		return arg_15_0.price < arg_15_1.price
	end

	if arg_15_0.id ~= arg_15_1.id then
		return arg_15_0.id < arg_15_1.id
	end
end

return var_0_0
