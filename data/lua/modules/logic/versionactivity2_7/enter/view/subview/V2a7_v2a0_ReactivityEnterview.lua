module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_v2a0_ReactivityEnterview", package.seeall)

local var_0_0 = class("V2a7_v2a0_ReactivityEnterview", ReactivityEnterview)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/Layout/#txt_time")
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
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Exchange")
	arg_1_0.rewardItems = {}

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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnAchevement:RemoveClickListener()
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnreplay:RemoveClickListener()
	arg_3_0._btnExchange:RemoveClickListener()
	arg_3_0._btnEnd:RemoveClickListener()
end

function var_0_0._onClickEnter(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(arg_4_0.actId)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_4_1 then
			GameFacade.showToastWithTableParam(var_4_1, var_4_2)
		end

		return
	end

	VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.initRedDot(arg_5_0)
	if arg_5_0.actId then
		return
	end

	arg_5_0.actId = VersionActivity2_7Enum.ActivityId.Reactivity

	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_0.actId)

	RedDotController.instance:addRedDot(arg_5_0._goreddot, var_5_0.redDotId)
end

return var_0_0
