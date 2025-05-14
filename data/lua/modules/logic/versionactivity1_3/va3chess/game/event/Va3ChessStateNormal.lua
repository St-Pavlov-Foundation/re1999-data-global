module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateNormal", package.seeall)

local var_0_0 = class("Va3ChessStateNormal", Va3ChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("Va3ChessStateNormal start")
	Va3ChessGameController.instance:resetObjStateOnNewRound()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventStart, arg_1_0:getStateType())
end

function var_0_0.onClickPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1 = Va3ChessGameController.instance:searchInteractByPos(arg_2_1, arg_2_2, Va3ChessGameController.filterSelectable)
	local var_2_2 = Va3ChessGameController.instance:getClickStatus()

	if var_2_2 == Va3ChessEnum.SelectPosStatus.None then
		arg_2_0:onClickInNoneStatus(var_2_0, var_2_1, arg_2_3)
	elseif var_2_2 == Va3ChessEnum.SelectPosStatus.SelectObjWaitPos then
		arg_2_0:onClickInSelectObjWaitPosStatus(arg_2_1, arg_2_2, var_2_0, var_2_1, arg_2_3)
	end
end

function var_0_0.onClickInNoneStatus(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 >= 1 then
		local var_3_0 = arg_3_1 > 1 and arg_3_2[1] or arg_3_2

		if var_3_0.objType ~= Va3ChessEnum.InteractType.Player and var_3_0.objType ~= Va3ChessEnum.InteractType.AssistPlayer then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			Va3ChessGameController.instance:setSelectObj(var_3_0)

			arg_3_0._lastSelectObj = Va3ChessGameController.instance:getSelectObj()
		end
	end
end

function var_0_0.onClickInSelectObjWaitPosStatus(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = Va3ChessGameController.instance:getSelectObj()

	arg_4_0._lastSelectObj = var_4_0

	if var_4_0 and var_4_0:getHandler() then
		if var_4_0:getHandler():onSelectPos(arg_4_1, arg_4_2) then
			arg_4_0:onClickPos(arg_4_1, arg_4_2, arg_4_5)
		end
	else
		logError("select obj missing!")
	end
end

return var_0_0
