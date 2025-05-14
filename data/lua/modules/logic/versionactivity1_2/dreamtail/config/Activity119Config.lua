module("modules.logic.versionactivity1_2.dreamtail.config.Activity119Config", package.seeall)

local var_0_0 = class("Activity119Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity119_episode",
		"activity119_task"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onInit(arg_3_0)
	arg_3_0._dict = nil
end

function var_0_0.getConfig(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._dict then
		arg_4_0._dict = {}

		for iter_4_0, iter_4_1 in ipairs(lua_activity119_episode.configList) do
			if not arg_4_0._dict[iter_4_1.activityId] then
				arg_4_0._dict[iter_4_1.activityId] = {}
			end

			if not arg_4_0._dict[iter_4_1.activityId][iter_4_1.tabId] then
				arg_4_0._dict[iter_4_1.activityId][iter_4_1.tabId] = {
					taskList = {},
					tabId = iter_4_1.tabId
				}
			end

			local var_4_0 = DungeonConfig.instance:getEpisodeCO(iter_4_1.id)

			if DungeonConfig.instance:getChapterCO(var_4_0.chapterId).type == DungeonEnum.ChapterType.DreamTailHard then
				arg_4_0._dict[iter_4_1.activityId][iter_4_1.tabId].hardCO = iter_4_1
			else
				arg_4_0._dict[iter_4_1.activityId][iter_4_1.tabId].normalCO = iter_4_1
			end
		end

		for iter_4_2, iter_4_3 in ipairs(lua_activity119_task.configList) do
			arg_4_0._dict[iter_4_3.activityId][iter_4_3.tabId].taskList[iter_4_3.sort] = iter_4_3
		end
	end

	return arg_4_0._dict[arg_4_1][arg_4_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
