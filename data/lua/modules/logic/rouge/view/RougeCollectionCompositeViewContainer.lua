module("modules.logic.rouge.view.RougeCollectionCompositeViewContainer", package.seeall)

slot0 = class("RougeCollectionCompositeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "left/#go_list/ListView"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "left/#go_list/ListView/Viewport/Content/#go_listitem"
	slot1.cellClass = RougeCollectionCompositeListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 2
	slot1.cellWidth = 170
	slot1.cellHeight = 170
	slot1.cellSpaceH = 20
	slot1.cellSpaceV = 0
	slot1.startSpace = 20
	slot1.endSpace = 0
	slot2 = {}

	table.insert(slot2, RougeCollectionCompositeView.New())
	table.insert(slot2, TabViewGroup.New(1, "#go_topleft"))
	table.insert(slot2, TabViewGroup.New(2, "#go_rougemapdetailcontainer"))
	table.insert(slot2, LuaListScrollView.New(RougeCollectionCompositeListModel.instance, slot1))

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
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
