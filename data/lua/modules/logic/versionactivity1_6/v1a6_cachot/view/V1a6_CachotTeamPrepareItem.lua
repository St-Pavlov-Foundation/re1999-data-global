module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPrepareItem", package.seeall)

slot0 = class("V1a6_CachotTeamPrepareItem", V1a6_CachotTeamItem)

function slot0.showNone(slot0)
	gohelper.setActive(slot0._gorole, false)
	gohelper.setActive(slot0._goheart, false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_normal"), false)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "bg_none"), true)
end

return slot0
