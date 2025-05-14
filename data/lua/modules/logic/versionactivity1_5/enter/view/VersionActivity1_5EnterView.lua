module("modules.logic.versionactivity1_5.enter.view.VersionActivity1_5EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_5EnterView", VersionActivityEnterBaseViewWithGroup)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/timebg/#txt_remaintime")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/#txt_time")
	arg_1_0.txtDungeonStoreNum1 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group1/activityContainer4/normal/#txt_num")
	arg_1_0.txtDungeonStoreNum2 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/activityContainer10/normal/#txt_num")
	arg_1_0.txtDungeonStoreRemainTime1 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group1/activityContainer4/#go_time/#txt_time")
	arg_1_0.txtDungeonStoreRemainTime2 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/activityContainer10/#go_time/#txt_time")
	arg_1_0._btnseasonstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#go_group2/#btn_seasonstore")
	arg_1_0._txtseasonstorenum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/storeBG/#txt_num")
	arg_1_0._txtseasonstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/#btn_seasonstore/normal/#go_bg1/#txt_time")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0.gobg1 = gohelper.findChild(arg_1_0.viewGO, "bg1")
	arg_1_0.gobg2 = gohelper.findChild(arg_1_0.viewGO, "bg2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnseasonstore:AddClickListener(arg_2_0._btnseasonstoreOnClick, arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnseasonstore:RemoveClickListener()
	arg_3_0._btnachievementpreview:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshCurrency, arg_4_0)
end

function var_0_0._btnseasonstoreOnClick(arg_5_0)
	local var_5_0 = Activity104Model.instance:getCurSeasonId()
	local var_5_1 = Activity104Enum.SeasonStore[var_5_0]
	local var_5_2, var_5_3, var_5_4 = ActivityHelper.getActivityStatusAndToast(var_5_1)

	if var_5_2 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_3 then
			GameFacade.showToast(var_5_3, var_5_4)
		end

		return
	end

	Activity104Controller.instance:openSeasonStoreView()
end

function var_0_0._btnachievementpreviewOnClick(arg_6_0)
	local var_6_0 = ActivityConfig.instance:getActivityCo(arg_6_0.actId)

	if var_6_0 and var_6_0.achievementGroup ~= 0 then
		AchievementController.instance:openAchievementGroupPreView(arg_6_0.actId, var_6_0.achievementGroup)
	end
end

function var_0_0.refreshSingleBgUI(arg_7_0)
	gohelper.setActive(arg_7_0.gobg1, arg_7_0.showGroupIndex == 1)
	gohelper.setActive(arg_7_0.gobg2, arg_7_0.showGroupIndex == 2)
end

function var_0_0.onClickActivity1(arg_8_0)
	Activity142Controller.instance:openMapView()
end

function var_0_0.onClickActivity2(arg_9_0)
	BossRushController.instance:openMainView()
end

function var_0_0.onClickActivity3(arg_10_0)
	SportsNewsController.instance:openSportsNewsMainView()
end

function var_0_0.onClickActivity4(arg_11_0)
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function var_0_0.onClickActivity5(arg_12_0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.onClickActivity6(arg_13_0)
	PeaceUluController.instance:openPeaceUluView()
end

function var_0_0.onClickActivity7(arg_14_0)
	BossRushController.instance:openMainView()
end

function var_0_0.onClickActivity8(arg_15_0)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0.onClickActivity9(arg_16_0)
	AiZiLaController.instance:openMapView()
end

function var_0_0.onClickActivity10(arg_17_0)
	VersionActivity1_5DungeonController.instance:openStoreView()
end

function var_0_0.onClickActivity11(arg_18_0)
	VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.singleBgUI(arg_19_0)
	return
end

function var_0_0.refreshUI(arg_20_0)
	var_0_0.super.refreshUI(arg_20_0)
	arg_20_0:refreshEnterViewTime()
	arg_20_0:updateAchievementBtnVisible()
	arg_20_0:refreshSeasonStore()
	arg_20_0:refreshCurrency()
	arg_20_0:refreshDungeonStoreTime()
end

function var_0_0.refreshEnterViewTime(arg_21_0)
	arg_21_0:refreshDurationTime()
	arg_21_0:refreshRemainTime()
end

function var_0_0.refreshCurrency(arg_22_0)
	local var_22_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a5Dungeon)
	local var_22_1 = var_22_0 and var_22_0.quantity or 0

	arg_22_0.txtDungeonStoreNum1.text = var_22_1
	arg_22_0.txtDungeonStoreNum2.text = var_22_1
