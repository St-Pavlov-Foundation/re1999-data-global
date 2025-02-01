module("modules.versionactivitybase.enterview.view.new.VersionActivityEnterBaseViewWithListNew", package.seeall)

slot0 = class("VersionActivityEnterBaseViewWithListNew", BaseView)

function slot0.onInitView(slot0)
	slot0.tabLevelSetting = {}
	slot0.activityTabItemList = {}
	slot0.activityTabItemDict = {}
	slot0.openActIdList = {}
	slot0.noOpenActList = {}
	slot0.curActId = 0
	slot0.defaultTabIndex = 1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, slot0.onSelectActId, slot0)
	slot0:childAddEvents()
end

function slot0.removeEvents(slot0)
	slot0:childRemoveEvents()
end

function slot0.onRefreshActivity(slot0, slot1)
	if ActivityHelper.getActivityStatus(slot0.curStoreId or slot0.curActId) == ActivityEnum.ActivityStatus.NotOnLine or slot3 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end

	for slot7, slot8 in ipairs(slot0.activitySettingList) do
		if VersionActivityEnterHelper.isActTabCanRemove(slot8) then
			slot0:removeActItem(slot8)
		end
	end

	for slot7, slot8 in ipairs(slot0.activityTabItemList) do
		if slot8:updateActId() then
			slot0.activityTabItemDict[slot8.actId] = slot8
		end
	end

	slot0:sortTabItemList()
end

function slot0.onSelectActId(slot0, slot1, slot2)
	if slot0.curActId == slot1 then
		return
	end

	slot0.curActId = slot1
	slot0.curStoreId = slot2 and slot2.storeId

	slot0.viewContainer:selectActTab(VersionActivityEnterHelper.getTabIndex(slot0.activitySettingList, slot1), slot0.curActId)
	ActivityEnterMgr.instance:enterActivity(slot0.curActId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.curActId
	})
	slot0:refreshBtnVisible()
end

function slot0.removeActItem(slot0, slot1)
	for slot5 = #slot0.activityTabItemList, 1, -1 do
		if VersionActivityEnterHelper.checkIsSameAct(slot1, slot0.activityTabItemList[slot5].actId) then
			table.remove(slot0.activityTabItemList, slot5)

			slot0.activityTabItemDict[slot6.actId] = nil

			slot6:dispose()
			gohelper.destroy(slot6.go)
		end
	end
end

function slot0.childAddEvents(slot0)
	logError("override VersionActivityEnterBaseViewWithListNew:childAddEvents")
end

function slot0.childRemoveEvents(slot0)
	logError("override VersionActivityEnterBaseViewWithListNew:childRemoveEvents")
end

function slot0.playVideo(slot0)
end

function slot0.refreshRedDot(slot0)
end

function slot0.refreshBtnVisible(slot0, slot1)
	logError("override VersionActivityEnterBaseViewWithListNew:refreshBtnVisible")
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:refreshUI()

	if slot0.activityTabItemDict[slot0.curActId] then
		slot0.curActId = nil

		slot1:onClick()
	end
end

function slot0.onOpen(slot0)
	for slot4, slot5 in ipairs(slot0.tabLevelSetting) do
		gohelper.setActive(slot5.go, false)
	end

	gohelper.setActive(slot0._goActivityLine, false)
	slot0:initViewParam()
	slot0:createActivityTabItem()
	slot0:playVideo()
	slot0:refreshUI()
	slot0:refreshRedDot()
	slot0:refreshBtnVisible(true)
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.skipOpenAnim = slot0.viewParam.skipOpenAnim
	slot0.activitySettingList = slot0.viewParam.activitySettingList
	slot0.defaultTabIndex = VersionActivityEnterHelper.getTabIndex(slot0.activitySettingList, slot0.viewParam.jumpActId)
	slot1 = slot0.activitySettingList[slot0.defaultTabIndex]
	slot0.curActId = VersionActivityEnterHelper.getActId(slot1)
	slot0.curStoreId = slot1 and slot1.storeId
