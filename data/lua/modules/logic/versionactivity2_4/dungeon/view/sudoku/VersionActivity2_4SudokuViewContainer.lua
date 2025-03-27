module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuViewContainer", package.seeall)

slot0 = class("VersionActivity2_4SudokuViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, VersionActivity2_4SudokuView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideCloseAction, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0._overrideCloseAction(slot0)
	VersionActivity2_4SudokuController.instance:setStatResult("break")
	VersionActivity2_4SudokuController.instance:sendStat()
	slot0:closeThis()
end

return slot0
