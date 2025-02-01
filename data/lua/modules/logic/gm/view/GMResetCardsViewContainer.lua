module("modules.logic.gm.view.GMResetCardsViewContainer", package.seeall)

slot0 = class("GMResetCardsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "viewport1"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "viewport1/item"
	slot1.cellClass = GMResetCardsItem1
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 170
	slot1.cellHeight = 250
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "viewport2"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "viewport2/item"
	slot2.cellClass = GMResetCardsItem2
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 2
	slot2.cellWidth = 170
	slot2.cellHeight = 250
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 20
	slot2.startSpace = 0
	slot3 = {}

	table.insert(slot3, GMResetCardsView.New())
	table.insert(slot3, LuaListScrollView.New(GMResetCardsModel.instance:getModel1(), slot1))
	table.insert(slot3, LuaListScrollView.New(GMResetCardsModel.instance:getModel2(), slot2))

	return slot3
end

return slot0
