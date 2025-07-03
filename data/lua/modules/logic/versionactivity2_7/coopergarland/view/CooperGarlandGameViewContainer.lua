module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameViewContainer", package.seeall)

local var_0_0 = class("CooperGarlandGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CooperGarlandGameView.New())
	table.insert(var_1_0, CooperGarlandGameScene.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0.overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.overrideClose(arg_3_0)
	if CooperGarlandGameModel.instance:getIsRemoveMode() then
		CooperGarlandController.instance:changeRemoveMode()
	else
		CooperGarlandController.instance:setStopGame(true)
		GameFacade.showMessageBox(MessageBoxIdDefine.CooperGarlandExitGame, MsgBoxEnum.BoxType.Yes_No, arg_3_0._confirmExit, arg_3_0._closeMessBox, nil, arg_3_0, arg_3_0)
	end
end

function var_0_0._confirmExit(arg_4_0)
	CooperGarlandStatHelper.instance:sendGameExit(ViewName.CooperGarlandGameView)
	arg_4_0.navigateView:_reallyClose()
	CooperGarlandController.instance:exitGame()
end

function var_0_0._closeMessBox(arg_5_0)
	CooperGarlandController.instance:setStopGame(false)
end

return var_0_0
