module("modules.logic.achievement.view.AchievementEntryViewContainer", package.seeall)

local var_0_0 = class("AchievementEntryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AchievementEntryView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, arg_2_0.closeCallback)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.closeCallback(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_close)
end

return var_0_0
