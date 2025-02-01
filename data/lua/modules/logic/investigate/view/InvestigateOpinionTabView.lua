module("modules.logic.investigate.view.InvestigateOpinionTabView", package.seeall)

slot0 = class("InvestigateOpinionTabView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "root/#go_container")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.ChangeArrow, slot0._onChangeArrow, slot0)
end

function slot0._onChangeArrow(slot0)
	slot1, slot2 = InvestigateOpinionModel.instance:getInfo()

	if InvestigateOpinionModel.instance:allOpinionLinked(slot1.id) then
		slot0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Extend)
	else
		slot0.viewContainer:switchTab(InvestigateEnum.OpinionTab.Normal)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_leimi_theft_open)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
