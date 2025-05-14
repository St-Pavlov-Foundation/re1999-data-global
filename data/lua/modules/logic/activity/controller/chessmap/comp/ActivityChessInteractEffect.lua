module("modules.logic.activity.controller.chessmap.comp.ActivityChessInteractEffect", package.seeall)

local var_0_0 = class("ActivityChessInteractEffect")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
end

function var_0_0.refreshSearchFailed(arg_2_0)
	if arg_2_0._target.originData and arg_2_0._target.originData.data and arg_2_0._target.avatar and arg_2_0._target.avatar.goLostTarget then
		gohelper.setActive(arg_2_0._target.avatar.goLostTarget, arg_2_0._target.originData.data.lostTarget)
	end
end

function var_0_0.dispose(arg_3_0)
	return
end

function var_0_0.onAvatarLoaded(arg_4_0)
	local var_4_0 = arg_4_0._target.avatar.loader

	if not var_4_0 then
		return
	end

	arg_4_0._target.avatar.goLostTarget = gohelper.findChild(var_4_0:getInstGO(), "piecea/vx_vertigo")

	arg_4_0:refreshSearchFailed()
end

return var_0_0
