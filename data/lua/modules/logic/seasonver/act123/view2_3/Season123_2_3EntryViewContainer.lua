module("modules.logic.seasonver.act123.view2_3.Season123_2_3EntryViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3EntryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3EntryView.New(),
		Season123_2_3EntryScene.New(),
		TabViewGroup.New(1, "top_left")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3MainViewHelp)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_7Enum.ActivityId.Season)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_7Enum.ActivityId.Season
	})
end

return var_0_0
