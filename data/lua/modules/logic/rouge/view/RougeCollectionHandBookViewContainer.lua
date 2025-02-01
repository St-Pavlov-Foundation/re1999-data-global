module("modules.logic.rouge.view.RougeCollectionHandBookViewContainer", package.seeall)

slot0 = class("RougeCollectionHandBookViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "Left/#scroll_collection"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
	slot1.cellClass = RougeCollectionHandBookItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 224
	slot1.cellHeight = 224
	slot1.cellSpaceH = 10
	slot1.cellSpaceV = 0
	slot1.startSpace = 20
	slot1.endSpace = 0
	slot2 = {}

	table.insert(slot2, RougeCollectionHandBookView.New())
	table.insert(slot2, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot2, LuaListScrollView.New(RougeCollectionHandBookListModel.instance, slot1))

	return slot2
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0
