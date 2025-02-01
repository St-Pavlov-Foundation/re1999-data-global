module("modules.logic.rouge.dlc.101.view.RougeDangerousView", package.seeall)

slot0 = class("RougeDangerousView", BaseView)
slot0.OpenViewDuration = 2.5

function slot0.onInitView(slot0)
	slot0._simagedecbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decbg1")
	slot0._simagedecbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decbg2")
	slot0._simagedecbg3 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decbg3")
	slot0._simagedecbg4 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decbg4")
	slot0._simagedecbg5 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decbg5")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_delay2CloseView()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeDangerousView)
end

function slot0._delay2CloseView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, uv0.OpenViewDuration)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
