module("modules.logic.resonance.model.TalentStyle.TalentStyleListModel", package.seeall)

slot0 = class("TalentStyleListModel", ListScrollModel)

function slot0._sort(slot0, slot1)
	if slot0._isUnlock == slot1._isUnlock then
		if slot0._styleId == 0 then
			return false
		end

		if slot1._styleId == 0 then
			return true
		end

		return slot0._styleId < slot1._styleId
	end

	return slot0._isUnlock
end

function slot0.initData(slot0, slot1)
	slot2 = TalentStyleModel.instance:getStyleMoList(slot1)

	table.sort(slot2, slot0._sort)
	slot0:setList(slot2)
end

function slot0.refreshData(slot0, slot1)
	slot0:setList(TalentStyleModel.instance:refreshMoList(slot1, slot0:getList()))
end

slot0.instance = slot0.New()

return slot0
