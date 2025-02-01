module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogEndView", package.seeall)

slot0 = class("AergusiDialogEndView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagedec2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_dec2")
	slot0._simagedec3 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_dec3")
	slot0._simagedec1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_dec1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_finish)
	slot0:_refreshUI()
	TaskDispatcher.runDelay(slot0._onShowFinished, slot0, 2)
end

function slot0._refreshUI(slot0)
end

function slot0._onShowFinished(slot0)
	slot0._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(slot0._realClose, slot0, 0.5)
end

function slot0._realClose(slot0)
	if slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onShowFinished, slot0)
	TaskDispatcher.cancelTask(slot0._realClose, slot0)
end

return slot0
