module("modules.logic.activity.view.ActivityNoviceSignViewContainer", package.seeall)

slot0 = class("ActivityNoviceSignViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_daylist/#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ActivityNoviceSignItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 190
	slot2.cellHeight = 520
	slot2.cellSpaceH = 3.16
	slot2.cellSpaceV = 0
	slot2.startSpace = 5

	table.insert(slot1, LuaListScrollView.New(ActivityNoviceSignItemListModel.instance, slot2))
	table.insert(slot1, ActivityNoviceSignView.New())

	return slot1
end

return slot0
