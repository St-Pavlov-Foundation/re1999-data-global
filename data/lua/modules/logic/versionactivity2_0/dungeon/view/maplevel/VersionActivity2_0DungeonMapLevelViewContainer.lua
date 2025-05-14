module("modules.logic.versionactivity2_0.dungeon.view.maplevel.VersionActivity2_0DungeonMapLevelViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapLevelViewContainer", BaseViewContainer)
local var_0_1 = 2

function var_0_0.buildViews(arg_1_0)
	arg_1_0.mapLevelView = VersionActivity2_0DungeonMapLevelView.New()

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

	local var_5_0 = arg_5_0.mapLevelView.animatorPlayer

	if var_5_0 then
		var_5_0:Play(UIAnimationName.Close, arg_5_0.onPlayCloseTransitionFinish, arg_5_0)
	end

	TaskDispatcher.runDelay(arg_5_0.onPlayCloseTransitionFinish, arg_5_0, var_0_1)
end

function var_0_0.onPlayCloseTransitionFinish(arg_6_0)
	SLFramework.AnimatorPlayer.Get(arg_6_0.mapLevelView.goVersionActivity):Stop()
	var_0_0.super.onPlayCloseTransitionFinish(arg_6_0)
end

function var_0_0.stopCloseViewTask(arg_7_0)
	return
end

return var_0_0
