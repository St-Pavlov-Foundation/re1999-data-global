module("modules.logic.handbook.view.HandBookCharacterSwitchViewContainer", package.seeall)

local var_0_0 = class("HandBookCharacterSwitchViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.navigateHandleView = HandBookCharacterNavigateHandleView.New()

	table.insert(var_1_0, arg_1_0.navigateHandleView)
	table.insert(var_1_0, HandBookCharacterSwitchView.New())
	table.insert(var_1_0, HandBookCharacterView.New())
	table.insert(var_1_0, HandBookCharacterSwitchViewEffect.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.navigateHandleView.onCloseBtnClick, arg_2_0.navigateHandleView)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	arg_3_0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return var_0_0
