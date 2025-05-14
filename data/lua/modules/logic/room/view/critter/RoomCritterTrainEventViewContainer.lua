module("modules.logic.room.view.critter.RoomCritterTrainEventViewContainer", package.seeall)

local var_0_0 = class("RoomCritterTrainEventViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RoomCritterTrainEventView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0._onCurrencyOpen(arg_3_0)
	logError("_onCurrencyOpen")
end

return var_0_0
