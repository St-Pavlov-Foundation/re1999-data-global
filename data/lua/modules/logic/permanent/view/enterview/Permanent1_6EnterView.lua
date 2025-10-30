module("modules.logic.permanent.view.enterview.Permanent1_6EnterView", package.seeall)

local var_0_0 = class("Permanent1_6EnterView", BaseView)

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
	ActQuNiangController.instance:enterActivity()
end

function var_0_0._btnEntranceRole2OnClick(arg_4_0)
	ActGeTianController.instance:enterActivity()
end

function var_0_0._btnPlayOnClick(arg_5_0)
	local var_5_0 = {}

	var_5_0.isVersionActivityPV = true

	StoryController.instance:playStory(arg_5_0.actCfg.storyId, var_5_0)
end

function var_0_0._btnEntranceDungeonOnClick(arg_6_0)
	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
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
	arg_8_0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.EnterView)

	gohelper.setActive(arg_8_0._btnAchievement.gameObject, false)
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Role1)
	local var_9_1 = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Role2)

	if var_9_0.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_9_0._goReddot1, var_9_0.redDotId, VersionActivity1_6Enum.ActivityId.Role1)
	end

	if var_9_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_9_0._goReddot2, var_9_1.redDotId, VersionActivity1_6Enum.ActivityId.Role2)
	end

	RedDotController.instance:addMultiRedDot(arg_9_0._goReddot3, {
		{
			id = RedDotEnum.DotNode.V1a6DungeonTask
		},
		{
			id = RedDotEnum.DotNode.V1a6DungeonSkillPoint
		},
		{
			id = RedDotEnum.DotNode.V1a6DungeonBossReward
		}
	})
	arg_9_0:modifyBgm()
end

function var_0_0.modifyBgm(arg_10_0)
	local var_10_0 = DungeonEnum.ModifyBgmEpisodeId

	if DungeonModel.instance:hasPassLevelAndStory(var_10_0) then
		AudioBgmManager.instance:modifyBgm(AudioBgmEnum.Layer.VersionActivity1_6Dungeon, AudioEnum.Bgm.Act1_6DungeonBgm2, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	end
end

function var_0_0.onClose(arg_11_0)
	PermanentModel.instance:undateActivityInfo(arg_11_0.actCfg.id)
end

return var_0_0
