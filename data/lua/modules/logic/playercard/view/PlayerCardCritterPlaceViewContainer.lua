module("modules.logic.playercard.view.PlayerCardCritterPlaceViewContainer", package.seeall)

local var_0_0 = class("PlayerCardCritterPlaceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PlayerCardCritterPlaceView.New())

	local var_1_1 = arg_1_0:getScrollParam1()
	local var_1_2 = arg_1_0:getScrollParam2()
	local var_1_3 = LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, var_1_1)
	local var_1_4 = LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, var_1_2)

	table.insert(var_1_0, var_1_3)
	table.insert(var_1_0, var_1_4)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getScrollParam1(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "#go_critterview1/critterscroll"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	var_3_0.cellClass = PlayerCardCritterPlaceItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.cellWidth = 150
	var_3_0.cellHeight = 200
	var_3_0.cellSpaceH = 30
	var_3_0.startSpace = 30

	return var_3_0
end

function var_0_0.getScrollParam2(arg_4_0)
	local var_4_0 = "#go_critterview2/critterscroll"
	local var_4_1 = arg_4_0:_getScrollWidth(var_4_0)
	local var_4_2 = ListScrollParam.New()

	var_4_2.scrollGOPath = var_4_0
	var_4_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_2.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	var_4_2.cellClass = PlayerCardCritterPlaceItem
	var_4_2.scrollDir = ScrollEnum.ScrollDirV
	var_4_2.cellWidth = 180
	var_4_2.cellHeight = 150
	var_4_2.lineCount = arg_4_0:_getLineCount(var_4_1, var_4_2.cellWidth)
	var_4_2.cellSpaceV = 20
	var_4_2.startSpace = 10

	return var_4_2
end

function var_0_0._getScrollWidth(arg_5_0, arg_5_1)
	local var_5_0 = gohelper.findChildComponent(arg_5_0.viewGO, arg_5_1, gohelper.Type_Transform)

	if var_5_0 then
		return recthelper.getWidth(var_5_0)
	end

	local var_5_1 = 1080 / UnityEngine.Screen.height

	return (math.floor(UnityEngine.Screen.width * var_5_1 + 0.5))
end

function var_0_0._getLineCount(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = math.floor(arg_6_1 / arg_6_2)

	return (math.max(var_6_0, 1))
end

return var_0_0
