module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessMonsterEffect", package.seeall)

local var_0_0 = class("Va3ChessMonsterEffect", Va3ChessEffectBase)

function var_0_0.refreshEffect(arg_1_0)
	return
end

function var_0_0.onDispose(arg_2_0)
	return
end

function var_0_0.onAvatarLoaded(arg_3_0)
	local var_3_0 = arg_3_0._loader

	if not arg_3_0._loader then
		return
	end

	local var_3_1 = var_3_0:getInstGO()

	if not gohelper.isNil(var_3_1) then
		local var_3_2 = gohelper.findChild(var_3_1, "vx_tracked")
		local var_3_3 = gohelper.findChild(var_3_1, "vx_number")
		local var_3_4 = gohelper.findChild(var_3_1, "icon_tanhao")

		gohelper.setActive(arg_3_0._target.avatar.goTrack, false)
		gohelper.setActive(var_3_2, false)
		gohelper.setActive(var_3_3, false)
		gohelper.setActive(var_3_4, false)

		arg_3_0._target.avatar.goTrack = var_3_2
		arg_3_0._target.avatar.goNumber = var_3_3
	end
end

return var_0_0
