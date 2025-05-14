module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractTriggerFail", package.seeall)

local var_0_0 = class("Va3ChessInteractTriggerFail", Va3ChessInteractBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._enableAlarm = false
	arg_1_0._isAlertActive = true
end

function var_0_0.onDrawAlert(arg_2_0, arg_2_1)
	if not arg_2_0._enableAlarm then
		return
	end

	local var_2_0 = arg_2_0._target.originData.posX
	local var_2_1 = arg_2_0._target.originData.posY

	if arg_2_0._isAlertActive then
		arg_2_0:insertToAlertMap(arg_2_1, var_2_0, var_2_1)
	end

	if arg_2_0._target.originData.data and arg_2_0._target.originData.data.alertArea then
		local var_2_2 = arg_2_0._target.originData.data.alertArea

		if #var_2_2 == 1 then
			local var_2_3 = var_2_2[1].x
			local var_2_4 = var_2_2[1].y
			local var_2_5 = arg_2_0._target.originData.posX
			local var_2_6 = arg_2_0._target.originData.posY
			local var_2_7 = Va3ChessMapUtils.ToDirection(var_2_5, var_2_6, var_2_3, var_2_4)

			arg_2_0:faceTo(var_2_7)
		end
	end
end

function var_0_0.setAlertActive(arg_3_0, arg_3_1)
	arg_3_0._isAlertActive = arg_3_1
end

function var_0_0.insertToAlertMap(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if Va3ChessGameModel.instance:isPosInChessBoard(arg_4_2, arg_4_3) and Va3ChessGameModel.instance:getBaseTile(arg_4_2, arg_4_3) ~= Va3ChessEnum.TileBaseType.None then
		local var_4_0 = Activity142Helper.isCanFireKill(arg_4_0._target)

		arg_4_1[arg_4_2] = arg_4_1[arg_4_2] or {}
		arg_4_1[arg_4_2][arg_4_3] = arg_4_1[arg_4_2][arg_4_3] or {}

		table.insert(arg_4_1[arg_4_2][arg_4_3], {
			showOrangeStyle = var_4_0
		})
	end
end

function var_0_0.moveTo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0._enableAlarm = false
	arg_5_0._moveTargetX = arg_5_1
	arg_5_0._moveTargetY = arg_5_2

	var_0_0.super.moveTo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function var_0_0.onMoveCompleted(arg_6_0)
	var_0_0.super.onMoveCompleted(arg_6_0)

	arg_6_0._enableAlarm = true

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

function var_0_0.onAvatarLoaded(arg_7_0)
	arg_7_0._enableAlarm = true

	var_0_0.super.onAvatarLoaded(arg_7_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)

	if not arg_7_0._target.avatar or not arg_7_0._target.avatar.loader then
		return
	end

	local var_7_0 = arg_7_0._target.avatar.loader:getInstGO()

	if gohelper.isNil(var_7_0) then
		return
	end

	arg_7_0._animSelf = var_7_0:GetComponent(typeof(UnityEngine.Animator))

	if arg_7_0._animSelf then
		local var_7_1 = Va3ChessGameModel.instance:getObjectDataById(arg_7_0._target.id)

		if var_7_1 and var_7_1:getHaveBornEff() then
			arg_7_0._animSelf:Play(Va3ChessEnum.SWITCH_OPEN_ANIM, 0, 0)
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchTrackEnemy)
			var_7_1:setHaveBornEff(false)
		end
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

function var_0_0.playDeleteObjView(arg_8_0, arg_8_1)
	if arg_8_0._animSelf then
		local var_8_0 = var_0_1[arg_8_1] or {}
		local var_8_1 = var_8_0.anim or "close"

		arg_8_0._animSelf:Play(var_8_1, 0, 0)

		local var_8_2 = var_8_0.audio

		if var_8_2 then
			AudioMgr.instance:trigger(var_8_2)
		end
	end

	if arg_8_0._target and arg_8_0._target.chessEffectObj and arg_8_0._target.chessEffectObj.isShowEffect then
		arg_8_0._target.chessEffectObj:isShowEffect(false)
	end
end

function var_0_0.dispose(arg_9_0)
	arg_9_0._enableAlarm = false

	var_0_0.super.dispose(arg_9_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RefreshAlarmArea)
end

return var_0_0
