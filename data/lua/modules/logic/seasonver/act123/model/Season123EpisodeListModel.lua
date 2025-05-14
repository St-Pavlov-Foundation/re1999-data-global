module("modules.logic.seasonver.act123.model.Season123EpisodeListModel", package.seeall)

local var_0_0 = class("Season123EpisodeListModel", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0._loadingRecordMap = nil
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.release(arg_3_0)
	arg_3_0.activityId = nil
	arg_3_0.stage = nil
	arg_3_0.lastSendEpisodeCfg = nil
	arg_3_0.curSelectLayer = nil

	arg_3_0:clear()
end

function var_0_0.init(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.activityId = arg_4_1
	arg_4_0.stage = arg_4_2

	arg_4_0:initEpisodeList()
	arg_4_0:initSelectLayer()
end

function var_0_0.initEpisodeList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = Season123Config.instance:getSeasonEpisodeByStage(arg_5_0.activityId, arg_5_0.stage)

	logNormal("episode list length : " .. tostring(#var_5_1))

	local var_5_2 = Season123Model.instance:getActInfo(arg_5_0.activityId):getStageMO(arg_5_0.stage)

	if var_5_2 then
		for iter_5_0 = 1, #var_5_1 do
			local var_5_3 = var_5_1[iter_5_0]
			local var_5_4 = var_5_2.episodeMap[var_5_3.layer]
			local var_5_5 = Season123EpisodeListMO.New()

			var_5_5:init(var_5_4, var_5_3)
			table.insert(var_5_0, var_5_5)
		end
	end

	arg_5_0:setList(var_5_0)
end

function var_0_0.initSelectLayer(arg_6_0)
	arg_6_0.curSelectLayer = arg_6_0:getCurrentChallengeLayer()
end

function var_0_0.isEpisodeUnlock(arg_7_0, arg_7_1)
	local var_7_0 = Season123Model.instance:getActInfo(arg_7_0.activityId)

	if arg_7_0:getById(arg_7_1).isFinished then
		return true
	end

	if arg_7_1 <= 1 then
		if not var_7_0 then
			return false
		end

		return arg_7_0.stage == var_7_0.stage
	end

	local var_7_1 = arg_7_0:getById(arg_7_1 - 1)

	if not var_7_1 or not var_7_1.isFinished then
		return false
	end

	return true
end

function var_0_0.inCurrentStage(arg_8_0)
	local var_8_0 = Season123Model.instance:getActInfo(arg_8_0.activityId)

	return var_8_0 ~= nil and not var_8_0:isNotInStage() and var_8_0.stage == var_0_0.instance.stage
end

function var_0_0.getCurrentChallengeLayer(arg_9_0)
	local var_9_0 = arg_9_0:getList()

	if not var_9_0 or #var_9_0 <= 0 then
		return 0
	end

	for iter_9_0 = 1, #var_9_0 do
		if not var_9_0[iter_9_0].isFinished then
			return iter_9_0
		end
	end

	return var_9_0[#var_9_0].cfg.layer
end

function var_0_0.getEnemyCareerList(arg_10_0, arg_10_1)
	local var_10_0 = FightParam.New()

	var_10_0:setEpisodeId(arg_10_1)

	local var_10_1 = {}
	local var_10_2 = {}
	local var_10_3 = {}
	local var_10_4 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0.monsterGroupIds) do
		local var_10_5 = lua_monster_group.configDict[iter_10_1].bossId
		local var_10_6 = string.splitToNumber(lua_monster_group.configDict[iter_10_1].monster, "#")

		for iter_10_2, iter_10_3 in ipairs(var_10_6) do
			local var_10_7 = lua_monster.configDict[iter_10_3].career

			if iter_10_3 == var_10_5 then
				var_10_1[var_10_7] = (var_10_1[var_10_7] or 0) + 1

				table.insert(var_10_4, iter_10_3)
			else
				var_10_2[var_10_7] = (var_10_2[var_10_7] or 0) + 1

				table.insert(var_10_3, iter_10_3)
			end
		end
	end

	local var_10_8 = {}

	for iter_10_4, iter_10_5 in pairs(var_10_1) do
		table.insert(var_10_8, {
			career = iter_10_4,
			count = iter_10_5
		})
	end

	local var_10_9 = #var_10_8

	for iter_10_6, iter_10_7 in pairs(var_10_2) do
		table.insert(var_10_8, {
			career = iter_10_6,
			count = iter_10_7
		})
	end

	return var_10_8, var_10_9
end

function var_0_0.setSelectLayer(arg_11_0, arg_11_1)
	arg_11_0.curSelectLayer = arg_11_1
end

function var_0_0.cleanPlayLoadingAnimRecord(arg_12_0, arg_12_1)
	if not arg_12_0._loadingRecordMap then
		return
	end

	arg_12_0._loadingRecordMap = arg_12_0._loadingRecordMap or {}
	arg_12_0._loadingRecordMap[arg_12_1] = nil
end

function var_0_0.savePlayLoadingAnimRecord(arg_13_0, arg_13_1)
	arg_13_0._loadingRecordMap = arg_13_0._loadingRecordMap or {}
	arg_13_0._loadingRecordMap[arg_13_1] = true
end

function var_0_0.isLoadingAnimNeedPlay(arg_14_0, arg_14_1)
	return arg_14_0._loadingRecordMap == nil or arg_14_0._loadingRecordMap[arg_14_1] == nil
end

function var_0_0.stageIsPassed(arg_15_0)
	local var_15_0 = Season123Model.instance:getActInfo(arg_15_0.activityId)

	if not var_15_0 then
		return false
	end

	local var_15_1 = var_15_0.stageMap[arg_15_0.stage]

	return var_15_1 and var_15_1.isPass
end

var_0_0.instance = var_0_0.New()

return var_0_0
