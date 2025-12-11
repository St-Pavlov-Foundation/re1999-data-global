module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupViewContainer", package.seeall)

local var_0_0 = class("Act191HeroGroupViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.groupView = Act191HeroGroupView.New()

	table.insert(var_1_0, arg_1_0.groupView)

	arg_1_0.groupListView = Act191HeroGroupListView.New()

	table.insert(var_1_0, arg_1_0.groupListView)
	table.insert(var_1_0, CheckActivityEndView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, arg_2_0._closeCallback, nil, nil, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act191MainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView()
		end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3)
	end)
end

function var_0_0.playOpenTransition(arg_6_0)
	arg_6_0.groupView.anim:Play("open", 0, 0)
	arg_6_0.groupListView.animSwitch:Play("open", 0, 0)
	TaskDispatcher.runDelay(arg_6_0.onPlayOpenTransitionFinish, arg_6_0, 0.33)
end

function var_0_0.playCloseTransition(arg_7_0)
	arg_7_0.groupView.anim:Play("close", 0, 0)
	arg_7_0.groupListView.animSwitch:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_7_0.onPlayCloseTransitionFinish, arg_7_0, 0.16)
end

function var_0_0.onContainerDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onPlayOpenTransitionFinish, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onPlayCloseTransitionFinish, arg_8_0)
end

return var_0_0
