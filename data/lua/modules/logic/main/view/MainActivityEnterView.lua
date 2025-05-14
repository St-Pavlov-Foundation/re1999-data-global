module("modules.logic.main.view.MainActivityEnterView", package.seeall)

local var_0_0 = class("MainActivityEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goGuideFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_guidefight")
	arg_1_0._goActivityFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_activityfight")
	arg_1_0._goNormalFight = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_normalfight")
	arg_1_0.btnGuideFight = gohelper.findButtonWithAudio(arg_1_0._goGuideFight)
	arg_1_0.btnNormalFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_fight")
	arg_1_0.btnJumpFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	arg_1_0.txtChapter = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/#txt_chapter")
	arg_1_0.txtChapterName = gohelper.findChildText(arg_1_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/#txt_chaptername")
	arg_1_0.btnActivityFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	arg_1_0.btnEnterActivity = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight")
	arg_1_0.simageActivityIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/icon")
	arg_1_0.imageActivityIcon = arg_1_0.simageActivityIcon:GetComponent(gohelper.Type_Image)
	arg_1_0.goActivityRedDot = gohelper.findChild(arg_1_0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/#go_activityreddot")
	arg_1_0.pckeyNormalFight = gohelper.findChild(arg_1_0.btnNormalFight.gameObject, "#go_pcbtn")
	arg_1_0.pckeyActivityFight = gohelper.findChild(arg_1_0.btnEnterActivity.gameObject, "#go_pcbtn")
	arg_1_0.pckeyEnterFight = gohelper.findChild(arg_1_0.btnActivityFight.gameObject, "#go_pcbtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnGuideFight:AddClickListener(arg_2_0.btnGuideFightOnClick, arg_2_0)
	arg_2_0.btnNormalFight:AddClickListener(arg_2_0.btnNormalFightOnClick, arg_2_0)
	arg_2_0.btnJumpFight:AddClickListener(arg_2_0.btnJumpFightOnClick, arg_2_0)
	arg_2_0.btnActivityFight:AddClickListener(arg_2_0.btnActivityFightOnClick, arg_2_0)
	arg_2_0.btnEnterActivity:AddClickListener(arg_2_0.btnEnterActivityOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, arg_2_0.OnNotifyEnterActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnGuideFight:RemoveClickListener()
	arg_3_0.btnNormalFight:RemoveClickListener()
	arg_3_0.btnJumpFight:RemoveClickListener()
	arg_3_0.btnActivityFight:RemoveClickListener()
	arg_3_0.btnEnterActivity:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, arg_3_0.OnNotifyEnterActivity, arg_3_0)
end

var_0_0.ShowFightGroupEnum = {
	Normal = 2,
	Activity = 3,
	Guide = 1
}
var_0_0.notOpenColor = Color.New(0.32, 0.32, 0.32, 0.91)

function var_0_0.btnGuideFightOnClick(arg_4_0)
	arg_4_0:enterDungeonView()
end

function var_0_0.btnNormalFightOnClick(arg_5_0)
	arg_5_0:enterDungeonView()
end

function var_0_0.btnActivityFightOnClick(arg_6_0)
	arg_6_0:enterDungeonView()
end

function var_0_0.btnJumpFightOnClick(arg_7_0)
	if arg_7_0._jumpParam then
		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon(arg_7_0._jumpParam)
	end
end

function var_0_0.enterDungeonView(arg_8_0)
	TeachNoteModel.instance:setJumpEnter(false)

	local var_8_0 = true

	DungeonController.instance:enterDungeonView(true, var_8_0)
end

function var_0_0.btnEnterActivityOnClick(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = ActivityHelper.getActivityStatusAndToast(arg_9_0.showActivityId)

	if var_9_0 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(var_9_1, var_9_2)

		return
	end

	local var_9_3 = arg_9_0:getActivityHandleFunc(arg_9_0.showActivityId)

	if var_9_3 then
		var_9_3(arg_9_0)
	end
end

function var_0_0.OnNotifyEnterActivity(arg_10_0)
	if arg_10_0.showActivityId ~= nil then
		arg_10_0:btnEnterActivityOnClick()
	end
end

function var_0_0._editableInitView(arg_11_0)
	gohelper.addUIClickAudio(arg_11_0.btnGuideFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_11_0.btnNormalFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_11_0.btnActivityFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_11_0.btnJumpFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_11_0.btnEnterActivity.gameObject, AudioEnum.UI.play_ui_admission_open)
	arg_11_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_11_0.onRefreshActivityState, arg_11_0)
	arg_11_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_11_0.refreshFastEnterDungeonUI, arg_11_0)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0:refreshShowFightGroupEnum()
	arg_13_0:refreshFightBtnGroup()
	arg_13_0:refreshRedDot()
	arg_13_0:refreshFastEnterDungeonUI()
	arg_13_0:refreshActivityIcon()
	arg_13_0:showKeyTips()
end

function var_0_0.refreshShowFightGroupEnum(arg_14_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		arg_14_0.showFightGroupEnum = var_0_0.ShowFightGroupEnum.Guide

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		arg_14_0.showFightGroupEnum = var_0_0.ShowFightGroupEnum.Normal

		return
	end

	for iter_14_0 = #ActivityEnum.VersionActivityIdList, 1, -1 do
		local var_14_0 = ActivityEnum.VersionActivityIdList[iter_14_0]
		local var_14_1 = ActivityHelper.getActivityStatus(var_14_0)

		if var_14_1 == ActivityEnum.ActivityStatus.Normal or var_14_1 == ActivityEnum.ActivityStatus.NotUnlock then
			arg_14_0.showActivityId = var_14_0
			arg_14_0.showFightGroupEnum = var_0_0.ShowFightGroupEnum.Activity

			return
		end
	end

	arg_14_0.showFightGroupEnum = var_0_0.ShowFightGroupEnum.Normal
end

function var_0_0.refreshFightBtnGroup(arg_15_0)
	gohelper.setActive(arg_15_0._goGuideFight, arg_15_0.showFightGroupEnum == var_0_0.ShowFightGroupEnum.Guide)
	gohelper.setActive(arg_15_0._goNormalFight, arg_15_0.showFightGroupEnum == var_0_0.ShowFightGroupEnum.Normal)
	gohelper.setActive(arg_15_0._goActivityFight, arg_15_0.showFightGroupEnum == var_0_0.ShowFightGroupEnum.Activity)
end

function var_0_0.refreshRedDot(arg_16_0)
	if arg_16_0.showFightGroupEnum ~= var_0_0.ShowFightGroupEnum.Activity then
		return
	end

	if arg_16_0.addRedDotActivityId and arg_16_0.addRedDotActivityId == arg_16_0.showActivityId then
		return
	end

	RedDotController.instance:addRedDot(arg_16_0.goActivityRedDot, RedDotEnum.DotNode.VersionActivityEnterRedDot, nil, arg_16_0.activityRedDotRefreshFunc, arg_16_0)

	arg_16_0.addRedDotActivityId = arg_16_0.showActivityId
end

function var_0_0.refreshFastEnterDungeonUI(arg_17_0)
	if arg_17_0.showFightGroupEnum ~= var_0_0.ShowFightGroupEnum.Normal then
		arg_17_0._jumpParam = nil

		return
	end

	local var_17_0, var_17_1 = DungeonModel.instance:getLastEpisodeShowData()

	if var_17_0 then
		local var_17_2 = var_17_0.id

		if var_17_2 == arg_17_0._showEpisodeId then
			return
		end

		local var_17_3 = var_17_0.chapterId
		local var_17_4 = lua_chapter.configDict[var_17_3]

		arg_17_0.txtChapter.text = DungeonController.getEpisodeName(var_17_0)
		arg_17_0.txtChapterName.text = var_17_0.name
		arg_17_0._jumpParam = arg_17_0._jumpParam or {}
		arg_17_0._jumpParam.chapterType = var_17_4.type
		arg_17_0._jumpParam.chapterId = var_17_3
		arg_17_0._jumpParam.episodeId = var_17_2
		arg_17_0._showEpisodeId = var_17_2
	end
end

function var_0_0.activityRedDotRefreshFunc(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getEnterViewActIdList()

	if var_18_0 then
		if ActivityStageHelper.checkActivityStageHasChange(var_18_0) then
			arg_18_1.show = true

			arg_18_1:showRedDot(RedDotEnum.Style.ObliqueNewTag)
			arg_18_1:SetRedDotTrsWithType(RedDotEnum.Style.ObliqueNewTag, 40, -4.74)
			arg_18_1:setRedDotTranLocalRotation(RedDotEnum.Style.ObliqueNewTag, 0, 0, -9)

			return
		end
	else
		logWarn(string.format("not found enter actI : %s map actId list", arg_18_0.showActivityId))
	end

	arg_18_1:setRedDotTranScale(RedDotEnum.Style.Normal, 1.5, 1.5)
	arg_18_1:defaultRefreshDot()
end

function var_0_0.getEnterViewActIdList(arg_19_0)
	if not arg_19_0.enterActId2ActIdListDict then
		arg_19_0.enterActId2ActIdListDict = {
			[ActivityEnum.VersionActivityIdDict.Activity1_1] = VersionActivityEnum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_2] = VersionActivity1_2Enum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_3] = VersionActivity1_3Enum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_41] = VersionActivity1_4Enum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_42] = VersionActivity1_4Enum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_51] = VersionActivity1_5Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity1_51],
			[ActivityEnum.VersionActivityIdDict.Activity1_52] = VersionActivity1_5Enum.EnterViewActIdListWithGroup[ActivityEnum.VersionActivityIdDict.Activity1_51],
			[ActivityEnum.VersionActivityIdDict.Activity1_6] = VersionActivity1_6Enum.EnterViewActIdList,
			[ActivityEnum.VersionActivityIdDict.Activity1_7] = VersionActivity1_7Enum.EnterViewActIdListWithRedDot,
			[ActivityEnum.VersionActivityIdDict.Activity1_8] = VersionActivity1_8Enum.EnterViewActIdListWithRedDot,
			[ActivityEnum.VersionActivityIdDict.Activity1_9] = VersionActivity1_9Enum.EnterViewActIdListWithRedDot
		}
	end

	return arg_19_0.enterActId2ActIdListDict[arg_19_0.showActivityId]
