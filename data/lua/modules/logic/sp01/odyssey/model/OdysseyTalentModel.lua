module("modules.logic.sp01.odyssey.model.OdysseyTalentModel", package.seeall)

local var_0_0 = class("OdysseyTalentModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.curTalentPoint = 0
	arg_2_0.levelAddTalentPoint = 0
	arg_2_0.rewardAddTalentPoint = 0
	arg_2_0.talentNodeMap = {}
	arg_2_0.talentTypeNodeMap = {}
	arg_2_0.curSelectNodeId = 0
end

function var_0_0.resetTalentData(arg_3_0)
	arg_3_0.levelAddTalentPoint = 0
	arg_3_0.rewardAddTalentPoint = 0
	arg_3_0.talentNodeMap = {}
	arg_3_0.talentTypeNodeMap = {}
	arg_3_0.curSelectNodeId = 0
end

function var_0_0.updateTalentInfo(arg_4_0, arg_4_1)
	arg_4_0.curTalentPoint = arg_4_1.point

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.nodes) do
		arg_4_0:updateTalentNode(iter_4_1)
	end

	arg_4_0:buildTalentTypeNodeMap()
	arg_4_0:setCassandraTreeInfoStr(arg_4_1.cassandraTree)
	arg_4_0:setNodeChild()
end

function var_0_0.updateTalentNode(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.talentNodeMap[arg_5_1.id]

	if not var_5_0 then
		var_5_0 = OdysseyTalentNodeMo.New()

		var_5_0:init(arg_5_1.id)

		arg_5_0.talentNodeMap[arg_5_1.id] = var_5_0
	end

	var_5_0:updateInfo(arg_5_1)
end

function var_0_0.buildTalentTypeNodeMap(arg_6_0)
	arg_6_0.talentTypeNodeMap = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.talentNodeMap) do
		if iter_6_1.level > 0 and iter_6_1.config then
			local var_6_0 = iter_6_1.config.type

			arg_6_0.talentTypeNodeMap[var_6_0] = arg_6_0.talentTypeNodeMap[var_6_0] or {}
			arg_6_0.talentTypeNodeMap[var_6_0][iter_6_1.id] = iter_6_1
		end
	end
end

