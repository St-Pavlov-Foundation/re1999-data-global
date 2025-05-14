module("modules.logic.versionactivity1_8.enter.view.subview.V1a8_Season123EnterView", package.seeall)

local var_0_0 = class("V1a8_Season123EnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goDesc = gohelper.findChild(arg_1_0.viewGO, "Dec")
	arg_1_0._btnnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Normal")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Store/#go_store/#btn_store")
	arg_1_0._txtstoretime = gohelper.findChildText(arg_1_0.viewGO, "Store/#go_taglimit/#txt_limit")
	arg_1_0._txtstoreCoinNum = gohelper.findChildText(arg_1_0.viewGO, "Store/#go_store/#txt_num")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Normal/#image_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/txt_Locked")
	arg_1_0._txtLockedEn = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/txt_LockedEn")
	arg_1_0._txtUnlockedTips = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/#txt_UnLockedTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._btnNormalOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnStoreOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStoreCoin, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCoin, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.refreshUI, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

function var_0_0._btnNormalOnClick(arg_4_0)
	if arg_4_0.actId ~= nil then
		local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.actId)

		if var_4_0 and var_4_0:isOpen() then
			Season123Controller.instance:openSeasonEntry({
				actId = arg_4_0.actId
			})

			return
		end
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_0.actId)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal and var_5_1 then
		GameFacade.showToast(var_5_1, var_5_2)
	end
end

function var_0_0._btnStoreOnClick(arg_6_0)
	Season123Controller.instance:openSeasonStoreView(arg_6_0.actId)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.animComp = VersionActivitySubAnimatorComp.get(arg_7_0.viewGO, arg_7_0)
	arg_7_0.descTab = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 4 do
		local var_7_0 = gohelper.findChildText(arg_7_0.viewGO, "Dec/txt_dec" .. iter_7_0)

		table.insert(arg_7_0.descTab, var_7_0)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.animComp:playOpenAnim()

	arg_9_0.actId = VersionActivity1_8Enum.ActivityId.Season

	RedDotController.instance:addRedDot(arg_9_0._goreddot, RedDotEnum.DotNode.Season123Enter)
	arg_9_0:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, arg_9_0.actId, arg_9_0)
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshEnterBtn()
	arg_10_0:refreshDesc()
	arg_10_0:refreshStoreCoin()
	arg_10_0:refreshRemainTime()
	TaskDispatcher.cancelTask(arg_10_0.refreshRemainTime, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0.refreshRemainTime, arg_10_0, 1)
end

function var_0_0.refreshDesc(arg_11_0)
	local var_11_0 = ActivityConfig.instance:getActivityCo(arg_11_0.actId)

	if not var_11_0 then
		gohelper.setActive(arg_11_0._goDesc, false)
	else
		gohelper.setActive(arg_11_0._goDesc, true)

		local var_11_1 = string.split(var_11_0.actDesc, "#")

		for iter_11_0 = 1, #var_11_1 do
			if not arg_11_0.descTab[iter_11_0] then
				return
			end

			gohelper.setActive(arg_11_0.descTab[iter_11_0].gameObject, true)

			arg_11_0.descTab[iter_11_0].text = var_11_1[iter_11_0]
		end

		for iter_11_1 = #var_11_1 + 1, #arg_11_0.descTab do
			gohelper.setActive(arg_11_0.descTab[iter_11_1].gameObject, false)
		end
	end
end

function var_0_0.refreshStoreCoin(arg_12_0)
	local var_12_0 = Season123Config.instance:getSeasonConstNum(arg_12_0.actId, Activity123Enum.Const.StoreCoinId)
	local var_12_1 = CurrencyModel.instance:getCurrency(var_12_0)
	local var_12_2 = var_12_1 and var_12_1.quantity or 0

	arg_12_0._txtstoreCoinNum.text = GameUtil.numberDisplay(var_12_2)
end

function var_0_0.refreshEnterBtn(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = ActivityHelper.getActivityStatusAndToast(arg_13_0.actId)
	local var_13_3 = var_13_0 ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_13_0._btnnormal.gameObject, not var_13_3)
	gohelper.setActive(arg_13_0._btnLocked.gameObject, var_13_3)

	if var_13_1 then
		local var_13_4 = ToastConfig.instance:getToastCO(var_13_1).tips
		local var_13_5 = GameUtil.getSubPlaceholderLuaLang(var_13_4, var_13_2)

		arg_13_0._txtUnlockedTips.text = var_13_5
	else
		arg_13_0._txtUnlockedTips.text = ""
	end

	gohelper.setActive(arg_13_0._txtUnlockedTips.gameObject, var_13_0 ~= ActivityEnum.ActivityStatus.Expired)

	arg_13_0._txtLocked.text = var_13_0 == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	arg_13_0._txtLockedEn.text = var_13_0 == ActivityEnum.ActivityStatus.Expired and "ENDED" or "LOCKED"
end

function var_0_0.refreshRemainTime(arg_14_0)
	arg_14_0:refreshMainTime()
	arg_14_0:refreshStoreTime()
end

function var_0_0.refreshMainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActMO(arg_15_0.actId)

	if not var_15_0 then
		arg_15_0._txtLimitTime.text = ""

		return
	end

	local var_15_1 = var_15_0:getRealEndTimeStamp() - ServerTime.now()

	if var_15_1 > 0 then
		local var_15_2 = TimeUtil.SecondToActivityTimeFormat(var_15_1)

		arg_15_0._txtLimitTime.text = var_15_2
	else
		arg_15_0._txtLimitTime.text = luaLang("ended")
	end
end

function var_0_0.refreshStoreTime(arg_16_0)
	local var_16_0 = Season123Config.instance:getSeasonConstNum(arg_16_0.actId, Activity123Enum.Const.StoreActId)
	local var_16_1 = ActivityModel.instance:getActMO(var_16_0)

	if not var_16_1 then
		return
	end

	local var_16_2, var_16_3, var_16_4 = ActivityHelper.getActivityStatusAndToast(var_16_0)

	if var_16_2 ~= ActivityEnum.ActivityStatus.Normal and var_16_3 then
		arg_16_0._txtstoretime.text = var_16_2 == ActivityEnum.ActivityStatus.Expired and luaLang("ended") or luaLang("notOpen")
	else
		arg_16_0._txtstoretime.text = var_16_1:getRemainTimeStr2ByEndTime(true)
	end
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.refreshRemainTime, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.animComp:destroy()
end

return var_0_0
