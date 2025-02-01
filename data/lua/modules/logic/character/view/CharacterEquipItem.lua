module("modules.logic.character.view.CharacterEquipItem", package.seeall)

slot0 = class("CharacterEquipItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._onClick(slot0)
	EquipController.instance:openEquipView({
		equipMO = slot0._mo,
		equipList = CharacterBackpackEquipListModel.instance:_getEquipList()
	})
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot0._commonEquipIcon then
		slot0._commonEquipIcon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, CommonEquipIcon)

		slot0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, slot0._commonEquipIcon)
	end

	slot0._mo = slot1
	slot0._config = EquipConfig.instance:getEquipCo(slot1.equipId)

	slot0._commonEquipIcon:setEquipMO(slot1)
	slot0._commonEquipIcon:refreshLock(slot0._mo.isLock)
	slot0._commonEquipIcon:hideHeroIcon()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()
end

return slot0
