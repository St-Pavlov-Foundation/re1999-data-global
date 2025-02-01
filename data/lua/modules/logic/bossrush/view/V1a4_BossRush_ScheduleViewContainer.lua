module("modules.logic.bossrush.view.V1a4_BossRush_ScheduleViewContainer", package.seeall)

slot0 = class("V1a4_BossRush_ScheduleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.cellClass = V1a4_BossRush_ScheduleItem
	slot1.scrollGOPath = "Root/#scroll_Reward"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 200
	slot1.cellHeight = 700
	slot1.cellSpaceH = 150
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 150
	slot0._listScrollParam = slot1
	slot0._scheduleView = V1a4_BossRush_ScheduleView.New()

	return {
		slot0._scheduleView
	}
end

function slot0.getListScrollParam(slot0)
	return slot0._listScrollParam
end

return slot0
