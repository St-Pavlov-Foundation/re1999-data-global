module("modules.logic.tower.model.TowerAssistBossMo", package.seeall)

local var_0_0 = pureTable("TowerAssistBossMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.level = 0
	arg_1_0.talentPoint = 0
	arg_1_0.useTalentPlan = 1
	arg_1_0.customPlanCount = 1
	arg_1_0.trialLevel = 0
	arg_1_0.trialTalentPlan = 0
	arg_1_0.isTemp = false
end

function var_0_0.setTrialInfo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.trialLevel = arg_2_1
	arg_2_0.trialTalentPlan = arg_2_2
end

function var_0_0.onTowerActiveTalent(arg_3_0, arg_3_1)
	arg_3_0:addTalentId(arg_3_1.talentId)

	arg_3_0.talentPoint = arg_3_1.talentPoint
	arg_3_0.talentPlanDict[arg_3_0.useTalentPlan].talentPoint = arg_3_0.talentPoint
end

function var_0_0.onTowerResetTalent(arg_4_0, arg_4_1)
	arg_4_0.talentPoint = arg_4_1.talentPoint

	if arg_4_1.talentId == 0 then
		arg_4_0:initTalentIds()

		arg_4_0.talentPlanDict[arg_4_0.useTalentPlan].talentIds = arg_4_0.talentIdList
		arg_4_0.talentPlanDict[arg_4_0.useTalentPlan].talentPoint = arg_4_0.talentPoint
	else
		arg_4_0:removeTalentId(arg_4_1.talentId)
	end
end

function var_0_0.updateInfo(arg_5_0, arg_5_1)
	arg_5_0.level = arg_5_1.level
	arg_5_0.useTalentPlan = arg_5_1.useTalentPlan or 1

	arg_5_0:initTalentPlanInfos(arg_5_1.talentPlans)
	arg_5_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_6_0)
	arg_6_0:initCurTalentInfo()
	arg_6_0:initTalentIds(arg_6_0.talentIds)
end

function var_0_0.initCurTalentInfo(arg_7_0)
	local var_7_0 = arg_7_0.trialTalentPlan > 0 and arg_7_0.trialTalentPlan or arg_7_0.useTalentPlan

	arg_7_0.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

	if var_7_0 <= arg_7_0.customPlanCount then
		arg_7_0.talentIds = arg_7_0.talentPlanDict and arg_7_0.talentPlanDict[var_7_0].talentIds or {}
		arg_7_0.talentPoint = arg_7_0.talentPlanDict and arg_7_0.talentPlanDict[var_7_0].talentPoint or 0
	else
		arg_7_0.talentIds = TowerConfig.instance:getTalentPlanNodeIds(arg_7_0.id, arg_7_0.trialTalentPlan > 0 and arg_7_0.trialTalentPlan or arg_7_0.useTalentPlan, arg_7_0.trialLevel > 0 and arg_7_0.trialLevel or arg_7_0.level)

		local var_7_1 = TowerConfig.instance:getAllTalentPoint(arg_7_0.id, arg_7_0.trialLevel > 0 and arg_7_0.trialLevel or arg_7_0.level)

		arg_7_0:initTalentIds(arg_7_0.talentIds)

		arg_7_0.talentPoint = var_7_1 - arg_7_0:getCurCostTalentPoint()
	end
end

function var_0_0.initTalentIds(arg_8_0, arg_8_1)
	arg_8_0.talentIdDict = {}
	arg_8_0.talentIdList = {}
	arg_8_0.talentIdCount = 0

	if arg_8_1 then
		for iter_8_0 = 1, #arg_8_1 do
			arg_8_0:addTalentId(arg_8_1[iter_8_0])
		end
	end
end

