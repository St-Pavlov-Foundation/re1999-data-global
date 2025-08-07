module("modules.logic.sp01.odyssey.view.OdysseyEquipViewContainer", package.seeall)

local var_0_0 = class("OdysseyEquipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, OdysseySuitListView.New("root"))
	table.insert(var_1_0, OdysseyEquipView.New())

	local var_1_1 = {}

	for iter_1_0 = 1, 20 do
		var_1_1[iter_1_0] = math.ceil((iter_1_0 - 1) % 4) * 0.03
	end

	local var_1_2 = arg_1_0:getEquipScrollListParam()

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(OdysseyEquipListModel.instance, var_1_2, var_1_1))

	local var_1_3 = arg_1_0:getEquipSuitTabListParam()

	table.insert(var_1_0, LuaListScrollView.New(OdysseyEquipSuitTabListModel.instance, var_1_3))

	return var_1_0
end

function var_0_0.getEquipScrollListParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "root/#go_container/#scroll_Equip"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = OdysseyEquipItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 4
	var_2_0.cellWidth = 200
	var_2_0.cellHeight = 200
	var_2_0.cellSpaceH = 12
	var_2_0.cellSpaceV = 16
	var_2_0.startSpace = 25
	var_2_0.endSpace = 0

	return var_2_0
end

function var_0_0.getEquipSuitTabListParam(arg_3_0)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "root/#scroll_LeftTab"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "root/#scroll_LeftTab/Viewport/Content/#go_TabItem"
	var_3_0.cellClass = OdysseyEquipSuitTabItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 120
	var_3_0.cellHeight = 80
	var_3_0.cellSpaceH = 0
	var_3_0.cellSpaceV = 18
	var_3_0.startSpace = 19
	var_3_0.endSpace = 20

	return var_3_0
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		arg_4_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_4_0.navigateView
		}
	end
end

return var_0_0
