module("modules.logic.fight.model.mo.FightEntityMO", package.seeall)

local var_0_0 = pureTable("FightEntityMO")

if SLFramework.FrameworkSettings.IsEditor then
	function var_0_0.__newindex(arg_1_0, arg_1_1, arg_1_2)
		if type(arg_1_2) == "userdata" or type(arg_1_2) == "function" then
			error("pureTable instance object field not support userdata or function,key=" .. arg_1_1)
		else
			if type(arg_1_2) == "table" and arg_1_2._cached_byte_size then
				logError("entityMO不可以直接引用protobuf数据,请构建一个数据")
			end

			rawset(arg_1_0, arg_1_1, arg_1_2)
		end
	end
end

function var_0_0.ctor(arg_2_0)
	arg_2_0.buffDic = {}
	arg_2_0.playCardExPoint = 0
	arg_2_0.moveCardExPoint = 0
	arg_2_0.skillList = {}
	arg_2_0.skillId2Lv = {}
	arg_2_0.skillNextLvId = {}
	arg_2_0.skillPrevLvId = {}
	arg_2_0.skillGroup1 = {}
	arg_2_0.skillGroup2 = {}
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._playCardAddExpoint = 1
	arg_3_0._moveCardAddExpoint = 1
	arg_3_0._combineCardAddExpoint = 1
	arg_3_0.expointMaxAdd = arg_3_1.expointMaxAdd
	arg_3_0.exSkillPointChange = arg_3_1.exSkillPointChange or 0
	arg_3_0.id = arg_3_1.uid
	arg_3_0.uid = arg_3_1.uid
	arg_3_0.modelId = arg_3_1.modelId
	arg_3_0.skin = arg_3_0:initSkin(arg_3_1)
	arg_3_0.originSkin = arg_3_0.skin
	arg_3_0.position = arg_3_1.position
	arg_3_0.entityType = arg_3_1.entityType
	arg_3_0.userId = arg_3_1.userId

	arg_3_0:setExPoint(arg_3_1.exPoint)

	arg_3_0.level = arg_3_1.level
	arg_3_0.currentHp = arg_3_1.currentHp
	arg_3_0.attrMO = arg_3_0:_buildAttr(arg_3_1.attr)

	arg_3_0:_buildBuffs(arg_3_1.buffs)
	arg_3_0:_buildSkills(arg_3_1)

	arg_3_0.shieldValue = arg_3_1.shieldValue
	arg_3_0.equipUid = arg_3_1.equipUid
	arg_3_0.trialId = arg_3_1.trialId

	if arg_3_1.trialEquip then
		arg_3_0.trialEquip = {}
		arg_3_0.trialEquip.equipUid = arg_3_1.trialEquip.equipUid
		arg_3_0.trialEquip.equipId = arg_3_1.trialEquip.equipId
		arg_3_0.trialEquip.equipLv = arg_3_1.trialEquip.equipLv
		arg_3_0.trialEquip.refineLv = arg_3_1.trialEquip.refineLv
	else
		arg_3_0.trialEquip = nil
	end

	arg_3_0.exSkillLevel = arg_3_1.exSkillLevel

	if FightModel.instance:getVersion() >= 1 then
		arg_3_0.side = arg_3_1.teamType == FightEnum.TeamType.MySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide
	else
		arg_3_0.side = arg_3_2
	end

	arg_3_0._powerInfos = {}

	arg_3_0:setPowerInfos(arg_3_1.powerInfos)
	arg_3_0:buildSummonedInfo(arg_3_1.SummonedList)

	arg_3_0.teamType = arg_3_1.teamType

	arg_3_0:buildEnhanceInfoBox(arg_3_1.enhanceInfoBox)

	arg_3_0.career = arg_3_1.career

	arg_3_0:updateStoredExPoint()

	arg_3_0.status = arg_3_1.status
	arg_3_0.guard = arg_3_1.guard
	arg_3_0.subCd = arg_3_1.subCd
	arg_3_0.exPointType = arg_3_1.exPointType
	arg_3_0.equipRecord = arg_3_1.equipRecord
	arg_3_0.destinyStone = arg_3_1.destinyStone
	arg_3_0.destinyRank = arg_3_1.destinyRank
	arg_3_0.customUnitId = arg_3_1.customUnitId
end

