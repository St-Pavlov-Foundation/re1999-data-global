module("modules.versionactivitybase.dungeon.model.VersionActivityDungeonBaseMo", package.seeall)

local var_0_0 = pureTable("VersionActivityDungeonBaseMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.actId = nil
	arg_1_0.chapterId = nil
	arg_1_0.episodeId = nil
	arg_1_0.mode = nil
	arg_1_0.activityDungeonConfig = nil
	arg_1_0.unlockHardModeEpisodeId = nil
	arg_1_0.layoutClass = nil
	arg_1_0.episodeItemCls = nil
	arg_1_0.layoutPrefabUrl = nil
	arg_1_0.layoutOffsetY = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.actId = arg_2_1
	arg_2_0.activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(arg_2_1)
	arg_2_0.unlockHardModeEpisodeId = arg_2_0:getUnlockActivityHardDungeonEpisodeId()

	if not arg_2_2 and not arg_2_3 then
		arg_2_0.chapterId = arg_2_0.activityDungeonConfig.story1ChapterId
	elseif arg_2_3 then
		arg_2_0.chapterId = DungeonConfig.instance:getEpisodeCO(arg_2_3).chapterId
	else
		arg_2_0.chapterId = arg_2_2
	end

	if arg_2_0.chapterId == arg_2_0.activityDungeonConfig.story2ChapterId or arg_2_0.chapterId == arg_2_0.activityDungeonConfig.story3ChapterId then
		arg_2_0.chapterId = arg_2_0.activityDungeonConfig.story1ChapterId
	end

	arg_2_0:updateMode()
	arg_2_0:updateEpisodeId(arg_2_3)
end

function var_0_0.update(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:init(arg_3_0.actId, arg_3_1, arg_3_2)
end

function var_0_0.getUnlockActivityHardDungeonEpisodeId(arg_4_0)
	local var_4_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_4_0.activityDungeonConfig.hardChapterId)

	return var_4_0 and #var_4_0 > 0 and var_4_0[1].preEpisode
end

function var_0_0.updateMode(arg_5_0)
	if arg_5_0.chapterId == arg_5_0.activityDungeonConfig.story1ChapterId then
		arg_5_0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story
	elseif arg_5_0.chapterId == arg_5_0.activityDungeonConfig.story2ChapterId then
		arg_5_0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story2
	elseif arg_5_0.chapterId == arg_5_0.activityDungeonConfig.story3ChapterId then
		arg_5_0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Story3
	elseif arg_5_0.chapterId == arg_5_0.activityDungeonConfig.hardChapterId then
		arg_5_0.mode = VersionActivityDungeonBaseEnum.DungeonMode.Hard
	end
end

function var_0_0.updateEpisodeId(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.episodeId = arg_6_1

		local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_0.episodeId)

		if var_6_0.chapterId == arg_6_0.activityDungeonConfig.story2ChapterId or var_6_0.chapterId == arg_6_0.activityDungeonConfig.story3ChapterId then
			while var_6_0.chapterId ~= arg_6_0.activityDungeonConfig.story1ChapterId do
				var_6_0 = DungeonConfig.instance:getEpisodeCO(var_6_0.preEpisode)
			end
		end

		arg_6_0.episodeId = var_6_0.id

		return
	end

	if DungeonModel.instance:hasPassAllChapterEpisode(arg_6_0.chapterId) then
		arg_6_0.episodeId = VersionActivityDungeonBaseController.instance:getChapterLastSelectEpisode(arg_6_0.chapterId)
	else
		local var_6_1 = DungeonConfig.instance:getChapterEpisodeCOList(arg_6_0.chapterId)
		local var_6_2

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			if iter_6_1 and DungeonModel.instance:getEpisodeInfo(iter_6_1.id) or nil then
				arg_6_0.episodeId = iter_6_1.id
			end
		end
	end
end

function var_0_0.changeMode(arg_7_0, arg_7_1)
	arg_7_0.mode = arg_7_1
	arg_7_0.chapterId = arg_7_0.activityDungeonConfig[VersionActivityDungeonBaseEnum.DungeonMode2ChapterIdKey[arg_7_0.mode]]

	arg_7_0:updateEpisodeId()
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnModeChange)
end

function var_0_0.changeEpisode(arg_8_0, arg_8_1)
	arg_8_0:updateEpisodeId(arg_8_1)
	VersionActivityDungeonBaseController.instance:dispatchEvent(VersionActivityDungeonEvent.OnActivityDungeonMoChange)
end

function var_0_0.isHardMode(arg_9_0)
	return arg_9_0.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard
end

function var_0_0.setLayoutClass(arg_10_0, arg_10_1)
	arg_10_0.layoutClass = arg_10_1
end

function var_0_0.getLayoutClass(arg_11_0)
	return arg_11_0.layoutClass or VersionActivityDungeonBaseChapterLayout
end

function var_0_0.setMapEpisodeItemClass(arg_12_0, arg_12_1)
	arg_12_0.episodeItemCls = arg_12_1
end

function var_0_0.getEpisodeItemClass(arg_13_0)
	return arg_13_0.episodeItemCls or VersionActivityDungeonBaseEpisodeItem
end

function var_0_0.setLayoutPrefabUrl(arg_14_0, arg_14_1)
	arg_14_0.layoutPrefabUrl = arg_14_1
end

function var_0_0.getLayoutPrefabUrl(arg_15_0)
	return arg_15_0.layoutPrefabUrl or "ui/viewres/dungeon/chaptermap/chaptermaplayout.prefab"
end

function var_0_0.setLayoutOffsetY(arg_16_0, arg_16_1)
	arg_16_0.layoutOffsetY = arg_16_1
end

function var_0_0.getLayoutOffsetY(arg_17_0)
	return arg_17_0.layoutOffsetY or 100
end

return var_0_0
