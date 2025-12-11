module("modules.logic.tower.model.TowerDeepGroupMo", package.seeall)

local var_0_0 = pureTable("TowerDeepGroupMo")

function var_0_0.init(arg_1_0)
	arg_1_0.teamsDataMap = {}
	arg_1_0.teamsDataList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.teamsDataMap = {}
	arg_2_0.teamsDataList = {}
end

function var_0_0.updateGroupData(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	arg_3_0.archiveId = 0
	arg_3_0.curDeep = arg_3_1.currDeep and arg_3_1.currDeep > 0 and arg_3_1.currDeep or TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)

	arg_3_0:updateTeamsInfo(arg_3_1)
end

function var_0_0.updateArchiveData(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0.archiveId = arg_4_1.archiveNo or 0
	arg_4_0.curDeep = arg_4_1.group and arg_4_1.group.currDeep > 0 and arg_4_1.group.currDeep or TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.StartDeepHigh)
	arg_4_0.createTime = arg_4_1.createTime and tonumber(arg_4_1.createTime) > 0 and tonumber(arg_4_1.createTime) / 1000 or ServerTime.now()

	arg_4_0:updateTeamsInfo(arg_4_1.group)
end

function var_0_0.updateTeamsInfo(arg_5_0, arg_5_1)
	arg_5_0.teamsDataMap = {}
	arg_5_0.teamsDataList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.teams) do
		local var_5_0 = {
			id = iter_5_1.teamNo,
			heroList = {}
		}

		for iter_5_2, iter_5_3 in ipairs(iter_5_1.heroes) do
			local var_5_1 = {
				heroId = iter_5_3.heroId,
				trialId = iter_5_3.trialId
			}

			table.insert(var_5_0.heroList, var_5_1)
		end

		var_5_0.deep = iter_5_1.deep
		arg_5_0.teamsDataMap[var_5_0.id] = var_5_0

		table.insert(arg_5_0.teamsDataList, var_5_0)
	end
end

function var_0_0.checkHasTeamData(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.teamsDataMap) do
		if iter_6_1.heroList and #iter_6_1.heroList > 0 then
			return true
		end
	end

	return false
end

function var_0_0.getTeamDataMap(arg_7_0)
	return arg_7_0.teamsDataMap
end

function var_0_0.getTeamDataList(arg_8_0)
	return arg_8_0.teamsDataList
end

function var_0_0.getAllHeroData(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.teamsDataList) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1.heroList) do
			table.insert(var_9_0, iter_9_3)
		end
	end

	return var_9_0
end

function var_0_0.getAllUsedHeroId(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.teamsDataList) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1.heroList) do
			if iter_10_3.heroId > 0 then
				table.insert(var_10_0, iter_10_3.heroId)
			elseif iter_10_3.trialId > 0 then
				local var_10_1 = lua_hero_trial.configDict[iter_10_3.trialId][0]

				table.insert(var_10_0, var_10_1.heroId)
			end
		end
	end

	return var_10_0
end

return var_0_0
