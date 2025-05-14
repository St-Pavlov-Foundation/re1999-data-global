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

function var_0_0.getAllRetailMo(arg_13_0)
	local var_13_0 = arg_13_0:getCurSeasonId()
	local var_13_1 = arg_13_0:getActivityInfo(var_13_0)

	if not var_13_1 then
		return
	end

	return var_13_1.retails
end

function var_0_0.getLastRetails(arg_14_0)
	local var_14_0 = arg_14_0:getCurSeasonId()
	local var_14_1 = arg_14_0:getActivityInfo(var_14_0)

	if not var_14_1 then
		return
	end

	return var_14_1:getLastRetails()
end

function var_0_0.getAllItemMo(arg_15_0)
	local var_15_0 = arg_15_0:getCurSeasonId()
	local var_15_1 = arg_15_0:getActivityInfo(var_15_0)

	if not var_15_1 then
		return
	end

	return var_15_1.activity104Items
end

function var_0_0.getItemEquipUid(arg_16_0, arg_16_1)
	if arg_16_1 == 0 then
		return 0
	end

	local var_16_0 = arg_16_0:getCurSeasonId()
	local var_16_1 = arg_16_0:getActivityInfo(var_16_0)

	if not var_16_1 then
		return
	end

	for iter_16_0, iter_16_1 in pairs(var_16_1.activity104Items) do
		if iter_16_1.itemId == arg_16_1 then
			return iter_16_1.uid
		end
	end

	return 0
end

function var_0_0.getItemIdByUid(arg_17_0, arg_17_1)
	if arg_17_1 == "0" then
		return 0
	end

	local var_17_0 = arg_17_0:getCurSeasonId()
	local var_17_1 = arg_17_0:getActivityInfo(var_17_0)

	if not var_17_1 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(var_17_1.activity104Items) do
		if iter_17_1.uid == arg_17_1 then
			return iter_17_1.itemId
		end
	end

	return 0
end

function var_0_0.getAllSpecialMo(arg_18_0)
	local var_18_0 = arg_18_0:getCurSeasonId()
	local var_18_1 = arg_18_0:getActivityInfo(var_18_0)

	if not var_18_1 then
		return
	end

	return var_18_1.specials
end

function var_0_0.getSeasonAllHeroGroup(arg_19_0)
	local var_19_0 = arg_19_0:getCurSeasonId()
	local var_19_1 = arg_19_0:getActivityInfo(var_19_0)

	if not var_19_1 then
		return
	end

	return var_19_1.heroGroupSnapshot
end

function var_0_0.isSeasonGMChapter(arg_20_0, arg_20_1)
	return (arg_20_1 or DungeonModel.instance.curSendChapterId) == 9991
end

function var_0_0.isSeasonChapter(arg_21_0)
	local var_21_0 = arg_21_0:getCurSeasonId()
	local var_21_1 = DungeonModel.instance.curSendEpisodeId

	if not var_21_1 or var_21_1 == 0 then
		return false
	end

	local var_21_2 = DungeonConfig.instance:getEpisodeCO(var_21_1)

	if var_21_2 and arg_21_0:isSeasonEpisodeType(var_21_2.type) then
		return true
	end

	return false
end

