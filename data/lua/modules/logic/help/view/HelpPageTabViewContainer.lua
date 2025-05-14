module("modules.logic.help.view.HelpPageTabViewContainer", package.seeall)

local var_0_0 = class("HelpPageTabViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._helpPageTabView = HelpPageTabView.New()

	return {
		arg_1_0._helpPageTabView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_helpview"),
		TabViewGroup.New(3, "#go_voidepage")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonsView
		}
	elseif arg_2_1 == 2 then
		return {
			HelpPageHelpView.New()
		}
	elseif arg_2_1 == 3 then
		return {
			HelpPageVideoView.New()
		}
	end
end

function var_0_0.setBtnShow(arg_3_0, arg_3_1)
	if arg_3_0._navigateButtonsView then
		arg_3_0._navigateButtonsView:setParam({
			arg_3_1,
			arg_3_1,
			false
		})
	end
end

function var_0_0.setVideoFullScreen(arg_4_0, arg_4_1)
	if arg_4_0._helpPageTabView then
		arg_4_0._helpPageTabView:setVideoFullScreen(arg_4_1)
	end
end

function var_0_0.checkHelpPageCfg(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 then
		return false
	end

	if arg_5_2 then
		if HelpController.instance:canShowPage(arg_5_1) or arg_5_1.unlockGuideId == arg_5_0._matchGuideId then
			return true
		end
	elseif arg_5_3 then
		if arg_5_1.unlockGuideId == arg_5_3 then
			return true
		end
	elseif HelpController.instance:canShowPage(arg_5_1) then
		return true
	end

	return false
end

function var_0_0.checkHelpVideoCfg(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 then
		return false
	end

	if arg_6_2 then
		if HelpController.instance:canShowVideo(arg_6_1) or arg_6_1.unlockGuideId == arg_6_0._matchGuideId then
			return true
		end
	elseif arg_6_3 then
		if arg_6_1.unlockGuideId == arg_6_3 then
			return true
		end
	elseif HelpController.instance:canShowVideo(arg_6_1) then
		return true
	end

	return false
end

return var_0_0
