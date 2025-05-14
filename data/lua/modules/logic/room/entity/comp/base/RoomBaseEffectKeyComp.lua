module("modules.logic.room.entity.comp.base.RoomBaseEffectKeyComp", package.seeall)

local var_0_0 = class("RoomBaseEffectKeyComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = arg_1_1:getMainEffectKey()
end

function var_0_0.setEffectKey(arg_2_0, arg_2_1)
	arg_2_0._effectKey = arg_2_1
end

function var_0_0.onRebuildEffectGO(arg_3_0)
	return
end

function var_0_0.onReturnEffectGO(arg_4_0)
	return
end

function var_0_0.onEffectReturn(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._effectKey == arg_5_1 then
		arg_5_0:onReturnEffectGO()
	end
end

function var_0_0.onEffectRebuild(arg_6_0)
	local var_6_0 = arg_6_0.entity.effect

	if var_6_0:isHasEffectGOByKey(arg_6_0._effectKey) and not var_6_0:isSameResByKey(arg_6_0._effectKey, arg_6_0._effectRes) then
		arg_6_0._effectRes = var_6_0:getEffectRes(arg_6_0._effectKey)

		arg_6_0:onRebuildEffectGO()
	end
end

return var_0_0
