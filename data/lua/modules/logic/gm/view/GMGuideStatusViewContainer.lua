module("modules.logic.gm.view.GMGuideStatusViewContainer", package.seeall)

slot0 = class("GMGuideStatusViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "view/scroll/item"
	slot2.cellClass = GMGuideStatusItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 800
	slot2.cellHeight = 60
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0

	table.insert(slot1, GMGuideStatusView.New())
	table.insert(slot1, LuaListScrollView.New(GMGuideStatusModel.instance, slot2))

	return slot1
end

return slot0
