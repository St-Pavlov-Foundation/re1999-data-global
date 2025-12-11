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
		local var_5_0 = FightBuffInfoData.New(iter_5_1, arg_5_0.id)

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
		local var_19_0 = FightBuffInfoData.New(arg_19_1, arg_19_0.id)

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
		FightDataUtil.coverData(arg_21_1, arg_21_0.buffDic[arg_21_1.uid])
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
	elseif arg_28_0:isAct191Boss() then
		for iter_28_0, iter_28_1 in ipairs(lua_activity191_assist_boss.configList) do
			if iter_28_1.skinId == arg_28_0.skin then
				return iter_28_1
			end
		end
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

function var_0_0.isAct191Boss(arg_34_0)
	return arg_34_0.entityType == FightEnum.EntityType.Act191Boss
end

function var_0_0.getSpineSkinCO(arg_35_0)
	if arg_35_0:isVorpalith() then
		return
	end

	local var_35_0 = arg_35_0.skin

	if not var_35_0 then
		local var_35_1 = lua_character.configDict[arg_35_0.modelId]

		var_35_0 = var_35_1 and var_35_1.skinId
	end

	if not var_35_0 then
		local var_35_2 = lua_monster.configDict[arg_35_0.modelId]
		local var_35_3

		var_35_3 = var_35_2 and var_35_2.skinId
	end

	local var_35_4 = FightConfig.instance:getSkinCO(arg_35_0.skin)

	if var_35_4 then
		return var_35_4
	else
		if FightEntityDataHelper.isPlayerUid(arg_35_0.id) then
			return
		end

		logError("skin not exist: " .. arg_35_0.skin .. " modelId: " .. arg_35_0.modelId)
	end
end

function var_0_0.resetSimulateExPoint(arg_36_0)
	arg_36_0.playCardExPoint = 0
	arg_36_0.moveCardExPoint = 0
end

function var_0_0.applyMoveCardExPoint(arg_37_0)
	arg_37_0.moveCardExPoint = 0
	arg_37_0.playCardExPoint = 0
end

function var_0_0.getExPoint(arg_38_0)
	return arg_38_0.exPoint
end

function var_0_0.setExPoint(arg_39_0, arg_39_1)
	arg_39_0.exPoint = arg_39_1
end

function var_0_0.changeExpointMaxAdd(arg_40_0, arg_40_1)
	arg_40_0.expointMaxAdd = arg_40_0.expointMaxAdd or 0

	if arg_40_0.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	arg_40_0.expointMaxAdd = arg_40_0.expointMaxAdd + arg_40_1
end

function var_0_0.getMaxExPoint(arg_41_0)
	if not arg_41_0:getCO() then
		return 0
	end

	return arg_41_0:getConfigMaxExPoint() + arg_41_0:getExpointMaxAddNum()
end

function var_0_0.getExpointMaxAddNum(arg_42_0)
	return arg_42_0.expointMaxAdd or 0
end

function var_0_0.changeServerUniqueCost(arg_43_0, arg_43_1)
	if arg_43_0.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	arg_43_0.exSkillPointChange = arg_43_0:getExpointCostOffsetNum() + arg_43_1
end

