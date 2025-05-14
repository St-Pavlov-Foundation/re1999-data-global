module("modules.logic.character.view.CharacterRankUpResultViewContainer", package.seeall)

local var_0_0 = class("CharacterRankUpResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterRankUpResultView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return var_0_0
