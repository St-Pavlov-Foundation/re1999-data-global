module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsView", package.seeall)

local var_0_0 = class("SportsNewsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._scrolltablist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tablist")
	arg_1_0._simagepaperbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_paperbg")
	arg_1_0._simageTitleName = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_TitleName")
	arg_1_0._itemList = gohelper.findChild(arg_1_0.viewGO, "List")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Reward/#btn_Reward")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "Reward/#go_redpoint")
	arg_1_0._gotabitemcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tablist/Viewport/content")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#simage_TitleName/#txt_time")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0._btnRewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnReward:RemoveClickListener()
end

function var_0_0._btnRewardOnClick(arg_4_0)
	local var_4_0 = ActivityWarmUpModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.SportsNewsTaskView, {
		actId = var_4_0,
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

var_0_0.OrderMaxPos = 4

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._pageTabs = arg_5_0:getUserDataTb_()
	arg_5_0._newsItems = arg_5_0:getUserDataTb_()
	arg_5_0._newsPos = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, var_0_0.OrderMaxPos do
		arg_5_0._newsPos[iter_5_0] = gohelper.findChild(arg_5_0._itemList, iter_5_0)
	end
end

function var_0_0.onDestroyView(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._newsItems) do
		iter_6_1:onDestroyView()
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._pageTabs) do
		iter_6_3:onDestroyView()
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId

	arg_7_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, arg_7_0.onInfosReply, arg_7_0)
	ActivityWarmUpController.instance:init(arg_7_0.actId)

	arg_7_0.jumpTab = SportsNewsModel.instance:getJumpToTab(arg_7_0.actId)

	if arg_7_0.jumpTab then
		ActivityWarmUpController.instance:switchTab(arg_7_0.jumpTab)
	end

	Activity106Rpc.instance:sendGet106InfosRequest(arg_7_0.actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)
	RedDotController.instance:addRedDot(arg_7_0._goreddot, RedDotEnum.DotNode.v1a5NewsTaskBonus)
	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime, arg_7_0, 1)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, arg_8_0.onInfosReply, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.refreshRemainTime, arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshAllTabBtns()
	arg_9_0:refreshAllOrder()
	arg_9_0:refreshRemainTime()
end

function var_0_0.onInfosReply(arg_10_0)
	if arg_10_0.jumpTab then
		return
	end

	local var_10_0 = SportsNewsModel.instance:hasCanFinishOrder()
	local var_10_1 = ActivityWarmUpModel.instance:getSelectedDay()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		var_10_1 = Mathf.Min(iter_10_0, var_10_1)
	end

	ActivityWarmUpController.instance:switchTab(var_10_1)
end

function var_0_0.refreshAllTabBtns(arg_11_0)
	local var_11_0 = ActivityWarmUpModel.instance:getTotalContentDays()
	local var_11_1 = ActivityWarmUpModel.instance:getCurrentDay()

	for iter_11_0 = 1, var_11_0 do
		arg_11_0:refreshTabBtn(iter_11_0)
	end

	arg_11_0:dayTabRedDot()
end

function var_0_0.refreshTabBtn(arg_12_0, arg_12_1)
	arg_12_0:getOrCreateTabItem(arg_12_1):onRefresh()
end

function var_0_0.refreshRemainTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActivityInfo()[arg_13_0.actId]

	if var_13_0 then
		local var_13_1 = var_13_0:getRemainTimeStr2ByEndTime()

		arg_13_0._txttime.text = string.format(luaLang("remain"), var_13_1)
	end
end

function var_0_0.getOrCreateTabItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._pageTabs[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()

		local var_14_1 = arg_14_0.viewContainer:getSetting().otherRes[3]
		local var_14_2 = arg_14_0:getResInst(var_14_1, arg_14_0._gotabitemcontent, "tab_item" .. tostring(arg_14_1))

		var_14_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_2, SportsNewsPageTabItem)

		var_14_0:initData(arg_14_1, var_14_2)

		arg_14_0._pageTabs[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.dayTabRedDot(arg_15_0)
	local var_15_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.v1a5NewsOrder).infos
	local var_15_1 = {}

	if var_15_0 then
		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			local var_15_2 = iter_15_1.uid
			local var_15_3 = SportsNewsModel.instance:getDayByOrderId(arg_15_0.actId, var_15_2)

			if not var_15_1[var_15_3] and var_15_3 then
				var_15_1[var_15_3] = {
					id = var_15_2
				}
			end
		end
	end

	local var_15_4 = ActivityWarmUpModel.instance:getTotalContentDays()

	for iter_15_2 = 1, var_15_4 do
		local var_15_5 = var_15_1[iter_15_2] and var_15_1[iter_15_2].id

		arg_15_0:getOrCreateTabItem(iter_15_2):enableRedDot(var_15_5, RedDotEnum.DotNode.v1a5NewsOrder, var_15_5)
	end
end

function var_0_0.refreshAllOrder(arg_16_0)
	local var_16_0 = ActivityWarmUpModel.instance:getSelectedDayOrders()

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			arg_16_0:refreshOrder(iter_16_0, iter_16_1)
		end
	end
end

function var_0_0.refreshOrder(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:getOrCreateOrderItem(arg_17_1):onRefresh(arg_17_2)
end

function var_0_0.getOrCreateOrderItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._newsItems[arg_18_1]

	if not var_18_0 then
		local var_18_1 = arg_18_0._newsPos[arg_18_1]

		if not var_18_1 then
			return
		end

		local var_18_2 = arg_18_1 > 1 and 2 or 1
		local var_18_3 = arg_18_0.viewContainer:getSetting().otherRes[var_18_2]
		local var_18_4 = arg_18_0:getResInst(var_18_3, var_18_1, "news_" .. tostring(arg_18_1))

		if var_18_2 == 1 then
			var_18_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_4, SportsNewsMainReadItem)
		else
			var_18_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_4, SportsNewsMainTaskItem)
		end

		var_18_0:initData(var_18_4, arg_18_1)

		arg_18_0._newsItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

return var_0_0
