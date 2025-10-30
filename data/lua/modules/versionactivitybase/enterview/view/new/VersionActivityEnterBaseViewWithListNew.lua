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
	arg_2_0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.DragOpenAct, arg_2_0.onDragOpenAct, arg_2_0)
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

function var_0_0.onDragOpenAct(arg_6_0, arg_6_1)
	local var_6_0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.activityTabItemList) do
		if iter_6_1.isSelect then
			var_6_0 = gohelper.getSibling(iter_6_1.go)

			break
		end
	end

	if not var_6_0 then
		return
	end

	local var_6_1
	local var_6_2

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.activityTabItemList) do
		if not iter_6_3.isSelect then
			local var_6_3 = gohelper.getSibling(iter_6_3.go)

			if arg_6_1 then
				if var_6_0 < var_6_3 and (not var_6_1 or var_6_3 < var_6_1) then
					var_6_1 = var_6_3
					var_6_2 = iter_6_3
				end
			elseif var_6_3 < var_6_0 and (not var_6_1 or var_6_1 < var_6_3) then
				var_6_1 = var_6_3
				var_6_2 = iter_6_3
			end
		end
	end

	if var_6_2 then
		var_6_2:onClick()
		arg_6_0:moveContent(var_6_2)
	end
end

function var_0_0.moveContent(arg_7_0, arg_7_1)
	return
end

function var_0_0.removeActItem(arg_8_0, arg_8_1)
	for iter_8_0 = #arg_8_0.activityTabItemList, 1, -1 do
		local var_8_0 = arg_8_0.activityTabItemList[iter_8_0]

		if VersionActivityEnterHelper.checkIsSameAct(arg_8_1, var_8_0.actId) then
			table.remove(arg_8_0.activityTabItemList, iter_8_0)

			arg_8_0.activityTabItemDict[var_8_0.actId] = nil

			local var_8_1 = var_8_0.go

			var_8_0:dispose()
			gohelper.destroy(var_8_1)
		end
	end
end

function var_0_0.childAddEvents(arg_9_0)
	logError("override VersionActivityEnterBaseViewWithListNew:childAddEvents")
end

function var_0_0.childRemoveEvents(arg_10_0)
	logError("override VersionActivityEnterBaseViewWithListNew:childRemoveEvents")
end

function var_0_0.playVideo(arg_11_0)
	return
end

function var_0_0.refreshRedDot(arg_12_0)
	return
end

function var_0_0.refreshBtnVisible(arg_13_0, arg_13_1)
	logError("override VersionActivityEnterBaseViewWithListNew:refreshBtnVisible")
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0:initViewParam()
	arg_14_0:refreshUI()

	local var_14_0 = arg_14_0.activityTabItemDict[arg_14_0.curActId]

	if var_14_0 then
		arg_14_0.curActId = nil

		var_14_0:onClick()
	end
end

function var_0_0.onOpen(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.tabLevelSetting) do
		local var_15_0 = iter_15_1.go

		gohelper.setActive(var_15_0, false)
	end

	gohelper.setActive(arg_15_0._goActivityLine, false)
	arg_15_0:initViewParam()
	arg_15_0:createActivityTabItem()
	arg_15_0:playVideo()
	arg_15_0:refreshUI()
	arg_15_0:refreshRedDot()
	arg_15_0:refreshBtnVisible(true)
end

function var_0_0.initViewParam(arg_16_0)
	arg_16_0.actId = arg_16_0.viewParam.actId
	arg_16_0.skipOpenAnim = arg_16_0.viewParam.skipOpenAnim
	arg_16_0.activitySettingList = arg_16_0.viewParam.activitySettingList
	arg_16_0.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(arg_16_0.activitySettingList, arg_16_0.viewParam.jumpActId)

	local var_16_0 = arg_16_0.activitySettingList[arg_16_0.defaultTabIndex]

	arg_16_0.curActId = VersionActivityEnterHelper.getActId(var_16_0)
	arg_16_0.curStoreId = var_16_0 and var_16_0.storeId
end

