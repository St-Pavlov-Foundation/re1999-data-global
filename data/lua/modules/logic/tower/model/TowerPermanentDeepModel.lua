module("modules.logic.tower.model.TowerPermanentDeepModel", package.seeall)

local var_0_0 = class("TowerPermanentDeepModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:initData()

	arg_2_0.curDeepGroupMo = nil
	arg_2_0.saveDeepGroupMoMap = {}
	arg_2_0.isOpenEndless = false
	arg_2_0.maxHighDeep = 0
	arg_2_0.fightResult = nil
	arg_2_0.isNewRecord = false
	arg_2_0.lastMaxHigDeep = 0
	arg_2_0.isFailFightNotEnd = false
end

function var_0_0.initData(arg_3_0)
	arg_3_0.isInDeepLayerState = false
	arg_3_0.isSelectDeepLayerCategory = false
end

function var_0_0.onReceiveTowerDeepGetInfoReply(arg_4_0, arg_4_1)
	arg_4_0:updateCurGroupMo(arg_4_1.group)

	arg_4_0.saveDeepGroupMoMap = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.archives) do
		arg_4_0:updateSaveGroupMo(iter_4_1)
	end

	arg_4_0.isOpenEndless = arg_4_1.endless
	arg_4_0.maxHighDeep = arg_4_1.highDeep
end

function var_0_0.updateCurGroupMo(arg_5_0, arg_5_1)
	if not arg_5_0.curDeepGroupMo then
		arg_5_0.curDeepGroupMo = TowerDeepGroupMo.New()
	end

	arg_5_0.curDeepGroupMo:updateGroupData(arg_5_1)
end

function var_0_0.updateSaveGroupMo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.saveDeepGroupMoMap[arg_6_1.archiveNo]

	if not var_6_0 then
		var_6_0 = TowerDeepGroupMo.New()
		arg_6_0.saveDeepGroupMoMap[arg_6_1.archiveNo] = var_6_0
	end

	var_6_0:updateArchiveData(arg_6_1)
end

function var_0_0.updateFightResult(arg_7_0, arg_7_1)
	arg_7_0:updateCurGroupMo(arg_7_1.group)

	arg_7_0.fightResult = arg_7_1.result
	arg_7_0.isNewRecord = arg_7_1.newRecord
	arg_7_0.lastMaxHigDeep = arg_7_0.maxHighDeep
	arg_7_0.maxHighDeep = arg_7_1.highDeep
end

function var_0_0.getCurMaxDeepHigh(arg_8_0)
	local var_8_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return Mathf.Max(arg_8_0.maxHighDeep, var_8_0)
end

function var_0_0.getLastMaxDeepHigh(arg_9_0)
	return arg_9_0.lastMaxHigDeep == 0 and arg_9_0:getCurMaxDeepHigh() or arg_9_0.lastMaxHigDeep
end

function var_0_0.setLastMaxDeepHigh(arg_10_0)
	arg_10_0.lastMaxHigDeep = arg_10_0.maxHighDeep
end

function var_0_0.getCurDeepHigh(arg_11_0)
	local var_11_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return arg_11_0.curDeepGroupMo and arg_11_0.curDeepGroupMo.curDeep > 0 and arg_11_0.curDeepGroupMo.curDeep or var_11_0
end

function var_0_0.getCurDeepGroupMo(arg_12_0)
	return arg_12_0.curDeepGroupMo
end

function var_0_0.getSaveDeepGroupMoMap(arg_13_0)
	return arg_13_0.saveDeepGroupMoMap
end

function var_0_0.checkDeepLayerUnlock(arg_14_0)
	local var_14_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.UnlockLayer)
	local var_14_1 = TowerModel.instance:getCurPermanentMo()

	return var_14_0 <= (var_14_1 and var_14_1.passLayerId or 0)
end

function var_0_0.setInDeepLayerState(arg_15_0, arg_15_1)
	arg_15_0.isInDeepLayerState = arg_15_1
end

function var_0_0.getIsInDeepLayerState(arg_16_0)
	return arg_16_0.isInDeepLayerState
end

function var_0_0.setIsSelectDeepCategory(arg_17_0, arg_17_1)
	arg_17_0.isSelectDeepLayerCategory = arg_17_1
end

function var_0_0.getIsSelectDeepCategory(arg_18_0)
	return arg_18_0.isSelectDeepLayerCategory
end

function var_0_0.checkEnterDeepLayerGuideFinish(arg_19_0)
	local var_19_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.FirstEnterDeepGuideId)
	local var_19_1 = GuideController.instance:isForbidGuides()

	return GuideModel.instance:isGuideFinish(var_19_0) or var_19_1
end

function var_0_0.checkIsDeepEpisode(arg_20_0, arg_20_1)
	local var_20_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.NormalDeepEpisodeId)
	local var_20_1 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.EndlessDeepEpisodeId)

	return arg_20_1 == var_20_0 or arg_20_1 == var_20_1
end

function var_0_0.getCurDeepGroupWave(arg_21_0)
	local var_21_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupTeamNum)
	local var_21_1 = arg_21_0.curDeepGroupMo and arg_21_0.curDeepGroupMo:getTeamDataList() or {}

	return Mathf.Min(#var_21_1 + 1, var_21_0)
end

function var_0_0.isHeroBan(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.curDeepGroupMo:getAllUsedHeroId()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if arg_22_1 == iter_22_1 then
			return true
		end
	end

	return false
end

function var_0_0.getFightResult(arg_23_0)
	return arg_23_0.fightResult
end

function var_0_0.checkCanShowResultView(arg_24_0)
	return arg_24_0.fightResult and (arg_24_0.fightResult == TowerDeepEnum.FightResult.Fail or arg_24_0.fightResult == TowerDeepEnum.FightResult.Succ), arg_24_0.fightResult
end

function var_0_0.getDeepRare(arg_25_0, arg_25_1)
	local var_25_0 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	return (Mathf.Clamp(Mathf.Ceil((arg_25_1 - var_25_0) / 100), TowerDeepEnum.DefaultDeepRare, TowerDeepEnum.MaxDeepRare))
end

function var_0_0.setIsFightFailNotEndState(arg_26_0, arg_26_1)
	arg_26_0.isFailFightNotEnd = arg_26_1
end

function var_0_0.getIsFightFailNotEndState(arg_27_0)
	return arg_27_0.isFailFightNotEnd
end

function var_0_0.getCurDeepMonsterId(arg_28_0)
	local var_28_0 = arg_28_0:getCurDeepHigh()

	return TowerDeepConfig.instance:getDeepMonsterId(var_28_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
