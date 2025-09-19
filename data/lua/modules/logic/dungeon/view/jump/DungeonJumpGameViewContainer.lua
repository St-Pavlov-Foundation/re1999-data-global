module("modules.logic.dungeon.view.jump.DungeonJumpGameViewContainer", package.seeall)

local var_0_0 = class("DungeonJumpGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._gameView = DungeonJumpGameView.New()

	return {
		arg_1_0._gameView,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0.overrideCloseFunc, arg_2_0)
		arg_2_0._navigateButtonView:setOverrideHome(arg_2_0.onClickHome, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.overrideCloseFunc(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, arg_3_0.closeFunc, nil, nil, arg_3_0)
end

function var_0_0.closeFunc(arg_4_0)
	local var_4_0 = arg_4_0._gameView:getCurCellIdx()

	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[3], var_4_0)
	DungeonJumpGameController.instance:ClearProgress()
	arg_4_0:closeThis()
end

function var_0_0.onClickHome(arg_5_0)
	local var_5_0 = arg_5_0._gameView:getCurCellIdx()

	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[3], var_5_0)
	NavigateButtonsView.homeClick()
end

return var_0_0
