module("modules.logic.guide.controller.GuideTriggerController", package.seeall)

local var_0_0 = class("GuideTriggerController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	arg_1_0.triggers = {}

	arg_1_0:_addTrigger(GuideTriggerPlayerLv.New("PlayerLv"))
	arg_1_0:_addTrigger(GuideTriggerEpisodeFinish.New("EpisodeFinish"))
	arg_1_0:_addTrigger(GuideTriggerWeekWalkLayerOpen.New("WeekWalkLayerOpen"))
	arg_1_0:_addTrigger(GuideTriggerUnlockChapter.New("UnlockChapter"))
	arg_1_0:_addTrigger(GuideTriggerFinishTask.New("FinishTask"))
	arg_1_0:_addTrigger(GuideTriggerOpenView.New("OpenView"))
	arg_1_0:_addTrigger(GuideTriggerOpenViewCondition.New("OpenViewCondition"))
	arg_1_0:_addTrigger(GuideTriggerEnterScene.New("EnterScene"))
	arg_1_0:_addTrigger(GuideTriggerEnterExplore.New("EnterExplore"))
	arg_1_0:_addTrigger(GuideTriggerEnterEpisode.New("EnterEpisode"))
	arg_1_0:_addTrigger(GuideTriggerRoomConfirmBuilding.New("RoomConfirmBuilding"))
	arg_1_0:_addTrigger(GuideTriggerRoomOpenBuildingStrengthView.New("RoomOpenBuildingStrengthView"))
	arg_1_0:_addTrigger(GuideTriggerRoomReset.New("RoomReset"))
	arg_1_0:_addTrigger(GuideTriggerRoomEnterEdit.New("RoomEnterEdit"))
	arg_1_0:_addTrigger(GuideTriggerFinishGuide.New("FinishGuide"))
	arg_1_0:_addTrigger(GuideTriggerEpisodeFinishAndTalent.New("EpisodeFinishAndTalent"))
	arg_1_0:_addTrigger(GuideTriggerEpisodeFinishWithOpen.New("EpisodeFinishWithOpen"))
	arg_1_0:_addTrigger(GuideTriggerEpisodeFinishAndInMainScene.New("EpisodeFinishAndInMainScene"))
	arg_1_0:_addTrigger(GuideTriggerRoomCheckGatherFactoryNum.New("RoomCheckGatherFactoryNum"))
	arg_1_0:_addTrigger(GuideTriggerEpisodeAndGuideFinish.New("EpisodeAndGuideFinish"))
	arg_1_0:_addTrigger(GuideTriggerEnterActivity109Chess.New("EnterActivity109Chess"))
	arg_1_0:_addTrigger(GuideTriggerCachotEnterRoom.New("CachotEnterRoom"))
	arg_1_0:_addTrigger(GuideTriggerMainSceneSkin.New("MainSceneSkin"))
	arg_1_0:_addTrigger(GuideTriggerTalentStyle.New("TalentStyle"))
	arg_1_0:_addTrigger(GuideTriggerChessGameGuideStart.New("ChessGameGuideStart"))
	arg_1_0:_addTrigger(GuideTriggerElementFinish.New("ElementFinish"))
	arg_1_0:_addTrigger(GuideTriggerRoomLv.New("RoomLv"))
	arg_1_0:_addTrigger(GuideTriggerRoomTradeLv.New("RoomTradeLv"))
	arg_1_0:_addTrigger(GuideTriggerDestinyStone.New("DestinyStone"))
	arg_1_0:_addTrigger(GuideTriggerStoryStep.New("StoryStep"))
	arg_1_0:_addTrigger(GuideTriggerGuideEvent.New("GuideEvent"))
	arg_1_0:_addTrigger(GuideTriggerOdysseyEpisodeFinish.New("OdysseyEpisodeFinish"))
end

function var_0_0._addTrigger(arg_2_0, arg_2_1)
	table.insert(arg_2_0.triggers, arg_2_1)
end

function var_0_0.addConstEvents(arg_3_0)
	GuideController.instance:registerCallback(GuideEvent.TriggerGuide, arg_3_0._onTriggerGuide, arg_3_0)
end

function var_0_0.onReset(arg_4_0)
	for iter_4_0 = 1, #arg_4_0.triggers do
		arg_4_0.triggers[iter_4_0]:onReset()
	end
end

function var_0_0.startTrigger(arg_5_0)
	for iter_5_0 = 1, #arg_5_0.triggers do
		arg_5_0.triggers[iter_5_0]:setCanTrigger(true)
		arg_5_0.triggers[iter_5_0]:checkStartGuide(nil, nil)
	end
end

function var_0_0._onTriggerGuide(arg_6_0, arg_6_1)
	for iter_6_0 = 1, #arg_6_0.triggers do
		arg_6_0.triggers[iter_6_0]:checkStartGuide(nil, arg_6_1)
	end
end

function var_0_0.hasSatisfyGuide(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.triggers do
		if arg_7_0.triggers[iter_7_0]:hasSatisfyGuide() then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
