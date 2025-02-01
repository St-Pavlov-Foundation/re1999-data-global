module("modules.logic.gm.view.GMErrorViewContainer", package.seeall)

slot0 = class("GMErrorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "panel/list/list"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "panel/list/list/Viewport/item"
	slot2.cellClass = GMErrorItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 900
	slot2.cellHeight = 100
	slot2.cellSpaceH = 2
	slot2.cellSpaceV = 0

	table.insert(slot1, GMErrorView.New())
	table.insert(slot1, LuaListScrollView.New(GMLogModel.instance.errorModel, slot2))

	return slot1
end

return slot0