function var_0_0._buildAttr(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.attrMO or HeroAttributeMO.New()

	var_4_0:init(arg_4_1)

	return var_4_0
end

function var_0_0._buildBuffs(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = FightBuffMO.New()

		var_5_0:init(iter_5_1, arg_5_0.id)

		arg_5_0.buffDic[var_5_0.uid] = var_5_0
	end

	arg_5_0:_dealBuffFeature()
end

function var_0_0._buildSkills(arg_6_0, arg_6_1)
	arg_6_0.skillList = {}
	arg_6_0.skillId2Lv = {}
	arg_6_0.skillNextLvId = {}
	arg_6_0.skillPrevLvId = {}
	arg_6_0.passiveSkillDic = {}
	arg_6_0.skillGroup1 = {}
	arg_6_0.skillGroup2 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.skillGroup1) do
		table.insert(arg_6_0.skillList, iter_6_1)
		table.insert(arg_6_0.skillGroup1, iter_6_1)

		arg_6_0.skillId2Lv[iter_6_1] = iter_6_0
		arg_6_0.skillNextLvId[iter_6_1] = arg_6_1.skillGroup1[iter_6_0 + 1]
		arg_6_0.skillPrevLvId[iter_6_1] = arg_6_1.skillGroup1[iter_6_0 - 1]
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.skillGroup2) do
		table.insert(arg_6_0.skillList, iter_6_3)
		table.insert(arg_6_0.skillGroup2, iter_6_3)

		arg_6_0.skillId2Lv[iter_6_3] = iter_6_2
		arg_6_0.skillNextLvId[iter_6_3] = arg_6_1.skillGroup2[iter_6_2 + 1]
		arg_6_0.skillPrevLvId[iter_6_3] = arg_6_1.skillGroup2[iter_6_2 - 1]
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_1.passiveSkill) do
		table.insert(arg_6_0.skillList, iter_6_5)

		arg_6_0.passiveSkillDic[iter_6_5] = true
	end

	table.insert(arg_6_0.skillList, arg_6_1.exSkill)

	arg_6_0.skillId2Lv[arg_6_1.exSkill] = 4
	arg_6_0.exSkill = arg_6_1.exSkill
end

function var_0_0.addPassiveSkill(arg_7_0, arg_7_1)
	if arg_7_0.passiveSkillDic then
		arg_7_0.passiveSkillDic[arg_7_1] = true
	end

	if arg_7_0.skillList and not tabletool.indexOf(arg_7_0.skillList, arg_7_1) then
		table.insert(arg_7_0.skillList, arg_7_1)
	end
end

function var_0_0.removePassiveSkill(arg_8_0, arg_8_1)
	if arg_8_0.passiveSkillDic then
		arg_8_0.passiveSkillDic[arg_8_1] = nil
	end

	if arg_8_0.skillList then
		tabletool.removeValue(arg_8_0.skillList, arg_8_1)
	end
end

function var_0_0.isPassiveSkill(arg_9_0, arg_9_1)
	return arg_9_0.passiveSkillDic and arg_9_0.passiveSkillDic[arg_9_1]
end

function var_0_0.hasSkill(arg_10_0, arg_10_1)
	return arg_10_0.skillId2Lv[arg_10_1] ~= nil
end

function var_0_0.getSkillLv(arg_11_0, arg_11_1)
	return arg_11_0.skillId2Lv[arg_11_1] or FightConfig.instance:getSkillLv(arg_11_1)
end

function var_0_0.getSkillNextLvId(arg_12_0, arg_12_1)
	return arg_12_0.skillNextLvId[arg_12_1] or FightHelper.processNextSkillId(arg_12_1) or FightConfig.instance:getSkillNextLvId(arg_12_1)
end

function var_0_0.getSkillPrevLvId(arg_13_0, arg_13_1)
	return arg_13_0.skillPrevLvId[arg_13_1] or FightConfig.instance:getSkillPrevLvId(arg_13_1)
end

function var_0_0.isActiveSkill(arg_14_0, arg_14_1)
	return arg_14_0.skillId2Lv[arg_14_1] ~= nil or FightConfig.instance:isActiveSkill(arg_14_1)
end

function var_0_0.getBuffList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 or {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0.buffDic) do
		table.insert(var_15_0, iter_15_1)
	end

	return var_15_0
end

