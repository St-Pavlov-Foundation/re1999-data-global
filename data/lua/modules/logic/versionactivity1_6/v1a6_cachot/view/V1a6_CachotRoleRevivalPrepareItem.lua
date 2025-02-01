module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalPrepareItem", package.seeall)

slot0 = class("V1a6_CachotRoleRevivalPrepareItem", V1a6_CachotTeamPrepareItem)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)
end

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
end

function slot0.showNone(slot0)
	gohelper.setActive(slot0._gorole, false)
	gohelper.setActive(slot0._goheart, false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_normal"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_none"), true)
end

function slot0.hideDeadStatus(slot0, slot1)
	slot0._hideDeadStatus = slot1
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:_updateHp()
	slot0:setSelectEnable(true)
end

function slot0._showDeadStatus(slot0, slot1)
	if slot0._hideDeadStatus then
		return
	end

	uv0.super._showDeadStatus(slot0, slot1)
end

return slot0
