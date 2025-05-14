module("modules.logic.equip.view.EquipSkillCharacterItem", package.seeall)

local var_0_0 = class("EquipSkillCharacterItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocharacter = gohelper.findChild(arg_1_0.viewGO, "#go_character")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_character/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_character/#txt_name")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_character/#go_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClickWithAudio(arg_4_0._goclick)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	if arg_5_0._hero then
		CharacterController.instance:openCharacterView(arg_5_0._hero)
		EquipController.instance:closeEquipSkillTipView()
	else
		GameFacade.showToast(ToastEnum.EquipSkillCharacter)
	end
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_1.id)
	local var_8_1 = SkinConfig.instance:getSkinCo(var_8_0.skinId)

	arg_8_0._simageicon:LoadImage(ResUrl.getHeadIconSmall(var_8_1.retangleIcon))

	arg_8_0._txtname.text = var_8_0.name
	arg_8_0._hero = HeroModel.instance:getByHeroId(arg_8_1.id)

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._simageicon:GetComponent(gohelper.Type_Image), arg_8_0._hero and "#FFFFFF" or "#5E6161")
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._click:RemoveClickListener()
end

return var_0_0
