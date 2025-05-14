module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPlayer", package.seeall)

local var_0_0 = class("Va3ChessInteractPlayer", Va3ChessInteractBase)

function var_0_0.onSelected(arg_1_0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.SelectObjWaitPos)

	local var_1_0 = arg_1_0._target.originData.posX
	local var_1_1 = arg_1_0._target.originData.posY
	local var_1_2 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = var_1_0,
		selfPosY = var_1_1,
		selectType = Va3ChessEnum.ChessSelectType.Normal
	}

	arg_1_0:insertPosToList(var_1_0 + 1, var_1_1, var_1_2.posXList, var_1_2.posYList)
	arg_1_0:insertPosToList(var_1_0 - 1, var_1_1, var_1_2.posXList, var_1_2.posYList)
	arg_1_0:insertPosToList(var_1_0, var_1_1 + 1, var_1_2.posXList, var_1_2.posYList)
	arg_1_0:insertPosToList(var_1_0, var_1_1 - 1, var_1_2.posXList, var_1_2.posYList)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, var_1_2)

	arg_1_0._isPlayerSelected = true

	arg_1_0:refreshPlayerSelected()
end

function var_0_0.insertPosToList(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_0._target.originData.posX
	local var_2_1 = arg_2_0._target.originData.posY
	local var_2_2 = Va3ChessMapUtils.ToDirection(var_2_0, var_2_1, arg_2_1, arg_2_2)

	if Va3ChessGameController.instance:posCanWalk(arg_2_1, arg_2_2, var_2_2, arg_2_0._target.objType) then
		table.insert(arg_2_3, arg_2_1)
		table.insert(arg_2_4, arg_2_2)
	end
end

function var_0_0.onCancelSelect(arg_3_0)
	Va3ChessGameController.instance:setClickStatus(Va3ChessEnum.SelectPosStatus.None)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	arg_3_0._isPlayerSelected = false

	arg_3_0:refreshPlayerSelected()
end

function var_0_0.onSelectPos(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._target.originData.posX
	local var_4_1 = arg_4_0._target.originData.posY
	local var_4_2 = Va3ChessGameModel.instance:getBaseTile(arg_4_1, arg_4_2)
	local var_4_3 = Va3ChessMapUtils.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)

	if (var_4_0 == arg_4_1 and math.abs(var_4_1 - arg_4_2) == 1 or var_4_1 == arg_4_2 and math.abs(var_4_0 - arg_4_1) == 1) and Va3ChessGameController.instance:posCanWalk(arg_4_1, arg_4_2, var_4_3, arg_4_0._target.objType) then
		local var_4_4 = {
			id = arg_4_0._target.originData.id,
			dir = Va3ChessMapUtils.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)
		}

		Va3ChessGameModel.instance:appendOpt(var_4_4)

		local var_4_5 = Va3ChessGameModel.instance:getActId()
		local var_4_6 = Va3ChessGameModel.instance:getOptList()

		Va3ChessRpcController.instance:sendActBeginRoundRequest(var_4_5, var_4_6, arg_4_0.onMoveSuccess, arg_4_0)
		Va3ChessGameController.instance:saveTempSelectObj()
		Va3ChessGameController.instance:setSelectObj(nil)

		local var_4_7 = Va3ChessGameController.instance.event

		if var_4_7 then
			var_4_7:setLockEvent()
		end
	else
		local var_4_8, var_4_9 = Va3ChessGameController.instance:searchInteractByPos(arg_4_1, arg_4_2)
		local var_4_10 = var_4_8 > 1 and var_4_9[1] or var_4_9

		if var_4_10 then
			if var_4_10.config and var_4_10.config.interactType ~= Va3ChessEnum.InteractType.Player and var_4_10.config.interactType ~= Va3ChessEnum.InteractType.AssistPlayer then
				-- block empty
			else
				Va3ChessGameController.instance:setSelectObj(nil)

				return true
			end

			GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
		else
			GameFacade.showToast(ToastEnum.ChessCanNotMoveHere)
		end
	end
end

function var_0_0.onMoveSuccess(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end
end

function var_0_0.moveTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	var_0_0.super.moveTo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)

	if arg_6_0._animSelf then
		arg_6_0._animSelf:Play("jump", 0, 0)
	end
end

function var_0_0.showHitAni(arg_7_0)
	if arg_7_0._animSelf then
		arg_7_0._animSelf:Play("hit", 0, 0)
	end
end

function var_0_0.refreshPlayerSelected(arg_8_0)
	return
end

function var_0_0.onAvatarLoaded(arg_9_0)
	var_0_0.super.onAvatarLoaded(arg_9_0)

	local var_9_0 = arg_9_0._target.avatar.loader

	if not var_9_0 then
		return
	end

	local var_9_1 = var_9_0:getInstGO()

	if not gohelper.isNil(var_9_1) then
		arg_9_0._animSelf = var_9_1:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_9_0._target.avatar.goSelected = gohelper.findChild(var_9_0:getInstGO(), "piecea/vx_select")

	gohelper.setActive(arg_9_0._target.avatar.goSelected, true)
	arg_9_0:refreshPlayerSelected()
end

return var_0_0
