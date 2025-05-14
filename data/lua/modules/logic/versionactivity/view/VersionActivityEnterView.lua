module("modules.logic.versionactivity.view.VersionActivityEnterView", package.seeall)

local var_0_0 = class("VersionActivityEnterView", VersionActivityEnterBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#txt_num")
	arg_1_0._txtremainday = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_remaintime")
	arg_1_0._txtremaindayprefix = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_remaintime_prefix")
	arg_1_0._txtremaindaysuffix = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_remiantime_suffix")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
end

var_0_0.SeasonAnchor = {
	Open = Vector2(-723.9, -228.9),
	NotOpen = Vector2(-660.9, 128.1)
}
var_0_0.LeiMiTeBeiAnchor = {
	Normal = {
		Position = Vector2(-651, -133),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-644, 85),
		Rotation = Vector3(0, 0, 31.65)
	}
}
var_0_0.LeiMiTeBeiStoreAnchor = {
	Normal = {
		Position = Vector2(-788, -94),
		Rotation = Vector3(0, 0, 0)
	},
	Expired = {
		Position = Vector2(-772, 28),
		Rotation = Vector3(0, 0, 31.65)
	}
}

function var_0_0._btnstoreOnClick(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(VersionActivityEnum.ActivityId.Act107)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_4_1 then
			GameFacade.showToastWithTableParam(var_4_1, var_4_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivityController.instance:openLeiMiTeBeiStoreView()
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/bg"))
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0.refreshLeiMiTeBeiCurrency, arg_5_0)
end

function var_0_0.onClickActivity1(arg_6_0)
	VersionActivityDungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.checkActivityCanClickFunc2(arg_7_0, arg_7_1)
	if ActivityHelper.getActivityStatus(arg_7_1.actId) == ActivityEnum.ActivityStatus.NotOpen then
		local var_7_0 = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(arg_7_1.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, var_7_0.month, var_7_0.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return arg_7_0:defaultCheckActivityCanClick(arg_7_1)
end

function var_0_0.onClickActivity2(arg_8_0)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0.onClickActivity3(arg_9_0)
	ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
end

function var_0_0.onClickActivity4(arg_10_0)
	Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
end

function var_0_0.onClickActivity5(arg_11_0)
	PushBoxController.instance:enterPushBoxGame()
end

function var_0_0.onClickActivity6(arg_12_0)
	MeilanniController.instance:openMeilanniMainView({
		checkStory = true
	})
end

function var_0_0.refreshUI(arg_13_0)
	var_0_0.super.refreshUI(arg_13_0)

	local var_13_0 = VersionActivityEnum.ActivityId.Act104
	local var_13_1 = arg_13_0:getVersionActivityItem(var_13_0)
	local var_13_2 = arg_13_0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113)
	local var_13_3 = var_13_1.rootGo.transform
	local var_13_4 = var_13_2.rootGo.transform
	local var_13_5 = arg_13_0._btnstore.transform
	local var_13_6 = ActivityHelper.getActivityStatus(var_13_0)
	local var_13_7
	local var_13_8

	if var_13_6 == ActivityEnum.ActivityStatus.NotOpen then
		local var_13_9 = var_0_0.SeasonAnchor.NotOpen

		recthelper.setAnchor(var_13_3, var_13_9.x, var_13_9.y)

		local var_13_10 = var_0_0.LeiMiTeBeiAnchor.Normal.Position

		recthelper.setAnchor(var_13_4, var_13_10.x, var_13_10.y)

		local var_13_11 = var_0_0.LeiMiTeBeiAnchor.Normal.Rotation

		transformhelper.setLocalRotation(var_13_4, var_13_11.x, var_13_11.y, var_13_11.z)

		local var_13_12 = var_0_0.LeiMiTeBeiStoreAnchor.Normal.Position

		recthelper.setAnchor(var_13_5, var_13_12.x, var_13_12.y)

		local var_13_13 = var_0_0.LeiMiTeBeiStoreAnchor.Normal.Rotation

		transformhelper.setLocalRotation(var_13_5, var_13_13.x, var_13_13.y, var_13_13.z)
	else
		local var_13_14 = var_0_0.SeasonAnchor.Open

		recthelper.setAnchor(var_13_3, var_13_14.x, var_13_14.y)

		local var_13_15 = var_0_0.LeiMiTeBeiAnchor.Expired.Position

		recthelper.setAnchor(var_13_4, var_13_15.x, var_13_15.y)

		local var_13_16 = var_0_0.LeiMiTeBeiAnchor.Expired.Rotation

		transformhelper.setLocalRotation(var_13_4, var_13_16.x, var_13_16.y, var_13_16.z)

		local var_13_17 = var_0_0.LeiMiTeBeiStoreAnchor.Expired.Position

		recthelper.setAnchor(var_13_5, var_13_17.x, var_13_17.y)

		local var_13_18 = var_0_0.LeiMiTeBeiStoreAnchor.Expired.Rotation

		transformhelper.setLocalRotation(var_13_5, var_13_18.x, var_13_18.y, var_13_18.z)
	end

	local var_13_19 = ActivityHelper.getActivityStatus(VersionActivityEnum.ActivityId.Act107)

	gohelper.setActive(arg_13_0._btnstore.gameObject, var_13_19 == ActivityEnum.ActivityStatus.Normal)
	arg_13_0:refreshLeiMiTeBeiCurrency()
	arg_13_0:refreshRemainTime()
end

function var_0_0.refreshLeiMiTeBeiCurrency(arg_14_0)
	local var_14_0 = ReactivityModel.instance:getActivityCurrencyId(arg_14_0.actId)
	local var_14_1 = CurrencyModel.instance:getCurrency(var_14_0)
	local var_14_2 = var_14_1 and var_14_1.quantity or 0

	arg_14_0._txtnum.text = GameUtil.numberDisplay(var_14_2)
end

function var_0_0.refreshRemainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActivityInfo()[arg_15_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_15_1 = Mathf.Floor(var_15_0 / TimeUtil.OneDaySecond)
	local var_15_2 = var_15_0 % TimeUtil.OneDaySecond
	local var_15_3 = Mathf.Floor(var_15_2 / TimeUtil.OneHourSecond)

	arg_15_0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_15_1, luaLang("time_day"), var_15_3, luaLang("time_hour2")))