function var_0_0.getEpisodeState(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getAllEpisodeMO()

	return var_22_0[arg_22_1] and var_22_0[arg_22_1].state or 0
end

function var_0_0.getCurSeasonId(arg_23_0)
	return Activity104Enum.CurSeasonId
end

function var_0_0.isSeasonDataReady(arg_24_0)
	local var_24_0 = arg_24_0:getCurSeasonId()

	return arg_24_0:getActivityInfo(var_24_0, true) ~= nil
end

function var_0_0.getSeasonCurSnapshotSubId(arg_25_0)
	local var_25_0 = arg_25_0:getCurSeasonId()
	local var_25_1 = arg_25_0:getActivityInfo(var_25_0)

	if not var_25_1 then
		return
	end

	return var_25_1.heroGroupSnapshotSubId
end

function var_0_0.setSeasonCurSnapshotSubId(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1 = arg_26_1 or arg_26_0:getCurSeasonId()
	arg_26_2 = arg_26_2 or 1

	local var_26_0 = arg_26_0:getActivityInfo(arg_26_1)

	if not var_26_0 then
		return
	end

	var_26_0.heroGroupSnapshotSubId = arg_26_2

	local var_26_1 = arg_26_0:getSnapshotHeroGroupBySubId(arg_26_2)

	HeroSingleGroupModel.instance:setSingleGroup(var_26_1)

	local var_26_2 = HeroSingleGroupModel.instance:getList()

	for iter_26_0 = 1, #var_26_2 do
		var_26_2[iter_26_0]:setAid(var_26_1.aidDict and var_26_1.aidDict[iter_26_0])

		if var_26_1.trialDict and var_26_1.trialDict[iter_26_0] then
			var_26_2[iter_26_0]:setTrial(unpack(var_26_1.trialDict[iter_26_0]))
		else
			var_26_2[iter_26_0]:setTrial()
		end
	end
end

function var_0_0.getSnapshotHeroGroupBySubId(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:getCurSeasonId()

	arg_27_1 = arg_27_1 or arg_27_0:getSeasonCurSnapshotSubId(var_27_0)

	local var_27_1 = arg_27_0:getActivityInfo(var_27_0)

	if not var_27_1 then
		return
	end

	return var_27_1:getSnapshotHeroGroupBySubId(arg_27_1)
end

function var_0_0.setSnapshotByFightGroup(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_1 = arg_28_1 or arg_28_0:getCurSeasonId()

	local var_28_0 = arg_28_0:getActivityInfo(arg_28_1)

	if not var_28_0 then
		return
	end

	if not var_28_0.heroGroupSnapshot[arg_28_2] then
		var_28_0.heroGroupSnapshot[arg_28_2] = {}
	end

	local var_28_1 = var_28_0.heroGroupSnapshot[arg_28_2]

	var_28_1.heroList = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_3.fightGroup.heroList) do
		table.insert(var_28_1.heroList, iter_28_1)
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_3.fightGroup.subHeroList) do
		table.insert(var_28_1.heroList, iter_28_3)
	end

	var_28_1.clothId = arg_28_3.fightGroup.clothId
	var_28_1.equips = {}

	for iter_28_4, iter_28_5 in ipairs(arg_28_3.fightGroup.equips) do
		if var_28_1.equips[iter_28_4 - 1] == nil then
			var_28_1.equips[iter_28_4 - 1] = HeroGroupEquipMO.New()
		end

		var_28_1.equips[iter_28_4 - 1]:init({
			index = iter_28_4 - 1,
			equipUid = iter_28_5.equipUid
		})
	end

	var_28_1.activity104Equips = {}

	for iter_28_6, iter_28_7 in ipairs(arg_28_3.fightGroup.activity104Equips) do
		if var_28_1.activity104Equips[iter_28_6 - 1] == nil then
			var_28_1.activity104Equips[iter_28_6 - 1] = HeroGroupActivity104EquipMo.New()
		end

		var_28_1.activity104Equips[iter_28_6 - 1]:init({
			index = iter_28_6 - 1,
			equipUid = iter_28_7.equipUid
		})
	end

	var_28_1:clearAidHero()
end

function var_0_0.getAllHeroGroupSnapshot(arg_29_0, arg_29_1)
	arg_29_1 = arg_29_1 or arg_29_0:getCurSeasonId()

	local var_29_0 = arg_29_0:getActivityInfo(arg_29_1)

	if not var_29_0 then
		return
	end

	return var_29_0.heroGroupSnapshot
end

function var_0_0.replaceHeroList(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_1 = arg_30_1 or arg_30_0:getCurSeasonId()
	arg_30_2 = arg_30_2 or arg_30_0:getSeasonCurSnapshotSubId(arg_30_1)

	local var_30_0 = arg_30_0:getActivityInfo(arg_30_1)

	if not var_30_0 then
		return
	end

	var_30_0.heroGroupSnapshot[arg_30_2].heroList = arg_30_3
end

function var_0_0.resetSnapshotHeroGroupEquip(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	arg_31_1 = arg_31_1 or arg_31_0:getCurSeasonId()
	arg_31_2 = arg_31_2 or arg_31_0:getSeasonCurSnapshotSubId(arg_31_1)

	local var_31_0 = arg_31_0:getActivityInfo(arg_31_1)

	if not var_31_0 then
		return
	end

	for iter_31_0, iter_31_1 in pairs(var_31_0.heroGroupSnapshot[arg_31_2].equips) do
		if iter_31_1.index == arg_31_3 then
			iter_31_1.equipUid = arg_31_4
		end
	end
end

function var_0_0.resetSnapshotHeroGroupHero(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	arg_32_1 = arg_32_1 or arg_32_0:getCurSeasonId()
	arg_32_2 = arg_32_2 or arg_32_0:getSeasonCurSnapshotSubId(arg_32_1)

	local var_32_0 = arg_32_0:getActivityInfo(arg_32_1)

	if not var_32_0 then
		return
	end

	var_32_0.heroGroupSnapshot[arg_32_2].heroList[arg_32_3] = arg_32_4
end

function var_0_0.getAct104CurLayer(arg_33_0, arg_33_1)
	arg_33_1 = arg_33_1 or arg_33_0:getCurSeasonId()

	local var_33_0 = arg_33_0:getActivityInfo(arg_33_1)

	if not var_33_0 or not var_33_0.episodes then
		return 0, 1
	end

	local var_33_1 = 1
	local var_33_2 = 1

	for iter_33_0, iter_33_1 in pairs(var_33_0.episodes) do
		if var_33_1 <= iter_33_1.layer and iter_33_1.state == 1 then
			var_33_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_33_1, iter_33_1.layer + 1) and iter_33_1.layer + 1 or iter_33_1.layer
			var_33_2 = iter_33_1.layer + 1
		end
	end

	return var_33_1, var_33_2
end

function var_0_0.isLayerPassed(arg_34_0, arg_34_1, arg_34_2)
	arg_34_1 = arg_34_1 or arg_34_0:getCurSeasonId()

	local var_34_0 = arg_34_0:getActivityInfo(arg_34_1)

	if not var_34_0 or not var_34_0.episodes then
		return false
	end

	for iter_34_0, iter_34_1 in pairs(var_34_0.episodes) do
		if iter_34_1.layer == arg_34_2 then
			return iter_34_1.state == 1
		end
	end

	return false
end

function var_0_0.getAct104CurStage(arg_35_0, arg_35_1, arg_35_2)
	arg_35_1 = arg_35_1 or arg_35_0:getCurSeasonId()
	arg_35_2 = arg_35_2 or arg_35_0:getAct104CurLayer()

	local var_35_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_35_1, arg_35_2)

	return var_35_0 and var_35_0.stage or 0
end

function var_0_0.getMaxLayer(arg_36_0, arg_36_1)
	arg_36_1 = arg_36_1 or arg_36_0:getCurSeasonId()

	if arg_36_0:getAct104CurLayer(arg_36_1) <= 20 then
		return 20
	end

	local var_36_0 = SeasonConfig.instance:getSeasonEpisodeCos(arg_36_1)
	local var_36_1 = 0

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		if var_36_1 < iter_36_1.layer then
			var_36_1 = iter_36_1.layer
		end
	end

	return var_36_1
end

function var_0_0.isSpecialOpen(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or arg_37_0:getCurSeasonId()

	if not arg_37_0:isEnterSpecial(arg_37_1) then
		return false
	end

	local var_37_0 = arg_37_0:getAct104CurLayer()
	local var_37_1 = SeasonConfig.instance:getSeasonConstCo(arg_37_1, Activity104Enum.ConstEnum.SpecialOpenLayer)

	if var_37_0 > (var_37_1 and var_37_1.value1) then
		return true
	end

	return false
end

function var_0_0.isEnterSpecial(arg_38_0, arg_38_1)
	arg_38_1 = arg_38_1 or arg_38_0:getCurSeasonId()

	local var_38_0 = ActivityModel.instance:getActStartTime(arg_38_1) / 1000
	local var_38_1 = SeasonConfig.instance:getSeasonConstCo(arg_38_1, Activity104Enum.ConstEnum.SpecialOpenDayCount)

	if (var_38_1 and var_38_1.value1 - 1) * 86400 + var_38_0 <= ServerTime.now() then
		return true
	end

	return false
end

function var_0_0.isSeasonSlotUnlock(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_1 = arg_39_1 or arg_39_0:getCurSeasonId()
	arg_39_2 = arg_39_2 or arg_39_0:getSeasonCurSnapshotSubId(arg_39_1)

	local var_39_0 = arg_39_0:getActivityInfo(arg_39_1)

	if not var_39_0 then
		return
	end

	local var_39_1 = var_39_0.unlockEquipIndexs

	for iter_39_0, iter_39_1 in pairs(var_39_1) do
		if iter_39_1 ~= 9 and iter_39_1 >= 4 * arg_39_3 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonPosUnlock(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	arg_40_1 = arg_40_1 or arg_40_0:getCurSeasonId()
	arg_40_2 = arg_40_2 or arg_40_0:getSeasonCurSnapshotSubId(arg_40_1)

	local var_40_0 = arg_40_0:getActivityInfo(arg_40_1)

	if not var_40_0 then
		return
	end

	local var_40_1 = var_40_0.unlockEquipIndexs
	local var_40_2 = arg_40_4 == 4 and 9 or arg_40_4 + 1 + 4 * (arg_40_3 - 1)

	for iter_40_0, iter_40_1 in pairs(var_40_1) do
		if iter_40_1 == var_40_2 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonLayerSlotUnlock(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
	arg_41_1 = arg_41_1 or arg_41_0:getCurSeasonId()
	arg_41_2 = arg_41_2 or arg_41_0:getSeasonCurSnapshotSubId(arg_41_1)

	local var_41_0 = {}

	if arg_41_3 > 1 then
		for iter_41_0 = 2, arg_41_3 do
			local var_41_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_41_0:getCurSeasonId(), iter_41_0 - 1)
			local var_41_2 = string.splitToNumber(var_41_1.unlockEquipIndex, "#")

			for iter_41_1, iter_41_2 in pairs(var_41_2) do
				table.insert(var_41_0, iter_41_2)
			end
		end
	end

	for iter_41_3, iter_41_4 in pairs(var_41_0) do
		if iter_41_4 ~= 9 and iter_41_4 >= 4 * arg_41_4 then
			return true
		end
	end

	return false
end

function var_0_0.isSeasonLayerPosUnlock(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	arg_42_1 = arg_42_1 or arg_42_0:getCurSeasonId()
	arg_42_2 = arg_42_2 or arg_42_0:getSeasonCurSnapshotSubId(arg_42_1)

	local var_42_0 = {}

	if arg_42_3 > 1 then
		for iter_42_0 = 2, arg_42_3 do
			local var_42_1 = SeasonConfig.instance:getSeasonEpisodeCo(arg_42_0:getCurSeasonId(), iter_42_0 - 1)
			local var_42_2 = string.splitToNumber(var_42_1.unlockEquipIndex, "#")

			for iter_42_1, iter_42_2 in pairs(var_42_2) do
				table.insert(var_42_0, iter_42_2)
			end
		end
	end

	local var_42_3 = arg_42_5 == 4 and 9 or arg_42_5 + 1 + 4 * (arg_42_4 - 1)

	for iter_42_3, iter_42_4 in pairs(var_42_0) do
		if iter_42_4 == var_42_3 then
			return true
		end
	end

	return false
end

function var_0_0.getSeasonHeroGroupEquipId(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4)
	arg_43_1 = arg_43_1 or arg_43_0:getCurSeasonId()

	local var_43_0 = arg_43_0:getActivityInfo(arg_43_1)

	if not var_43_0 then
		return 0
	end

	local var_43_1 = var_43_0:getSnapshotHeroGroupBySubId(arg_43_2)

	if var_43_1 and var_43_1.activity104Equips[arg_43_4] then
		local var_43_2 = var_43_1.activity104Equips[arg_43_4].equipUid[arg_43_3]

		return arg_43_0:getItemIdByUid(var_43_2), var_43_2
	end

	return 0
end

function var_0_0.getAct104Retails(arg_44_0, arg_44_1)
	arg_44_1 = arg_44_1 or arg_44_0:getCurSeasonId()

	local var_44_0 = arg_44_0:getActivityInfo(arg_44_1)

	if not var_44_0 then
		return
	end

	return var_44_0.retails
end

function var_0_0.replaceAct104Retails(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1.actId or arg_45_0:getCurSeasonId()
	local var_45_1 = arg_45_0:getActivityInfo(var_45_0)

	if not var_45_1 then
		return
	end

	var_45_1:replaceRetails(arg_45_1.retails)

	var_45_1.retailStage = arg_45_1.retailStage
end

function var_0_0.getRetailStage(arg_46_0, arg_46_1)
	arg_46_1 = arg_46_1 or arg_46_0:getCurSeasonId()

	local var_46_0 = arg_46_0:getActivityInfo(arg_46_1)

	if not var_46_0 then
		return
	end

	if var_46_0.retailStage == 0 then
		var_46_0.retailStage = arg_46_0:getAct104CurStage(arg_46_1)
	end

	return var_46_0.retailStage
end

function var_0_0.getRetailEpisodeTag(arg_47_0, arg_47_1)
	local var_47_0 = ""
	local var_47_1 = arg_47_0:getCurSeasonId()
	local var_47_2 = SeasonConfig.instance:getSeasonRetailCos(var_47_1)

	for iter_47_0, iter_47_1 in pairs(var_47_2) do
		local var_47_3 = string.splitToNumber(iter_47_1.retailEpisodeIdPool, "#")
		local var_47_4 = string.split(iter_47_1.enemyTag, "#")

		for iter_47_2 = 1, #var_47_3 do
			if var_47_3[iter_47_2] == arg_47_1 then
				var_47_0 = var_47_4[iter_47_2] or ""

				return var_47_0
			end
		end
	end

	return var_47_0
end

function var_0_0.getEpisodeRetail(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:getCurSeasonId()
	local var_48_1 = arg_48_0:getActivityInfo(var_48_0)

	if var_48_1 then
		for iter_48_0, iter_48_1 in pairs(var_48_1.retails) do
			if iter_48_1.id == arg_48_1 then
				return iter_48_1
			end
		end
	end

	return {}
end

function var_0_0.isLastDay(arg_49_0, arg_49_1)
	arg_49_1 = arg_49_1 or arg_49_0:getCurSeasonId()

	return ActivityModel.instance:getRemainTime(arg_49_1) < 86400
end

function var_0_0.isAllSpecialLayerFinished(arg_50_0)
	local var_50_0 = arg_50_0:getCurSeasonId()
	local var_50_1 = arg_50_0:getActivityInfo(var_50_0)

	if not var_50_1 or not var_50_1.specials then
		return true
	end

	local var_50_2 = arg_50_0:getMaxSpecialLayer()

	for iter_50_0, iter_50_1 in pairs(var_50_1.specials) do
		if iter_50_1.state == 0 then
			return false
		end
	end

	return true
end

function var_0_0.getAct104SpecialInitLayer(arg_51_0)
	local var_51_0 = arg_51_0:getCurSeasonId()
	local var_51_1 = arg_51_0:getActivityInfo(var_51_0)

	if not var_51_1 or not var_51_1.specials then
		return 0
	end

	if not next(var_51_1.specials) then
		return 1
	end

	local var_51_2 = arg_51_0:getMaxSpecialLayer()

	for iter_51_0, iter_51_1 in pairs(var_51_1.specials) do
		if iter_51_1.state == 0 then
			var_51_2 = math.min(iter_51_1.layer, var_51_2)
		end
	end

	return var_51_2
end

function var_0_0.getMaxSpecialLayer(arg_52_0)
	local var_52_0 = SeasonConfig.instance:getSeasonSpecialCos(arg_52_0:getCurSeasonId())
	local var_52_1 = 0

	for iter_52_0, iter_52_1 in pairs(var_52_0) do
		if var_52_1 < iter_52_1.layer then
			var_52_1 = iter_52_1.layer
		end
	end

	return var_52_1
end

function var_0_0.isSpecialLayerPassed(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:getCurSeasonId()
	local var_53_1 = arg_53_0:getActivityInfo(var_53_0)

	if not var_53_1 or not var_53_1.specials then
		return false
	end

	for iter_53_0, iter_53_1 in pairs(var_53_1.specials) do
		if iter_53_1.layer == arg_53_1 then
			return iter_53_1.state == 1
		end
	end

	return false
end

function var_0_0.isNewStage(arg_54_0)
	local var_54_0 = arg_54_0:getAct104CurStage()
	local var_54_1 = arg_54_0:getAct104CurLayer()
	local var_54_2 = SeasonConfig.instance:getSeasonEpisodeCo(arg_54_0:getCurSeasonId(), var_54_1 - 1)

	if not var_54_2 then
		return false
	end

	return var_54_0 ~= var_54_2.stage
end

function var_0_0.isNextLayerNewStage(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getCurSeasonId()
	local var_55_1 = SeasonConfig.instance:getSeasonEpisodeCo(var_55_0, arg_55_1)
	local var_55_2 = var_55_1 and var_55_1.stage or 0
	local var_55_3 = SeasonConfig.instance:getSeasonEpisodeCo(arg_55_0:getCurSeasonId(), arg_55_1 + 1)

	if not var_55_3 then
		return false
	end

	return var_55_2 ~= var_55_3.stage
end

function var_0_0.isEpisodeAdvance(arg_56_0, arg_56_1)
	if DungeonConfig.instance:getEpisodeCO(arg_56_1).type ~= DungeonEnum.EpisodeType.SeasonRetail then
		return false
	end

	local var_56_0 = arg_56_0:getAct104Retails()

	for iter_56_0, iter_56_1 in pairs(var_56_0) do
		if iter_56_1.id == arg_56_1 and iter_56_1.advancedId ~= 0 and iter_56_1.advancedRare ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.onReceiveGetUnlockActivity104EquipIdsReply(arg_57_0, arg_57_1)
	arg_57_0:getActivityInfo(arg_57_1.activityId):setUnlockActivity104EquipIds(arg_57_1.unlockActivity104EquipIds)
end

function var_0_0.isNew104Equip(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:getActivityInfo(arg_58_0:getCurSeasonId())

	if not var_58_0 then
		return
	end

	return not var_58_0.unlockActivity104EquipIds[arg_58_1]
end

function var_0_0.markActivityStory(arg_59_0, arg_59_1)
	arg_59_1 = arg_59_1 or arg_59_0:getCurSeasonId()

	local var_59_0 = arg_59_0:getActivityInfo(arg_59_1)

	if var_59_0 then
		var_59_0:markStory(true)
	end
end

function var_0_0.markEpisodeAfterStory(arg_60_0, arg_60_1, arg_60_2)
	arg_60_1 = arg_60_1 or arg_60_0:getCurSeasonId()

	local var_60_0 = arg_60_0:getActivityInfo(arg_60_1)

	if var_60_0 then
		var_60_0:markEpisodeAfterStory(arg_60_2)
	end
end

function var_0_0.isReadActivity104Story(arg_61_0, arg_61_1)
	arg_61_1 = arg_61_1 or arg_61_0:getCurSeasonId()

	local var_61_0 = arg_61_0:getActivityInfo(arg_61_1)

	return var_61_0 and var_61_0.readActivity104Story
end

function var_0_0.isEpisodeAfterStory(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = arg_62_0:getAllEpisodeMO(arg_62_1)

	if not var_62_0 then
		return
	end

	return var_62_0[arg_62_2] and var_62_0[arg_62_2].readAfterStory
end

function var_0_0.canPlayStageLevelup(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	if arg_63_1 ~= 1 then
		return
	end

	if arg_63_2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if arg_63_3 then
		return
	end

	arg_63_4 = arg_63_4 or arg_63_0:getCurSeasonId()

	if arg_63_0:isEpisodeAfterStory(arg_63_4, arg_63_5) then
		return
	end

	if not arg_63_0:isNextLayerNewStage(arg_63_5) then
		return
	end

	local var_63_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_63_4, arg_63_5 + 1)

	return var_63_0 and var_63_0.stage
end

function var_0_0.canMarkFightAfterStory(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
	if arg_64_1 ~= 1 then
		return
	end

	if arg_64_2 ~= DungeonEnum.EpisodeType.Season then
		return
	end

	if arg_64_3 or not arg_64_5 then
		return
	end

	arg_64_4 = arg_64_4 or arg_64_0:getCurSeasonId()

	if arg_64_0:isEpisodeAfterStory(arg_64_4, arg_64_5) then
		return
	end

	return true
end

function var_0_0.getOptionalAct104Equips(arg_65_0, arg_65_1)
	arg_65_1 = arg_65_1 or arg_65_0:getCurSeasonId()

	local var_65_0 = {}
	local var_65_1 = arg_65_0:getActivityInfo(arg_65_1)

	if var_65_1 then
		for iter_65_0, iter_65_1 in pairs(var_65_1.activity104Items) do
			local var_65_2 = SeasonConfig.instance:getSeasonEquipCo(iter_65_1.itemId)

			if var_65_2 and var_65_2.isOptional == 1 then
				table.insert(var_65_0, iter_65_1)
			end
		end
	end

	return var_65_0
end

function var_0_0.addCardGetData(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0:getCurSeasonId()
	local var_66_1 = SeasonViewHelper.getViewName(var_66_0, Activity104Enum.ViewName.CelebrityCardGetlView)

	for iter_66_0 = 1, PopupController.instance._popupList:getSize() do
		if PopupController.instance._popupList._dataList[iter_66_0][2] == var_66_1 then
			local var_66_2 = PopupController.instance._popupList._dataList[iter_66_0][3].data

			tabletool.addValues(var_66_2, arg_66_1)

			PopupController.instance._popupList._dataList[iter_66_0][3] = {
				is_item_id = true,
				data = var_66_2
			}

			return
		end
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, var_66_1, {
		is_item_id = true,
		data = arg_66_1
	})
end

function var_0_0.setMakertLayerMark(arg_67_0, arg_67_1, arg_67_2)
	arg_67_1 = arg_67_1 or arg_67_0:getCurSeasonId()

	local var_67_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local var_67_1 = string.split(var_67_0, "|")
	local var_67_2 = {}

	for iter_67_0, iter_67_1 in ipairs(var_67_1) do
		local var_67_3 = string.splitToNumber(iter_67_1, "#")

		if var_67_3 and var_67_3[1] then
			var_67_2[var_67_3[1]] = var_67_3[2]
		end
	end

	if not var_67_2[arg_67_1] or arg_67_2 > var_67_2[arg_67_1] then
		var_67_2[arg_67_1] = arg_67_2
	end

	local var_67_4 = {}

	for iter_67_2, iter_67_3 in pairs(var_67_2) do
		table.insert(var_67_4, string.format("%s#%s", iter_67_2, iter_67_3))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), table.concat(var_67_4, "|"))
end

function var_0_0.isCanPlayMakertLayerAnim(arg_68_0, arg_68_1, arg_68_2)
	arg_68_1 = arg_68_1 or arg_68_0:getCurSeasonId()

	if not arg_68_1 or not arg_68_2 then
		return
	end

	local var_68_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.EnterSeasonMakertLayer), "")
	local var_68_1 = string.split(var_68_0, "|")

	for iter_68_0, iter_68_1 in ipairs(var_68_1) do
		local var_68_2 = string.splitToNumber(iter_68_1, "#")

		if var_68_2 and var_68_2[1] == arg_68_1 then
			return arg_68_2 > var_68_2[2]
		end
	end

	return true
end

function var_0_0.setGroupCardUnlockTweenPos(arg_69_0, arg_69_1, arg_69_2)
	arg_69_1 = arg_69_1 or arg_69_0:getCurSeasonId()

	local var_69_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local var_69_1 = string.split(var_69_0, "|")
	local var_69_2 = {}

	for iter_69_0, iter_69_1 in ipairs(var_69_1) do
		local var_69_3 = string.splitToNumber(iter_69_1, "#")

		if var_69_3 and var_69_3[1] then
			var_69_2[var_69_3[1]] = {}

			if #var_69_3 > 1 then
				for iter_69_2 = 2, #var_69_3 do
					var_69_2[var_69_3[1]][var_69_3[iter_69_2]] = 1
				end
			end
		end
	end

	if not var_69_2[arg_69_1] then
		var_69_2[arg_69_1] = {}
	end

	var_69_2[arg_69_1][arg_69_2] = 1

	local var_69_4 = {}

	for iter_69_3, iter_69_4 in pairs(var_69_2) do
		local var_69_5 = {
			iter_69_3
		}

		for iter_69_5, iter_69_6 in pairs(iter_69_4) do
			table.insert(var_69_5, iter_69_5)
		end

		table.insert(var_69_4, table.concat(var_69_5, "#"))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), table.concat(var_69_4, "|"))
end

function var_0_0.isContainGroupCardUnlockTweenPos(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_1 = arg_70_1 or arg_70_0:getCurSeasonId()

	local var_70_0 = SeasonConfig.instance:getSeasonEpisodeCo(arg_70_1, arg_70_2)

	if not var_70_0 then
		return true
	end

	local var_70_1 = string.splitToNumber(var_70_0.unlockEquipIndex, "#")

	if not tabletool.indexOf(var_70_1, arg_70_3) then
		return true
	end

	local var_70_2 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SeasonGroupCardUnlockTweenPos), "")
	local var_70_3 = string.split(var_70_2, "|")

	for iter_70_0, iter_70_1 in ipairs(var_70_3) do
		local var_70_4 = string.splitToNumber(iter_70_1, "#")

		if var_70_4 and var_70_4[1] == arg_70_1 then
			if #var_70_4 > 1 then
				for iter_70_2 = 2, #var_70_4 do
					if var_70_4[iter_70_2] == arg_70_3 then
						return true
					end
				end
			end

			break
		end
	end

	return false
end

function var_0_0.caleStageEquipRareWeight(arg_71_0, arg_71_1)
	arg_71_1 = arg_71_1 or arg_71_0:getAct104CurStage()

	local var_71_0 = arg_71_0:getCurSeasonId()
	local var_71_1 = SeasonConfig.instance:getSeasonRetailCo(var_71_0, arg_71_1)
	local var_71_2 = string.split(var_71_1.equipRareWeight, "|")
	local var_71_3 = 0
	local var_71_4 = 0
	local var_71_5 = 0
	local var_71_6 = {}

	for iter_71_0, iter_71_1 in ipairs(var_71_2) do
		local var_71_7 = string.splitToNumber(iter_71_1, "#")

		if var_71_7 then
			var_71_3 = var_71_7[2] + var_71_3

			if var_71_5 < var_71_7[1] then
				var_71_5 = var_71_7[1]
				var_71_4 = var_71_7[2]
			end
		end
	end

	if var_71_3 == 0 then
		var_71_3 = 1
	end

	local var_71_8 = 0
	local var_71_9 = SeasonConfig.instance:getSeasonOptionalEquipCos()

	for iter_71_2, iter_71_3 in pairs(var_71_9) do
		if iter_71_3.rare == var_71_5 then
			var_71_8 = iter_71_3.equipId

			break
		end
	end

	return var_71_4 / var_71_3, var_71_5, var_71_8
end

function var_0_0.getStageEpisodeList(arg_72_0, arg_72_1)
	local var_72_0 = {}

	if arg_72_1 then
		local var_72_1 = arg_72_0:getCurSeasonId()
		local var_72_2 = SeasonConfig.instance:getSeasonEpisodeCos(var_72_1)

		for iter_72_0, iter_72_1 in pairs(var_72_2) do
			if iter_72_1.stage == arg_72_1 then
				table.insert(var_72_0, iter_72_1)
			end
		end

		table.sort(var_72_0, function(arg_73_0, arg_73_1)
			return arg_73_0.layer < arg_73_1.layer
		end)
	end

	return var_72_0
end

function var_0_0.getItemCount(arg_74_0, arg_74_1, arg_74_2)
	arg_74_2 = arg_74_2 or arg_74_0:getCurSeasonId()

	local var_74_0 = arg_74_0:getActivityInfo(arg_74_2)

	if not var_74_0 then
		return
	end

	return var_74_0:getItemCount(arg_74_1)
end

function var_0_0.isSeasonEpisodeType(arg_75_0, arg_75_1)
	return arg_75_1 == DungeonEnum.EpisodeType.Season or arg_75_1 == DungeonEnum.EpisodeType.SeasonRetail or arg_75_1 == DungeonEnum.EpisodeType.SeasonSpecial or arg_75_1 == DungeonEnum.EpisodeType.SeasonTrial
end

function var_0_0.getRealHeroGroupBySubId(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0:getCurSeasonId()
	local var_76_1 = arg_76_0:getActivityInfo(var_76_0)

	if not var_76_1 then
		return
	end

	return var_76_1:getRealHeroGroupBySubId(arg_76_1)
end

function var_0_0.getFightCardDataList(arg_77_0)
	local var_77_0 = FightModel.instance:getFightParam()
	local var_77_1 = var_77_0.activity104Equips

	return Activity104EquipItemListModel.instance:fiterFightCardDataList(var_77_1, var_77_0.trialHeroList)
end

function var_0_0.buildHeroGroup(arg_78_0)
	local var_78_0 = arg_78_0:getCurSeasonId()
	local var_78_1 = arg_78_0:getActivityInfo(var_78_0)

	if not var_78_1 then
		return
	end

	var_78_1:buildHeroGroup()
end

function var_0_0.MarkPopSummary(arg_79_0, arg_79_1)
	local var_79_0 = arg_79_0:getActivityInfo(arg_79_1)

	if not var_79_0 then
		return
	end

	var_79_0:setIsPopSummary(false)
end

function var_0_0.getIsPopSummary(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0:getActivityInfo(arg_80_1)

	if not var_80_0 then
		return
	end

	return var_80_0:getIsPopSummary()
end

function var_0_0.getLastMaxLayer(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0:getActivityInfo(arg_81_1)

	if not var_81_0 then
		return
	end

	return var_81_0:getLastMaxLayer()
end

function var_0_0.getTrialId(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_0:getActivityInfo(arg_82_1)

	if not var_82_0 then
		return
	end

	return var_82_0:getTrialId()
end

function var_0_0.getSeasonTrialPrefsKey(arg_83_0)
	return (string.format("%s_%s_%s", PlayerPrefsKey.SeasonHeroGroupTrial, PlayerModel.instance:getMyUserId(), arg_83_0:getCurSeasonId()))
end

var_0_0.instance = var_0_0.New()

return var_0_0
