module("modules.logic.sp01.odyssey.view.OdysseyBagViewContainer", package.seeall)

local var_0_0 = class("OdysseyBagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, OdysseyBagView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

	local var_1_1 = {}

	for iter_1_0 = 1, 25 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 5) * 0.03
	end

	local var_1_2 = arg_1_0:getEquipScrollListParam()
	local var_1_3 = LuaListScrollViewWithAnimator.New(OdysseyEquipListModel.instance, var_1_2, var_1_1)

	table.insert(var_1_0, var_1_3)

	local var_1_4 = arg_1_0:getEquipSuitTabListParam()

	table.insert(var_1_0, LuaListScrollView.New(OdysseyEquipSuitTabListModel.instance, var_1_4))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getEquipScrollListParam(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "root/Equip/#scroll_Equip"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = OdysseyEquipItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = arg_3_0:getCurrentBagLineCount()
	var_3_0.cellWidth = 200
	var_3_0.cellHeight = 170
	var_3_0.cellSpaceH = 8
	var_3_0.cellSpaceV = 34
	var_3_0.startSpace = 20
	var_3_0.endSpace = 15

	return var_3_0
end

function var_0_0.getEquipSuitTabListParam(arg_4_0)
	local var_4_0 = ListScrollParam.New()

	var_4_0.scrollGOPath = "root/Equip/#scroll_LeftTab"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_0.prefabUrl = "root/Equip/#scroll_LeftTab/Viewport/Content/#go_TabItem"
	var_4_0.cellClass = OdysseyEquipSuitTabItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.lineCount = 1
	var_4_0.cellWidth = 120
	var_4_0.cellHeight = 80
	var_4_0.cellSpaceH = 0
	var_4_0.cellSpaceV = 18
	var_4_0.startSpace = 19
	var_4_0.endSpace = 20

	return var_4_0
end

function var_0_0.getCurrentBagLineCount(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = arg_5_1 or UnityEngine.Screen.width
	arg_5_2 = arg_5_2 or UnityEngine.Screen.height

	local var_5_0 = 2.39

	return arg_5_1 / arg_5_2 - var_5_0 >= 0.0001 and 6 or 5
end

return var_0_0
