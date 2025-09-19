module("modules.logic.versionactivity2_8.nuodika.config.NuoDiKaConfig", package.seeall)

local var_0_0 = class("NuoDiKaConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.reqConfigNames(arg_3_0)
	return {
		"activity_nuodika_180_const",
		"activity_nuodika_180_event",
		"activity_nuodika_180_enemy",
		"activity_nuodika_180_item",
		"activity_nuodika_180_skill"
	}
end

function var_0_0.getMapCo(arg_4_0, arg_4_1)
	local var_4_0 = addGlobalModule("modules.configs.nuodika.lua_nuodika_map_" .. tostring(arg_4_1), "lua_nuodika_map_" .. tostring(arg_4_1))

	if not var_4_0 then
		logError("诺谛卡地图配置不存在" .. arg_4_1)

		return
	end

	return var_4_0
end

function var_0_0.getEpisodeCoList(arg_5_0, arg_5_1)
	return (WuErLiXiConfig.instance:getEpisodeCoList(arg_5_1))
end

function var_0_0.getEpisodeCo(arg_6_0, arg_6_1, arg_6_2)
	return (WuErLiXiConfig.instance:getEpisodeCo(arg_6_1, arg_6_2))
end

function var_0_0.getTaskByActId(arg_7_0, arg_7_1)
	return (WuErLiXiConfig.instance:getTaskByActId(arg_7_1))
end

function var_0_0.getEventList(arg_8_0)
	return lua_activity_nuodika_180_event.configList
end

function var_0_0.getEventCo(arg_9_0, arg_9_1)
	return lua_activity_nuodika_180_event.configDict[arg_9_1]
end

function var_0_0.getEnemyList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(lua_activity_nuodika_180_enemy.configList) do
		if iter_10_1.main == NuoDiKaEnum.EnemyType.Normal then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.getMainRoleList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(lua_activity_nuodika_180_enemy.configList) do
		if iter_11_1.main == NuoDiKaEnum.EnemyType.MainRole then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_0.getEnemyCo(arg_12_0, arg_12_1)
	return lua_activity_nuodika_180_enemy.configDict[arg_12_1]
end

function var_0_0.getItemList(arg_13_0)
	return lua_activity_nuodika_180_item.configList
end

function var_0_0.getItemCo(arg_14_0, arg_14_1)
	return lua_activity_nuodika_180_item.configDict[arg_14_1]
end

function var_0_0.getConstCo(arg_15_0, arg_15_1)
	local var_15_0 = VersionActivity2_8Enum.ActivityId.NuoDiKa

	return lua_activity_nuodika_180_const.configDict[var_15_0][arg_15_1]
end

function var_0_0.getSkillCo(arg_16_0, arg_16_1)
	return lua_activity_nuodika_180_skill.configDict[arg_16_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
