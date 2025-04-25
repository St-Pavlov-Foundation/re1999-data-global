module("modules.logic.versionactivity2_5.challenge.view.Act183FinishView", package.seeall)

slot0 = class("Act183FinishView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	NavigateMgr.instance:removeEscape(slot0.viewName)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0.animatorPlayer:Play(UIAnimationName.Open, slot0.closeThis, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenFinishView)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
