module("modules.logic.room.view.critter.RoomCritterTrainViewContainer", package.seeall)

local var_0_0 = class("RoomCritterTrainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return var_0_0.createViewList()
end

function var_0_0.createViewList()
	local var_2_0 = RoomCritterTrainViewDetail.New()
	local var_2_1 = RoomCritterTrainViewSelect.New()
	local var_2_2 = RoomCritterTrainView.New()

	var_2_2.viewDetail = var_2_0
	var_2_2.viewSelect = var_2_1

	return {
		var_2_0,
		var_2_1,
		var_2_2,
		RoomCritterTrainViewAnim.New(),
		var_0_0._createSlotScrollView(),
		var_0_0._createHeroScrollView(),
		var_0_0._createCritterScrollView()
	}
end

function var_0_0._createSlotScrollView()
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "right/#go_slotSub/#scroll_slot"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = RoomTrainSlotItem.prefabPath
	var_3_0.cellClass = RoomTrainSlotItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 300
	var_3_0.cellHeight = 200
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 0

	return (LuaListScrollView.New(RoomTrainSlotListModel.instance, var_3_0))
end

function var_0_0._createHeroScrollView()
	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "right/#go_heroSub/#scroll_hero"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_4_0.prefabUrl = RoomTrainHeroItem.prefabPath
	var_4_0.cellClass = RoomTrainHeroItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.lineCount = 1
	var_4_0.cellWidth = 540
	var_4_0.cellHeight = 184
	var_4_0.cellSpaceH = 0
	var_4_0.cellSpaceV = 8.6
	var_4_0.startSpace = 0
	var_4_0.emptyScrollParam = EmptyScrollParam.New()

	var_4_0.emptyScrollParam:setFromView("right/#go_heroSub/#go_empty")

	return (LuaListScrollView.New(RoomTrainHeroListModel.instance, var_4_0))
end

function var_0_0._createCritterScrollView()
	local var_5_0 = ListScrollParam.New()

	var_5_0.scrollGOPath = "right/#go_critterSub/#scroll_critter"
	var_5_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_5_0.prefabUrl = RoomCritterTrainItem.prefabPath
	var_5_0.cellClass = RoomCritterTrainItem
	var_5_0.scrollDir = ScrollEnum.ScrollDirV
	var_5_0.lineCount = 1
	var_5_0.cellWidth = 540
	var_5_0.cellHeight = 184
	var_5_0.cellSpaceH = 0
	var_5_0.cellSpaceV = 8.6
	var_5_0.startSpace = 14
	var_5_0.emptyScrollParam = EmptyScrollParam.New()

	var_5_0.emptyScrollParam:setFromView("right/#go_critterSub/#go_empty")

	return (LuaListScrollView.New(RoomTrainCritterListModel.instance, var_5_0))
end

return var_0_0
