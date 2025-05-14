module("modules.logic.room.view.RoomBlockPackageViewContainer", package.seeall)

local var_0_0 = class("RoomBlockPackageViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomBlockPackageView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "middle/#scroll_detailed"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "middle/cloneItem/#go_detailedItem"
	var_1_1.cellClass = RoomBlockPackageDetailedItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 298
	var_1_1.cellHeight = 360
	var_1_1.cellSpaceH = 70
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 26

	table.insert(var_1_0, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, var_1_1))

	local var_1_2 = arg_1_0:getUIScreenWidth() - 182 - 46 - 10 - 10
	local var_1_3 = 380
	local var_1_4 = math.floor(var_1_2 / var_1_3)
	local var_1_5 = 0
	local var_1_6 = math.max(var_1_4, 1)

	if var_1_6 > 1 then
		var_1_5 = (var_1_2 - var_1_3 * var_1_6) / var_1_6
		var_1_5 = math.max(0, var_1_5)
	end

	local var_1_7 = ListScrollParam.New()

	var_1_7.scrollGOPath = "middle/#scroll_simple"
	var_1_7.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_7.prefabUrl = "middle/cloneItem/#go_simpleItem"
	var_1_7.cellClass = RoomBlockPackageSimpleItem
	var_1_7.scrollDir = ScrollEnum.ScrollDirV
	var_1_7.lineCount = var_1_6
	var_1_7.cellWidth = var_1_3
	var_1_7.cellHeight = 105
	var_1_7.cellSpaceH = var_1_5
	var_1_7.cellSpaceV = 10
	var_1_7.startSpace = 10

	table.insert(var_1_0, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, var_1_7))

	return var_1_0
end

function var_0_0.getUIScreenWidth(arg_2_0)
	local var_2_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_2_0 then
		return recthelper.getWidth(var_2_0.transform)
	end

	local var_2_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_2_1 + 0.5))
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return var_0_0
