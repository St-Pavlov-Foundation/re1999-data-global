module("modules.logic.versionactivity1_4.act131.view.Activity131GameViewContainer", package.seeall)

local var_0_0 = class("Activity131GameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._act131GameView = Activity131GameView.New()

	return {
		arg_1_0._act131GameView,
		Activity131Map.New(),
		TabViewGroup.New(1, "#go_topbtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	arg_3_0._act131GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_3_0._doClose, arg_3_0, 0.167)
end

function var_0_0._doClose(arg_4_0)
	arg_4_0:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

return var_0_0
