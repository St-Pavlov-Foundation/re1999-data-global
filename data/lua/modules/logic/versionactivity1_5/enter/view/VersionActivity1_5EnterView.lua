module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterView", package.seeall)

slot0 = class("VersionActivity1_5EnterView", VersionActivityEnterBaseViewWithGroup)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "logo/Time/timebg/#txt_remaintime")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/Time/#txt_time")
	slot0.txtDungeonStoreNum1 = gohelper.findChildText(slot0.viewGO, "entrance/#go_group1/activityContainer4/normal/#txt_num")
	slot0.txtDungeonStoreNum2 = gohelper.findChildText(slot0.viewGO, "entrance/#go_group2/activityContainer10/normal/#txt_num")
	slot0.txtDungeonStoreRemainTime1 = gohelper.findChildText(slot0.viewGO, "entrance/#go_group1/activityContainer4/#go_time/#txt_time")
	slot0.txtDungeonStoreRemainTime2 = gohelper.findChildText(slot0.viewGO, "entrance/#go_group2/activityContainer10/#go_time/#txt_time")
	slot0._btnseasonstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#go_group2/#btn_seasonstore")
	slot0._txtseasonstorenum = gohelper.findChildText(slot0.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/storeBG/#txt_num")
	slot0._txtseasonstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/#go_bg1/#txt_time")
	slot0._btnachievementpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0.gobg1 = gohelper.findChild(slot0.viewGO, "bg1")
	slot0.gobg2 = gohelper.findChild(slot0.viewGO, "bg2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnseasonstore:AddClickListener(slot0._btnseasonstoreOnClick, slot0)
	slot0._btnachievementpreview:AddClickListener(slot0._btnachievementpreviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnseasonstore:RemoveClickListener()
	slot0._btnachievementpreview:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0._btnseasonstoreOnClick(slot0)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(Activity104Enum.SeasonStore[Activity104Model.instance:getCurSeasonId()])

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToast(slot4, slot5)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function slot0._btnachievementpreviewOnClick(slot0)
	if ActivityConfig.instance:getActivityCo(slot0.actId) and slot1.achievementGroup ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(slot0.actId, slot1.achievementGroup)
	end
end

function slot0.refreshSingleBgUI(slot0)
	gohelper.setActive(slot0.gobg1, slot0.showGroupIndex == 1)
	gohelper.setActive(slot0.gobg2, slot0.showGroupIndex == 2)
end

function slot0.onClickActivity1(slot0)
	Activity142Controller.instance:openMapView()
end

function slot0.onClickActivity2(slot0)
	BossRushController.instance:openMainView()
end

function slot0.onClickActivity3(slot0)
	SportsNewsController.instance:openSportsNewsMainView()
end

function slot0.onClickActivity4(slot0)
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function slot0.onClickActivity5(slot0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.onClickActivity6(slot0)
	PeaceUluController.instance:openPeaceUluView()
end

function slot0.onClickActivity7(slot0)
	BossRushController.instance:openMainView()
end

function slot0.onClickActivity8(slot0)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0.onClickActivity9(slot0)
	AiZiLaController.instance:openMapView()
end

function slot0.onClickActivity10(slot0)
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function slot0.onClickActivity11(slot0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.singleBgUI(slot0)
end

function slot0.refreshUI(slot0)
	uv0.super.refreshUI(slot0)
	slot0:refreshEnterViewTime()
	slot0:updateAchievementBtnVisible()
	slot0:refreshSeasonStore()
	slot0:refreshCurrency()
	slot0:refreshDungeonStoreTime()
end

function slot0.refreshEnterViewTime(slot0)
	slot0:refreshDurationTime()
	slot0:refreshRemainTime()
end

function slot0.refreshCurrency(slot0)
	slot2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon) and slot1.quantity or 0
	slot0.txtDungeonStoreNum1.text = slot2
	slot0.txtDungeonStoreNum2.text = slot2
end

function slot0.refreshDungeonStoreTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.DungeonStore]:getRealEndTimeStamp() - ServerTime.now() then
		slot5 = Mathf.Floor(slot3 / TimeUtil.OneDaySecond) .. "d"
		slot0.txtDungeonStoreRemainTime1.text = slot5
		slot0.txtDungeonStoreRemainTime2.text = slot5

		return
	end

	if TimeUtil.OneHourSecond < slot3 then
		slot5 = Mathf.Floor(slot3 / TimeUtil.OneHourSecond) .. "h"
		slot0.txtDungeonStoreRemainTime1.text = slot5
		slot0.txtDungeonStoreRemainTime2.text = slot5

		return
	end

	slot0.txtDungeonStoreRemainTime1.text = "1h"
	slot0.txtDungeonStoreRemainTime2.text = "1h"
end

function slot0.refreshRemainTime(slot0)
	slot0._txtremaintime.text = formatLuaLang("remain", ActivityModel.instance:getActivityInfo()[slot0.actId]:getRemainTimeStr3())
end

function slot0.refreshDurationTime(slot0)
	slot1 = ActivityModel.instance:getActivityInfo()[slot0.actId]

	if slot0._txttime then
		slot0._txttime.text = slot1:getStartTimeStr() .. " ~ " .. slot1:getEndTimeStr()
	end
end

function slot0.everyMinuteCall(slot0)
	uv0.super.everyMinuteCall(slot0)
	slot0:refreshRemainTime()
	slot0:refreshDungeonStoreTime()
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0.onRefreshActivity8(slot0, slot1)
	slot3 = ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot1.goNormal, "week"), slot3 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "score"), slot3)

	if slot3 and Activity104Model.instance:tryGetActivityInfo(slot1.actId, slot0.checkNeedRefreshUI, slot0) then
		gohelper.setActive(gohelper.findChildImage(slot1.rootGo, "normal/score/stage7"), Activity104Model.instance:getAct104CurStage() == 7)

		for slot11 = 1, 7 do
			UISpriteSetMgr.instance:setV1a5EnterViewSprite(gohelper.findChildImage(slot1.rootGo, "normal/score/stage" .. slot11), slot11 <= slot6 and "v1a5_enterview_scorefg" or "v1a5_enterview_scorebg", true)
		end
	end

	if GameConfig:GetCurLangType() ~= LangSettings.zh then
		slot6 = gohelper.findChild(slot1.goNormal, "txt_Activity2")

		transformhelper.setLocalPosXY(slot6.transform, slot6.transform.localPosition.x, slot3 and -12 or -20)
	end
