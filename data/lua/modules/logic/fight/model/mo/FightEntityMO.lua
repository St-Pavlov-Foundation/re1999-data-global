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
	arg_3_0.exPointType = arg_3_1.exPointType
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

function var_0_0.getBuffDic(arg_16_0)
	return arg_16_0.buffDic
end

function var_0_0.addBuff(arg_17_0, arg_17_1)
	if not arg_17_0.buffDic[arg_17_1.uid] then
		local var_17_0 = FightBuffMO.New()

		var_17_0:init(arg_17_1, arg_17_0.id)

		arg_17_0.buffDic[arg_17_1.uid] = var_17_0

		arg_17_0:_dealBuffFeature()

		return true
	end
end

function var_0_0.delBuff(arg_18_0, arg_18_1)
	if arg_18_0.buffDic[arg_18_1] then
		arg_18_0.buffDic[arg_18_1] = nil

		arg_18_0:_dealBuffFeature()
	end
end

function var_0_0.updateBuff(arg_19_0, arg_19_1)
	if arg_19_0.buffDic[arg_19_1.uid] then
		arg_19_0.buffDic[arg_19_1.uid]:init(arg_19_1, arg_19_0.id)
	end
end

function var_0_0.getBuffMO(arg_20_0, arg_20_1)
	return arg_20_0.buffDic[arg_20_1]
end

function var_0_0.clearAllBuff(arg_21_0)
	tabletool.clear(arg_21_0.buffDic)
end

function var_0_0.getEntityName(arg_22_0)
	local var_22_0 = arg_22_0:getCO()

	return var_22_0 and var_22_0.name or "nil"
end

function var_0_0.isEnemySide(arg_23_0)
	return arg_23_0.side == FightEnum.EntitySide.EnemySide
end

function var_0_0.isMySide(arg_24_0)
	return arg_24_0.side == FightEnum.EntitySide.MySide
end

function var_0_0.getIdName(arg_25_0)
	local var_25_0 = arg_25_0.side == FightEnum.EntitySide.MySide and FightEnum.EntityGOName.MySide or FightEnum.EntityGOName.EnemySide

	return string.format("%s_%d", var_25_0, arg_25_0.position)
end

function var_0_0.getCO(arg_26_0)
	if arg_26_0:isCharacter() then
		return lua_character.configDict[arg_26_0.modelId]
	elseif arg_26_0:isMonster() then
		return lua_monster.configDict[arg_26_0.modelId]
	elseif arg_26_0:isAssistBoss() then
		return lua_tower_assist_boss.configDict[arg_26_0.modelId]
	elseif arg_26_0:isASFDEmitter() then
		return FightASFDConfig.instance:getASFDEmitterConfig(arg_26_0.side)
	end

	return lua_character.configDict[arg_26_0.modelId] or lua_monster.configDict[arg_26_0.modelId]
end

function var_0_0.isCharacter(arg_27_0)
	return arg_27_0.entityType == FightEnum.EntityType.Character
end

function var_0_0.isMonster(arg_28_0)
	return arg_28_0.entityType == FightEnum.EntityType.Monster
end

function var_0_0.isAssistBoss(arg_29_0)
	return arg_29_0.entityType == FightEnum.EntityType.AssistBoss
end

function var_0_0.isASFDEmitter(arg_30_0)
	return arg_30_0.entityType == FightEnum.EntityType.ASFDEmitter
end

function var_0_0.getSpineSkinCO(arg_31_0)
	local var_31_0 = arg_31_0.skin

	if not var_31_0 then
		local var_31_1 = lua_character.configDict[arg_31_0.modelId]

		var_31_0 = var_31_1 and var_31_1.skinId
	end

	if not var_31_0 then
		local var_31_2 = lua_monster.configDict[arg_31_0.modelId]
		local var_31_3

		var_31_3 = var_31_2 and var_31_2.skinId
	end

	local var_31_4 = FightConfig.instance:getSkinCO(arg_31_0.skin)

	if var_31_4 then
		return var_31_4
	else
		if FightEntityDataHelper.isPlayerUid(arg_31_0.id) then
			return
		end

		logError("skin not exist: " .. arg_31_0.skin .. " modelId: " .. arg_31_0.modelId)
	end
