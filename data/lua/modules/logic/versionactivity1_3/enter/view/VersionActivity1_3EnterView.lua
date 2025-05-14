module("modules.logic.versionactivity1_3.enter.view.VersionActivity1_3EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_3EnterView", VersionActivityEnterBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#txt_num")
	arg_1_0._gostoretime = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_store/timebg")
	arg_1_0._gostorelock = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_store/#go_Lock")
	arg_1_0._txtstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/timebg/#txt_time")
	arg_1_0._txtremainday = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/#txt_remaintime")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/#txt_time")
	arg_1_0._btnseasonstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_seasonstore")
	arg_1_0._txtseasonstorenum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_seasonstore/#txt_num")
	arg_1_0._txtseasonstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_seasonstore/timebg/#txt_time")
	arg_1_0._simagefg = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_fg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnseasonstore:AddClickListener(arg_2_0._btnseasonstoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnseasonstore:RemoveClickListener()
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

function var_0_0._btnseasonstoreOnClick(arg_4_0)
	local var_4_0 = Activity104Model.instance:getCurSeasonId()
	local var_4_1 = Activity104Enum.SeasonStore[var_4_0]
	local var_4_2, var_4_3, var_4_4 = ActivityHelper.getActivityStatusAndToast(var_4_1)

	if var_4_2 ~= ActivityEnum.ActivityStatus.Normal then
		if var_4_3 then
			GameFacade.showToast(var_4_3, var_4_4)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function var_0_0._btnstoreOnClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_3Enum.ActivityId.DungeonStore)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_1 then
			GameFacade.showToast(var_5_1, var_5_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	VersionActivity1_3EnterController.instance:openStoreView()
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_fullbg"))
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0.refreshLeiMiTeBeiCurrency, arg_6_0)
	arg_6_0._simagefg:LoadImage(ResUrl.getActivity1_3EnterIcon("v1a3_enterview_mainfg"))
end

function var_0_0.checkActivityCanClickFunc3(arg_7_0, arg_7_1)
	if ActivityHelper.getActivityStatus(arg_7_1.actId) == ActivityEnum.ActivityStatus.NotOpen then
		local var_7_0 = TimeUtil.timestampToTable(ActivityModel.instance:getActStartTime(arg_7_1.actId) / 1000)

		GameFacade.showToast(ToastEnum.SeasonUTTUNotOpen, var_7_0.month, var_7_0.day)
		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return arg_7_0:defaultCheckActivityCanClick(arg_7_1)
end

function var_0_0.onClickActivity4(arg_8_0)
	VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.onClickActivity3(arg_9_0)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0.onClickActivity5(arg_10_0)
	ArmPuzzlePipeController.instance:openMainView()
end

function var_0_0.onClickActivity1(arg_11_0)
	JiaLaBoNaController.instance:openMapView()
end

function var_0_0.onClickActivity2(arg_12_0)
	Activity1_3_119Controller.instance:openView()
end

function var_0_0.onClickActivity6(arg_13_0)
	Activity1_3ChessController.instance:openMapView()
end

function var_0_0.refreshUI(arg_14_0)
	var_0_0.super.refreshUI(arg_14_0)

	local var_14_0 = ActivityHelper.getActivityStatus(VersionActivity1_3Enum.ActivityId.DungeonStore)

	gohelper.setActive(arg_14_0._btnstore.gameObject, var_14_0 == ActivityEnum.ActivityStatus.Normal)
	arg_14_0:refreshLeiMiTeBeiCurrency()
	arg_14_0:refreshRemainTime()
end

function var_0_0.refreshSeasonStore(arg_15_0)
	local var_15_0 = Activity104Model.instance:getCurSeasonId()

	if ActivityHelper.getActivityStatus(var_15_0) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(arg_15_0._btnseasonstore.gameObject, false)

		return
	end

	local var_15_1 = Activity104Enum.SeasonStore[var_15_0]
	local var_15_2 = ActivityHelper.getActivityStatus(var_15_1)

	gohelper.setActive(arg_15_0._btnseasonstore.gameObject, var_15_2 == ActivityEnum.ActivityStatus.Normal)

	if var_15_2 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local var_15_3 = CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[var_15_0])
	local var_15_4 = var_15_3 and var_15_3.quantity or 0

	arg_15_0._txtseasonstorenum.text = GameUtil.numberDisplay(var_15_4)

	local var_15_5 = ActivityModel.instance:getActMO(var_15_1)

	arg_15_0._txtseasonstoretime.text = var_15_5 and var_15_5:getRemainTimeStr2ByEndTime(true) or ""
end

function var_0_0.refreshLeiMiTeBeiCurrency(arg_16_0)
	local var_16_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Planet)
	local var_16_1 = var_16_0 and var_16_0.quantity or 0

	arg_16_0._txtnum.text = GameUtil.numberDisplay(var_16_1)
