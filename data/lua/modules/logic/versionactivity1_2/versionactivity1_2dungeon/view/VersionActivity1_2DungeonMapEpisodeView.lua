module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapEpisodeView", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapEpisodeView", VersionActivity1_2DungeonMapEpisodeBaseView)

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.enterFight, slot0._onEnterFight, slot0)
end

function slot0._onSetEpisodeListVisible(slot0, slot1)
end

function slot0.getLayoutClass(slot0)
	return VersionActivity1_2DungeonMapChapterLayout.New()
end

function slot0.btnHardModeClick(slot0)
	slot1, slot2 = slot0:hardModelIsOpen()

	if not slot1 then
		GameFacade.showToast(slot2)

		return
	end

	slot0:changeEpisodeMode(VersionActivity1_2DungeonEnum.DungeonMode.Hard)
end

function slot0.hardModelIsOpen(slot0)
	slot1, slot2 = VersionActivityConfig.instance:getAct113DungeonChapterIsOpen(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)

	if not slot1 then
		return false, 10301, 1
	end

	if not DungeonModel.instance:hasPassLevelAndStory(DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)[1].preEpisode) then
		return false, 10302, 2
	end

	return true
end

return slot0
