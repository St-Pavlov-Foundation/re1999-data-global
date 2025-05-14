module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailViewContainer", package.seeall)

local var_0_0 = class("AiZiLaEpsiodeDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._detailView = AiZiLaEpsiodeDetailView.New()

	table.insert(var_1_0, arg_1_0._detailView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

function var_0_0.playViewAnimator(arg_4_0, arg_4_1)
	arg_4_0._detailView:playViewAnimator(arg_4_1)
end

return var_0_0
