module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapLevelViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapLevelView = VersionActivity1_3DungeonMapLevelView.New()

	return {
		arg_1_0.mapLevelView,
		TabViewGroup.New(1, "anim/#go_righttop"),
		TabViewGroup.New(2, "anim/#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Power
			})
		}
	elseif arg_2_1 == 2 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function var_0_0.setOpenedEpisodeId(arg_3_0, arg_3_1)
	arg_3_0.openedEpisodeId = arg_3_1
end

function var_0_0.getOpenedEpisodeId(arg_4_0)
	return arg_4_0.openedEpisodeId
end

function var_0_0.playCloseTransition(arg_5_0)
	arg_5_0:startViewOpenBlock()
	SLFramework.AnimatorPlayer.Get(arg_5_0.mapLevelView.goVersionActivity):Play(UIAnimationName.Close, arg_5_0.onPlayCloseTransitionFinish, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.onPlayCloseTransitionFinish, arg_5_0, 2)
end

function var_0_0.onPlayCloseTransitionFinish(arg_6_0)
	SLFramework.AnimatorPlayer.Get(arg_6_0.mapLevelView.goVersionActivity):Stop()
	var_0_0.super.onPlayCloseTransitionFinish(arg_6_0)
end

function var_0_0.stopCloseViewTask(arg_7_0)
	arg_7_0.mapLevelView:cancelStartCloseTask()
end

return var_0_0
