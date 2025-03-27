module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_LeftDialogueItem", package.seeall)

slot0 = class("V2a4_WarmUp_DialogueView_LeftDialogueItem", V2a4_WarmUpDialogueItemBase_LR)

function slot0.onInitView(slot0)
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "content_bg/#txt_content")
	slot0._goloading = gohelper.findChild(slot0.viewGO, "content_bg/#go_loading")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.getTemplateGo(slot0)
	return slot0:parent()._goleftdialogueitem
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

return slot0
