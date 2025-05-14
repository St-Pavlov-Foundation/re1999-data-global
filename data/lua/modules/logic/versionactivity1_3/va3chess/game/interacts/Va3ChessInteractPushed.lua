module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractPushed", package.seeall)

local var_0_0 = class("Va3ChessInteractPushed", Va3ChessInteractBase)

function var_0_0.checkCanBlock(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 == Va3ChessEnum.InteractType.AssistPlayer then
		return true
	end

	if arg_1_0._target.originData.data.status then
		return true
	end

	local var_1_0, var_1_1 = Va3ChessMapUtils.CalNextCellPos(arg_1_0._target.originData.posX, arg_1_0._target.originData.posY, arg_1_1)

	if arg_1_0:checkNoTileByXY(var_1_0, var_1_1) then
		return true
	end

	if Va3ChessGameController.instance:searchInteractByPos(var_1_0, var_1_1) > 0 then
		return true
	end
end

function var_0_0.checkNoTileByXY(arg_2_0, arg_2_1, arg_2_2)
	if not Va3ChessGameModel.instance:isPosInChessBoard(arg_2_1, arg_2_2) then
		return true
	end

	local var_2_0 = Va3ChessGameModel.instance:getTileMO(arg_2_1, arg_2_2)

	if not var_2_0 or var_2_0.tileType == Va3ChessEnum.TileBaseType.None or var_2_0:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		return true
	end

	return false
end

function var_0_0.showStateView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == Va3ChessEnum.ObjState.Idle then
		arg_3_0:showIdleStateView()
	elseif arg_3_1 == Va3ChessEnum.ObjState.Interoperable then
		arg_3_0:showPushableStateView(arg_3_2)
	end
end

function var_0_0.showIdleStateView(arg_4_0)
	arg_4_0:setArrawDir(0)
end

function var_0_0.showPushableStateView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.dir

	arg_5_0:setArrawDir(var_5_0)
end

function var_0_0.onAvatarLoaded(arg_6_0)
	var_0_0.super.onAvatarLoaded(arg_6_0)

	local var_6_0 = arg_6_0._target.avatar.loader:getInstGO()

	for iter_6_0, iter_6_1 in ipairs(Va3ChessInteractObject.DirectionList) do
		arg_6_0._target.avatar["arraw" .. iter_6_1] = gohelper.findChild(var_6_0, "icon/icon_direction/dir_" .. iter_6_1)
	end
end

function var_0_0.setArrawDir(arg_7_0, arg_7_1)
	if arg_7_0._target.avatar then
		for iter_7_0, iter_7_1 in ipairs(Va3ChessInteractObject.DirectionList) do
			local var_7_0 = arg_7_0._target.avatar["arraw" .. iter_7_1]

			if not gohelper.isNil(var_7_0) then
				gohelper.setActive(var_7_0, arg_7_1 == iter_7_1)
			end
		end
	end
end

local var_0_1 = "vx_smoke"

function var_0_0.onMoveBegin(arg_8_0)
	local var_8_0 = arg_8_0._target.avatar.loader:getInstGO()
	local var_8_1 = gohelper.findChild(var_8_0, var_0_1)

	gohelper.setActive(var_8_1, false)
	gohelper.setActive(var_8_1, true)
	AudioMgr.instance:trigger(AudioEnum.Role2ChessGame1_3.PushStone)
end

return var_0_0
