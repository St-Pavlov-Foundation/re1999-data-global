module("modules.logic.character.view.CharacterCategoryItem", package.seeall)

local var_0_0 = class("CharacterCategoryItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gounselected = gohelper.findChild(arg_1_0.viewGO, "#go_unselected")
	arg_1_0._txtitemcn1 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_itemcn1")
	arg_1_0._txtitemen1 = gohelper.findChildText(arg_1_0.viewGO, "#go_unselected/#txt_itemen1")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._selectedAnim = gohelper.findChild(arg_1_0.viewGO, "#go_selected/itemicon2"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtitemcn2 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_itemcn2")
	arg_1_0._txtitemen2 = gohelper.findChildText(arg_1_0.viewGO, "#go_selected/#txt_itemen2")
	arg_1_0._gocatereddot = gohelper.findChild(arg_1_0.viewGO, "#go_catereddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, arg_2_0._refreshRedDot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtitemcn1.text = arg_4_0.viewParam.name
	arg_4_0._txtitemcn2.text = arg_4_0.viewParam.name
	arg_4_0._txtitemen1.text = arg_4_0.viewParam.enName
	arg_4_0._txtitemen2.text = arg_4_0.viewParam.enName
	arg_4_0._index = arg_4_0.viewParam.index

	arg_4_0:updateSeletedStatus(1)
	arg_4_0:_refreshRedDot()

	arg_4_0._click = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
end

function var_0_0._refreshRedDot(arg_5_0)
	if arg_5_0._index == 1 then
		local var_5_0 = CharacterModel.instance:hasRoleCouldUp() or CharacterModel.instance:hasRewardGet()

		gohelper.setActive(arg_5_0._gocatereddot, var_5_0)
	else
		local var_5_1 = false

		gohelper.setActive(arg_5_0._gocatereddot, var_5_1)
	end
end

function var_0_0._onClick(arg_6_0)
	if arg_6_0._isSelected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
	CharacterController.instance:dispatchEvent(CharacterEvent.BackpackChangeCategory, arg_6_0._index)
end

function var_0_0.updateSeletedStatus(arg_7_0, arg_7_1)
	arg_7_0._isSelected = arg_7_0._index == arg_7_1

	arg_7_0._gounselected:SetActive(not arg_7_0._isSelected)
	arg_7_0._goselected:SetActive(arg_7_0._isSelected)

	if arg_7_0._isSelected then
		arg_7_0._selectedAnim:Play("icon_click", 0, 0)
		arg_7_0._selectedAnim:Update(0)
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._click:RemoveClickListener()
end

return var_0_0
