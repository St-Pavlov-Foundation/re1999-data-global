module("modules.logic.chessgame.controller.ChessGameJumpHandler", package.seeall)

slot0 = class("ChessGameJumpHandler")

function slot0.defaultJump()
	MainController.instance:enterMainScene()
end

return slot0