end

function slot0.refreshSeasonStore(slot0)
	if ActivityHelper.getActivityStatus(Activity104Model.instance:getCurSeasonId()) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(slot0._btnseasonstore, false)

		return
	end

	gohelper.setActive(slot0._btnseasonstore, ActivityHelper.getActivityStatus(Activity104Enum.SeasonStore[slot1]) == ActivityEnum.ActivityStatus.Normal)

	if slot4 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0._txtseasonstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[slot1]) and slot5.quantity or 0)
	slot0._txtseasonstoretime.text = ActivityModel.instance:getActMO(slot3) and slot7:getRemainTimeStr2ByEndTime(true) or ""
end

function slot0.updateAchievementBtnVisible(slot0)
	gohelper.setActive(slot0._btnachievementpreview.gameObject, ActivityConfig.instance:getActivityCo(slot0.actId) and slot1.achievementGroup ~= 0)
end

function slot0.getLockTextFunc1(slot0, slot1, slot2)
	if slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		return slot0:getLockTextByOpenCo(slot1.openId)
	end

	return slot0:getLockText(slot1, slot2)
end

function slot0.getLockTextFunc9(slot0, slot1, slot2)
	if slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		return slot0:getLockTextByOpenCo(slot1.openId)
	end

	return slot0:getLockText(slot1, slot2)
end

function slot0.getLockTextByOpenCo(slot0, slot1)
	slot3 = DungeonConfig.instance:getEpisodeCO(lua_open.configDict[slot1].episodeId)

	return string.format(luaLang("versionactivity1_3_hardlocktip"), string.format("%s-%s", DungeonConfig.instance:getChapterCO(slot3.chapterId).chapterIndex, slot3.id % 100))
end

function slot0.onOpenViewFinish(slot0, slot1)
	uv0.super.onOpenViewFinish(slot0, slot1)

	if slot1 == ViewName.VersionActivity1_5DungeonMapView then
		slot0:closeBgmLeadSinger()
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	uv0.super.onCloseViewFinish(slot0, slot1)

	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:openBgmLeadSinger()
	end
end

function slot0.playBgm(slot0)
	slot0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	slot0.originalStateId = AudioMgr.instance:getIdFromString("original")
	slot0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")

	slot0:openBgmLeadSinger()
end

function slot0.openBgmLeadSinger(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.originalStateId)
end

function slot0.closeBgmLeadSinger(slot0)
	AudioMgr.instance:setSwitch(slot0.switchGroupId, slot0.accompanimentStateId)
end

return slot0
