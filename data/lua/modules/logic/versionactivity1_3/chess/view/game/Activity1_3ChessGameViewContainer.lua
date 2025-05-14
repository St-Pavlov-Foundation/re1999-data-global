module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessGameViewContainer", package.seeall)

local var_0_0 = class("Activity1_3ChessGameViewContainer", BaseViewContainer)
local var_0_1 = "ChessGameViewColseBlockKey"
local var_0_2 = 0.5

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._gameView = Activity1_3ChessGameView.New()

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
			true
		}, HelpEnum.HelpId.VersionActivity_1_3Chess)

		var_2_0:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			var_2_0
		}
	elseif arg_2_1 == 2 then
		return {
			Activity1_3ChessGameScene.New()
		}
	end
end

function var_0_0.onContainerOpen(arg_3_0)
	return
end

function var_0_0.onContainerClose(arg_4_0)
	return
end

function var_0_0.onContainerOpenFinish(arg_5_0)
	arg_5_0._gameView:initCamera()
end

function var_0_0.onContainerClickModalMask(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_6_0:closeThis()
end

function var_0_0.onContainerUpdateParam(arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._setUnitCameraNextFrame, arg_7_0, 0.1)
end

function var_0_0._setUnitCameraNextFrame(arg_8_0)
	Activity1_3ChessGameController.instance:setSceneCamera(true)
end

function var_0_0.overrideOnCloseClick(arg_9_0)
	if Va3ChessGameController.instance:isNeedBlock() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_9_0.closeFunc, nil, nil, arg_9_0)
end

function var_0_0.closeFunc(arg_10_0)
	Stat1_3Controller.instance:bristleStatAbort()
	UIBlockMgr.instance:startBlock(var_0_1)
	arg_10_0._gameView:playCloseAniamtion()
	TaskDispatcher.runDelay(arg_10_0._delayCloseFunc, arg_10_0, var_0_2)
end

function var_0_0._delayCloseFunc(arg_11_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	arg_11_0:closeThis()
end

return var_0_0
