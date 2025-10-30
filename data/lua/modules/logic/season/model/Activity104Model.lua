module("modules.logic.season.model.Activity104Model", package.seeall)

local var_0_0 = class("Activity104Model", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._activity104MoDic = {}
	arg_2_0._getCardList = nil
end

function var_0_0.setActivity104Info(arg_3_0, arg_3_1)
	if not arg_3_0._activity104MoDic[arg_3_1.activityId] then
		arg_3_0._activity104MoDic[arg_3_1.activityId] = Activity104Mo.New()
	end

	arg_3_0._activity104MoDic[arg_3_1.activityId]:init(arg_3_1)
end

function var_0_0.tryGetActivityInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:getActivityInfo(arg_4_1, true)

	if not var_4_0 then
		Activity104Rpc.instance:sendGet104InfosRequest(arg_4_1, arg_4_2, arg_4_3)
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Season
		})
	end

	return var_4_0
end

function var_0_0.getActivityInfo(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._activity104MoDic[arg_5_1]

	if not var_5_0 and not arg_5_2 then
		-- block empty
	end

	return var_5_0
end

function var_0_0.updateItemChange(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.activityId or arg_6_0:getCurSeasonId()
	local var_6_1 = arg_6_0:getActivityInfo(var_6_0)

	if var_6_1 then
		var_6_1:updateItems(arg_6_1)
	end
end

function var_0_0.updateActivity104Info(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getActivityInfo(arg_7_1.activityId)

	if not var_7_0 then
		return
	end

	var_7_0:reset(arg_7_1)
	var_7_0:setBattleFinishLayer(arg_7_1.layer)

	arg_7_0.settleType = arg_7_1.settleType
	arg_7_0.curBattleRetail = arg_7_1.retail
end

function var_0_0.enterAct104Battle(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_1)

	arg_8_0:setBattleFinishLayer(arg_8_2)
	DungeonFightController.instance:enterSeasonFight(var_8_0.chapterId, arg_8_1)
end

function var_0_0.onStartAct104BattleReply(arg_9_0, arg_9_1)
	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_1.episodeId)

	arg_9_0:setBattleFinishLayer(arg_9_1.layer)
	DungeonFightController.instance:enterSeasonFight(var_9_0.chapterId, arg_9_1.episodeId)
end

function var_0_0.setBattleFinishLayer(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getCurSeasonId()
	local var_10_1 = arg_10_0:getActivityInfo(var_10_0)

	if not var_10_1 then
		return
	end

	var_10_1:setBattleFinishLayer(arg_10_1)
end

function var_0_0.getBattleFinishLayer(arg_11_0)
	local var_11_0 = arg_11_0:getCurSeasonId()
	local var_11_1 = arg_11_0:getActivityInfo(var_11_0)

	if not var_11_1 then
		return
	end

	return var_11_1:getBattleFinishLayer()
end

function var_0_0.getAllEpisodeMO(arg_12_0)
	local var_12_0 = arg_12_0:getCurSeasonId()
	local var_12_1 = arg_12_0:getActivityInfo(var_12_0)

	if not var_12_1 then
		return
	end

	return var_12_1.episodes
end

function var_0_0.getLastRetails(arg_13_0)
	local var_13_0 = arg_13_0:getCurSeasonId()
	local var_13_1 = arg_13_0:getActivityInfo(var_13_0)

	if not var_13_1 then
		return
	end

	return var_13_1:getLastRetails()
end

function var_0_0.getAllItemMo(arg_14_0)
	local var_14_0 = arg_14_0:getCurSeasonId()
	local var_14_1 = arg_14_0:getActivityInfo(var_14_0)

	if not var_14_1 then
		return
	end

	return var_14_1.activity104Items
end

function var_0_0.getItemEquipUid(arg_15_0, arg_15_1)
	if arg_15_1 == 0 then
		return 0
	end

	local var_15_0 = arg_15_0:getCurSeasonId()
	local var_15_1 = arg_15_0:getActivityInfo(var_15_0)

	if not var_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in pairs(var_15_1.activity104Items) do
		if iter_15_1.itemId == arg_15_1 then
			return iter_15_1.uid
		end
	end

	return 0
end

function var_0_0.getItemIdByUid(arg_16_0, arg_16_1)
	if arg_16_1 == "0" then
		return 0
	end

	local var_16_0 = arg_16_0:getCurSeasonId()
	local var_16_1 = arg_16_0:getActivityInfo(var_16_0)

	if not var_16_1 then
		return
	end

	for iter_16_0, iter_16_1 in pairs(var_16_1.activity104Items) do
		if iter_16_1.uid == arg_16_1 then
			return iter_16_1.itemId
		end
	end

	return 0
end

function var_0_0.getAllSpecialMo(arg_17_0)
	local var_17_0 = arg_17_0:getCurSeasonId()
	local var_17_1 = arg_17_0:getActivityInfo(var_17_0)

	if not var_17_1 then
		return
	end

	return var_17_1.specials
end

function var_0_0.getSeasonAllHeroGroup(arg_18_0)
	local var_18_0 = arg_18_0:getCurSeasonId()
	local var_18_1 = arg_18_0:getActivityInfo(var_18_0)

	if not var_18_1 then
		return
	end

	return var_18_1.heroGroupSnapshot
end

function var_0_0.isSeasonGMChapter(arg_19_0, arg_19_1)
	return (arg_19_1 or DungeonModel.instance.curSendChapterId) == 9991
end

function var_0_0.isSeasonChapter(arg_20_0)
	local var_20_0 = arg_20_0:getCurSeasonId()
	local var_20_1 = DungeonModel.instance.curSendEpisodeId

	if not var_20_1 or var_20_1 == 0 then
		return false
	end

	local var_20_2 = DungeonConfig.instance:getEpisodeCO(var_20_1)

	if var_20_2 and arg_20_0:isSeasonEpisodeType(var_20_2.type) then
		return true
	end

	return false
end

function var_0_0.getEpisodeState(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getAllEpisodeMO()

	return var_21_0[arg_21_1] and var_21_0[arg_21_1].state or 0
end

function var_0_0.getCurSeasonId(arg_22_0)
	return Activity104Enum.CurSeasonId
end

function var_0_0.isSeasonDataReady(arg_23_0)
	local var_23_0 = arg_23_0:getCurSeasonId()

	return arg_23_0:getActivityInfo(var_23_0, true) ~= nil
end

function var_0_0.getSeasonCurSnapshotSubId(arg_24_0)
	local var_24_0 = arg_24_0:getCurSeasonId()
	local var_24_1 = arg_24_0:getActivityInfo(var_24_0)

	if not var_24_1 then
		return
	end

	return var_24_1.heroGroupSnapshotSubId
end

function var_0_0.setSeasonCurSnapshotSubId(arg_25_0, arg_25_1, arg_25_2)
	arg_25_1 = arg_25_1 or arg_25_0:getCurSeasonId()
	arg_25_2 = arg_25_2 or 1

	local var_25_0 = arg_25_0:getActivityInfo(arg_25_1)

	if not var_25_0 then
		return
	end

	var_25_0.heroGroupSnapshotSubId = arg_25_2

	local var_25_1 = arg_25_0:getSnapshotHeroGroupBySubId(arg_25_2)

	HeroSingleGroupModel.instance:setSingleGroup(var_25_1)

	local var_25_2 = HeroSingleGroupModel.instance:getList()

	for iter_25_0 = 1, #var_25_2 do
		var_25_2[iter_25_0]:setAid(var_25_1.aidDict and var_25_1.aidDict[iter_25_0])

		if var_25_1.trialDict and var_25_1.trialDict[iter_25_0] then
			var_25_2[iter_25_0]:setTrial(unpack(var_25_1.trialDict[iter_25_0]))
		else
			var_25_2[iter_25_0]:setTrial()
		end
	end
end

function var_0_0.getSnapshotHeroGroupBySubId(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCurSeasonId()

	arg_26_1 = arg_26_1 or arg_26_0:getSeasonCurSnapshotSubId(var_26_0)

	local var_26_1 = arg_26_0:getActivityInfo(var_26_0)

	if not var_26_1 then
		return
	end

	return var_26_1:getSnapshotHeroGroupBySubId(arg_26_1)
end

function var_0_0.setSnapshotByFightGroup(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	arg_27_1 = arg_27_1 or arg_27_0:getCurSeasonId()

	local var_27_0 = arg_27_0:getActivityInfo(arg_27_1)

	if not var_27_0 then
		return
	end

	if not var_27_0.heroGroupSnapshot[arg_27_2] then
		var_27_0.heroGroupSnapshot[arg_27_2] = {}
	end

	local var_27_1 = var_27_0.heroGroupSnapshot[arg_27_2]

	var_27_1.heroList = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_3.fightGroup.heroList) do
		table.insert(var_27_1.heroList, iter_27_1)
	end

	for iter_27_2, iter_27_3 in ipairs(arg_27_3.fightGroup.subHeroList) do
		table.insert(var_27_1.heroList, iter_27_3)
	end

	var_27_1.clothId = arg_27_3.fightGroup.clothId
	var_27_1.equips = {}

	for iter_27_4, iter_27_5 in ipairs(arg_27_3.fightGroup.equips) do
		if var_27_1.equips[iter_27_4 - 1] == nil then
			var_27_1.equips[iter_27_4 - 1] = HeroGroupEquipMO.New()
		end

		var_27_1.equips[iter_27_4 - 1]:init({
			index = iter_27_4 - 1,
			equipUid = iter_27_5.equipUid
		})
	end

	var_27_1.activity104Equips = {}

	for iter_27_6, iter_27_7 in ipairs(arg_27_3.fightGroup.activity104Equips) do
		if var_27_1.activity104Equips[iter_27_6 - 1] == nil then
			var_27_1.activity104Equips[iter_27_6 - 1] = HeroGroupActivity104EquipMo.New()
		end

		var_27_1.activity104Equips[iter_27_6 - 1]:init({
			index = iter_27_6 - 1,
			equipUid = iter_27_7.equipUid
		})
	end

	var_27_1:clearAidHero()
end

function var_0_0.getAllHeroGroupSnapshot(arg_28_0, arg_28_1)
	arg_28_1 = arg_28_1 or arg_28_0:getCurSeasonId()

	local var_28_0 = arg_28_0:getActivityInfo(arg_28_1)

	if not var_28_0 then
		return
	end

	return var_28_0.heroGroupSnapshot
end

function var_0_0.replaceHeroList(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_1 = arg_29_1 or arg_29_0:getCurSeasonId()
	arg_29_2 = arg_29_2 or arg_29_0:getSeasonCurSnapshotSubId(arg_29_1)

	local var_29_0 = arg_29_0:getActivityInfo(arg_29_1)

	if not var_29_0 then
		return
	end

	var_29_0.heroGroupSnapshot[arg_29_2].heroList = arg_29_3
end

function var_0_0.resetSnapshotHeroGroupEquip(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	arg_30_1 = arg_30_1 or arg_30_0:getCurSeasonId()
	arg_30_2 = arg_30_2 or arg_30_0:getSeasonCurSnapshotSubId(arg_30_1)

	local var_30_0 = arg_30_0:getActivityInfo(arg_30_1)

	if not var_30_0 then
		return
	end

	for iter_30_0, iter_30_1 in pairs(var_30_0.heroGroupSnapshot[arg_30_2].equips) do
		if iter_30_1.index == arg_30_3 then
			iter_30_1.equipUid = arg_30_4
		end
	end
end

function var_0_0.resetSnapshotHeroGroupHero(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_1 = arg_31_1 or arg_31_0:getCurSeasonId()
	arg_31_2 = arg_31_2 or arg_31_0:getSeasonCurSnapshotSubId(arg_31_1)

	local var_31_0 = arg_31_0:getActivityInfo(arg_31_1)

	if not var_31_0 then
		return
	end

	var_31_0.heroGroupSnapshot[arg_31_2].heroList[arg_31_3] = arg_31_4
end

function var_0_0.getAct104CurLayer(arg_32_0, arg_32_1)
	arg_32_1 = arg_32_1 or arg_32_0:getCurSeasonId()

	local var_32_0 = arg_32_0:getActivityInfo(arg_32_1)

	if not var_32_0 or not var_32_0.episodes then
		return 0, 1
	end

	local var_32_1 = 1
	local var_32_2 = 1

	for iter_32_0, iter_32_1 in pairs(var_32_0.episodes) do
		if var_32_1 <= iter_32_1.layer and iter_32_1.state == 1 then
			var_32_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_32_1, iter_32_1.layer + 1) and iter_32_1.layer + 1 or iter_32_1.layer
			var_32_2 = iter_32_1.layer + 1
		end
	end

	return var_32_1, var_32_2
end

function var_0_0.isLayerPassed(arg_33_0, arg_33_1, arg_33_2)
	arg_33_1 = arg_33_1 or arg_33_0:getCurSeasonId()

	local var_33_0 = arg_33_0:getActivityInfo(arg_33_1)

	if not var_33_0 or not var_33_0.episodes then
		return false
	end

	return arg_33_0:getEpisodeState(arg_33_2) == 1
end

function var_0_0.getAct104CurStage(arg_34_0, arg_34_1, arg_34_2)
	arg_34_1 = arg_34_1 or arg_34_0:getCurSeasonId()
	arg_34_2 = arg_34_2 or arg_34_0:getAct104CurLayer(arg_34_1)

	local var_34_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_34_1, arg_34_2)

	return var_34_0 and var_34_0.stage or 0
end

function var_0_0.isStagePassed(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getCurSeasonId()
	local var_35_1 = arg_35_0:getAct104CurLayer(var_35_0)
	local var_35_2 = SeasonConfig.instance:getSeasonEpisodeCo(var_35_0, var_35_1)
	local var_35_3 = var_35_2 and var_35_2.stage or 0
	local var_35_4 = arg_35_0:getEpisodeState(var_35_1) == 1

	if arg_35_1 < var_35_3 then
		return true
	end

	if var_35_3 == arg_35_1 and var_35_4 then
		return true
	end

	return false
end

function var_0_0.getMaxLayer(arg_36_0, arg_36_1)
	arg_36_1 = arg_36_1 or arg_36_0:getCurSeasonId()

	local var_36_0 = SeasonConfig.instance:getSeasonEpisodeCos(arg_36_1)
	local var_36_1 = 0

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		if var_36_1 < iter_36_1.layer then
			var_36_1 = iter_36_1.layer
		end
	end

	return var_36_1
end

function var_0_0.getMaxStage(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or arg_37_0:getCurSeasonId()

	local var_37_0 = arg_37_0:getMaxLayer(arg_37_1)
	local var_37_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_37_1, var_37_0)

	return var_37_1 and var_37_1.stage or 0
end

function var_0_0.isSpecialOpen(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or arg_38_0:getCurSeasonId()

	if not arg_38_0:isEnterSpecial(arg_38_1) then
		return false
	end

	local var_38_0 = SeasonConfig.instance:getSeasonConstCo(arg_38_1, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local var_38_1 = var_38_0 and var_38_0.value1

	return arg_38_0:isLayerPassed(arg_38_1, var_38_1)
end

function var_0_0.isEnterSpecial(arg_39_0, arg_39_1)
	arg_39_1 = arg_39_1 or arg_39_0:getCurSeasonId()

	local var_39_0 = ActivityModel.instance:getActStartTime(arg_39_1) / 1000
	local var_39_1 = SeasonConfig.instance:getSeasonConstCo(arg_39_1, Activity104Enum.ConstEnum.SpecialOpenDayCount)

	if (var_39_1 and var_39_1.value1 - 1) * 86400 + var_39_0 <= ServerTime.now() then
		return true
	end

	return false
end

function var_0_0.isSpecialLayerOpen(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1 = arg_40_1 or arg_40_0:getCurSeasonId()

	local var_40_0 = SeasonConfig.instance:getSeasonSpecialCo(arg_40_1, arg_40_2)
	local var_40_1 = ActivityModel.instance:getActStartTime(arg_40_1) / 1000
	local var_40_2 = (var_40_0.openDay - 1) * 86400 + var_40_1 - ServerTime.now()

	if var_40_2 > 0 then
		return false, var_40_2
	end

	return true
end

function var_0_0.isSeasonSlotUnlock(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	arg_41_1 = arg_41_1 or arg_41_0:getCurSeasonId()
	arg_41_2 = arg_41_2 or arg_41_0:getSeasonCurSnapshotSubId(arg_41_1)

	local var_41_0 = arg_41_0:getActivityInfo(arg_41_1)

	if not var_41_0 then
		return
	end

	local var_41_1 = var_41_0.unlockEquipIndexs

	for iter_41_0, iter_41_1 in pairs(var_41_1) do
		if iter_41_1 ~= 9 and iter_41_1 >= 4 * arg_41_3 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonPosUnlock(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	arg_42_1 = arg_42_1 or arg_42_0:getCurSeasonId()
	arg_42_2 = arg_42_2 or arg_42_0:getSeasonCurSnapshotSubId(arg_42_1)

	local var_42_0 = arg_42_0:getActivityInfo(arg_42_1)

	if not var_42_0 then
		return
	end

	local var_42_1 = var_42_0.unlockEquipIndexs
	local var_42_2 = arg_42_4 == 4 and 9 or arg_42_4 + 1 + 4 * (arg_42_3 - 1)

	for iter_42_0, iter_42_1 in pairs(var_42_1) do
		if iter_42_1 == var_42_2 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonLayerSlotUnlock(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	arg_43_1 = arg_43_1 or arg_43_0:getCurSeasonId()
	arg_43_2 = arg_43_2 or arg_43_0:getSeasonCurSnapshotSubId(arg_43_1)

	local var_43_0 = {}

	if arg_43_3 > 1 then
		for iter_43_0 = 2, arg_43_3 do
			local var_43_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_43_0:getCurSeasonId(), iter_43_0 - 1)
			local var_43_2 = string.splitToNumber(var_43_1.unlockEquipIndex, "#")

			for iter_43_1, iter_43_2 in pairs(var_43_2) do
				table.insert(var_43_0, iter_43_2)
			end
		end
	end

	for iter_43_3, iter_43_4 in pairs(var_43_0) do
		if iter_43_4 ~= 9 and iter_43_4 >= 4 * arg_43_4 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonLayerPosUnlock(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	arg_44_1 = arg_44_1 or arg_44_0:getCurSeasonId()
	arg_44_2 = arg_44_2 or arg_44_0:getSeasonCurSnapshotSubId(arg_44_1)

	local var_44_0 = {}

	if arg_44_3 > 1 then
		for iter_44_0 = 2, arg_44_3 do
			local var_44_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_44_0:getCurSeasonId(), iter_44_0 - 1)
			local var_44_2 = string.splitToNumber(var_44_1.unlockEquipIndex, "#")

			for iter_44_1, iter_44_2 in pairs(var_44_2) do
				table.insert(var_44_0, iter_44_2)
			end
		end
	end

	local var_44_3 = arg_44_5 == 4 and 9 or arg_44_5 + 1 + 4 * (arg_44_4 - 1)

	for iter_44_3, iter_44_4 in pairs(var_44_0) do
		if iter_44_4 == var_44_3 then
			return true
		end
	end

	return false
end

function var_0_0.getSeasonHeroGroupEquipId(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	arg_45_1 = arg_45_1 or arg_45_0:getCurSeasonId()

	local var_45_0 = arg_45_0:getActivityInfo(arg_45_1)

	if not var_45_0 then
		return 0
	end

	local var_45_1 = var_45_0:getSnapshotHeroGroupBySubId(arg_45_2)

	if var_45_1 and var_45_1.activity104Equips[arg_45_4] then
		local var_45_2 = var_45_1.activity104Equips[arg_45_4].equipUid[arg_45_3]

		return arg_45_0:getItemIdByUid(var_45_2), var_45_2
	end

	return 0
end

function var_0_0.getAct104Retails(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or arg_46_0:getCurSeasonId()

	local var_46_0 = arg_46_0:getActivityInfo(arg_46_1)

	if not var_46_0 then
		return
	end

	return var_46_0.retails
end

function var_0_0.replaceAct104Retails(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1.actId or arg_47_0:getCurSeasonId()
	local var_47_1 = arg_47_0:getActivityInfo(var_47_0)

	if not var_47_1 then
		return
	end

	var_47_1:replaceRetails(arg_47_1.retails)

	var_47_1.retailStage = arg_47_1.retailStage
end

function var_0_0.getRetailStage(arg_48_0, arg_48_1)
	arg_48_1 = arg_48_1 or arg_48_0:getCurSeasonId()

	local var_48_0 = arg_48_0:getActivityInfo(arg_48_1)

	if not var_48_0 then
		return
	end

	if var_48_0.retailStage == 0 then
		var_48_0.retailStage = arg_48_0:getAct104CurStage(arg_48_1)
	end

	return var_48_0.retailStage
end

function var_0_0.getRetailEpisodeTag(arg_49_0, arg_49_1)
	local var_49_0 = ""
	local var_49_1 = arg_49_0:getCurSeasonId()
	local var_49_2 = SeasonConfig.instance:getSeasonRetailCos(var_49_1)

	for iter_49_0, iter_49_1 in pairs(var_49_2) do
		local var_49_3 = string.splitToNumber(iter_49_1.retailEpisodeIdPool, "#")
		local var_49_4 = string.split(iter_49_1.enemyTag, "#")

		for iter_49_2 = 1, #var_49_3 do
			if var_49_3[iter_49_2] == arg_49_1 then
				var_49_0 = var_49_4[iter_49_2] or ""

				return var_49_0
			end
		end
	end

	return var_49_0
end

function var_0_0.getEpisodeRetail(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:getCurSeasonId()
	local var_50_1 = arg_50_0:getActivityInfo(var_50_0)

	if var_50_1 then
		for iter_50_0, iter_50_1 in pairs(var_50_1.retails) do
			if iter_50_1.id == arg_50_1 then
				return iter_50_1
			end
		end
	end

	return {}
end

function var_0_0.isLastDay(arg_51_0, arg_51_1)
	arg_51_1 = arg_51_1 or arg_51_0:getCurSeasonId()

	return ActivityModel.instance:getRemainTime(arg_51_1) < 86400
end

function var_0_0.isAllSpecialLayerFinished(arg_52_0)
	local var_52_0 = arg_52_0:getCurSeasonId()
	local var_52_1 = arg_52_0:getActivityInfo(var_52_0)

	if not var_52_1 or not var_52_1.specials then
		return true
	end

	local var_52_2 = arg_52_0:getMaxSpecialLayer()

	for iter_52_0, iter_52_1 in pairs(var_52_1.specials) do
		if iter_52_1.state == 0 then
			return false
		end
	end

	return true
end

function var_0_0.getAct104SpecialInitLayer(arg_53_0)
	local var_53_0 = arg_53_0:getCurSeasonId()
	local var_53_1 = arg_53_0:getActivityInfo(var_53_0)

	if not var_53_1 or not var_53_1.specials then
		return 0
	end

	local var_53_2 = 1
	local var_53_3

	for iter_53_0, iter_53_1 in pairs(var_53_1.specials) do
		if iter_53_1.state == 0 then
			var_53_3 = var_53_3 and math.min(iter_53_1.layer, var_53_3) or iter_53_1.layer
		end

		if arg_53_0:isSpecialLayerOpen(var_53_0, iter_53_1.layer) then
			var_53_2 = math.max(iter_53_1.layer, var_53_2)
		end
	end

	if var_53_3 == nil then
		var_53_3 = var_53_2
	end

	return var_53_3
end

function var_0_0.getMaxSpecialLayer(arg_54_0)
	local var_54_0 = SeasonConfig.instance:getSeasonSpecialCos(arg_54_0:getCurSeasonId())
	local var_54_1 = 0

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		if var_54_1 < iter_54_1.layer then
			var_54_1 = iter_54_1.layer
		end
	end

	return var_54_1
end

function var_0_0.isSpecialLayerPassed(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getCurSeasonId()
	local var_55_1 = arg_55_0:getActivityInfo(var_55_0)

	if not var_55_1 or not var_55_1.specials then
		return false
	end

	for iter_55_0, iter_55_1 in pairs(var_55_1.specials) do
		if iter_55_1.layer == arg_55_1 then
			return iter_55_1.state == 1
		end
	end

	return false
end

function var_0_0.isNewStage(arg_56_0)
	local var_56_0 = arg_56_0:getAct104CurStage()
	local var_56_1 = arg_56_0:getAct104CurLayer()
	local var_56_2 = SeasonConfig.instance:getSeasonEpisodeCo(arg_56_0:getCurSeasonId(), var_56_1 - 1)

	if not var_56_2 then
		return false
	end

	return var_56_0 ~= var_56_2.stage
end

function var_0_0.isNextLayerNewStage(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:getCurSeasonId()
	local var_57_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_57_0, arg_57_1)
	local var_57_2 = var_57_1 and var_57_1.stage or 0
	local var_57_3 = SeasonConfig.instance:getSeasonEpisodeCo(arg_57_0:getCurSeasonId(), arg_57_1 + 1)

	if not var_57_3 then
		return false
	end

	return var_57_2 ~= var_57_3.stage
end

function var_0_0.isEpisodeAdvance(arg_58_0, arg_58_1)
	if DungeonConfig.instance:getEpisodeCO(arg_58_1).type ~= DungeonEnum.EpisodeType.SeasonRetail then
		return false
	end

	local var_58_0 = arg_58_0:getAct104Retails()

	for iter_58_0, iter_58_1 in pairs(var_58_0) do
		if iter_58_1.id == arg_58_1 and iter_58_1.advancedId ~= 0 and iter_58_1.advancedRare ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.onReceiveGetUnlockActivity104EquipIdsReply(arg_59_0, arg_59_1)
	arg_59_0:getActivityInfo(arg_59_1.activityId):setUnlockActivity104EquipIds(arg_59_1.unlockActivity104EquipIds)
end

function var_0_0.isNew104Equip(arg_60_0, arg_60_1)
	local var_60_0 = arg_60_0:getActivityInfo(arg_60_0:getCurSeasonId())

	if not var_60_0 then
		return
	end

	return not var_60_0.unlockActivity104EquipIds[arg_60_1]
end

function var_0_0.markActivityStory(arg_61_0, arg_61_1)
	arg_61_1 = arg_61_1 or arg_61_0:getCurSeasonId()

	local var_61_0 = arg_61_0:getActivityInfo(arg_61_1)

	if var_61_0 then
		var_61_0:markStory(true)
	end
end

function var_0_0.markEpisodeAfterStory(arg_62_0, arg_62_1, arg_62_2)
	arg_62_1 = arg_62_1 or arg_62_0:getCurSeasonId()

	local var_62_0 = arg_62_0:getActivityInfo(arg_62_1)

	if var_62_0 then
		var_62_0:markEpisodeAfterStory(arg_62_2)
	end
end

function var_0_0.isReadActivity104Story(arg_63_0, arg_63_1)
	arg_63_1 = arg_63_1 or arg_63_0:getCurSeasonId()

	local var_63_0 = arg_63_0:getActivityInfo(arg_63_1)

	return var_63_0 and var_63_0.readActivity104Story
end

function var_0_0.isEpisodeAfterStory(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = arg_64_0:getAllEpisodeMO(arg_64_1)

	if not var_64_0 then
		return
	end

	return var_64_0[arg_64_2] and var_64_0[arg_64_2].readAfterStory
end

function var_0_0.canPlayStageLevelup(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5)
	if arg_65_1 ~= 1 then
		return
	end

	if arg_65_2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if arg_65_3 then
		return
	end

	arg_65_4 = arg_65_4 or arg_65_0:getCurSeasonId()

	if arg_65_0:isEpisodeAfterStory(arg_65_4, arg_65_5) then
		return
	end

	if arg_65_0:getMaxLayer() == arg_65_5 then
		return SeasonConfig.instance:getSeasonEpisodeCo(arg_65_4, arg_65_5).stage + 1
	end

	if not arg_65_0:isNextLayerNewStage(arg_65_5) then
		return
	end

	local var_65_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_65_4, arg_65_5 + 1)

	return var_65_0 and var_65_0.stage
end

function var_0_0.canMarkFightAfterStory(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4, arg_66_5)
	if arg_66_1 ~= 1 then
		return
	end

	if arg_66_2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if arg_66_3 or not arg_66_5 then
		return
	end

	arg_66_4 = arg_66_4 or arg_66_0:getCurSeasonId()

	if arg_66_0:isEpisodeAfterStory(arg_66_4, arg_66_5) then
		return
	end

	return true
end

function var_0_0.getOptionalAct104Equips(arg_67_0, arg_67_1)
	arg_67_1 = arg_67_1 or arg_67_0:getCurSeasonId()

	local var_67_0 = {}
	local var_67_1 = arg_67_0:getActivityInfo(arg_67_1)

	if var_67_1 then
		for iter_67_0, iter_67_1 in pairs(var_67_1.activity104Items) do
			local var_67_2 = SeasonConfig.instance:getSeasonEquipCo(iter_67_1.itemId)

			if var_67_2 and var_67_2.isOptional == 1 then
				table.insert(var_67_0, iter_67_1)
			end
		end
	end

	return var_67_0
end

function var_0_0.addCardGetData(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0:getCurSeasonId()
	local var_68_1 = SeasonViewHelper.getViewName(var_68_0, Activity104Enum.ViewName.CelebrityCardGetlView)

	for iter_68_0 = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[iter_68_0][2] == var_68_1 then
			local var_68_2 = PopupController.instance._popupList._dataList[iter_68_0][3].data

			tabletool.addValues(var_68_2, arg_68_1)

			PopupController.instance._popupList._dataList[iter_68_0][3] = {
				is_item_id = true,
				data = var_68_2
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, var_68_1, {
		is_item_id = true,
		data = arg_68_1
	})
end

function var_0_0.setMakertLayerMark(arg_69_0, arg_69_1, arg_69_2)
	arg_69_1 = arg_69_1 or arg_69_0:getCurSeasonId()

	local var_69_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local var_69_1 = string.split(var_69_0, "|")
	local var_69_2 = {}

	for iter_69_0, iter_69_1 in ipairs(var_69_1) do
		local var_69_3 = string.splitToNumber(iter_69_1, "#")

		if var_69_3 and var_69_3[1] then
			var_69_2[var_69_3[1]] = var_69_3[2]
		end
	end

	if not var_69_2[arg_69_1] or arg_69_2 > var_69_2[arg_69_1] then
		var_69_2[arg_69_1] = arg_69_2
	end

	local var_69_4 = {}

	for iter_69_2, iter_69_3 in pairs(var_69_2) do
		table.insert(var_69_4, string.format("%s#%s", iter_69_2, iter_69_3))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), table.concat(var_69_4, "|"))
end

function var_0_0.isCanPlayMakertLayerAnim(arg_70_0, arg_70_1, arg_70_2)
	arg_70_1 = arg_70_1 or arg_70_0:getCurSeasonId()

	if not arg_70_1 or not arg_70_2 then
		return
	end

	local var_70_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local var_70_1 = string.split(var_70_0, "|")

	for iter_70_0, iter_70_1 in ipairs(var_70_1) do
		local var_70_2 = string.splitToNumber(iter_70_1, "#")

		if var_70_2 and var_70_2[1] == arg_70_1 then
			return arg_70_2 > var_70_2[2]
		end
	end

	return true
end

function var_0_0.setGroupCardUnlockTweenPos(arg_71_0, arg_71_1, arg_71_2)
	arg_71_1 = arg_71_1 or arg_71_0:getCurSeasonId()

	local var_71_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local var_71_1 = string.split(var_71_0, "|")
	local var_71_2 = {}

	for iter_71_0, iter_71_1 in ipairs(var_71_1) do
		local var_71_3 = string.splitToNumber(iter_71_1, "#")

		if var_71_3 and var_71_3[1] then
			var_71_2[var_71_3[1]] = {}

			if #var_71_3 > 1 then
				for iter_71_2 = 2, #var_71_3 do
					var_71_2[var_71_3[1]][var_71_3[iter_71_2]] = 1
				end
			end
		end
	end

	if not var_71_2[arg_71_1] then
		var_71_2[arg_71_1] = {}
	end

	var_71_2[arg_71_1][arg_71_2] = 1

	local var_71_4 = {}

	for iter_71_3, iter_71_4 in pairs(var_71_2) do
		local var_71_5 = {
			iter_71_3
		}

		for iter_71_5, iter_71_6 in pairs(iter_71_4) do
			table.insert(var_71_5, iter_71_5)
		end

		table.insert(var_71_4, table.concat(var_71_5, "#"))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), table.concat(var_71_4, "|"))
end

function var_0_0.isContainGroupCardUnlockTweenPos(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_1 = arg_72_1 or arg_72_0:getCurSeasonId()

	local var_72_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_72_1, arg_72_2)

	if not var_72_0 then
		return true
	end

	local var_72_1 = string.splitToNumber(var_72_0.unlockEquipIndex, "#")

	if not tabletool.indexOf(var_72_1, arg_72_3) then
		return true
	end

	local var_72_2 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local var_72_3 = string.split(var_72_2, "|")

	for iter_72_0, iter_72_1 in ipairs(var_72_3) do
		local var_72_4 = string.splitToNumber(iter_72_1, "#")

		if var_72_4 and var_72_4[1] == arg_72_1 then
			if #var_72_4 > 1 then
				for iter_72_2 = 2, #var_72_4 do
					if var_72_4[iter_72_2] == arg_72_3 then
						return true
					end
				end
			end

			break
		end
	end

	return false
end

function var_0_0.caleStageEquipRareWeight(arg_73_0, arg_73_1)
	arg_73_1 = arg_73_1 or arg_73_0:getAct104CurStage()

	local var_73_0 = arg_73_0:getCurSeasonId()
	local var_73_1 = SeasonConfig.instance:getSeasonRetailCo(var_73_0, arg_73_1)
	local var_73_2 = string.split(var_73_1.equipRareWeight, "|")
	local var_73_3 = 0
	local var_73_4 = 0
	local var_73_5 = 0
	local var_73_6 = {}

	for iter_73_0, iter_73_1 in ipairs(var_73_2) do
		local var_73_7 = string.splitToNumber(iter_73_1, "#")

		if var_73_7 then
			var_73_3 = var_73_7[2] + var_73_3

			if var_73_5 < var_73_7[1] then
				var_73_5 = var_73_7[1]
				var_73_4 = var_73_7[2]
			end
		end
	end

	if var_73_3 == 0 then
		var_73_3 = 1
	end

	local var_73_8 = 0
	local var_73_9 = SeasonConfig.instance:getSeasonOptionalEquipCos()

	for iter_73_2, iter_73_3 in pairs(var_73_9) do
		if iter_73_3.rare == var_73_5 then
			var_73_8 = iter_73_3.equipId

			break
		end
	end

	return var_73_4 / var_73_3, var_73_5, var_73_8
end

function var_0_0.getStageEpisodeList(arg_74_0, arg_74_1)
	local var_74_0 = {}

	if arg_74_1 then
		local var_74_1 = arg_74_0:getCurSeasonId()
		local var_74_2 = SeasonConfig.instance:getSeasonEpisodeCos(var_74_1)

		for iter_74_0, iter_74_1 in pairs(var_74_2) do
			if iter_74_1.stage == arg_74_1 then
				table.insert(var_74_0, iter_74_1)
			end
		end

		table.sort(var_74_0, function(arg_75_0, arg_75_1)
			return arg_75_0.layer < arg_75_1.layer
		end)
	end

	return var_74_0
end

function var_0_0.getItemCount(arg_76_0, arg_76_1, arg_76_2)
	arg_76_2 = arg_76_2 or arg_76_0:getCurSeasonId()

	local var_76_0 = arg_76_0:getActivityInfo(arg_76_2)

	if not var_76_0 then
		return
	end

	return var_76_0:getItemCount(arg_76_1)
end

function var_0_0.isSeasonEpisodeType(arg_77_0, arg_77_1)
	return arg_77_1 == DungeonEnum.EpisodeType.Season or arg_77_1 == DungeonEnum.EpisodeType.SeasonRetail or arg_77_1 == DungeonEnum.EpisodeType.SeasonSpecial or arg_77_1 == DungeonEnum.EpisodeType.SeasonTrial
end

function var_0_0.getRealHeroGroupBySubId(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_0:getCurSeasonId()
	local var_78_1 = arg_78_0:getActivityInfo(var_78_0)

	if not var_78_1 then
		return
	end

	return var_78_1:getRealHeroGroupBySubId(arg_78_1)
end

function var_0_0.getFightCardDataList(arg_79_0)
	local var_79_0 = FightModel.instance:getFightParam()
	local var_79_1 = var_79_0.activity104Equips

	return Activity104EquipItemListModel.instance:fiterFightCardDataList(var_79_1, var_79_0.trialHeroList)
end

function var_0_0.buildHeroGroup(arg_80_0)
	local var_80_0 = arg_80_0:getCurSeasonId()
	local var_80_1 = arg_80_0:getActivityInfo(var_80_0)

	if not var_80_1 then
		return
	end

	var_80_1:buildHeroGroup()
end

function var_0_0.MarkPopSummary(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0:getActivityInfo(arg_81_1)

	if not var_81_0 then
		return
	end

	var_81_0:setIsPopSummary(false)
end

function var_0_0.getIsPopSummary(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0:getActivityInfo(arg_82_1)

	if not var_82_0 then
		return
	end

	return var_82_0:getIsPopSummary()
end

function var_0_0.getLastMaxLayer(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0:getActivityInfo(arg_83_1)

	if not var_83_0 then
		return
	end

	return var_83_0:getLastMaxLayer()
end

function var_0_0.getTrialId(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0:getActivityInfo(arg_84_1)

	if not var_84_0 then
		return
	end

	return var_84_0:getTrialId()
end

function var_0_0.getSeasonTrialPrefsKey(arg_85_0)
	return (string.format("%s_%s_%s", PlayerPrefsKey.SeasonHeroGroupTrial, PlayerModel.instance:getMyUserId(), arg_85_0:getCurSeasonId()))
end

function var_0_0.hasSeasonReview(arg_86_0, arg_86_1)
	local var_86_0 = SeasonConfig.instance:getSeasonConstCo(arg_86_1, Activity104Enum.ConstEnum.LastSeasonId)
	local var_86_1 = var_86_0 and var_86_0.value1

	if not var_86_1 or var_86_1 == 0 then
		return false
	end

	return ActivityConfig.instance:getActivityCo(var_86_1) ~= nil
end

function var_0_0.caleRetailEquipRareWeight(arg_87_0)
	local var_87_0 = arg_87_0:getCurSeasonId()
	local var_87_1 = SeasonConfig.instance:getSeasonRetailEpisodes(var_87_0)
	local var_87_2 = 0
	local var_87_3 = 0
	local var_87_4 = 0

	for iter_87_0, iter_87_1 in pairs(var_87_1) do
		local var_87_5 = iter_87_1.retailEpisodeId
		local var_87_6, var_87_7, var_87_8 = arg_87_0:getRetailEpisodeEquipRareWeight(var_87_0, var_87_5)

		if var_87_3 < var_87_7 then
			var_87_2 = var_87_6
			var_87_3 = var_87_7
			var_87_4 = var_87_8
		end
	end

	return var_87_2, var_87_3, var_87_4
end

function var_0_0.getRetailEpisodeEquipRareWeight(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = SeasonConfig.instance:getSeasonRetailEpisodeCo(arg_88_1, arg_88_2)
	local var_88_1 = 0
	local var_88_2 = 0
	local var_88_3 = 0

	if not var_88_0 then
		return 0, 0, 0
	end

	local var_88_4 = GameUtil.splitString2(var_88_0.equipRareWeight, true)

	for iter_88_0, iter_88_1 in ipairs(var_88_4) do
		var_88_1 = iter_88_1[2] + var_88_1

		if var_88_3 < iter_88_1[1] then
			var_88_3 = iter_88_1[1]
			var_88_2 = iter_88_1[2]
		end
	end

	if var_88_1 == 0 then
		var_88_1 = 1
	end

	local var_88_5 = 0
	local var_88_6 = SeasonConfig.instance:getSeasonOptionalEquipCos()

	for iter_88_2, iter_88_3 in pairs(var_88_6) do
		if iter_88_3.rare == var_88_3 then
			var_88_5 = iter_88_3.equipId

			break
		end
	end

	return var_88_2 / var_88_1, var_88_3, var_88_5
end

var_0_0.instance = var_0_0.New()

return var_0_0
