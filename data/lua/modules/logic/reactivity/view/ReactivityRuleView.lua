module("modules.logic.reactivity.view.ReactivityRuleView", package.seeall)

slot0 = class("ReactivityRuleView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_go")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Mask")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._onClickJump, slot0)
	slot0._btnclose1:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnclose2:AddClickListener(slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	ReactivityRuleModel.instance:refreshList()
end

function slot0.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onClickJump(slot0)
	JumpController.instance:jumpByParam("1#180")
end

function slot0._onClickClose(slot0)
	slot0:closeThis()
end

return slot0