end

function var_0_0.resetSimulateExPoint(arg_32_0)
	arg_32_0.playCardExPoint = 0
	arg_32_0.moveCardExPoint = 0
end

function var_0_0.applyMoveCardExPoint(arg_33_0)
	arg_33_0.moveCardExPoint = 0
	arg_33_0.playCardExPoint = 0
end

function var_0_0.getExPoint(arg_34_0)
	return arg_34_0.exPoint
end

function var_0_0.setExPoint(arg_35_0, arg_35_1)
	arg_35_0.exPoint = arg_35_1
end

function var_0_0.changeExpointMaxAdd(arg_36_0, arg_36_1)
	arg_36_0.expointMaxAdd = arg_36_0.expointMaxAdd or 0
	arg_36_0.expointMaxAdd = arg_36_0.expointMaxAdd + arg_36_1
end

function var_0_0.getMaxExPoint(arg_37_0)
	if not arg_37_0:getCO() then
		return 0
	end

	return arg_37_0:getConfigMaxExPoint() + arg_37_0:getExpointMaxAddNum()
end

function var_0_0.getExpointMaxAddNum(arg_38_0)
	return arg_38_0.expointMaxAdd or 0
end

function var_0_0.changeServerUniqueCost(arg_39_0, arg_39_1)
	arg_39_0.exSkillPointChange = arg_39_0:getExpointCostOffsetNum() + arg_39_1
end

