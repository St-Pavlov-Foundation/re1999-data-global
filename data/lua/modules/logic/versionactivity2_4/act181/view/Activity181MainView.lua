module("modules.logic.versionactivity2_4.act181.view.Activity181MainView", package.seeall)

local var_0_0 = class("Activity181MainView", BaseView)

var_0_0.OPEN_ANIM = "open"
var_0_0.OPEN_ANIM_FIRST_DAY = "openfrist"
var_0_0.POP_UP_DELAY = 0.8

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageBoxShadow = gohelper.findChildSingleImage(arg_1_0.viewGO, "Box/#simage_BoxShadow")
	arg_1_0._simageBoxShadow2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Box/#simage_BoxShadow2")
	arg_1_0._simageBox = gohelper.findChildSingleImage(arg_1_0.viewGO, "Box/#simage_Box")
	arg_1_0._txtOpenTimes = gohelper.findChildText(arg_1_0.viewGO, "Box/OpenTimes/#txt_OpenTimes")
	arg_1_0._goClaimed = gohelper.findChild(arg_1_0.viewGO, "Box/OpenTimes/#go_Claimed")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item")
	arg_1_0._simageItem = gohelper.findChildSingleImage(arg_1_0.viewGO, "Box/Grid/#go_Item/OptionalItem/#simage_Item")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Box/Grid/#go_Item/OptionalItem/image_NumBG/#txt_Num")
	arg_1_0._txtItemName = gohelper.findChildText(arg_1_0.viewGO, "Box/Grid/#go_Item/OptionalItem/#txt_ItemName")
	arg_1_0._goCover = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item/#go_Cover")
	arg_1_0._goType1 = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type1")
	arg_1_0._goType2 = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type2")
	arg_1_0._goType3 = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type3")
	arg_1_0._goType4 = gohelper.findChild(arg_1_0.viewGO, "Box/Grid/#go_Item/#go_Cover/#go_Type4")
	arg_1_0._goTips1 = gohelper.findChild(arg_1_0.viewGO, "Box/Tips/#go_Tips1")
	arg_1_0._goTips2 = gohelper.findChild(arg_1_0.viewGO, "Box/Tips/#go_Tips2")
	arg_1_0._btnInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Reward/#btn_Info")
	arg_1_0._btnSpInfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Reward/#btn_SpInfo")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnspBonus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Reward/image_Reward/#btn_spBonus")
	arg_1_0._goCanGet = gohelper.findChild(arg_1_0.viewGO, "Right/Reward/#go_CanGet")
	arg_1_0._goSpClaimed = gohelper.findChild(arg_1_0.viewGO, "Right/Reward/#go_SpClaimed")
	arg_1_0._simageRewardName = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/Reward/#simage_RewardName")
	arg_1_0._txtRewardDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/Reward/#txt_RewardDescr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnInfo:AddClickListener(arg_2_0._btnInfoOnClick, arg_2_0)
	arg_2_0._btnspBonus:AddClickListener(arg_2_0._btnspBonusOnClick, arg_2_0)
	arg_2_0._btnSpInfo:AddClickListener(arg_2_0._btnSpInfoOnClick, arg_2_0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetBonus, arg_2_0.onGetBonus, arg_2_0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetInfo, arg_2_0.refreshUI, arg_2_0)
	Activity181Controller.instance:registerCallback(Activity181Event.OnGetSPBonus, arg_2_0.onGetSPBonus, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.refreshTime, arg_2_0, TimeUtil.OneSecond)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.updateInfo, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDay, arg_2_0.refreshSpBonusZeroTime, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnInfo:RemoveClickListener()
	arg_3_0._btnspBonus:RemoveClickListener()
	arg_3_0._btnSpInfo:RemoveClickListener()
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetBonus, arg_3_0.onGetBonus, arg_3_0)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetInfo, arg_3_0.refreshUI, arg_3_0)
	Activity181Controller.instance:unregisterCallback(Activity181Event.OnGetSPBonus, arg_3_0.onGetSPBonus, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshTime, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.updateInfo, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDay, arg_3_0.refreshSpBonusZeroTime, arg_3_0)
