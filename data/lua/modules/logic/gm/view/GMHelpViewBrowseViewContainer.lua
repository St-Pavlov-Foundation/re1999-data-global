module("modules.logic.gm.view.GMHelpViewBrowseViewContainer", package.seeall)

slot0 = class("GMHelpViewBrowseViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "view/scroll/item"
	slot2.cellClass = GMHelpViewBrowseItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 962.5
	slot2.cellHeight = 85
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0

	table.insert(slot1, GMHelpViewBrowseView.New())
	table.insert(slot1, LuaListScrollView.New(GMHelpViewBrowseModel.instance, slot2))

	return slot1
end

return slot0
