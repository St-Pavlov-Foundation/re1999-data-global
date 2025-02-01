module("modules.logic.seasonver.act123.utils.Season123ViewHelper", package.seeall)

slot0 = class("Season123ViewHelper")

function slot0.openView(slot0, slot1, slot2)
	if uv0.getViewName(slot0, slot1) then
		ViewMgr.instance:openView(slot3, slot2)
	end
end

function slot0.getViewName(slot0, slot1, slot2)
	if not ViewName[string.format("Season123%s%s", Activity123Enum.SeasonViewPrefix[slot0 or Season123Model.instance:getCurSeasonId()] or "", slot1)] and not slot2 then
		logError(string.format("cant find season123 view [%s] [%s]", slot0, slot1))
	end

	return slot5 or slot4
end

function slot0.getIconUrl(slot0, slot1, slot2)
	return string.format(slot0, Activity123Enum.SeasonResourcePrefix[slot2 or Season123Model.instance:getCurSeasonId()], slot1)
end

return slot0
