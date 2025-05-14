module("modules.logic.versionactivity1_5.act142.view.game.Activity142GameViewContainer", package.seeall)

local var_0_0 = class("Activity142GameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameView = Activity142GameView.New()

	table.insert(var_1_0, arg_1_0._gameView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(var_1_0, TabViewGroup.New(2, "gamescene"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		var_2_0:setHelpId(HelpEnum.HelpId.Activity142)
		var_2_0:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			var_2_0
		}
	elseif arg_2_1 == 2 then
		return {
			Activity142GameScene.New()
		}
	end
end

function var_0_0.overrideOnCloseClick(arg_3_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_3_0.yesCloseView, nil, nil, arg_3_0)
end

function var_0_0.yesCloseView(arg_4_0)
	Activity142StatController.instance:statAbort()
	arg_4_0:closeThis()
end

return var_0_0