end

function var_0_0.refreshActivityIcon(arg_20_0)
	if arg_20_0.showFightGroupEnum ~= var_0_0.ShowFightGroupEnum.Activity then
		return
	end

	arg_20_0.simageActivityIcon:LoadImage(ResUrl.getMainActivityIcon(ActivityEnum.MainIcon[arg_20_0.showActivityId]))

	if ActivityHelper.getActivityStatus(arg_20_0.showActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		arg_20_0.imageActivityIcon.color = var_0_0.notOpenColor

		gohelper.setAsFirstSibling(arg_20_0.btnEnterActivity.gameObject)
	else
		arg_20_0.imageActivityIcon.color = Color.white

		gohelper.setAsLastSibling(arg_20_0.btnEnterActivity.gameObject)
	end
end

function var_0_0.getActivityHandleFunc(arg_21_0, arg_21_1)
	if not arg_21_0.activityHandleFuncDict then
		arg_21_0.activityHandleFuncDict = {
			[ActivityEnum.VersionActivityIdDict.Activity1_1] = arg_21_0.enterVersionActivity1_1,
			[ActivityEnum.VersionActivityIdDict.Activity1_2] = arg_21_0.enterVersionActivity1_2,
			[ActivityEnum.VersionActivityIdDict.Activity1_3] = arg_21_0.enterVersionActivity1_3,
			[ActivityEnum.VersionActivityIdDict.Activity1_41] = arg_21_0.enterVersionActivity1_4,
			[ActivityEnum.VersionActivityIdDict.Activity1_42] = arg_21_0.enterVersionActivity1_4,
			[ActivityEnum.VersionActivityIdDict.Activity1_51] = arg_21_0.enterVersionActivity1_5,
			[ActivityEnum.VersionActivityIdDict.Activity1_52] = arg_21_0.enterVersionActivity1_5,
			[ActivityEnum.VersionActivityIdDict.Activity1_6] = arg_21_0.enterVersionActivity1_6,
			[ActivityEnum.VersionActivityIdDict.Activity1_7] = arg_21_0.enterVersionActivity1_7
		}
	end

	return arg_21_0.activityHandleFuncDict[arg_21_1] or arg_21_0.commonEnterVersionActivity
end

function var_0_0.getActivityEnterHandleFunc(arg_22_0, arg_22_1)
	if not arg_22_0._activityEnterHandleFuncDict then
		arg_22_0._activityEnterHandleFuncDict = {
			[ActivityEnum.VersionActivityIdDict.Activity1_8] = VersionActivity1_8EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity1_9] = VersionActivity1_9EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_0] = VersionActivity2_0EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_1] = VersionActivity2_1EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_2] = VersionActivity2_2EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_3] = VersionActivity2_3EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_4] = VersionActivity2_4EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_5] = VersionActivity2_5EnterController.instance
		}
	end

	return arg_22_0._activityEnterHandleFuncDict[arg_22_1]
