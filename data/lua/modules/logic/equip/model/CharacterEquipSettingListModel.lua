module("modules.logic.equip.model.CharacterEquipSettingListModel", package.seeall)

slot0 = class("CharacterEquipSettingListModel", EquipInfoBaseListModel)

function slot0.onOpen(slot0, slot1, slot2)
	slot0.heroMo = slot1.heroMo

	slot0:initEquipList(slot2)
	slot0:setCurrentShowHeroMo(slot1.heroMo)
	slot0:setCurrentSelectEquipMo(EquipModel.instance:getEquip(slot1.heroMo.defaultEquipUid) or slot0.equipMoList and slot0.equipMoList[1])
end

function slot0.setCurrentShowHeroMo(slot0, slot1)
	slot0.currentShowHeroMo = slot1
end

slot0.instance = slot0.New()

return slot0