function var_0_0.getOrderedBuffList_ByTime(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getBuffList(arg_16_1)

	table.sort(var_16_0, arg_16_0.sortBuffByTime)

	return var_16_0
end

function var_0_0.sortBuffByTime(arg_17_0, arg_17_1)
	return arg_17_0.time < arg_17_1.time
end

function var_0_0.getBuffDic(arg_18_0)
	return arg_18_0.buffDic
end

function var_0_0.addBuff(arg_19_0, arg_19_1)
	if not arg_19_0.buffDic[arg_19_1.uid] then
		local var_19_0 = FightBuffMO.New()

		var_19_0:init(arg_19_1, arg_19_0.id)

		arg_19_0.buffDic[arg_19_1.uid] = var_19_0

		arg_19_0:_dealBuffFeature()

		return true
	end
end

function var_0_0.delBuff(arg_20_0, arg_20_1)
	if arg_20_0.buffDic[arg_20_1] then
		arg_20_0.buffDic[arg_20_1] = nil

		arg_20_0:_dealBuffFeature()
	end
end

function var_0_0.updateBuff(arg_21_0, arg_21_1)
	if arg_21_0.buffDic[arg_21_1.uid] then
		arg_21_0.buffDic[arg_21_1.uid]:init(arg_21_1, arg_21_0.id)
	end
end

function var_0_0.getBuffMO(arg_22_0, arg_22_1)
	return arg_22_0.buffDic[arg_22_1]
end

function var_0_0.clearAllBuff(arg_23_0)
	tabletool.clear(arg_23_0.buffDic)
end

function var_0_0.getEntityName(arg_24_0)
	local var_24_0 = arg_24_0:getCO()

	return var_24_0 and var_24_0.name or "nil"
end

function var_0_0.isEnemySide(arg_25_0)
	return arg_25_0.side == FightEnum.EntitySide.EnemySide
end

function var_0_0.isMySide(arg_26_0)
	return arg_26_0.side == FightEnum.EntitySide.MySide
end

function var_0_0.getIdName(arg_27_0)
	local var_27_0 = arg_27_0.side == FightEnum.EntitySide.MySide and FightEnum.EntityGOName.MySide or FightEnum.EntityGOName.EnemySide

	return string.format("%s_%d", var_27_0, arg_27_0.position)
end

function var_0_0.getCO(arg_28_0)
	if arg_28_0:isCharacter() then
		return lua_character.configDict[arg_28_0.modelId]
	elseif arg_28_0:isMonster() then
		return lua_monster.configDict[arg_28_0.modelId]
	elseif arg_28_0:isAssistBoss() then
		return lua_tower_assist_boss.configDict[arg_28_0.modelId]
	elseif arg_28_0:isASFDEmitter() then
		return FightASFDConfig.instance:getASFDEmitterConfig(arg_28_0.side)
	elseif arg_28_0:isVorpalith() then
		arg_28_0.vorpalithCo = arg_28_0.vorpalithCo or {
			uniqueSkill_point = 5,
			name = "灵刃"
		}

		return arg_28_0.vorpalithCo
	end

	return lua_character.configDict[arg_28_0.modelId] or lua_monster.configDict[arg_28_0.modelId]
end

function var_0_0.isCharacter(arg_29_0)
	return arg_29_0.entityType == FightEnum.EntityType.Character
end

function var_0_0.isMonster(arg_30_0)
	return arg_30_0.entityType == FightEnum.EntityType.Monster
end

function var_0_0.isAssistBoss(arg_31_0)
	return arg_31_0.entityType == FightEnum.EntityType.AssistBoss
end

function var_0_0.isASFDEmitter(arg_32_0)
	return arg_32_0.entityType == FightEnum.EntityType.ASFDEmitter
end

function var_0_0.isVorpalith(arg_33_0)
	return arg_33_0.entityType == FightEnum.EntityType.Vorpalith
end

function var_0_0.getSpineSkinCO(arg_34_0)
	if arg_34_0:isVorpalith() then
		return
	end

	local var_34_0 = arg_34_0.skin

	if not var_34_0 then
		local var_34_1 = lua_character.configDict[arg_34_0.modelId]

		var_34_0 = var_34_1 and var_34_1.skinId
	end

	if not var_34_0 then
		local var_34_2 = lua_monster.configDict[arg_34_0.modelId]
		local var_34_3

		var_34_3 = var_34_2 and var_34_2.skinId
	end

	local var_34_4 = FightConfig.instance:getSkinCO(arg_34_0.skin)

	if var_34_4 then
		return var_34_4
	else
		if FightEntityDataHelper.isPlayerUid(arg_34_0.id) then
			return
		end

		logError("skin not exist: " .. arg_34_0.skin .. " modelId: " .. arg_34_0.modelId)
	end
end

function var_0_0.resetSimulateExPoint(arg_35_0)
	arg_35_0.playCardExPoint = 0
	arg_35_0.moveCardExPoint = 0
end

function var_0_0.applyMoveCardExPoint(arg_36_0)
	arg_36_0.moveCardExPoint = 0
	arg_36_0.playCardExPoint = 0
end

function var_0_0.getExPoint(arg_37_0)
	return arg_37_0.exPoint
end

function var_0_0.setExPoint(arg_38_0, arg_38_1)
	arg_38_0.exPoint = arg_38_1
end

function var_0_0.changeExpointMaxAdd(arg_39_0, arg_39_1)
	arg_39_0.expointMaxAdd = arg_39_0.expointMaxAdd or 0

	if arg_39_0.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	arg_39_0.expointMaxAdd = arg_39_0.expointMaxAdd + arg_39_1
end

function var_0_0.getMaxExPoint(arg_40_0)
	if not arg_40_0:getCO() then
		return 0
	end

	return arg_40_0:getConfigMaxExPoint() + arg_40_0:getExpointMaxAddNum()
end

function var_0_0.getExpointMaxAddNum(arg_41_0)
	return arg_41_0.expointMaxAdd or 0
end

function var_0_0.changeServerUniqueCost(arg_42_0, arg_42_1)
	if arg_42_0.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	arg_42_0.exSkillPointChange = arg_42_0:getExpointCostOffsetNum() + arg_42_1
end

function var_0_0.getUniqueSkillPoint(arg_43_0)
	for iter_43_0, iter_43_1 in pairs(arg_43_0.buffDic) do
		local var_43_0 = iter_43_1.buffId
		local var_43_1 = arg_43_0:getFeaturesSplitInfoByBuffId(var_43_0)

		if var_43_1 then
			for iter_43_2, iter_43_3 in ipairs(var_43_1) do
				if iter_43_3[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return arg_43_0:getConfigMaxExPoint() + arg_43_0:getExpointCostOffsetNum()
end

function var_0_0.getExpointCostOffsetNum(arg_44_0)
	return arg_44_0.exSkillPointChange or 0
end

function var_0_0.getPreviewExPoint(arg_45_0)
	return arg_45_0.exPoint + arg_45_0.moveCardExPoint + arg_45_0.playCardExPoint - FightHelper.getPredeductionExpoint(arg_45_0.id)
end

function var_0_0.onPlayCardExPoint(arg_46_0, arg_46_1)
	if not FightCardDataHelper.isBigSkill(arg_46_1) then
		local var_46_0 = arg_46_0:getMaxExPoint()

		if var_46_0 > arg_46_0:getPreviewExPoint() then
			arg_46_0.playCardExPoint = arg_46_0.playCardExPoint + arg_46_0._playCardAddExpoint

			if var_46_0 < arg_46_0:getPreviewExPoint() then
				arg_46_0.playCardExPoint = arg_46_0.playCardExPoint - (arg_46_0:getPreviewExPoint() - var_46_0)
			end
		end
	end
end

function var_0_0.onMoveCardExPoint(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1 and arg_47_0._moveCardAddExpoint or arg_47_0._combineCardAddExpoint
	local var_47_1 = arg_47_0:getMaxExPoint()

	if var_47_1 > arg_47_0:getPreviewExPoint() then
		arg_47_0.moveCardExPoint = arg_47_0.moveCardExPoint + var_47_0

		if var_47_1 < arg_47_0:getPreviewExPoint() then
			arg_47_0.moveCardExPoint = arg_47_0.moveCardExPoint - (arg_47_0:getPreviewExPoint() - var_47_1)
		end
	end
end

function var_0_0._dealBuffFeature(arg_48_0)
	arg_48_0._playCardAddExpoint = 1
	arg_48_0._moveCardAddExpoint = 1
	arg_48_0._combineCardAddExpoint = 1

	for iter_48_0, iter_48_1 in pairs(arg_48_0.buffDic) do
		local var_48_0 = iter_48_1.buffId
		local var_48_1 = arg_48_0:getFeaturesSplitInfoByBuffId(var_48_0)

		if var_48_1 then
			for iter_48_2, iter_48_3 in ipairs(var_48_1) do
				if iter_48_3[1] == 606 then
					arg_48_0._combineCardAddExpoint = arg_48_0._combineCardAddExpoint + iter_48_3[2]
				elseif iter_48_3[1] == 607 then
					arg_48_0._moveCardAddExpoint = arg_48_0._moveCardAddExpoint + iter_48_3[2]
				elseif iter_48_3[1] == 603 then
					arg_48_0._playCardAddExpoint = 0
					arg_48_0._combineCardAddExpoint = 0
					arg_48_0._moveCardAddExpoint = 0

					return
				elseif iter_48_3[1] == 845 then
					arg_48_0._playCardAddExpoint = arg_48_0._playCardAddExpoint + iter_48_3[2]
				end
			end
		end
	end
end

function var_0_0.getCombineCardAddExPoint(arg_49_0)
	return arg_49_0._combineCardAddExpoint
end

function var_0_0.getMoveCardAddExPoint(arg_50_0)
	return arg_50_0._moveCardAddExpoint
end

function var_0_0.getPlayCardAddExPoint(arg_51_0)
	return arg_51_0._playCardAddExpoint
end

function var_0_0.getFeaturesSplitInfoByBuffId(arg_52_0, arg_52_1)
	if not arg_52_0.buffFeaturesSplit then
		arg_52_0.buffFeaturesSplit = {}
	end

	if not arg_52_0.buffFeaturesSplit[arg_52_1] then
		local var_52_0 = lua_skill_buff.configDict[arg_52_1]
		local var_52_1 = var_52_0 and var_52_0.features

		if not string.nilorempty(var_52_1) then
			local var_52_2 = FightStrUtil.instance:getSplitString2Cache(var_52_1, true)

			arg_52_0.buffFeaturesSplit[arg_52_1] = var_52_2
		end
	end

	return arg_52_0.buffFeaturesSplit[arg_52_1]
end

function var_0_0.hasBuffFeature(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.buffDic) do
		local var_53_0 = iter_53_1.buffId
		local var_53_1 = arg_53_0:getFeaturesSplitInfoByBuffId(var_53_0)

		if var_53_1 then
			for iter_53_2, iter_53_3 in ipairs(var_53_1) do
				local var_53_2 = lua_buff_act.configDict[iter_53_3[1]]

				if var_53_2 and var_53_2.type == arg_53_1 then
					return true, iter_53_1
				end
			end
		end
	end
end

function var_0_0.hasBuffActId(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.buffDic) do
		local var_54_0 = iter_54_1.buffId
		local var_54_1 = arg_54_0:getFeaturesSplitInfoByBuffId(var_54_0)

		if var_54_1 then
			for iter_54_2, iter_54_3 in ipairs(var_54_1) do
				if iter_54_3[1] == arg_54_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffTypeId(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.buffDic) do
		local var_55_0 = iter_55_1:getCO()

		if var_55_0 and var_55_0.typeId == arg_55_1 then
			return true
		end
	end
end

function var_0_0.hasBuffId(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in pairs(arg_56_0.buffDic) do
		if iter_56_1.buffId == arg_56_1 then
			return true
		end
	end
end

function var_0_0.setHp(arg_57_0, arg_57_1)
	if arg_57_0:isASFDEmitter() then
		return arg_57_0:setASFDEmitterHp(arg_57_1)
	end

	arg_57_0:defaultSetHp(arg_57_1)
end

function var_0_0.defaultSetHp(arg_58_0, arg_58_1)
	if arg_58_1 < 0 then
		arg_58_1 = 0
	end

	if arg_58_1 > arg_58_0.attrMO.hp then
		arg_58_1 = arg_58_0.attrMO.hp
	end

	arg_58_0.currentHp = arg_58_1
end

function var_0_0.setASFDEmitterHp(arg_59_0, arg_59_1)
	if arg_59_1 < 0 then
		arg_59_1 = 0
	end

	arg_59_0.currentHp = arg_59_1
end

function var_0_0.setShield(arg_60_0, arg_60_1)
	arg_60_0.shieldValue = arg_60_1
end

function var_0_0.onChangeHero(arg_61_0)
	tabletool.clear(arg_61_0.buffDic)
	arg_61_0:_dealBuffFeature()
	arg_61_0:setShield(0)
end

function var_0_0.setPowerInfos(arg_62_0, arg_62_1)
	local var_62_0 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_1) do
		local var_62_1 = FightPowerInfoData.New(iter_62_1)

		var_62_0[var_62_1.powerId] = var_62_1
	end

	FightDataUtil.coverData(var_62_0, arg_62_0._powerInfos)
end

function var_0_0.refreshPowerInfo(arg_63_0, arg_63_1)
	local var_63_0 = FightPowerInfoData.New(arg_63_1)
	local var_63_1 = var_63_0.powerId

	arg_63_0._powerInfos[var_63_1] = FightDataUtil.coverData(var_63_0, arg_63_0._powerInfos[var_63_1])
end

function var_0_0.getPowerInfos(arg_64_0)
	return arg_64_0._powerInfos or {}
end

function var_0_0.getPowerInfo(arg_65_0, arg_65_1)
	return arg_65_0._powerInfos and arg_65_0._powerInfos[arg_65_1]
end

function var_0_0.hasStress(arg_66_0)
	local var_66_0 = arg_66_0._powerInfos and arg_66_0._powerInfos[FightEnum.PowerType.Stress]

	return var_66_0 and var_66_0.max > 0
end

function var_0_0.changePowerMax(arg_67_0, arg_67_1, arg_67_2)
	if arg_67_0._powerInfos and arg_67_0._powerInfos[arg_67_1] then
		arg_67_0._powerInfos[arg_67_1].max = arg_67_0._powerInfos[arg_67_1].max + arg_67_2
	end
end

function var_0_0.buildSummonedInfo(arg_68_0, arg_68_1)
	arg_68_0.summonedInfo = arg_68_0.summonedInfo or FightEntitySummonedInfo.New()

	arg_68_0.summonedInfo:init(arg_68_1)

	return arg_68_0.summonedInfo
end

function var_0_0.getSummonedInfo(arg_69_0)
	arg_69_0.summonedInfo = arg_69_0.summonedInfo or FightEntitySummonedInfo.New()

	return arg_69_0.summonedInfo
end

function var_0_0.buildEnhanceInfoBox(arg_70_0, arg_70_1)
	arg_70_0.canUpgradeIds = {}
	arg_70_0.upgradedOptions = {}

	if arg_70_1 then
		for iter_70_0, iter_70_1 in ipairs(arg_70_1.canUpgradeIds) do
			arg_70_0.canUpgradeIds[iter_70_1] = iter_70_1
		end

		for iter_70_2, iter_70_3 in ipairs(arg_70_1.upgradedOptions) do
			arg_70_0.upgradedOptions[iter_70_3] = iter_70_3
		end
	end
end

function var_0_0.getTrialAttrCo(arg_71_0)
	if not arg_71_0.trialId or arg_71_0.trialId <= 0 then
		return
	end

	local var_71_0 = lua_hero_trial.configDict[arg_71_0.trialId][0]

	if not var_71_0 then
		return
	end

	if var_71_0.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[var_71_0.attrId]
end

function var_0_0.updateStoredExPoint(arg_72_0)
	arg_72_0.storedExPoint = 0

	for iter_72_0, iter_72_1 in ipairs(arg_72_0:getBuffList()) do
		local var_72_0 = iter_72_1.actCommonParams

		if not string.nilorempty(var_72_0) then
			local var_72_1 = FightStrUtil.instance:getSplitToNumberCache(var_72_0, "#")
			local var_72_2 = var_72_1[1]
			local var_72_3 = lua_buff_act.configDict[var_72_2]

			if (var_72_3 and var_72_3.type) == FightEnum.BuffType_ExPointOverflowBank then
				arg_72_0.storedExPoint = arg_72_0.storedExPoint + var_72_1[2]
			end
		end
	end
end

function var_0_0.setStoredExPoint(arg_73_0, arg_73_1)
	arg_73_0.storedExPoint = arg_73_1
end

function var_0_0.changeStoredExPoint(arg_74_0, arg_74_1)
	arg_74_0.storedExPoint = arg_74_0.storedExPoint + arg_74_1
end

function var_0_0.getStoredExPoint(arg_75_0)
	return arg_75_0.storedExPoint
end

function var_0_0.hadStoredExPoint(arg_76_0)
	return arg_76_0.storedExPoint > 0
end

function var_0_0.getResistanceDict(arg_77_0)
	arg_77_0.resistanceDict = arg_77_0.resistanceDict or {}

	tabletool.clear(arg_77_0.resistanceDict)

	local var_77_0 = FightModel.instance:getSpAttributeMo(arg_77_0.uid)

	if var_77_0 then
		for iter_77_0, iter_77_1 in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			local var_77_1 = var_77_0[iter_77_1]

			if var_77_1 and var_77_1 > 0 then
				arg_77_0.resistanceDict[iter_77_0] = var_77_1
			end
		end
	end

	return arg_77_0.resistanceDict
end

function var_0_0.isFullResistance(arg_78_0, arg_78_1)
	local var_78_0 = FightModel.instance:getSpAttributeMo(arg_78_0.uid)

	if not var_78_0 then
		return false
	end

	local var_78_1 = var_78_0[arg_78_1]

	if not var_78_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_78_0:getEntityName(), arg_78_1))

		return false
	end

	return var_78_1 >= 1000
end

function var_0_0.isPartResistance(arg_79_0, arg_79_1)
	local var_79_0 = FightModel.instance:getSpAttributeMo(arg_79_0.uid)

	if not var_79_0 then
		return false
	end

	local var_79_1 = var_79_0[arg_79_1]

	if not var_79_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_79_0:getEntityName(), arg_79_1))

		return false
	end

	return var_79_1 > 0
