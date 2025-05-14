module("modules.logic.versionactivity2_4.enter.view.subview.V2a4_Season166EnterView", package.seeall)

local var_0_0 = class("V2a4_Season166EnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goDesc = gohelper.findChild(arg_1_0.viewGO, "#simage_FullBG/Dec")
	arg_1_0._btnnormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Normal")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._btnInformation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_information")
	arg_1_0._txtcoinNum = gohelper.findChildText(arg_1_0.viewGO, "#btn_information/#txt_coinNum")
	arg_1_0._goinfoReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_information/#go_infoReddot")
	arg_1_0._goinfoNewReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_information/#go_infoNewReddot")
	arg_1_0._goinfoTime = gohelper.findChildText(arg_1_0.viewGO, "#btn_information/#go_infoTime")
	arg_1_0._txtinfoTime = gohelper.findChildText(arg_1_0.viewGO, "#btn_information/#go_infoTime/#txt_time")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Normal/#image_reddot")
	arg_1_0._btnLocked = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Locked")
	arg_1_0._txtLocked = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/txt_Locked")
	arg_1_0._txtLockedEn = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/txt_LockedEn")
	arg_1_0._txtUnlockedTips = gohelper.findChildText(arg_1_0.viewGO, "#btn_Locked/#txt_UnLockedTips")
	arg_1_0._btnEnd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_End")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnormal:AddClickListener(arg_2_0._btnNormalOnClick, arg_2_0)
	arg_2_0._btnLocked:AddClickListener(arg_2_0._btnLockedOnClick, arg_2_0)
	arg_2_0._btnEnd:AddClickListener(arg_2_0._btnEndOnClick, arg_2_0)
	arg_2_0._btnInformation:AddClickListener(arg_2_0._btnInformationOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshInformationCoin, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnormal:RemoveClickListener()
	arg_3_0._btnLocked:RemoveClickListener()
	arg_3_0._btnEnd:RemoveClickListener()
	arg_3_0._btnInformation:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshInformationCoin, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0, LuaEventSystem.Low)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

function var_0_0._btnNormalOnClick(arg_4_0)
	if arg_4_0.actId ~= nil then
		local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.actId)

		if var_4_0 and var_4_0:isOpen() then
			local var_4_1 = {
				actId = arg_4_0.actId
			}

			Season166Controller.instance:openSeasonView(var_4_1)

			return
		end
	end

	GameFacade.showToast(ToastEnum.ActivityNotOpen)
end

function var_0_0._btnLockedOnClick(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_0.actId)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal and var_5_0 ~= ActivityEnum.ActivityStatus.Expired and var_5_1 then
		GameFacade.showToast(var_5_1, var_5_2)
	end
end

function var_0_0._btnEndOnClick(arg_6_0)
	if arg_6_0.isCloseEnter then
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function var_0_0._btnInformationOnClick(arg_7_0)
	Activity166Rpc.instance:sendGet166InfosRequest(arg_7_0.actId, function()
		ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
			actId = arg_7_0.actId
		})
	end, arg_7_0)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.descTab = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, 3 do
		local var_9_0 = gohelper.findChildText(arg_9_0.viewGO, "#simage_FullBG/Dec/go_desc" .. iter_9_0 .. "/txt_desc")

		table.insert(arg_9_0.descTab, var_9_0)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	var_0_0.super.onOpen(arg_11_0)

	arg_11_0.actId = VersionActivity2_4Enum.ActivityId.Season
	arg_11_0.infoCoinId = Season166Config.instance:getSeasonConstNum(arg_11_0.actId, Season166Enum.InfoCostId)

	if ActivityHelper.getActivityStatusAndToast(arg_11_0.actId) == ActivityEnum.ActivityStatus.Normal then
		Activity166Rpc.instance:sendGet166InfosRequest(arg_11_0.actId)
	end

	arg_11_0.closeEnterTimeOffset = Season166Config.instance:getSeasonConstNum(arg_11_0.actId, Season166Enum.CloseSeasonEnterTime)

	local var_11_0 = Season166Config.instance:getSeasonConstStr(arg_11_0.actId, Season166Enum.EnterViewBgUrl)

	arg_11_0._simageFullBG:LoadImage(var_11_0)
	arg_11_0:refreshUI()
	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.SelectActId, arg_11_0.actId, arg_11_0)
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshRemainTime()
	arg_12_0:refreshEnterBtn()
	arg_12_0:refreshDesc()
	arg_12_0:refreshInformationCoin()
	arg_12_0:refreshReddot()
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0.refreshRemainTime, arg_12_0, 1)
end