end

function var_0_0.refreshEnterViewTime(arg_16_0)
	arg_16_0:refreshRemainTime()
	arg_16_0:onRefreshActivity1(arg_16_0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act113))
	arg_16_0:onRefreshActivity2(arg_16_0:getVersionActivityItem(VersionActivityEnum.ActivityId.Act104))
end

function var_0_0.onRefreshActivity1(arg_17_0, arg_17_1)
	local var_17_0 = ActivityHelper.getActivityStatus(arg_17_1.actId)
	local var_17_1 = gohelper.findChild(arg_17_1.rootGo, "normal/#go_bg1")

	gohelper.setActive(var_17_1, var_17_0 == ActivityEnum.ActivityStatus.Normal)

	if var_17_0 == ActivityEnum.ActivityStatus.Normal then
		local var_17_2 = ActivityModel.instance:getActivityInfo()[arg_17_1.actId]

		gohelper.findChildText(arg_17_1.rootGo, "normal/#go_bg1/#txt_time").text = string.format(luaLang("versionactivity_remain_day"), var_17_2 and var_17_2:getRemainTimeStr())
	end
end

function var_0_0.onRefreshActivity2(arg_18_0, arg_18_1)
	local var_18_0 = ActivityHelper.getActivityStatus(arg_18_1.actId)
	local var_18_1 = var_18_0 == ActivityEnum.ActivityStatus.Normal
	local var_18_2 = gohelper.findChild(arg_18_1.goLockContainer, "notopen")
	local var_18_3 = gohelper.findChild(arg_18_1.goLockContainer, "lock")

	gohelper.setActive(var_18_2, var_18_0 == ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(var_18_3, var_18_0 ~= ActivityEnum.ActivityStatus.NotOpen)
	gohelper.setActive(arg_18_1.goNormal, var_18_0 ~= ActivityEnum.ActivityStatus.NotOpen)

	local var_18_4 = gohelper.findChild(arg_18_1.goNormal, "week")
	local var_18_5 = gohelper.findChild(arg_18_1.goNormal, "score")

	gohelper.setActive(var_18_4, var_18_1 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(var_18_5, var_18_1)

	if var_18_1 then
		local var_18_6 = Activity104Model.instance:getAct104CurStage()
		local var_18_7 = gohelper.findChildImage(arg_18_1.rootGo, "normal/score/stage7")

		gohelper.setActive(var_18_7, var_18_6 == 7)

		for iter_18_0 = 1, 7 do
			local var_18_8 = gohelper.findChildImage(arg_18_1.rootGo, "normal/score/stage" .. iter_18_0)

			UISpriteSetMgr.instance:setVersionActivitySprite(var_18_8, iter_18_0 <= var_18_6 and "eye" or "slot", true)
		end
	end
end

function var_0_0.beforePlayActUnlockAnimationActivity2(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_1.goTime, true)
	gohelper.setActive(arg_19_1.goLockContainer, true)

	local var_19_0 = gohelper.findChild(arg_19_1.goLockContainer, "lock/bg")

	if var_19_0 then
		gohelper.setActive(var_19_0, false)
	end

	local var_19_1 = gohelper.findChild(arg_19_1.goLockContainer, "lock")

	gohelper.setActive(var_19_1, true)
end

function var_0_0.everyMinuteCall(arg_20_0)
	var_0_0.super.everyMinuteCall(arg_20_0)
	arg_20_0:refreshEnterViewTime()
end

function var_0_0.playBgm(arg_21_0)
	return
end

function var_0_0.stopBgm(arg_22_0)
	return
end

function var_0_0.onDestroyView(arg_23_0)
	var_0_0.super.onDestroyView(arg_23_0)
	arg_23_0._simagebg:UnLoadImage()
end

function var_0_0.initActivityItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = var_0_0.super.initActivityItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)

	var_24_0.shakeicon = gohelper.findChild(arg_24_3, "normal/icon1")

	return var_24_0
end

function var_0_0.defaultBeforePlayActUnlockAnimation(arg_25_0, arg_25_1)
	var_0_0.super.defaultBeforePlayActUnlockAnimation(arg_25_0, arg_25_1)

	if arg_25_1.shakeicon then
		gohelper.setActive(arg_25_1.shakeicon, false)
	end
end

function var_0_0.refreshLockUI(arg_26_0, arg_26_1, arg_26_2)
	var_0_0.super.refreshLockUI(arg_26_0, arg_26_1, arg_26_2)

	if arg_26_1.shakeicon then
		local var_26_0 = arg_26_2 == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(arg_26_1.shakeicon, var_26_0)
	end
end

function var_0_0.playUnlockAnimationDone(arg_27_0)
	var_0_0.super.playUnlockAnimationDone(arg_27_0)

	if arg_27_0.needPlayTimeUnlockList then
		for iter_27_0, iter_27_1 in ipairs(arg_27_0.needPlayTimeUnlockList) do
			if iter_27_1.shakeicon then
				gohelper.setActive(iter_27_1.shakeicon, true)
			end
		end
	end
end

return var_0_0
