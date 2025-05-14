module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterBaseViewWithListNew", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseViewWithListNew", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.tabLevelSetting = {}
	arg_1_0.activityTabItemList = {}
	arg_1_0.activityTabItemDict = {}
	arg_1_0.openActIdList = {}
	arg_1_0.noOpenActList = {}
	arg_1_0.curActId = 0
	arg_1_0.defaultTabIndex = 1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	arg_2_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, arg_2_0.onSelectActId, arg_2_0)
	arg_2_0:childAddEvents()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:childRemoveEvents()
end

function var_0_0.onRefreshActivity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.curStoreId or arg_4_0.curActId
	local var_4_1 = ActivityHelper.getActivityStatus(var_4_0)

	if var_4_1 == ActivityEnum.ActivityStatus.NotOnLine or var_4_1 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.activitySettingList) do
		if VersionActivityEnterHelper.isActTabCanRemove(iter_4_1) then
			arg_4_0:removeActItem(iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.activityTabItemList) do
		if iter_4_3:updateActId() then
			arg_4_0.activityTabItemDict[iter_4_3.actId] = iter_4_3
		end
	end

	arg_4_0:sortTabItemList()
end

function var_0_0.onSelectActId(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.curActId == arg_5_1 then
		return
	end

	arg_5_0.curActId = arg_5_1
	arg_5_0.curStoreId = arg_5_2 and arg_5_2.storeId

	local var_5_0 = VersionActivityEnterHelper.getTabIndex(arg_5_0.activitySettingList, arg_5_1)

	arg_5_0.viewContainer:selectActTab(var_5_0, arg_5_0.curActId)
	ActivityEnterMgr.instance:enterActivity(arg_5_0.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_5_0.curActId
	})
	arg_5_0:refreshBtnVisible()
end

function var_0_0.removeActItem(arg_6_0, arg_6_1)
	for iter_6_0 = #arg_6_0.activityTabItemList, 1, -1 do
		local var_6_0 = arg_6_0.activityTabItemList[iter_6_0]

		if VersionActivityEnterHelper.checkIsSameAct(arg_6_1, var_6_0.actId) then
			table.remove(arg_6_0.activityTabItemList, iter_6_0)

			arg_6_0.activityTabItemDict[var_6_0.actId] = nil

			local var_6_1 = var_6_0.go

			var_6_0:dispose()
			gohelper.destroy(var_6_1)
		end
	end
end

function var_0_0.childAddEvents(arg_7_0)
	logError("override VersionActivityEnterBaseViewWithListNew:childAddEvents")
end

function var_0_0.childRemoveEvents(arg_8_0)
	logError("override VersionActivityEnterBaseViewWithListNew:childRemoveEvents")
end

function var_0_0.playVideo(arg_9_0)
	return
end

function var_0_0.refreshRedDot(arg_10_0)
	return
end

function var_0_0.refreshBtnVisible(arg_11_0, arg_11_1)
	logError("override VersionActivityEnterBaseViewWithListNew:refreshBtnVisible")
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:initViewParam()
	arg_12_0:refreshUI()

	local var_12_0 = arg_12_0.activityTabItemDict[arg_12_0.curActId]

	if var_12_0 then
		arg_12_0.curActId = nil

		var_12_0:onClick()
	end
end

function var_0_0.onOpen(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.tabLevelSetting) do
		local var_13_0 = iter_13_1.go

		gohelper.setActive(var_13_0, false)
	end

	gohelper.setActive(arg_13_0._goActivityLine, false)
	arg_13_0:initViewParam()
	arg_13_0:createActivityTabItem()
	arg_13_0:playVideo()
	arg_13_0:refreshUI()
	arg_13_0:refreshRedDot()
	arg_13_0:refreshBtnVisible(true)
end

function var_0_0.initViewParam(arg_14_0)
	arg_14_0.actId = arg_14_0.viewParam.actId
	arg_14_0.skipOpenAnim = arg_14_0.viewParam.skipOpenAnim
	arg_14_0.activitySettingList = arg_14_0.viewParam.activitySettingList
	arg_14_0.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(arg_14_0.activitySettingList, arg_14_0.viewParam.jumpActId)

	local var_14_0 = arg_14_0.activitySettingList[arg_14_0.defaultTabIndex]

	arg_14_0.curActId = VersionActivityEnterHelper.getActId(var_14_0)
	arg_14_0.curStoreId = var_14_0 and var_14_0.storeId
end

