module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaLevelViewContainer", package.seeall)

local var_0_0 = class("NuoDiKaLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NuoDiKaLevelView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonsView:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_8Enum.ActivityId.NuoDiKa
	})
end

function var_0_0.overrideOnCloseClick(arg_4_0)
	NuoDiKaModel.instance:setCurEpisode(0, 0)
	arg_4_0:closeThis()
end

return var_0_0
