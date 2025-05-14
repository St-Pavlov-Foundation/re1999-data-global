module("modules.logic.activity.controller.chessmap.event.ActivityChessStateNormal", package.seeall)

local var_0_0 = class("ActivityChessStateNormal", ActivityChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("ActivityChessStateNormal start")
end

function var_0_0.onClickPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1 = ActivityChessGameController.instance:searchInteractByPos(arg_2_1, arg_2_2, ActivityChessGameController.filterSelectable)
	local var_2_2 = ActivityChessGameController.instance:getClickStatus()

	if var_2_2 == ActivityChessEnum.SelectPosStatus.None then
		arg_2_0:onClickInNoneStatus(var_2_0, var_2_1, arg_2_3)
	elseif var_2_2 == ActivityChessEnum.SelectPosStatus.SelectObjWaitPos then
		arg_2_0:onClickInSelectObjWaitPosStatus(arg_2_1, arg_2_2, var_2_0, var_2_1, arg_2_3)
	end
end

function var_0_0.onClickInNoneStatus(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 >= 1 then
		local var_3_0 = arg_3_1 > 1 and arg_3_2[1] or arg_3_2

		if var_3_0.objType ~= ActivityChessEnum.InteractType.Player then
			GameFacade.showToast(ToastEnum.ChessCanNotSelect)
		else
			if arg_3_0._lastSelectObj ~= var_3_0 and arg_3_3 then
				if var_3_0.config.avatar == ActivityChessEnum.RoleAvatar.Apple then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectApple)
				elseif var_3_0.config.avatar == ActivityChessEnum.RoleAvatar.PKLS then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectPKLS)
				elseif var_3_0.config.avatar == ActivityChessEnum.RoleAvatar.WJYS then
					AudioMgr.instance:trigger(AudioEnum.ChessGame.SelectWJYS)
				end
			end

			ActivityChessGameController.instance:setSelectObj(var_3_0)

			arg_3_0._lastSelectObj = ActivityChessGameController.instance:getSelectObj()
		end
	end
end

function var_0_0.onClickInSelectObjWaitPosStatus(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = ActivityChessGameController.instance:getSelectObj()

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
