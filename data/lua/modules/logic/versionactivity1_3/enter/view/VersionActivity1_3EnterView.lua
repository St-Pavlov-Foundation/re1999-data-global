module("modules.logic.versionactivity1_3.enter.view.VersionActivity1_3EnterView", package.seeall)

slot0 = class("VersionActivity1_3EnterView", VersionActivityEnterBaseView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#txt_num")
	slot0._gostoretime = gohelper.findChild(slot0.viewGO, "entrance/#btn_store/timebg")
	slot0._gostorelock = gohelper.findChild(slot0.viewGO, "entrance/#btn_store/#go_Lock")
	slot0._txtstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/timebg/#txt_time")
	slot0._txtremainday = gohelper.findChildText(slot0.viewGO, "logo/Time/#txt_remaintime")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/Time/#txt_time")
	slot0._btnseasonstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_seasonstore")
	slot0._txtseasonstorenum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_seasonstore/#txt_num")
	slot0._txtseasonstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_seasonstore/timebg/#txt_time")
	slot0._simagefg = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_fg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
	slot0._btnseasonstore:AddClickListener(slot0._btnseasonstoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
	slot0._btnseasonstore:RemoveClickListener()
end

slot0.SeasonAnchor = {
	Open = Vector2(-723.9, -228.9),
	NotOpen = Vector2(-660.9, 128.1)
}
slot0.LeiMiTeBeiAnchor = {
	Normal = {
		Position = Vector2(-651, -133),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-644, 85),
		Rotation = Vector3(0, 0, 31.65)
	}
}
slot0.LeiMiTeBeiStoreAnchor = {
	Normal = {
		Position = Vector2(-788, -94),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-772, 28),
		Rotation = Vector3(0, 0, 31.65)
	}
}

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

function slot0._btnstoreOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.DungeonStore)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivity1_3EnterController.instance:openStoreView()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_fullbg"))
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshLeiMiTeBeiCurrency, slot0)
	slot0._simagefg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_mainfg"))
end

function slot0.checkActivityCanClickFunc3(slot0, slot1)
	if ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.NotOpen then
		slot3 = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(slot1.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, slot3.month, slot3.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return slot0:defaultCheckActivityCanClick(slot1)
end

function slot0.onClickActivity4(slot0)
	VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.onClickActivity3(slot0)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0.onClickActivity5(slot0)
	ArmPuzzlePipeController.instance:openMainView()
end

function slot0.onClickActivity1(slot0)
	JiaLaBoNaController.instance:openMapView()
end

function slot0.onClickActivity2(slot0)
	Activity1_3_119Controller.instance:openView()
end

function slot0.onClickActivity6(slot0)
	Activity1_3ChessController.instance:openMapView()
end

function slot0.refreshUI(slot0)
	uv0.super.refreshUI(slot0)
	gohelper.setActive(slot0._btnstore.gameObject, ActivityHelper.getActivityStatus(VersionActivity1_3Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal)
	slot0:refreshLeiMiTeBeiCurrency()
	slot0:refreshRemainTime()
end

function slot0.refreshSeasonStore(slot0)
	if ActivityHelper.getActivityStatus(Activity104Model.instance:getCurSeasonId()) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(slot0._btnseasonstore.gameObject, false)

		return
	end

	gohelper.setActive(slot0._btnseasonstore.gameObject, ActivityHelper.getActivityStatus(Activity104Enum.SeasonStore[slot1]) == ActivityEnum.ActivityStatus.Normal)

	if slot4 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	slot0._txtseasonstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[slot1]) and slot5.quantity or 0)
	slot0._txtseasonstoretime.text = ActivityModel.instance:getActMO(slot3) and slot7:getRemainTimeStr2ByEndTime(true) or ""
end

function slot0.refreshLeiMiTeBeiCurrency(slot0)
	slot0._txtnum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet) and slot1.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now()
	slot0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", Mathf.Floor(slot2 / TimeUtil.OneDaySecond), luaLang("time_day"), Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond), luaLang("time_hour2")))

	slot0:_refreshStore()
	slot0:refreshSeasonStore()
end

function slot0.refreshEnterViewTime(slot0)
	slot0:refreshRemainTime()
	slot0:onRefreshActivity4(slot0:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Dungeon))
	slot0:onRefreshActivity3(slot0:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Season))
end

function slot0.onRefreshActivity4(slot0, slot1)
	slot3 = ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot1.rootGo, "normal/#go_bg1"), slot3)

	if slot3 then
		gohelper.findChildText(slot1.rootGo, "normal/#go_bg1/#txt_time").text = string.format(luaLang("versionactivity_remain_day"), ActivityModel.instance:getActivityInfo()[slot1.actId] and slot5:getRemainTimeStr())
	end
end

function slot0._refreshStore(slot0)
	slot3 = ActivityHelper.getActivityStatus(VersionActivity1_3Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal
	slot0._txtstoretime.text = ActivityModel.instance:getActivityInfo()[slot1] and slot4:getRemainTimeStr2ByEndTime(true) or ""

	gohelper.setActive(slot0._gostoretime, slot3)

	if not slot3 then
		gohelper.setActive(slot0._gostorelock, true)
	end
end

function slot0.onRefreshActivity3(slot0, slot1)
	slot3 = ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot1.goNormal, "week"), slot3 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "score"), slot3)

	if slot3 and Activity104Model.instance:tryGetActivityInfo(slot1.actId, slot0.checkNeedRefreshUI, slot0) then
		gohelper.setActive(gohelper.findChildImage(slot1.rootGo, "normal/score/stage7"), Activity104Model.instance:getAct104CurStage() == 7)

		for slot11 = 1, 7 do
			UISpriteSetMgr.instance:setV1a3EnterViewSprite(gohelper.findChildImage(slot1.rootGo, "normal/score/stage" .. slot11), slot11 <= slot6 and "v1a3_enterview_scorefg" or "v1a3_enterview_scorebg", true)
		end
	end
end

function slot0.beforePlayActUnlockAnimationActivity2(slot0, slot1)
	gohelper.setActive(slot1.goTime, true)
	gohelper.setActive(slot1.goLockContainer, true)

	if gohelper.findChild(slot1.goLockContainer, "lock/bg") then
		gohelper.setActive(slot2, false)
	end

	gohelper.setActive(gohelper.findChild(slot1.goLockContainer, "lock"), true)
end

function slot0.everyMinuteCall(slot0)
	uv0.super.everyMinuteCall(slot0)
	slot0:refreshEnterViewTime()
end

function slot0.playBgm(slot0)
end

function slot0.stopBgm(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagefg:UnLoadImage()
end

return slot0
