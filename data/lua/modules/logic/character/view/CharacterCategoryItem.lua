module("modules.logic.character.view.CharacterCategoryItem", package.seeall)

slot0 = class("CharacterCategoryItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_unselected")
	slot0._txtitemcn1 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_itemcn1")
	slot0._txtitemen1 = gohelper.findChildText(slot0.viewGO, "#go_unselected/#txt_itemen1")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._selectedAnim = gohelper.findChild(slot0.viewGO, "#go_selected/itemicon2"):GetComponent(typeof(UnityEngine.Animator))
	slot0._txtitemcn2 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_itemcn2")
	slot0._txtitemen2 = gohelper.findChildText(slot0.viewGO, "#go_selected/#txt_itemen2")
	slot0._gocatereddot = gohelper.findChild(slot0.viewGO, "#go_catereddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshRedDot, slot0)
end

function slot0.removeEvents(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshRedDot, slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtitemcn1.text = slot0.viewParam.name
	slot0._txtitemcn2.text = slot0.viewParam.name
	slot0._txtitemen1.text = slot0.viewParam.enName
	slot0._txtitemen2.text = slot0.viewParam.enName
	slot0._index = slot0.viewParam.index

	slot0:updateSeletedStatus(1)
	slot0:_refreshRedDot()

	slot0._click = gohelper.getClick(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._refreshRedDot(slot0)
	if slot0._index == 1 then
		gohelper.setActive(slot0._gocatereddot, CharacterModel.instance:hasRoleCouldUp() or CharacterModel.instance:hasRewardGet())
	else
		gohelper.setActive(slot0._gocatereddot, false)
	end
end

function slot0._onClick(slot0)
	if slot0._isSelected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	CharacterController.instance:dispatchEvent(CharacterEvent.BackpackChangeCategory, slot0._index)
end

function slot0.updateSeletedStatus(slot0, slot1)
	slot0._isSelected = slot0._index == slot1

	slot0._gounselected:SetActive(not slot0._isSelected)
	slot0._goselected:SetActive(slot0._isSelected)

	if slot0._isSelected then
		slot0._selectedAnim:Play("icon_click", 0, 0)
		slot0._selectedAnim:Update(0)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
