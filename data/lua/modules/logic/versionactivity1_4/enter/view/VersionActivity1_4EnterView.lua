module("modules.logic.versionactivity1_4.enter.view.VersionActivity1_4EnterView", package.seeall)

local var_0_0 = class("VersionActivity1_4EnterView", VersionActivityEnterBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg/img/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg/img/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg/img/#simage_bg3")
	arg_1_0._simagebg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg/img/#simage_bg4")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_mask")
	arg_1_0._txtremainday = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/#txt_remaintime")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/#txt_time")
	arg_1_0.goTabNode = gohelper.findChild(arg_1_0.viewGO, "logo/#go_change")
	arg_1_0._btnmainentrance = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_mainentrance")
	arg_1_0._btnroom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_room")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievement")
	arg_1_0._btnseasonstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_seasonstore")
	arg_1_0._txtseasonstorenum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_seasonstore/normal/storeBG/#txt_num")
	arg_1_0._txtseasonstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_seasonstore/normal/#go_bg1/#txt_time")

	arg_1_0:initTab()

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnmainentrance:AddClickListener(arg_2_0._onClickMainentranceBtn, arg_2_0)
	arg_2_0._btnroom:AddClickListener(arg_2_0._onClickRoomBtn, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._onClickAchievementBtn, arg_2_0)
	arg_2_0._btnseasonstore:AddClickListener(arg_2_0._btnseasonstoreOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnmainentrance:RemoveClickListener()
	arg_3_0._btnroom:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnseasonstore:RemoveClickListener()
end

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

function var_0_0._onClickMainentranceBtn(arg_5_0)
	GameFacade.jump(51)
end

function var_0_0._onClickRoomBtn(arg_6_0)
	GameFacade.jump(440001)
end

function var_0_0._onClickAchievementBtn(arg_7_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementMainView, {
			selectType = AchievementEnum.Type.Activity
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end
end

function var_0_0._editableInitView(arg_8_0)
	var_0_0.super._editableInitView(arg_8_0)
	arg_8_0._simagebg1:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_01.png")
	arg_8_0._simagebg2:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_02.png")
	arg_8_0._simagebg3:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_03.png")
	arg_8_0._simagebg4:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbg_04.png")
	arg_8_0._simagemask:LoadImage("singlebg/v1a4_enterview_singlebg/v1a4_enterview_fullbgmask.png")
end

function var_0_0.onClickActivity1(arg_9_0, arg_9_1)
	Activity133Controller.instance:openActivity133MainView(arg_9_1)
end

function var_0_0.onClickActivity2(arg_10_0)
	Activity130Controller.instance:enterActivity130()
end

function var_0_0.onClickActivity3(arg_11_0)
	BossRushController.instance:openMainView()
end

function var_0_0.onClickActivity4(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
		activityId = arg_12_1
	})
end

function var_0_0.onClickActivity5(arg_13_0, arg_13_1)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = arg_13_1
	})
end

function var_0_0.onClickActivity6(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = arg_14_1
	})
end

function var_0_0.onClickActivity7(arg_15_0, arg_15_1)
	BossRushController.instance:openMainView()
end

function var_0_0.onClickActivity8(arg_16_0, arg_16_1)
	Activity104Controller.instance:openSeasonMainView()
end

function var_0_0.onClickActivity9(arg_17_0, arg_17_1)
	Activity134Controller.instance:openActivity134MainView(arg_17_1)
end

function var_0_0.onClickActivity10(arg_18_0)
	Activity131Controller.instance:enterActivity131()
end

function var_0_0.onClickActivity11(arg_19_0, arg_19_1)
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = arg_19_1
	})
end

function var_0_0.onClickActivity12(arg_20_0, arg_20_1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
		actId = arg_20_1
	})
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0.onOpening = true

	arg_21_0:initViewParam()
	arg_21_0:initActivityNode()
	arg_21_0:initActivityItemList()

	for iter_21_0 = 2, 1, -1 do
		if arg_21_0:checkTabIsOpen(iter_21_0, true) then
			arg_21_0:onChangeTab(iter_21_0)

			break
		end
	end

	arg_21_0:playOpenAnimation()
