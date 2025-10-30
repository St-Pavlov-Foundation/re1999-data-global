module("modules.logic.permanent.view.enterview.Permanent1_7EnterView", package.seeall)

local var_0_0 = class("Permanent1_7EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	arg_1_0._goReddot1 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	arg_1_0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	arg_1_0._goReddot2 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/#btn_Play")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Achievement")
	arg_1_0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceRole1, arg_2_0._btnEntranceRole1OnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceRole2, arg_2_0._btnEntranceRole2OnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnPlay, arg_2_0._btnPlayOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnAchievement, arg_2_0._btnAchievementOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnEntranceDungeon, arg_2_0._btnEntranceDungeonOnClick, arg_2_0)
end

function var_0_0._btnEntranceRole1OnClick(arg_3_0)
	ActIsoldeController.instance:enterActivity()
end

function var_0_0._btnEntranceRole2OnClick(arg_4_0)
	ActMarcusController.instance:enterActivity()
end

function var_0_0._btnPlayOnClick(arg_5_0)
	local var_5_0 = {}

	var_5_0.isVersionActivityPV = true

	StoryController.instance:playStory(arg_5_0.actCfg.storyId, var_5_0)
end

function var_0_0._btnAchievementOnClick(arg_6_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function var_0_0._btnEntranceDungeonOnClick(arg_7_0)
	if DungeonModel.instance:chapterIsUnLock(106) then
		JumpController.instance:jumpTo("3#106", function()
			DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
		end)
	else
		JumpController.instance:jumpTo("5#1", arg_7_0.closeThis, arg_7_0)
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity1_7Enum.ActivityId.EnterView)

	gohelper.setActive(arg_9_0._btnAchievement.gameObject, false)
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = ActivityConfig.instance:getActivityCo(VersionActivity1_7Enum.ActivityId.Isolde)
	local var_10_1 = ActivityConfig.instance:getActivityCo(VersionActivity1_7Enum.ActivityId.Marcus)

	if var_10_0.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_10_0._goReddot1, var_10_0.redDotId, var_10_0.id)
	end

	if var_10_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_10_0._goReddot2, var_10_1.redDotId, var_10_1.id)
	end
end

function var_0_0.onClose(arg_11_0)
	PermanentModel.instance:undateActivityInfo(arg_11_0.actCfg.id)
end

return var_0_0