function var_0_0.getUniqueSkillPoint(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.buffDic) do
		local var_44_0 = iter_44_1.buffId
		local var_44_1 = arg_44_0:getFeaturesSplitInfoByBuffId(var_44_0)

		if var_44_1 then
			for iter_44_2, iter_44_3 in ipairs(var_44_1) do
				if iter_44_3[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return arg_44_0:getConfigMaxExPoint() + arg_44_0:getExpointCostOffsetNum()
end

function var_0_0.getExpointCostOffsetNum(arg_45_0)
	return arg_45_0.exSkillPointChange or 0
end

function var_0_0.getPreviewExPoint(arg_46_0)
	return arg_46_0.exPoint + arg_46_0.moveCardExPoint + arg_46_0.playCardExPoint - FightHelper.getPredeductionExpoint(arg_46_0.id)
end

function var_0_0.onPlayCardExPoint(arg_47_0, arg_47_1)
	if not FightCardDataHelper.isBigSkill(arg_47_1) then
		local var_47_0 = arg_47_0:getMaxExPoint()

		if var_47_0 > arg_47_0:getPreviewExPoint() then
			arg_47_0.playCardExPoint = arg_47_0.playCardExPoint + arg_47_0._playCardAddExpoint

			if var_47_0 < arg_47_0:getPreviewExPoint() then
				arg_47_0.playCardExPoint = arg_47_0.playCardExPoint - (arg_47_0:getPreviewExPoint() - var_47_0)
			end
		end
	end
end

function var_0_0.onMoveCardExPoint(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1 and arg_48_0._moveCardAddExpoint or arg_48_0._combineCardAddExpoint
	local var_48_1 = arg_48_0:getMaxExPoint()

	if var_48_1 > arg_48_0:getPreviewExPoint() then
		arg_48_0.moveCardExPoint = arg_48_0.moveCardExPoint + var_48_0

		if var_48_1 < arg_48_0:getPreviewExPoint() then
			arg_48_0.moveCardExPoint = arg_48_0.moveCardExPoint - (arg_48_0:getPreviewExPoint() - var_48_1)
		end
	end
end

function var_0_0._dealBuffFeature(arg_49_0)
	arg_49_0._playCardAddExpoint = 1
	arg_49_0._moveCardAddExpoint = 1
	arg_49_0._combineCardAddExpoint = 1

	for iter_49_0, iter_49_1 in pairs(arg_49_0.buffDic) do
		local var_49_0 = iter_49_1.buffId
		local var_49_1 = arg_49_0:getFeaturesSplitInfoByBuffId(var_49_0)

		if var_49_1 then
			for iter_49_2, iter_49_3 in ipairs(var_49_1) do
				if iter_49_3[1] == 606 then
					arg_49_0._combineCardAddExpoint = arg_49_0._combineCardAddExpoint + iter_49_3[2]
				elseif iter_49_3[1] == 607 then
					arg_49_0._moveCardAddExpoint = arg_49_0._moveCardAddExpoint + iter_49_3[2]
				elseif iter_49_3[1] == 603 then
					arg_49_0._playCardAddExpoint = 0
					arg_49_0._combineCardAddExpoint = 0
					arg_49_0._moveCardAddExpoint = 0

					return
				elseif iter_49_3[1] == 845 then
					arg_49_0._playCardAddExpoint = arg_49_0._playCardAddExpoint + iter_49_3[2]
				end
			end
		end
	end
end

function var_0_0.getCombineCardAddExPoint(arg_50_0)
	return arg_50_0._combineCardAddExpoint
end

function var_0_0.getMoveCardAddExPoint(arg_51_0)
	return arg_51_0._moveCardAddExpoint
end

function var_0_0.getPlayCardAddExPoint(arg_52_0)
	return arg_52_0._playCardAddExpoint
end

function var_0_0.getFeaturesSplitInfoByBuffId(arg_53_0, arg_53_1)
	if not arg_53_0.buffFeaturesSplit then
		arg_53_0.buffFeaturesSplit = {}
	end

	if not arg_53_0.buffFeaturesSplit[arg_53_1] then
		local var_53_0 = lua_skill_buff.configDict[arg_53_1]
		local var_53_1 = var_53_0 and var_53_0.features

		if not string.nilorempty(var_53_1) then
			local var_53_2 = FightStrUtil.instance:getSplitString2Cache(var_53_1, true)

			arg_53_0.buffFeaturesSplit[arg_53_1] = var_53_2
		end
	end

	return arg_53_0.buffFeaturesSplit[arg_53_1]
end

function var_0_0.hasBuffFeature(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.buffDic) do
		local var_54_0 = iter_54_1.buffId
		local var_54_1 = arg_54_0:getFeaturesSplitInfoByBuffId(var_54_0)

		if var_54_1 then
			for iter_54_2, iter_54_3 in ipairs(var_54_1) do
				local var_54_2 = lua_buff_act.configDict[iter_54_3[1]]

				if var_54_2 and var_54_2.type == arg_54_1 then
					return true, iter_54_1
				end
			end
		end
	end
end

function var_0_0.hasBuffActId(arg_55_0, arg_55_1)
	for iter_55_0, iter_55_1 in pairs(arg_55_0.buffDic) do
		local var_55_0 = iter_55_1.buffId
		local var_55_1 = arg_55_0:getFeaturesSplitInfoByBuffId(var_55_0)

		if var_55_1 then
			for iter_55_2, iter_55_3 in ipairs(var_55_1) do
				if iter_55_3[1] == arg_55_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffTypeId(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in pairs(arg_56_0.buffDic) do
		local var_56_0 = iter_56_1:getCO()

		if var_56_0 and var_56_0.typeId == arg_56_1 then
			return true
		end
	end
end

function var_0_0.hasBuffId(arg_57_0, arg_57_1)
	for iter_57_0, iter_57_1 in pairs(arg_57_0.buffDic) do
		if iter_57_1.buffId == arg_57_1 then
			return true
		end
	end
end

function var_0_0.setHp(arg_58_0, arg_58_1)
	if arg_58_0:isASFDEmitter() then
		return arg_58_0:setASFDEmitterHp(arg_58_1)
	end

	arg_58_0:defaultSetHp(arg_58_1)
end

function var_0_0.defaultSetHp(arg_59_0, arg_59_1)
	if arg_59_1 < 0 then
		arg_59_1 = 0
	end

	if arg_59_1 > arg_59_0.attrMO.hp then
		arg_59_1 = arg_59_0.attrMO.hp
	end

	arg_59_0.currentHp = arg_59_1
end

function var_0_0.setASFDEmitterHp(arg_60_0, arg_60_1)
	if arg_60_1 < 0 then
		arg_60_1 = 0
	end

	arg_60_0.currentHp = arg_60_1
end

function var_0_0.setShield(arg_61_0, arg_61_1)
	arg_61_0.shieldValue = arg_61_1
end

function var_0_0.onChangeHero(arg_62_0)
	tabletool.clear(arg_62_0.buffDic)
	arg_62_0:_dealBuffFeature()
	arg_62_0:setShield(0)
end

function var_0_0.setPowerInfos(arg_63_0, arg_63_1)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in ipairs(arg_63_1) do
		local var_63_1 = FightPowerInfoData.New(iter_63_1)

		var_63_0[var_63_1.powerId] = var_63_1
	end

	FightDataUtil.coverData(var_63_0, arg_63_0._powerInfos)
end

function var_0_0.refreshPowerInfo(arg_64_0, arg_64_1)
	local var_64_0 = FightPowerInfoData.New(arg_64_1)
	local var_64_1 = var_64_0.powerId

	arg_64_0._powerInfos[var_64_1] = FightDataUtil.coverData(var_64_0, arg_64_0._powerInfos[var_64_1])
end

function var_0_0.getPowerInfos(arg_65_0)
	return arg_65_0._powerInfos or {}
end

function var_0_0.getPowerInfo(arg_66_0, arg_66_1)
	return arg_66_0._powerInfos and arg_66_0._powerInfos[arg_66_1]
end

function var_0_0.hasStress(arg_67_0)
	local var_67_0 = arg_67_0._powerInfos and arg_67_0._powerInfos[FightEnum.PowerType.Stress]

	return var_67_0 and var_67_0.max > 0
end

function var_0_0.changePowerMax(arg_68_0, arg_68_1, arg_68_2)
	if arg_68_0._powerInfos and arg_68_0._powerInfos[arg_68_1] then
		arg_68_0._powerInfos[arg_68_1].max = arg_68_0._powerInfos[arg_68_1].max + arg_68_2
	end
end

function var_0_0.buildSummonedInfo(arg_69_0, arg_69_1)
	arg_69_0.summonedInfo = arg_69_0.summonedInfo or FightEntitySummonedInfo.New()

	arg_69_0.summonedInfo:init(arg_69_1)

	return arg_69_0.summonedInfo
end

function var_0_0.getSummonedInfo(arg_70_0)
	arg_70_0.summonedInfo = arg_70_0.summonedInfo or FightEntitySummonedInfo.New()

	return arg_70_0.summonedInfo
end

function var_0_0.buildEnhanceInfoBox(arg_71_0, arg_71_1)
	arg_71_0.canUpgradeIds = {}
	arg_71_0.upgradedOptions = {}

	if arg_71_1 then
		for iter_71_0, iter_71_1 in ipairs(arg_71_1.canUpgradeIds) do
			arg_71_0.canUpgradeIds[iter_71_1] = iter_71_1
		end

		for iter_71_2, iter_71_3 in ipairs(arg_71_1.upgradedOptions) do
			arg_71_0.upgradedOptions[iter_71_3] = iter_71_3
		end
	end
end

function var_0_0.getTrialAttrCo(arg_72_0)
	if not arg_72_0.trialId or arg_72_0.trialId <= 0 then
		return
	end

	local var_72_0 = lua_hero_trial.configDict[arg_72_0.trialId][0]

	if not var_72_0 then
		return
	end

	if var_72_0.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[var_72_0.attrId]
end

function var_0_0.updateStoredExPoint(arg_73_0)
	arg_73_0.storedExPoint = 0

	for iter_73_0, iter_73_1 in ipairs(arg_73_0:getBuffList()) do
		local var_73_0 = iter_73_1.actCommonParams

		if not string.nilorempty(var_73_0) then
			local var_73_1 = FightStrUtil.instance:getSplitToNumberCache(var_73_0, "#")
			local var_73_2 = var_73_1[1]
			local var_73_3 = lua_buff_act.configDict[var_73_2]

			if (var_73_3 and var_73_3.type) == FightEnum.BuffType_ExPointOverflowBank then
				arg_73_0.storedExPoint = arg_73_0.storedExPoint + var_73_1[2]
			end
		end
	end
end

function var_0_0.setStoredExPoint(arg_74_0, arg_74_1)
	arg_74_0.storedExPoint = arg_74_1
end

function var_0_0.changeStoredExPoint(arg_75_0, arg_75_1)
	arg_75_0.storedExPoint = arg_75_0.storedExPoint + arg_75_1
end

function var_0_0.getStoredExPoint(arg_76_0)
	return arg_76_0.storedExPoint
end

function var_0_0.hadStoredExPoint(arg_77_0)
	return arg_77_0.storedExPoint > 0
end

function var_0_0.getResistanceDict(arg_78_0)
	arg_78_0.resistanceDict = arg_78_0.resistanceDict or {}

	tabletool.clear(arg_78_0.resistanceDict)

	local var_78_0 = FightModel.instance:getSpAttributeMo(arg_78_0.uid)

	if var_78_0 then
		for iter_78_0, iter_78_1 in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			local var_78_1 = var_78_0[iter_78_1]

			if var_78_1 and var_78_1 > 0 then
				arg_78_0.resistanceDict[iter_78_0] = var_78_1
			end
		end
	end

	return arg_78_0.resistanceDict
end

function var_0_0.isFullResistance(arg_79_0, arg_79_1)
	local var_79_0 = FightModel.instance:getSpAttributeMo(arg_79_0.uid)

	if not var_79_0 then
		return false
	end

	local var_79_1 = var_79_0[arg_79_1]

	if not var_79_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_79_0:getEntityName(), arg_79_1))

		return false
	end

	return var_79_1 >= 1000
end

function var_0_0.isPartResistance(arg_80_0, arg_80_1)
	local var_80_0 = FightModel.instance:getSpAttributeMo(arg_80_0.uid)

	if not var_80_0 then
		return false
	end

	local var_80_1 = var_80_0[arg_80_1]

	if not var_80_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_80_0:getEntityName(), arg_80_1))

		return false
	end

	return var_80_1 > 0
