module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameViewContainer", package.seeall)

local var_0_0 = class("LanShouPaGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, LanShouPaGameView.New())
	table.insert(var_1_0, LanShouPaGameScene.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		local var_3_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_3_0:setOverrideClose(arg_3_0._overrideCloseFunc, arg_3_0)

		return {
			var_3_0
		}
	end
end

function var_0_0._overrideCloseFunc(arg_4_0)
	ChessGameController.instance:release()
	arg_4_0:closeThis()
end

function var_0_0._onEscape(arg_5_0)
	arg_5_0:_overrideCloseFunc()
end

function var_0_0.setRootSceneGo(arg_6_0, arg_6_1)
	arg_6_0.sceneGo = arg_6_1
end

function var_0_0.getRootSceneGo(arg_7_0)
	return arg_7_0.sceneGo
end

return var_0_0
