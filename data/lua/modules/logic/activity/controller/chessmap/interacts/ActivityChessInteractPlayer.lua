module("modules.logic.activity.controller.chessmap.interacts.ActivityChessInteractPlayer", package.seeall)

local var_0_0 = class("ActivityChessInteractPlayer", ActivityChessInteractBase)

function var_0_0.onSelectCall(arg_1_0)
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.SelectObjWaitPos)

	local var_1_0 = arg_1_0._target.originData.posX
	local var_1_1 = arg_1_0._target.originData.posY
	local var_1_2 = {
		visible = true,
		posXList = {},
		posYList = {},
		selfPosX = var_1_0,
		selfPosY = var_1_1,
		selectType = ActivityChessEnum.ChessSelectType.Normal
	}

	var_0_0.insertPosToList(var_1_0 + 1, var_1_1, var_1_2.posXList, var_1_2.posYList)
	var_0_0.insertPosToList(var_1_0 - 1, var_1_1, var_1_2.posXList, var_1_2.posYList)
	var_0_0.insertPosToList(var_1_0, var_1_1 + 1, var_1_2.posXList, var_1_2.posYList)
	var_0_0.insertPosToList(var_1_0, var_1_1 - 1, var_1_2.posXList, var_1_2.posYList)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, var_1_2)

	arg_1_0._isPlayerSelected = true

	arg_1_0:refreshPlayerSelected()
end

function var_0_0.insertPosToList(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if ActivityChessGameController.instance:posCanWalk(arg_2_0, arg_2_1) then
		table.insert(arg_2_2, arg_2_0)
		table.insert(arg_2_3, arg_2_1)
	end
end

function var_0_0.onCancelSelect(arg_3_0)
	ActivityChessGameController.instance:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	arg_3_0._isPlayerSelected = false

	arg_3_0:refreshPlayerSelected()
end

function var_0_0.onSelectPos(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._target.originData.posX
	local var_4_1 = arg_4_0._target.originData.posY
	local var_4_2 = ActivityChessGameModel.instance:getBaseTile(arg_4_1, arg_4_2)

	if (var_4_0 == arg_4_1 and math.abs(var_4_1 - arg_4_2) == 1 or var_4_1 == arg_4_2 and math.abs(var_4_0 - arg_4_1) == 1) and ActivityChessGameController.instance:posCanWalk(arg_4_1, arg_4_2) then
		local var_4_3 = {
			id = arg_4_0._target.originData.id,
			dir = ActivityChessMapUtils.ToDirection(var_4_0, var_4_1, arg_4_1, arg_4_2)
		}

		ActivityChessGameModel.instance:appendOpt(var_4_3)

		local var_4_4 = ActivityChessGameModel.instance:getActId()
		local var_4_5 = ActivityChessGameModel.instance:getOptList()

		Activity109Rpc.instance:sendAct109BeginRoundRequest(var_4_4, var_4_5, arg_4_0.onMoveSuccess, arg_4_0)
		ActivityChessGameController.instance:saveTempSelectObj()
		ActivityChessGameController.instance:setSelectObj(nil)

		local var_4_6 = ActivityChessGameController.instance.event

		if var_4_6 then
			var_4_6:setLockEvent()
		end
	else
		local var_4_7, var_4_8 = ActivityChessGameController.instance:searchInteractByPos(arg_4_1, arg_4_2)
		local var_4_9 = var_4_7 > 1 and var_4_8[1] or var_4_8

		if var_4_9 then
			if var_4_9.config and var_4_9.config.interactType ~= ActivityChessEnum.InteractType.Player then
				-- block empty
			else
				ActivityChessGameController.instance:setSelectObj(nil)

				return true
			end
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

function var_0_0.refreshPlayerSelected(arg_7_0)
	return
end

function var_0_0.onAvatarLoaded(arg_8_0)
	var_0_0.super.onAvatarLoaded(arg_8_0)

	local var_8_0 = arg_8_0._target.avatar.loader

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getInstGO()

	if not gohelper.isNil(var_8_1) then
		arg_8_0._animSelf = var_8_1:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_8_0._target.avatar.goSelected = gohelper.findChild(var_8_0:getInstGO(), "piecea/vx_select")

	gohelper.setActive(arg_8_0._target.avatar.goSelected, true)
	arg_8_0:refreshPlayerSelected()
end

return var_0_0
