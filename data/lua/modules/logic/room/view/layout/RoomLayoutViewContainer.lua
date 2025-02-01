module("modules.logic.room.view.layout.RoomLayoutViewContainer", package.seeall)

slot0 = class("RoomLayoutViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "go_normalroot/#scroll_ItemList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = RoomLayoutItem.prefabUrl
	slot2.cellClass = RoomLayoutItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 2
	slot2.cellWidth = 690
	slot2.cellHeight = 400
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot0._scrollParam = slot2
	slot0._luaScrollView = LuaListScrollView.New(RoomLayoutListModel.instance, slot2)

	table.insert(slot1, slot0._luaScrollView)
	table.insert(slot1, RoomLayoutView.New())

	if not RoomController.instance:isVisitMode() then
		table.insert(slot1, TabViewGroup.New(1, "go_navigatebtn"))
	end

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0.getCsListScroll(slot0)
	return slot0._luaScrollView:getCsListScroll()
end

function slot0.getListScrollParam(slot0)
	return slot0._scrollParam
end

function slot0.movetoSelect(slot0)
	if RoomLayoutListModel.instance:getSelectMO() == nil then
		return
	end

	if slot1:getIndex(slot2) == nil then
		return
	end

	if not slot0._luaScrollView:getCsListScroll() then
		return
	end

	slot8 = recthelper.getWidth(slot4.transform)
	slot4.HorizontalScrollPixel = Mathf.Max(0, Mathf.Max(0, Mathf.Ceil(slot3 / slot0._scrollParam.lineCount) - 1) * (slot0._scrollParam.cellWidth + slot0._scrollParam.cellSpaceH))

	slot4:UpdateCells(false)
end

return slot0
