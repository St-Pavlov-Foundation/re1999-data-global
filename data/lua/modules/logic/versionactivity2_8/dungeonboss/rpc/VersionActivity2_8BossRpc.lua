module("modules.logic.versionactivity2_8.dungeonboss.rpc.VersionActivity2_8BossRpc", package.seeall)

local var_0_0 = class("VersionActivity2_8BossRpc", BaseRpc)

function var_0_0.sendBossFightResetChapterRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = BossFightModule_pb.BossFightResetChapterRequest()

	var_1_0.chapterId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveBossFightResetChapterReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.chapterId

	DungeonModel.instance:resetEpisodeInfoByChapterId(DungeonEnum.ChapterId.BossStory)
	HeroGroupModel.instance:clearCustomHeroGroup(VersionActivity2_8BossEnum.HeroGroupId.First)
	HeroGroupModel.instance:clearCustomHeroGroup(VersionActivity2_8BossEnum.HeroGroupId.Second)
	DungeonController.instance:dispatchEvent(DungeonEvent.BossStoryReset)
end

var_0_0.instance = var_0_0.New()

return var_0_0
