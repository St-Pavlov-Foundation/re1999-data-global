module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsView", package.seeall)

slot0 = class("SportsNewsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._scrolltablist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_tablist")
	slot0._simagepaperbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_paperbg")
	slot0._simageTitleName = gohelper.findChildSingleImage(slot0.viewGO, "#simage_TitleName")
	slot0._itemList = gohelper.findChild(slot0.viewGO, "List")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Reward/#btn_Reward")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Reward/#go_redpoint")
	slot0._gotabitemcontent = gohelper.findChild(slot0.viewGO, "#scroll_tablist/Viewport/content")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#simage_TitleName/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnReward:AddClickListener(slot0._btnRewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnReward:RemoveClickListener()
end

function slot0._btnRewardOnClick(slot0)
	ViewMgr.instance:openView(ViewName.SportsNewsTaskView, {
		actId = ActivityWarmUpModel.instance:getActId(),
		index = ActivityWarmUpModel.instance:getSelectedDay()
	})
end

slot0.OrderMaxPos = 4

function slot0._editableInitView(slot0)
	slot0._pageTabs = slot0:getUserDataTb_()
	slot0._newsItems = slot0:getUserDataTb_()
	slot0._newsPos = slot0:getUserDataTb_()

	for slot4 = 1, uv0.OrderMaxPos do
		slot0._newsPos[slot4] = gohelper.findChild(slot0._itemList, slot4)
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._newsItems) do
		slot5:onDestroyView()
	end

	for slot4, slot5 in ipairs(slot0._pageTabs) do
		slot5:onDestroyView()
	end
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, slot0.refreshUI, slot0)
	slot0:addEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, slot0.onInfosReply, slot0)
	ActivityWarmUpController.instance:init(slot0.actId)

	slot0.jumpTab = SportsNewsModel.instance:getJumpToTab(slot0.actId)

	if slot0.jumpTab then
		ActivityWarmUpController.instance:switchTab(slot0.jumpTab)
	end

	Activity106Rpc.instance:sendGet106InfosRequest(slot0.actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.v1a5NewsTaskBonus)
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.ViewSwitchTab, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.InfoReceived, slot0.refreshUI, slot0)
	slot0:removeEventCb(ActivityWarmUpController.instance, ActivityWarmUpEvent.OnInfosReply, slot0.onInfosReply, slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshAllTabBtns()
	slot0:refreshAllOrder()
	slot0:refreshRemainTime()
end

function slot0.onInfosReply(slot0)
	if slot0.jumpTab then
		return
	end

	for slot6, slot7 in pairs(SportsNewsModel.instance:hasCanFinishOrder()) do
		slot2 = Mathf.Min(slot6, ActivityWarmUpModel.instance:getSelectedDay())
	end

	ActivityWarmUpController.instance:switchTab(slot2)
end

function slot0.refreshAllTabBtns(slot0)
	slot2 = ActivityWarmUpModel.instance:getCurrentDay()

	for slot6 = 1, ActivityWarmUpModel.instance:getTotalContentDays() do
		slot0:refreshTabBtn(slot6)
	end

	slot0:dayTabRedDot()
end

function slot0.refreshTabBtn(slot0, slot1)
	slot0:getOrCreateTabItem(slot1):onRefresh()
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0.actId] then
		slot0._txttime.text = string.format(luaLang("remain"), slot1:getRemainTimeStr2ByEndTime())
	end
end

function slot0.getOrCreateTabItem(slot0, slot1)
	if not slot0._pageTabs[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot4 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[3], slot0._gotabitemcontent, "tab_item" .. tostring(slot1))
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, SportsNewsPageTabItem)

		slot2:initData(slot1, slot4)

		slot0._pageTabs[slot1] = slot2
	end

	return slot2
end

function slot0.dayTabRedDot(slot0)
	slot2 = {}

	if RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.v1a5NewsOrder).infos then
		for slot6, slot7 in pairs(slot1) do
			if not slot2[SportsNewsModel.instance:getDayByOrderId(slot0.actId, slot7.uid)] and slot9 then
				slot2[slot9] = {
					id = slot8
				}
			end
		end
	end

	for slot7 = 1, ActivityWarmUpModel.instance:getTotalContentDays() do
		slot8 = slot2[slot7] and slot2[slot7].id

		slot0:getOrCreateTabItem(slot7):enableRedDot(slot8, RedDotEnum.DotNode.v1a5NewsOrder, slot8)
	end
end

function slot0.refreshAllOrder(slot0)
	if ActivityWarmUpModel.instance:getSelectedDayOrders() then
		for slot5, slot6 in ipairs(slot1) do
			slot0:refreshOrder(slot5, slot6)
		end
	end
end

function slot0.refreshOrder(slot0, slot1, slot2)
	slot0:getOrCreateOrderItem(slot1):onRefresh(slot2)
end

function slot0.getOrCreateOrderItem(slot0, slot1)
	if not slot0._newsItems[slot1] then
		if not slot0._newsPos[slot1] then
			return
		end

		slot4 = slot1 > 1 and 2 or 1
		slot6 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[slot4], slot3, "news_" .. tostring(slot1))
		slot2 = (slot4 ~= 1 or MonoHelper.addNoUpdateLuaComOnceToGo(slot6, SportsNewsMainReadItem)) and MonoHelper.addNoUpdateLuaComOnceToGo(slot6, SportsNewsMainTaskItem)

		slot2:initData(slot6, slot1)

		slot0._newsItems[slot1] = slot2
	end

	return slot2
end

return slot0
