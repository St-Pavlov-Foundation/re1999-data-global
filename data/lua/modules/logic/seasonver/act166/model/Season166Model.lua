module("modules.logic.seasonver.act166.model.Season166Model", package.seeall)

local var_0_0 = class("Season166Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._actInfo = {}
	arg_2_0._battleContext = nil
	arg_2_0.localPrefsDict = {}
	arg_2_0._fightTalentData = {}
end

function var_0_0.setActInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.activityId
	local var_3_1 = arg_3_0._actInfo[var_3_0]

	if not var_3_1 then
		var_3_1 = Season166MO.New()
		arg_3_0._actInfo[var_3_0] = var_3_1
		arg_3_0._curSeasonId = var_3_0
	end

	var_3_1:updateInfo(arg_3_1)
end

function var_0_0.getActInfo(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return nil
	end

	return arg_4_0._actInfo[arg_4_1]
end

function var_0_0.getCurSeasonId(arg_5_0)
	return arg_5_0._curSeasonId
end

function var_0_0.setBattleContext(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	arg_6_0._battleContext = Season166BattleContext.New()

	arg_6_0._battleContext:init(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
end

function var_0_0.getBattleContext(arg_7_0, arg_7_1)
	if not arg_7_1 and not arg_7_0._battleContext then
		logError("battleContext is nil")
	end

	return arg_7_0._battleContext
end

function var_0_0.onReceiveAnalyInfo(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getActInfo(arg_8_1.activityId)

	if var_8_0 then
		var_8_0:updateAnalyInfoStage(arg_8_1.infoId, arg_8_1.stage)
	end
end

function var_0_0.onReceiveInformationBonus(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getActInfo(arg_9_1.activityId)

	if var_9_0 then
		var_9_0:onReceiveInformationBonus(arg_9_1.bonusIds)
	end
end

function var_0_0.onReceiveInfoBonus(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getActInfo(arg_10_1.activityId)

	if var_10_0 then
		var_10_0:updateInfoBonus(arg_10_1.infoId, arg_10_1.bonusStage)
	end
end

function var_0_0.onReceiveUpdateInfos(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getActInfo(arg_11_1.activityId)

	if var_11_0 and var_11_0:updateInfos(arg_11_1.updateInfos) then
		Season166Controller.instance:showToast(Season166Enum.ToastType.Info)
	end
end

function var_0_0.getTalentInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getActInfo(arg_12_1)

	if var_12_0 then
		return var_12_0:getTalentMO(arg_12_2)
	end
end

function var_0_0.onReceiveSetTalentSkill(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getActInfo(arg_13_1.activityId):setTalentSkillIds(arg_13_1.talentId, arg_13_1.skillIds)

	Season166Controller.instance:dispatchEvent(Season166Event.SetTalentSkill, arg_13_1.talentId, var_13_0)
end

function var_0_0.onReceiveAct166TalentPush(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getActInfo(arg_14_1.activityId)

	if var_14_0 then
		var_14_0:updateTalentInfo(arg_14_1.talents)
	end
end

function var_0_0.onReceiveAct166EnterBaseReply(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getActInfo(arg_15_1.activityId)

	if var_15_0 then
		var_15_0:setSpotBaseEnter(arg_15_1.baseId, true)
	end
end

function var_0_0.onReceiveBattleFinishPush(arg_16_0, arg_16_1)
	if arg_16_1.activityId ~= arg_16_0._curSeasonId then
		logError("activityId mismatch")

		return
	end

	arg_16_0.fightResult = arg_16_1

	local var_16_0 = arg_16_0:getActInfo(arg_16_1.activityId)

	if var_16_0 and arg_16_1.isHighestScore then
		var_16_0:updateMaxScore(arg_16_1.episodeType, arg_16_1.id, arg_16_1.totalScore)
	end
end

function var_0_0.getFightResult(arg_17_0)
	if not arg_17_0.fightResult then
		logError("not receive 166BattleFinishPush")
	end

	return arg_17_0.fightResult
end

function var_0_0.clearFightResult(arg_18_0)
	arg_18_0.fightResult = nil
end

function var_0_0.setPrefsTalent(arg_19_0)
	PlayerPrefsHelper.setNumber(var_0_0.getKey(), arg_19_0)
end

function var_0_0.getPrefsTalent()
	local var_20_0 = PlayerPrefsHelper.getNumber(var_0_0.getKey(), 0)

	if var_20_0 == 0 then
		return
	end

	return var_20_0
end

function var_0_0.getKey()
	local var_21_0 = PlayerModel.instance:getMyUserId()
	local var_21_1 = var_0_0.instance:getCurSeasonId() or 0

	if var_21_1 == 0 then
		logError("赛季id为空,请检查")
	end

	return tostring(var_21_0) .. PlayerPrefsKey.Season166EquipTalentId .. var_21_1
end

function var_0_0.checkHasNewUnlockInfo(arg_22_0)
	local var_22_0 = arg_22_0:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)
	local var_22_1 = arg_22_0:getActInfo(arg_22_0._curSeasonId)

	if not var_22_1 then
		return false
	end

	local var_22_2 = Season166Config.instance:getSeasonInfos(arg_22_0._curSeasonId)

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		local var_22_3 = var_22_1 and var_22_1:getInformationMO(iter_22_1.infoId)
		local var_22_4 = var_22_3 and Season166Enum.UnlockState or Season166Enum.LockState
		local var_22_5 = var_22_0[iter_22_1.infoId]

		if var_22_3 and var_22_4 ~= var_22_5 then
			return true
		end
	end

	return false
end

function var_0_0.getLocalUnlockState(arg_23_0, arg_23_1)
	local var_23_0 = Season166Controller.instance:getPlayerPrefs(arg_23_1)
	local var_23_1 = Season166Controller.instance:loadDictFromStr(var_23_0)
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		local var_23_3 = string.split(iter_23_1, "|")

		var_23_2[tonumber(var_23_3[1])] = tonumber(var_23_3[2])
	end

	return var_23_2
end

function var_0_0.getCurUnlockTalentData(arg_24_0, arg_24_1)
	local var_24_0 = lua_activity166_talent_style.configDict[arg_24_1]
	local var_24_1 = arg_24_0:getTalentInfo(arg_24_0._curSeasonId, arg_24_1)
	local var_24_2 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if var_24_1.level >= iter_24_1.level and iter_24_1.needStar > 0 then
			table.insert(var_24_2, iter_24_1)
		end
	end

	local var_24_3 = {}

	for iter_24_2, iter_24_3 in ipairs(var_24_2) do
		local var_24_4 = string.splitToNumber(iter_24_3.skillId, "#")

		for iter_24_4, iter_24_5 in ipairs(var_24_4) do
			table.insert(var_24_3, iter_24_5)
		end
	end

	return var_24_2, var_24_3
end

function var_0_0.getUnlockWithNotSelectTalents(arg_25_0, arg_25_1)
	local var_25_0, var_25_1 = arg_25_0:getCurUnlockTalentData(arg_25_1)
	local var_25_2 = arg_25_0:getTalentInfo(arg_25_0._curSeasonId, arg_25_1).skillIds

	if tabletool.len(var_25_2) == 0 then
		return var_25_1
	end

	local var_25_3 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		for iter_25_2, iter_25_3 in ipairs(var_25_2) do
			if tabletool.indexOf(var_25_1, iter_25_3) and iter_25_3 ~= iter_25_1 then
				table.insert(var_25_3, iter_25_1)
			end
		end
	end

	return var_25_3
end

function var_0_0.getTalentLocalSaveKey(arg_26_0, arg_26_1)
	return string.format("%s_%s", Season166Enum.TalentLockSaveKey, arg_26_1)
end

function var_0_0.checkHasNewTalent(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getTalentLocalSaveKey(arg_27_1)
	local var_27_1 = arg_27_0:getLocalUnlockState(var_27_0)
	local var_27_2 = arg_27_0:getUnlockWithNotSelectTalents(arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(var_27_2) do
		if var_27_1[iter_27_1] ~= Season166Enum.UnlockState then
			return true
		end
	end

	return false
end

function var_0_0.checkAllHasNewTalent(arg_28_0, arg_28_1)
	local var_28_0 = lua_activity166_talent.configDict[arg_28_1]

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		if arg_28_0:checkHasNewTalent(iter_28_1.talentId) then
			return true
		end
	end

	return false
end

function var_0_0.checkIsBaseSpotEpisode(arg_29_0)
	local var_29_0 = arg_29_0:getBattleContext()

	return var_29_0 and var_29_0.baseId and var_29_0.baseId > 0
end

function var_0_0.checkCanShowSeasonTalent(arg_30_0)
	local var_30_0 = arg_30_0:getBattleContext()
	local var_30_1 = FightModel.instance:getFightParam()

	if var_30_1 and var_30_1.episodeId then
		local var_30_2 = DungeonConfig.instance:getEpisodeCO(var_30_1.episodeId)

		if not Season166Controller.instance.isSeason166EpisodeType(var_30_2.type) then
			return false
		end
	end

	local var_30_3 = var_30_0.baseId and var_30_0.baseId > 0
	local var_30_4 = var_30_0.trainId and var_30_0.trainId > 0

	return var_30_0 and (var_30_3 or var_30_4)
end

function var_0_0.isTrainPass(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getActInfo(arg_31_1)

	if var_31_0 then
		return var_31_0:isTrainPass(arg_31_2)
	end

	return false
end

function var_0_0.unpackFightReconnectData(arg_32_0, arg_32_1)
	local var_32_0 = cjson.decode(arg_32_1)

	if var_32_0 then
		local var_32_1 = var_32_0.talentId
		local var_32_2 = var_32_0.talentSkillIds
		local var_32_3 = var_32_0.talentLevel

		arg_32_0:setFightTalentParam(var_32_1, var_32_2, var_32_3)
	end
end

function var_0_0.setFightTalentParam(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0._fightTalentData = {}
	arg_33_0._fightTalentData.talentId = arg_33_1
	arg_33_0._fightTalentData.talentSkillIds = {}
	arg_33_0._fightTalentData.talentLevel = arg_33_3

	for iter_33_0, iter_33_1 in ipairs(arg_33_2) do
		table.insert(arg_33_0._fightTalentData.talentSkillIds, iter_33_1)
	end
end

function var_0_0.getFightTalentParam(arg_34_0)
	return arg_34_0._fightTalentData
end

function var_0_0.getLocalPrefsTab(arg_35_0, arg_35_1)
	if not arg_35_0.localPrefsDict[arg_35_1] then
		local var_35_0 = {}
		local var_35_1 = Season166Controller.instance:getPlayerPrefs(arg_35_1)
		local var_35_2 = GameUtil.splitString2(var_35_1, true)

		if var_35_2 then
			for iter_35_0, iter_35_1 in ipairs(var_35_2) do
				var_35_0[iter_35_1[1]] = iter_35_1[2]
			end
		end

		arg_35_0.localPrefsDict[arg_35_1] = var_35_0
	end

	return arg_35_0.localPrefsDict[arg_35_1]
end

function var_0_0.setLocalPrefsTab(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_0:getLocalPrefsTab(arg_36_1)

	if var_36_0[arg_36_2] == arg_36_3 then
		return
	end

	var_36_0[arg_36_2] = arg_36_3

	local var_36_1 = {}

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		table.insert(var_36_1, string.format("%s#%s", iter_36_0, iter_36_1))
	end

	local var_36_2 = table.concat(var_36_1, "|")

	Season166Controller.instance:savePlayerPrefs(arg_36_1, var_36_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
