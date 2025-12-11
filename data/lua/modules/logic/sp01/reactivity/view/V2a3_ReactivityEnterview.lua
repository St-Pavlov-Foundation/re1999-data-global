module("modules.logic.sp01.reactivity.view.V2a3_ReactivityEnterview", package.seeall)

local var_0_0 = class("V2a3_ReactivityEnterview", ReactivityEnterview)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._btnEnd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Locked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._txtlockedtips = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_store/#go_time")
	arg_1_0._txtstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnAchevement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store/#btn_Exchange")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_task")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_task/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnAchevement:AddClickListener(arg_2_0._onClickAchevementBtn, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._onClickStoreBtn, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._onClickReplay, arg_2_0)
	arg_2_0._btnExchange:AddClickListener(arg_2_0._onClickExchange, arg_2_0)
	arg_2_0._btnEnd:AddClickListener(arg_2_0._onClickEnter, arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAchevement:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnExchange:RemoveClickListener()
	arg_3_0._btnEnd:RemoveClickListener()
	arg_3_0._btntask:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.rewardItems = {}

	var_0_0.super._editableInitView(arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam
	local var_5_1 = VersionActivity2_3Enum.ActivityId.Dungeon

	if var_5_0 then
		var_5_1 = var_5_0.actId
	end

	arg_5_0.actId = var_5_1

	local var_5_2 = ActivityConfig.instance:getActivityCo(arg_5_0.actId)

	RedDotController.instance:addRedDot(arg_5_0._goreddot, var_5_2.redDotId)
	var_0_0.super.onOpen(arg_5_0)
end

function var_0_0._onClickEnter(arg_6_0)
	if not arg_6_0:_isOpenOrThrowToast() then
		return
	end

	VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.initRedDot(arg_7_0)
	return
end

function var_0_0._btntaskOnClick(arg_8_0)
	if not arg_8_0:_isOpenOrThrowToast() then
		return
	end

	VersionActivity2_3DungeonController.instance:openTaskView()
end

function var_0_0._onClickStoreBtn(arg_9_0)
	VersionActivity2_3DungeonController.instance:openStoreView()
end

function var_0_0._isOpenOrThrowToast(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = ActivityHelper.getActivityStatusAndToast(arg_10_0.actId)

	if var_10_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_10_1 then
			GameFacade.showToastWithTableParam(var_10_1, var_10_2)
		end

		return false
	end

	return true
end

function var_0_0.refreshStoreTime(arg_11_0)
	local var_11_0 = arg_11_0.storeActId
	local var_11_1 = ActivityModel.instance:getActMO(var_11_0)

	if not var_11_1 then
		arg_11_0._txttime.text = luaLang("ended")

		return
	end

	local var_11_2 = var_11_1:getRealEndTimeStamp() - ServerTime.now()

	if var_11_2 > TimeUtil.OneDaySecond then
		local var_11_3 = Mathf.Floor(var_11_2 / TimeUtil.OneDaySecond) .. "d"

		arg_11_0._txtstoretime.text = var_11_3

		return
	end

	if var_11_2 > TimeUtil.OneHourSecond then
		local var_11_4 = Mathf.Floor(var_11_2 / TimeUtil.OneHourSecond) .. "h"

		arg_11_0._txtstoretime.text = var_11_4

		return
	end

	arg_11_0._txtstoretime.text = "1h"
end

return var_0_0