end

function var_0_0.playOpenAnimation(arg_22_0)
	local var_22_0 = arg_22_0.tabIndex == VersionActivity1_4Enum.TabEnum.First and "open_a" or "open_b"

	if arg_22_0.skipOpenAnim then
		arg_22_0.animator:Play(var_22_0, 0, 1)
		TaskDispatcher.runDelay(arg_22_0.onOpenAnimationDone, arg_22_0, 0.5)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_open)
		arg_22_0.animator:Play(var_22_0)
		TaskDispatcher.runDelay(arg_22_0.onOpenAnimationDone, arg_22_0, 2)
	end
end

function var_0_0.refreshUI(arg_23_0)
	gohelper.setActive(arg_23_0._btnroom, arg_23_0.tabIndex == VersionActivity1_4Enum.TabEnum.First)
	arg_23_0:refreshRemainTime()
	arg_23_0:refreshCenterActUI()
	arg_23_0:refreshActivityUI()
	arg_23_0:refreshSeasonStore()
	arg_23_0:refreshTabRed()
end

function var_0_0.refreshActivityItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.index

	if not arg_24_0.actIndex2TabIndex then
		arg_24_0.actIndex2TabIndex = {}

		for iter_24_0, iter_24_1 in pairs(VersionActivity1_4Enum.TabActivityList) do
			for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
				arg_24_0.actIndex2TabIndex[iter_24_3] = iter_24_0
			end
		end
	end

	local var_24_1 = arg_24_0.actIndex2TabIndex[var_24_0] == arg_24_0.tabIndex

	gohelper.setActive(arg_24_1.rootGo, var_24_1)

	if not var_24_1 then
		return
	end

	var_0_0.super.refreshActivityItem(arg_24_0, arg_24_1)
end

