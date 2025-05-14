module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewContainer", package.seeall)

local var_0_0 = class("Activity130LevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapViewScene = Activity130LevelScene.New()
	arg_1_0._levelView = Activity130LevelView.New()
	arg_1_0._sceneChangeView = Activity130DungeonChange.New()

	table.insert(var_1_0, arg_1_0._mapViewScene)
	table.insert(var_1_0, arg_1_0._levelView)
	table.insert(var_1_0, arg_1_0._sceneChangeView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

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
			true,
			false
		})

		arg_3_0._navigateButtonsView:setOverrideClose(arg_3_0._overrideCloseFunc, arg_3_0)

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_4_0)
	arg_4_0._levelView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_4_0._doClose, arg_4_0, 0.333)
end

function var_0_0._doClose(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.changeLvScene(arg_6_0, arg_6_1)
	arg_6_0._mapViewScene:changeLvScene(arg_6_1)
end

return var_0_0