end

function var_0_0.setNotifyBindContract(arg_81_0)
	arg_81_0.notifyBindContract = true
end

function var_0_0.clearNotifyBindContract(arg_82_0)
	arg_82_0.notifyBindContract = nil
end

function var_0_0.isStatusDead(arg_83_0)
	return arg_83_0.status == FightEnum.EntityStatus.Dead
end

function var_0_0.setDead(arg_84_0)
	arg_84_0.status = FightEnum.EntityStatus.Dead
end

function var_0_0.getCareer(arg_85_0)
	if arg_85_0:isASFDEmitter() then
		return arg_85_0:getASFDCareer()
	end

	return arg_85_0.career
end

function var_0_0.getASFDCareer(arg_86_0)
	for iter_86_0, iter_86_1 in pairs(arg_86_0.buffDic) do
		local var_86_0 = iter_86_1.buffId
		local var_86_1 = arg_86_0:getFeaturesSplitInfoByBuffId(var_86_0)

		if var_86_1 then
			for iter_86_2, iter_86_3 in ipairs(var_86_1) do
				local var_86_2 = lua_buff_act.configDict[iter_86_3[1]]

				if var_86_2 and var_86_2.type == FightEnum.BuffType_EmitterCareerChange then
					return tonumber(iter_86_3[2])
				end
			end
		end
	end

	return arg_86_0.career