function var_0_0.refreshRemainTime(arg_25_0)
	local var_25_0 = ActivityModel.instance:getActivityInfo()[arg_25_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_25_1 = Mathf.Floor(var_25_0 / TimeUtil.OneDaySecond)
	local var_25_2 = var_25_0 % TimeUtil.OneDaySecond
	local var_25_3 = Mathf.Floor(var_25_2 / TimeUtil.OneHourSecond)

	if LangSettings.instance:isEn() then
		arg_25_0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s %s%s", var_25_1, luaLang("time_day"), var_25_3, luaLang("time_hour2")))
	else
		arg_25_0._txtremainday.text = string.format(luaLang("remain"), string.format("%s%s%s%s", var_25_1, luaLang("time_day"), var_25_3, luaLang("time_hour2")))
	end
end

function var_0_0.refreshEnterViewTime(arg_26_0)
	arg_26_0:refreshRemainTime()
	arg_26_0:refreshSeasonStore()
end

function var_0_0.onRefreshActivity5(arg_27_0, arg_27_1)
	local var_27_0 = ActivityHelper.getActivityStatus(arg_27_1.actId)
	local var_27_1 = gohelper.findChild(arg_27_1.goNormal, "#go_bg1")
	local var_27_2 = gohelper.findChild(arg_27_1.goNormal, "storeBG")

	gohelper.setActive(var_27_1, var_27_0 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(var_27_2, var_27_0 == ActivityEnum.ActivityStatus.Normal)

	if var_27_0 == ActivityEnum.ActivityStatus.Normal then
		local var_27_3 = ActivityModel.instance:getActMO(arg_27_1.actId)

		gohelper.findChildTextMesh(arg_27_1.goNormal, "#go_bg1/#txt_time").text = var_27_3:getRemainTimeStr(true)

		local var_27_4 = gohelper.findChildTextMesh(arg_27_1.goNormal, "storeBG/#txt_num")
		local var_27_5 = Activity129Config.instance:getConstValue1(arg_27_1.actId, Activity129Enum.ConstEnum.CostId)
		local var_27_6 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_27_5)

		var_27_4.text = tostring(var_27_6)
	end
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

			UISpriteSetMgr.instance:setV1a4EnterViewSprite(var_28_5, iter_28_0 <= var_28_3 and "v1a4_enterview_scorefg" or "v1a4_enterview_scorebg", true)
		end
	end
end

function var_0_0.onRefreshActivity11(arg_29_0, arg_29_1)
	local var_29_0 = ActivityHelper.getActivityStatus(arg_29_1.actId)
	local var_29_1 = gohelper.findChild(arg_29_1.goNormal, "#go_bg1")
	local var_29_2 = gohelper.findChild(arg_29_1.goNormal, "storeBG")

	gohelper.setActive(var_29_1, var_29_0 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(var_29_2, var_29_0 == ActivityEnum.ActivityStatus.Normal)

	if var_29_0 == ActivityEnum.ActivityStatus.Normal then
		local var_29_3 = ActivityModel.instance:getActMO(arg_29_1.actId)

		gohelper.findChildTextMesh(arg_29_1.goNormal, "#go_bg1/#txt_time").text = var_29_3:getRemainTimeStr(true)

		local var_29_4 = gohelper.findChildTextMesh(arg_29_1.goNormal, "storeBG/#txt_num")
		local var_29_5 = Activity129Config.instance:getConstValue1(arg_29_1.actId, Activity129Enum.ConstEnum.CostId)
		local var_29_6 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_29_5)

		var_29_4.text = tostring(var_29_6)
	end
end

function var_0_0.refreshSeasonStore(arg_30_0)
	if arg_30_0.tabIndex == VersionActivity1_4Enum.TabEnum.First then
		gohelper.setActive(arg_30_0._btnseasonstore, false)

		return
	end

	local var_30_0 = Activity104Model.instance:getCurSeasonId()

	if ActivityHelper.getActivityStatus(var_30_0) == ActivityEnum.ActivityStatus.Normal then
		gohelper.setActive(arg_30_0._btnseasonstore, false)

		return
	end

	local var_30_1 = Activity104Enum.SeasonStore[var_30_0]
	local var_30_2 = ActivityHelper.getActivityStatus(var_30_1)

	gohelper.setActive(arg_30_0._btnseasonstore, var_30_2 == ActivityEnum.ActivityStatus.Normal)

	if var_30_2 ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local var_30_3 = CurrencyModel.instance:getCurrency(Activity104Enum.StoreUTTU[var_30_0])
	local var_30_4 = var_30_3 and var_30_3.quantity or 0

	arg_30_0._txtseasonstorenum.text = GameUtil.numberDisplay(var_30_4)

	local var_30_5 = ActivityModel.instance:getActMO(var_30_1)

	arg_30_0._txtseasonstoretime.text = var_30_5 and var_30_5:getRemainTimeStr2ByEndTime(true) or ""
end

function var_0_0.getSeasonStoreActivity(arg_31_0)
	local var_31_0 = Activity104Model.instance:getCurSeasonId()

	if ActivityHelper.getActivityStatus(var_31_0) == ActivityEnum.ActivityStatus.Normal then
		return false
	end

	local var_31_1 = Activity104Enum.SeasonStore[var_31_0]

	return ActivityHelper.getActivityStatus(var_31_1) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.everyMinuteCall(arg_32_0)
	var_0_0.super.everyMinuteCall(arg_32_0)
	arg_32_0:refreshEnterViewTime()
end

function var_0_0.playBgm(arg_33_0)
	return
end

function var_0_0.stopBgm(arg_34_0)
	return
end

function var_0_0.initTab(arg_35_0)
	arg_35_0.tabList = {}

	for iter_35_0 = 1, 2 do
		arg_35_0.tabList[iter_35_0] = arg_35_0:createTab(iter_35_0)
	end
end

function var_0_0.createTab(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getUserDataTb_()

	var_36_0.go = gohelper.findChild(arg_36_0.goTabNode, string.format("Item%s", arg_36_1))
	var_36_0.goSelect = gohelper.findChild(var_36_0.go, "#btn_select")
	var_36_0.btn = gohelper.findButtonWithAudio(var_36_0.go, AudioEnum.UI.play_ui_leimi_theft_open)

	var_36_0.btn:AddClickListener(arg_36_0.onChangeTab, arg_36_0, arg_36_1)

	var_36_0.goRed = gohelper.findChild(var_36_0.go, "#go_reddot")

	return var_36_0
end

function var_0_0.refreshTabRed(arg_37_0)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.tabList) do
		if not iter_37_1.redDot then
			local var_37_0 = iter_37_0 == VersionActivity1_4Enum.TabEnum.First and 1075 or 1088

			iter_37_1.redDot = RedDotController.instance:addRedDot(iter_37_1.goRed, var_37_0)
		else
			iter_37_1.redDot:refreshDot()
		end
	end
end

function var_0_0.destoryTab(arg_38_0, arg_38_1)
	if arg_38_1 then
		arg_38_1.btn:RemoveClickListener()
	end
end

function var_0_0.onChangeTab(arg_39_0, arg_39_1)
	if arg_39_0.tabIndex == arg_39_1 then
		return
	end

	if not arg_39_0:checkTabIsOpen(arg_39_1) then
		return
	end

	local var_39_0 = arg_39_0.tabIndex ~= nil

	arg_39_0.tabIndex = arg_39_1

	gohelper.setActive(arg_39_0._btnachievement, true)

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.tabList) do
		gohelper.setActive(iter_39_1.goSelect, arg_39_0.tabIndex == iter_39_0)
	end

	TaskDispatcher.cancelTask(arg_39_0.onSwitchAnimEnd, arg_39_0)

	if var_39_0 then
		local var_39_1 = arg_39_0.tabIndex == VersionActivity1_4Enum.TabEnum.First and "switch_b" or "switch_a"

		arg_39_0.animator:Play(var_39_1)

		for iter_39_2, iter_39_3 in ipairs(arg_39_0.activityItemList) do
			gohelper.setActive(iter_39_3.rootGo, true)
		end

		gohelper.setActive(arg_39_0._btnroom, true)

		if arg_39_0:getSeasonStoreActivity() then
			gohelper.setActive(arg_39_0._btnseasonstore, true)
		end

		local var_39_2 = 0.5

		TaskDispatcher.runDelay(arg_39_0.onSwitchAnimEnd, arg_39_0, var_39_2)
	else
		arg_39_0:onSwitchAnimEnd()
	end