function var_0_0.setTabLevelSetting(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if gohelper.isNil(arg_15_2) or not arg_15_1 or not arg_15_3 then
		return
	end

	if not arg_15_0.tabLevelSetting then
		arg_15_0.tabLevelSetting = {}
	end

	arg_15_0.tabLevelSetting[arg_15_1] = arg_15_0:getUserDataTb_()
	arg_15_0.tabLevelSetting[arg_15_1].go = arg_15_2
	arg_15_0.tabLevelSetting[arg_15_1].cls = arg_15_3
end

function var_0_0.setActivityLineGo(arg_16_0, arg_16_1)
	if gohelper.isNil(arg_16_1) then
		return
	end

	arg_16_0._goActivityLine = arg_16_1
end

function var_0_0.getItemGoAndCls(arg_17_0, arg_17_1)
	if not arg_17_1 then
		logError("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, level is nil")

		return
	end

	local var_17_0 = arg_17_0.tabLevelSetting and arg_17_0.tabLevelSetting[arg_17_1]

	if not var_17_0 then
		logError(string.format("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, no tabSetting, level:%s", arg_17_1))

		return
	end

	return var_17_0.go, var_17_0.cls
end

function var_0_0.createActivityTabItem(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.activitySettingList) do
		if not VersionActivityEnterHelper.isActTabCanRemove(iter_18_1) then
			local var_18_0 = VersionActivityEnterHelper.getActId(iter_18_1)
			local var_18_1, var_18_2 = arg_18_0:getItemGoAndCls(iter_18_1.actLevel)

			if var_18_1 and var_18_2 then
				local var_18_3 = gohelper.cloneInPlace(var_18_1, var_18_0)
				local var_18_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_3, var_18_2)

				var_18_4:setData(iter_18_0, iter_18_1)
				var_18_4:refreshSelect(arg_18_0.curActId)

				local var_18_5 = arg_18_0["onClickActivity" .. var_18_0]

				if var_18_5 then
					var_18_4:setClickFunc(var_18_5, arg_18_0)
				end

				arg_18_0.activityTabItemDict[var_18_0] = var_18_4

				table.insert(arg_18_0.activityTabItemList, var_18_4)
			end
		end
	end
end

function var_0_0.refreshUI(arg_19_0)
	arg_19_0:sortTabItemList()

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.activityTabItemList) do
		iter_19_1:refreshUI()
	end
end

local function var_0_1(arg_20_0, arg_20_1)
	local var_20_0 = ActivityModel.instance:getActMO(arg_20_0)
	local var_20_1 = ActivityModel.instance:getActMO(arg_20_1)
	local var_20_2 = var_20_0 and var_20_0.config.displayPriority or 0
	local var_20_3 = var_20_1 and var_20_1.config.displayPriority or 0

	if var_20_2 ~= var_20_3 then
		return var_20_2 < var_20_3
	end

	local var_20_4 = var_20_0 and var_20_0:getRealStartTimeStamp() or 0
	local var_20_5 = var_20_1 and var_20_1:getRealStartTimeStamp() or 0

	if var_20_4 ~= var_20_5 then
		return var_20_5 < var_20_4
	end

	return arg_20_0 < arg_20_1
end

local function var_0_2(arg_21_0, arg_21_1)
	local var_21_0 = ActivityModel.instance:getActMO(arg_21_0)
	local var_21_1 = ActivityModel.instance:getActMO(arg_21_1)
	local var_21_2 = var_21_0:getRealStartTimeStamp()
	local var_21_3 = var_21_1:getRealStartTimeStamp()

	if var_21_2 ~= var_21_3 then
		return var_21_2 < var_21_3
	end

	local var_21_4 = var_21_0.config.displayPriority
	local var_21_5 = var_21_1.config.displayPriority

	if var_21_4 ~= var_21_5 then
		return var_21_4 < var_21_5
	end

	return arg_21_0 < arg_21_1
end

function var_0_0.sortTabItemList(arg_22_0)
	tabletool.clear(arg_22_0.openActIdList)
	tabletool.clear(arg_22_0.noOpenActList)

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.activityTabItemList) do
		if ActivityHelper.getActivityStatus(iter_22_1.actId) == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(arg_22_0.noOpenActList, iter_22_1.actId)
		else
			table.insert(arg_22_0.openActIdList, iter_22_1.actId)
		end
	end

	table.sort(arg_22_0.openActIdList, var_0_1)

	for iter_22_2, iter_22_3 in ipairs(arg_22_0.openActIdList) do
		local var_22_0 = arg_22_0.activityTabItemDict[iter_22_3]

		gohelper.setSibling(var_22_0.go, iter_22_2)
	end

	if #arg_22_0.noOpenActList < 1 then
		gohelper.setActive(arg_22_0._goActivityLine, false)

		return
	end

	gohelper.setActive(arg_22_0._goActivityLine, true)

	local var_22_1 = #arg_22_0.openActIdList

	gohelper.setSibling(arg_22_0._goActivityLine, var_22_1 + 1)
	table.sort(arg_22_0.noOpenActList, var_0_2)

	for iter_22_4, iter_22_5 in ipairs(arg_22_0.noOpenActList) do
		local var_22_2 = arg_22_0.activityTabItemDict[iter_22_5]

		gohelper.setSibling(var_22_2.go, var_22_1 + 1 + iter_22_4)
	end
end

function var_0_0.onDestroyView(arg_23_0)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.activityTabItemList) do
		iter_23_1:dispose()
	end

	arg_23_0.activityTabItemList = nil
	arg_23_0.activityTabItemDict = nil
end

return var_0_0
