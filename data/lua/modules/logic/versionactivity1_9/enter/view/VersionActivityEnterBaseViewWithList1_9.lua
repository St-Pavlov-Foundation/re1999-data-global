module("modules.logic.versionactivity1_9.enter.view.VersionActivityEnterBaseViewWithList1_9", package.seeall)

slot0 = class("VersionActivityEnterBaseViewWithList1_9", BaseView)

function slot0.onInitView(slot0)
	slot0._goActivityItem1 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem1")
	slot0._goActivityItem2 = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_tabitem2")
	slot0._goActivityLine = gohelper.findChild(slot0.viewGO, "#go_tabcontainer/#scroll_tab/Viewport/Content/#go_line")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goActivityItem1, false)
	gohelper.setActive(slot0._goActivityItem2, false)
	gohelper.setActive(slot0._goActivityLine, false)

	slot0.activityTabItemList = {}
	slot0.activityTabItemDict = {}
	slot0.openActIdList = {}
	slot0.noOpenActList = {}
	slot0.removeActList = {}
	slot0.actLevel2GoItem = slot0:getUserDataTb_()
	slot0.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.First] = slot0._goActivityItem1
	slot0.actLevel2GoItem[VersionActivity1_9Enum.ActLevel.Second] = slot0._goActivityItem2
	slot0.actLevel2Cls = {
		[VersionActivity1_9Enum.ActLevel.First] = VersionActivity1_9EnterViewTabItem1,
		[VersionActivity1_9Enum.ActLevel.Second] = VersionActivity1_9EnterViewTabItem2
	}

	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0)

	slot0.defaultTabIndex = 1
	slot0.curTabIndex = -1
	slot0.curActId = 0
end

function slot0.onRefreshActivity(slot0, slot1)
	if ActivityHelper.getActivityStatus(slot0.curStoreId or slot0.curActId) == ActivityEnum.ActivityStatus.NotOnLine or slot3 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	for slot7, slot8 in ipairs(slot0.activityIdList) do
		if slot0:checkCanRemove(slot8) then
			slot0:removeActItem(slot8)
		end
	end

	for slot7, slot8 in ipairs(slot0.activityTabItemList) do
		if slot8:updateActId() then
			slot0.activityTabItemDict[slot8.actId] = slot8

			if slot8.actId and slot8.actId then
				slot8:refreshData()
			end
		end
	end

	slot0:refreshItemSiblingAndActive()
end

function slot0.onSelectActId(slot0, slot1, slot2)
	if slot0.curActId == slot1 then
		return
	end

	slot0.curActId = slot1
	slot0.curStoreId = slot2 and slot2.storeId

	slot0.viewContainer:selectActTab(VersionActivityEnterHelper.getTabIndex(slot0.activityIdList, slot1), slot0.curActId)
	ActivityEnterMgr.instance:enterActivity(slot0.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.curActId
	})
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.skipOpenAnim = slot0.viewParam.skipOpenAnim
	slot0.activityIdList = slot0.viewParam.activityIdList
	slot0.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(slot0.activityIdList, slot0.viewParam.jumpActId)
	slot1 = slot0.activityIdList[slot0.defaultTabIndex]
	slot0.curActId = VersionActivityEnterHelper.getActId(slot1)
	slot0.curStoreId = slot1 and slot1.storeId
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:initActivityItemList()
	slot0:refreshUI()
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:refreshUI()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		slot5:dispose()
	end

	slot0.activityTabItemList = nil
	slot0.activityTabItemDict = nil
end

function slot0.initActivityItemList(slot0)
	for slot4, slot5 in ipairs(slot0.activityIdList) do
		if not slot0:checkCanRemove(slot5) then
			slot6 = VersionActivityEnterHelper.getActId(slot5)
			slot10 = slot0.actLevel2Cls[slot5.actLevel].New()

			slot10:init(slot4, slot5, gohelper.cloneInPlace(slot0.actLevel2GoItem[slot5.actLevel], slot6))
			slot10:refreshSelect(slot0.curActId)

			if slot0["onClickActivity" .. slot6] then
				slot10:overrideOnClickHandle(slot11, slot0)
			end

			table.insert(slot0.activityTabItemList, slot10)

			slot0.activityTabItemDict[slot6] = slot10
		end
	end
end

function slot0.refreshUI(slot0)
	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		slot5:refreshUI()
	end

	slot0:refreshItemSiblingAndActive()
end

function slot0.refreshItemSiblingAndActive(slot0)
	tabletool.clear(slot0.openActIdList)
	tabletool.clear(slot0.noOpenActList)

	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		if ActivityHelper.getActivityStatus(slot5.actId) == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(slot0.noOpenActList, slot5.actId)
		else
			table.insert(slot0.openActIdList, slot5.actId)
		end
	end

	table.sort(slot0.openActIdList, slot0.openActItemSortFunc)

	for slot4, slot5 in ipairs(slot0.openActIdList) do
		gohelper.setSibling(slot0.activityTabItemDict[slot5].rootGo, slot4)
	end

	if #slot0.noOpenActList < 1 then
		gohelper.setActive(slot0._goActivityLine, false)

		return
	end

	gohelper.setActive(slot0._goActivityLine, true)
	gohelper.setSibling(slot0._goActivityLine, #slot0.openActIdList + 1)
	table.sort(slot0.noOpenActList, slot0.noOpenActItemSortFunc)

	for slot5, slot6 in ipairs(slot0.noOpenActList) do
		gohelper.setSibling(slot0.activityTabItemDict[slot6].rootGo, slot1 + 1 + slot5)
	end
end

function slot0.removeActItem(slot0, slot1)
	for slot5 = #slot0.activityTabItemList, 1, -1 do
		if VersionActivityEnterHelper.checkIsSameAct(slot1, slot0.activityTabItemList[slot5].actId) then
			table.remove(slot0.activityTabItemList, slot5)

			slot0.activityTabItemDict[slot6.actId] = nil

			slot6:dispose()
			gohelper.destroy(slot6.rootGo)
		end
	end
end

function slot0.checkCanRemove(slot0, slot1)
	if slot1.actType == VersionActivity1_9Enum.ActType.Single then
		slot2 = slot1.storeId and ActivityHelper.getActivityStatus(slot1.storeId) or ActivityHelper.getActivityStatus(slot1.actId)

		return slot2 == ActivityEnum.ActivityStatus.Expired or slot2 == ActivityEnum.ActivityStatus.NotOnLine
	end

	for slot5, slot6 in ipairs(slot1.actId) do
		if ActivityHelper.getActivityStatus(slot6) ~= ActivityEnum.ActivityStatus.Expired and slot7 ~= ActivityEnum.ActivityStatus.NotOnLine then
			return false
		end
	end

	return true
end

function slot0.openActItemSortFunc(slot0, slot1)
	if ActivityModel.instance:getActMO(slot0).config.displayPriority ~= ActivityModel.instance:getActMO(slot1).config.displayPriority then
		return slot4 < slot5
	end

	if slot2:getRealStartTimeStamp() ~= slot3:getRealStartTimeStamp() then
		return slot7 < slot6
	end

	return slot0 < slot1
end

function slot0.noOpenActItemSortFunc(slot0, slot1)
	if ActivityModel.instance:getActMO(slot0):getRealStartTimeStamp() ~= ActivityModel.instance:getActMO(slot1):getRealStartTimeStamp() then
		return slot4 < slot5
	end

	if slot2.config.displayPriority ~= slot3.config.displayPriority then
		return slot6 < slot7
	end

	return slot0 < slot1
end

return slot0
