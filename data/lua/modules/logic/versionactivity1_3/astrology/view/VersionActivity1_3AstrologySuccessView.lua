module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySuccessView", package.seeall)

slot0 = class("VersionActivity1_3AstrologySuccessView", BaseView)

function slot0.onInitView(slot0)
	slot0._goSuccess = gohelper.findChild(slot0.viewGO, "#go_Success")
	slot0._simageSuccessBG = gohelper.findChildSingleImage(slot0.viewGO, "#go_Success/#simage_SuccessBG")
	slot0._simageSuccessCircleDec = gohelper.findChildSingleImage(slot0.viewGO, "#go_Success/#simage_SuccessCircleDec")
	slot0._simageSuccessTitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Success/#simage_SuccessTitle")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simageSuccessBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_successtitlebg"))
	TaskDispatcher.cancelTask(slot0._onAminDone, slot0)
	TaskDispatcher.runDelay(slot0._onAminDone, slot0, 3.5)
end

function slot0._onAminDone(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_success)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onAminDone, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageSuccessBG:UnLoadImage()
end

return slot0
