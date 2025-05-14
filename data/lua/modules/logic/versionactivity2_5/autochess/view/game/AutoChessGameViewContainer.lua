module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameViewContainer", package.seeall)

local var_0_0 = class("AutoChessGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AutoChessGameView.New())
	table.insert(var_1_0, AutoChessGameScene.New())

	return var_1_0
end

return var_0_0
