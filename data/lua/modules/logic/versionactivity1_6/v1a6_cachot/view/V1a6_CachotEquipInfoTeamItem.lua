module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEquipInfoTeamItem", package.seeall)

local var_0_0 = class("V1a6_CachotEquipInfoTeamItem", ListScrollCellExtend)

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
		V1a6_CachotEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(arg_5_0.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		V1a6_CachotEquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function var_0_0._updateBySeatLevel(arg_6_0)
	local var_6_0 = V1a6_CachotEquipInfoTeamListModel.instance:getSeatLevel()

	if not var_6_0 then
		return
	end

	local var_6_1 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_6_0.equipMo, var_6_0)
	local var_6_2 = arg_6_0.equipMo.level ~= var_6_1

	arg_6_0._commonEquipIcon._txtlevel.text = var_6_1

	local var_6_3 = gohelper.findChildText(arg_6_0._commonEquipIcon._txtlevel.gameObject, "lv")

	if var_6_2 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._commonEquipIcon._txtlevel, "#bfdaff")
		SLFramework.UGUI.GuiHelper.SetColor(var_6_3, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(var_6_3, "#ffffff")
		SLFramework.UGUI.GuiHelper.SetColor(arg_6_0._commonEquipIcon._txtlevel, "#ffffff")
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.equipMo = arg_7_1

	arg_7_0._commonEquipIcon:setSelectUIVisible(true)
	arg_7_0._commonEquipIcon:hideLockIcon()
	arg_7_0._commonEquipIcon:setEquipMO(arg_7_0.equipMo)
	arg_7_0._commonEquipIcon:setCountFontSize(33)
	arg_7_0._commonEquipIcon:setLevelPos(24, -2)
	arg_7_0._commonEquipIcon:setLevelFontColor("#ffffff")
	arg_7_0:refreshSelect()
	arg_7_0:refreshHeroIcon()

	local var_7_0, var_7_1, var_7_2 = HeroGroupBalanceHelper.getBalanceLv()

	arg_7_0._commonEquipIcon:setBalanceLv(var_7_2)
	arg_7_0:_updateBySeatLevel()
end

function var_0_0.refreshSelect(arg_8_0)
	arg_8_0.isSelect = V1a6_CachotEquipInfoTeamListModel.instance:isSelectedEquip(arg_8_0.equipMo.uid)

	arg_8_0._commonEquipIcon:onSelect(arg_8_0.isSelect)
end

function var_0_0.refreshHeroIcon(arg_9_0)
	local var_9_0 = V1a6_CachotEquipInfoTeamListModel.instance:getHeroMoByEquipUid(arg_9_0.equipMo.uid)

	if var_9_0 and arg_9_0.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		local var_9_1 = lua_skin.configDict[var_9_0.skin]

		arg_9_0._commonEquipIcon:showHeroIcon(var_9_1)
	else
		arg_9_0._commonEquipIcon:hideHeroIcon()
	end
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, arg_10_0.refreshSelect, arg_10_0)
end

return var_0_0
