module("modules.logic.room.view.interact.RoomInteractBuildingViewContainer", package.seeall)

slot0 = class("RoomInteractBuildingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._interactView = RoomInteractBuildingView.New()

	table.insert(slot1, slot0._interactView)
	table.insert(slot1, TabViewGroup.New(1, "#go_BackBtns"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_right/#go_hero/#scroll_hero"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = RoomInteractCharacterItem.prefabUrl
	slot2.cellClass = RoomInteractCharacterItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.cellWidth = 200
	slot2.lineCount = 3
	slot2.cellHeight = 205
	slot2.cellSpaceH = 5
	slot2.cellSpaceV = 4.6
	slot2.startSpace = 10
	slot2.emptyScrollParam = EmptyScrollParam.New()

	slot2.emptyScrollParam:setFromView("#go_right/#go_hero/#go_empty")
	table.insert(slot1, LuaListScrollView.New(RoomInteractCharacterListModel.instance, slot2))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setCloseCheck(slot0._navigateCloseView, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._navigateCloseView(slot0)
	if slot0._interactView then
		slot0._interactView:goBackClose()
	else
		slot0:closeThis()
	end
end

return slot0
