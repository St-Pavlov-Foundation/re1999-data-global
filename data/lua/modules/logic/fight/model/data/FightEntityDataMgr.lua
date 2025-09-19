module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightEntityDataMgr", FightDataMgrBase)
local var_0_1 = {
	normal = "normal",
	assistBoss = "assistBoss",
	ASFD_emitter = "ASFD_emitter",
	sp = "sp",
	sub = "sub",
	vorpalith = "vorpalith",
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

function var_0_0.getVorpalith(arg_19_0)
	return arg_19_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.vorpalith][1]
end

function var_0_0.getASFDEntityMo(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.sideDic[arg_20_1]
	local var_20_1 = var_20_0 and var_20_0[var_0_1.ASFD_emitter]

	return var_20_1 and var_20_1[1]
end

function var_0_0.getDeadList(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_2 or {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.entityDataDic) do
		if iter_21_1.side == arg_21_1 and iter_21_1:isStatusDead() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	return var_21_0
end

function var_0_0.getMyDeadList(arg_22_0, arg_22_1)
	return arg_22_0:getDeadList(FightEnum.EntitySide.MySide, arg_22_1)
end

function var_0_0.getEnemyDeadList(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0:getDeadList(FightEnum.EntitySide.EnemySide, arg_23_2)
end

function var_0_0.getList(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_3 or {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.sideDic[arg_24_1][arg_24_2]) do
		local var_24_1 = false

		if iter_24_1:isStatusDead() and not arg_24_4 then
			var_24_1 = true
		end

		if not var_24_1 then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0.getOriginSide(arg_25_0, arg_25_1)
	return arg_25_0.sideDic[arg_25_1]
end

function var_0_0.getOriginNormalList(arg_26_0, arg_26_1)
	return arg_26_0.sideDic[arg_26_1][var_0_1.normal]
end

function var_0_0.getOriginSubList(arg_27_0, arg_27_1)
	return arg_27_0.sideDic[arg_27_1][var_0_1.sub]
end

function var_0_0.getOriginSpList(arg_28_0, arg_28_1)
	return arg_28_0.sideDic[arg_28_1][var_0_1.sp]
end

function var_0_0.getOriginASFDEmitterList(arg_29_0, arg_29_1)
	return arg_29_0.sideDic[arg_29_1][var_0_1.ASFD_emitter]
end

function var_0_0.getOriginListById(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getById(arg_30_1)

	if var_30_0 then
		local var_30_1 = var_30_0.side
		local var_30_2 = arg_30_0.sideDic[var_30_1]

		for iter_30_0, iter_30_1 in pairs(var_30_2) do
			for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
				if iter_30_3.uid == var_30_0.uid then
					return iter_30_1
				end
			end
		end
	end

	return {}
end

function var_0_0.isSub(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.sideDic) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1[var_0_1.sub]) do
			if iter_31_3.id == arg_31_1 then
				return true
			end
		end
	end
end

function var_0_0.isMySub(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sub]) do
		if iter_32_1.id == arg_32_1 then
			return true
		end
	end
end

function var_0_0.isSp(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.sideDic) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1[var_0_1.sp]) do
			if iter_33_3.id == arg_33_1 then
				return true
			end
		end
	end
end

function var_0_0.isAssistBoss(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getAssistBoss()

	return var_34_0 and var_34_0.id == arg_34_1
end

function var_0_0.isMySp(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sp]) do
		if iter_35_1.id == arg_35_1 then
			return true
		end
	end
end

function var_0_0.addDeadUid(arg_36_0, arg_36_1)
	arg_36_0.deadUids[arg_36_1] = true
end

function var_0_0.isDeadUid(arg_37_0, arg_37_1)
	return arg_37_0.deadUids[arg_37_1]
end

function var_0_0.removeEntity(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	local var_38_0 = arg_38_0.entityDataDic[arg_38_1]

	if not var_38_0 then
		return
	end

	arg_38_0.entityDataDic[arg_38_1] = nil

	for iter_38_0, iter_38_1 in pairs(arg_38_0.sideDic) do
		for iter_38_2, iter_38_3 in pairs(iter_38_1) do
			for iter_38_4, iter_38_5 in ipairs(iter_38_3) do
				if iter_38_5.id == var_38_0.id then
					table.remove(iter_38_3, iter_38_4)

					break
				end
			end
		end
	end

	return var_38_0
end

function var_0_0.getById(arg_39_0, arg_39_1)
	return arg_39_0.entityDataDic[arg_39_1]
end

function var_0_0.getByPosId(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.sideDic[arg_40_1]) do
		for iter_40_2, iter_40_3 in ipairs(iter_40_1) do
			if not iter_40_3:isStatusDead() and iter_40_3.position == arg_40_2 then
				return iter_40_3
			end
		end
	end
end

function var_0_0.getOldEntityMO(arg_41_0, arg_41_1)
	local var_41_0 = FightEntityMO.New()

	FightDataUtil.coverData(arg_41_0:getById(arg_41_1), var_41_0)

	return var_41_0
end

function var_0_0.getAllEntityData(arg_42_0)
	return arg_42_0.entityDataDic
end

function var_0_0.getAllEntityMO(arg_43_0)
	return arg_43_0.entityDataDic
end

function var_0_0.addEntityMO(arg_44_0, arg_44_1)
	return arg_44_0:refreshEntityByEntityMO(arg_44_1)
end

function var_0_0.replaceEntityMO(arg_45_0, arg_45_1)
	return arg_45_0:refreshEntityByEntityMO(arg_45_1)
end

function var_0_0.refreshEntityByEntityMO(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.entityDataDic[arg_46_1.id]

	if not var_46_0 then
		var_46_0 = FightEntityMO.New()
		arg_46_0.entityDataDic[arg_46_1.id] = var_46_0
	end

	FightEntityDataHelper.copyEntityMO(arg_46_1, var_46_0)
	arg_46_0.dataMgr.entityExMgr:setEXDataAfterAddEntityMO(arg_46_1)

	if var_46_0:isASFDEmitter() then
		FightDataHelper.ASFDDataMgr:setEmitterEntityMo(var_46_0)
	end

	return var_46_0
end

function var_0_0.addEntityMOByProto(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = FightEntityMO.New()

	var_47_0:init(arg_47_1, arg_47_2)

	if FightModel.instance:getVersion() >= 4 then
		if var_47_0:isStatusDead() then
			arg_47_0:addDeadUid(var_47_0.id)
		end
	elseif var_47_0.currentHp <= 0 then
		var_47_0:setDead()
		arg_47_0:addDeadUid(var_47_0.id)
	end

	return arg_47_0:addEntityMO(var_47_0)
end

function var_0_0.initEntityListByProto(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	tabletool.clear(arg_48_3)

	for iter_48_0, iter_48_1 in ipairs(arg_48_1) do
		table.insert(arg_48_3, arg_48_0:addEntityMOByProto(iter_48_1, arg_48_2))
	end
end

function var_0_0.initOneEntityListByProto(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	tabletool.clear(arg_49_3)
	table.insert(arg_49_3, arg_49_0:addEntityMOByProto(arg_49_1, arg_49_2))
end

function var_0_0.updateData(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.sideDic[FightEnum.EntitySide.MySide]
	local var_50_1 = arg_50_0.sideDic[FightEnum.EntitySide.EnemySide]

	if arg_50_1.attacker.playerEntity then
		arg_50_0:initOneEntityListByProto(arg_50_1.attacker.playerEntity, FightEnum.EntitySide.MySide, var_50_0[var_0_1.player])
	end

	arg_50_0:initEntityListByProto(arg_50_1.attacker.entitys, FightEnum.EntitySide.MySide, var_50_0[var_0_1.normal])
	arg_50_0:initEntityListByProto(arg_50_1.attacker.subEntitys, FightEnum.EntitySide.MySide, var_50_0[var_0_1.sub])
	arg_50_0:initEntityListByProto(arg_50_1.attacker.spEntitys, FightEnum.EntitySide.MySide, var_50_0[var_0_1.sp])

	if arg_50_1.attacker.assistBoss then
		arg_50_0:initOneEntityListByProto(arg_50_1.attacker.assistBoss, FightEnum.EntitySide.MySide, var_50_0[var_0_1.assistBoss])
	end

	if arg_50_1.attacker.emitter then
		arg_50_0:initOneEntityListByProto(arg_50_1.attacker.emitter, FightEnum.EntitySide.MySide, var_50_0[var_0_1.ASFD_emitter])
	end

	if arg_50_1.attacker.vorpalith then
		arg_50_0:initOneEntityListByProto(arg_50_1.attacker.vorpalith, FightEnum.EntitySide.MySide, var_50_0[var_0_1.vorpalith])
	end

	if arg_50_1.defender.playerEntity then
		arg_50_0:initOneEntityListByProto(arg_50_1.defender.playerEntity, FightEnum.EntitySide.EnemySide, var_50_1[var_0_1.player])
	end

	arg_50_0:initEntityListByProto(arg_50_1.defender.entitys, FightEnum.EntitySide.EnemySide, var_50_1[var_0_1.normal])
	arg_50_0:initEntityListByProto(arg_50_1.defender.subEntitys, FightEnum.EntitySide.EnemySide, var_50_1[var_0_1.sub])
	arg_50_0:initEntityListByProto(arg_50_1.defender.spEntitys, FightEnum.EntitySide.EnemySide, var_50_1[var_0_1.sp])

	if arg_50_1.defender.emitter then
		arg_50_0:initOneEntityListByProto(arg_50_1.defender.emitter, FightEnum.EntitySide.EnemySide, var_50_1[var_0_1.ASFD_emitter])
	end
end

function var_0_0.clientTestSetEntity(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	arg_51_0:clientSetEntityList(arg_51_1, var_0_1.normal, arg_51_2)
	arg_51_0:clientSetEntityList(arg_51_1, var_0_1.sub, arg_51_3)
end

function var_0_0.clientSetEntityList(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_0.sideDic[arg_52_1][arg_52_2]

	tabletool.clear(var_52_0)

	for iter_52_0, iter_52_1 in ipairs(arg_52_3) do
		local var_52_1 = arg_52_0:addEntityMO(iter_52_1)

		table.insert(var_52_0, var_52_1)
	end
end

function var_0_0.clientSetSubEntityList(arg_53_0, arg_53_1, arg_53_2)
	arg_53_0:clientSetEntityList(arg_53_1, var_0_1.sub, arg_53_2)
end

return var_0_0
