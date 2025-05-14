module("modules.logic.character.view.CharacterSkinSwitchViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSkinSwitchView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(var_1_0, CharacterSkinSwitchSpineGCView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.on(arg_3_0)
	arg_3_0.navigateView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_skin_close)
end

return var_0_0