function var_0_0.getUniqueSkillPoint(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.buffDic) do
		local var_40_0 = iter_40_1.buffId
		local var_40_1 = arg_40_0:getFeaturesSplitInfoByBuffId(var_40_0)

		if var_40_1 then
			for iter_40_2, iter_40_3 in ipairs(var_40_1) do
				if iter_40_3[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					return 0
				end
			end
		end
	end

	return arg_40_0:getConfigMaxExPoint() + arg_40_0:getExpointCostOffsetNum()
end

function var_0_0.getExpointCostOffsetNum(arg_41_0)
	return arg_41_0.exSkillPointChange or 0
end

function var_0_0.getPreviewExPoint(arg_42_0)
	return arg_42_0.exPoint + arg_42_0.moveCardExPoint + arg_42_0.playCardExPoint - FightHelper.getPredeductionExpoint(arg_42_0.id)
end

function var_0_0.onPlayCardExPoint(arg_43_0, arg_43_1)
	if not FightCardDataHelper.isBigSkill(arg_43_1) then
		local var_43_0 = arg_43_0:getMaxExPoint()

		if var_43_0 > arg_43_0:getPreviewExPoint() then
			arg_43_0.playCardExPoint = arg_43_0.playCardExPoint + arg_43_0._playCardAddExpoint

			if var_43_0 < arg_43_0:getPreviewExPoint() then
				arg_43_0.playCardExPoint = arg_43_0.playCardExPoint - (arg_43_0:getPreviewExPoint() - var_43_0)
			end
		end
	end
end

function var_0_0.onMoveCardExPoint(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1 and arg_44_0._moveCardAddExpoint or arg_44_0._combineCardAddExpoint
	local var_44_1 = arg_44_0:getMaxExPoint()

	if var_44_1 > arg_44_0:getPreviewExPoint() then
		arg_44_0.moveCardExPoint = arg_44_0.moveCardExPoint + var_44_0

		if var_44_1 < arg_44_0:getPreviewExPoint() then
			arg_44_0.moveCardExPoint = arg_44_0.moveCardExPoint - (arg_44_0:getPreviewExPoint() - var_44_1)
		end
	end
end

function var_0_0._dealBuffFeature(arg_45_0)
	arg_45_0._playCardAddExpoint = 1
	arg_45_0._moveCardAddExpoint = 1
	arg_45_0._combineCardAddExpoint = 1

	for iter_45_0, iter_45_1 in pairs(arg_45_0.buffDic) do
		local var_45_0 = iter_45_1.buffId
		local var_45_1 = arg_45_0:getFeaturesSplitInfoByBuffId(var_45_0)

		if var_45_1 then
			for iter_45_2, iter_45_3 in ipairs(var_45_1) do
				if iter_45_3[1] == 606 then
					arg_45_0._combineCardAddExpoint = arg_45_0._combineCardAddExpoint + iter_45_3[2]
				elseif iter_45_3[1] == 607 then
					arg_45_0._moveCardAddExpoint = arg_45_0._moveCardAddExpoint + iter_45_3[2]
				elseif iter_45_3[1] == 603 then
					arg_45_0._playCardAddExpoint = 0
					arg_45_0._combineCardAddExpoint = 0
					arg_45_0._moveCardAddExpoint = 0

					return
				elseif iter_45_3[1] == 845 then
					arg_45_0._playCardAddExpoint = arg_45_0._playCardAddExpoint + iter_45_3[2]
				end
			end
		end
	end
end

function var_0_0.getCombineCardAddExPoint(arg_46_0)
	return arg_46_0._combineCardAddExpoint
end

function var_0_0.getMoveCardAddExPoint(arg_47_0)
	return arg_47_0._moveCardAddExpoint
end

function var_0_0.getPlayCardAddExPoint(arg_48_0)
	return arg_48_0._playCardAddExpoint
end

function var_0_0.getFeaturesSplitInfoByBuffId(arg_49_0, arg_49_1)
	if not arg_49_0.buffFeaturesSplit then
		arg_49_0.buffFeaturesSplit = {}
	end

	if not arg_49_0.buffFeaturesSplit[arg_49_1] then
		local var_49_0 = lua_skill_buff.configDict[arg_49_1]
		local var_49_1 = var_49_0 and var_49_0.features

		if not string.nilorempty(var_49_1) then
			local var_49_2 = FightStrUtil.instance:getSplitString2Cache(var_49_1, true)

			arg_49_0.buffFeaturesSplit[arg_49_1] = var_49_2
		end
	end

	return arg_49_0.buffFeaturesSplit[arg_49_1]
end

function var_0_0.hasBuffFeature(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.buffDic) do
		local var_50_0 = iter_50_1.buffId
		local var_50_1 = arg_50_0:getFeaturesSplitInfoByBuffId(var_50_0)

		if var_50_1 then
			for iter_50_2, iter_50_3 in ipairs(var_50_1) do
				local var_50_2 = lua_buff_act.configDict[iter_50_3[1]]

				if var_50_2 and var_50_2.type == arg_50_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffActId(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.buffDic) do
		local var_51_0 = iter_51_1.buffId
		local var_51_1 = arg_51_0:getFeaturesSplitInfoByBuffId(var_51_0)

		if var_51_1 then
			for iter_51_2, iter_51_3 in ipairs(var_51_1) do
				if iter_51_3[1] == arg_51_1 then
					return true
				end
			end
		end
	end
end

function var_0_0.hasBuffTypeId(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_0.buffDic) do
		local var_52_0 = iter_52_1:getCO()

		if var_52_0 and var_52_0.typeId == arg_52_1 then
			return true
		end
	end
end

function var_0_0.hasBuffId(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in pairs(arg_53_0.buffDic) do
		if iter_53_1.buffId == arg_53_1 then
			return true
		end
	end
end

function var_0_0.setHp(arg_54_0, arg_54_1)
	if arg_54_0:isASFDEmitter() then
		return arg_54_0:setASFDEmitterHp(arg_54_1)
	end

	arg_54_0:defaultSetHp(arg_54_1)
end

function var_0_0.defaultSetHp(arg_55_0, arg_55_1)
	if arg_55_1 < 0 then
		arg_55_1 = 0
	end

	if arg_55_1 > arg_55_0.attrMO.hp then
		arg_55_1 = arg_55_0.attrMO.hp
	end

	arg_55_0.currentHp = arg_55_1
end

function var_0_0.setASFDEmitterHp(arg_56_0, arg_56_1)
	if arg_56_1 < 0 then
		arg_56_1 = 0
	end

	arg_56_0.currentHp = arg_56_1
end

function var_0_0.setShield(arg_57_0, arg_57_1)
	arg_57_0.shieldValue = arg_57_1
end

function var_0_0.onChangeHero(arg_58_0)
	tabletool.clear(arg_58_0.buffDic)
	arg_58_0:_dealBuffFeature()
	arg_58_0:setShield(0)
end

function var_0_0.setPowerInfos(arg_59_0, arg_59_1)
	arg_59_0._powerInfos = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		arg_59_0:refreshPowerInfo(iter_59_1)
	end
end

function var_0_0.refreshPowerInfo(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0._powerInfos[arg_60_1.powerId] or {}

	var_60_0.powerId = arg_60_1.powerId
	var_60_0.num = arg_60_1.num
	var_60_0.max = arg_60_1.max
	arg_60_0._powerInfos[arg_60_1.powerId] = var_60_0
end

function var_0_0.getPowerInfos(arg_61_0)
	return arg_61_0._powerInfos or {}
end

function var_0_0.getPowerInfo(arg_62_0, arg_62_1)
	return arg_62_0._powerInfos and arg_62_0._powerInfos[arg_62_1]
end

function var_0_0.hasStress(arg_63_0)
	local var_63_0 = arg_63_0._powerInfos and arg_63_0._powerInfos[FightEnum.PowerType.Stress]

	return var_63_0 and var_63_0.max > 0
end

function var_0_0.changePowerMax(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_0._powerInfos and arg_64_0._powerInfos[arg_64_1] then
		arg_64_0._powerInfos[arg_64_1].max = arg_64_0._powerInfos[arg_64_1].max + arg_64_2
	end
end

function var_0_0.buildSummonedInfo(arg_65_0, arg_65_1)
	arg_65_0.summonedInfo = arg_65_0.summonedInfo or FightEntitySummonedInfo.New()

	arg_65_0.summonedInfo:init(arg_65_1)

	return arg_65_0.summonedInfo
end

function var_0_0.getSummonedInfo(arg_66_0)
	arg_66_0.summonedInfo = arg_66_0.summonedInfo or FightEntitySummonedInfo.New()

	return arg_66_0.summonedInfo
end

function var_0_0.buildEnhanceInfoBox(arg_67_0, arg_67_1)
	arg_67_0.canUpgradeIds = {}
	arg_67_0.upgradedOptions = {}

	if arg_67_1 then
		for iter_67_0, iter_67_1 in ipairs(arg_67_1.canUpgradeIds) do
			arg_67_0.canUpgradeIds[iter_67_1] = iter_67_1
		end

		for iter_67_2, iter_67_3 in ipairs(arg_67_1.upgradedOptions) do
			arg_67_0.upgradedOptions[iter_67_3] = iter_67_3
		end
	end
end

function var_0_0.getTrialAttrCo(arg_68_0)
	if not arg_68_0.trialId or arg_68_0.trialId <= 0 then
		return
	end

	local var_68_0 = lua_hero_trial.configDict[arg_68_0.trialId][0]

	if not var_68_0 then
		return
	end

	if var_68_0.attrId <= 0 then
		return
	end

	return lua_hero_trial_attr.configDict[var_68_0.attrId]
end

function var_0_0.updateStoredExPoint(arg_69_0)
	arg_69_0.storedExPoint = 0

	for iter_69_0, iter_69_1 in ipairs(arg_69_0:getBuffList()) do
		local var_69_0 = iter_69_1.actCommonParams

		if not string.nilorempty(var_69_0) then
			local var_69_1 = FightStrUtil.instance:getSplitToNumberCache(var_69_0, "#")
			local var_69_2 = var_69_1[1]
			local var_69_3 = lua_buff_act.configDict[var_69_2]

			if (var_69_3 and var_69_3.type) == FightEnum.BuffType_ExPointOverflowBank then
				arg_69_0.storedExPoint = arg_69_0.storedExPoint + var_69_1[2]
			end
		end
	end
end

function var_0_0.setStoredExPoint(arg_70_0, arg_70_1)
	arg_70_0.storedExPoint = arg_70_1
end

function var_0_0.changeStoredExPoint(arg_71_0, arg_71_1)
	arg_71_0.storedExPoint = arg_71_0.storedExPoint + arg_71_1
end

function var_0_0.getStoredExPoint(arg_72_0)
	return arg_72_0.storedExPoint
end

function var_0_0.hadStoredExPoint(arg_73_0)
	return arg_73_0.storedExPoint > 0
end

function var_0_0.getResistanceDict(arg_74_0)
	arg_74_0.resistanceDict = arg_74_0.resistanceDict or {}

	tabletool.clear(arg_74_0.resistanceDict)

	local var_74_0 = FightModel.instance:getSpAttributeMo(arg_74_0.uid)

	if var_74_0 then
		for iter_74_0, iter_74_1 in pairs(FightEnum.ResistanceKeyToSpAttributeMoField) do
			local var_74_1 = var_74_0[iter_74_1]

			if var_74_1 and var_74_1 > 0 then
				arg_74_0.resistanceDict[iter_74_0] = var_74_1
			end
		end
	end

	return arg_74_0.resistanceDict
end

function var_0_0.isFullResistance(arg_75_0, arg_75_1)
	local var_75_0 = FightModel.instance:getSpAttributeMo(arg_75_0.uid)

	if not var_75_0 then
		return false
	end

	local var_75_1 = var_75_0[arg_75_1]

	if not var_75_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_75_0:getEntityName(), arg_75_1))

		return false
	end

	return var_75_1 >= 1000
end

function var_0_0.isPartResistance(arg_76_0, arg_76_1)
	local var_76_0 = FightModel.instance:getSpAttributeMo(arg_76_0.uid)

	if not var_76_0 then
		return false
	end

	local var_76_1 = var_76_0[arg_76_1]

	if not var_76_1 then
		logError(string.format("%s 不存在 %s 的sp attr", arg_76_0:getEntityName(), arg_76_1))

		return false
	end

	return var_76_1 > 0
end

function var_0_0.setNotifyBindContract(arg_77_0)
	arg_77_0.notifyBindContract = true
end

function var_0_0.clearNotifyBindContract(arg_78_0)
	arg_78_0.notifyBindContract = nil
end

function var_0_0.isStatusDead(arg_79_0)
	return arg_79_0.status == FightEnum.EntityStatus.Dead
end

function var_0_0.setDead(arg_80_0)
	arg_80_0.status = FightEnum.EntityStatus.Dead
end

function var_0_0.getCareer(arg_81_0)
	if arg_81_0:isASFDEmitter() then
		return arg_81_0:getASFDCareer()
	end

	return arg_81_0.career
end

function var_0_0.getASFDCareer(arg_82_0)
	for iter_82_0, iter_82_1 in pairs(arg_82_0.buffDic) do
		local var_82_0 = iter_82_1.buffId
		local var_82_1 = arg_82_0:getFeaturesSplitInfoByBuffId(var_82_0)

		if var_82_1 then
			for iter_82_2, iter_82_3 in ipairs(var_82_1) do
				local var_82_2 = lua_buff_act.configDict[iter_82_3[1]]

				if var_82_2 and var_82_2.type == FightEnum.BuffType_EmitterCareerChange then
					return tonumber(iter_82_3[2])
				end
			end
		end
	end

	return arg_82_0.career
end

function var_0_0.getConfigMaxExPoint(arg_83_0)
	if arg_83_0.configMaxExPoint then
		return arg_83_0.configMaxExPoint
	end

	local var_83_0 = arg_83_0:getCO()

	if not var_83_0 then
		return 0
	end

	local var_83_1 = var_83_0.uniqueSkill_point

	if var_83_1 and type(var_83_1) == "string" then
		var_83_1 = tonumber(string.split(var_83_1, "#")[2])
	end

	arg_83_0.configMaxExPoint = var_83_1

	return arg_83_0.configMaxExPoint
end

function var_0_0.getHeroDestinyStoneMo(arg_84_0)
	if arg_84_0.trialId and arg_84_0.trialId > 0 then
		local var_84_0 = lua_hero_trial.configDict[arg_84_0.trialId][0]

		if var_84_0 then
			arg_84_0.destinyStoneMo = arg_84_0.destinyStoneMo or HeroDestinyStoneMO.New(arg_84_0.modelId)

			arg_84_0.destinyStoneMo:refreshMo(var_84_0.facetslevel, 1, var_84_0.facetsId)
		end
	else
		local var_84_1 = HeroModel.instance:getByHeroId(arg_84_0.modelId)

		arg_84_0.destinyStoneMo = var_84_1 and var_84_1.destinyStoneMo
	end

	return arg_84_0.destinyStoneMo
end

return var_0_0
