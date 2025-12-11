module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightEntityDataMgr", FightDataMgrBase)
local var_0_1 = {
	normal = "normal",
	assistBoss = "assistBoss",
	ASFD_emitter = "ASFD_emitter",
	sp = "sp",
	sub = "sub",
	vorpalith = "vorpalith",
	spFightEntities = "spFightEntities",
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
	arg_1_0.heroId2SkinId = {}
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

function var_0_0.getSpFightEntities(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	return arg_24_0:getList(arg_24_1, var_0_1.spFightEntities, arg_24_2, arg_24_3)
end

function var_0_0.getMySpFightEntities(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_0:getSpFightEntities(FightEnum.EntitySide.MySide, arg_25_1, arg_25_2)
end

function var_0_0.getEnemySpFightEntities(arg_26_0, arg_26_1, arg_26_2)
	return arg_26_0:getSpFightEntities(FightEnum.EntitySide.EnemySide, arg_26_1, arg_26_2)
end

function var_0_0.getList(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_3 or {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.sideDic[arg_27_1][arg_27_2]) do
		local var_27_1 = false

		if iter_27_1:isStatusDead() and not arg_27_4 then
			var_27_1 = true
		end

		if not var_27_1 then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_0.getOriginSide(arg_28_0, arg_28_1)
	return arg_28_0.sideDic[arg_28_1]
end

function var_0_0.getOriginNormalList(arg_29_0, arg_29_1)
	return arg_29_0.sideDic[arg_29_1][var_0_1.normal]
end

function var_0_0.getOriginSubList(arg_30_0, arg_30_1)
	return arg_30_0.sideDic[arg_30_1][var_0_1.sub]
end

function var_0_0.getOriginSpList(arg_31_0, arg_31_1)
	return arg_31_0.sideDic[arg_31_1][var_0_1.sp]
end

function var_0_0.getOriginASFDEmitterList(arg_32_0, arg_32_1)
	return arg_32_0.sideDic[arg_32_1][var_0_1.ASFD_emitter]
end

function var_0_0.getOriginListById(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getById(arg_33_1)

	if var_33_0 then
		local var_33_1 = var_33_0.side
		local var_33_2 = arg_33_0.sideDic[var_33_1]

		for iter_33_0, iter_33_1 in pairs(var_33_2) do
			for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
				if iter_33_3.uid == var_33_0.uid then
					return iter_33_1
				end
			end
		end
	end

	return {}
end

function var_0_0.isSub(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in pairs(arg_34_0.sideDic) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1[var_0_1.sub]) do
			if iter_34_3.id == arg_34_1 then
				return true
			end
		end
	end
end

function var_0_0.isMySub(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sub]) do
		if iter_35_1.id == arg_35_1 then
			return true
		end
	end
end

function var_0_0.isSp(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.sideDic) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1[var_0_1.sp]) do
			if iter_36_3.id == arg_36_1 then
				return true
			end
		end
	end
end

function var_0_0.isAssistBoss(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getAssistBoss()

	return var_37_0 and var_37_0.id == arg_37_1
end

function var_0_0.isAct191Boss(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.entityDataDic[arg_38_1]

	if not var_38_0 then
		return false
	end

	if var_38_0.entityType == FightEnum.EntityType.Act191Boss then
		return true
	end
end

function var_0_0.isMySp(arg_39_0, arg_39_1)
	for iter_39_0, iter_39_1 in ipairs(arg_39_0.sideDic[FightEnum.EntitySide.MySide][var_0_1.sp]) do
		if iter_39_1.id == arg_39_1 then
			return true
		end
	end
end

function var_0_0.addDeadUid(arg_40_0, arg_40_1)
	arg_40_0.deadUids[arg_40_1] = true
end

function var_0_0.isDeadUid(arg_41_0, arg_41_1)
	return arg_41_0.deadUids[arg_41_1]
end

function var_0_0.removeEntity(arg_42_0, arg_42_1)
	if not arg_42_1 then
		return
	end

	local var_42_0 = arg_42_0.entityDataDic[arg_42_1]

	if not var_42_0 then
		return
	end

	arg_42_0.entityDataDic[arg_42_1] = nil

	for iter_42_0, iter_42_1 in pairs(arg_42_0.sideDic) do
		for iter_42_2, iter_42_3 in pairs(iter_42_1) do
			for iter_42_4, iter_42_5 in ipairs(iter_42_3) do
				if iter_42_5.id == var_42_0.id then
					table.remove(iter_42_3, iter_42_4)

					break
				end
			end
		end
	end

	return var_42_0
end

function var_0_0.getById(arg_43_0, arg_43_1)
	return arg_43_0.entityDataDic[arg_43_1]
end

function var_0_0.getByPosId(arg_44_0, arg_44_1, arg_44_2)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.sideDic[arg_44_1]) do
		for iter_44_2, iter_44_3 in ipairs(iter_44_1) do
			if not iter_44_3:isStatusDead() and iter_44_3.position == arg_44_2 then
				return iter_44_3
			end
		end
	end
end

function var_0_0.getOldEntityMO(arg_45_0, arg_45_1)
	local var_45_0 = FightEntityMO.New()

	FightDataUtil.coverData(arg_45_0:getById(arg_45_1), var_45_0)

	return var_45_0
end

function var_0_0.getAllEntityData(arg_46_0)
	return arg_46_0.entityDataDic
end

function var_0_0.getAllEntityMO(arg_47_0)
	return arg_47_0.entityDataDic
end

function var_0_0.addEntityMO(arg_48_0, arg_48_1)
	return arg_48_0:refreshEntityByEntityMO(arg_48_1)
end

function var_0_0.replaceEntityMO(arg_49_0, arg_49_1)
	return arg_49_0:refreshEntityByEntityMO(arg_49_1)
end

function var_0_0.refreshEntityByEntityMO(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.entityDataDic[arg_50_1.id]

	if not var_50_0 then
		var_50_0 = FightEntityMO.New()
		arg_50_0.entityDataDic[arg_50_1.id] = var_50_0
	end

	FightEntityDataHelper.copyEntityMO(arg_50_1, var_50_0)

	if var_50_0:isASFDEmitter() then
		FightDataHelper.ASFDDataMgr:setEmitterEntityMo(var_50_0)
	end

	arg_50_0.heroId2SkinId[var_50_0.modelId] = var_50_0.skin

	return var_50_0
end

function var_0_0.addEntityMOByProto(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = FightEntityMO.New()

	var_51_0:init(arg_51_1, arg_51_2)

	if FightModel.instance:getVersion() >= 4 then
		if var_51_0:isStatusDead() then
			arg_51_0:addDeadUid(var_51_0.id)
		end
	elseif var_51_0.currentHp <= 0 then
		var_51_0:setDead()
		arg_51_0:addDeadUid(var_51_0.id)
	end

	return arg_51_0:addEntityMO(var_51_0)
end

function var_0_0.initEntityListByProto(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	tabletool.clear(arg_52_3)

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		table.insert(arg_52_3, arg_52_0:addEntityMOByProto(iter_52_1, arg_52_2))
	end
end

function var_0_0.initOneEntityListByProto(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	tabletool.clear(arg_53_3)
	table.insert(arg_53_3, arg_53_0:addEntityMOByProto(arg_53_1, arg_53_2))
end

function var_0_0.updateData(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.sideDic[FightEnum.EntitySide.MySide]
	local var_54_1 = arg_54_0.sideDic[FightEnum.EntitySide.EnemySide]

	if arg_54_1.attacker.playerEntity then
		arg_54_0:initOneEntityListByProto(arg_54_1.attacker.playerEntity, FightEnum.EntitySide.MySide, var_54_0[var_0_1.player])
	end

	arg_54_0:initEntityListByProto(arg_54_1.attacker.entitys, FightEnum.EntitySide.MySide, var_54_0[var_0_1.normal])
	arg_54_0:initEntityListByProto(arg_54_1.attacker.subEntitys, FightEnum.EntitySide.MySide, var_54_0[var_0_1.sub])
	arg_54_0:initEntityListByProto(arg_54_1.attacker.spEntitys, FightEnum.EntitySide.MySide, var_54_0[var_0_1.sp])
	arg_54_0:initEntityListByProto(arg_54_1.attacker.spFightEntities, FightEnum.EntitySide.MySide, var_54_0[var_0_1.spFightEntities])

	if arg_54_1.attacker.assistBoss then
		arg_54_0:initOneEntityListByProto(arg_54_1.attacker.assistBoss, FightEnum.EntitySide.MySide, var_54_0[var_0_1.assistBoss])
	end

	if arg_54_1.attacker.emitter then
		arg_54_0:initOneEntityListByProto(arg_54_1.attacker.emitter, FightEnum.EntitySide.MySide, var_54_0[var_0_1.ASFD_emitter])
	end

	if arg_54_1.attacker.vorpalith then
		arg_54_0:initOneEntityListByProto(arg_54_1.attacker.vorpalith, FightEnum.EntitySide.MySide, var_54_0[var_0_1.vorpalith])
	end

	if arg_54_1.defender.playerEntity then
		arg_54_0:initOneEntityListByProto(arg_54_1.defender.playerEntity, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.player])
	end

	arg_54_0:initEntityListByProto(arg_54_1.defender.entitys, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.normal])
	arg_54_0:initEntityListByProto(arg_54_1.defender.subEntitys, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.sub])
	arg_54_0:initEntityListByProto(arg_54_1.defender.spEntitys, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.sp])
	arg_54_0:initEntityListByProto(arg_54_1.defender.spFightEntities, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.spFightEntities])

	if arg_54_1.defender.emitter then
		arg_54_0:initOneEntityListByProto(arg_54_1.defender.emitter, FightEnum.EntitySide.EnemySide, var_54_1[var_0_1.ASFD_emitter])
	end
end

function var_0_0.clientTestSetEntity(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	arg_55_0:clientSetEntityList(arg_55_1, var_0_1.normal, arg_55_2)
	arg_55_0:clientSetEntityList(arg_55_1, var_0_1.sub, arg_55_3)
end

function var_0_0.clientSetEntityList(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = arg_56_0.sideDic[arg_56_1][arg_56_2]

	tabletool.clear(var_56_0)

	for iter_56_0, iter_56_1 in ipairs(arg_56_3) do
		local var_56_1 = arg_56_0:addEntityMO(iter_56_1)

		table.insert(var_56_0, var_56_1)
	end
end

function var_0_0.clientSetSubEntityList(arg_57_0, arg_57_1, arg_57_2)
	arg_57_0:clientSetEntityList(arg_57_1, var_0_1.sub, arg_57_2)
end

function var_0_0.getHeroSkin(arg_58_0, arg_58_1)
	return arg_58_0.heroId2SkinId[arg_58_1]
end

return var_0_0
