module("modules.logic.chessgame.controller.ChessGameJumpHandler", package.seeall)

local var_0_0 = class("ChessGameJumpHandler")

function var_0_0.defaultJump()
	MainController.instance:enterMainScene()
end

return var_0_0
