module("modules.logic.activity.view.chessmap.Activity109ChessEntryContainer", package.seeall)

local var_0_0 = class("Activity109ChessEntryContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity109ChessEntry.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerOpen(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivityEnum.ActivityId.Act109)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivityEnum.ActivityId.Act109
	})
end

return var_0_0