end

function var_0_0.refreshRemainTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActivityInfo()[arg_17_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_17_1 = Mathf.Floor(var_17_0 / TimeUtil.OneDaySecond)
	local var_17_2 = var_17_0 % TimeUtil.OneDaySecond
	local var_17_3 = Mathf.Floor(var_17_2 / TimeUtil.OneHourSecond)

	arg_17_0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_17_1, luaLang("time_day"), var_17_3, luaLang("time_hour2")))

	arg_17_0:_refreshStore()
	arg_17_0:refreshSeasonStore()
end

function var_0_0.refreshEnterViewTime(arg_18_0)
	arg_18_0:refreshRemainTime()
	arg_18_0:onRefreshActivity4(arg_18_0:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Dungeon))
	arg_18_0:onRefreshActivity3(arg_18_0:getVersionActivityItem(VersionActivity1_3Enum.ActivityId.Season))
end

function var_0_0.onRefreshActivity4(arg_19_0, arg_19_1)
	local var_19_0 = ActivityHelper.getActivityStatus(arg_19_1.actId) == ActivityEnum.ActivityStatus.Normal
	local var_19_1 = gohelper.findChild(arg_19_1.rootGo, "normal/#go_bg1")

	gohelper.setActive(var_19_1, var_19_0)

	if var_19_0 then
		local var_19_2 = ActivityModel.instance:getActivityInfo()[arg_19_1.actId]

		gohelper.findChildText(arg_19_1.rootGo, "normal/#go_bg1/#txt_time").text = string.format(luaLang("versionactivity_remain_day"), var_19_2 and var_19_2:getRemainTimeStr())
	end
end

function var_0_0._refreshStore(arg_20_0)
	local var_20_0 = VersionActivity1_3Enum.ActivityId.DungeonStore
	local var_20_1 = ActivityHelper.getActivityStatus(var_20_0) == ActivityEnum.ActivityStatus.Normal
	local var_20_2 = ActivityModel.instance:getActivityInfo()[var_20_0]

	arg_20_0._txtstoretime.text = var_20_2 and var_20_2:getRemainTimeStr2ByEndTime(true) or ""

	gohelper.setActive(arg_20_0._gostoretime, var_20_1)

	if not var_20_1 then
		gohelper.setActive(arg_20_0._gostorelock, true)
	end
end

function var_0_0.onRefreshActivity3(arg_21_0, arg_21_1)
	local var_21_0 = ActivityHelper.getActivityStatus(arg_21_1.actId) == ActivityEnum.ActivityStatus.Normal
	local var_21_1 = gohelper.findChild(arg_21_1.goNormal, "week")
	local var_21_2 = gohelper.findChild(arg_21_1.goNormal, "score")

	gohelper.setActive(var_21_1, var_21_0 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(var_21_2, var_21_0)

	if var_21_0 and Activity104Model.instance:tryGetActivityInfo(arg_21_1.actId, arg_21_0.checkNeedRefreshUI, arg_21_0) then
		local var_21_3 = Activity104Model.instance:getAct104CurStage()
		local var_21_4 = gohelper.findChildImage(arg_21_1.rootGo, "normal/score/stage7")

		gohelper.setActive(var_21_4, var_21_3 == 7)

		for iter_21_0 = 1, 7 do
			local var_21_5 = gohelper.findChildImage(arg_21_1.rootGo, "normal/score/stage" .. iter_21_0)

			UISpriteSetMgr.instance:setV1a3EnterViewSprite(var_21_5, iter_21_0 <= var_21_3 and "v1a3_enterview_scorefg" or "v1a3_enterview_scorebg", true)
		end
	end
end

function var_0_0.beforePlayActUnlockAnimationActivity2(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_1.goTime, true)
	gohelper.setActive(arg_22_1.goLockContainer, true)

	local var_22_0 = gohelper.findChild(arg_22_1.goLockContainer, "lock/bg")

	if var_22_0 then
		gohelper.setActive(var_22_0, false)
	end

	local var_22_1 = gohelper.findChild(arg_22_1.goLockContainer, "lock")

	gohelper.setActive(var_22_1, true)
end

function var_0_0.everyMinuteCall(arg_23_0)
	var_0_0.super.everyMinuteCall(arg_23_0)
	arg_23_0:refreshEnterViewTime()
end

function var_0_0.playBgm(arg_24_0)
	return
end

function var_0_0.stopBgm(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	var_0_0.super.onDestroyView(arg_26_0)
	arg_26_0._simagebg:UnLoadImage()
	arg_26_0._simagefg:UnLoadImage()
end

return var_0_0
