module("modules.logic.weekwalk.view.WeekWalkTarotViewContainer", package.seeall)

slot0 = class("WeekWalkTarotViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, WeekWalkTarotView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_tarot"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = WeekWalkTarotItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 340
	slot2.cellHeight = 650
	slot2.cellSpaceH = 110.3
	slot2.cellSpaceV = 40
	slot2.startSpace = 10.6
	slot2.endSpace = 20

	table.insert(slot1, LuaListScrollView.New(WeekWalkTarotListModel.instance, slot2))

	return slot1
end

return slot0