end

function var_0_0.getConfigMaxExPoint(arg_87_0)
	if arg_87_0.configMaxExPoint then
		return arg_87_0.configMaxExPoint
	end

	local var_87_0 = arg_87_0:getCO()

	if not var_87_0 then
		return 0
	end

	local var_87_1 = var_87_0.uniqueSkill_point

	if var_87_1 and type(var_87_1) == "string" then
		var_87_1 = tonumber(string.split(var_87_1, "#")[2])
	end

	local var_87_2 = lua_character_rank_replace.configDict[arg_87_0.modelId]

	if var_87_2 then
		local var_87_3, var_87_4 = HeroConfig.instance:getShowLevel(arg_87_0.level or 1)

		var_87_1 = var_87_4 > 2 and string.split(var_87_2.uniqueSkill_point, "#")[2] or var_87_1
	end

	arg_87_0.configMaxExPoint = var_87_1

	return arg_87_0.configMaxExPoint
end

function var_0_0.getHeroDestinyStoneMo(arg_88_0)
	if arg_88_0.trialId and arg_88_0.trialId > 0 then
		local var_88_0 = lua_hero_trial.configDict[arg_88_0.trialId][0]

		if var_88_0 then
			arg_88_0.destinyStoneMo = arg_88_0.destinyStoneMo or HeroDestinyStoneMO.New(arg_88_0.modelId)

			arg_88_0.destinyStoneMo:refreshMo(var_88_0.facetslevel, 1, var_88_0.facetsId)
		end
	else
		local var_88_1 = HeroModel.instance:getByHeroId(arg_88_0.modelId)

		arg_88_0.destinyStoneMo = var_88_1 and var_88_1.destinyStoneMo
	end

	return arg_88_0.destinyStoneMo