end

function var_0_0.refreshDungeonStoreTime(arg_23_0)
	local var_23_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.DungeonStore]:getRealEndTimeStamp() - ServerTime.now()

	if var_23_0 > TimeUtil.OneDaySecond then
		local var_23_1 = Mathf.Floor(var_23_0 / TimeUtil.OneDaySecond) .. "d"

		arg_23_0.txtDungeonStoreRemainTime1.text = var_23_1
		arg_23_0.txtDungeonStoreRemainTime2.text = var_23_1

		return
	end

	if var_23_0 > TimeUtil.OneHourSecond then
		local var_23_2 = Mathf.Floor(var_23_0 / TimeUtil.OneHourSecond) .. "h"

		arg_23_0.txtDungeonStoreRemainTime1.text = var_23_2
		arg_23_0.txtDungeonStoreRemainTime2.text = var_23_2

		return
	end

	arg_23_0.txtDungeonStoreRemainTime1.text = "1h"
	arg_23_0.txtDungeonStoreRemainTime2.text = "1h"
end

function var_0_0.refreshRemainTime(arg_24_0)
	local var_24_0 = ActivityModel.instance:getActivityInfo()[arg_24_0.actId]:getRemainTimeStr3()

	arg_24_0._txtremaintime.text = formatLuaLang("remain", var_24_0)
end

function var_0_0.refreshDurationTime(arg_25_0)
	local var_25_0 = ActivityModel.instance:getActivityInfo()[arg_25_0.actId]

	if arg_25_0._txttime then
		arg_25_0._txttime.text = var_25_0:getStartTimeStr() .. " ~ " .. var_25_0:getEndTimeStr()
	end
end

function var_0_0.everyMinuteCall(arg_26_0)
	var_0_0.super.everyMinuteCall(arg_26_0)
	arg_26_0:refreshRemainTime()
	arg_26_0:refreshDungeonStoreTime()
end

function var_0_0.onDestroyView(arg_27_0)
	var_0_0.super.onDestroyView(arg_27_0)
end

function var_0_0.onRefreshActivity8(arg_28_0, arg_28_1)
	local var_28_0 = ActivityHelper.getActivityStatus(arg_28_1.actId) == ActivityEnum.ActivityStatus.Normal
	local var_28_1 = gohelper.findChild(arg_28_1.goNormal, "week")
	local var_28_2 = gohelper.findChild(arg_28_1.goNormal, "score")

	gohelper.setActive(var_28_1, var_28_0 and Activity104Model.instance:isEnterSpecial())
	gohelper.setActive(var_28_2, var_28_0)

	if var_28_0 and Activity104Model.instance:tryGetActivityInfo(arg_28_1.actId, arg_28_0.checkNeedRefreshUI, arg_28_0) then
		local var_28_3 = Activity104Model.instance:getAct104CurStage()
		local var_28_4 = gohelper.findChildImage(arg_28_1.rootGo, "normal/score/stage7")

		gohelper.setActive(var_28_4, var_28_3 == 7)

		for iter_28_0 = 1, 7 do
			local var_28_5 = gohelper.findChildImage(arg_28_1.rootGo, "normal/score/stage" .. iter_28_0)

			UISpriteSetMgr.instance:setV1a5EnterViewSprite(var_28_5, iter_28_0 <= var_28_3 and "v1a5_enterview_scorefg" or "v1a5_enterview_scorebg", true)
		end
	end

	if GameConfig:GetCurLangType() ~= LangSettings.zh then
		local var_28_6 = gohelper.findChild(arg_28_1.goNormal, "txt_Activity2")
		local var_28_7 = var_28_0 and -12 or -20

		transformhelper.setLocalPosXY(var_28_6.transform, var_28_6.transform.localPosition.x, var_28_7)
	end
