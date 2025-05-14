module("modules.logic.test.view.TestUIViewContainer", package.seeall)

local var_0_0 = class("TestUIViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TestUIView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			}, nil, function()
				AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_close)
			end)
		}
	end
end

return var_0_0
