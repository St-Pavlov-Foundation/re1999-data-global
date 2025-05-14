module("modules.logic.versionactivity1_3.va3chess.view.Va3ChessGameSceneContainer", package.seeall)

local var_0_0 = class("Va3ChessGameSceneContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Va3ChessGameScene.New())

	return var_1_0
end

return var_0_0
