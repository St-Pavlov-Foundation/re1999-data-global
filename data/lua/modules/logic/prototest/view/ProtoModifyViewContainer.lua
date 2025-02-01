module("modules.logic.prototest.view.ProtoModifyViewContainer", package.seeall)

slot0 = class("ProtoModifyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "paramlistpanel/paramscroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "paramlistpanel/paramscroll/Viewport/item"
	slot2.cellClass = ProtoModifyListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 667
	slot2.cellHeight = 75
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0

	table.insert(slot1, LuaListScrollView.New(ProtoModifyModel.instance, slot2))
	table.insert(slot1, ProtoModifyView.New())

	return slot1
end

return slot0