end

function var_0_0._btnspBonusOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(arg_4_0._actId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local var_4_0 = Activity181Model.instance:getActivityInfo(arg_4_0._actId)

	if not var_4_0 then
		return
	end

	if var_4_0.spBonusState == Activity181Enum.SPBonusState.Locked then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	elseif var_4_0.spBonusState == Activity181Enum.SPBonusState.HaveGet then
		local var_4_1 = string.splitToNumber(var_4_0.config.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(var_4_1[1], var_4_1[2], false)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getSPBonus(arg_4_0._actId)
end

function var_0_0._btnSpInfoOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	local var_5_0 = Activity181Model.instance:getActivityInfo(arg_5_0._actId)

	if not var_5_0 then
		return
	end

	local var_5_1 = string.splitToNumber(var_5_0.config.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(var_5_1[1], var_5_1[2], false)
end

function var_0_0._btnInfoOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	local var_6_0 = {
		actId = arg_6_0._actId
	}

	ViewMgr.instance:openView(ViewName.Activity181RewardView, var_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._bonusItemList = {}

	gohelper.setActive(arg_7_0._goItem, false)

	arg_7_0._animator = gohelper.findChildComponent(arg_7_0.viewGO, "", gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam.parent

	gohelper.addChild(var_9_0, arg_9_0.viewGO)

	arg_9_0._actId = arg_9_0.viewParam.actId

	arg_9_0:updateInfo()
	arg_9_0:playOpenAnim()
end

function var_0_0.updateInfo(arg_10_0)
	Activity181Controller.instance:getActivityInfo(arg_10_0._actId)
end

function var_0_0.playOpenAnim(arg_11_0)
	local var_11_0 = Activity181Model.instance:getHaveFirstDayLogin(arg_11_0._actId)

	if var_11_0 then
		Activity181Model.instance:setHaveFirstDayLogin(arg_11_0._actId)
	end

	local var_11_1 = var_11_0 and arg_11_0.OPEN_ANIM_FIRST_DAY or arg_11_0.OPEN_ANIM

	arg_11_0._animator:Play(var_11_1)
	AudioMgr.instance:trigger(AudioEnum.Act181.play_ui_diqiu_xueye_open)
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshTime()
	arg_12_0:refreshBonus()
end

function var_0_0.onGetBonus(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 ~= arg_13_0._actId then
		return
	end

	local var_13_0 = arg_13_0._bonusItemList

	var_13_0[arg_13_3]:onUpdateMO(arg_13_3, arg_13_1, true)

	local var_13_1 = Activity181Model.instance:getActivityInfo(arg_13_0._actId)

	if not var_13_1 then
		return
	end

	if var_13_1:getBonusTimes() <= 0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_0 ~= arg_13_3 then
				local var_13_2 = var_13_1:getBonusState(iter_13_0) == Activity181Enum.BonusState.HaveGet

				iter_13_1:setBonusFxState(var_13_2, false)
			end
		end
	end

	arg_13_0:refreshBonusDesc(var_13_1)
	arg_13_0:refreshSPBonus(var_13_1)
	Activity181Model.instance:setPopUpPauseState(true)
	TaskDispatcher.runDelay(arg_13_0.onBonusAnimationEnd, arg_13_0, arg_13_0.POP_UP_DELAY)
end

function var_0_0.onBonusAnimationEnd(arg_14_0)
	Activity181Model.instance:setPopUpPauseState(false)
	TaskDispatcher.cancelTask(arg_14_0.onBonusAnimationEnd, arg_14_0)
end

function var_0_0.onGetSPBonus(arg_15_0, arg_15_1)
	if arg_15_1 ~= arg_15_0._actId then
		return
	end

	local var_15_0 = Activity181Model.instance:getActivityInfo(arg_15_0._actId)

	if not var_15_0 then
		return
	end

	arg_15_0:refreshSPBonus(var_15_0)
end

function var_0_0.refreshSpBonusZeroTime(arg_16_0)
	logNormal("Activity181MainView : refreshSpBonusZeroTime")

	local var_16_0 = ActivityModel.instance:getActMO(arg_16_0._actId):getRealEndTimeStamp()
	local var_16_1 = ServerTime.now()

	if var_16_0 <= var_16_1 then
		return
	end

	local var_16_2 = Activity181Model.instance:getActivityInfo(arg_16_0._actId)

	if not var_16_2 then
		return
	end

	local var_16_3 = var_16_2.config

	if var_16_1 <= TimeUtil.stringToTimestamp(var_16_3.obtainStart) - TimeUtil.OneDaySecond or var_16_1 >= TimeUtil.stringToTimestamp(var_16_3.obtainEnd) + TimeUtil.OneDaySecond then
		return
	end

	logNormal("Activity181MainView : refreshSpBonusInfo")
	var_16_2:refreshSpBonusInfo()
end

function var_0_0.refreshTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActMO(arg_17_0._actId):getRealEndTimeStamp()
	local var_17_1 = ServerTime.now()

	if var_17_0 <= var_17_1 then
		arg_17_0._txtLimitTime.text = luaLang("ended")

		return
	end

	local var_17_2 = TimeUtil.SecondToActivityTimeFormat(var_17_0 - var_17_1)

	arg_17_0._txtLimitTime.text = var_17_2
end

function var_0_0.refreshBonus(arg_18_0)
	local var_18_0 = Activity181Model.instance:getActivityInfo(arg_18_0._actId)

	if not var_18_0 then
		return
	end

	local var_18_1 = Activity181Config.instance:getBoxListByActivityId(arg_18_0._actId)
	local var_18_2 = #var_18_1
	local var_18_3 = arg_18_0._bonusItemList
	local var_18_4 = #var_18_3

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_5

		if var_18_4 < iter_18_0 then
			local var_18_6 = gohelper.clone(arg_18_0._goItem, arg_18_0._goItem.transform.parent.gameObject, tostring(iter_18_0))

			var_18_5 = Activity181BonusItem.New()

			var_18_5:init(var_18_6)
			table.insert(var_18_3, var_18_5)
		else
			var_18_5 = var_18_3[iter_18_0]
		end

		var_18_5:setEnable(true)
		var_18_5:onUpdateMO(iter_18_0, arg_18_0._actId)
	end

	if var_18_2 < var_18_4 then
		for iter_18_2 = var_18_2 + 1, var_18_4 do
			arg_18_0._bonusItemList[iter_18_2]:setEnable(false)
		end
	end

	arg_18_0:refreshBonusDesc(var_18_0)
	arg_18_0:refreshSPBonus(var_18_0)
end

function var_0_0.refreshBonusDesc(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:canGetBonus()

	gohelper.setActive(arg_19_0._goClaimed, not var_19_0)
	gohelper.setActive(arg_19_0._txtOpenTimes, var_19_0)

	if var_19_0 then
		local var_19_1 = luaLang("blind_box_bouns_count")

		arg_19_0._txtOpenTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_19_1, tostring(arg_19_1.canGetTimes))
	end

	gohelper.setActive(arg_19_0._goTips2, arg_19_1.canGetTimes > 0)
	gohelper.setActive(arg_19_0._goTips1, arg_19_1.canGetTimes <= 0 and var_19_0)
end

function var_0_0.refreshSPBonus(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return
	end

	local var_20_0 = arg_20_1.spBonusState

	gohelper.setActive(arg_20_0._goSpClaimed, var_20_0 == Activity181Enum.SPBonusState.HaveGet)
	gohelper.setActive(arg_20_0._goCanGet, var_20_0 == Activity181Enum.SPBonusState.Unlock)
	gohelper.setActive(arg_20_0._btnSpInfo, var_20_0 == Activity181Enum.SPBonusState.Locked)
end

function var_0_0.onClose(arg_21_0)
	if Activity181Model.instance:getPopUpPauseState() then
		arg_21_0:onBonusAnimationEnd()
	end
end

function var_0_0.onDestroyView(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._bonusItemList) do
		iter_22_1:onDestroy()
	end

	arg_22_0._bonusItemList = nil
end

return var_0_0
