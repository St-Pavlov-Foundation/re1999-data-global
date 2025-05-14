module("modules.logic.main.view.MainSwitchViewContainer", package.seeall)

local var_0_0 = class("MainSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainSwitchView.New())
	table.insert(var_1_0, TabViewGroupFit.New(1, "#go_container"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 2 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end

	if arg_2_1 == 1 then
		local var_2_0 = {}

		arg_2_0:_addCharacterSwitch(var_2_0)
		arg_2_0:_addSceneSwitch(var_2_0)

		return var_2_0
	end
end

function var_0_0._addCharacterSwitch(arg_3_0, arg_3_1)
	local var_3_0 = {}

	table.insert(var_3_0, CharacterSwitchView.New())

	local var_3_1 = ListScrollParam.New()

	var_3_1.scrollGOPath = "right/mask/#scroll_card"
	var_3_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_1.prefabUrl = arg_3_0._viewSetting.tabRes[1][1][2]
	var_3_1.cellClass = CharacterSwitchItem
	var_3_1.scrollDir = ScrollEnum.ScrollDirV
	var_3_1.lineCount = 3
	var_3_1.cellWidth = 170
	var_3_1.cellHeight = 208
	var_3_1.cellSpaceH = 5
	var_3_1.cellSpaceV = 0
	var_3_1.startSpace = 5
	var_3_1.endSpace = 0
	arg_3_0._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, var_3_1)

	table.insert(var_3_0, arg_3_0._characterScrollView)

	arg_3_1[MainEnum.SwitchType.Character] = MultiView.New(var_3_0)
end

function var_0_0.getCharacterScrollView(arg_4_0)
	return arg_4_0._characterScrollView
end

function var_0_0._addSceneSwitch(arg_5_0, arg_5_1)
	local var_5_0 = {}

	table.insert(var_5_0, MainSceneSwitchDisplayView.New())
	table.insert(var_5_0, MainSceneSwitchView.New())

	local var_5_1 = MixScrollParam.New()

	var_5_1.scrollGOPath = "right/mask/#scroll_card"
	var_5_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_5_1.prefabUrl = arg_5_0._viewSetting.tabRes[1][2][2]
	var_5_1.cellClass = MainSceneSwitchItem
	var_5_1.scrollDir = ScrollEnum.ScrollDirV
	var_5_1.lineCount = 1

	table.insert(var_5_0, LuaMixScrollView.New(MainSceneSwitchListModel.instance, var_5_1))

	arg_5_1[MainEnum.SwitchType.Scene] = MultiView.New(var_5_0)
end

function var_0_0.switchTab(arg_6_0, arg_6_1)
	arg_6_0:dispatchEvent(ViewEvent.ToSwitchTab, 1, arg_6_1)
end

return var_0_0
