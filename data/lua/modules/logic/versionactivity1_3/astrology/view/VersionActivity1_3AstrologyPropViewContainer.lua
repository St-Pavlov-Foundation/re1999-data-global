module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPropViewContainer", package.seeall)

slot0 = class("VersionActivity1_3AstrologyPropViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = CommonPropListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 270
	slot2.cellHeight = 250
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 50
	slot2.startSpace = 35
	slot2.endSpace = 56

	table.insert(slot1, LuaListScrollView.New(CommonPropListModel.instance, slot2))
	table.insert(slot1, VersionActivity1_3AstrologyPropView.New())

	return slot1
end

return slot0
