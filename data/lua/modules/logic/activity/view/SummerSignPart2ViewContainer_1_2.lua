module("modules.logic.activity.view.SummerSignPart2ViewContainer_1_2", package.seeall)

slot0 = class("SummerSignPart2ViewContainer_1_2", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_daylist/#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ActivityNorSignItem_1_2
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 7
	slot2.cellWidth = 200
	slot2.cellHeight = 590
	slot2.cellSpaceH = 4.1
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(ActivityNorSignItemListModel_1_2.instance, slot2))
	table.insert(slot1, SummerSignPart2View_1_2.New())

	return slot1
end

return slot0
