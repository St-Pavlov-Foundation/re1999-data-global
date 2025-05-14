module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_4SudokuViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity2_4SudokuView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideCloseAction, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._overrideCloseAction(arg_3_0)
	VersionActivity2_4SudokuController.instance:setStatResult("break")
	VersionActivity2_4SudokuController.instance:sendStat()
	arg_3_0:closeThis()
end

return var_0_0
