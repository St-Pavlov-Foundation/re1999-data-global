module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBoltLauncher", package.seeall)

local var_0_0 = class("Va3ChessInteractBoltLauncher", Va3ChessInteractBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._enableAlarm = true
end

function var_0_0.onDrawAlert(arg_2_0, arg_2_1)
	if not arg_2_0._enableAlarm then
		return
	end

	local var_2_0 = arg_2_0._target.originData:getDirection()

	if not var_2_0 then
		return
	end

	local var_2_1
	local var_2_2
	local var_2_3, var_2_4 = Va3ChessGameModel.instance:getGameSize()
	local var_2_5 = arg_2_0._target.originData.posX
	local var_2_6 = arg_2_0._target.originData.posY
	local var_2_7 = var_2_0 == Va3ChessEnum.Direction.Up
	local var_2_8 = var_2_0 == Va3ChessEnum.Direction.Down
	local var_2_9 = var_2_0 == Va3ChessEnum.Direction.Right

	if var_2_7 or var_2_8 then
		var_2_1 = var_2_7 and var_2_6 + 1 or 0
		var_2_2 = var_2_7 and var_2_4 - 1 or var_2_6 - 1
	else
		var_2_1 = var_2_9 and var_2_5 + 1 or 0
		var_2_2 = var_2_9 and var_2_3 - 1 or var_2_5 - 1
	end

	if var_2_1 < 0 or var_2_2 < 0 then
		return
	end

	if var_2_2 < var_2_1 then
		logError(string.format("Va3ChessInteractBoltLauncher:onDrawAlert target error,interactId:%s beginPos:%s endPos:%s", arg_2_0._target.id, var_2_1, var_2_2))

		return
	end

	if var_2_7 or var_2_8 then
		for iter_2_0 = var_2_1, var_2_2 do
			local var_2_10 = {
				Va3ChessEnum.Direction.Left,
				Va3ChessEnum.Direction.Right
			}

			if iter_2_0 == var_2_1 then
				table.insert(var_2_10, Va3ChessEnum.Direction.Down)
			elseif iter_2_0 == var_2_2 then
				table.insert(var_2_10, Va3ChessEnum.Direction.Up)
			end

			arg_2_0:_insertToAlertMap(arg_2_1, var_2_5, iter_2_0, var_2_10)
		end
	else
		for iter_2_1 = var_2_1, var_2_2 do
			local var_2_11 = {
				Va3ChessEnum.Direction.Up,
				Va3ChessEnum.Direction.Down
			}

			if iter_2_1 == var_2_1 then
				table.insert(var_2_11, Va3ChessEnum.Direction.Left)
			elseif iter_2_1 == var_2_2 then
				table.insert(var_2_11, Va3ChessEnum.Direction.Right)
			end

			arg_2_0:_insertToAlertMap(arg_2_1, iter_2_1, var_2_6, var_2_11)
		end
	end
end

function var_0_0._insertToAlertMap(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if Va3ChessGameModel.instance:isPosInChessBoard(arg_3_2, arg_3_3) and Va3ChessGameModel.instance:getBaseTile(arg_3_2, arg_3_3) ~= Va3ChessEnum.TileBaseType.None then
		arg_3_1[arg_3_2] = arg_3_1[arg_3_2] or {}
		arg_3_1[arg_3_2][arg_3_3] = arg_3_1[arg_3_2][arg_3_3] or {}

		table.insert(arg_3_1[arg_3_2][arg_3_3], {
			isStatic = true,
			resPath = Va3ChessEnum.SceneResPath.AlarmItem2,
			showDirLine = arg_3_4
		})
	end
end

function var_0_0.onAvatarLoaded(arg_4_0)
	var_0_0.super.onAvatarLoaded(arg_4_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function var_0_0.dispose(arg_5_0)
	arg_5_0._enableAlarm = false

	var_0_0.super.dispose(arg_5_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return var_0_0
