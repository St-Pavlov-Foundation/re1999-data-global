module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationGiftFullView", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationGiftFullView", VersionActivity2_3NewCultivationGiftView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_bg")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._simagedec = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_dec")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/reward/#btn_reward")
	arg_1_0._simageTitle2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/reward/#simage_Title2")
	arg_1_0._btnstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/stone/txt_dec/#btn_stone")
	arg_1_0._btnget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/Btn/#btn_get")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "Root/Btn/hasget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstone:AddClickListener(arg_2_0._btnstoneOnClick, arg_2_0)
	arg_2_0._btnget:AddClickListener(arg_2_0._btngetOnClick, arg_2_0)
	Activity125Controller.instance:registerCallback(Activity125Event.DataUpdate, arg_2_0.onEpisodeFinished, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0.refreshRemainTime, arg_2_0, arg_2_0.REMAIN_TIME_REFRESH_INTERVAL)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstone:RemoveClickListener()
	arg_3_0._btnget:RemoveClickListener()
	Activity125Controller.instance:unregisterCallback(Activity125Event.DataUpdate, arg_3_0.onEpisodeFinished, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.refreshRemainTime, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._actId = arg_5_0.viewParam.actId

	arg_5_0:_refreshUI()
end

return var_0_0
