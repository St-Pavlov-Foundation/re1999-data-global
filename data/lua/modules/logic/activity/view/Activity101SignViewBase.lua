module("modules.logic.activity.view.Activity101SignViewBase", package.seeall)

slot0 = class("Activity101SignViewBase", BaseView)
slot0.eOpenMode = {
	PaiLian = 2,
	ActivityBeginnerView = 1
}

function slot0.addEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0.internal_set_actId(slot0, slot1)
	slot0._actId = slot1
end

function slot0.internal_set_openMode(slot0, slot1)
	slot0._eOpenMode = slot1
end

function slot0.actId(slot0)
	return assert(slot0._actId, "please call self:internal_set_actId(actId) first")
end

function slot0.openMode(slot0)
	return assert(slot0._eOpenMode, "please call self:internal_set_openMode(eOpenMode) first")
end

function slot0.actCO(slot0)
	return lua_activity.configDict[slot0:actId()]
end

function slot0.internal_onOpen(slot0)
	if slot0:openMode() == uv0.eOpenMode.ActivityBeginnerView then
		slot0:internal_set_actId(slot0.viewParam.actId)
		gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
		slot0:_internal_onOpen()
		slot0:_refresh()
	elseif slot1 == slot2.PaiLian then
		slot0:_internal_onOpen()
		slot0:_refresh()
	else
		assert(false)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function slot0._internal_onOpen(slot0)
	slot0:onStart()
end

function slot0._internal_onDestroy(slot0)
	FrameTimerController.onDestroyViewMember(slot0, "__createTimer")
	GameUtil.onDestroyViewMemberList(slot0, "__itemList")
end

function slot0._refresh(slot0)
	slot0:onRefresh()
end

function slot0.getHelpViewParam(slot0, slot1)
	return {
		title = luaLang("rule"),
		desc = ActivityConfig.instance:getActivityCo(slot0._actId).actTip,
		rootGo = slot1
	}
end

function slot0.getDataList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(lua_activity101.configDict[slot0:actId()] or {}) do
		slot1[#slot1 + 1] = {
			day = slot6,
			data = slot7
		}
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.day < slot1.day
	end)

	slot0._tempDataList = slot1

	return slot1
end

function slot0.getTempDataList(slot0)
	return slot0._tempDataList
end

function slot0.getRewardCouldGetIndex(slot0)
	slot2 = slot0:getDataList()
	slot3 = #slot2

	for slot7, slot8 in ipairs(slot2) do
		if not ActivityType101Model.instance:isType101RewardGet(slot0:actId(), slot8.day) then
			return true, slot7
		end
	end

	return false, slot3
end

function slot0.updateRewardCouldGetHorizontalScrollPixel(slot0, slot1)
	slot2, slot3 = slot0:getRewardCouldGetIndex()

	if slot1 then
		slot3 = slot1(slot3)
	end

	if slot0.viewContainer:getCsListScroll() then
		slot0:_tweenByLimitedScrollView(slot3)
	else
		slot0:_tweenByScrollContent(slot3)
	end
end

function slot0._tweenByLimitedScrollView(slot0, slot1)
	slot2 = slot0.viewContainer:getCsListScroll()
	slot3 = slot0.viewContainer:getListScrollParam()
	slot2.HorizontalScrollPixel = math.max(0, (slot3.cellWidth + slot3.cellSpaceH) * math.max(0, slot1))

	slot2:UpdateCells(true)
end

function slot0._tweenByScrollContent(slot0, slot1)
	slot2 = slot0.viewContainer:getScrollContentTranform()
	slot4 = slot0.viewContainer:getListScrollParam().startSpace

	if slot1 <= 1 then
		recthelper.setAnchorX(slot2, slot4 or 0)

		return
	end

	recthelper.setAnchorX(slot2, -math.min(slot0:getMaxScrollX(), math.max(0, slot4 + (slot1 - 1) * (slot3.cellWidth + slot3.cellSpaceH))))
end

function slot0.getRemainTimeStr(slot0)
	slot1 = slot0:actId()

	if slot0:getRemainTimeSec() <= 0 then
		return luaLang("turnback_end")
	end

	slot3, slot4, slot5, slot6 = TimeUtil.secondsToDDHHMMSS(slot2)

	if slot3 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			slot3,
			slot4
		})
	elseif slot4 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			slot4,
			slot5
		})
	elseif slot5 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			slot5
		})
	elseif slot6 > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	return luaLang("turnback_end")
