module("modules.logic.versionactivity1_9.enter.view.VersionActivityEnterBaseViewWithList1_9", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseViewWithList1_9", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goActivityItem1 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	arg_1_0._goActivityItem2 = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	arg_1_0._goActivityLine = gohelper.findChild(arg_1_0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goActivityItem1, false)
	gohelper.setActive(arg_4_0._goActivityItem2, false)
	gohelper.setActive(arg_4_0._goActivityLine, false)

	arg_4_0.activityTabItemList = {}
	arg_4_0.activityTabItemDict = {}
	arg_4_0.openActIdList = {}
	arg_4_0.noOpenActList = {}
	arg_4_0.removeActList = {}
	arg_4_0.actLevel2GoItem = arg_4_0:getUserDataTb_()
	arg_4_0.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.First] = arg_4_0._goActivityItem1
	arg_4_0.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.Second] = arg_4_0._goActivityItem2
	arg_4_0.actLevel2Cls = {
		[VersionActivity1_9Enum.ActLevel.First] = VersionActivity1_9EnterViewTabItem1,
		[VersionActivity1_9Enum.ActLevel.Second] = VersionActivity1_9EnterViewTabItem2
	}

	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.onRefreshActivity, arg_4_0)
	arg_4_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_4_0.onSelectActId, arg_4_0)

	arg_4_0.defaultTabIndex = 1
	arg_4_0.curTabIndex = -1
	arg_4_0.curActId = 0
end

function var_0_0.onRefreshActivity(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.curStoreId or arg_5_0.curActId
	local var_5_1 = ActivityHelper.getActivityStatus(var_5_0)

	if var_5_1 == ActivityEnum.ActivityStatus.NotOnLine or var_5_1 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activityIdList) do
		if arg_5_0:checkCanRemove(iter_5_1) then
			arg_5_0:removeActItem(iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.activityTabItemList) do
		local var_5_2 = iter_5_3.actId

		if iter_5_3:updateActId() then
			arg_5_0.activityTabItemDict[iter_5_3.actId] = iter_5_3

			if iter_5_3.actId and var_5_2 then
				iter_5_3:refreshData()
			end
		end
	end

	arg_5_0:refreshItemSiblingAndActive()
end

function var_0_0.onSelectActId(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.curActId == arg_6_1 then
		return
	end

	arg_6_0.curActId = arg_6_1
	arg_6_0.curStoreId = arg_6_2 and arg_6_2.storeId

	local var_6_0 = VersionActivityEnterHelper.getTabIndex(arg_6_0.activityIdList, arg_6_1)

	arg_6_0.viewContainer:selectActTab(var_6_0, arg_6_0.curActId)
	ActivityEnterMgr.instance:enterActivity(arg_6_0.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_6_0.curActId
	})
end

function var_0_0.initViewParam(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId
	arg_7_0.skipOpenAnim = arg_7_0.viewParam.skipOpenAnim
	arg_7_0.activityIdList = arg_7_0.viewParam.activityIdList
	arg_7_0.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(arg_7_0.activityIdList, arg_7_0.viewParam.jumpActId)

	local var_7_0 = arg_7_0.activityIdList[arg_7_0.defaultTabIndex]

	arg_7_0.curActId = VersionActivityEnterHelper.getActId(var_7_0)
	arg_7_0.curStoreId = var_7_0 and var_7_0.storeId
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:initActivityItemList()
	arg_8_0:refreshUI()
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:initViewParam()
	arg_9_0:refreshUI()
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.activityTabItemList) do
		iter_10_1:dispose()
	end

	arg_10_0.activityTabItemList = nil
	arg_10_0.activityTabItemDict = nil
end

function var_0_0.initActivityItemList(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.activityIdList) do
		if not arg_11_0:checkCanRemove(iter_11_1) then
			local var_11_0 = VersionActivityEnterHelper.getActId(iter_11_1)
			local var_11_1 = arg_11_0.actLevel2GoItem[iter_11_1.actLevel]
			local var_11_2 = arg_11_0.actLevel2Cls[iter_11_1.actLevel]
			local var_11_3 = gohelper.cloneInPlace(var_11_1, var_11_0)
			local var_11_4 = var_11_2.New()

			var_11_4:init(iter_11_0, iter_11_1, var_11_3)
			var_11_4:refreshSelect(arg_11_0.curActId)

			local var_11_5 = arg_11_0["onClickActivity" .. var_11_0]

			if var_11_5 then
				var_11_4:overrideOnClickHandle(var_11_5, arg_11_0)
			end

			table.insert(arg_11_0.activityTabItemList, var_11_4)

			arg_11_0.activityTabItemDict[var_11_0] = var_11_4
		end
	end
