module("modules.logic.room.view.RoomCharacterPlaceViewContainer", package.seeall)

local var_0_0 = class("RoomCharacterPlaceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCharacterPlaceView.New())
	table.insert(var_1_0, RoomViewTopRight.New("#go_topright", arg_1_0._viewSetting.otherRes[2], {
		{
			classDefine = RoomViewTopRightCharacterItem
		}
	}))
	arg_1_0:_buildCharacterPlaceListView1(var_1_0)
	arg_1_0:_buildCharacterPlaceListView2(var_1_0)

	return var_1_0
end

function var_0_0._buildCharacterPlaceListView1(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#go_roleview1/rolescroll"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = RoomCharacterPlaceItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.cellWidth = 200

	local var_2_1 = arg_2_0:_getUIScreenWidth() - 44.22 - 39.48 - 20

	var_2_0.lineCount = 1
	var_2_0.cellHeight = 225
	var_2_0.cellSpaceH = arg_2_0:_getCellSpace(var_2_1, var_2_0.lineCount, var_2_0.cellWidth)
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 10
	arg_2_0._characterPlaceScrollView1 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, var_2_0)

	table.insert(arg_2_1, arg_2_0._characterPlaceScrollView1)
end

function var_0_0._buildCharacterPlaceListView2(arg_3_0, arg_3_1)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#go_roleview2/rolescroll"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = RoomCharacterPlaceItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.cellWidth = 200

	local var_3_1 = arg_3_0:_getUIScreenWidth() - 44.22 - 39.48 - 20

	var_3_0.lineCount = arg_3_0:_getLineCount(var_3_1, var_3_0.cellWidth)
	var_3_0.cellHeight = 205
	var_3_0.cellSpaceH = arg_3_0:_getCellSpace(var_3_1, var_3_0.lineCount, var_3_0.cellWidth)
	var_3_0.cellSpaceV = 4.6
	var_3_0.startSpace = 10
	arg_3_0._characterPlaceScrollView2 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, var_3_0)

	table.insert(arg_3_1, arg_3_0._characterPlaceScrollView2)
end

function var_0_0._getLineCount(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = math.floor(arg_4_1 / arg_4_2)

	return (math.max(var_4_0, 1))
end

function var_0_0._getCellSpace(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = 7

	if arg_5_2 > 1 then
		var_5_0 = (arg_5_1 - arg_5_3 * arg_5_2 + 48) / arg_5_2
		var_5_0 = math.max(0, var_5_0)
	end

	return var_5_0
end

function var_0_0._getUIScreenWidth(arg_6_0)
	local var_6_0 = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP")

	if var_6_0 then
		return recthelper.getWidth(var_6_0.transform)
	end

	local var_6_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_6_1 + 0.5))
end

return var_0_0
