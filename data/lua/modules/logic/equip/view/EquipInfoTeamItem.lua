module("modules.logic.equip.view.EquipInfoTeamItem", package.seeall)

slot0 = class("EquipInfoTeamItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goequip = gohelper.findChild(slot0.viewGO, "#go_equip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClick(slot0.viewGO)

	slot0.click:AddClickListener(slot0.onClickEquip, slot0)

	slot0._commonEquipIcon = IconMgr.instance:getCommonEquipIcon(slot0._goequip, 0.85)

	EquipController.instance:registerCallback(EquipEvent.ChangeSelectedEquip, slot0.refreshSelect, slot0)
end

function slot0.onClickEquip(slot0)
	slot0.isSelect = not slot0.isSelect

	if slot0.isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
		EquipInfoTeamListModel.instance:setCurrentSelectEquipMo(slot0.equipMo)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Forget)
		EquipInfoTeamListModel.instance:setCurrentSelectEquipMo(nil)
	end

	EquipController.instance:dispatchEvent(EquipEvent.ChangeSelectedEquip)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.equipMo = slot1

	slot0._commonEquipIcon:setSelectUIVisible(true)
	slot0._commonEquipIcon:hideLockIcon()
	slot0._commonEquipIcon:setEquipMO(slot0.equipMo)
	slot0._commonEquipIcon:setCountFontSize(33)
	slot0._commonEquipIcon:setLevelPos(24, -2)
	slot0._commonEquipIcon:setLevelFontColor("#ffffff")
	slot0:refreshSelect()
	slot0:refreshHeroIcon()
	slot0._commonEquipIcon:setBalanceLv(slot0._view.viewContainer:getBalanceEquipLv())
end

function slot0.refreshSelect(slot0)
	slot0.isSelect = EquipInfoTeamListModel.instance:isSelectedEquip(slot0.equipMo.uid)

	slot0._commonEquipIcon:onSelect(slot0.isSelect)
end

function slot0.refreshHeroIcon(slot0)
	if EquipInfoTeamListModel.instance:getHeroMoByEquipUid(slot0.equipMo.uid) and slot0.equipMo.equipType ~= EquipEnum.ClientEquipType.TrialHero then
		slot0._commonEquipIcon:showHeroIcon(lua_skin.configDict[slot1.skin])
	else
		slot0._commonEquipIcon:hideHeroIcon()
	end
end

function slot0.onDestroyView(slot0)
	slot0.click:RemoveClickListener()
	EquipController.instance:unregisterCallback(EquipEvent.ChangeSelectedEquip, slot0.refreshSelect, slot0)
end

return slot0
