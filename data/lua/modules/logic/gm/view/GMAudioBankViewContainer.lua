module("modules.logic.gm.view.GMAudioBankViewContainer", package.seeall)

slot0 = class("GMAudioBankViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "view/scroll/item"
	slot2.cellClass = GMAudioBankViewItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 962.5
	slot2.cellHeight = 85
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0

	table.insert(slot1, GMAudioBankView.New())
	table.insert(slot1, LuaListScrollView.New(GMAudioBankViewModel.instance, slot2))

	return slot1
end

return slot0
