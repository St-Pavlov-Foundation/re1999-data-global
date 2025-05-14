module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractSentryEnemy", package.seeall)

local var_0_0 = class("Va3ChessInteractSentryEnemy", Va3ChessInteractBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._enableAlarm = true
end

function var_0_0.onDrawAlert(arg_2_0, arg_2_1)
	if not arg_2_0._enableAlarm then
		return
	end

	local var_2_0

	if arg_2_0._target and arg_2_0._target.originData and arg_2_0._target.originData.data then
		var_2_0 = arg_2_0._target.originData.data.alertArea
	end

	if var_2_0 then
		local var_2_1 = var_2_0[1].x
		local var_2_2 = var_2_0[1].y

		if Va3ChessGameModel.instance:isPosInChessBoard(var_2_1, var_2_2) and Va3ChessGameModel.instance:getBaseTile(var_2_1, var_2_2) ~= Va3ChessEnum.TileBaseType.None then
			arg_2_1[var_2_1] = arg_2_1[var_2_1] or {}
			arg_2_1[var_2_1][var_2_2] = arg_2_1[var_2_1][var_2_2] or {}

			table.insert(arg_2_1[var_2_1][var_2_2], true)
		end
	end

	local var_2_3 = arg_2_0._target.originData.posX
	local var_2_4 = arg_2_0._target.originData.posY
	local var_2_5 = Activity142Helper.isCanFireKill(arg_2_0._target)

	if var_2_5 then
		arg_2_1[var_2_3] = arg_2_1[var_2_3] or {}
		arg_2_1[var_2_3][var_2_4] = arg_2_1[var_2_3][var_2_4] or {}

		table.insert(arg_2_1[var_2_3][var_2_4], {
			showOrangeStyle = var_2_5
		})
	end
end

local var_0_1 = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.MoveKill] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	}
}

function var_0_0.playDeleteObjView(arg_3_0, arg_3_1)
	if arg_3_0._animSelf then
		local var_3_0 = var_0_1[arg_3_1] or {}
		local var_3_1 = var_3_0.anim or "close"

		arg_3_0._animSelf:Play(var_3_1, 0, 0)

		local var_3_2 = var_3_0.audio

		if var_3_2 then
			AudioMgr.instance:trigger(var_3_2)
		end
	end

	if arg_3_0._target and arg_3_0._target.chessEffectObj and arg_3_0._target.chessEffectObj.isShowEffect then
		arg_3_0._target.chessEffectObj:isShowEffect(false)
	end
end

function var_0_0.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._enableAlarm = false

	var_0_0.super.moveTo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function var_0_0.onMoveCompleted(arg_5_0)
	var_0_0.super.onMoveCompleted(arg_5_0)

	arg_5_0._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function var_0_0.onAvatarLoaded(arg_6_0)
	var_0_0.super.onAvatarLoaded(arg_6_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)

	if arg_6_0._target.avatar and arg_6_0._target.avatar.loader then
		local var_6_0 = arg_6_0._target.avatar.loader:getInstGO()

		if not gohelper.isNil(var_6_0) then
			arg_6_0._animSelf = var_6_0:GetComponent(typeof(UnityEngine.Animator))

			if arg_6_0._animSelf then
				arg_6_0._animSelf:Play("open", 0, 0)
			end
		end
	end
end

function var_0_0.dispose(arg_7_0)
	arg_7_0._enableAlarm = false

	var_0_0.super.dispose(arg_7_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return var_0_0
