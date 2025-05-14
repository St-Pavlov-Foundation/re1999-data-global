module("modules.logic.seasonver.act166.model.Season166MO", package.seeall)

local var_0_0 = pureTable("Season166MO")

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.isFinishTeach = arg_1_1.isFinishTeach

	arg_1_0:updateSpotsInfo(arg_1_1.bases)
	arg_1_0:updateTrainsInfo(arg_1_1.trains)
	arg_1_0:updateTeachsInfo(arg_1_1.teachs)
	arg_1_0:updateInfomation(arg_1_1.information)
	arg_1_0:initTalentInfo(arg_1_1.talents)

	arg_1_0.spotHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(arg_1_1.baseHeroGroupSnapshot)
	arg_1_0.trainHeroGroupSnapshot = Season166HeroGroupUtils.buildSnapshotHeroGroups(arg_1_1.trainHeroGroupSnapshot)
end

function var_0_0.updateInfomation(arg_2_0, arg_2_1)
	arg_2_0.infoBonusDict = {}
	arg_2_0.informationDict = {}

	for iter_2_0 = 1, #arg_2_1.bonusIds do
		arg_2_0.infoBonusDict[arg_2_1.bonusIds[iter_2_0]] = 1
	end

	arg_2_0:updateInfos(arg_2_1.infos)
end

function var_0_0.updateInfos(arg_3_0, arg_3_1)
	local var_3_0 = false

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_1 = arg_3_1[iter_3_0]
		local var_3_2 = arg_3_0.informationDict[var_3_1.id]

		if not var_3_2 then
			var_3_2 = Season166InfoMO.New()

			var_3_2:init(arg_3_0.activityId)

			arg_3_0.informationDict[var_3_1.id] = var_3_2
			var_3_0 = true
		end

		var_3_2:setData(var_3_1)
	end

	return var_3_0
end

function var_0_0.updateAnalyInfoStage(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.informationDict[arg_4_1]

	if var_4_0 then
		var_4_0.stage = arg_4_2
	end
end

function var_0_0.updateInfoBonus(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.informationDict[arg_5_1]

	if var_5_0 then
		var_5_0.bonusStage = arg_5_2
	end
end

function var_0_0.onReceiveInformationBonus(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_1 do
		arg_6_0.infoBonusDict[arg_6_1[iter_6_0]] = 1
	end
end

function var_0_0.updateSpotsInfo(arg_7_0, arg_7_1)
	arg_7_0.baseSpotInfoMap = {}

	for iter_7_0 = 1, #arg_7_1 do
		local var_7_0 = arg_7_1[iter_7_0]
		local var_7_1 = Season166BaseSpotMO.New()

		var_7_1:setData(var_7_0)

		arg_7_0.baseSpotInfoMap[var_7_0.id] = var_7_1
	end
end

function var_0_0.updateMaxScore(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.baseSpotInfoMap[arg_8_1]

	if var_8_0 then
		var_8_0.maxScore = arg_8_2
	end
end

function var_0_0.updateTrainsInfo(arg_9_0, arg_9_1)
	arg_9_0.trainInfoMap = {}

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_0 = arg_9_1[iter_9_0]
		local var_9_1 = Season166TrainMO.New()

		var_9_1:setData(var_9_0)

		arg_9_0.trainInfoMap[var_9_0.id] = var_9_1
	end
end

function var_0_0.updateTeachsInfo(arg_10_0, arg_10_1)
	arg_10_0.teachInfoMap = {}

	for iter_10_0 = 1, #arg_10_1 do
		local var_10_0 = arg_10_1[iter_10_0]
		local var_10_1 = Season166TeachMO.New()

		var_10_1:setData(var_10_0)

		arg_10_0.teachInfoMap[var_10_0.id] = var_10_1
	end
end

function var_0_0.getHeroGroupSnapShot(arg_11_0, arg_11_1)
	if arg_11_1 == DungeonEnum.EpisodeType.Season166Base then
		return arg_11_0.spotHeroGroupSnapshot
	elseif arg_11_1 == DungeonEnum.EpisodeType.Season166Train then
		return arg_11_0.trainHeroGroupSnapshot
	end
end

function var_0_0.getInformationMO(arg_12_0, arg_12_1)
	return arg_12_0.informationDict[arg_12_1]
end

function var_0_0.isBonusGet(arg_13_0, arg_13_1)
	return arg_13_0.infoBonusDict[arg_13_1] == 1
end

function var_0_0.getBonusNum(arg_14_0)
	local var_14_0 = Season166Config.instance:getSeasonInfoBonuss(arg_14_0.activityId) or {}
	local var_14_1 = #var_14_0
	local var_14_2 = 0
	local var_14_3 = arg_14_0:getInfoAnalyCount()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if var_14_3 >= iter_14_1.analyCount then
			var_14_2 = var_14_2 + 1
		end
	end

	return var_14_2, var_14_1
end

function var_0_0.getInfoAnalyCount(arg_15_0)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.informationDict) do
		if iter_15_1:hasAnaly() then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function var_0_0.initTalentInfo(arg_16_0, arg_16_1)
	arg_16_0.talentMap = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_0 = arg_16_0.talentMap[iter_16_1.id] or Season166TalentMO.New()

		var_16_0:setData(iter_16_1)

		arg_16_0.talentMap[iter_16_1.id] = var_16_0
	end
end

function var_0_0.updateTalentInfo(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.talentMap[arg_17_1.id]

	if not var_17_0 then
		logError("talent not init" .. arg_17_1.id)
	end

	var_17_0:setData(arg_17_1)
end

function var_0_0.setTalentSkillIds(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0:getTalentMO(arg_18_1)
	local var_18_1 = #var_18_0.skillIds

	var_18_0:updateSkillIds(arg_18_2)

	return var_18_1 < #arg_18_2
end

function var_0_0.getTalentMO(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.talentMap[arg_19_1]

	if not var_19_0 then
		logError("dont exist TalentMO" .. arg_19_1)
	end

	return var_19_0
end

function var_0_0.isTrainPass(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.trainInfoMap[arg_20_1]

	if var_20_0 then
		return var_20_0.passCount > 0
	end

	return false
end

function var_0_0.setSpotBaseEnter(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.baseSpotInfoMap[arg_21_1]

	if var_21_0 then
		var_21_0.isEnter = arg_21_2
	end
end

return var_0_0
