module("modules.logic.versionactivity2_2.act101.view.VersionActivity2_2RoomSignView", package.seeall)

slot0 = class("VersionActivity2_2RoomSignView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildTextMesh(slot0.viewGO, "timebg/#txt_LimitTime")
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "#scroll_ItemList")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_ItemList/Viewport/Content")
	slot0.itemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0._onRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity125Controller.instance, Activity125Event.DataUpdate, slot0._onRefresh, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onRefresh(slot0)
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0.isFirstOpen = true

	slot0:refreshView()
	slot0:moveLast()
end

function slot0.refreshView(slot0)
	if slot0.isFirstOpen then
		slot0.isFirstOpen = false

		slot0:refreshItemListDelay()
	else
		slot0:refreshItemList()
	end

	slot0:_showDeadline()
end

function slot0.refreshItemList(slot0)
	if slot0.curIndex then
		return
	end

	slot7 = #Activity125Model.instance:getById(slot0._actId):getEpisodeList()

	for slot7 = 1, math.max(#slot0.itemList, slot7) do
		if not slot0.itemList[slot7] then
			slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent), VersionActivity2_2RoomSignItem)
			slot8._index = slot7
			slot0.itemList[slot7] = slot8
		end

		slot8:onUpdateMO(slot2[slot7], slot1)
	end
end

function slot0.refreshItemListDelay(slot0)
	slot0.curIndex = 0

	TaskDispatcher.cancelTask(slot0._refreshCurItem, slot0)
	TaskDispatcher.runRepeat(slot0._refreshCurItem, slot0, 0.06)
end

function slot0._refreshCurItem(slot0)
	slot0.curIndex = slot0.curIndex + 1

	if Activity125Model.instance:getById(slot0._actId):getEpisodeList()[slot0.curIndex] then
		slot0:refreshItem(slot0.curIndex, slot3, slot1)
	else
		slot0.curIndex = nil

		TaskDispatcher.cancelTask(slot0._refreshCurItem, slot0)
	end
end

function slot0.refreshItem(slot0, slot1, slot2, slot3)
	if not slot0.itemList[slot1] then
		slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._goContent), VersionActivity2_2RoomSignItem)
		slot4._index = slot1
		slot0.itemList[slot1] = slot4
	end

	slot4:onUpdateMO(slot2, slot3)
end

function slot0.moveLast(slot0)
	slot3 = 1

	for slot7, slot8 in ipairs(Activity125Model.instance:getById(slot0._actId):getEpisodeList()) do
		if slot1:isEpisodeDayOpen(slot8.id) and not slot1:isEpisodeFinished(slot8.id) then
			slot3 = slot7

			break
		end
	end

	recthelper.setAnchorX(slot0._goContent.transform, -math.min(slot0:getMaxScrollX(), math.max(0, 0 + (slot3 - 1) * (476 + 30))))
end

function slot0.getMaxScrollX(slot0)
	slot5 = 506 * #Activity125Model.instance:getById(slot0._actId):getEpisodeList() - 12

	recthelper.setWidth(slot0._goContent.transform, slot5)

	return math.max(0, slot5 - recthelper.getWidth(slot0._goScroll.transform))
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 60)
end

function slot0._onRefreshDeadline(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshCurItem, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	slot0.itemList = nil
end

return slot0
