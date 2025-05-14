module("modules.logic.herogroup.view.EnemyInfoViewContainer", package.seeall)

local var_0_0 = class("EnemyInfoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		EnemyInfoView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0.navigationView:resetCloseBtnAudioId(AudioEnum.HeroGroupUI.Play_UI_Action_Return)
end

return var_0_0
