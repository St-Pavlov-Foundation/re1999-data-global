module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPrepareItem", package.seeall)

slot0 = class("V1a6_CachotTeamPreviewPrepareItem", V1a6_CachotTeamPrepareItem)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)
end

function slot0._getEquipMO(slot0)
end

function slot0.showNone(slot0)
	gohelper.setActive(slot0._gorole, false)
	gohelper.setActive(slot0._goheart, false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_normal"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_none"), true)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)
	slot0:_updateHp()
end

return slot0
