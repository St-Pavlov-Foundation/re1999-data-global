module("modules.logic.main.view.MainActivityEnterView", package.seeall)

slot0 = class("MainActivityEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goGuideFight = gohelper.findChild(slot0.viewGO, "right/go_fight/#go_guidefight")
	slot0._goActivityFight = gohelper.findChild(slot0.viewGO, "right/go_fight/#go_activityfight")
	slot0._goNormalFight = gohelper.findChild(slot0.viewGO, "right/go_fight/#go_normalfight")
	slot0.btnGuideFight = gohelper.findButtonWithAudio(slot0._goGuideFight)
	slot0.btnNormalFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/go_fight/#go_normalfight/#btn_fight")
	slot0.btnJumpFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	slot0.txtChapter = gohelper.findChildText(slot0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/#txt_chapter")
	slot0.txtChapterName = gohelper.findChildText(slot0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight/#txt_chaptername")
	slot0.btnActivityFight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	slot0.btnEnterActivity = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight")
	slot0.simageActivityIcon = gohelper.findChildSingleImage(slot0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/icon")
	slot0.imageActivityIcon = slot0.simageActivityIcon:GetComponent(gohelper.Type_Image)
	slot0.goActivityRedDot = gohelper.findChild(slot0.viewGO, "right/go_fight/#go_activityfight/#btn_activefight/#go_activityreddot")
	slot0.pckeyActivityFight = gohelper.findChild(slot0.btnEnterActivity.gameObject, "#go_pcbtn")
	slot0.pckeyEnterFight = gohelper.findChild(slot0.btnActivityFight.gameObject, "#go_pcbtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnGuideFight:AddClickListener(slot0.btnGuideFightOnClick, slot0)
	slot0.btnNormalFight:AddClickListener(slot0.btnNormalFightOnClick, slot0)
	slot0.btnJumpFight:AddClickListener(slot0.btnJumpFightOnClick, slot0)
	slot0.btnActivityFight:AddClickListener(slot0.btnActivityFightOnClick, slot0)
	slot0.btnEnterActivity:AddClickListener(slot0.btnEnterActivityOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, slot0.OnNotifyEnterActivity, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnGuideFight:RemoveClickListener()
	slot0.btnNormalFight:RemoveClickListener()
	slot0.btnJumpFight:RemoveClickListener()
	slot0.btnActivityFight:RemoveClickListener()
	slot0.btnEnterActivity:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterActivityCenter, slot0.OnNotifyEnterActivity, slot0)
end

slot0.ShowFightGroupEnum = {
	Normal = 2,
	Activity = 3,
	Guide = 1
}
slot0.notOpenColor = Color.New(0.32, 0.32, 0.32, 0.91)

function slot0.btnGuideFightOnClick(slot0)
	slot0:enterDungeonView()
end

function slot0.btnNormalFightOnClick(slot0)
	slot0:enterDungeonView()
end

function slot0.btnActivityFightOnClick(slot0)
	slot0:enterDungeonView()
end

function slot0.btnJumpFightOnClick(slot0)
	if slot0._jumpParam then
		TeachNoteModel.instance:setJumpEnter(false)
		DungeonController.instance:jumpDungeon(slot0._jumpParam)
	end
end

function slot0.enterDungeonView(slot0)
	TeachNoteModel.instance:setJumpEnter(false)
	DungeonController.instance:enterDungeonView(true, true)
end

function slot0.btnEnterActivityOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.showActivityId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(slot2, slot3)

		return
	end

	if slot0:getActivityHandleFunc(slot0.showActivityId) then
		slot4(slot0)
	end
end

function slot0.OnNotifyEnterActivity(slot0)
	slot0:btnEnterActivityOnClick()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0.btnGuideFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0.btnNormalFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0.btnActivityFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0.btnJumpFight.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0.btnEnterActivity.gameObject, AudioEnum.UI.play_ui_admission_open)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivityState, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.refreshFastEnterDungeonUI, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshShowFightGroupEnum()
	slot0:refreshFightBtnGroup()
	slot0:refreshRedDot()
	slot0:refreshFastEnterDungeonUI()
	slot0:refreshActivityIcon()
	slot0:showKeyTips()
end

function slot0.refreshShowFightGroupEnum(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FastDungeon) then
		slot0.showFightGroupEnum = uv0.ShowFightGroupEnum.Guide

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(ActivityEnum.ShowVersionActivityEpisode) then
		slot0.showFightGroupEnum = uv0.ShowFightGroupEnum.Normal

		return
	end

	for slot5 = #ActivityEnum.VersionActivityIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(ActivityEnum.VersionActivityIdList[slot5]) == ActivityEnum.ActivityStatus.Normal or slot7 == ActivityEnum.ActivityStatus.NotUnlock then
			slot0.showActivityId = slot6
			slot0.showFightGroupEnum = uv0.ShowFightGroupEnum.Activity

			return
		end
	end

	slot0.showFightGroupEnum = uv0.ShowFightGroupEnum.Normal
end

function slot0.refreshFightBtnGroup(slot0)
	gohelper.setActive(slot0._goGuideFight, slot0.showFightGroupEnum == uv0.ShowFightGroupEnum.Guide)
	gohelper.setActive(slot0._goNormalFight, slot0.showFightGroupEnum == uv0.ShowFightGroupEnum.Normal)
	gohelper.setActive(slot0._goActivityFight, slot0.showFightGroupEnum == uv0.ShowFightGroupEnum.Activity)
end

function slot0.refreshRedDot(slot0)
	if slot0.showFightGroupEnum ~= uv0.ShowFightGroupEnum.Activity then
		return
	end

	if slot0.addRedDotActivityId and slot0.addRedDotActivityId == slot0.showActivityId then
		return
	end

	RedDotController.instance:addRedDot(slot0.goActivityRedDot, RedDotEnum.DotNode.VersionActivityEnterRedDot, nil, slot0.activityRedDotRefreshFunc, slot0)

	slot0.addRedDotActivityId = slot0.showActivityId
end

function slot0.refreshFastEnterDungeonUI(slot0)
	if slot0.showFightGroupEnum ~= uv0.ShowFightGroupEnum.Normal then
		slot0._jumpParam = nil

		return
	end

	slot1, slot2 = DungeonModel.instance:getLastEpisodeShowData()

	if slot1 then
		if slot1.id == slot0._showEpisodeId then
			return
		end

		slot0.txtChapter.text = DungeonController.getEpisodeName(slot1)
		slot0.txtChapterName.text = slot1.name
		slot0._jumpParam = slot0._jumpParam or {}
		slot0._jumpParam.chapterType = lua_chapter.configDict[slot1.chapterId].type
		slot0._jumpParam.chapterId = slot4
		slot0._jumpParam.episodeId = slot3
		slot0._showEpisodeId = slot3
	end
end

function slot0.activityRedDotRefreshFunc(slot0, slot1)
	if slot0:getEnterViewActIdList() then
		if ActivityStageHelper.checkActivityStageHasChange(slot2) then
			slot1.show = true

			slot1:showRedDot(RedDotEnum.Style.ObliqueNewTag)
			slot1:SetRedDotTrsWithType(RedDotEnum.Style.ObliqueNewTag, 40, -4.74)
			slot1:setRedDotTranLocalRotation(RedDotEnum.Style.ObliqueNewTag, 0, 0, -9)

			return
		end
	else
		logWarn(string.format("not found enter actI : %s map actId list", slot0.showActivityId))
	end

	slot1:setRedDotTranScale(RedDotEnum.Style.Normal, 1.5, 1.5)
	slot1:defaultRefreshDot()
end

function slot0.getEnterViewActIdList(slot0)
	if not slot0.enterActId2ActIdListDict then
		slot0.enterActId2ActIdListDict = {
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

	return slot0.enterActId2ActIdListDict[slot0.showActivityId]
end

function slot0.refreshActivityIcon(slot0)
	if slot0.showFightGroupEnum ~= uv0.ShowFightGroupEnum.Activity then
		return
	end

	slot0.simageActivityIcon:LoadImage(ResUrl.getMainActivityIcon(ActivityEnum.MainIcon[slot0.showActivityId]))

	if ActivityHelper.getActivityStatus(slot0.showActivityId) ~= ActivityEnum.ActivityStatus.Normal then
		slot0.imageActivityIcon.color = uv0.notOpenColor

		gohelper.setAsFirstSibling(slot0.btnEnterActivity.gameObject)
	else
		slot0.imageActivityIcon.color = Color.white

		gohelper.setAsLastSibling(slot0.btnEnterActivity.gameObject)
	end
end

function slot0.getActivityHandleFunc(slot0, slot1)
	if not slot0.activityHandleFuncDict then
		slot0.activityHandleFuncDict = {
			[ActivityEnum.VersionActivityIdDict.Activity1_1] = slot0.enterVersionActivity1_1,
			[ActivityEnum.VersionActivityIdDict.Activity1_2] = slot0.enterVersionActivity1_2,
			[ActivityEnum.VersionActivityIdDict.Activity1_3] = slot0.enterVersionActivity1_3,
			[ActivityEnum.VersionActivityIdDict.Activity1_41] = slot0.enterVersionActivity1_4,
			[ActivityEnum.VersionActivityIdDict.Activity1_42] = slot0.enterVersionActivity1_4,
			[ActivityEnum.VersionActivityIdDict.Activity1_51] = slot0.enterVersionActivity1_5,
			[ActivityEnum.VersionActivityIdDict.Activity1_52] = slot0.enterVersionActivity1_5,
			[ActivityEnum.VersionActivityIdDict.Activity1_6] = slot0.enterVersionActivity1_6,
			[ActivityEnum.VersionActivityIdDict.Activity1_7] = slot0.enterVersionActivity1_7,
			[ActivityEnum.VersionActivityIdDict.Activity1_8] = slot0.commonEnterVersionActivity,
			[ActivityEnum.VersionActivityIdDict.Activity1_9] = slot0.commonEnterVersionActivity,
			[ActivityEnum.VersionActivityIdDict.Activity2_0] = slot0.commonEnterVersionActivity,
			[ActivityEnum.VersionActivityIdDict.Activity2_1] = slot0.commonEnterVersionActivity,
			[ActivityEnum.VersionActivityIdDict.Activity2_2] = slot0.commonEnterVersionActivity
		}
	end

	return slot0.activityHandleFuncDict[slot1]
end

function slot0.getActivityEnterHandleFunc(slot0, slot1)
	if not slot0._activityEnterHandleFuncDict then
		slot0._activityEnterHandleFuncDict = {
			[ActivityEnum.VersionActivityIdDict.Activity1_8] = VersionActivity1_8EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity1_9] = VersionActivity1_9EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_0] = VersionActivity2_0EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_1] = VersionActivity2_1EnterController.instance,
			[ActivityEnum.VersionActivityIdDict.Activity2_2] = VersionActivity2_2EnterController.instance
		}
	end

	return slot0._activityEnterHandleFuncDict[slot1]
end

function slot0.getCurEnterController(slot0)
	return slot0:getActivityEnterHandleFunc(slot0.showActivityId)
end

function slot0.enterVersionActivity1_1(slot0)
	VersionActivityController.instance:openVersionActivityEnterView()
end

function slot0.enterVersionActivity1_2(slot0)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()
end

function slot0.enterVersionActivity1_3(slot0)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()
end

function slot0.enterVersionActivity1_4(slot0)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()
end

function slot0.enterVersionActivity1_5(slot0)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()
end

function slot0.enterVersionActivity1_6(slot0)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, , , true)
end

function slot0.enterVersionActivity1_7(slot0)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()
end

function slot0.commonEnterVersionActivity(slot0)
	slot0:getCurEnterController():openVersionActivityEnterView()
end

function slot0.onRefreshActivityState(slot0)
	slot0:refreshUI()
end

function slot0.onUpdateDungeonInfo(slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.simageActivityIcon:UnLoadImage()
end

function slot0.showKeyTips(slot0)
	if PlayerPrefsHelper.getNumber("keyTips", 0) == 1 then
		PCInputController.instance:showkeyTips(slot0.pckeyActivityFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.activityCenter)
		PCInputController.instance:showkeyTips(slot0.pckeyEnterFight, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Enter)
	end
end

return slot0
