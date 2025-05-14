module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordViewContainer", package.seeall)

local var_0_0 = class("AiZiLaRecordViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._equipView = AiZiLaRecordView.New()

	table.insert(var_1_0, arg_1_0._equipView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	return
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

return var_0_0
