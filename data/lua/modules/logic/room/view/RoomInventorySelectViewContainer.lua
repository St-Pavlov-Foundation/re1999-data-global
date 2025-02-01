module("modules.logic.room.view.RoomInventorySelectViewContainer", package.seeall)

slot0 = class("RoomInventorySelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.selectView = RoomInventorySelectView.New()
	slot0._listScrollView = slot0:getScrollView()
	slot1 = {
		slot0.selectView,
		slot0._listScrollView
	}

	table.insert(slot1, TabViewGroup.New(1, "blockop_tab"))
	table.insert(slot1, TabViewGroup.New(2, "go_content/go_righttop/go_tabtransprotfail"))
	table.insert(slot1, RoomInventorySelectEffect.New())

	return slot1
end

function slot0.getScrollView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "go_content/scroll_block"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "go_content/#go_item"
	slot1.cellClass = RoomInventorySelectItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 170
	slot1.cellHeight = 231
	slot1.cellSpaceH = 0.5
	slot1.cellSpaceV = 0
	slot1.startSpace = 5

	for slot6 = 1, 12 do
	end

	return LuaListScrollViewWithAnimator.New(RoomShowBlockListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = RoomViewBuilding.New()

		return {
			MultiView.New({
				slot2,
				slot2:getBuildingListView()
			})
		}
	elseif slot1 == 2 then
		return {
			RoomTransportPathFailTips.New()
		}
	end
end

function slot0.switch2BuildingView(slot0, slot1)
	if slot0.selectView then
		slot0.selectView:_btnbuildingOnClick(slot1)
	end
end

return slot0
