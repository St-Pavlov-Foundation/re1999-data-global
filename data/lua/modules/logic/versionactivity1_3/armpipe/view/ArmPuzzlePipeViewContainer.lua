module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipeViewContainer", package.seeall)

local var_0_0 = class("ArmPuzzlePipeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._pipes = ArmPuzzlePipes.New()

	return {
		ArmPuzzlePipeView.New(),
		arg_1_0._pipes,
		ArmPuzzlePipePieceView.New(),
		TabViewGroup.New(1, "#go_BackBtns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		false,
		true
	}, HelpEnum.HelpId.VersionActivity_1_3_LeftHand)

	var_2_0:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)

	return {
		var_2_0
	}
end

function var_0_0.onContainerInit(arg_3_0)
	Stat1_3Controller.instance:armPuzzleStatStart()
end

function var_0_0.getPipesXYByPostion(arg_4_0, arg_4_1)
	return arg_4_0._pipes:getXYByPostion(arg_4_1)
end

function var_0_0.getPipes(arg_5_0)
	return arg_5_0._pipes
end

function var_0_0.overrideCloseFunc(arg_6_0)
	Stat1_3Controller.instance:puzzleStatAbort()
	arg_6_0:closeThis()
end

return var_0_0
