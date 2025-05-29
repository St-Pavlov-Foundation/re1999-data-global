module("modules.logic.fight.entity.FightEntityAssembledMonsterMain", package.seeall)

local var_0_0 = class("FightEntityAssembledMonsterMain", FightEntityMonster)

function var_0_0.getHangPoint(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_2 and not string.nilorempty(arg_1_1) and ModuleEnum.SpineHangPointRoot ~= arg_1_1 then
		arg_1_1 = string.format("%s_part_%d", arg_1_1, arg_1_0:getPartIndex())
	end

	return var_0_0.super.getHangPoint(arg_1_0, arg_1_1)
end

function var_0_0.getBuffAnim(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		if (isTypeOf(iter_2_1, var_0_0) or isTypeOf(iter_2_1, FightEntityAssembledMonsterSub)) and iter_2_1.buff then
			local var_2_3, var_2_4 = iter_2_1.buff:getBuffAnim()

			if var_2_3 then
				table.insert(var_2_0, var_2_4)

				var_2_1[var_2_4.uid] = var_2_3
			end
		end
	end

	if #var_2_0 > 0 then
		table.sort(var_2_0, FightBuffComp.buffCompareFuncAni)

		return var_2_1[var_2_0[1].uid]
	end
end

function var_0_0.getDefaultMatName(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		if (isTypeOf(iter_3_1, var_0_0) or isTypeOf(iter_3_1, FightEntityAssembledMonsterSub)) and iter_3_1.buff then
			local var_3_3, var_3_4 = iter_3_1.buff:getBuffMatName()

			if var_3_3 then
				table.insert(var_3_0, var_3_4)

				var_3_1[var_3_4.uid] = var_3_3
			end
		end
	end

	if #var_3_0 > 0 then
		table.sort(var_3_0, FightBuffComp.buffCompareFuncMat)

		return var_3_1[var_3_0[1].uid]
	end
end

function var_0_0.setAlpha(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:setAlphaData(arg_4_0.id, arg_4_1, arg_4_2)
end

function var_0_0.setAlphaData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._alphaDic = arg_5_0._alphaDic or {}
	arg_5_0._alphaDic[arg_5_1] = arg_5_2

	for iter_5_0, iter_5_1 in pairs(arg_5_0._alphaDic) do
		if iter_5_1 ~= arg_5_2 then
			var_0_0.super.setAlpha(arg_5_0, 1, 0)

			local var_5_0 = FightHelper.getEntity(iter_5_0)

			if var_5_0 ~= arg_5_0 then
				var_5_0.super.setAlpha(var_5_0, 1, 0)
			end

			return
		end
	end

	var_0_0.super.setAlpha(arg_5_0, arg_5_2, arg_5_3)

	for iter_5_2, iter_5_3 in pairs(arg_5_0._alphaDic) do
		local var_5_1 = FightHelper.getEntity(iter_5_2)

		if var_5_1 ~= arg_5_0 then
			var_5_1.super.setAlpha(var_5_1, arg_5_2, arg_5_3)
		end
	end
end

function var_0_0.initComponents(arg_6_0)
	var_0_0.super.initComponents(arg_6_0)
end

function var_0_0.getSpineClass(arg_7_0)
	return FightAssembledMonsterSpine
end

function var_0_0.getPartIndex(arg_8_0)
	local var_8_0 = arg_8_0:getMO()

	if var_8_0 then
		return lua_fight_assembled_monster.configDict[var_8_0.skin].part
	end
end

function var_0_0.killAllSubMonster(arg_9_0)
	local var_9_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_9_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if FightHelper.isAssembledMonster(iter_9_1) and iter_9_1 ~= arg_9_0 then
			var_9_0:removeUnit(iter_9_1:getTag(), iter_9_1.id)

			local var_9_2 = FightDataHelper.entityMgr:getById(iter_9_1.id)

			var_9_2:setDead()
			FightDataHelper.entityMgr:addDeadUid(var_9_2.id)

			if arg_9_0._alphaDic then
				arg_9_0._alphaDic[iter_9_1.id] = nil
			end
		end
	end
end

function var_0_0.beforeDestroy(arg_10_0)
	var_0_0.super.beforeDestroy(arg_10_0)
end

return var_0_0
