module("modules.logic.season.utils.SeasonViewHelper", package.seeall)

slot0 = class("SeasonViewHelper")

function slot0.openView(slot0, slot1, slot2)
	if uv0.getViewName(slot0, slot1) then
		ViewMgr.instance:openView(slot3, slot2)
	end
end

function slot0.getViewName(slot0, slot1, slot2)
	if not ViewName[string.format("Season%s%s", Activity104Enum.SeasonViewPrefix[slot0 or Activity104Model.instance:getCurSeasonId()] or "", slot1)] and not slot2 then
		logError(string.format("cant find season view [%s] [%s]", slot0, slot1))
	end

	return slot5
end

function slot0.getSeasonIcon(slot0, slot1)
	return string.format("singlebg/%s/%s", Activity104Enum.SeasonIconFolder[slot1 or Activity104Model.instance:getCurSeasonId()], slot0)
end

function slot0.getAllSeasonViewList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(Activity104Enum.ViewName) do
		if uv0.getViewName(slot0, slot6, true) then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

return slot0
