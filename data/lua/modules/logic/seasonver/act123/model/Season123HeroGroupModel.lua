module("modules.logic.seasonver.act123.model.Season123HeroGroupModel", package.seeall)

local var_0_0 = class("Season123HeroGroupModel", BaseModel)

function var_0_0.release(arg_1_0)
	arg_1_0.curUnlockIndexSet = nil
	arg_1_0.curUnlockSlotSet = nil
	arg_1_0.animRecord = nil
	arg_1_0.multiplication = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.activityId = arg_2_1
	arg_2_0.layer = arg_2_2
	arg_2_0.episodeId = arg_2_3
	arg_2_0.stage = arg_2_4
	arg_2_0.multiplication = 1
	arg_2_0.unlockTweenKey = Activity123Enum.AnimRecord.UnlockTweenPos .. tostring(arg_2_0.stage)
	arg_2_0.animRecord = Season123UnlockLocalRecord.New()

	arg_2_0.animRecord:init(arg_2_0.activityId, PlayerPrefsKey.Season123UnlockAnimAlreadyPlay)
	arg_2_0:initUnlockIndex()
	arg_2_0:initMultiplication()
end

function var_0_0.initUnlockIndex(arg_3_0)
	arg_3_0.curUnlockIndexSet = {}
	arg_3_0.curUnlockSlotSet = {}

	local var_3_0 = DungeonConfig.instance:getEpisodeCO(arg_3_0.episodeId)

	if not var_3_0 then
		return
	end

	if var_3_0.type == DungeonEnum.EpisodeType.Season123 then
		if not Season123Model.instance:getActInfo(arg_3_0.activityId) then
			return
		end

		arg_3_0.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(arg_3_0.activityId)

		for iter_3_0, iter_3_1 in pairs(arg_3_0.curUnlockIndexSet) do
			arg_3_0.curUnlockIndexSet[iter_3_0] = true

			arg_3_0:checkAddUnlockSlot(iter_3_0)
		end
	end
end

function var_0_0.initMultiplication(arg_4_0)
	local var_4_0 = PlayerPrefsHelper.getNumber(arg_4_0:getMultiplicationKey(), 1)

	if arg_4_0:isEpisodeSeason123Retail() then
		local var_4_1 = arg_4_0:getMultiplicationTicket()

		arg_4_0.multiplication = math.min(var_4_0, var_4_1)
	else
		arg_4_0.multiplication = var_4_0
	end
end

function var_0_0.getMultiplicationKey(arg_5_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_5_0.episodeId)
end

function var_0_0.saveMultiplication(arg_6_0)
	PlayerPrefsHelper.setNumber(arg_6_0:getMultiplicationKey(), arg_6_0.multiplication)
end

function var_0_0.getMultiplicationTicket(arg_7_0)
	local var_7_0 = arg_7_0.activityId
	local var_7_1 = Season123Config.instance:getEquipItemCoin(var_7_0, Activity123Enum.Const.UttuTicketsCoin)

	if var_7_1 then
		local var_7_2 = CurrencyModel.instance:getCurrency(var_7_1)

		return var_7_2 and var_7_2.quantity or 0
	end

	return 0
end

function var_0_0.checkAddUnlockSlot(arg_8_0, arg_8_1)
	local var_8_0

	if arg_8_1 >= 1 and arg_8_1 <= Activity123Enum.MainCharPos then
		var_8_0 = 1
	elseif arg_8_1 > Activity123Enum.MainCharPos and arg_8_1 <= Activity123Enum.MainCharPos * 2 then
		var_8_0 = 2
	end

	if var_8_0 and not arg_8_0.curUnlockSlotSet[var_8_0] then
		arg_8_0.curUnlockSlotSet[var_8_0] = true
	end
end

function var_0_0.isSeasonChapter(arg_9_0)
	local var_9_0 = DungeonModel.instance.curSendEpisodeId

	if not var_9_0 or var_9_0 == 0 then
		return false
	end

	if DungeonConfig.instance:getEpisodeCO(var_9_0).type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function var_0_0.getMainPosEquipId(arg_10_0, arg_10_1)
	local var_10_0 = ModuleEnum.MaxHeroCountInGroup + 1
	local var_10_1 = HeroGroupModel.instance:getCurGroupMO()
	local var_10_2 = "-100000"

	if var_10_1 then
		if var_10_1.isReplay then
			local var_10_3 = var_10_1.replay_activity104Equip_data[var_10_2]

			if var_10_3 and var_10_3[arg_10_1] then
				return var_10_3[arg_10_1].equipId
			end
		else
			local var_10_4 = var_10_1.activity104Equips[var_10_0 - 1]

			if var_10_4 and var_10_4.equipUid[arg_10_1] then
				return var_0_0.instance:getItemIdByUid(var_10_4.equipUid[arg_10_1])
			end
		end
	end
end

function var_0_0.getItemIdByUid(arg_11_0, arg_11_1)
	local var_11_0 = Season123Model.instance:getActInfo(arg_11_0.activityId)

	if not var_11_0 then
		return 0
	end

	local var_11_1 = var_11_0:getItemIdByUid(arg_11_1)

	if not var_11_1 then
		return 0
	end

	return var_11_1