end

function var_0_0.initSkin(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_1.skin

	var_89_0 = var_89_0 ~= 312001 and FightHelper.processEntitySkin(var_89_0, arg_89_1.uid) or var_89_0

	if var_89_0 == 312001 then
		local var_89_1, var_89_2 = HeroConfig.instance:getShowLevel(arg_89_1.level)

		if var_89_2 and var_89_2 - 1 >= 2 then
			var_89_0 = 312002
		end
	end

	return var_89_0
end

function var_0_0.getEquipMo(arg_90_0)
	if not arg_90_0.equipRecord then
		return
	end

	if not arg_90_0.equipMo then
		arg_90_0.equipMo = EquipMO.New()

		arg_90_0.equipMo:init({
			count = 1,
			exp = 0,
			uid = arg_90_0.equipRecord.equipUid,
			equipId = arg_90_0.equipRecord.equipId,
			level = arg_90_0.equipRecord.equipLv,
			refineLv = arg_90_0.equipRecord.refineLv
		})
		arg_90_0.equipMo:setBreakLvByLevel()
	end

	return arg_90_0.equipMo
end

function var_0_0.getLockMaxHpRate(arg_91_0)
	for iter_91_0, iter_91_1 in pairs(arg_91_0.buffDic) do
		local var_91_0 = iter_91_1.actCommonParams

		if not string.nilorempty(var_91_0) then
			local var_91_1 = FightStrUtil.instance:getSplitString2Cache(var_91_0, true, "|", "#")

			for iter_91_2, iter_91_3 in ipairs(var_91_1) do
				if iter_91_3[1] == FightEnum.BuffActId.LockHpMax then
					return iter_91_3[2] and iter_91_3[2] / 1000 or 1
				end
			end
		end
	end

	return 1
end

function var_0_0.getHpAndShieldFillAmount(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = arg_92_0:getLockMaxHpRate()
	local var_92_1 = (arg_92_0.attrMO and arg_92_0.attrMO.hp > 0 and arg_92_0.attrMO.hp or 1) * var_92_0
	local var_92_2 = arg_92_1 or arg_92_0.currentHp
	local var_92_3 = arg_92_2 or arg_92_0.shieldValue
	local var_92_4 = var_92_2 / var_92_1 or 0
	local var_92_5 = 0

	if var_92_1 >= var_92_3 + var_92_2 then
		var_92_4 = var_92_2 / var_92_1
		var_92_5 = (var_92_3 + var_92_2) / var_92_1
	else
		var_92_4 = var_92_2 / (var_92_2 + var_92_3)
		var_92_5 = 1
	end

	local var_92_6 = var_92_4 * var_92_0
	local var_92_7 = var_92_5 * var_92_0

	return var_92_6, var_92_7
end

function var_0_0.getHeroExtraMo(arg_93_0)
	if arg_93_0.trialId and arg_93_0.trialId > 0 then
		local var_93_0 = lua_hero_trial.configDict[arg_93_0.trialId][0]

		if var_93_0 then
			local var_93_1 = var_93_0.extraStr

			if not string.nilorempty(var_93_1) then
				local var_93_2 = HeroConfig.instance:getHeroCO(arg_93_0.modelId)
				local var_93_3 = HeroMo.New()

				var_93_3:init(var_93_0, var_93_2)

				arg_93_0.extraMo = arg_93_0.extraMo or CharacterExtraMO.New(var_93_3)

				arg_93_0.extraMo:refreshMo(var_93_1)
			end
		end
	else
		local var_93_4 = HeroModel.instance:getByHeroId(arg_93_0.modelId)

		arg_93_0.extraMo = var_93_4 and var_93_4.extraMo
	end

	return arg_93_0.extraMo
end

function var_0_0.checkReplaceSkill(arg_94_0, arg_94_1)
	if arg_94_1 then
		local var_94_0 = arg_94_0:getHeroDestinyStoneMo()

		if var_94_0 then
			arg_94_1 = var_94_0:_replaceSkill(arg_94_1)
		end

		local var_94_1 = arg_94_0:getHeroExtraMo()

		if var_94_1 then
			arg_94_1 = var_94_1:getReplaceSkills(arg_94_1)
		end
	end

	return arg_94_1
end

return var_0_0
