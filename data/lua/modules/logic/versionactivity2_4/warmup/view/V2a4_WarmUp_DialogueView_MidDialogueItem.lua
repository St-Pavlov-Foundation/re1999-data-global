module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueView_MidDialogueItem", package.seeall)

slot0 = class("V2a4_WarmUp_DialogueView_MidDialogueItem", V2a4_WarmUpDialogueItemBase)

function slot0.onInitView(slot0)
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "#txt_content")

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

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txtGo = slot0._txtcontent.gameObject
	slot0._txtTrans = slot0._txtGo.transform
	slot0._oriTxtHeight = recthelper.getHeight(slot0._txtTrans)
	slot0._oriTxtWidth = recthelper.getWidth(slot0._txtTrans)
end

function slot0.getTemplateGo(slot0)
	return slot0:parent()._gomiddialogueItem
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)
	slot0:setText(V2a4_WarmUpConfig.instance:getDialogDesc(slot1.dialogCO))
	slot0:onFlush()
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0.onRefreshLineInfo(slot0)
	slot1 = slot0:preferredHeightTxt()

	recthelper.setSize(slot0._txtTrans, slot0._oriTxtWidth, slot1)
	slot0:addContentItem(slot1)
	slot0:stepEnd()
end

function slot0.setGray(slot0, slot1)
	slot0:grayscale(slot1, slot0._txtGo)
end

return slot0
