module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractStandbyTrackEnemy", package.seeall)

local var_0_0 = class("Va3ChessInteractStandbyTrackEnemy", Va3ChessInteractBase)
local var_0_1 = {
	[Va3ChessEnum.DeleteReason.Arrow] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.FireBall] = {
		anim = "die",
		audio = AudioEnum.chess_activity142.Die
	},
	[Va3ChessEnum.DeleteReason.Change] = {
		anim = Activity142Enum.SWITCH_CLOSE_ANIM
	}
}

function var_0_0.playDeleteObjView(arg_1_0, arg_1_1)
	if arg_1_0._animSelf then
		local var_1_0 = var_0_1[arg_1_1] or {}
		local var_1_1 = var_1_0.anim or "close"

		arg_1_0._animSelf:Play(var_1_1, 0, 0)

		local var_1_2 = var_1_0.audio

		if var_1_2 then
			AudioMgr.instance:trigger(var_1_2)
		end
	end

	if arg_1_0._target and arg_1_0._target.chessEffectObj and arg_1_0._target.chessEffectObj.isShowEffect then
		arg_1_0._target.chessEffectObj:isShowEffect(false)
	end
end

function var_0_0.onDrawAlert(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._target.originData.posX
	local var_2_1 = arg_2_0._target.originData.posY
	local var_2_2 = Activity142Helper.isCanFireKill(arg_2_0._target)

	if var_2_2 then
		arg_2_1[var_2_0] = arg_2_1[var_2_0] or {}
		arg_2_1[var_2_0][var_2_1] = arg_2_1[var_2_0][var_2_1] or {}

		table.insert(arg_2_1[var_2_0][var_2_1], {
			showOrangeStyle = var_2_2
		})
	end
end

function var_0_0.onAvatarLoaded(arg_3_0)
	var_0_0.super.onAvatarLoaded(arg_3_0)

	if arg_3_0._target.avatar and arg_3_0._target.avatar.loader then
		local var_3_0 = arg_3_0._target.avatar.loader:getInstGO()

		if not gohelper.isNil(var_3_0) then
			arg_3_0._animSelf = var_3_0:GetComponent(typeof(UnityEngine.Animator))

			if arg_3_0._animSelf then
				arg_3_0._animSelf:Play("open", 0, 0)
			end
		end
	end
end

return var_0_0
