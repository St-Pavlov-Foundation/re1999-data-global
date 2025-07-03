module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightEntityDataMgr", FightDataMgrBase)
local var_0_1 = {
	normal = "normal",
	assistBoss = "assistBoss",
	ASFD_emitter = "ASFD_emitter",
	sp = "sp",
	sub = "sub",
	player = "player"
}

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.entityDataDic = {}
	arg_1_0.sideDic = {}

	local var_1_0 = {
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.sideDic[iter_1_1] = {}

		for iter_1_2, iter_1_3 in pairs(var_0_1) do
			arg_1_0.sideDic[iter_1_1][iter_1_3] = {}
		end
	end

	arg_1_0.deadUids = {}
end

function var_0_0.getAllEntityList(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1 = arg_2_1 or {}

	for iter_2_0, iter_2_1 in pairs(var_0_1) do
		arg_2_0:getList(FightEnum.EntitySide.MySide, iter_2_1, arg_2_1, arg_2_2)
		arg_2_0:getList(FightEnum.EntitySide.EnemySide, iter_2_1, arg_2_1, arg_2_2)
	end

	return arg_2_1
end

function var_0_0.getSideList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2 or {}

	for iter_3_0, iter_3_1 in pairs(var_0_1) do
		arg_3_0:getList(arg_3_1, iter_3_1, var_3_0, arg_3_3)
	end

	return var_3_0
end

function var_0_0.getPlayerList(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return arg_4_0:getList(arg_4_1, var_0_1.player, arg_4_2, arg_4_3)
end

function var_0_0.getMyPlayerList(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0:getList(FightEnum.EntitySide.MySide, var_0_1.player, arg_5_1, arg_5_2)
end

function var_0_0.getEnemyPlayerList(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0:getList(FightEnum.EntitySide.EnemySide, var_0_1.player, arg_6_1, arg_6_2)
end

function var_0_0.getMyVertin(arg_7_0)
	return arg_7_0:getMyPlayerList()[1]
end

function var_0_0.getEnemyVertin(arg_8_0)
	return arg_8_0:getEnemyPlayerList()[1]
end

function var_0_0.getNormalList(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	return arg_9_0:getList(arg_9_1, var_0_1.normal, arg_9_2, arg_9_3)
end

function var_0_0.getMyNormalList(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:getList(FightEnum.EntitySide.MySide, var_0_1.normal, arg_10_1, arg_10_2)
end

function var_0_0.getEnemyNormalList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getList(FightEnum.EntitySide.EnemySide, var_0_1.normal, arg_11_1, arg_11_2)

	table.sort(var_11_0, FightHelper.sortAssembledMonsterFunc)

	return var_11_0
end

function var_0_0.getSubList(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return arg_12_0:getList(arg_12_1, var_0_1.sub, arg_12_2, arg_12_3)
end

function var_0_0.getMySubList(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0:getList(FightEnum.EntitySide.MySide, var_0_1.sub, arg_13_1, arg_13_2)
end

function var_0_0.getEnemySubList(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:getList(FightEnum.EntitySide.EnemySide, var_0_1.sub, arg_14_1, arg_14_2)
end

function var_0_0.getSpList(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	return arg_15_0:getList(arg_15_1, var_0_1.sp, arg_15_2, arg_15_3)
end

function var_0_0.getMySpList(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0:getList(FightEnum.EntitySide.MySide, var_0_1.sp, arg_16_1, arg_16_2)
end

function var_0_0.getEnemySpList(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0:getList(FightEnum.EntitySide.EnemySide, var_0_1.sp, arg_17_1, arg_17_2)
end

function var_0_0.getAssistBoss(arg_18_0)
	return arg_18_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.assistBoss][1]
end

function var_0_0.getASFDEntityMo(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.sideDic[arg_19_1]
	local var_19_1 = var_19_0 and var_19_0[var_0_1.ASFD_emitter]

	return var_19_1 and var_19_1[1]
end

function var_0_0.getDeadList(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2 or {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0.entityDataDic) do
		if iter_20_1.side == arg_20_1 and iter_20_1:isStatusDead() then
			table.insert(var_20_0, iter_20_1)
		end
	end

	return var_20_0
end

function var_0_0.getMyDeadList(arg_21_0, arg_21_1)
	return arg_21_0:getDeadList(FightEnum.EntitySide.MySide, arg_21_1)
end

function var_0_0.getEnemyDeadList(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0:getDeadList(FightEnum.EntitySide.EnemySide, arg_22_2)
end

function var_0_0.getList(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_3 or {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.sideDic[arg_23_1][arg_23_2]) do
		local var_23_1 = false

		if iter_23_1:isStatusDead() and not arg_23_4 then
			var_23_1 = true
		end

		if not var_23_1 then
			table.insert(var_23_0, iter_23_1)
		end
	end

	return var_23_0
end

function var_0_0.getOriginSide(arg_24_0, arg_24_1)
	return arg_24_0.sideDic[arg_24_1]
end

function var_0_0.getOriginNormalList(arg_25_0, arg_25_1)
	return arg_25_0.sideDic[arg_25_1][var_0_1.normal]
end

function var_0_0.getOriginSubList(arg_26_0, arg_26_1)
	return arg_26_0.sideDic[arg_26_1][var_0_1.sub]
end

function var_0_0.getOriginSpList(arg_27_0, arg_27_1)
	return arg_27_0.sideDic[arg_27_1][var_0_1.sp]
end

function var_0_0.getOriginASFDEmitterList(arg_28_0, arg_28_1)
	return arg_28_0.sideDic[arg_28_1][var_0_1.ASFD_emitter]
end

function var_0_0.getOriginListById(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getById(arg_29_1)

	if var_29_0 then
		local var_29_1 = var_29_0.side
		local var_29_2 = arg_29_0.sideDic[var_29_1]

		for iter_29_0, iter_29_1 in pairs(var_29_2) do
			for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
				if iter_29_3.uid == var_29_0.uid then
					return iter_29_1
				end
			end
		end
	end

	return {}
end

function var_0_0.isSub(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.sideDic) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1[var_0_1.sub]) do
			if iter_30_3.id == arg_30_1 then
				return true
			end
		end
	end
end

function var_0_0.isMySub(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sub]) do
		if iter_31_1.id == arg_31_1 then
			return true
		end
	end
end

function var_0_0.isSp(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.sideDic) do
		for iter_32_2, iter_32_3 in ipairs(iter_32_1[var_0_1.sp]) do
			if iter_32_3.id == arg_32_1 then
				return true
			end
		end
	end
end

function var_0_0.isAssistBoss(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getAssistBoss()

	return var_33_0 and var_33_0.id == arg_33_1
end

function var_0_0.isMySp(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sp]) do
		if iter_34_1.id == arg_34_1 then
			return true
		end
	end
end

function var_0_0.addDeadUid(arg_35_0, arg_35_1)
	arg_35_0.deadUids[arg_35_1] = true
end

function var_0_0.isDeadUid(arg_36_0, arg_36_1)
	return arg_36_0.deadUids[arg_36_1]
end

function var_0_0.removeEntity(arg_37_0, arg_37_1)
	if not arg_37_1 then
		return
	end

	local var_37_0 = arg_37_0.entityDataDic[arg_37_1]

	if not var_37_0 then
		return
	end

	arg_37_0.entityDataDic[arg_37_1] = nil

	for iter_37_0, iter_37_1 in pairs(arg_37_0.sideDic) do
		for iter_37_2, iter_37_3 in pairs(iter_37_1) do
			for iter_37_4, iter_37_5 in ipairs(iter_37_3) do
				if iter_37_5.id == var_37_0.id then
					table.remove(iter_37_3, iter_37_4)

					break
				end
			end
		end
	end

	return var_37_0
end

function var_0_0.getById(arg_38_0, arg_38_1)
	return arg_38_0.entityDataDic[arg_38_1]
end

function var_0_0.getByPosId(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.sideDic[arg_39_1]) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
			if not iter_39_3:isStatusDead() and iter_39_3.position == arg_39_2 then
				return iter_39_3
			end
		end
	end
end

function var_0_0.getOldEntityMO(arg_40_0, arg_40_1)
	local var_40_0 = FightEntityMO.New()

	FightDataUtil.coverData(arg_40_0:getById(arg_40_1), var_40_0)

	return var_40_0
end

function var_0_0.getAllEntityData(arg_41_0)
	return arg_41_0.entityDataDic
end

function var_0_0.getAllEntityMO(arg_42_0)
	return arg_42_0.entityDataDic
end

function var_0_0.addEntityMO(arg_43_0, arg_43_1)
	return arg_43_0:refreshEntityByEntityMO(arg_43_1)
end

function var_0_0.replaceEntityMO(arg_44_0, arg_44_1)
	return arg_44_0:refreshEntityByEntityMO(arg_44_1)
end

function var_0_0.refreshEntityByEntityMO(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0.entityDataDic[arg_45_1.id]

	if not var_45_0 then
		var_45_0 = FightEntityMO.New()
		arg_45_0.entityDataDic[arg_45_1.id] = var_45_0
	end

	FightEntityDataHelper.copyEntityMO(arg_45_1, var_45_0)
	arg_45_0.dataMgr.entityExMgr:setEXDataAfterAddEntityMO(arg_45_1)

	if var_45_0:isASFDEmitter() then
		FightDataHelper.ASFDDataMgr:setEmitterEntityMo(var_45_0)
	end

	return var_45_0
end

function var_0_0.addEntityMOByProto(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = FightEntityMO.New()

	var_46_0:init(arg_46_1, arg_46_2)

	if FightModel.instance:getVersion() >= 4 then
		if var_46_0:isStatusDead() then
			arg_46_0:addDeadUid(var_46_0.id)
		end
	elseif var_46_0.currentHp <= 0 then
		var_46_0:setDead()
		arg_46_0:addDeadUid(var_46_0.id)
	end

	return arg_46_0:addEntityMO(var_46_0)
end

function var_0_0.initEntityListByProto(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	tabletool.clear(arg_47_3)

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		table.insert(arg_47_3, arg_47_0:addEntityMOByProto(iter_47_1, arg_47_2))
	end
end

function var_0_0.initOneEntityListByProto(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	tabletool.clear(arg_48_3)
	table.insert(arg_48_3, arg_48_0:addEntityMOByProto(arg_48_1, arg_48_2))
end

function var_0_0.updateData(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0.sideDic[FightEnum.EntitySide.MySide]
	local var_49_1 = arg_49_0.sideDic[FightEnum.EntitySide.EnemySide]

	if arg_49_1.attacker.playerEntity then
		arg_49_0:initOneEntityListByProto(arg_49_1.attacker.playerEntity, FightEnum.EntitySide.MySide, var_49_0[var_0_1.player])
	end

	arg_49_0:initEntityListByProto(arg_49_1.attacker.entitys, FightEnum.EntitySide.MySide, var_49_0[var_0_1.normal])
	arg_49_0:initEntityListByProto(arg_49_1.attacker.subEntitys, FightEnum.EntitySide.MySide, var_49_0[var_0_1.sub])
	arg_49_0:initEntityListByProto(arg_49_1.attacker.spEntitys, FightEnum.EntitySide.MySide, var_49_0[var_0_1.sp])

	if arg_49_1.attacker.assistBoss then
		arg_49_0:initOneEntityListByProto(arg_49_1.attacker.assistBoss, FightEnum.EntitySide.MySide, var_49_0[var_0_1.assistBoss])
	end

	if arg_49_1.attacker.emitter then
		arg_49_0:initOneEntityListByProto(arg_49_1.attacker.emitter, FightEnum.EntitySide.MySide, var_49_0[var_0_1.ASFD_emitter])
	end

	if arg_49_1.defender.playerEntity then
		arg_49_0:initOneEntityListByProto(arg_49_1.defender.playerEntity, FightEnum.EntitySide.EnemySide, var_49_1[var_0_1.player])
	end

	arg_49_0:initEntityListByProto(arg_49_1.defender.entitys, FightEnum.EntitySide.EnemySide, var_49_1[var_0_1.normal])
	arg_49_0:initEntityListByProto(arg_49_1.defender.subEntitys, FightEnum.EntitySide.EnemySide, var_49_1[var_0_1.sub])
	arg_49_0:initEntityListByProto(arg_49_1.defender.spEntitys, FightEnum.EntitySide.EnemySide, var_49_1[var_0_1.sp])

	if arg_49_1.defender.emitter then
		arg_49_0:initOneEntityListByProto(arg_49_1.defender.emitter, FightEnum.EntitySide.EnemySide, var_49_1[var_0_1.ASFD_emitter])
	end
end

function var_0_0.clientTestSetEntity(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	arg_50_0:clientSetEntityList(arg_50_1, var_0_1.normal, arg_50_2)
	arg_50_0:clientSetEntityList(arg_50_1, var_0_1.sub, arg_50_3)
end

function var_0_0.clientSetEntityList(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_0.sideDic[arg_51_1][arg_51_2]

	tabletool.clear(var_51_0)

	for iter_51_0, iter_51_1 in ipairs(arg_51_3) do
		local var_51_1 = arg_51_0:addEntityMO(iter_51_1)

		table.insert(var_51_0, var_51_1)
	end
end

function var_0_0.clientSetSubEntityList(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0:clientSetEntityList(arg_52_1, var_0_1.sub, arg_52_2)
end

return var_0_0