end

function slot0._createList(slot0)
	if slot0.__itemList then
		return
	end

	slot1 = slot0:getDataList()

	recthelper.setWidth(slot0.viewContainer:getScrollContentTranform(), slot0:calcContentWidth())

	if slot0._scrollItemList then
		slot0._scrollItemList:GetComponent(gohelper.Type_RectMask2D).enabled = #slot1 > 7
	end

	slot0.__itemList = {}

	if #slot1 <= 7 then
		slot0:_createListDirectly()
	else
		slot0:_createListSplitFrame()
	end
end

function slot0._createListDirectly(slot0)
	for slot5, slot6 in ipairs(slot0:getDataList()) do
		slot7 = slot0.viewContainer:createItemInst()
		slot7._index = slot5
		slot7._view = slot0

		slot7:onUpdateMO(slot6)
		slot7:playOpenAnim()
		table.insert(slot0.__itemList, slot7)
	end
end

function slot0._createListSplitFrame(slot0)
	slot0.__createTimer = FrameTimerController.instance:register(slot0.__createInner, slot0, 1, #slot0:getDataList() + 1)

	slot0.__createTimer:Start()
end

slot1 = 3

function slot0.__createInner(slot0)
	if #slot0:getDataList() == #slot0.__itemList then
		FrameTimerController.onDestroyViewMember(slot0, "__createTimer")

		return
	end

	slot4 = uv0

	for slot9 = #slot0.__itemList + 1, slot2 do
		if slot4 <= 0 and uv0 <= slot2 - slot9 then
			break
		end

		slot11 = slot0.viewContainer:createItemInst()
		slot11._index = slot9
		slot11._view = slot0

		slot11:onUpdateMO(slot1[slot9])
		slot11:playOpenAnim()
		table.insert(slot0.__itemList, slot11)

		slot4 = slot4 - 1
	end
end

function slot0._refreshList(slot0, slot1)
	slot2 = nil
	slot2 = (not slot1 or slot0:getTempDataList()) and slot0:getDataList()

	slot0:_setPinStartIndex(slot2)
	slot0:onRefreshList(slot2)
end

function slot0.refreshListByLimitedScollRect(slot0, slot1)
	slot0:getScrollModel():setList(slot1)
end

function slot0._updateScrollViewPos(slot0)
	slot0:updateRewardCouldGetHorizontalScrollPixel(function (slot0)
		if slot0 <= 4 then
			return slot0 - 4
		else
			return uv0:getTempDataList() and #slot1 or slot0
		end
	end)
end

function slot0.calcContentWidth(slot0)
	slot1 = slot0:getTempDataList() or slot0:getDataList()
	slot2 = slot0.viewContainer:getListScrollParam()
	slot3 = slot2.cellWidth

	return ((slot1 and #slot1 or 0) - 1) * (slot3 + slot2.cellSpaceH) + slot3 + slot2.startSpace + slot2.endSpace
end

function slot0.getMaxScrollX(slot0)
	return math.max(0, slot0:calcContentWidth() - slot0.viewContainer:getViewportWH())
end

function slot0.getScrollModel(slot0)
	return slot0.viewContainer:getScrollModel()
end

function slot0.getRemainTimeSec(slot0)
	return ActivityModel.instance:getRemainTimeSec(slot0:actId()) or 0
end

function slot0._editableInitView(slot0)
	assert(false, "please override this function")
end

function slot0._setPinStartIndex(slot0, slot1)
	slot2, slot3 = slot0:getRewardCouldGetIndex()

	slot0:getScrollModel():setDefaultPinStartIndex(slot1, slot2 and slot3 or 1)
end

function slot0.onStart(slot0)
	if slot0.viewContainer:isLimitedScrollView() then
		return
	end

	slot0:_createList()
	slot0:_updateScrollViewPos()
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
end

function slot0.onRefreshList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot0.__itemList[slot6] then
			if slot8._mo then
				slot7.__isPlayedOpenAnim = slot9.__isPlayedOpenAnim
			end

			slot8:onUpdateMO(slot7)
		end
	end
end

return slot0
