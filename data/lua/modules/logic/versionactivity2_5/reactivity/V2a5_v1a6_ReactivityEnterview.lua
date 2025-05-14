module("modules.logic.versionactivity2_5.reactivity.V2a5_v1a6_ReactivityEnterview", package.seeall)

local var_0_0 = class("V2a5_v1a6_ReactivityEnterview", ReactivityEnterview)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "img/#simage_bg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_time")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._btnEnd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_End")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Locked")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/normal/#go_reddot")
	arg_1_0._txtlockedtips = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_store/#go_time")
	arg_1_0._txtstoretime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._btnAchevement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievement_normal")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Exchange")
	arg_1_0.rewardItems = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._onClickEnter(arg_2_0)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(arg_2_0.actId)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_2_1 then
			GameFacade.showToastWithTableParam(var_2_1, var_2_2)
		end

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0.onOpen(arg_3_0)
	var_0_0.super.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewMainActTabSelect)
end

return var_0_0
