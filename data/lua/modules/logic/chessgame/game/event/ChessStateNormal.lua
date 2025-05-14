module("modules.logic.chessgame.game.event.ChessStateNormal", package.seeall)

local var_0_0 = class("ChessStateNormal", ChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("ChessStateNormal start")
	ChessGameController.instance:dispatchEvent(ChessGameEvent.EventStart, arg_1_0:getStateType())
end

function var_0_0.onClickPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1 = ChessGameController.instance:searchInteractByPos(arg_2_1, arg_2_2, ChessGameController.filterSelectable)
	local var_2_2 = ChessGameController.instance:getClickStatus()

	if var_2_2 == ChessGameEnum.SelectPosStatus.None then
		arg_2_0:onClickInNoneStatus(var_2_0, var_2_1, arg_2_3)
	elseif var_2_2 == ChessGameEnum.SelectPosStatus.SelectObjWaitPos then
		arg_2_0:onClickInSelectObjWaitPosStatus(arg_2_1, arg_2_2, var_2_0, var_2_1, arg_2_3)
	elseif var_2_2 == ChessGameEnum.SelectPosStatus.CatchObj then
		arg_2_0:onClickCatchObjWaitPosStatus(arg_2_1, arg_2_2, var_2_0, var_2_1, arg_2_3)
	elseif var_2_2 == ChessGameEnum.SelectPosStatus.ShowTalk then
		arg_2_0:onClickShowTalkWaitPosStatus()
	end
end

function var_0_0.onClickInNoneStatus(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 >= 1 then
		local var_3_0 = arg_3_1 > 1 and arg_3_2[1] or arg_3_2

		if var_3_0.objType ~= ChessGameEnum.InteractType.Role then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			ChessGameController.instance:setSelectObj(var_3_0)

			arg_3_0._lastSelectObj = ChessGameController.instance:getSelectObj()
		end
	end
end

function var_0_0.onClickInSelectObjWaitPosStatus(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = ChessGameController.instance:getSelectObj()

	arg_4_0._lastSelectObj = var_4_0

	if var_4_0 and var_4_0:getHandler() then
		if var_4_0:getHandler():onSelectPos(arg_4_1, arg_4_2) then
			if ChessGameController.instance.eventMgr:isPlayingFlow() then
				return
			end

			arg_4_0:onClickPos(arg_4_1, arg_4_2, arg_4_5)
		end
	else
		logError("select obj missing!")
	end
end

function var_0_0.onClickCatchObjWaitPosStatus(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = ChessGameController.instance:getSelectObj()

	arg_5_0._lastSelectObj = var_5_0

	if var_5_0 and var_5_0:getHandler() then
		if var_5_0:getHandler():onSetPosWithCatchObj(arg_5_1, arg_5_2) then
			arg_5_0:onClickPos(arg_5_1, arg_5_2, arg_5_5)
		end
	else
		logError("select obj missing!")
	end
end

function var_0_0.onClickShowTalkWaitPosStatus(arg_6_0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.ClickOnTalking)
end

return var_0_0
