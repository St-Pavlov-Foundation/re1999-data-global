module("modules.logic.chessgame.game.step.ChessCheckIsCatch", package.seeall)

local var_0_0 = class("ChessCheckIsCatch", BaseWork)

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:checkIsCatchObj(arg_2_1)
end

function var_0_0.checkIsCatchObj(arg_3_0, arg_3_1)
	if arg_3_1 then
		if not ChessGameInteractModel.instance:getInteractById(arg_3_1.mo.id) then
			local var_3_0 = ChessGameController.instance.interactsMgr:getMainPlayer()
			local var_3_1, var_3_2 = var_3_0.mo:getXY()

			var_3_0:getHandler():moveTo(var_3_1, var_3_2, arg_3_0.afterReturnBack, arg_3_0)
		else
			ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
				visible = false
			})
			ChessGameController.instance:autoSelectPlayer()

			local var_3_3 = ChessGameController.instance.interactsMgr:getMainPlayer()

			if var_3_3 then
				var_3_3:getHandler():_refreshNodeArea()
				arg_3_1:getHandler():withCatch()
				ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.CatchObj)
				arg_3_0:onDone(true)
			else
				arg_3_0:onDone(true)
			end
		end
	else
		arg_3_0:onDone(true)
	end
end

function var_0_0.afterReturnBack(arg_4_0)
	local var_4_0 = ChessGameController.instance.interactsMgr:getMainPlayer()

	var_4_0:getHandler():calCanWalkArea()

	local var_4_1 = var_4_0.mo:getDirection()

	var_4_0:getHandler():faceTo(var_4_1)
	arg_4_0:onDone(true)
end

return var_0_0
