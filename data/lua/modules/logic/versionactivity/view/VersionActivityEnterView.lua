module("modules.logic.versionactivity.view.VersionActivityEnterView", package.seeall)

slot0 = class("VersionActivityEnterView", VersionActivityEnterBaseView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#txt_num")
	slot0._txtremainday = gohelper.findChildText(slot0.viewGO, "logo/#txt_remaintime")
	slot0._txtremaindayprefix = gohelper.findChildText(slot0.viewGO, "logo/#txt_remaintime_prefix")
	slot0._txtremaindaysuffix = gohelper.findChildText(slot0.viewGO, "logo/#txt_remiantime_suffix")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
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

function slot0._btnstoreOnClick(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act107)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg"))
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshLeiMiTeBeiCurrency, slot0)
end

function slot0.onClickActivity1(slot0)
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.checkActivityCanClickFunc2(slot0, slot1)
	if ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.NotOpen then
		slot3 = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(slot1.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, slot3.month, slot3.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return slot0:defaultCheckActivityCanClick(slot1)
end

function slot0.onClickActivity2(slot0)
	Activity104Controller.instance:openSeasonMainView()
end

function slot0.onClickActivity3(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
end

function slot0.onClickActivity4(slot0)
	Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
end

function slot0.onClickActivity5(slot0)
	PushBoxController.instance:enterPushBoxGame()
end

function slot0.onClickActivity6(slot0)
	MeilanniController.instance:openMeilanniMainView({
		checkStory = true
	})
end

function slot0.refreshUI(slot0)
	uv0.super.refreshUI(slot0)

	slot1 = VersionActivityEnum.ActivityId.Act104
	slot5 = slot0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113).rootGo.transform
	slot6 = slot0._btnstore.transform
	slot8, slot9 = nil

	if ActivityHelper.getActivityStatus(slot1) == ActivityEnum.ActivityStatus.NotOpen then
		slot8 = uv0.SeasonAnchor.NotOpen

		recthelper.setAnchor(slot0:getVersionActivityItem(slot1).rootGo.transform, slot8.x, slot8.y)

		slot8 = uv0.LeiMiTeBeiAnchor.Normal.Position

		recthelper.setAnchor(slot5, slot8.x, slot8.y)

		slot9 = uv0.LeiMiTeBeiAnchor.Normal.Rotation

		transformhelper.setLocalRotation(slot5, slot9.x, slot9.y, slot9.z)

		slot8 = uv0.LeiMiTeBeiStoreAnchor.Normal.Position

		recthelper.setAnchor(slot6, slot8.x, slot8.y)

		slot9 = uv0.LeiMiTeBeiStoreAnchor.Normal.Rotation

		transformhelper.setLocalRotation(slot6, slot9.x, slot9.y, slot9.z)
	else
		slot8 = uv0.SeasonAnchor.Open

		recthelper.setAnchor(slot4, slot8.x, slot8.y)

		slot8 = uv0.LeiMiTeBeiAnchor.Expired.Position

		recthelper.setAnchor(slot5, slot8.x, slot8.y)

		slot9 = uv0.LeiMiTeBeiAnchor.Expired.Rotation

		transformhelper.setLocalRotation(slot5, slot9.x, slot9.y, slot9.z)

		slot8 = uv0.LeiMiTeBeiStoreAnchor.Expired.Position

		recthelper.setAnchor(slot6, slot8.x, slot8.y)

		slot9 = uv0.LeiMiTeBeiStoreAnchor.Expired.Rotation

		transformhelper.setLocalRotation(slot6, slot9.x, slot9.y, slot9.z)
	end

	gohelper.setActive(slot0._btnstore.gameObject, ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act107) == ActivityEnum.ActivityStatus.Normal)
	slot0:refreshLeiMiTeBeiCurrency()
	slot0:refreshRemainTime()
end

function slot0.refreshLeiMiTeBeiCurrency(slot0)
	slot0._txtnum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(slot0.actId)) and slot2.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now()
	slot0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", Mathf.Floor(slot2 / TimeUtil.OneDaySecond), luaLang("time_day"), Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond), luaLang("time_hour2")))
end

function slot0.refreshEnterViewTime(slot0)
	slot0:refreshRemainTime()
	slot0:onRefreshActivity1(slot0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113))
	slot0:onRefreshActivity2(slot0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act104))
end

function slot0.onRefreshActivity1(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1.rootGo, "normal/#go_bg1"), ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal)

	if slot2 == ActivityEnum.ActivityStatus.Normal then
		gohelper.findChildText(slot1.rootGo, "normal/#go_bg1/#txt_time").text = string.format(luaLang("versionactivity_remain_day"), ActivityModel.instance:getActivityInfo()[slot1.actId] and slot4:getRemainTimeStr())
	end
end

function slot0.onRefreshActivity2(slot0, slot1)
	slot3 = ActivityHelper.getActivityStatus(slot1.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot1.goLockContainer, "notopen"), slot2 == ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(gohelper.findChild(slot1.goLockContainer, "lock"), slot2 ~= ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(slot1.goNormal, slot2 ~= ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "week"), slot3 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(gohelper.findChild(slot1.goNormal, "score"), slot3)

	if slot3 then
		gohelper.setActive(gohelper.findChildImage(slot1.rootGo, "normal/score/stage7"), Activity104Model.instance:getAct104CurStage() == 7)

		for slot13 = 1, 7 do
			UISpriteSetMgr.instance:setVersionActivitySprite(gohelper.findChildImage(slot1.rootGo, "normal/score/stage" .. slot13), slot13 <= slot8 and "eye" or "slot", true)
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
end

function slot0.initActivityItem(slot0, slot1, slot2, slot3)
	slot4 = uv0.super.initActivityItem(slot0, slot1, slot2, slot3)
	slot4.shakeicon = gohelper.findChild(slot3, "normal/icon1")

	return slot4
end

function slot0.defaultBeforePlayActUnlockAnimation(slot0, slot1)
	uv0.super.defaultBeforePlayActUnlockAnimation(slot0, slot1)

	if slot1.shakeicon then
		gohelper.setActive(slot1.shakeicon, false)
	end
end

function slot0.refreshLockUI(slot0, slot1, slot2)
	uv0.super.refreshLockUI(slot0, slot1, slot2)

	if slot1.shakeicon then
		gohelper.setActive(slot1.shakeicon, slot2 == ActivityEnum.ActivityStatus.Normal)
	end
end

function slot0.playUnlockAnimationDone(slot0)
	uv0.super.playUnlockAnimationDone(slot0)

	if slot0.needPlayTimeUnlockList then
		for slot4, slot5 in ipairs(slot0.needPlayTimeUnlockList) do
			if slot5.shakeicon then
				gohelper.setActive(slot5.shakeicon, true)
			end
		end
	end
end

return slot0
