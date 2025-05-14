module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementContainer", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScoreTaskAchievementContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = V1a4_BossRush_ScoreTaskAchievementListModel.instance
	local var_1_1 = ListScrollParam.New()

	var_1_1.cellClass = V1a4_BossRush_ScoreTaskAchievementItem
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.scrollGOPath = "#scroll_ScoreList"
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 964
	var_1_1.cellHeight = 162
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.sortMode = ScrollEnum.ScrollSortDown
	arg_1_0._scoreTaskAchievement = V1a4_BossRush_ScoreTaskAchievement.New()
	arg_1_0._taskScrollView = LuaListScrollView.New(var_1_0, var_1_1)

	return {
		arg_1_0._scoreTaskAchievement,
		arg_1_0._taskScrollView,
		(TabViewGroup.New(1, "top_left"))
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.setActiveBlock(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0._scoreTaskAchievement then
		return
	end

	arg_3_0._scoreTaskAchievement:setActiveBlock(arg_3_1, arg_3_2)
end

function var_0_0.onContainerInit(arg_4_0)
	arg_4_0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_4_0._taskScrollView)

	arg_4_0.taskAnimRemoveItem:setMoveInterval(0)
end

return var_0_0
