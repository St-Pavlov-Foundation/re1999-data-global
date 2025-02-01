module("modules.logic.gm.view.GMFightSimulateViewContainer", package.seeall)

slot0 = class("GMFightSimulateViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "leftviewport"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "leftviewport/item"
	slot1.cellClass = GMFightSimulateLeftItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 350
	slot1.cellHeight = 100
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "rightviewport"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "rightviewport/item"
	slot2.cellClass = GMFightSimulateRightItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1000
	slot2.cellHeight = 100
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot3 = {}

	table.insert(slot3, LuaListScrollView.New(GMFightSimulateLeftModel.instance, slot1))
	table.insert(slot3, LuaListScrollView.New(GMFightSimulateRightModel.instance, slot2))
	table.insert(slot3, GMFightSimulateView.New())

	return slot3
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