end

function var_0_0.refreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.activityTabItemList) do
		iter_12_1:refreshUI()
	end

	arg_12_0:refreshItemSiblingAndActive()
end

function var_0_0.refreshItemSiblingAndActive(arg_13_0)
	tabletool.clear(arg_13_0.openActIdList)
	tabletool.clear(arg_13_0.noOpenActList)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activityTabItemList) do
		if ActivityHelper.getActivityStatus(iter_13_1.actId) == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(arg_13_0.noOpenActList, iter_13_1.actId)
		else
			table.insert(arg_13_0.openActIdList, iter_13_1.actId)
		end
	end

	table.sort(arg_13_0.openActIdList, arg_13_0.openActItemSortFunc)

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.openActIdList) do
		local var_13_0 = arg_13_0.activityTabItemDict[iter_13_3]

		gohelper.setSibling(var_13_0.rootGo, iter_13_2)
	end

	if #arg_13_0.noOpenActList < 1 then
		gohelper.setActive(arg_13_0._goActivityLine, false)

		return
	end

	gohelper.setActive(arg_13_0._goActivityLine, true)

	local var_13_1 = #arg_13_0.openActIdList

	gohelper.setSibling(arg_13_0._goActivityLine, var_13_1 + 1)
	table.sort(arg_13_0.noOpenActList, arg_13_0.noOpenActItemSortFunc)

	for iter_13_4, iter_13_5 in ipairs(arg_13_0.noOpenActList) do
		local var_13_2 = arg_13_0.activityTabItemDict[iter_13_5]

		gohelper.setSibling(var_13_2.rootGo, var_13_1 + 1 + iter_13_4)
	end
end

function var_0_0.removeActItem(arg_14_0, arg_14_1)
	for iter_14_0 = #arg_14_0.activityTabItemList, 1, -1 do
		local var_14_0 = arg_14_0.activityTabItemList[iter_14_0]

		if VersionActivityEnterHelper.checkIsSameAct(arg_14_1, var_14_0.actId) then
			table.remove(arg_14_0.activityTabItemList, iter_14_0)

			arg_14_0.activityTabItemDict[var_14_0.actId] = nil

			local var_14_1 = var_14_0.rootGo

			var_14_0:dispose()
			gohelper.destroy(var_14_1)
		end
	end
end

function var_0_0.checkCanRemove(arg_15_0, arg_15_1)
	if arg_15_1.actType == VersionActivity1_9Enum.ActType.Single then
		local var_15_0 = arg_15_1.storeId and ActivityHelper.getActivityStatus(arg_15_1.storeId) or ActivityHelper.getActivityStatus(arg_15_1.actId)

		return var_15_0 == ActivityEnum.ActivityStatus.Expired or var_15_0 == ActivityEnum.ActivityStatus.NotOnLine
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_1.actId) do
		local var_15_1 = ActivityHelper.getActivityStatus(iter_15_1)

		if var_15_1 ~= ActivityEnum.ActivityStatus.Expired and var_15_1 ~= ActivityEnum.ActivityStatus.NotOnLine then
			return false
		end
	end

	return true
end

function var_0_0.openActItemSortFunc(arg_16_0, arg_16_1)
	local var_16_0 = ActivityModel.instance:getActMO(arg_16_0)
	local var_16_1 = ActivityModel.instance:getActMO(arg_16_1)
	local var_16_2 = var_16_0.config.displayPriority
	local var_16_3 = var_16_1.config.displayPriority

	if var_16_2 ~= var_16_3 then
		return var_16_2 < var_16_3
	end

	local var_16_4 = var_16_0:getRealStartTimeStamp()
	local var_16_5 = var_16_1:getRealStartTimeStamp()

	if var_16_4 ~= var_16_5 then
		return var_16_5 < var_16_4
	end

	return arg_16_0 < arg_16_1
end

function var_0_0.noOpenActItemSortFunc(arg_17_0, arg_17_1)
	local var_17_0 = ActivityModel.instance:getActMO(arg_17_0)
	local var_17_1 = ActivityModel.instance:getActMO(arg_17_1)
	local var_17_2 = var_17_0:getRealStartTimeStamp()
	local var_17_3 = var_17_1:getRealStartTimeStamp()

	if var_17_2 ~= var_17_3 then
		return var_17_2 < var_17_3
	end

	local var_17_4 = var_17_0.config.displayPriority
	local var_17_5 = var_17_1.config.displayPriority

	if var_17_4 ~= var_17_5 then
		return var_17_4 < var_17_5
	end

	return arg_17_0 < arg_17_1
end

return var_0_0
