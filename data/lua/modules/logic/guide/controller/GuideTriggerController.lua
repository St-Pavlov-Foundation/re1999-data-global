module("modules.logic.guide.controller.GuideTriggerController", package.seeall)

slot0 = class("GuideTriggerController", BaseController)

function slot0.onInitFinish(slot0)
	slot0.triggers = {}

	slot0:_addTrigger(GuideTriggerPlayerLv.New("PlayerLv"))
	slot0:_addTrigger(GuideTriggerEpisodeFinish.New("EpisodeFinish"))
	slot0:_addTrigger(GuideTriggerWeekWalkLayerOpen.New("WeekWalkLayerOpen"))
	slot0:_addTrigger(GuideTriggerUnlockChapter.New("UnlockChapter"))
	slot0:_addTrigger(GuideTriggerFinishTask.New("FinishTask"))
	slot0:_addTrigger(GuideTriggerOpenView.New("OpenView"))
	slot0:_addTrigger(GuideTriggerOpenViewCondition.New("OpenViewCondition"))
	slot0:_addTrigger(GuideTriggerEnterScene.New("EnterScene"))
	slot0:_addTrigger(GuideTriggerEnterExplore.New("EnterExplore"))
	slot0:_addTrigger(GuideTriggerEnterEpisode.New("EnterEpisode"))
	slot0:_addTrigger(GuideTriggerRoomConfirmBuilding.New("RoomConfirmBuilding"))
	slot0:_addTrigger(GuideTriggerRoomOpenBuildingStrengthView.New("RoomOpenBuildingStrengthView"))
	slot0:_addTrigger(GuideTriggerRoomReset.New("RoomReset"))
	slot0:_addTrigger(GuideTriggerRoomEnterEdit.New("RoomEnterEdit"))
	slot0:_addTrigger(GuideTriggerFinishGuide.New("FinishGuide"))
	slot0:_addTrigger(GuideTriggerEpisodeFinishAndTalent.New("EpisodeFinishAndTalent"))
	slot0:_addTrigger(GuideTriggerEpisodeFinishWithOpen.New("EpisodeFinishWithOpen"))
	slot0:_addTrigger(GuideTriggerEpisodeFinishAndInMainScene.New("EpisodeFinishAndInMainScene"))
	slot0:_addTrigger(GuideTriggerRoomCheckGatherFactoryNum.New("RoomCheckGatherFactoryNum"))
	slot0:_addTrigger(GuideTriggerEpisodeAndGuideFinish.New("EpisodeAndGuideFinish"))
	slot0:_addTrigger(GuideTriggerEnterActivity109Chess.New("EnterActivity109Chess"))
	slot0:_addTrigger(GuideTriggerCachotEnterRoom.New("CachotEnterRoom"))
	slot0:_addTrigger(GuideTriggerMainSceneSkin.New("MainSceneSkin"))
	slot0:_addTrigger(GuideTriggerTalentStyle.New("TalentStyle"))
	slot0:_addTrigger(GuideTriggerChessGameGuideStart.New("ChessGameGuideStart"))
	slot0:_addTrigger(GuideTriggerElementFinish.New("ElementFinish"))
	slot0:_addTrigger(GuideTriggerRoomLv.New("RoomLv"))
	slot0:_addTrigger(GuideTriggerRoomTradeLv.New("RoomTradeLv"))
	slot0:_addTrigger(GuideTriggerDestinyStone.New("DestinyStone"))
	slot0:_addTrigger(GuideTriggerGuideEvent.New("GuideEvent"))
end

function slot0._addTrigger(slot0, slot1)
	table.insert(slot0.triggers, slot1)
end

function slot0.addConstEvents(slot0)
	GuideController.instance:registerCallback(GuideEvent.TriggerGuide, slot0._onTriggerGuide, slot0)
end

function slot0.onReset(slot0)
	for slot4 = 1, #slot0.triggers do
		slot0.triggers[slot4]:onReset()
	end
end

function slot0.startTrigger(slot0)
	for slot4 = 1, #slot0.triggers do
		slot0.triggers[slot4]:setCanTrigger(true)
		slot0.triggers[slot4]:checkStartGuide(nil, )
	end
end

function slot0._onTriggerGuide(slot0, slot1)
	for slot5 = 1, #slot0.triggers do
		slot0.triggers[slot5]:checkStartGuide(nil, slot1)
	end
end

function slot0.hasSatisfyGuide(slot0)
	for slot4 = 1, #slot0.triggers do
		if slot0.triggers[slot4]:hasSatisfyGuide() then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
