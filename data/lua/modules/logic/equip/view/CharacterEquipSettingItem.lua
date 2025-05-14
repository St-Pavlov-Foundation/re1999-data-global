module("modules.logic.equip.view.CharacterEquipSettingItem", package.seeall)

local var_0_0 = class("CharacterEquipSettingItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "#go_equip")

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
	arg_4_0.click = gohelper.getClick(arg_4_0.viewGO)

	arg_4_0.click:AddClickListener(arg_4_0.onClickEquip, arg_4_0)

	arg_4_0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(arg_4_0._goequip, 0.85)

	EquipController.instance:registerCallback(EquipEvent.ChangeSelectedEquip, arg_4_0.refreshSelect, arg_4_0)
end

function var_0_0.onClickEquip(arg_5_0)
	arg_5_0.isSelect = not arg_5_0.isSelect

	if arg_5_0.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		CharacterEquipSettingListModel.instance:setCurrentSelectEquipMo(arg_5_0.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		CharacterEquipSettingListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0.equipMo = arg_6_1

	arg_6_0._commonEquipIcon:setSelectUIVisible(true)
	arg_6_0._commonEquipIcon:hideLockIcon()
	arg_6_0._commonEquipIcon:setEquipMO(arg_6_0.equipMo)
	arg_6_0._commonEquipIcon:isShowRefineLv(true)
	arg_6_0._commonEquipIcon:setCountFontSize(33)
	arg_6_0._commonEquipIcon:setLevelPos(24, -2)
	arg_6_0._commonEquipIcon:setLevelFontColor("#ffffff")
	arg_6_0._commonEquipIcon:checkRecommend()
	arg_6_0:refreshSelect()
end

function var_0_0.refreshSelect(arg_7_0)
	arg_7_0.isSelect = CharacterEquipSettingListModel.instance:isSelectedEquip(arg_7_0.equipMo.uid)

	arg_7_0._commonEquipIcon:onSelect(arg_7_0.isSelect)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, arg_8_0.refreshSelect, arg_8_0)
end

return var_0_0
