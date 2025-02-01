module("modules.logic.permanent.view.enterview.Permanent1_5EnterView", package.seeall)

slot0 = class("Permanent1_5EnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	slot0._goReddot1 = gohelper.findChild(slot0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	slot0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	slot0._goReddot2 = gohelper.findChild(slot0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/#btn_Play")
	slot0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	slot0._goReddot3 = gohelper.findChild(slot0.viewGO, "Right/#go_Reddot3")
	slot0._btnAchievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Achievement")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnEntranceRole1, slot0._btnEntranceRole1OnClick, slot0)
	slot0:addClickCb(slot0._btnEntranceRole2, slot0._btnEntranceRole2OnClick, slot0)
	slot0:addClickCb(slot0._btnPlay, slot0._btnPlayOnClick, slot0)
	slot0:addClickCb(slot0._btnEntranceDungeon, slot0._btnEntranceDungeonOnClick, slot0)
	slot0:addClickCb(slot0._btnAchievement, slot0._btnAchievementOnClick, slot0)
end

function slot0._btnEntranceRole1OnClick(slot0)
	AiZiLaController.instance:openMapView()
end

function slot0._btnEntranceRole2OnClick(slot0)
	Activity142Controller.instance:openMapView()
end

function slot0._btnPlayOnClick(slot0)
	StoryController.instance:playStory(slot0.actCfg.storyId)
end

function slot0._btnEntranceDungeonOnClick(slot0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._btnAchievementOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function slot0._editableInitView(slot0)
	slot0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.EnterView)

	gohelper.setActive(slot0._btnAchievement.gameObject, false)

	slot0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	slot0.originalStateId = AudioMgr.instance:getIdFromString("original")
	slot0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")
end

function slot0.onOpen(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.originalStateId)

	slot2 = ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.Activity142)

	if ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.AiZiLa).redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goReddot1, slot1.redDotId)
	end

	if slot2.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot0._goReddot2, slot2.redDotId)
	end

	RedDotController.instance:addMultiRedDot(slot0._goReddot3, {
		{
			id = RedDotEnum.DotNode.V1a5DungeonTask
		},
		{
			id = RedDotEnum.DotNode.V1a5DungeonRevivalTask
		},
		{
			id = RedDotEnum.DotNode.V1a5DungeonBuildTask
		}
	})
end

function slot0.onClose(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.accompanimentStateId)
	PermanentModel.instance:undateActivityInfo(slot0.actCfg.id)
end

return slot0
