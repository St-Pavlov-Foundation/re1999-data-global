module("modules.logic.seasonver.act123.controller.Season123HeroGroupController", package.seeall)

local var_0_0 = class("Season123HeroGroupController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	Season123Controller.instance:registerCallback(Season123Event.HeroGroupIndexChanged, arg_1_0.handleHeroGroupIndexChanged, arg_1_0)
	FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_1_0.handleGetFightRecordGroupReply, arg_1_0)

	local var_1_0 = Season123Model.instance:getBattleContext()

	if var_1_0 then
		local var_1_1 = DungeonConfig.instance:getEpisodeCO(var_1_0.episodeId)

		if var_1_1 then
			HeroGroupTrialModel.instance:setTrialByBattleId(var_1_1.battleId)
		end
	end

	CharacterModel.instance:setAppendHeroMOs(nil)
	Season123HeroGroupModel.instance:init(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	Season123HeroGroupEditModel.instance:init(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	Season123HeroGroupQuickEditModel.instance:init(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
end

function var_0_0.onCloseView(arg_2_0)
	Season123Controller.instance:unregisterCallback(Season123Event.HeroGroupIndexChanged, arg_2_0.handleHeroGroupIndexChanged, arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0.handleGetFightRecordGroupReply, arg_2_0)
	arg_2_0:saveCurrentHeroGroup()
	CharacterModel.instance:setAppendHeroMOs(nil)
end

function var_0_0.checkSeason123HeroGroup(arg_3_0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_3_0 = Season123HeroGroupModel.instance.activityId
		local var_3_1 = Season123HeroGroupModel.instance.stage
		local var_3_2 = Season123HeroGroupModel.instance.layer

		var_0_0.checkHeroGroupAvailable(var_3_0, var_3_1, var_3_2)
	end
end

function var_0_0.changeReplayMode2Manual(arg_4_0)
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

	local var_4_0 = HeroGroupModel.instance:getCurGroupMO().id

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_4_0)

	local var_4_1 = Season123HeroGroupModel.instance.activityId
	local var_4_2 = Season123HeroGroupModel.instance.stage
	local var_4_3 = Season123HeroGroupModel.instance.layer

	var_0_0.instance:checkSeason123HeroGroup(var_4_1, var_4_2, var_4_3)
end

function var_0_0.switchHeroGroup(arg_5_0, arg_5_1)
	arg_5_0:saveCurrentHeroGroup()

	local var_5_0 = Season123HeroGroupModel.instance.activityId

	Activity123Rpc.instance:sendAct123ChangeFightGroupRequest(var_5_0, arg_5_1)
end

function var_0_0.saveCurrentHeroGroup(arg_6_0)
	local var_6_0 = Season123HeroGroupModel.instance.activityId

	if not var_6_0 then
		return
	end

	local var_6_1 = Season123Model.instance:getActInfo(var_6_0)

	if not var_6_1 then
		return
	end

	var_0_0.saveHeroGroup(var_6_0, var_6_1.heroGroupSnapshotSubId)
end

function var_0_0.saveHeroGroup(arg_7_0, arg_7_1)
	local var_7_0 = Season123Model.instance:getActInfo(arg_7_0)

	if not var_7_0 then
		return
	end

	local var_7_1

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		var_7_1 = var_7_0.heroGroupSnapshot[arg_7_1]
	elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		var_7_1 = var_7_0.retailHeroGroups[arg_7_1]
	end

	if not var_7_1 then
		return
	end

	var_0_0.instance:syncHeroGroup(var_7_1, var_7_0.heroGroupSnapshotSubId, arg_7_0)
end

function var_0_0.openHeroGroupView(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = Season123Model.instance:getBattleContext()

	if not var_8_0 then
		return
	end

	Season123HeroGroupModel.instance:init(var_8_0.actId, var_8_0.layer, var_8_0.episodeId, var_8_0.stage)
	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(arg_8_1, arg_8_2)

	local var_8_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_8_2 = DungeonModel.instance:getEpisodeInfo(arg_8_2)
	local var_8_3 = var_8_2 and var_8_2.star == DungeonEnum.StarType.Advanced and var_8_2.hasRecord
	local var_8_4 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_8_1 and var_8_3 and not string.nilorempty(var_8_4) and cjson.decode(var_8_4)[tostring(arg_8_2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_8_0.handleGetFightRecordGroupReply, arg_8_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(arg_8_2)

		return
	end

	Season123Controller.instance:openHeroGroupFightView({
		actId = var_8_0.actId,
		layer = var_8_0.layer,
		episodeId = var_8_0.episodeId,
		stage = var_8_0.stage
	})
end

function var_0_0.handleGetFightRecordGroupReply(arg_9_0, arg_9_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_9_0.handleGetFightRecordGroupReply, arg_9_0)
	HeroGroupModel.instance:setReplayParam(arg_9_1)

	local var_9_0 = Season123Model.instance:getBattleContext()

	if var_9_0 then
		Season123Controller.instance:openHeroGroupFightView({
			actId = var_9_0.actId,
			layer = var_9_0.layer,
			episodeId = var_9_0.episodeId,
			stage = var_9_0.stage
		})
	end
end

function var_0_0.changeEquipFromSelect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = Season123HeroGroupModel.instance.activityId
	local var_10_1 = {
		index = arg_10_1,
		equipUid = {}
	}

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		table.insert(var_10_1.equipUid, iter_10_1)
	end

	local var_10_2 = HeroGroupModel.instance:getCurGroupMO()

	var_10_2.equips[arg_10_1].equipUid = arg_10_2

	var_10_2:updatePosEquips(var_10_1)
	var_0_0.instance:syncHeroGroup(var_10_2, arg_10_0)
end

function var_0_0.checkUnloadHero(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_11_0.heroList then
		return
	end

	if not Season123Model.instance:getActInfo(arg_11_0) then
		return
	end

	local var_11_1 = false
	local var_11_2

	for iter_11_0, iter_11_1 in ipairs(var_11_0.heroList) do
		if iter_11_1 ~= Activity123Enum.EmptyUid then
			local var_11_3 = Season123Model.instance:getSeasonHeroMO(arg_11_0, arg_11_1, arg_11_2, iter_11_1)

			if var_11_3 == nil or var_11_3.hpRate == nil or var_11_3.hpRate <= 0 then
				if arg_11_3 then
					var_11_0.heroList[iter_11_0] = Activity123Enum.EmptyUid
				end

				var_11_2 = var_11_2 or {}
				var_11_2[iter_11_1] = true
				var_11_1 = true
			end
		end
	end

	return var_11_1, var_11_2
end

function var_0_0.checkUnlockLockPos(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_12_1 = Season123HeroGroupUtils.getUnlockSlotSet(arg_12_0)
	local var_12_2 = Season123Model.instance:getActInfo(arg_12_0)

	if not var_12_2 then
		return false
	end

	if not var_12_2:getStageMO(arg_12_1) then
		return false
	end

	local var_12_3 = false
	local var_12_4

	for iter_12_0, iter_12_1 in pairs(var_12_0.activity104Equips) do
		if iter_12_1.equipUid then
			for iter_12_2, iter_12_3 in pairs(iter_12_1.equipUid) do
				local var_12_5 = Season123Model.instance:getUnlockCardIndex(iter_12_1.index, iter_12_2)

				if not var_12_1[var_12_5] and not string.nilorempty(iter_12_3) and iter_12_3 ~= Activity123Enum.EmptyUid then
					iter_12_1.equipUid[iter_12_2] = Activity123Enum.EmptyUid
					var_12_4 = var_12_4 or {}

					table.insert(var_12_4, var_12_5)

					var_12_3 = true
				end
			end
		end
	end

	return var_12_3
end

function var_0_0.checkHeroGroupAvailable(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = var_0_0.checkEquipClothSkill()
	local var_13_1 = var_0_0.checkUnloadHero(arg_13_0, arg_13_1, arg_13_2, true)
	local var_13_2 = var_0_0.checkUnlockLockPos(arg_13_0, arg_13_1, arg_13_2)

	if var_13_1 or var_13_2 or var_13_0 then
		local var_13_3 = HeroGroupModel.instance:getCurGroupMO()
		local var_13_4 = Season123Model.instance:getActInfo(arg_13_0)

		if not var_13_4 or not var_13_3 then
			return
		end

		logNormal(string.format("season heroGroupId = [%s] role need unload.", var_13_4.heroGroupSnapshotSubId))
		var_0_0.instance:syncHeroGroup(var_13_3, var_13_4.heroGroupSnapshotSubId, arg_13_0)
	end
end

function var_0_0.syncHeroGroup(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	Season123HeroGroupModel.instance.lastSyncGroupActId = arg_14_3 or Season123HeroGroupModel.instance.activityId

	local var_14_0 = HeroGroupModel.instance:getCurGroupMO()

	if var_14_0 == arg_14_1 then
		HeroSingleGroupModel.instance:setSingleGroup(var_14_0, true)
	end

	local var_14_1 = {
		groupIndex = arg_14_2,
		heroGroup = arg_14_1
	}

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123, DungeonModel.instance.curSendEpisodeId, true, var_14_1)
	elseif Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season123Retail, DungeonModel.instance.curSendEpisodeId, true, var_14_1)
	end
end

function var_0_0.handleHeroGroupIndexChanged(arg_15_0)
	local var_15_0 = Season123HeroGroupModel.instance.activityId
	local var_15_1 = Season123HeroGroupModel.instance.stage
	local var_15_2 = Season123HeroGroupModel.instance.layer

	arg_15_0:checkSeason123HeroGroup()

	local var_15_3 = Season123Model.instance:getActInfo(var_15_0)

	if var_15_3 and HeroGroupModel.instance:getCurGroupMO() == var_15_3:getCurHeroGroup() then
		HeroGroupModel.instance:setCurGroupId(HeroGroupModel.instance:getCurGroupId())
	end
end

function var_0_0.sendStartAct123Battle(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)
	local var_16_0 = Season123HeroGroupModel.instance.activityId
	local var_16_1 = Season123HeroGroupModel.instance.layer

	if Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		var_16_1 = -1
	end

	Activity123Rpc.instance:sendStartAct123BattleRequest(var_16_0, var_16_1, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7, arg_16_8, arg_16_9)
end

function var_0_0.replaceHeroesDefaultEquip(arg_17_0, arg_17_1)
	local var_17_0 = Season123HeroGroupModel.instance.activityId
	local var_17_1 = HeroGroupModel.instance:getCurGroupMO().equips
	local var_17_2

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_3 = Season123HeroUtils.getHeroMO(var_17_0, iter_17_1, Season123HeroGroupModel.instance.stage)

		if var_17_3 and var_17_3:hasDefaultEquip() then
			for iter_17_2, iter_17_3 in pairs(var_17_1) do
				if iter_17_3.equipUid[1] == var_17_3.defaultEquipUid then
					iter_17_3.equipUid[1] = "0"

					break
				end
			end

			var_17_1[iter_17_0 - 1].equipUid[1] = var_17_3.defaultEquipUid
		end
	end
end

function var_0_0.setMultiplication(arg_18_0, arg_18_1)
	if arg_18_1 <= Season123HeroGroupModel.instance:getMultiplicationTicket() then
		Season123HeroGroupModel.instance.multiplication = arg_18_1

		Season123HeroGroupModel.instance:saveMultiplication()
	end
end

function var_0_0.checkEquipClothSkill()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_19_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_19_0.clothId) then
		return
	end

	local var_19_1 = PlayerClothModel.instance:getList()

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if PlayerClothModel.instance:hasCloth(iter_19_1.id) then
			HeroGroupModel.instance:replaceCloth(iter_19_1.id)

			return true
		end
	end
end

function var_0_0.processReplayGroupMO(arg_20_0)
	if arg_20_0.isReplay then
		local var_20_0 = arg_20_0.replay_activity104Equip_data["-100000"]
		local var_20_1 = arg_20_0.activity104Equips[Activity123Enum.MainCharPos]

		if var_20_0 and var_20_1 then
			for iter_20_0 = 1, #var_20_0 do
				var_20_1.equipUid[iter_20_0] = var_20_0[iter_20_0].equipUid
			end
		end

		Season123HeroGroupUtils.formation104Equips(arg_20_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