function var_0_0.setNodeChild(arg_7_0)
	arg_7_0:cleanNotLevelUpTalentNode()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.talentNodeMap) do
		local var_7_0 = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(iter_7_1.id)[1].unlockCondition

		if not string.nilorempty(var_7_0) then
			local var_7_1 = GameUtil.splitString2(var_7_0)

			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				if iter_7_3[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
					local var_7_2 = tonumber(iter_7_3[2])
					local var_7_3 = arg_7_0.talentNodeMap[var_7_2]

					if var_7_3 then
						var_7_3:setChildNode(iter_7_1)
					end
				end
			end
		end
	end
end

function var_0_0.cleanNotLevelUpTalentNode(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.talentNodeMap) do
		iter_8_1:cleanChildNodes()

		if iter_8_1.level == 0 and iter_8_1.consume == 0 then
			arg_8_0.talentNodeMap[iter_8_1.id] = nil
		end
	end
end

function var_0_0.checkTalentCanUnlock(arg_9_0, arg_9_1)
	local var_9_0 = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(arg_9_1)[1].unlockCondition

	if string.nilorempty(var_9_0) then
		return true
	end

	local var_9_1 = GameUtil.splitString2(var_9_0)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		if iter_9_1[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
			local var_9_2 = tonumber(iter_9_1[2])

			if tonumber(iter_9_1[3]) > arg_9_0:getTalentConsumeCount(var_9_2) then
				return false, iter_9_1
			end
		elseif iter_9_1[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
			local var_9_3 = tonumber(iter_9_1[2])

			if not arg_9_0.talentNodeMap[var_9_3] then
				return false, iter_9_1
			end
		end
	end

	return true
end

function var_0_0.getTalentConsumeCount(arg_10_0, arg_10_1)
	local var_10_0 = 0
	local var_10_1 = arg_10_0.talentTypeNodeMap[arg_10_1] or {}

	for iter_10_0, iter_10_1 in pairs(var_10_1) do
		if iter_10_1 and iter_10_1.consume > 0 then
			var_10_0 = var_10_0 + iter_10_1.consume
		end
	end

	return var_10_0
end

function var_0_0.getTalentMo(arg_11_0, arg_11_1)
	return arg_11_0.talentNodeMap[arg_11_1]
end

function var_0_0.setCurTalentPoint(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == OdysseyEnum.Reason.LevelUp then
		arg_12_0.levelAddTalentPoint = arg_12_0.levelAddTalentPoint + (arg_12_1 - arg_12_0.curTalentPoint)
	elseif OdysseyEnum.GetItemPushReason[arg_12_2] then
		arg_12_0.rewardAddTalentPoint = arg_12_0.rewardAddTalentPoint + (arg_12_1 - arg_12_0.curTalentPoint)
	end

	arg_12_0.curTalentPoint = arg_12_1
end

function var_0_0.getRewardAddTalentPoint(arg_13_0)
	return arg_13_0.rewardAddTalentPoint
end

function var_0_0.getLevelAddTalentPoint(arg_14_0)
	return arg_14_0.levelAddTalentPoint
end

function var_0_0.getCurTalentPoint(arg_15_0)
	return arg_15_0.curTalentPoint
end

function var_0_0.cleanChangeTalentPoint(arg_16_0)
	arg_16_0.levelAddTalentPoint = 0
	arg_16_0.rewardAddTalentPoint = 0
end

function var_0_0.setCurselectNodeId(arg_17_0, arg_17_1)
	arg_17_0.curSelectNodeId = arg_17_1
end

function var_0_0.getCurSelectNodeId(arg_18_0)
	return arg_18_0.curSelectNodeId
end

function var_0_0.setCassandraTreeInfoStr(arg_19_0, arg_19_1)
	arg_19_0.cassandraTreeInfoStr = arg_19_1
end

function var_0_0.setTrialCassandraTreeInfo(arg_20_0)
	arg_20_0.skillTalentMo = arg_20_0.skillTalentMo or CharacterExtraSkillTalentMO.New()

	local var_20_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_20_1 = tonumber(var_20_0.value)
	local var_20_2 = lua_hero_trial.configDict[var_20_1][0]
	local var_20_3 = HeroGroupTrialModel.instance:getHeroMo(var_20_2)

	if var_20_3 then
		arg_20_0.skillTalentMo:refreshMo(arg_20_0.cassandraTreeInfoStr, var_20_3)
	end
end

function var_0_0.getTrialCassandraTreeInfo(arg_21_0)
	return arg_21_0.skillTalentMo
end

function var_0_0.isHasTalentNode(arg_22_0)
	return tabletool.len(arg_22_0.talentNodeMap) > 0
end

function var_0_0.checkLvDownHasNotAccordLightNumNode(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getTalentMo(arg_23_1)

	if not var_23_0 or var_23_0.level == 0 or not var_23_0.config then
		return false
	end

	local var_23_1 = var_23_0.config.type
	local var_23_2 = arg_23_0.talentTypeNodeMap[var_23_1] or {}
	local var_23_3 = math.ceil(var_23_0.config.position / 2)

	for iter_23_0, iter_23_1 in pairs(var_23_2) do
		if iter_23_1.level > 0 and iter_23_1.config then
			local var_23_4 = math.ceil(iter_23_1.config.position / 2)

			if var_23_3 < var_23_4 and var_23_4 > 1 then
				local var_23_5 = arg_23_0:getCurTalentAllLowLayerTalentConsume(iter_23_1) - var_23_0.config.consume

				if not string.nilorempty(iter_23_1.config.unlockCondition) then
					local var_23_6 = GameUtil.splitString2(iter_23_1.config.unlockCondition)

					for iter_23_2, iter_23_3 in ipairs(var_23_6) do
						if iter_23_3[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
							local var_23_7 = tonumber(iter_23_3[2])

							if var_23_5 < tonumber(iter_23_3[3]) then
								return true
							end
						end
					end
				end
			end
		end
	end

	return false
end

function var_0_0.getCurTalentAllLowLayerTalentConsume(arg_24_0, arg_24_1)
	local var_24_0 = math.ceil(arg_24_1.config.position / 2)
	local var_24_1 = arg_24_0.talentTypeNodeMap[arg_24_1.config.type] or {}
	local var_24_2 = 0

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		if iter_24_1.level > 0 and iter_24_1.config and var_24_0 > math.ceil(iter_24_1.config.position / 2) and iter_24_1.id ~= arg_24_1.id then
			var_24_2 = var_24_2 + iter_24_1.consume
		end
	end

	return var_24_2
end

function var_0_0.isTalentUnlock(arg_25_0)
	local var_25_0 = OdysseyModel.instance:getHeroCurLevelAndExp()

	if var_25_0 == nil then
		return false
	end

	local var_25_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TalentUnlockLevel)
	local var_25_2 = string.split(var_25_1.value, "#")
	local var_25_3 = tonumber(var_25_2[2])

	return var_25_3 ~= nil and var_25_3 <= var_25_0
end

function var_0_0.checkHasNotUsedTalentPoint(arg_26_0)
	return arg_26_0.curTalentPoint > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
