module("modules.logic.chessgame.game.interact.ChessInteractObstacle", package.seeall)

local var_0_0 = class("ChessInteractObstacle", ChessInteractBase)

function var_0_0.playBreakAnim(arg_1_0, arg_1_1, arg_1_2)
	logNormal("on playBreakAnim....")

	if arg_1_1 and arg_1_2 then
		arg_1_0:showDestoryAni(arg_1_1, arg_1_2)
	else
		arg_1_0:showDestoryAni(arg_1_0.destroy, arg_1_0)
	end
end

function var_0_0.destroy(arg_2_0)
	if arg_2_0._target.mo:isInCurrentMap() then
		ChessGameController.instance:deleteInteractObj(arg_2_0._target.mo.id)
	end
end

function var_0_0.withCatch(arg_3_0)
	if arg_3_0._target.chessEffectObj and arg_3_0._target.chessEffectObj:getIsLoadEffect() then
		arg_3_0._target.chessEffectObj:hideEffect()
	end
end

return var_0_0
