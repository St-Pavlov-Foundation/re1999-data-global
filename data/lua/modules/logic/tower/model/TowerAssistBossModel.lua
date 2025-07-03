module("modules.logic.tower.model.TowerAssistBossModel", package.seeall)

local var_0_0 = class("TowerAssistBossModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempBossDict = {}
end

function var_0_0.updateAssistBossInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.id
	local var_3_1 = arg_3_0:getById(var_3_0)

	if not var_3_1 then
		var_3_1 = TowerAssistBossMo.New()

		var_3_1:init(var_3_0)
		arg_3_0:addAtLast(var_3_1)
	end

	var_3_1:setTempState(false)
	var_3_1:updateInfo(arg_3_1)
end

function var_0_0.onTowerActiveTalent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.bossId
	local var_4_1 = arg_4_0:getById(var_4_0)

	if var_4_1 then
		var_4_1:onTowerActiveTalent(arg_4_1)
	end
end

function var_0_0.onTowerResetTalent(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.bossId
	local var_5_1 = arg_5_0:getById(var_5_0)

	if var_5_1 then
		var_5_1:onTowerResetTalent(arg_5_1)
	end
end

function var_0_0.getBoss(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1) or arg_6_0.tempBossDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = TowerAssistBossMo.New()

		var_6_0:init(arg_6_1)
		var_6_0:initTalentIds()

		arg_6_0.tempBossDict[arg_6_1] = var_6_0
	end

	return var_6_0
end

function var_0_0.onTowerRenameTalentPlan(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.bossId
	local var_7_1 = arg_7_0:getById(var_7_0)

	if var_7_1 then
		var_7_1:renameTalentPlan(arg_7_1.planName)
	end
end

function var_0_0.cleanTrialLevel(arg_8_0)
	local var_8_0 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		iter_8_1:setTrialInfo(0, iter_8_1.useTalentPlan)
	end
end

function var_0_0.getLimitedTrialBossSaveKey(arg_9_0, arg_9_1)
	local var_9_0 = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	return "TowerLimitedTrialBoss" .. var_9_0.towerId .. "_" .. arg_9_1.id
end

function var_0_0.setLimitedTrialBossInfo(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local var_10_1 = arg_10_0:getLimitedTrialBossLocalPlan(arg_10_1)

	arg_10_1:setTrialInfo(var_10_0, var_10_1)
	arg_10_1:refreshTalent()
end

function var_0_0.getLimitedTrialBossLocalPlan(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getLimitedTrialBossSaveKey(arg_11_1)
	local var_11_1 = TowerConfig.instance:getAllTalentPlanConfig(arg_11_1.id)[1].planId

	return (TowerController.instance:getPlayerPrefs(var_11_0, var_11_1))
end

function var_0_0.getLimitedTrialBossTalentPlan(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = HeroGroupModel.instance:getCurGroupMO()
	local var_12_2 = var_12_1 and var_12_1:getAssistBossId() or FightModel.instance.last_fightGroup.assistBossId
	local var_12_3 = arg_12_0:getBoss(var_12_2)

	if arg_12_1.towerType == TowerEnum.TowerType.Limited then
		local var_12_4 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

		var_12_0 = var_12_3 and var_12_3.trialTalentPlan > 0 and var_12_4 > var_12_3.level and var_12_3.trialTalentPlan or 0

		return var_12_0
	else
		return var_12_3 and var_12_3.useTalentPlan or 0
	end

	return var_12_0
end

function var_0_0.getTempUnlockTrialBossMO(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_1 == 0 then
		return
	end

	local var_13_0 = arg_13_0:getById(arg_13_1)

	if not var_13_0 then
		var_13_0 = arg_13_0:buildTempUnlockTrialBossMO(arg_13_1)

		arg_13_0:addAtLast(var_13_0)

		return var_13_0
	elseif var_13_0 and var_13_0:getTempState() then
		return arg_13_0:buildTempUnlockTrialBossMO(arg_13_1, var_13_0)
	end
end

function var_0_0.buildTempUnlockTrialBossMO(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2 or TowerAssistBossMo.New()

	var_14_0:init(arg_14_1)
	var_14_0:setTempState(true)

	local var_14_1 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))
	local var_14_2 = arg_14_0:getLimitedTrialBossLocalPlan({
		id = arg_14_1
	})

	var_14_0:setTrialInfo(var_14_1, var_14_2)
	var_14_0:refreshTalent()

	return var_14_0
end

function var_0_0.sortBossList(arg_15_0, arg_15_1)
	if arg_15_0.towerStartTime ~= arg_15_1.towerStartTime then
		return arg_15_0.towerStartTime > arg_15_1.towerStartTime
	else
		return arg_15_0.towerId < arg_15_1.towerId
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
