module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverPresetItem", package.seeall)

slot0 = class("V1a6_CachotRoleRecoverPresetItem", V1a6_CachotTeamItem)

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, slot0._onClickTeamItem, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, slot0._onClickTeamItem, slot0)
end

function slot0._onClickTeamItem(slot0, slot1)
	slot0:setSelected(slot0._mo == slot1)
end

function slot0._getEquipMO(slot0)
	if slot0._mo then
		slot0._equipMO = V1a6_CachotRoleRecoverPresetListModel.instance:getEquip(slot0._mo)
	end
end

function slot0.setSelected(slot0, slot1)
	gohelper.setActive(slot0._goselect2, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:_updateHp()
	slot0:setSelectEnable(true)
end

return slot0
