module("modules.logic.seasonver.act123.view1_8.Season123_1_8EpisodeListViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8EpisodeListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.episodeListView = Season123_1_8EpisodeListView.New()

	table.insert(var_1_0, Season123_1_8CheckCloseView.New())
	table.insert(var_1_0, arg_1_0.episodeListView)
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))

	return var_1_0
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
	arg_3_0.episodeListView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterEpiosdeList, false)
	TaskDispatcher.runDelay(arg_3_0._doClose, arg_3_0, 0.17)
end

function var_0_0._doClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onContainerDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._doClose, arg_5_0)
end

return var_0_0