end

function slot0.setTabLevelSetting(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot2) or not slot1 or not slot3 then
		return
	end

	if not slot0.tabLevelSetting then
		slot0.tabLevelSetting = {}
	end

	slot0.tabLevelSetting[slot1] = slot0:getUserDataTb_()
	slot0.tabLevelSetting[slot1].go = slot2
	slot0.tabLevelSetting[slot1].cls = slot3
end

function slot0.setActivityLineGo(slot0, slot1)
	if gohelper.isNil(slot1) then
		return
	end

	slot0._goActivityLine = slot1
end

function slot0.getItemGoAndCls(slot0, slot1)
	if not slot1 then
		logError("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, level is nil")

		return
	end

	if not (slot0.tabLevelSetting and slot0.tabLevelSetting[slot1]) then
		logError(string.format("VersionActivityEnterBaseViewWithListNew:getItemGoAndCls error, no tabSetting, level:%s", slot1))

		return
	end

	return slot2.go, slot2.cls
end

function slot0.createActivityTabItem(slot0)
	for slot4, slot5 in ipairs(slot0.activitySettingList) do
		if not VersionActivityEnterHelper.isActTabCanRemove(slot5) then
			slot7 = VersionActivityEnterHelper.getActId(slot5)
			slot8, slot9 = slot0:getItemGoAndCls(slot5.actLevel)

			if slot8 and slot9 then
				slot11 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot8, slot7), slot9)

				slot11:setData(slot4, slot5)
				slot11:refreshSelect(slot0.curActId)

				if slot0["onClickActivity" .. slot7] then
					slot11:setClickFunc(slot12, slot0)
				end

				slot0.activityTabItemDict[slot7] = slot11

				table.insert(slot0.activityTabItemList, slot11)
			end
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:sortTabItemList()

	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		slot5:refreshUI()
	end
end

function slot1(slot0, slot1)
	slot3 = ActivityModel.instance:getActMO(slot1)

	if (ActivityModel.instance:getActMO(slot0) and slot2.config.displayPriority or 0) ~= (slot3 and slot3.config.displayPriority or 0) then
		return slot4 < slot5
	end

	if (slot2 and slot2:getRealStartTimeStamp() or 0) ~= (slot3 and slot3:getRealStartTimeStamp() or 0) then
		return slot7 < slot6
	end

	return slot0 < slot1
end

function slot2(slot0, slot1)
	if ActivityModel.instance:getActMO(slot0):getRealStartTimeStamp() ~= ActivityModel.instance:getActMO(slot1):getRealStartTimeStamp() then
		return slot4 < slot5
	end

	if slot2.config.displayPriority ~= slot3.config.displayPriority then
		return slot6 < slot7
	end

	return slot0 < slot1
end

function slot0.sortTabItemList(slot0)
	tabletool.clear(slot0.openActIdList)
	tabletool.clear(slot0.noOpenActList)

	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		if ActivityHelper.getActivityStatus(slot5.actId) == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(slot0.noOpenActList, slot5.actId)
		else
			table.insert(slot0.openActIdList, slot5.actId)
		end
	end

	table.sort(slot0.openActIdList, uv0)

	for slot4, slot5 in ipairs(slot0.openActIdList) do
		gohelper.setSibling(slot0.activityTabItemDict[slot5].go, slot4)
	end

	if #slot0.noOpenActList < 1 then
		gohelper.setActive(slot0._goActivityLine, false)

		return
	end

	gohelper.setActive(slot0._goActivityLine, true)
	gohelper.setSibling(slot0._goActivityLine, #slot0.openActIdList + 1)
	table.sort(slot0.noOpenActList, uv1)

	for slot5, slot6 in ipairs(slot0.noOpenActList) do
		gohelper.setSibling(slot0.activityTabItemDict[slot6].go, slot1 + 1 + slot5)
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.activityTabItemList) do
		slot5:dispose()
	end

	slot0.activityTabItemList = nil
	slot0.activityTabItemDict = nil
end

return slot0