function var_0_0.setTabLevelSetting(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if gohelper.isNil(arg_17_2) or not arg_17_1 or not arg_17_3 then
		return
	end

	if not arg_17_0.tabLevelSetting then
		arg_17_0.tabLevelSetting = {}
	end

	arg_17_0.tabLevelSetting[arg_17_1] = arg_17_0:getUserDataTb_()
	arg_17_0.tabLevelSetting[arg_17_1].go = arg_17_2
	arg_17_0.tabLevelSetting[arg_17_1].cls = arg_17_3
end

function var_0_0.setActivityLineGo(arg_18_0, arg_18_1)
	if gohelper.isNil(arg_18_1) then
		return
	end

	arg_18_0._goActivityLine = arg_18_1
end

function var_0_0.getItemGoAndCls(arg_19_0, arg_19_1)
	if not arg_19_1 then
		logError("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, level is nil")

		return
	end

	local var_19_0 = arg_19_0.tabLevelSetting and arg_19_0.tabLevelSetting[arg_19_1]

	if not var_19_0 then
		logError(string.format("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, no tabSetting, level:%s", arg_19_1))

		return
	end

	return var_19_0.go, var_19_0.cls
end

function var_0_0.createActivityTabItem(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.activitySettingList) do
		if not VersionActivityEnterHelper.isActTabCanRemove(iter_20_1) then
			local var_20_0 = VersionActivityEnterHelper.getActId(iter_20_1)
			local var_20_1, var_20_2 = arg_20_0:getItemGoAndCls(iter_20_1.actLevel)

			if var_20_1 and var_20_2 then
				local var_20_3 = gohelper.cloneInPlace(var_20_1, var_20_0)
				local var_20_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_20_3, var_20_2)

				var_20_4:setData(iter_20_0, iter_20_1)
				var_20_4:refreshSelect(arg_20_0.curActId)

				local var_20_5 = arg_20_0["onClickActivity" .. var_20_0]

				if var_20_5 then
					var_20_4:setClickFunc(var_20_5, arg_20_0)
				end

				arg_20_0.activityTabItemDict[var_20_0] = var_20_4

				table.insert(arg_20_0.activityTabItemList, var_20_4)
			end
		end
	end
end

function var_0_0.refreshUI(arg_21_0)
	arg_21_0:sortTabItemList()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.activityTabItemList) do
		iter_21_1:refreshUI()
	end
end

local function var_0_1(arg_22_0, arg_22_1)
	local var_22_0 = ActivityModel.instance:getActMO(arg_22_0)
	local var_22_1 = ActivityModel.instance:getActMO(arg_22_1)
	local var_22_2 = var_22_0 and var_22_0.config.displayPriority or 0
	local var_22_3 = var_22_1 and var_22_1.config.displayPriority or 0

	if var_22_2 ~= var_22_3 then
		return var_22_2 < var_22_3
	end

	local var_22_4 = var_22_0 and var_22_0:getRealStartTimeStamp() or 0
	local var_22_5 = var_22_1 and var_22_1:getRealStartTimeStamp() or 0

	if var_22_4 ~= var_22_5 then
		return var_22_5 < var_22_4
	end

	return arg_22_0 < arg_22_1
end

local function var_0_2(arg_23_0, arg_23_1)
	local var_23_0 = ActivityModel.instance:getActMO(arg_23_0)
	local var_23_1 = ActivityModel.instance:getActMO(arg_23_1)
	local var_23_2 = var_23_0:getRealStartTimeStamp()
	local var_23_3 = var_23_1:getRealStartTimeStamp()

	if var_23_2 ~= var_23_3 then
		return var_23_2 < var_23_3
	end

	local var_23_4 = var_23_0.config.displayPriority
	local var_23_5 = var_23_1.config.displayPriority

	if var_23_4 ~= var_23_5 then
		return var_23_4 < var_23_5
	end

	return arg_23_0 < arg_23_1
end

function var_0_0.sortTabItemList(arg_24_0)
	tabletool.clear(arg_24_0.openActIdList)
	tabletool.clear(arg_24_0.noOpenActList)

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.activityTabItemList) do
		if ActivityHelper.getActivityStatus(iter_24_1.actId) == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(arg_24_0.noOpenActList, iter_24_1.actId)
		else
			table.insert(arg_24_0.openActIdList, iter_24_1.actId)
		end
	end

	table.sort(arg_24_0.openActIdList, var_0_1)

	for iter_24_2, iter_24_3 in ipairs(arg_24_0.openActIdList) do
		local var_24_0 = arg_24_0.activityTabItemDict[iter_24_3]

		gohelper.setSibling(var_24_0.go, iter_24_2)
	end

	if #arg_24_0.noOpenActList < 1 then
		gohelper.setActive(arg_24_0._goActivityLine, false)

		return
	end

	gohelper.setActive(arg_24_0._goActivityLine, true)

	local var_24_1 = #arg_24_0.openActIdList

	gohelper.setSibling(arg_24_0._goActivityLine, var_24_1 + 1)
	table.sort(arg_24_0.noOpenActList, var_0_2)

	for iter_24_4, iter_24_5 in ipairs(arg_24_0.noOpenActList) do
		local var_24_2 = arg_24_0.activityTabItemDict[iter_24_5]

		gohelper.setSibling(var_24_2.go, var_24_1 + 1 + iter_24_4)
	end
end

function var_0_0.onDestroyView(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.activityTabItemList) do
		iter_25_1:dispose()
	end

	arg_25_0.activityTabItemList = nil
	arg_25_0.activityTabItemDict = nil
end

return var_0_0
