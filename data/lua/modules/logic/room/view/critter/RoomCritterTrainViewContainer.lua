module("modules.logic.room.view.critter.RoomCritterTrainViewContainer", package.seeall)

slot0 = class("RoomCritterTrainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return uv0.createViewList()
end

function slot0.createViewList()
	slot0 = RoomCritterTrainViewDetail.New()
	slot1 = RoomCritterTrainViewSelect.New()
	slot2 = RoomCritterTrainView.New()
	slot2.viewDetail = slot0
	slot2.viewSelect = slot1

	return {
		slot0,
		slot1,
		slot2,
		RoomCritterTrainViewAnim.New(),
		uv0._createSlotScrollView(),
		uv0._createHeroScrollView(),
		uv0._createCritterScrollView()
	}
end

function slot0._createSlotScrollView()
	slot0 = ListScrollParam.New()
	slot0.scrollGOPath = "right/#go_slotSub/#scroll_slot"
	slot0.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot0.prefabUrl = RoomTrainSlotItem.prefabPath
	slot0.cellClass = RoomTrainSlotItem
	slot0.scrollDir = ScrollEnum.ScrollDirV
	slot0.lineCount = 1
	slot0.cellWidth = 300
	slot0.cellHeight = 200
	slot0.cellSpaceH = 0
	slot0.cellSpaceV = 0
	slot0.startSpace = 0

	return LuaListScrollView.New(RoomTrainSlotListModel.instance, slot0)
end

function slot0._createHeroScrollView()
	slot0 = ListScrollParam.New()
	slot0.scrollGOPath = "right/#go_heroSub/#scroll_hero"
	slot0.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot0.prefabUrl = RoomTrainHeroItem.prefabPath
	slot0.cellClass = RoomTrainHeroItem
	slot0.scrollDir = ScrollEnum.ScrollDirV
	slot0.lineCount = 1
	slot0.cellWidth = 540
	slot0.cellHeight = 184
	slot0.cellSpaceH = 0
	slot0.cellSpaceV = 8.6
	slot0.startSpace = 0
	slot0.emptyScrollParam = EmptyScrollParam.New()

	slot0.emptyScrollParam:setFromView("right/#go_heroSub/#go_empty")

	return LuaListScrollView.New(RoomTrainHeroListModel.instance, slot0)
end

function slot0._createCritterScrollView()
	slot0 = ListScrollParam.New()
	slot0.scrollGOPath = "right/#go_critterSub/#scroll_critter"
	slot0.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot0.prefabUrl = RoomCritterTrainItem.prefabPath
	slot0.cellClass = RoomCritterTrainItem
	slot0.scrollDir = ScrollEnum.ScrollDirV
	slot0.lineCount = 1
	slot0.cellWidth = 540
	slot0.cellHeight = 184
	slot0.cellSpaceH = 0
	slot0.cellSpaceV = 8.6
	slot0.startSpace = 14
	slot0.emptyScrollParam = EmptyScrollParam.New()

	slot0.emptyScrollParam:setFromView("right/#go_critterSub/#go_empty")

	return LuaListScrollView.New(RoomTrainCritterListModel.instance, slot0)
end

return slot0
