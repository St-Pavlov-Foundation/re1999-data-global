module("modules.logic.tower.view.TowerGuideView", package.seeall)

slot0 = class("TowerGuideView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnlook = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_look")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlook:AddClickListener(slot0._btnlookOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlook:RemoveClickListener()
end

function slot0._btnlookOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_artificial_ui_openfunction)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
