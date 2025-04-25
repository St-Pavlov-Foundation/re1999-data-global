module("modules.logic.gm.view.GMLangTxtViewContainer", package.seeall)

slot0 = class("GMLangTxtViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "view/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "view/scroll/item"
	slot2.cellClass = GMLangTxtItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 800
	slot2.cellHeight = 60
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot0._langTxtView = GMLangTxtView.New()

	table.insert(slot1, slot0._langTxtView)
	table.insert(slot1, LuaListScrollView.New(GMLangTxtModel.instance, slot2))

	return slot1
end

function slot0.onLangTxtClick(slot0, slot1)
	slot0._langTxtView:onLangTxtClick(slot1)
end

return slot0