end

function var_0_0.setNotifyBindContract(arg_80_0)
	arg_80_0.notifyBindContract = true
end

function var_0_0.clearNotifyBindContract(arg_81_0)
	arg_81_0.notifyBindContract = nil
end

function var_0_0.isStatusDead(arg_82_0)
	return arg_82_0.status == FightEnum.EntityStatus.Dead
end

function var_0_0.setDead(arg_83_0)
	arg_83_0.status = FightEnum.EntityStatus.Dead
end

function var_0_0.getCareer(arg_84_0)
	if arg_84_0:isASFDEmitter() then
		return arg_84_0:getASFDCareer()
	end

	return arg_84_0.career
end

function var_0_0.getASFDCareer(arg_85_0)
	for iter_85_0, iter_85_1 in pairs(arg_85_0.buffDic) do
		local var_85_0 = iter_85_1.buffId
		local var_85_1 = arg_85_0:getFeaturesSplitInfoByBuffId(var_85_0)

		if var_85_1 then
			for iter_85_2, iter_85_3 in ipairs(var_85_1) do
				local var_85_2 = lua_buff_act.configDict[iter_85_3[1]]

				if var_85_2 and var_85_2.type == FightEnum.BuffType_EmitterCareerChange then
					return tonumber(iter_85_3[2])
				end
			end
		end
	end

	return arg_85_0.career
