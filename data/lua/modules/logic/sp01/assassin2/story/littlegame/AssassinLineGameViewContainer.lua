module("modules.logic.sp01.assassin2.story.littlegame.AssassinLineGameViewContainer", package.seeall)

local var_0_0 = class("AssassinLineGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinLineGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))

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
	arg_3_0:stat(StatEnum.Result.Abort)
	arg_3_0:closeThis()
end

function var_0_0.onContainerOpenFinish(arg_4_0)
	var_0_0.super.onContainerOpenFinish(arg_4_0)

	arg_4_0._startTime = Time.realtimeSinceStartup
	arg_4_0._episodeId = arg_4_0.viewParam and arg_4_0.viewParam.episodeId
end

function var_0_0.stat(arg_5_0, arg_5_1)
	StatController.instance:track(StatEnum.EventName.S01_mini_game, {
		[StatEnum.EventProperties.UseTime] = Mathf.Floor(Time.realtimeSinceStartup - arg_5_0._startTime),
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_5_0._episodeId),
		[StatEnum.EventProperties.Result] = StatEnum.Result2Cn[arg_5_1]
	})
end

return var_0_0
