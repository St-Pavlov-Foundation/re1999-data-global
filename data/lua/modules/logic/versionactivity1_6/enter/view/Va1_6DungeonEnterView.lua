module("modules.logic.versionactivity1_6.enter.view.Va1_6DungeonEnterView", package.seeall)

local var_0_0 = class("Va1_6DungeonEnterView", VersionActivityEnterBaseSubView)
local var_0_1 = "v1a6_srsj"
local var_0_2 = "srsj"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreRemainTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_time")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goEnterNormal = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/normal")
	arg_1_0._goEnterLocked = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/locked")
	arg_1_0._goEnterFinished = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/finished")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._onClickStoreBtn, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onClickMainActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.refreshUI, arg_4_0)
	arg_4_0:addEventCb(VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, arg_4_0.onEnterVideoFinished, arg_4_0)

	arg_4_0.goRedDot = gohelper.findChild(arg_4_0.viewGO, "entrance/#btn_enter/normal/#go_reddot")

	RedDotController.instance:addRedDot(arg_4_0.goRedDot, RedDotEnum.DotNode.V1a6DungeonEnterBtn)

	arg_4_0._uiSpine = GuiSpine.Create(arg_4_0._gospine, true)
	arg_4_0.actId = VersionActivity1_6Enum.ActivityId.Dungeon

	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0._refreshStoreCurrency, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	var_0_0.super.onOpen(arg_5_0)
	arg_5_0:refreshRemainTime()
	arg_5_0:_refreshStoreCurrency()
	arg_5_0:_initBgSpine()
	arg_5_0:refreshDesc()
	arg_5_0:refreshEnterState()
	arg_5_0:refreshStoreRemainTime()
end

function var_0_0.onClose(arg_6_0)
	var_0_0.super.onClose(arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_refreshStoreCurrency()
	arg_7_0:refreshRemainTime()
	arg_7_0:refreshEnterState()
	arg_7_0:refreshStoreRemainTime()
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._uiSpine then
		arg_8_0._uiSpine = nil
	end
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshRemainTime()
	arg_9_0:refreshEnterState()
	arg_9_0:refreshStoreRemainTime()
end

function var_0_0.refreshDesc(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActivityInfo()[arg_10_0.actId].config.actDesc

	arg_10_0._txtdec.text = var_10_0
end

function var_0_0.refreshEnterState(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = ActivityHelper.getActivityStatusAndToast(arg_11_0.actId)
	local var_11_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore)

	gohelper.setActive(arg_11_0._goEnterLocked, false)
	gohelper.setActive(arg_11_0._goEnterNormal, var_11_0 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(arg_11_0._goEnterFinished, var_11_0 == ActivityEnum.ActivityStatus.Expired)
	gohelper.setActive(arg_11_0._btnstore.gameObject, var_11_3 == ActivityEnum.ActivityStatus.Normal)
end

function var_0_0.everySecondCall(arg_12_0)
	arg_12_0:refreshUI()
end

function var_0_0._initBgSpine(arg_13_0)
	local var_13_0 = var_0_2
	local var_13_1 = ResUrl.getRolesCgStory(var_13_0, var_0_1)

	arg_13_0._uiSpine:setResPath(var_13_1, arg_13_0._onSpineLoaded, arg_13_0)
end

function var_0_0._onSpineLoaded(arg_14_0)
	return
end

function var_0_0._refreshStoreCurrency(arg_15_0)
	local var_15_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon)
	local var_15_1 = var_15_0 and var_15_0.quantity or 0

	arg_15_0._txtStoreNum.text = GameUtil.numberDisplay(var_15_1)
end

function var_0_0.refreshRemainTime(arg_16_0)
	local var_16_0 = ActivityModel.instance:getActivityInfo()[arg_16_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	gohelper.setActive(arg_16_0._txttime, var_16_0 > 0)

	local var_16_1 = TimeUtil.SecondToActivityTimeFormat(var_16_0)

	arg_16_0._txttime.text = var_16_1
end

function var_0_0.refreshStoreRemainTime(arg_17_0)
	local var_17_0 = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.DungeonStore]:getRealEndTimeStamp() - ServerTime.now()

	if var_17_0 > TimeUtil.OneDaySecond then
		local var_17_1 = Mathf.Floor(var_17_0 / TimeUtil.OneDaySecond) .. "d"

		arg_17_0._txtStoreRemainTime.text = var_17_1

		return
	end

	if var_17_0 > TimeUtil.OneHourSecond then
		local var_17_2 = Mathf.Floor(var_17_0 / TimeUtil.OneHourSecond) .. "h"

		arg_17_0._txtStoreRemainTime.text = var_17_2

		return
	end

	arg_17_0._txtStoreRemainTime.text = "1h"
end

function var_0_0._onClickMainActivity(arg_18_0)
	local var_18_0, var_18_1, var_18_2 = ActivityHelper.getActivityStatusAndToast(arg_18_0.actId)

	if var_18_0 ~= ActivityEnum.ActivityStatus.Normal and var_18_1 then
		GameFacade.showToastWithTableParam(var_18_1, var_18_2)

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._onClickStoreBtn(arg_19_0)
	VersionActivity1_6EnterController.instance:openStoreView()
end

return var_0_0
