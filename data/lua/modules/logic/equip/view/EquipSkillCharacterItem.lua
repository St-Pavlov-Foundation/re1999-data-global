module("modules.logic.equip.view.EquipSkillCharacterItem", package.seeall)

slot0 = class("EquipSkillCharacterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocharacter = gohelper.findChild(slot0.viewGO, "#go_character")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_character/#simage_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_character/#txt_name")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#go_character/#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0._goclick)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._onClick(slot0)
	if slot0._hero then
		CharacterController.instance:openCharacterView(slot0._hero)
		EquipController.instance:closeEquipSkillTipView()
	else
		GameFacade.showToast(ToastEnum.EquipSkillCharacter)
	end
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot1.id)

	slot0._simageicon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot2.skinId).retangleIcon))

	slot0._txtname.text = slot2.name
	slot0._hero = HeroModel.instance:getByHeroId(slot1.id)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._simageicon:GetComponent(gohelper.Type_Image), slot0._hero and "#FFFFFF" or "#5E6161")
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
