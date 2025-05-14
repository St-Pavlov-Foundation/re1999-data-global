module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapLevelViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapLevelView = VersionActivity1_2DungeonMapLevelView.New()

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
	UIBlockMgr.instance:endBlock(arg_5_0.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(arg_5_0._onOpenAnimDone, arg_5_0)

	arg_5_0._playCloseAnim = true

	UIBlockMgr.instance:startBlock(arg_5_0.viewName .. "ViewCloseAnim")
	SLFramework.AnimatorPlayer.Get(arg_5_0.mapLevelView.goVersionActivity):Play("close", arg_5_0._onCloseAnimDone, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._onCloseAnimDone, arg_5_0, 2)
end

function var_0_0._onCloseAnimDone(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onCloseAnimDone, arg_6_0, 2)
	SLFramework.AnimatorPlayer.Get(arg_6_0.mapLevelView.goVersionActivity):Stop()
	arg_6_0:onPlayCloseTransitionFinish()
end

function var_0_0.stopCloseViewTask(arg_7_0)
	arg_7_0.mapLevelView:cancelStartCloseTask()
end

return var_0_0
