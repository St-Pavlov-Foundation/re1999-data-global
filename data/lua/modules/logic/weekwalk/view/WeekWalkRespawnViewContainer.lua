module("modules.logic.weekwalk.view.WeekWalkRespawnViewContainer", package.seeall)

local var_0_0 = class("WeekWalkRespawnViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#go_rolecontainer/#scroll_card"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = HeroGroupEditItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 5
	var_1_0.cellWidth = 290
	var_1_0.cellHeight = 550
	var_1_0.cellSpaceH = 48
	var_1_0.cellSpaceV = 30
	var_1_0.startSpace = 25

	return {
		LuaListScrollView.New(WeekWalkRespawnModel.instance, var_1_0),
		WeekWalkRespawnView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return var_0_0
