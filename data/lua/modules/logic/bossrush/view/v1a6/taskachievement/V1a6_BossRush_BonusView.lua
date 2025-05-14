module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusView", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusView", BaseView)

function var_0_0._setActive_text(arg_1_0, arg_1_1)
	gohelper.setActive(arg_1_0._textGo, arg_1_1)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simageFullBG = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_FullBG")
	arg_2_0._gobonus = gohelper.findChild(arg_2_0.viewGO, "#go_bonus")
	arg_2_0._goTab3 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab3")
	arg_2_0._goUnSelect3 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab3/#go_UnSelect3")
	arg_2_0._goSelected3 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab3/#go_Selected3")
	arg_2_0._goRedDot3 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab3/#go_RedDot3")
	arg_2_0._btn3 = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Tab/#go_Tab3/#btn_3")
	arg_2_0._goTab1 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab1")
	arg_2_0._goUnSelected1 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab1/#go_UnSelected1")
	arg_2_0._goSelected1 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab1/#go_Selected1")
	arg_2_0._goRedDot1 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab1/#go_RedDot1")
	arg_2_0._btn1 = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Tab/#go_Tab1/#btn_1")
	arg_2_0._goTab2 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab2")
	arg_2_0._goUnSelect2 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab2/#go_UnSelect2")
	arg_2_0._goSelected2 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab2/#go_Selected2")
	arg_2_0._goRedDot2 = gohelper.findChild(arg_2_0.viewGO, "Tab/#go_Tab2/#go_RedDot2")
	arg_2_0._btn2 = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Tab/#go_Tab2/#btn_2")
	arg_2_0._goBlock = gohelper.findChild(arg_2_0.viewGO, "#go_Block")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btn3:AddClickListener(arg_3_0._btn3OnClick, arg_3_0)
	arg_3_0._btn1:AddClickListener(arg_3_0._btn1OnClick, arg_3_0)
	arg_3_0._btn2:AddClickListener(arg_3_0._btn2OnClick, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_3_0._refreshRedDot, arg_3_0)
	arg_3_0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btn3:RemoveClickListener()
	arg_4_0._btn1:RemoveClickListener()
	arg_4_0._btn2:RemoveClickListener()
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_4_0._refreshRedDot, arg_4_0)
	arg_4_0:removeEventCb(TaskController.instance, TaskEvent.SetTaskList, arg_4_0._refreshRedDot, arg_4_0)
end

function var_0_0._btn1OnClick(arg_5_0)
	arg_5_0:cutTab(BossRushEnum.BonusViewTab.AchievementTab)
end

function var_0_0._btn2OnClick(arg_6_0)
	arg_6_0:cutTab(BossRushEnum.BonusViewTab.ScheduleTab)
end

function var_0_0._btn3OnClick(arg_7_0)
	arg_7_0:cutTab(BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function var_0_0._btnOnClick(arg_8_0)
	return
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._textGo = gohelper.findChild(arg_9_0.viewGO, "text")
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._stage = arg_11_0.viewParam.stage
	arg_11_0._selectTab = BossRushModel.instance:isSpecialActivity() and BossRushEnum.BonusViewTab.SpecialScheduleTab or BossRushEnum.BonusViewTab.AchievementTab

	arg_11_0:activeTab()
	arg_11_0:_refreshTab()
	arg_11_0:_addRedDot()
	BossRushController.instance:sendGetTaskInfoRequest(arg_11_0.openDefaultTab, arg_11_0)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

function var_0_0.openDefaultTab(arg_14_0)
	arg_14_0:selectTab(arg_14_0._selectTab)
	arg_14_0:_refreshRedDot()
end

function var_0_0.cutTab(arg_15_0, arg_15_1)
	if arg_15_0._selectTab and arg_15_0._selectTab == arg_15_1 then
		return
	end

	arg_15_0._selectTab = arg_15_1

	arg_15_0:activeTab()
	arg_15_0:selectTab(arg_15_0._selectTab)
end

function var_0_0.selectTab(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:_setActive_text(arg_16_1 == BossRushEnum.BonusViewTab.AchievementTab)
	arg_16_0.viewContainer:selectTabView(arg_16_1, arg_16_2)
end

function var_0_0.activeTab(arg_17_0)
	gohelper.setActive(arg_17_0._goUnSelected1, arg_17_0._selectTab ~= BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(arg_17_0._goSelected1, arg_17_0._selectTab == BossRushEnum.BonusViewTab.AchievementTab)
	gohelper.setActive(arg_17_0._goUnSelect2, arg_17_0._selectTab ~= BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(arg_17_0._goSelected2, arg_17_0._selectTab == BossRushEnum.BonusViewTab.ScheduleTab)
	gohelper.setActive(arg_17_0._goUnSelect3, arg_17_0._selectTab ~= BossRushEnum.BonusViewTab.SpecialScheduleTab)
	gohelper.setActive(arg_17_0._goSelected3, arg_17_0._selectTab == BossRushEnum.BonusViewTab.SpecialScheduleTab)
end

function var_0_0._addRedDot(arg_18_0)
	local var_18_0 = RedDotEnum.DotNode.BossRushBossSchedule
	local var_18_1 = BossRushRedModel.instance:getUId(var_18_0, arg_18_0._stage)

	RedDotController.instance:addRedDot(arg_18_0._goRedDot2, var_18_0, var_18_1)

	local var_18_2 = RedDotEnum.DotNode.BossRushBossAchievement
	local var_18_3 = BossRushRedModel.instance:getUId(var_18_2, arg_18_0._stage)

	RedDotController.instance:addRedDot(arg_18_0._goRedDot1, var_18_2, var_18_3)
	RedDotController.instance:addRedDot(arg_18_0._goRedDot3, var_18_2, var_18_3)
end

function var_0_0._refreshRedDot(arg_19_0)
	local var_19_0 = V1a4_BossRush_ScoreTaskAchievementListModel.instance:isReddot(arg_19_0._stage)
	local var_19_1 = V2a1_BossRush_SpecialScheduleViewListModel.instance:isReddot(arg_19_0._stage)

	gohelper.setActive(arg_19_0._goRedDot1, var_19_0)
	gohelper.setActive(arg_19_0._goRedDot3, var_19_1)
end

function var_0_0._refreshTab(arg_20_0)
	local var_20_0 = BossRushModel.instance:isSpecialActivity()

	gohelper.setActive(arg_20_0._goTab3, var_20_0)

	local var_20_1 = var_20_0 and 326 or 489

	recthelper.setWidth(arg_20_0._goTab1.transform, var_20_1)
	recthelper.setWidth(arg_20_0._goTab2.transform, var_20_1)
	recthelper.setWidth(arg_20_0._goTab3.transform, var_20_1)
end

return var_0_0
