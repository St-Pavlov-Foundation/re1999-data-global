module("modules.logic.room.view.common.RoomThemeFilterViewContainer", package.seeall)

local var_0_0 = class("RoomThemeFilterViewContainer", BaseViewContainer)
local var_0_1 = 386
local var_0_2 = 80
local var_0_3 = 3

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomThemeFilterView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_content/#scroll_theme"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "#go_content/#go_themeitem"
	var_1_1.cellClass = RoomThemeFilterItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = var_0_3
	var_1_1.cellWidth = var_0_1
	var_1_1.cellHeight = var_0_2
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RoomThemeFilterListModel.instance, var_1_1))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

function var_0_0.getUIScreenWidth(arg_3_0)
	local var_3_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_3_0 then
		return recthelper.getWidth(var_3_0.transform)
	end

	local var_3_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_3_1 + 0.5))
end

function var_0_0.layoutContentTrs(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = 1220
	local var_4_1 = arg_4_0:getUIScreenWidth() * 0.5
	local var_4_2 = RoomThemeFilterListModel.instance:getCount()
	local var_4_3 = math.floor((var_4_2 + var_0_3 - 1) / var_0_3) * var_0_2 + 130 + 26

	if arg_4_2 then
		local var_4_4 = 173
		local var_4_5 = -var_4_1 + var_4_4

		recthelper.setAnchorX(arg_4_1, var_4_5)
	else
		local var_4_6 = 46
		local var_4_7 = 668
		local var_4_8 = var_4_1 - var_4_0 - var_4_6
		local var_4_9 = -var_4_1 + var_4_7
		local var_4_10 = math.min(var_4_9, var_4_8)

		recthelper.setHeight(arg_4_1, math.min(var_4_3, 605))
		recthelper.setAnchor(arg_4_1, var_4_10, 85)
	end
end

return var_0_0
