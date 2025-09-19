module("modules.logic.versionactivity2_8.dungeonboss.model.VersionActivity2_8BossModel", package.seeall)

local var_0_0 = class("VersionActivity2_8BossModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._isFocusElement = false
	arg_2_0._bossStoryFightEpisodeId = nil
end

function var_0_0.setFocusElement(arg_3_0, arg_3_1)
	arg_3_0._isFocusElement = arg_3_1
end

function var_0_0.isFocusElement(arg_4_0)
	return arg_4_0._isFocusElement
end

function var_0_0.enterBossStoryFight(arg_5_0, arg_5_1)
	arg_5_0._bossStoryFightEpisodeId = arg_5_1
end

function var_0_0.getBossStoryFightEpisodeId(arg_6_0)
	return arg_6_0._bossStoryFightEpisodeId
end

function var_0_0.getStoryBossCurEpisodeId(arg_7_0)
	local var_7_0 = DungeonConfig.instance:getChapterEpisodeCOList(DungeonEnum.ChapterId.BossStory)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if not DungeonModel.instance:hasPassLevelAndStory(iter_7_1.id) then
			return iter_7_1.id
		end
	end

	return var_7_0[#var_7_0].id
end

var_0_0.instance = var_0_0.New()

return var_0_0
