module("modules.logic.common.view.CommonInputView", package.seeall)

slot0 = class("CommonInputView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
	slot0._txtyes = gohelper.findChildText(slot0.viewGO, "#btn_yes/#txt_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")
	slot0._txtno = gohelper.findChildText(slot0.viewGO, "#btn_no/#txt_no")
	slot0._input = gohelper.findChildTextMeshInputField(slot0.viewGO, "#input")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._input:AddOnEndEdit(slot0._onEndEdit, slot0)
	slot0._input:AddOnValueChanged(slot0._onValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
	slot0._input:RemoveOnEndEdit()
	slot0._input:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam
	slot0._txttitle.text = slot1.title
	slot0._txtno.text = slot1.cancelBtnName
	slot0._txtyes.text = slot1.sureBtnName

	slot0._input:SetText(slot1.defaultInput)
end

function slot0._btnyesOnClick(slot0)
	if slot0.viewParam.sureCallback then
		if slot1.callbackObj then
			slot1.sureCallback(slot1.callbackObj, slot0._input:GetText())
		else
			slot1.sureCallback(slot2)
		end
	else
		slot0:closeThis()
	end
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()

	if slot0.viewParam.cancelCallback then
		slot1.cancelCallack(slot1.callbackObj)
	end
end

function slot0._onEndEdit(slot0, slot1)
	slot0._input:SetText(GameUtil.filterRichText(slot1 or ""))
end

function slot0._onValueChanged(slot0)
	slot0._input:SetText(GameUtil.getBriefName(string.gsub(slot0._input:GetText(), "\n", ""), slot0.viewParam.characterLimit, ""))
end

return slot0
