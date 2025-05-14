module("modules.logic.equip.view.EquipTeamViewContainer", package.seeall)

local var_0_0 = class("EquipTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = EquipTeamItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 3
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 210
	var_1_0.cellSpaceH = 28
	var_1_0.cellSpaceV = 10
	var_1_0.startSpace = 13

	return {
		EquipTeamView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LuaListScrollView.New(EquipTeamListModel.instance, var_1_0)
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, arg_2_0._overrideClose)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCloseEquipTeamShowView)
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	arg_4_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

return var_0_0
