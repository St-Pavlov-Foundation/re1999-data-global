module("modules.logic.versionactivity1_9.matildagift.view.V1a9_MatildagiftView", package.seeall)

local var_0_0 = class("V1a9_MatildagiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCloseMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseMask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageEnvelope = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Envelope")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Role")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._simageLOGO = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_LOGO")
	arg_1_0._simagetxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_txt")
	arg_1_0._simageName = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Name")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/#txt_LimitTime")
	arg_1_0._btnGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Get")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseMask:AddClickListener(arg_2_0._btnCloseMaskOnClick, arg_2_0)
	arg_2_0._btnGet:AddClickListener(arg_2_0._btnGetOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.onRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseMask:RemoveClickListener()
	arg_3_0._btnGet:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.onRefresh, arg_3_0)
end

function var_0_0._btnCloseMaskOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnGetOnClick(arg_5_0)
	V1a9_MatildaGiftModel.instance:onGetBonus()
end

function var_0_0._btnCloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._imgGet = gohelper.findChild(arg_7_0.viewGO, "Root/#btn_Get")
	arg_7_0._txtGetCn = gohelper.findChildText(arg_7_0.viewGO, "Root/#btn_Get/cn")
	arg_7_0._txtGetEn = gohelper.findChildText(arg_7_0.viewGO, "Root/#btn_Get/en")
	arg_7_0._VXGetBtn = gohelper.findChild(arg_7_0._imgGet, "vx_geteffect")
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onRefresh()
	arg_9_0:_refreshTimeTick()
	TaskDispatcher.runRepeat(arg_9_0._refreshTimeTick, arg_9_0, 1)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._refreshTimeTick, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

function var_0_0.onRefresh(arg_12_0)
	local var_12_0 = V1a9_MatildaGiftModel.instance:couldGet()
	local var_12_1 = var_12_0 and "v1a9_matildagiftview_claim_cn" or "v1a9_matildagiftview_claimed_cn"
	local var_12_2 = var_12_0 and "v1a9_matildagiftview_claim_en" or "v1a9_matildagiftview_claimed_en"

	ZProj.UGUIHelper.SetGrayscale(arg_12_0._imgGet, not var_12_0)

	arg_12_0._txtGetCn.text = luaLang(var_12_1)
	arg_12_0._txtGetEn.text = luaLang(var_12_2)

	gohelper.setActive(arg_12_0._VXGetBtn, var_12_0)
end

function var_0_0._refreshTimeTick(arg_13_0)
	arg_13_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V1a9_Matildagift)
end

return var_0_0
