module("modules.logic.fight.entity.comp.skill.FightTLEventEntityRenderOrder", package.seeall)

local var_0_0 = class("FightTLEventEntityRenderOrder", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tonumber(arg_1_3[1]) or -1
	local var_1_1 = tonumber(arg_1_3[2]) or -1
	local var_1_2 = FightHelper.getEntity(arg_1_1.fromId)
	local var_1_3 = var_1_2:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	local var_1_4 = FightHelper.getSideEntitys(var_1_3, true)

	arg_1_0:_setRenderOrder(var_1_2, var_1_0)

	for iter_1_0, iter_1_1 in ipairs(var_1_4) do
		arg_1_0:_setRenderOrder(iter_1_1, var_1_1)
	end

	FightRenderOrderMgr.instance:refreshRenderOrder()
end

function var_0_0._setRenderOrder(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 ~= -1 then
		FightRenderOrderMgr.instance:setOrder(arg_2_1.id, arg_2_2)
	end
end

return var_0_0
