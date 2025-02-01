module("modules.logic.dialogue.view.items.DialogueSystemMessageItem", package.seeall)

slot0 = class("DialogueSystemMessageItem", DialogueItem)

function slot0.initView(slot0)
	slot0.txtSystemMessage = gohelper.findChildText(slot0.go, "#txt_systemmessage")
end

function slot0.refresh(slot0)
	slot0.txtSystemMessage.text = slot0.stepCo.content
end

function slot0.calculateHeight(slot0)
	slot0.height = DialogueEnum.MinHeight[DialogueEnum.Type.SystemMessage]
end

function slot0.onDestroy(slot0)
end

return slot0
