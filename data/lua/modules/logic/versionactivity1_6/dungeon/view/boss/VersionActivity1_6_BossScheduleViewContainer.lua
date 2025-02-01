module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossScheduleViewContainer", package.seeall)

slot0 = class("VersionActivity1_6_BossScheduleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.cellClass = VersionActivity1_6_BossScheduleItem
	slot1.scrollGOPath = "Root/#scroll_Reward"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 200
	slot1.cellHeight = 700
	slot1.cellSpaceH = 100
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 300
	slot0._listScrollParam = slot1
	slot0._scheduleView = VersionActivity1_6_BossScheduleView.New()

	return {
		slot0._scheduleView
	}
end

function slot0.getListScrollParam(slot0)
	return slot0._listScrollParam
end

return slot0