end

function var_0_0.getCurEnterController(arg_23_0)
	return arg_23_0:getActivityEnterHandleFunc(arg_23_0.showActivityId)
end

function var_0_0.enterVersionActivity1_1(arg_24_0)
	VersionActivityController.instance:openVersionActivityEnterView()
end

function var_0_0.enterVersionActivity1_2(arg_25_0)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()
end

function var_0_0.enterVersionActivity1_3(arg_26_0)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()
end

function var_0_0.enterVersionActivity1_4(arg_27_0)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()
end

function var_0_0.enterVersionActivity1_5(arg_28_0)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()
end

function var_0_0.enterVersionActivity1_6(arg_29_0)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, nil, nil, true)
end

function var_0_0.enterVersionActivity1_7(arg_30_0)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()
end

function var_0_0.commonEnterVersionActivity(arg_31_0)
	arg_31_0:getCurEnterController():openVersionActivityEnterView()
end

function var_0_0.onRefreshActivityState(arg_32_0)
	arg_32_0:refreshUI()
end

function var_0_0.onUpdateDungeonInfo(arg_33_0)
	arg_33_0:refreshUI()
end

function var_0_0.onClose(arg_34_0)
	return
end

function var_0_0.onDestroyView(arg_35_0)
	arg_35_0.simageActivityIcon:UnLoadImage()
end

function var_0_0.showKeyTips(arg_36_0)
	PCInputController.instance:showkeyTips(arg_36_0.pckeyActivityFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.activityCenter)
	PCInputController.instance:showkeyTips(arg_36_0.pckeyEnterFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
	PCInputController.instance:showkeyTips(arg_36_0.pckeyNormalFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
end

return var_0_0