end

function var_0_0.getConfigMaxExPoint(arg_86_0)
	if arg_86_0.configMaxExPoint then
		return arg_86_0.configMaxExPoint
	end

	local var_86_0 = arg_86_0:getCO()

	if not var_86_0 then
		return 0
	end

	local var_86_1 = var_86_0.uniqueSkill_point

	if var_86_1 and type(var_86_1) == "string" then
		var_86_1 = tonumber(string.split(var_86_1, "#")[2])
	end

	local var_86_2 = lua_character_rank_replace.configDict[arg_86_0.modelId]

	if var_86_2 then
		local var_86_3, var_86_4 = HeroConfig.instance:getShowLevel(arg_86_0.level or 1)

		var_86_1 = var_86_4 > 2 and string.split(var_86_2.uniqueSkill_point, "#")[2] or var_86_1
	end

	arg_86_0.configMaxExPoint = var_86_1

	return arg_86_0.configMaxExPoint
end

function var_0_0.getHeroDestinyStoneMo(arg_87_0)
	if arg_87_0.trialId and arg_87_0.trialId > 0 then
		local var_87_0 = lua_hero_trial.configDict[arg_87_0.trialId][0]

		if var_87_0 then
			arg_87_0.destinyStoneMo = arg_87_0.destinyStoneMo or HeroDestinyStoneMO.New(arg_87_0.modelId)

			arg_87_0.destinyStoneMo:refreshMo(var_87_0.facetslevel, 1, var_87_0.facetsId)
		end
	else
		local var_87_1 = HeroModel.instance:getByHeroId(arg_87_0.modelId)

		arg_87_0.destinyStoneMo = var_87_1 and var_87_1.destinyStoneMo
	end

	return arg_87_0.destinyStoneMo
