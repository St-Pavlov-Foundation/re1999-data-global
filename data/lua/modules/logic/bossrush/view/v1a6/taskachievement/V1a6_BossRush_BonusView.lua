module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

slot0 = class("V1a6_BossRush_BonusView", BaseView)

function slot0._setActive_text(slot0, slot1)
	gohelper.setActive(slot0._textGo, slot1)
end

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gobonus = gohelper.findChild(slot0.viewGO, "#go_bonus")
	slot0._goTab3 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab3")
	slot0._goUnSelect3 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab3/#go_UnSelect3")
	slot0._goSelected3 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab3/#go_Selected3")
	slot0._goRedDot3 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab3/#go_RedDot3")
	slot0._btn3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tab/#go_Tab3/#btn_3")
	slot0._goTab1 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab1")
	slot0._goUnSelected1 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab1/#go_UnSelected1")
	slot0._goSelected1 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab1/#go_Selected1")
	slot0._goRedDot1 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab1/#go_RedDot1")
	slot0._btn1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tab/#go_Tab1/#btn_1")
	slot0._goTab2 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab2")
	slot0._goUnSelect2 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab2/#go_UnSelect2")
	slot0._goSelected2 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab2/#go_Selected2")
	slot0._goRedDot2 = gohelper.findChild(slot0.viewGO, "Tab/#go_Tab2/#go_RedDot2")
	slot0._btn2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Tab/#go_Tab2/#btn_2")
	slot0._goBlock = gohelper.findChild(slot0.viewGO, "#go_Block")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn3:AddClickListener(slot0._btn3OnClick, slot0)
	slot0._btn1:AddClickListener(slot0._btn1OnClick, slot0)
	slot0._btn2:AddClickListener(slot0._btn2OnClick, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._refreshRedDot, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._refreshRedDot, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshRedDot, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._refreshRedDot, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn3:RemoveClickListener()
	slot0._btn1:RemoveClickListener()
	slot0._btn2:RemoveClickListener()
	slot0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0._refreshRedDot, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._refreshRedDot, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0._refreshRedDot, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0._refreshRedDot, slot0)
end

function slot0._btn1OnClick(slot0)
	slot0:cutTab(BossRushEnum.BonusViewTab.AchievementTab)
end

function slot0._btn2OnClick(slot0)
	slot0:cutTab(BossRushEnum.BonusViewTab.ScheduleTab)
end

function slot0._btn3OnClick(slot0)
	slot0:cutTab(BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function slot0._btnOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._textGo = gohelper.findChild(slot0.viewGO, "text")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._stage = slot0.viewParam.stage
	slot0._selectTab = BossRushModel.instance:isSpecialActivity() and BossRushEnum.BonusViewTab.SpecialScheduleTab or BossRushEnum.BonusViewTab.AchievementTab

	slot0:activeTab()
	slot0:_refreshTab()
	slot0:_addRedDot()
	BossRushController.instance:sendGetTaskInfoRequest(slot0.openDefaultTab, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.openDefaultTab(slot0)
	slot0:selectTab(slot0._selectTab)
	slot0:_refreshRedDot()
end

function slot0.cutTab(slot0, slot1)
	if slot0._selectTab and slot0._selectTab == slot1 then
		return
	end

	slot0._selectTab = slot1

	slot0:activeTab()
	slot0:selectTab(slot0._selectTab)
end

function slot0.selectTab(slot0, slot1, slot2)
	slot0:_setActive_text(slot1 == BossRushEnum.BonusViewTab.AchievementTab)
	slot0.viewContainer:selectTabView(slot1, slot2)
end

function slot0.activeTab(slot0)
	gohelper.setActive(slot0._goUnSelected1, slot0._selectTab ~= BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(slot0._goSelected1, slot0._selectTab == BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(slot0._goUnSelect2, slot0._selectTab ~= BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(slot0._goSelected2, slot0._selectTab == BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(slot0._goUnSelect3, slot0._selectTab ~= BossRushEnum.BonusViewTab.SpecialScheduleTab)
	gohelper.setActive(slot0._goSelected3, slot0._selectTab == BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function slot0._addRedDot(slot0)
	slot1 = RedDotEnum.DotNode.BossRushBossSchedule

	RedDotController.instance:addRedDot(slot0._goRedDot2, slot1, BossRushRedModel.instance:getUId(slot1, slot0._stage))

	slot3 = RedDotEnum.DotNode.BossRushBossAchievement
	slot4 = BossRushRedModel.instance:getUId(slot3, slot0._stage)

	RedDotController.instance:addRedDot(slot0._goRedDot1, slot3, slot4)
	RedDotController.instance:addRedDot(slot0._goRedDot3, slot3, slot4)
end

function slot0._refreshRedDot(slot0)
	gohelper.setActive(slot0._goRedDot1, V1a4_BossRush_ScoreTaskAchievementListModel.instance:isReddot(slot0._stage))
	gohelper.setActive(slot0._goRedDot3, V2a1_BossRush_SpecialScheduleViewListModel.instance:isReddot(slot0._stage))
end

function slot0._refreshTab(slot0)
	slot1 = BossRushModel.instance:isSpecialActivity()

	gohelper.setActive(slot0._goTab3, slot1)

	slot2 = slot1 and 326 or 489

	recthelper.setWidth(slot0._goTab1.transform, slot2)
	recthelper.setWidth(slot0._goTab2.transform, slot2)
	recthelper.setWidth(slot0._goTab3.transform, slot2)
end

return slot0
