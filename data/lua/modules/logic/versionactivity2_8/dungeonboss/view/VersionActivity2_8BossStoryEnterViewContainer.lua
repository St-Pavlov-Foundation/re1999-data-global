module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossStoryEnterViewContainer", package.seeall)

local var_0_0 = class("VersionActivity2_8BossStoryEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapScene = VersionActivity2_8BossStorySceneView.New()

	table.insert(var_1_0, VersionActivity2_8BossStoryEnterView.New())
	table.insert(var_1_0, arg_1_0._mapScene)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

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

function var_0_0.setVisibleInternal(arg_3_0, arg_3_1)
	var_0_0.super.setVisibleInternal(arg_3_0, arg_3_1)

	if arg_3_0._mapScene then
		arg_3_0._mapScene:setSceneVisible(arg_3_1)
	end
end

return var_0_0