end

function var_0_0.initSkin(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_1.skin

	var_88_0 = var_88_0 ~= 312001 and FightHelper.processEntitySkin(var_88_0, arg_88_1.uid) or var_88_0

	if var_88_0 == 312001 then
		local var_88_1, var_88_2 = HeroConfig.instance:getShowLevel(arg_88_1.level)

		if var_88_2 and var_88_2 - 1 >= 2 then
			var_88_0 = 312002
		end
	end

	return var_88_0
end

function var_0_0.getEquipMo(arg_89_0)
	if not arg_89_0.equipRecord then
		return
	end

	if not arg_89_0.equipMo then
		arg_89_0.equipMo = EquipMO.New()

		arg_89_0.equipMo:init({
			count = 1,
			exp = 0,
			uid = arg_89_0.equipRecord.equipUid,
			equipId = arg_89_0.equipRecord.equipId,
			level = arg_89_0.equipRecord.equipLv,
			refineLv = arg_89_0.equipRecord.refineLv
		})
		arg_89_0.equipMo:setBreakLvByLevel()
	end

	return arg_89_0.equipMo
end

function var_0_0.getLockMaxHpRate(arg_90_0)
	for iter_90_0, iter_90_1 in pairs(arg_90_0.buffDic) do
		local var_90_0 = iter_90_1.actCommonParams

		if not string.nilorempty(var_90_0) then
			local var_90_1 = FightStrUtil.instance:getSplitString2Cache(var_90_0, true, "|", "#")

			for iter_90_2, iter_90_3 in ipairs(var_90_1) do
				if iter_90_3[1] == FightEnum.BuffActId.LockHpMax then
					return iter_90_3[2] and iter_90_3[2] / 1000 or 1
				end
			end
		end
	end

	return 1
end

function var_0_0.getHpAndShieldFillAmount(arg_91_0, arg_91_1, arg_91_2)
	local var_91_0 = arg_91_0:getLockMaxHpRate()
	local var_91_1 = (arg_91_0.attrMO and arg_91_0.attrMO.hp > 0 and arg_91_0.attrMO.hp or 1) * var_91_0
	local var_91_2 = arg_91_1 or arg_91_0.currentHp
	local var_91_3 = arg_91_2 or arg_91_0.shieldValue
	local var_91_4 = var_91_2 / var_91_1 or 0
	local var_91_5 = 0

	if var_91_1 >= var_91_3 + var_91_2 then
		var_91_4 = var_91_2 / var_91_1
		var_91_5 = (var_91_3 + var_91_2) / var_91_1
	else
		var_91_4 = var_91_2 / (var_91_2 + var_91_3)
		var_91_5 = 1
	end

	local var_91_6 = var_91_4 * var_91_0
	local var_91_7 = var_91_5 * var_91_0

	return var_91_6, var_91_7
end

function var_0_0.getHeroExtraMo(arg_92_0)
	if arg_92_0.trialId and arg_92_0.trialId > 0 then
		local var_92_0 = lua_hero_trial.configDict[arg_92_0.trialId][0]

		if var_92_0 then
			local var_92_1 = var_92_0.extraStr

			if not string.nilorempty(var_92_1) then
				local var_92_2 = HeroConfig.instance:getHeroCO(arg_92_0.modelId)
				local var_92_3 = HeroMo.New()

				var_92_3:init(var_92_0, var_92_2)

				arg_92_0.extraMo = arg_92_0.extraMo or CharacterExtraMO.New(var_92_3)

				arg_92_0.extraMo:refreshMo(var_92_1)
			end
		end
	else
		local var_92_4 = HeroModel.instance:getByHeroId(arg_92_0.modelId)

		arg_92_0.extraMo = var_92_4 and var_92_4.extraMo
	end

	return arg_92_0.extraMo
end

function var_0_0.checkReplaceSkill(arg_93_0, arg_93_1)
	if arg_93_1 then
		local var_93_0 = arg_93_0:getHeroDestinyStoneMo()

		if var_93_0 then
			arg_93_1 = var_93_0:_replaceSkill(arg_93_1)
		end

		local var_93_1 = arg_93_0:getHeroExtraMo()

		if var_93_1 then
			arg_93_1 = var_93_1:getReplaceSkills(arg_93_1)
		end
	end

	return arg_93_1
end

return var_0_0
