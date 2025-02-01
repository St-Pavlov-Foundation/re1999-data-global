module("modules.logic.versionactivity1_7.dungeon.view.DungeonMapActDropView", package.seeall)

slot0 = class("DungeonMapActDropView", BaseView)

function slot0.onInitView(slot0)
	slot0._goact = gohelper.findChild(slot0.viewGO, "#go_act")
	slot0._bg1 = gohelper.findChild(slot0.viewGO, "#go_act/bg")
	slot0._bg2 = gohelper.findChild(slot0.viewGO, "#go_act/bg2")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_act/layout/#btn_store")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_act/layout/#btn_task")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "#go_act/layout/#btn_task/#go_reddot")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_act/layout/#btn_store/normal/#txt_num")
	slot0._txtStoreTime = gohelper.findChildText(slot0.viewGO, "#go_act/layout/#btn_store/#go_time/#txt_time")
	slot0._goStoreTime = gohelper.findChild(slot0.viewGO, "#go_act/layout/#btn_store/#go_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0.onClickStore, slot0)
	slot0._btntask:AddClickListener(slot0.onClickTask, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
	slot0._btntask:RemoveClickListener()
end

slot0.ActBtnPosY = {
	Resource = 345,
	Equip = 236,
	Normal = 160
}

function slot0.onClickStore(slot0)
	VersionActivity2_2DungeonController.instance:openStoreView()
end

function slot0.onClickTask(slot0)
	VersionActivity2_2DungeonController.instance:openTaskView()
end

function slot0._editableInitView(slot0)
	slot0.rectTrLayout = gohelper.findChildComponent(slot0.viewGO, "#go_act/layout", gohelper.Type_RectTransform)

	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.V2a2DungeonTask)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshStoreCurrency, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0.setEpisodeListVisible, slot0)
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		gohelper.setActive(slot0._goact, false)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0:_showActNode(slot0:checkCanShowAct())
	end
end

function slot0.onOpen(slot0)
	slot0.chapterId = slot0.viewParam.chapterId
	slot0.chapterCo = DungeonConfig.instance:getChapterCO(slot0.chapterId)

	slot0:_showActNode(slot0:checkCanShowAct())
end

function slot0.onUpdateParam(slot0)
	slot0.chapterId = slot0.viewParam.chapterId
	slot0.chapterCo = DungeonConfig.instance:getChapterCO(slot0.chapterId)

	slot0:_showActNode(slot0:checkCanShowAct())
end

function slot0._showActNode(slot0, slot1)
	slot1 = slot1 and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView)

	gohelper.setActive(slot0._goact, slot1)

	if slot1 then
		slot0:refreshLayout()
		slot0:refreshStoreCurrency()
		slot0:refreshRemainTime()
	end
end

function slot0.refreshLayout(slot0)
	slot2 = uv0.ActBtnPosY.Normal

	if DungeonModel.instance:chapterListIsNormalType(slot0.chapterCo.type) then
		slot2 = uv0.ActBtnPosY.Normal
	elseif slot1 == DungeonEnum.ChapterType.Equip then
		slot2 = uv0.ActBtnPosY.Equip
	elseif DungeonModel.instance:chapterListIsResType(slot1) or DungeonModel.instance:chapterListIsBreakType(slot1) then
		slot2 = uv0.ActBtnPosY.Resource
	end

	gohelper.setActive(slot0._gobg1, slot2 == uv0.ActBtnPosY.Normal)
	gohelper.setActive(slot0._gobg2, slot2 ~= uv0.ActBtnPosY.Normal)
	recthelper.setAnchorY(slot0.rectTrLayout, slot2)
end

function slot0.refreshStoreCurrency(slot0)
	slot0._txtnum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a2Dungeon) and slot1.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	if not ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.DungeonStore] then
		gohelper.setActive(slot0._goStoreTime, false)

		return
	end

	gohelper.setActive(slot0._goStoreTime, true)

	slot0._txtStoreTime.text = slot1:getRemainTimeStr2ByEndTime(true)
end

function slot0.checkCanShowAct(slot0)
	return slot0:checkHadAct155Drop() and slot0:checkActActive()
end

function slot0.checkHadAct155Drop(slot0)
	for slot5, slot6 in ipairs(lua_activity155_drop.configList) do
		if slot6.chapterId == slot0.chapterId then
			-- Nothing
		end
	end

	for slot5 in pairs({
		[slot6.activityId] = true
	}) do
		if ActivityHelper.getActivityStatus(slot5) == ActivityEnum.ActivityStatus.Normal then
			slot0.actId = slot5

			return true
		end
	end

	return false
end

function slot0.checkActActive(slot0)
	if not slot0.actId then
		return false
	end

	return ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal
end

function slot0.setEpisodeListVisible(slot0, slot1)
	gohelper.setActive(slot0._goact, slot1 and slot0:checkCanShowAct())
end

function slot0.onRefreshActivityState(slot0)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		return
	end

	gohelper.setActive(slot0._goact, slot0:checkCanShowAct())
end

function slot0.onDestroyView(slot0)
end

return slot0