function var_0_0.refreshDesc(arg_13_0)
	local var_13_0 = ActivityConfig.instance:getActivityCo(arg_13_0.actId)

	if not var_13_0 then
		gohelper.setActive(arg_13_0._goDesc, false)
	else
		gohelper.setActive(arg_13_0._goDesc, true)

		local var_13_1 = string.split(var_13_0.actDesc, "#")

		for iter_13_0 = 1, #var_13_1 do
			if not arg_13_0.descTab[iter_13_0] then
				return
			end

			gohelper.setActive(arg_13_0.descTab[iter_13_0].gameObject, true)

			arg_13_0.descTab[iter_13_0].text = var_13_1[iter_13_0]
		end

		for iter_13_1 = #var_13_1 + 1, #arg_13_0.descTab do
			gohelper.setActive(arg_13_0.descTab[iter_13_1].gameObject, false)
		end
	end
end

function var_0_0.refreshEnterBtn(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = ActivityHelper.getActivityStatusAndToast(arg_14_0.actId)
	local var_14_3 = var_14_0 ~= ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_14_0._btnnormal.gameObject, not var_14_3 and not arg_14_0.isCloseEnter)
	gohelper.setActive(arg_14_0._btnEnd.gameObject, not var_14_3 and arg_14_0.isCloseEnter)
	gohelper.setActive(arg_14_0._btnLocked.gameObject, var_14_3)

	if var_14_1 then
		local var_14_4 = ToastConfig.instance:getToastCO(var_14_1).tips
		local var_14_5 = GameUtil.getSubPlaceholderLuaLang(var_14_4, var_14_2)

		arg_14_0._txtUnlockedTips.text = var_14_5
	else
		arg_14_0._txtUnlockedTips.text = ""
	end

	gohelper.setActive(arg_14_0._txtUnlockedTips.gameObject, var_14_0 ~= ActivityEnum.ActivityStatus.Expired)

	arg_14_0._txtLocked.text = luaLang("notOpen")
	arg_14_0._txtLockedEn.text = "LOCKED"
end

function var_0_0.refreshRemainTime(arg_15_0)
	local var_15_0 = ActivityModel.instance:getActMO(arg_15_0.actId)

	if not var_15_0 then
		arg_15_0._txtLimitTime.text = ""

		gohelper.setActive(arg_15_0._goinfoTime, false)

		return
	end

	arg_15_0.isCloseEnter = arg_15_0:checkIsCloseEnter(var_15_0)

	local var_15_1 = arg_15_0.enterCloseTime - ServerTime.now()
	local var_15_2 = var_15_0:getRealEndTimeStamp() - ServerTime.now()

	if var_15_1 > 0 then
		local var_15_3 = TimeUtil.SecondToActivityTimeFormat(var_15_1)

		arg_15_0._txtLimitTime.text = var_15_3
	else
		arg_15_0._txtLimitTime.text = luaLang("ended")
	end

	gohelper.setActive(arg_15_0._goinfoTime, var_15_2 > 0)

	arg_15_0._txtinfoTime.text = var_15_0:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.checkIsCloseEnter(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getRealEndTimeStamp()
	local var_16_1 = arg_16_1:getRealStartTimeStamp()
	local var_16_2 = var_16_0 - ServerTime.now() > 0

	if arg_16_0.closeEnterTimeOffset == 0 then
		arg_16_0.enterCloseTime = var_16_0

		return false
	end

	arg_16_0.enterCloseTime = var_16_1 + arg_16_0.closeEnterTimeOffset * TimeUtil.OneDaySecond

	local var_16_3 = ServerTime.now() > arg_16_0.enterCloseTime

	return var_16_2 and var_16_3
end

function var_0_0.refreshInformationCoin(arg_17_0)
	local var_17_0 = CurrencyModel.instance:getCurrency(arg_17_0.infoCoinId)

	arg_17_0._txtcoinNum.text = GameUtil.numberDisplay(var_17_0.quantity)
end

function var_0_0._onCloseViewFinish(arg_18_0, arg_18_1)
	if arg_18_1 == ViewName.Season166InformationMainView then
		arg_18_0:refreshReddot()
	end
end

function var_0_0.refreshReddot(arg_19_0)
	RedDotController.instance:addRedDot(arg_19_0._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, arg_19_0.checkReddotShow, arg_19_0)
end

function var_0_0.checkReddotShow(arg_20_0, arg_20_1)
	arg_20_1:defaultRefreshDot()

	if Season166Model.instance:checkHasNewUnlockInfo() then
		gohelper.setActive(arg_20_0._goinfoNewReddot, true)
		gohelper.setActive(arg_20_0._goinfoReddot, false)
	else
		gohelper.setActive(arg_20_0._goinfoNewReddot, false)
		gohelper.setActive(arg_20_0._goinfoReddot, true)
		arg_20_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.onDestroyView(arg_21_0)
	var_0_0.super.onDestroyView(arg_21_0)
	arg_21_0._simageFullBG:UnLoadImage()
end

return var_0_0
