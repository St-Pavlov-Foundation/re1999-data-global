module("modules.logic.versionactivity2_5.liangyue.view.LiangYueGameViewContainer", package.seeall)

local var_0_0 = class("LiangYueGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, LiangYueGameView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.onContainerClose(arg_3_0)
	local var_3_0 = arg_3_0._views[1]

	if var_3_0._isDrag then
		return
	end

	if var_3_0._isFinish == false then
		var_3_0:statData(LiangYueEnum.StatGameState.Exit)
	end
end

return var_0_0
