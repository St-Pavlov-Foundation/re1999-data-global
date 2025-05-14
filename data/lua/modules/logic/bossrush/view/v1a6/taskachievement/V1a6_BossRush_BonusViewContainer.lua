module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusViewContainer", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, V1a6_BossRush_TabViewGroup.New(2, "#go_bonus"))
	table.insert(var_1_0, V1a6_BossRush_BonusView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = {}

		for iter_2_0 = 1, 10 do
			var_2_0[iter_2_0] = (iter_2_0 - 1) * 0.07
		end

		local var_2_1 = ListScrollParam.New()

		var_2_1.cellClass = V1a6_BossRush_AchievementItem
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_1.scrollGOPath = "Right/#scroll_ScoreList"
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 1
		var_2_1.cellWidth = 964
		var_2_1.cellHeight = 162
		var_2_1.cellSpaceH = 0
		var_2_1.cellSpaceV = 0
		var_2_1.startSpace = 0
		var_2_1.sortMode = ScrollEnum.ScrollSortDown
		arg_2_0._achievementScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScoreTaskAchievementListModel.instance, var_2_1, var_2_0)
		arg_2_0._achievementView = V1a6_BossRush_AchievementView.New()

		local var_2_2 = ListScrollParam.New()

		var_2_2.cellClass = V1a6_BossRush_ScheduleItem
		var_2_2.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_2.prefabUrl = arg_2_0._viewSetting.otherRes[2]
		var_2_2.scrollGOPath = "Right/#scroll_ScoreList"
		var_2_2.scrollDir = ScrollEnum.ScrollDirV
		var_2_2.lineCount = 1
		var_2_2.cellWidth = 964
		var_2_2.cellHeight = 162
		var_2_2.cellSpaceH = 0
		var_2_2.cellSpaceV = 0
		var_2_2.startSpace = 0
		var_2_2.sortMode = ScrollEnum.ScrollSortDown
		arg_2_0._scheduleScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScheduleViewListModel.instance, var_2_2, var_2_0)
		arg_2_0._scheduleView = V1a6_BossRush_ScheduleView.New()

		local var_2_3 = ListScrollParam.New()

		var_2_3.cellClass = V2a1_BossRush_SpecialScheduleItem
		var_2_3.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_3.prefabUrl = arg_2_0._viewSetting.otherRes[4]
		var_2_3.scrollGOPath = "Right/#scroll_ScoreList"
		var_2_3.scrollDir = ScrollEnum.ScrollDirV
		var_2_3.lineCount = 1
		var_2_3.cellWidth = 964
		var_2_3.cellHeight = 162
		var_2_3.cellSpaceH = 0
		var_2_3.cellSpaceV = 0
		var_2_3.startSpace = 0
		var_2_3.sortMode = ScrollEnum.ScrollSortDown
		arg_2_0._specialScheduleScrollView = LuaListScrollViewWithAnimator.New(V2a1_BossRush_SpecialScheduleViewListModel.instance, var_2_3, var_2_0)
		arg_2_0._specialScheduleView = V2a1_BossRush_SpecialScheduleView.New()

		return {
			MultiView.New({
				arg_2_0._specialScheduleView,
				arg_2_0._specialScheduleScrollView
			}),
			MultiView.New({
				arg_2_0._achievementView,
				arg_2_0._achievementScrollView
			}),
			MultiView.New({
				arg_2_0._scheduleView,
				arg_2_0._scheduleScrollView
			})
		}
	end
end

function var_0_0.getScrollAnimRemoveItem(arg_3_0, arg_3_1)
	if arg_3_1 == BossRushEnum.BonusViewTab.AchievementTab then
		return ListScrollAnimRemoveItem.Get(arg_3_0._achievementScrollView)
	elseif arg_3_1 == BossRushEnum.BonusViewTab.ScheduleTab then
		return ListScrollAnimRemoveItem.Get(arg_3_0._scheduleScrollView)
	elseif arg_3_1 == BossRushEnum.BonusViewTab.SpecialScheduleTab then
		return ListScrollAnimRemoveItem.Get(arg_3_0._specialScheduleScrollView)
	end
end

function var_0_0.getTabView(arg_4_0, arg_4_1)
	if arg_4_1 == BossRushEnum.BonusViewTab.AchievementTab then
		return arg_4_0._achievementView
	elseif arg_4_1 == BossRushEnum.BonusViewTab.ScheduleTab then
		return arg_4_0._scheduleView
	elseif arg_4_1 == BossRushEnum.BonusViewTab.SpecialScheduleTab then
		return arg_4_0._specialScheduleView
	end
end

function var_0_0.selectTabView(arg_5_0, arg_5_1)
	arg_5_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_5_1)
end

return var_0_0
