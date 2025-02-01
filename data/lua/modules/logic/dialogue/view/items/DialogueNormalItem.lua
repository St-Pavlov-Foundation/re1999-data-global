module("modules.logic.dialogue.view.items.DialogueNormalItem", package.seeall)

slot0 = class("DialogueNormalItem", DialogueItem)

function slot0.initView(slot0)
	slot0.simageAvatar = gohelper.findChildSingleImage(slot0.go, "rolebg/#image_avatar")
	slot0.txtName = gohelper.findChildText(slot0.go, "#txt_name")
	slot0.txtContent = gohelper.findChildText(slot0.go, "content_bg/#txt_content")
	slot0.goLoading = gohelper.findChild(slot0.go, "content_bg/#go_loading")
	slot0.contentBgRectTr = gohelper.findChildComponent(slot0.go, "content_bg", gohelper.Type_RectTransform)
	slot0.txtRectTr = slot0.txtContent:GetComponent(gohelper.Type_RectTransform)
end

function slot0.refresh(slot0)
	slot0.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(slot0.stepCo.avatar))

	slot0.txtName.text = slot0.stepCo.name
	slot0.txtContent.text = slot0.stepCo.content

	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function slot0.calculateHeight(slot0)
	if slot0.txtContent.preferredWidth <= DialogueEnum.MessageTxtMaxWidth then
		slot2 = DialogueEnum.MessageTxtOneLineHeight + DialogueEnum.MessageBgOffsetHeight

		recthelper.setSize(slot0.contentBgRectTr, slot1 + DialogueEnum.MessageBgOffsetWidth, slot2)
		recthelper.setSize(slot0.txtRectTr, slot1, DialogueEnum.MessageTxtOneLineHeight)

		slot0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], slot2 + DialogueEnum.MessageNameHeight)

		return
	end

	slot2 = slot0.txtContent.preferredHeight
	slot3 = slot2 + DialogueEnum.MessageBgOffsetHeight

	recthelper.setSize(slot0.contentBgRectTr, DialogueEnum.MessageTxtMaxWidth + DialogueEnum.MessageBgOffsetWidth, slot3)
	recthelper.setSize(slot0.txtRectTr, DialogueEnum.MessageTxtMaxWidth, slot2)

	slot0.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], slot3 + DialogueEnum.MessageNameHeight)
end

function slot0.logHeight(slot0)
	logError(string.format("【%s】", slot0.stepCo.id) .. " : " .. slot0.txtContent.preferredHeight)
	logError(string.format("【%s】", slot0.stepCo.id) .. " : " .. slot0.txtContent.preferredWidth)
	logError(string.format("【%s】", slot0.stepCo.id) .. " : " .. slot0.txtContent.renderedWidth)
	logError(string.format("【%s】", slot0.stepCo.id) .. " : " .. slot0.txtContent.renderedHeight)
end

function slot0.onDestroy(slot0)
	slot0.simageAvatar:UnLoadImage()
end

return slot0