end

function var_0_0.onSwitchAnimEnd(arg_40_0)
	arg_40_0:refreshUI()
end

function var_0_0.checkTabIsOpen(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = VersionActivity1_4Enum.ActivityId.EnterView

	if arg_41_1 == VersionActivity1_4Enum.TabEnum.Second then
		var_41_0 = VersionActivity1_4Enum.ActivityId.SecondEnter
	end

	local var_41_1, var_41_2, var_41_3 = ActivityHelper.getActivityStatusAndToast(var_41_0)

	if var_41_1 ~= ActivityEnum.ActivityStatus.Normal then
		if not arg_41_2 then
			if var_41_1 == ActivityEnum.ActivityStatus.NotOpen then
				local var_41_4 = ActivityModel.instance:getActMO(var_41_0)
				local var_41_5 = var_41_4:getRealStartTimeStamp() - ServerTime.now()
				local var_41_6 = var_41_4.config.name
				local var_41_7 = TimeUtil.getFormatTime_overseas(var_41_5)

				GameFacade.showToast(ToastEnum.V1a4_ActPreTips, var_41_6, var_41_7)
			elseif var_41_2 then
				GameFacade.showToast(var_41_2, var_41_3)
			end
		end

		return false
	end

	return true
end

function var_0_0.onDestroyView(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.onSwitchAnimEnd, arg_42_0)
	arg_42_0._simagebg1:UnLoadImage()
	arg_42_0._simagebg2:UnLoadImage()
	arg_42_0._simagebg3:UnLoadImage()
	arg_42_0._simagebg4:UnLoadImage()
	arg_42_0._simagemask:UnLoadImage()

	if arg_42_0.tabList then
		for iter_42_0, iter_42_1 in pairs(arg_42_0.tabList) do
			arg_42_0:destoryTab(iter_42_1)
		end

		arg_42_0.tabList = nil
	end

	var_0_0.super.onDestroyView(arg_42_0)
end

return var_0_0
