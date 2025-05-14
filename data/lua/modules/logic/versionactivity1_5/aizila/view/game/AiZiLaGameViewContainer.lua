module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameViewContainer", package.seeall)

local var_0_0 = class("AiZiLaGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameView = AiZiLaGameView.New()

	table.insert(var_1_0, arg_1_0._gameView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0._navigateButtonsView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)
		arg_2_0._navigateButtonsView:setHelpId(HelpEnum.HelpId.Role1_5AiziLa)

		return {
			arg_2_0._navigateButtonsView
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	if arg_3_0._gameView:isLockOp() then
		return
	end

	AiZiLaGameController.instance:exitGame()
end

function var_0_0.needPlayRiseAnim(arg_4_0)
	return arg_4_0._gameView:needPlayRiseAnim()
end

function var_0_0.startViewOpenBlock(arg_5_0)
	return
end

return var_0_0
