module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2NoteConfig", package.seeall)

local var_0_0 = class("VersionActivity1_2NoteConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity121_note",
		"activity121_story",
		"activity121_clue"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity121_note" then
		arg_3_0:_initNoteConfig()
	elseif arg_3_1 == "activity121_story" then
		arg_3_0:_initStoryConfig()
	end
end

function var_0_0._initNoteConfig(arg_4_0)
	arg_4_0._episodeId2Config = {}
	arg_4_0._noteCount = 0

	for iter_4_0, iter_4_1 in ipairs(lua_activity121_note.configList) do
		if not arg_4_0._episodeId2Config[iter_4_1.episodeId] then
			arg_4_0._episodeId2Config[iter_4_1.episodeId] = {}
		end

		table.insert(arg_4_0._episodeId2Config[iter_4_1.episodeId], iter_4_1)

		arg_4_0._noteCount = arg_4_0._noteCount + 1
	end
end

function var_0_0.getConfigList(arg_5_0, arg_5_1)
	return arg_5_0._episodeId2Config and arg_5_0._episodeId2Config[arg_5_1]
end

function var_0_0._initStoryConfig(arg_6_0)
	arg_6_0._storyList = {}

	for iter_6_0, iter_6_1 in ipairs(lua_activity121_story.configList) do
		arg_6_0._storyList[iter_6_1.id] = iter_6_1
	end

	table.sort(arg_6_0._storyList, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)
end

function var_0_0.getStoryList(arg_8_0)
	return arg_8_0._storyList
end

function var_0_0.getAllNoteCount(arg_9_0)
	return arg_9_0._noteCount
end

var_0_0.instance = var_0_0.New()

return var_0_0
