module("modules.logic.character.view.CharacterSwitchViewContainer", package.seeall)

local var_0_0 = class("CharacterSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSwitchView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "right/mask/#scroll_card"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = CharacterSwitchItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 170
	var_1_1.cellHeight = 208
	var_1_1.cellSpaceH = 5
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 5
	var_1_1.endSpace = 0
	arg_1_0._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._characterScrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.getCharacterScrollView(arg_2_0)
	return arg_2_0._characterScrollView
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	arg_3_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		arg_3_0.navigationView
	}
end

function var_0_0.on(arg_4_0)
	arg_4_0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

return var_0_0
