module("modules.logic.versionactivity1_9.matildagift.view.V1a9_MatildagiftView", package.seeall)

slot0 = class("V1a9_MatildagiftView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnCloseMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_CloseMask")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_PanelBG")
	slot0._simageEnvelope = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Envelope")
	slot0._simageRole = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Role")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._simageLOGO = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_LOGO")
	slot0._simagetxt = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_txt")
	slot0._simageName = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Name")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/#txt_LimitTime")
	slot0._btnGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Get")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnCloseMask:AddClickListener(slot0._btnCloseMaskOnClick, slot0)
	slot0._btnGet:AddClickListener(slot0._btnGetOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.onRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnCloseMask:RemoveClickListener()
	slot0._btnGet:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.onRefresh, slot0)
end

function slot0._btnCloseMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnGetOnClick(slot0)
	V1a9_MatildaGiftModel.instance:onGetBonus()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._imgGet = gohelper.findChild(slot0.viewGO, "Root/#btn_Get")
	slot0._txtGetCn = gohelper.findChildText(slot0.viewGO, "Root/#btn_Get/cn")
	slot0._txtGetEn = gohelper.findChildText(slot0.viewGO, "Root/#btn_Get/en")
	slot0._VXGetBtn = gohelper.findChild(slot0._imgGet, "vx_geteffect")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:onRefresh()
	slot0:_refreshTimeTick()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onRefresh(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._imgGet, not slot1)

	slot0._txtGetCn.text = luaLang(V1a9_MatildaGiftModel.instance:couldGet() and "v1a9_matildagiftview_claim_cn" or "v1a9_matildagiftview_claimed_cn")
	slot0._txtGetEn.text = luaLang(slot1 and "v1a9_matildagiftview_claim_en" or "v1a9_matildagiftview_claimed_en")

	gohelper.setActive(slot0._VXGetBtn, slot1)
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.V1a9_Matildagift)
end

return slot0
