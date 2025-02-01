module("modules.logic.rouge.view.RougeFavoriteCollectionViewContainer", package.seeall)

slot0 = class("RougeFavoriteCollectionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeFavoriteCollectionView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(slot1, TabViewGroup.New(2, "#go_content"))
	table.insert(slot1, TabViewGroup.New(3, "#go_rougemapdetailcontainer"))

	return slot1
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

	if slot1 == 2 then
		slot2 = MixScrollParam.New()
		slot2.scrollGOPath = "Left/#scroll_collection"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = RougeCollectionListRow
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.startSpace = 0
		slot2.endSpace = 0
		slot3 = ListScrollParam.New()
		slot3.scrollGOPath = "Left/#scroll_collection"
		slot3.prefabType = ScrollEnum.ScrollPrefabFromView
		slot3.prefabUrl = "Left/#scroll_collection/Viewport/Content/#go_collectionitem"
		slot3.cellClass = RougeCollectionHandBookItem
		slot3.scrollDir = ScrollEnum.ScrollDirV
		slot3.lineCount = 4
		slot3.cellWidth = 224
		slot3.cellHeight = 224
		slot3.cellSpaceH = 10
		slot3.cellSpaceV = 0
		slot3.startSpace = 61
		slot3.endSpace = 0
		slot4 = ListScrollParam.New()
		slot4.scrollGOPath = "Right/#go_normal/bottom/scrollview"
		slot4.prefabType = ScrollEnum.ScrollPrefabFromView
		slot4.prefabUrl = "Right/#go_normal/bottom/scrollview/Viewport/Content/Item"
		slot4.cellClass = RougeCollectionListDropdownItem
		slot4.scrollDir = ScrollEnum.ScrollDirV
		slot4.lineCount = 1
		slot4.cellWidth = 200
		slot4.cellHeight = 120
		slot4.cellSpaceH = 0
		slot4.cellSpaceV = 0
		slot4.startSpace = 20
		slot4.endSpace = 0
		slot0._dropDownView = RougeCollectionListDropdownView.New()
		slot0._collectinListView = RougeCollectionListView.New()

		return {
			MultiView.New({
				LuaListScrollView.New(RougeFavoriteCollectionEnchantListModel.instance, slot4),
				slot0._dropDownView,
				slot0._collectinListView,
				LuaMixScrollView.New(RougeCollectionListModel.instance, slot2)
			}),
			MultiView.New({
				RougeCollectionHandBookView.New(),
				LuaListScrollView.New(RougeCollectionHandBookListModel.instance, slot3)
			})
		}
	end

	if slot1 == 3 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function slot0.getDropDownView(slot0)
	return slot0._dropDownView
end

function slot0.getCollectionListView(slot0)
	return slot0._collectinListView
end

function slot0.selectTabView(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

return slot0
