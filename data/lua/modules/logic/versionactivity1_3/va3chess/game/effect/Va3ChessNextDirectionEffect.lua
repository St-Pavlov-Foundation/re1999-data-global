module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessNextDirectionEffect", package.seeall)

local var_0_0 = class("Va3ChessNextDirectionEffect", Va3ChessEffectBase)

function var_0_0.refreshEffect(arg_1_0)
	return
end

function var_0_0.onDispose(arg_2_0)
	return
end

function var_0_0.refreshNextDirFlag(arg_3_0)
	if arg_3_0._target.originData.data and arg_3_0._target.originData.data.alertArea then
		local var_3_0 = arg_3_0._target.originData.posX
		local var_3_1 = arg_3_0._target.originData.posY
		local var_3_2 = arg_3_0._target.originData.data.alertArea

		if #var_3_2 == 1 then
			local var_3_3 = var_3_2[1].x
			local var_3_4 = var_3_2[1].y
			local var_3_5 = arg_3_0._target.originData.posX
			local var_3_6 = arg_3_0._target.originData.posY
			local var_3_7 = Va3ChessMapUtils.ToDirection(var_3_5, var_3_6, var_3_3, var_3_4)

			arg_3_0._target:getHandler():faceTo(var_3_7)
		end
	end
end

function var_0_0.onAvatarLoaded(arg_4_0)
	local var_4_0 = arg_4_0._loader

	if not arg_4_0._loader then
		return
	end

	local var_4_1 = var_4_0:getInstGO()

	if not gohelper.isNil(var_4_1) then
		local var_4_2 = arg_4_0._target.avatar

		for iter_4_0, iter_4_1 in ipairs(Va3ChessInteractObject.DirectionList) do
			local var_4_3 = gohelper.findChild(var_4_1, "dir_" .. iter_4_1)

			var_4_2.goNextDirection = var_4_1
			var_4_2["goMovetoDir" .. iter_4_1] = var_4_3

			gohelper.setActive(var_4_3, false)
		end
	end

	arg_4_0:refreshNextDirFlag()
end

return var_0_0
