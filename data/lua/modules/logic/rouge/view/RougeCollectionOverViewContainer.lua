module("modules.logic.rouge.view.RougeCollectionOverViewContainer", package.seeall)

slot0 = class("RougeCollectionOverViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollView = slot0:buildScrollView()

	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionOverView.New(),
		slot0._scrollView
	}
end

slot1 = 0.06

function slot0.buildScrollView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_view/Viewport/Content/#go_collectionitem"
	slot1.cellClass = RougeCollectionOverListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 620
	slot1.cellHeight = 190
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = -6
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot2 = {}

	for slot7 = 1, 5 do
		for slot11 = 1, slot1.lineCount do
			slot2[(slot7 - 1) * slot1.lineCount + slot11] = slot7 * uv0
		end
	end

	return LuaListScrollViewWithAnimator.New(RougeCollectionOverListModel.instance, slot1, slot2)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return slot0
