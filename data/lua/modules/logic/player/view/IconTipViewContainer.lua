module("modules.logic.player.view.IconTipViewContainer", package.seeall)

slot0 = class("IconTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "window/left/scrollview"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = IconListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 6
	slot2.cellWidth = 160
	slot2.cellHeight = 160
	slot2.cellSpaceH = 5
	slot2.cellSpaceV = 5
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(IconListModel.instance, slot2))
	table.insert(slot1, IconTipView.New())

	return slot1
end

return slot0
