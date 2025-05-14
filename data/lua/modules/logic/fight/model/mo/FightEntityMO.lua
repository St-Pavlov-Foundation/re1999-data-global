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
	arg_3_0.skin = FightHelper.processEntitySkin(arg_3_1.skin, arg_3_1.uid)
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

	arg_3_0:setPowerInfos(arg_3_1.powerInfos)
	arg_3_0:buildSummonedInfo(arg_3_1.SummonedList)

	arg_3_0.teamType = arg_3_1.teamType

	arg_3_0:buildEnhanceInfoBox(arg_3_1.enhanceInfoBox)

	arg_3_0.career = arg_3_1.career

	arg_3_0:updateStoredExPoint()

	arg_3_0.status = arg_3_1.status
	arg_3_0.guard = arg_3_1.guard
	arg_3_0.subCd = arg_3_1.subCd
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

function var_0_0.isUniqueSkill(arg_14_0, arg_14_1)
	return arg_14_0.skillId2Lv[arg_14_1] == FightEnum.UniqueSkillCardLv or FightConfig.instance:isUniqueSkill(arg_14_1)
end

function var_0_0.isActiveSkill(arg_15_0, arg_15_1)
	return arg_15_0.skillId2Lv[arg_15_1] ~= nil or FightConfig.instance:isActiveSkill(arg_15_1)
end

