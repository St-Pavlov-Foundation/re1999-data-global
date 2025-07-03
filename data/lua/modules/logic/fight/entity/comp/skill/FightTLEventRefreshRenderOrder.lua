module("modules.logic.fight.entity.comp.skill.FightTLEventRefreshRenderOrder", package.seeall)

local var_0_0 = class("FightTLEventRefreshRenderOrder", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = FightHelper.getEntity(arg_1_1.fromId)
	local var_1_1 = FightHelper.getSideEntitys(var_1_0:getSide(), true)
	local var_1_2 = FightHelper.getDefenders(arg_1_1, true)

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		FightRenderOrderMgr.instance:cancelOrder(iter_1_1.id)
	end

	local var_1_3 = tonumber(arg_1_3[1])

	FightRenderOrderMgr.instance:setSortType(var_1_3)

	if var_1_3 == FightEnum.RenderOrderType.ZPos then
		arg_1_0._keepOrderPriorityDict = {}
		arg_1_0._keepOrderPriorityDict[var_1_0.id] = 0

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			arg_1_0._keepOrderPriorityDict[iter_1_3.id] = 1
		end

		local var_1_4 = tonumber(arg_1_3[2]) or 0.33

		TaskDispatcher.runRepeat(arg_1_0._refreshOrder, arg_1_0, var_1_4)
	end
end

function var_0_0._refreshOrder(arg_2_0)
	FightRenderOrderMgr.instance:refreshRenderOrder(arg_2_0._keepOrderPriorityDict)
end

function var_0_0.onDestructor(arg_3_0)
	arg_3_0._keepOrderPriorityDict = nil

	TaskDispatcher.cancelTask(arg_3_0._refreshOrder, arg_3_0)
end

return var_0_0
