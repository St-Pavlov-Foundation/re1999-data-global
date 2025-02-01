module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPresetItem", package.seeall)

slot0 = class("V1a6_CachotTeamPreviewPresetItem", V1a6_CachotTeamItem)

function slot0._getEquipMO(slot0)
	if slot0._mo then
		slot0._equipMO = V1a6_CachotTeamPreviewPresetListModel.instance:getEquip(slot0._mo)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:_updateHp()
end

return slot0
