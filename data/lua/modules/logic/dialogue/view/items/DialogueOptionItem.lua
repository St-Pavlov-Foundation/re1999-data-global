module("modules.logic.dialogue.view.items.DialogueOptionItem", package.seeall)

slot0 = class("DialogueOptionItem", DialogueItem)

function slot0.initView(slot0)
	slot0.goOptionItem = gohelper.findChild(slot0.go, "#go_suboptionitem")

	gohelper.setActive(slot0.goOptionItem, false)

	slot0.optionList = GameUtil.splitString2(slot0.stepCo.content, false)
	slot0.optionItemList = {}
	slot0.handled = false
end

function slot0.refresh(slot0)
	for slot4, slot5 in ipairs(slot0.optionList) do
		slot0:createOption(slot5[1], tonumber(slot5[2]))
	end
end

function slot0.createOption(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.cloneInPlace(slot0.goOptionItem)
	slot3.btn = gohelper.findChildButton(slot3.go, "#btn_suboption")
	slot3.txtOption = gohelper.findChildText(slot3.go, "#btn_suboption/#txt_suboption")
	slot3.txtOption.text = slot1
	slot3.goBtn = slot3.btn.gameObject

	slot3.btn:AddClickListener(slot0.onClickOption, slot0, slot2)

	slot3.jumpStepId = slot2

	gohelper.setActive(slot3.go, true)
	table.insert(slot0.optionItemList, slot3)
end

function slot0.onClickOption(slot0, slot1)
	if slot0.handled then
		return
	end

	slot0.handled = true

	for slot5, slot6 in ipairs(slot0.optionItemList) do
		ZProj.UGUIHelper.SetGrayscale(slot6.goBtn, slot1 ~= slot6.jumpStepId)
	end

	DialogueController.instance:dispatchEvent(DialogueEvent.OnClickOption, slot1)
end

function slot0.calculateHeight(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0.go.transform)

	slot0.height = recthelper.getHeight(slot0.go.transform)
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0.optionItemList) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
