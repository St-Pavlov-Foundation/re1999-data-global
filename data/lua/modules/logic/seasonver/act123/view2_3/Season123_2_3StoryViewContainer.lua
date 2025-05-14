module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3StoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3StoryView.New(),
		TabViewGroup.New(1, "#go_LeftTop")
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
	arg_3_0._views[1]._animView:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_3_0._doCloseView, arg_3_0, 0.333)
end

function var_0_0._doCloseView(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onContainerDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._doCloseView, arg_5_0)
end

return var_0_0
