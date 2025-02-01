module("modules.logic.fight.view.FightCardMixIntroduceView", package.seeall)

slot0 = class("FightCardMixIntroduceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocardcontent1 = gohelper.findChild(slot0.viewGO, "#go_cardcontent1")
	slot0._gocardcontent2 = gohelper.findChild(slot0.viewGO, "#go_cardcontent2")

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
	gohelper.setActive(slot0._gocardcontent1, false)
	gohelper.setActive(slot0._gocardcontent2, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if slot0["_gocardcontent" .. tostring(slot0.viewParam.viewParam)] then
		gohelper.setActive(slot2, true)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
