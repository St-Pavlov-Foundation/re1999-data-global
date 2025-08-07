module("modules.logic.sp01.odyssey.view.OdysseyEquipInfoTeamItem", package.seeall)

local var_0_0 = class("OdysseyEquipInfoTeamItem", EquipInfoTeamItem)

function var_0_0.refreshSelect(arg_1_0)
	arg_1_0.isSelect = OdysseyEquipInfoTeamListModel.instance:isSelectedEquip(arg_1_0.equipMo.uid)

	arg_1_0._commonEquipIcon:onSelect(arg_1_0.isSelect)
end

function var_0_0.onClickEquip(arg_2_0)
	arg_2_0.isSelect = not arg_2_0.isSelect

	if arg_2_0.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		OdysseyEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(arg_2_0.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		OdysseyEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function var_0_0.refreshHeroIcon(arg_3_0)
	local var_3_0 = OdysseyEquipInfoTeamListModel.instance:getHeroMoByEquipUid(arg_3_0.equipMo.uid)

	if var_3_0 and arg_3_0.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		local var_3_1 = lua_skin.configDict[var_3_0.skin]

		arg_3_0._commonEquipIcon:showHeroIcon(var_3_1)
	else
		arg_3_0._commonEquipIcon:hideHeroIcon()
	end
end

return var_0_0
