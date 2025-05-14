module("modules.logic.permanent.view.enterview.Permanent1_5EnterView", package.seeall)

local var_0_0 = class("Permanent1_5EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	arg_1_0._goReddot1 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	arg_1_0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	arg_1_0._goReddot2 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/#btn_Play")
	arg_1_0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	arg_1_0._goReddot3 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Reddot3")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Achievement")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceRole1, arg_2_0._btnEntranceRole1OnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceRole2, arg_2_0._btnEntranceRole2OnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnPlay, arg_2_0._btnPlayOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceDungeon, arg_2_0._btnEntranceDungeonOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnAchievement, arg_2_0._btnAchievementOnClick, arg_2_0)
end

function var_0_0._btnEntranceRole1OnClick(arg_3_0)
	AiZiLaController.instance:openMapView()
end

function var_0_0._btnEntranceRole2OnClick(arg_4_0)
	Activity142Controller.instance:openMapView()
end

function var_0_0._btnPlayOnClick(arg_5_0)
	StoryController.instance:playStory(arg_5_0.actCfg.storyId)
end

function var_0_0._btnEntranceDungeonOnClick(arg_6_0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnAchievementOnClick(arg_7_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.EnterView)

	gohelper.setActive(arg_8_0._btnAchievement.gameObject, false)

	arg_8_0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	arg_8_0.originalStateId = AudioMgr.instance:getIdFromString("original")
	arg_8_0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:setSwitch(arg_9_0.switchGroupId, arg_9_0.originalStateId)

	local var_9_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.AiZiLa)
	local var_9_1 = ActivityConfig.instance:getActivityCo(VersionActivity1_5Enum.ActivityId.Activity142)

	if var_9_0.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_9_0._goReddot1, var_9_0.redDotId)
	end

	if var_9_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_9_0._goReddot2, var_9_1.redDotId)
	end

	RedDotController.instance:addMultiRedDot(arg_9_0._goReddot3, {
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

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:setSwitch(arg_10_0.switchGroupId, arg_10_0.accompanimentStateId)
	PermanentModel.instance:undateActivityInfo(arg_10_0.actCfg.id)
end

return var_0_0
