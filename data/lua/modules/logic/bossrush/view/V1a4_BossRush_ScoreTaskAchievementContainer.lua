module("modules.logic.bossrush.view.V1a4_BossRush_ScoreTaskAchievementContainer", package.seeall)

slot0 = class("V1a4_BossRush_ScoreTaskAchievementContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot2 = ListScrollParam.New()
	slot2.cellClass = V1a4_BossRush_ScoreTaskAchievementItem
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.scrollGOPath = "#scroll_ScoreList"
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 964
	slot2.cellHeight = 162
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.sortMode = ScrollEnum.ScrollSortDown
	slot0._scoreTaskAchievement = V1a4_BossRush_ScoreTaskAchievement.New()
	slot0._taskScrollView = LuaListScrollView.New(V1a4_BossRush_ScoreTaskAchievementListModel.instance, slot2)

	return {
		slot0._scoreTaskAchievement,
		slot0._taskScrollView,
		TabViewGroup.New(1, "top_left")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.setActiveBlock(slot0, slot1, slot2)
	if not slot0._scoreTaskAchievement then
		return
	end

	slot0._scoreTaskAchievement:setActiveBlock(slot1, slot2)
end

function slot0.onContainerInit(slot0)
	slot0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._taskScrollView)

	slot0.taskAnimRemoveItem:setMoveInterval(0)
end

return slot0