end

function var_0_0.buildAidHeroGroup(arg_12_0)
	local var_12_0 = Season123Model.instance:getBattleContext()

	if var_12_0 then
		local var_12_1 = var_12_0.actId

		if not Season123Model.instance:getActInfo(var_12_1) then
			return
		end

		local var_12_2 = HeroGroupModel.instance.battleConfig

		if not var_12_2 or string.nilorempty(var_12_2.aid) then
			return
		end

		if #string.splitToNumber(var_12_2.aid, "#") > 0 or var_12_2.trialLimit > 0 then
			local var_12_3 = {}

			for iter_12_0, iter_12_1 in ipairs(arg_12_0.heroGroupSnapshot) do
				var_12_3[iter_12_0] = HeroGroupModel.instance:generateTempGroup(iter_12_1)

				var_12_3[iter_12_0]:setTemp(false)
				Season123HeroGroupUtils.formation104Equips(var_12_3[iter_12_0])
			end

			arg_12_0.tempHeroGroupSnapshot = var_12_3
		end
	end
end

function var_0_0.getCurrentHeroGroup(arg_13_0)
	local var_13_0 = Season123Model.instance:getBattleContext()

	if not var_13_0 then
		return
	end

	local var_13_1 = Season123Model.instance:getActInfo(var_13_0.actId)

	if not var_13_1 then
		return
	end

	local var_13_2

	if var_0_0.instance:isEpisodeSeason123(var_13_0.episodeId) then
		var_13_2 = var_13_1.heroGroupSnapshotSubId
	else
		var_13_2 = 1
	end

	local var_13_3 = HeroGroupModel.instance.battleConfig

	if var_13_3 and not string.nilorempty(var_13_3.aid) and (#string.splitToNumber(var_13_3.aid, "#") > 0 or var_13_3.trialLimit > 0) then
		return arg_13_0.tempHeroGroupSnapshot[var_13_2]
	end

	if arg_13_0:isEpisodeSeason123Retail(var_13_0.episodeId) then
		return Season123Model.instance:getRetailHeroGroup(var_13_2)
	elseif arg_13_0:isEpisodeSeason123(var_13_0.episodeId) then
		return Season123Model.instance:getSnapshotHeroGroup(var_13_2)
	end
end

function var_0_0.isContainGroupCardUnlockTweenPos(arg_14_0, arg_14_1)
	local var_14_0 = Season123Config.instance:getSeasonEpisodeCo(arg_14_0.activityId, arg_14_0.stage, arg_14_0.layer - 1)

	if not var_14_0 then
		return true
	end

	local var_14_1 = string.splitToNumber(var_14_0.unlockEquipIndex, "#")

	if not tabletool.indexOf(var_14_1, arg_14_1) then
		return true
	end

	return arg_14_0.animRecord:contain(arg_14_1, arg_14_0.unlockTweenKey)
end

function var_0_0.saveGroupCardUnlockTweenPos(arg_15_0, arg_15_1)
	arg_15_0.animRecord:add(arg_15_1, arg_15_0.unlockTweenKey)
end

function var_0_0.isEquipCardPosUnlock(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = Season123Model.instance:getUnlockCardIndex(arg_16_2, arg_16_1)

	return arg_16_0.curUnlockIndexSet[var_16_0] == true
end

function var_0_0.isSlotNeedShow(arg_17_0, arg_17_1)
	return arg_17_0.curUnlockSlotSet[arg_17_1] == true
end

function var_0_0.isEpisodeSeason123(arg_18_0, arg_18_1)
	local var_18_0 = DungeonConfig.instance:getEpisodeCO(arg_18_1 or arg_18_0.episodeId)

	if var_18_0 and var_18_0.type == DungeonEnum.EpisodeType.Season123 then
		return true
	end

	return false
end

function var_0_0.isEpisodeSeason123Retail(arg_19_0, arg_19_1)
	local var_19_0 = DungeonConfig.instance:getEpisodeCO(arg_19_1 or arg_19_0.episodeId)

	if var_19_0 and var_19_0.type == DungeonEnum.EpisodeType.Season123Retail then
		return true
	end

	return false
end

function var_0_0.isCardPosLimit(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0, var_20_1 = Season123Config.instance:getCardLimitPosDict(arg_20_1)

	if var_20_0 == nil or var_20_0[arg_20_2 + 1] then
		return false
	end

	return true, var_20_1
end

function var_0_0.filterRule(arg_21_0, arg_21_1)
	local var_21_0 = Season123Config.instance:getSeasonConstStr(arg_21_0, Activity123Enum.Const.HideRule)
	local var_21_1 = string.splitToNumber(var_21_0, "#")
	local var_21_2 = {}

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		var_21_2[iter_21_1] = true
	end

	local var_21_3 = {}

	for iter_21_2, iter_21_3 in ipairs(arg_21_1) do
		local var_21_4 = iter_21_3[1]

		if not var_21_2[iter_21_3[2]] then
			table.insert(var_21_3, iter_21_3)
		end
	end

	return var_21_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