end

function var_0_0.refreshSeasonStore(arg_29_0)
	local var_29_0 = Activity104Model.instance:getCurSeasonId()

	if ActivityHelper.getActivityStatus(var_29_0) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(arg_29_0._btnseasonstore, false)

		return
	end

	local var_29_1 = Activity104Enum.SeasonStore[var_29_0]
	local var_29_2 = ActivityHelper.getActivityStatus(var_29_1)

	gohelper.setActive(arg_29_0._btnseasonstore, var_29_2 == ActivityEnum.ActivityStatus.Normal)

	if var_29_2 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local var_29_3 = CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[var_29_0])
	local var_29_4 = var_29_3 and var_29_3.quantity or 0

	arg_29_0._txtseasonstorenum.text = GameUtil.numberDisplay(var_29_4)

	local var_29_5 = ActivityModel.instance:getActMO(var_29_1)

	arg_29_0._txtseasonstoretime.text = var_29_5 and var_29_5:getRemainTimeStr2ByEndTime(true) or ""
end

function var_0_0.updateAchievementBtnVisible(arg_30_0)
	local var_30_0 = ActivityConfig.instance:getActivityCo(arg_30_0.actId)

	gohelper.setActive(arg_30_0._btnachievementpreview.gameObject, var_30_0 and var_30_0.achievementGroup ~= 0)
end

function var_0_0.getLockTextFunc1(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_2 == ActivityEnum.ActivityStatus.NotUnlock then
		return arg_31_0:getLockTextByOpenCo(arg_31_1.openId)
	end

	return arg_31_0:getLockText(arg_31_1, arg_31_2)
end

function var_0_0.getLockTextFunc9(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_2 == ActivityEnum.ActivityStatus.NotUnlock then
		return arg_32_0:getLockTextByOpenCo(arg_32_1.openId)
	end

	return arg_32_0:getLockText(arg_32_1, arg_32_2)
end

function var_0_0.getLockTextByOpenCo(arg_33_0, arg_33_1)
	local var_33_0 = lua_open.configDict[arg_33_1]
	local var_33_1 = DungeonConfig.instance:getEpisodeCO(var_33_0.episodeId)
	local var_33_2 = DungeonConfig.instance:getChapterCO(var_33_1.chapterId).chapterIndex
	local var_33_3 = var_33_1.id % 100

	return string.format(luaLang("versionactivity1_3_hardlocktip"), string.format("%s-%s", var_33_2, var_33_3))
end

function var_0_0.onOpenViewFinish(arg_34_0, arg_34_1)
	var_0_0.super.onOpenViewFinish(arg_34_0, arg_34_1)

	if arg_34_1 == ViewName.VersionActivity1_5DungeonMapView then
		arg_34_0:closeBgmLeadSinger()
	end
end

function var_0_0.onCloseViewFinish(arg_35_0, arg_35_1)
	var_0_0.super.onCloseViewFinish(arg_35_0, arg_35_1)

	if ViewHelper.instance:checkViewOnTheTop(arg_35_0.viewName) then
		arg_35_0:openBgmLeadSinger()
	end
end

function var_0_0.playBgm(arg_36_0)
	arg_36_0.switchGroupId = AudioMgr.instance:getIdFromString("music_vocal_filter")
	arg_36_0.originalStateId = AudioMgr.instance:getIdFromString("original")
	arg_36_0.accompanimentStateId = AudioMgr.instance:getIdFromString("accompaniment")

	arg_36_0:openBgmLeadSinger()
end

function var_0_0.openBgmLeadSinger(arg_37_0)
	AudioMgr.instance:setSwitch(arg_37_0.switchGroupId, arg_37_0.originalStateId)
end

function var_0_0.closeBgmLeadSinger(arg_38_0)
	AudioMgr.instance:setSwitch(arg_38_0.switchGroupId, arg_38_0.accompanimentStateId)
end

return var_0_0