function var_0_0.addTalentId(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_0:isActiveTalent(arg_9_1) then
		return
	end

	arg_9_0.talentIdCount = arg_9_0.talentIdCount + 1
	arg_9_0.talentIdDict[arg_9_1] = 1
	arg_9_0.talentIdList[arg_9_0.talentIdCount] = arg_9_1

	if arg_9_0.talentPlanDict and arg_9_0.useTalentPlan <= arg_9_0.customPlanCount then
		arg_9_0.talentPlanDict[arg_9_0.useTalentPlan].talentIds = arg_9_0.talentIdList
	end
end

function var_0_0.removeTalentId(arg_10_0, arg_10_1)
	if not arg_10_1 or not arg_10_0:isActiveTalent(arg_10_1) then
		return
	end

	arg_10_0.talentIdCount = arg_10_0.talentIdCount - 1
	arg_10_0.talentIdDict[arg_10_1] = nil

	tabletool.removeValue(arg_10_0.talentIdList, arg_10_1)

	if arg_10_0.useTalentPlan <= arg_10_0.customPlanCount then
		arg_10_0.talentPlanDict[arg_10_0.useTalentPlan].talentIds = arg_10_0.talentIdList
	end
end

function var_0_0.isActiveTalent(arg_11_0, arg_11_1)
	return arg_11_0.talentIdDict[arg_11_1] ~= nil
end

function var_0_0.getTalentPoint(arg_12_0)
	return arg_12_0.talentPoint
end

function var_0_0.getTalentTree(arg_13_0)
	if not arg_13_0.talentTree then
		arg_13_0.talentTree = TowerTalentTree.New()

		local var_13_0 = TowerConfig.instance:getAssistTalentConfig().configDict[arg_13_0.id]

		arg_13_0.talentTree:initTree(arg_13_0, var_13_0)
	end

	return arg_13_0.talentTree
end

function var_0_0.getTalentActiveCount(arg_14_0)
	return arg_14_0:getCurCostTalentPoint(), arg_14_0.talentPoint
end

function var_0_0.getCurCostTalentPoint(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.talentIdList) do
		var_15_0 = var_15_0 + TowerConfig.instance:getAssistTalentConfigById(arg_15_0.id, iter_15_1).consume
	end

	return var_15_0
end

function var_0_0.hasTalentCanActive(arg_16_0)
	if arg_16_0.useTalentPlan > arg_16_0.customPlanCount then
		return false
	end

	return arg_16_0:getTalentTree():hasTalentCanActive()
end

function var_0_0.initTalentPlanInfos(arg_17_0, arg_17_1)
	arg_17_0.talentPlanDict = {}

	local var_17_0 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount)

	for iter_17_0 = 1, var_17_0 do
		local var_17_1 = arg_17_1[iter_17_0]

		if not var_17_1 then
			var_17_1 = {
				talentIds = {}
			}

			logWarn("boss" .. arg_17_0.id .. "天赋方案数据为空" .. iter_17_0)
		end

		local var_17_2 = {
			planId = var_17_1.planId or iter_17_0,
			talentPoint = var_17_1.talentPoint or TowerConfig.instance:getAllTalentPoint(arg_17_0.id, arg_17_0.trialLevel > 0 and arg_17_0.trialLevel or arg_17_0.level),
			planName = string.nilorempty(var_17_1.planName) and GameUtil.getSubPlaceholderLuaLang(luaLang("towerbosstalentplan"), {
				iter_17_0
			}) or var_17_1.planName,
			talentIds = {}
		}

		for iter_17_1, iter_17_2 in ipairs(var_17_1.talentIds) do
			table.insert(var_17_2.talentIds, iter_17_2)
		end

		arg_17_0.talentPlanDict[var_17_2.planId] = var_17_2
	end
end

function var_0_0.renameTalentPlan(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.talentPlanDict[arg_18_0.useTalentPlan]

	if var_18_0 then
		var_18_0.planName = arg_18_1
	end
end

function var_0_0.getTalentPlanInfos(arg_19_0)
	return arg_19_0.talentPlanDict
end

function var_0_0.setCurUseTalentPlan(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		arg_20_0.trialTalentPlan = arg_20_1
	else
		arg_20_0.useTalentPlan = arg_20_1
		arg_20_0.trialTalentPlan = 0
	end

	arg_20_0:refreshTalent()
end

function var_0_0.getCurUseTalentPlan(arg_21_0)
	return arg_21_0.useTalentPlan
end

function var_0_0.setTempState(arg_22_0, arg_22_1)
	arg_22_0.isTemp = arg_22_1
end

function var_0_0.getTempState(arg_23_0)
	return arg_23_0.isTemp
end

function var_0_0.isSelectedSystemTalentPlan(arg_24_0)
	local var_24_0 = arg_24_0.trialTalentPlan > 0 and arg_24_0.trialTalentPlan or arg_24_0.useTalentPlan

	arg_24_0.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

	return var_24_0 > arg_24_0.customPlanCount
end

return var_0_0