function var_0_0.getBuffList(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 or {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.buffDic) do
		table.insert(var_16_0, iter_16_1)
	end

	return var_16_0
end

function var_0_0.getBuffDic(arg_17_0)
	return arg_17_0.buffDic
end

function var_0_0.addBuff(arg_18_0, arg_18_1)
	if not arg_18_0.buffDic[arg_18_1.uid] then
		local var_18_0 = FightBuffMO.New()

		var_18_0:init(arg_18_1, arg_18_0.id)

		arg_18_0.buffDic[arg_18_1.uid] = var_18_0

		arg_18_0:_dealBuffFeature()

		return true
	end
end

function var_0_0.delBuff(arg_19_0, arg_19_1)
	if arg_19_0.buffDic[arg_19_1] then
		arg_19_0.buffDic[arg_19_1] = nil

		arg_19_0:_dealBuffFeature()
	end
end

function var_0_0.updateBuff(arg_20_0, arg_20_1)
	if arg_20_0.buffDic[arg_20_1.uid] then
		arg_20_0.buffDic[arg_20_1.uid]:init(arg_20_1, arg_20_0.id)
	end
end

function var_0_0.getBuffMO(arg_21_0, arg_21_1)
	return arg_21_0.buffDic[arg_21_1]
end

function var_0_0.clearAllBuff(arg_22_0)
	tabletool.clear(arg_22_0.buffDic)
end

function var_0_0.getEntityName(arg_23_0)
	local var_23_0 = arg_23_0:getCO()

	return var_23_0 and var_23_0.name or "nil"
end

function var_0_0.getIdName(arg_24_0)
	local var_24_0 = arg_24_0.side == FightEnum.EntitySide.MySide and FightEnum.EntityGOName.MySide or FightEnum.EntityGOName.EnemySide

	return string.format("%s_%d", var_24_0, arg_24_0.position)
end

function var_0_0.getCO(arg_25_0)
	if arg_25_0:isCharacter() then
		return lua_character.configDict[arg_25_0.modelId]
	elseif arg_25_0:isMonster() then
		return lua_monster.configDict[arg_25_0.modelId]
	elseif arg_25_0:isAssistBoss() then
		return lua_tower_assist_boss.configDict[arg_25_0.modelId]
	elseif arg_25_0:isASFDEmitter() then
		return FightASFDConfig.instance:getASFDEmitterConfig(arg_25_0.side)
	end

	return lua_character.configDict[arg_25_0.modelId] or lua_monster.configDict[arg_25_0.modelId]
end

function var_0_0.isCharacter(arg_26_0)
	return arg_26_0.entityType == FightEnum.EntityType.Character
end

function var_0_0.isMonster(arg_27_0)
	return arg_27_0.entityType == FightEnum.EntityType.Monster
end

function var_0_0.isAssistBoss(arg_28_0)
	return arg_28_0.entityType == FightEnum.EntityType.AssistBoss
end

function var_0_0.isASFDEmitter(arg_29_0)
	return arg_29_0.entityType == FightEnum.EntityType.ASFDEmitter
end

function var_0_0.getSpineSkinCO(arg_30_0)
	local var_30_0 = arg_30_0.skin

	if not var_30_0 then
		local var_30_1 = lua_character.configDict[arg_30_0.modelId]

		var_30_0 = var_30_1 and var_30_1.skinId
	end

	if not var_30_0 then
		local var_30_2 = lua_monster.configDict[arg_30_0.modelId]
		local var_30_3

		var_30_3 = var_30_2 and var_30_2.skinId
	end

	local var_30_4 = FightConfig.instance:getSkinCO(arg_30_0.skin)

	if var_30_4 then
		return var_30_4
	else
		if FightEntityDataHelper.isPlayerUid(arg_30_0.id) then
			return
		end

		logError("skin not exist: " .. arg_30_0.skin .. " modelId: " .. arg_30_0.modelId)
	end
end

function var_0_0.resetSimulateExPoint(arg_31_0)
	arg_31_0.playCardExPoint = 0
	arg_31_0.moveCardExPoint = 0
end

function var_0_0.applyMoveCardExPoint(arg_32_0)
	arg_32_0.moveCardExPoint = 0
	arg_32_0.playCardExPoint = 0
end

function var_0_0.getExPoint(arg_33_0)
	return arg_33_0.exPoint
end

function var_0_0.setExPoint(arg_34_0, arg_34_1)
	arg_34_0.exPoint = arg_34_1
end

function var_0_0.changeExpointMaxAdd(arg_35_0, arg_35_1)
	arg_35_0.expointMaxAdd = arg_35_0.expointMaxAdd or 0
	arg_35_0.expointMaxAdd = arg_35_0.expointMaxAdd + arg_35_1
end

function var_0_0.getMaxExPoint(arg_36_0)
	local var_36_0 = arg_36_0:getCO()

	if not var_36_0 then
		return 0
	end

	return var_36_0.uniqueSkill_point + arg_36_0:getExpointMaxAddNum()
end

function var_0_0.getExpointMaxAddNum(arg_37_0)
	return arg_37_0.expointMaxAdd or 0
end

function var_0_0.changeServerUniqueCost(arg_38_0, arg_38_1)
	arg_38_0.exSkillPointChange = arg_38_0:getExpointCostOffsetNum() + arg_38_1
end

function var_0_0.getUniqueSkillPoint(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.buffDic) do
		local var_39_0 = iter_39_1.buffId
		local var_39_1 = arg_39_0:getFeaturesSplitInfoByBuffId(var_39_0)

		if var_39_1 then
			for iter_39_2, iter_39_3 in ipairs(var_39_1) do
				if iter_39_3[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return arg_39_0:getCO().uniqueSkill_point + arg_39_0:getExpointCostOffsetNum()
end

function var_0_0.getExpointCostOffsetNum(arg_40_0)
	return arg_40_0.exSkillPointChange or 0
end

function var_0_0.getPreviewExPoint(arg_41_0)
	return arg_41_0.exPoint + arg_41_0.moveCardExPoint + arg_41_0.playCardExPoint - FightHelper.getPredeductionExpoint(arg_41_0.id)
end

function var_0_0.onPlayCardExPoint(arg_42_0, arg_42_1)
	if not arg_42_0:isUniqueSkill(arg_42_1) then
		local var_42_0 = arg_42_0:getMaxExPoint()

		if var_42_0 > arg_42_0:getPreviewExPoint() then
			arg_42_0.playCardExPoint = arg_42_0.playCardExPoint + arg_42_0._playCardAddExpoint

			if var_42_0 < arg_42_0:getPreviewExPoint() then
				arg_42_0.playCardExPoint = arg_42_0.playCardExPoint - (arg_42_0:getPreviewExPoint() - var_42_0)
			end
		end
	end
end

function var_0_0.onMoveCardExPoint(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 and arg_43_0._moveCardAddExpoint or arg_43_0._combineCardAddExpoint
	local var_43_1 = arg_43_0:getMaxExPoint()

	if var_43_1 > arg_43_0:getPreviewExPoint() then
		arg_43_0.moveCardExPoint = arg_43_0.moveCardExPoint + var_43_0

		if var_43_1 < arg_43_0:getPreviewExPoint() then
			arg_43_0.moveCardExPoint = arg_43_0.moveCardExPoint - (arg_43_0:getPreviewExPoint() - var_43_1)
		end
	end
end

function var_0_0._dealBuffFeature(arg_44_0)
	arg_44_0._playCardAddExpoint = 1
	arg_44_0._moveCardAddExpoint = 1
	arg_44_0._combineCardAddExpoint = 1

	for iter_44_0, iter_44_1 in pairs(arg_44_0.buffDic) do
		local var_44_0 = iter_44_1.buffId
		local var_44_1 = arg_44_0:getFeaturesSplitInfoByBuffId(var_44_0)

		if var_44_1 then
			for iter_44_2, iter_44_3 in ipairs(var_44_1) do
				if iter_44_3[1] == 606 then
					arg_44_0._combineCardAddExpoint = arg_44_0._combineCardAddExpoint + iter_44_3[2]
				elseif iter_44_3[1] == 607 then
					arg_44_0._moveCardAddExpoint = arg_44_0._moveCardAddExpoint + iter_44_3[2]
				elseif iter_44_3[1] == 603 then
					arg_44_0._playCardAddExpoint = 0
					arg_44_0._combineCardAddExpoint = 0
					arg_44_0._moveCardAddExpoint = 0

					return
				elseif iter_44_3[1] == 845 then
					arg_44_0._playCardAddExpoint = arg_44_0._playCardAddExpoint + iter_44_3[2]
				end
			end
		end
	end
end

function var_0_0.getCombineCardAddExPoint(arg_45_0)
	return arg_45_0._combineCardAddExpoint
end

function var_0_0.getMoveCardAddExPoint(arg_46_0)
	return arg_46_0._moveCardAddExpoint
end

function var_0_0.getPlayCardAddExPoint(arg_47_0)
	return arg_47_0._playCardAddExpoint
end

function var_0_0.getFeaturesSplitInfoByBuffId(arg_48_0, arg_48_1)
	if not arg_48_0.buffFeaturesSplit then
		arg_48_0.buffFeaturesSplit = {}
	end

	if not arg_48_0.buffFeaturesSplit[arg_48_1] then
		local var_48_0 = lua_skill_buff.configDict[arg_48_1]
		local var_48_1 = var_48_0 and var_48_0.features

		if not string.nilorempty(var_48_1) then
			local var_48_2 = FightStrUtil.instance:getSplitString2Cache(var_48_1, true)

			arg_48_0.buffFeaturesSplit[arg_48_1] = var_48_2
		end
	end

	return arg_48_0.buffFeaturesSplit[arg_48_1]
end

function var_0_0.hasBuffFeature(arg_49_0, arg_49_1)
	for iter_49_0, iter_49_1 in pairs(arg_49_0.buffDic) do
		local var_49_0 = iter_49_1.buffId
		local var_49_1 = arg_49_0:getFeaturesSplitInfoByBuffId(var_49_0)

		if var_49_1 then
			for iter_49_2, iter_49_3 in ipairs(var_49_1) do
				local var_49_2 = lua_buff_act.configDict[iter_49_3[1]]

				if var_49_2 and var_49_2.type == arg_49_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffActId(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.buffDic) do
		local var_50_0 = iter_50_1.buffId
		local var_50_1 = arg_50_0:getFeaturesSplitInfoByBuffId(var_50_0)

		if var_50_1 then
			for iter_50_2, iter_50_3 in ipairs(var_50_1) do
				if iter_50_3[1] == arg_50_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffTypeId(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.buffDic) do
		local var_51_0 = iter_51_1:getCO()

		if var_51_0 and var_51_0.typeId == arg_51_1 then
			return true
		end
	end
end

function var_0_0.hasBuffId(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_0.buffDic) do
		if iter_52_1.buffId == arg_52_1 then
			return true
		end
	end
end

function var_0_0.setHp(arg_53_0, arg_53_1)
	if arg_53_0:isASFDEmitter() then
		return arg_53_0:setASFDEmitterHp(arg_53_1)
	end

	arg_53_0:defaultSetHp(arg_53_1)
end

function var_0_0.defaultSetHp(arg_54_0, arg_54_1)
	if arg_54_1 < 0 then
		arg_54_1 = 0
	end

	if arg_54_1 > arg_54_0.attrMO.hp then
		arg_54_1 = arg_54_0.attrMO.hp
	end

	arg_54_0.currentHp = arg_54_1
end

function var_0_0.setASFDEmitterHp(arg_55_0, arg_55_1)
	if arg_55_1 < 0 then
		arg_55_1 = 0
	end

	arg_55_0.currentHp = arg_55_1
end

function var_0_0.setShield(arg_56_0, arg_56_1)
	arg_56_0.shieldValue = arg_56_1
end

function var_0_0.onChangeHero(arg_57_0)
	tabletool.clear(arg_57_0.buffDic)
	arg_57_0:_dealBuffFeature()
	arg_57_0:setShield(0)
end

function var_0_0.setPowerInfos(arg_58_0, arg_58_1)
	arg_58_0._powerInfos = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		arg_58_0:refreshPowerInfo(iter_58_1)
	end
end

function var_0_0.refreshPowerInfo(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0._powerInfos[arg_59_1.powerId] or {}

	var_59_0.powerId = arg_59_1.powerId
	var_59_0.num = arg_59_1.num
	var_59_0.max = arg_59_1.max
	arg_59_0._powerInfos[arg_59_1.powerId] = var_59_0
end

function var_0_0.getPowerInfos(arg_60_0)
	return arg_60_0._powerInfos or {}
end

function var_0_0.getPowerInfo(arg_61_0, arg_61_1)
	return arg_61_0._powerInfos and arg_61_0._powerInfos[arg_61_1]
end

function var_0_0.hasStress(arg_62_0)
	local var_62_0 = arg_62_0._powerInfos and arg_62_0._powerInfos[FightEnum.PowerType.Stress]

	return var_62_0 and var_62_0.max > 0
end

function var_0_0.changePowerMax(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_0._powerInfos and arg_63_0._powerInfos[arg_63_1] then
		arg_63_0._powerInfos[arg_63_1].max = arg_63_0._powerInfos[arg_63_1].max + arg_63_2
	end
end

function var_0_0.buildSummonedInfo(arg_64_0, arg_64_1)
	arg_64_0.summonedInfo = arg_64_0.summonedInfo or FightEntitySummonedInfo.New()

	arg_64_0.summonedInfo:init(arg_64_1)

	return arg_64_0.summonedInfo
end

function var_0_0.getSummonedInfo(arg_65_0)
	arg_65_0.summonedInfo = arg_65_0.summonedInfo or FightEntitySummonedInfo.New()

	return arg_65_0.summonedInfo
end

function var_0_0.buildEnhanceInfoBox(arg_66_0, arg_66_1)
	arg_66_0.canUpgradeIds = {}
	arg_66_0.upgradedOptions = {}

	if arg_66_1 then
		for iter_66_0, iter_66_1 in ipairs(arg_66_1.canUpgradeIds) do
			arg_66_0.canUpgradeIds[iter_66_1] = iter_66_1
		end

		for iter_66_2, iter_66_3 in ipairs(arg_66_1.upgradedOptions) do
			arg_66_0.upgradedOptions[iter_66_3] = iter_66_3
		end
	end
end

function var_0_0.getTrialAttrCo(arg_67_0)
	if not arg_67_0.trialId or arg_67_0.trialId <= 0 then
		return
	end

	local var_67_0 = lua_hero_trial.configDict[arg_67_0.trialId][0]

	if not var_67_0 then
		return
	end

	if var_67_0.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[var_67_0.attrId]
end

function var_0_0.updateStoredExPoint(arg_68_0)
	arg_68_0.storedExPoint = 0

	for iter_68_0, iter_68_1 in ipairs(arg_68_0:getBuffList()) do
		local var_68_0 = iter_68_1.actCommonParams

		if not string.nilorempty(var_68_0) then
			local var_68_1 = FightStrUtil.instance:getSplitToNumberCache(var_68_0, "#")
			local var_68_2 = var_68_1[1]
			local var_68_3 = lua_buff_act.configDict[var_68_2]

			if (var_68_3 and var_68_3.type) == FightEnum.BuffType_ExPointOverflowBank then
				arg_68_0.storedExPoint = arg_68_0.storedExPoint + var_68_1[2]
			end
		end
	end
end

function var_0_0.setStoredExPoint(arg_69_0, arg_69_1)
	arg_69_0.storedExPoint = arg_69_1
end

function var_0_0.changeStoredExPoint(arg_70_0, arg_70_1)
	arg_70_0.storedExPoint = arg_70_0.storedExPoint + arg_70_1
end

function var_0_0.getStoredExPoint(arg_71_0)
	return arg_71_0.storedExPoint
end

function var_0_0.hadStoredExPoint(arg_72_0)
	return arg_72_0.storedExPoint > 0
end

function var_0_0.getResistanceDict(arg_73_0)
	arg_73_0.resistanceDict = arg_73_0.resistanceDict or {}

	tabletool.clear(arg_73_0.resistanceDict)

	local var_73_0 = FightModel.instance:getSpAttributeMo(arg_73_0.uid)

	if var_73_0 then
		for iter_73_0, iter_73_1 in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			local var_73_1 = var_73_0[iter_73_1]

			if var_73_1 and var_73_1 > 0 then
				arg_73_0.resistanceDict[iter_73_0] = var_73_1
			end
		end
	end

	return arg_73_0.resistanceDict
end

function var_0_0.isFullResistance(arg_74_0, arg_74_1)
	local var_74_0 = FightModel.instance:getSpAttributeMo(arg_74_0.uid)

	if not var_74_0 then
		return false
	end

	local var_74_1 = var_74_0[arg_74_1]

	if not var_74_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_74_0:getEntityName(), arg_74_1))

		return false
	end

	return var_74_1 >= 1000
end

function var_0_0.isPartResistance(arg_75_0, arg_75_1)
	local var_75_0 = FightModel.instance:getSpAttributeMo(arg_75_0.uid)

	if not var_75_0 then
		return false
	end

	local var_75_1 = var_75_0[arg_75_1]

	if not var_75_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_75_0:getEntityName(), arg_75_1))

		return false
	end

	return var_75_1 > 0
end

function var_0_0.setNotifyBindContract(arg_76_0)
	arg_76_0.notifyBindContract = true
end

function var_0_0.clearNotifyBindContract(arg_77_0)
	arg_77_0.notifyBindContract = nil
end

function var_0_0.isStatusDead(arg_78_0)
	return arg_78_0.status == FightEnum.EntityStatus.Dead
end

function var_0_0.setDead(arg_79_0)
	arg_79_0.status = FightEnum.EntityStatus.Dead
end

function var_0_0.getCareer(arg_80_0)
	if arg_80_0:isASFDEmitter() then
		return arg_80_0:getASFDCareer()
	end

	return arg_80_0.career
end

function var_0_0.getASFDCareer(arg_81_0)
	for iter_81_0, iter_81_1 in pairs(arg_81_0.buffDic) do
		local var_81_0 = iter_81_1.buffId
		local var_81_1 = arg_81_0:getFeaturesSplitInfoByBuffId(var_81_0)

		if var_81_1 then
			for iter_81_2, iter_81_3 in ipairs(var_81_1) do
				local var_81_2 = lua_buff_act.configDict[iter_81_3[1]]

				if var_81_2 and var_81_2.type == FightEnum.BuffType_EmitterCareerChange then
					return tonumber(iter_81_3[2])
				end
			end
		end
	end

	return arg_81_0.career
end

return var_0_0
