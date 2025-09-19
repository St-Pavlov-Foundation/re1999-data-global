module("modules.logic.permanent.view.enterview.Permanent2_1EnterView", package.seeall)

local var_0_0 = class("Permanent2_1EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnEntranceRole1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole1/#btn_EntranceRole1")
	arg_1_0._goReddot1 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole1/#go_Reddot1")
	arg_1_0._btnEntranceRole2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/EntranceRole2/#btn_EntranceRole2")
	arg_1_0._goReddot2 = gohelper.findChild(arg_1_0.viewGO, "Left/EntranceRole2/#go_Reddot2")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/#btn_Play")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Achievement")
	arg_1_0._btnEntranceDungeon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/EntranceDungeon/#btn_EntranceDungeon")
	arg_1_0._goReddot = gohelper.findChild(arg_1_0.viewGO, "Right/EntranceDungeon/#go_Reddot")

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
	arg_2_0:addEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_2_0._act165RedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity165Controller.instance, Activity165Event.refreshStoryReddot, arg_3_0._act165RedDot, arg_3_0)
end

local var_0_1 = {
	{
		actId = VersionActivity2_1Enum.ActivityId.LanShouPa,
		redDotId = RedDotEnum.DotNode.V2a1LanShouPaTaskRed
	},
	{
		actId = VersionActivity2_1Enum.ActivityId.Aergusi,
		redDotId = RedDotEnum.DotNode.V2a1AergusiTaskRed
	}
}

var_0_0.kRoleIndex2ActId = var_0_1

local function var_0_2(arg_4_0)
	local var_4_0 = var_0_1[arg_4_0]

	return var_4_0 and var_4_0.actId or 0
end

local function var_0_3(arg_5_0)
	local var_5_0 = var_0_1[arg_5_0]

	return var_5_0 and var_5_0.redDotId or 0
end

local function var_0_4(arg_6_0, arg_6_1)
	local var_6_0 = var_0_2(arg_6_1)
	local var_6_1 = ActivityConfig.instance:getActivityCo(var_6_0)
	local var_6_2 = var_0_3(arg_6_1) or var_6_1.redDotId

	RedDotController.instance:addRedDot(arg_6_0, var_6_2, var_6_0)
end

local function var_0_5(arg_7_0, arg_7_1)
	if arg_7_1 == nil then
		arg_7_1 = true
	end

	LanShouPaController.instance:openLanShouPaMapView(arg_7_0 or var_0_2(1), arg_7_1)
end

local function var_0_6(arg_8_0, arg_8_1)
	if arg_8_1 == nil then
		arg_8_1 = true
	end

	AergusiController.instance:openAergusiLevelView(arg_8_0 or var_0_2(2), arg_8_1)
end

function var_0_0._btnEntranceRole1OnClick(arg_9_0)
	var_0_5()
end

function var_0_0._btnEntranceRole2OnClick(arg_10_0)
	var_0_6()
end

function var_0_0._btnPlayOnClick(arg_11_0)
	local var_11_0 = {}

	var_11_0.isVersionActivityPV = true

	StoryController.instance:playStory(arg_11_0.actCfg.storyId, var_11_0)
end

function var_0_0._btnAchievementOnClick(arg_12_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			categoryType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function var_0_0._btnEntranceDungeonOnClick(arg_13_0)
	VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0.actCfg = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.EnterView)

	gohelper.setActive(arg_14_0._btnAchievement.gameObject, false)

	arg_14_0._commonRedDotIcon = RedDotController.instance:addRedDot(arg_14_0._goReddot, 0, 0, arg_14_0._act165RedDotOverrideRefreshFunc, arg_14_0)
end

function var_0_0.onOpen(arg_15_0)
	if arg_15_0.viewParam then
		local var_15_0 = arg_15_0.viewParam

		if var_15_0.isJumpAergusi then
			var_0_6(var_15_0.roleActId, var_15_0.roleActNeedReqInfo)
		elseif var_15_0.isJumpLanShouPa then
			var_0_5(var_15_0.roleActId, var_15_0.roleActNeedReqInfo)
		end
	end

	var_0_4(arg_15_0._goReddot1, 1)
	var_0_4(arg_15_0._goReddot2, 2)
end

function var_0_0.onClose(arg_16_0)
	PermanentModel.instance:undateActivityInfo(arg_16_0.actCfg.id)
end

function var_0_0._act165RedDotOverrideRefreshFunc(arg_17_0, arg_17_1)
	arg_17_1.show = Activity165Model.instance:isShowAct165Reddot()

	arg_17_1:showRedDot(RedDotEnum.Style.Normal)
end

function var_0_0._act165RedDot(arg_18_0)
	arg_18_0._commonRedDotIcon:refreshDot()
end

return var_0_0
