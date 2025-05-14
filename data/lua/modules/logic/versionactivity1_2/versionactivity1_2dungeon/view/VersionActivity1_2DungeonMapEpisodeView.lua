module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonMapEpisodeView", VersionActivity1_2DungeonMapEpisodeBaseView)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_1_0._onSetEpisodeListVisible, arg_1_0)
	arg_1_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.enterFight, arg_1_0._onEnterFight, arg_1_0)
end

function var_0_0._onSetEpisodeListVisible(arg_2_0, arg_2_1)
	return
end

function var_0_0.getLayoutClass(arg_3_0)
	return VersionActivity1_2DungeonMapChapterLayout.New()
end

function var_0_0.btnHardModeClick(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0:hardModelIsOpen()

	if not var_4_0 then
		GameFacade.showToast(var_4_1)

		return
	end

	arg_4_0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function var_0_0.hardModelIsOpen(arg_5_0)
	local var_5_0, var_5_1 = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)

	if not var_5_0 then
		return false, 10301, 1
	end

	local var_5_2 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)

	if not DungeonModel.instance:hasPassLevelAndStory(var_5_2[1].preEpisode) then
		return false, 10302, 2
	end

	return true
end

return var_0_0
