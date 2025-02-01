module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusViewContainer", package.seeall)

slot0 = class("V1a6_BossRush_BonusViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, V1a6_BossRush_TabViewGroup.New(2, "#go_bonus"))
	table.insert(slot1, V1a6_BossRush_BonusView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		slot2 = {
			[slot6] = (slot6 - 1) * 0.07
		}

		for slot6 = 1, 10 do
		end

		slot3 = ListScrollParam.New()
		slot3.cellClass = V1a6_BossRush_AchievementItem
		slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot3.prefabUrl = slot0._viewSetting.otherRes[1]
		slot3.scrollGOPath = "Right/#scroll_ScoreList"
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.lineCount = 1
		slot3.cellWidth = 964
		slot3.cellHeight = 162
		slot3.cellSpaceH = 0
		slot3.cellSpaceV = 0
		slot3.startSpace = 0
		slot3.sortMode = ScrollEnum.ScrollSortDown
		slot0._achievementScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScoreTaskAchievementListModel.instance, slot3, slot2)
		slot0._achievementView = V1a6_BossRush_AchievementView.New()
		slot4 = ListScrollParam.New()
		slot4.cellClass = V1a6_BossRush_ScheduleItem
		slot4.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot4.prefabUrl = slot0._viewSetting.otherRes[2]
		slot4.scrollGOPath = "Right/#scroll_ScoreList"
		slot4.scrollDir = ScrollEnum.ScrollDirV
		slot4.lineCount = 1
		slot4.cellWidth = 964
		slot4.cellHeight = 162
		slot4.cellSpaceH = 0
		slot4.cellSpaceV = 0
		slot4.startSpace = 0
		slot4.sortMode = ScrollEnum.ScrollSortDown
		slot0._scheduleScrollView = LuaListScrollViewWithAnimator.New(V1a4_BossRush_ScheduleViewListModel.instance, slot4, slot2)
		slot0._scheduleView = V1a6_BossRush_ScheduleView.New()
		slot5 = ListScrollParam.New()
		slot5.cellClass = V2a1_BossRush_SpecialScheduleItem
		slot5.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot5.prefabUrl = slot0._viewSetting.otherRes[4]
		slot5.scrollGOPath = "Right/#scroll_ScoreList"
		slot5.scrollDir = ScrollEnum.ScrollDirV
		slot5.lineCount = 1
		slot5.cellWidth = 964
		slot5.cellHeight = 162
		slot5.cellSpaceH = 0
		slot5.cellSpaceV = 0
		slot5.startSpace = 0
		slot5.sortMode = ScrollEnum.ScrollSortDown
		slot0._specialScheduleScrollView = LuaListScrollViewWithAnimator.New(V2a1_BossRush_SpecialScheduleViewListModel.instance, slot5, slot2)
		slot0._specialScheduleView = V2a1_BossRush_SpecialScheduleView.New()

		return {
			MultiView.New({
				slot0._specialScheduleView,
				slot0._specialScheduleScrollView
			}),
			MultiView.New({
				slot0._achievementView,
				slot0._achievementScrollView
			}),
			MultiView.New({
				slot0._scheduleView,
				slot0._scheduleScrollView
			})
		}
	end
end

function slot0.getScrollAnimRemoveItem(slot0, slot1)
	if slot1 == BossRushEnum.BonusViewTab.AchievementTab then
		return ListScrollAnimRemoveItem.Get(slot0._achievementScrollView)
	elseif slot1 == BossRushEnum.BonusViewTab.ScheduleTab then
		return ListScrollAnimRemoveItem.Get(slot0._scheduleScrollView)
	elseif slot1 == BossRushEnum.BonusViewTab.SpecialScheduleTab then
		return ListScrollAnimRemoveItem.Get(slot0._specialScheduleScrollView)
	end
end

function slot0.getTabView(slot0, slot1)
	if slot1 == BossRushEnum.BonusViewTab.AchievementTab then
		return slot0._achievementView
	elseif slot1 == BossRushEnum.BonusViewTab.ScheduleTab then
		return slot0._scheduleView
	elseif slot1 == BossRushEnum.BonusViewTab.SpecialScheduleTab then
		return slot0._specialScheduleView
	end
end

function slot0.selectTabView(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

return slot0
