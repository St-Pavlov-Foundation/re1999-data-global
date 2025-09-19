module("modules.logic.dungeon.view.maze.DungeonMazeViewContainer", package.seeall)

local var_0_0 = class("DungeonMazeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_topleft"),
		DungeonMazeWordEffectView.New(),
		DungeonMazeView.New()
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
	local var_4_0 = DungeonMazeModel.instance:getCurCellData()
	local var_4_1 = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[3], var_4_0.cellId, var_4_1)
	DungeonMazeModel.instance:ClearProgress()
	arg_4_0:closeThis()
end

function var_0_0.onClickHome(arg_5_0)
	local var_5_0 = DungeonMazeModel.instance:getCurCellData()
	local var_5_1 = DungeonMazeModel.instance:getChaosValue()

	DungeonMazeController.instance:sandStatData(DungeonMazeEnum.resultStat[3], var_5_0.cellId, var_5_1)
	NavigateButtonsView.homeClick()
end

return var_0_0
