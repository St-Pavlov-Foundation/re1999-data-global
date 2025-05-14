module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBrazier", package.seeall)

local var_0_0 = class("Va3ChessInteractBrazier", Va3ChessInteractBase)

function var_0_0.onAvatarLoaded(arg_1_0)
	var_0_0.super.onAvatarLoaded(arg_1_0)

	local var_1_0 = arg_1_0._target.avatar.loader

	if not var_1_0 then
		return
	end

	local var_1_1 = var_1_0:getInstGO()

	if not gohelper.isNil(var_1_1) then
		arg_1_0._goFire = gohelper.findChild(var_1_1, "huopeng_fire")
	end

	arg_1_0:refreshBrazier()
end

function var_0_0.refreshBrazier(arg_2_0)
	local var_2_0 = false

	if arg_2_0._target.originData then
		var_2_0 = arg_2_0._target.originData:getBrazierIsLight()
	end

	if not gohelper.isNil(arg_2_0._goFire) then
		gohelper.setActive(arg_2_0._goFire, var_2_0)
	end
end

return var_0_0
