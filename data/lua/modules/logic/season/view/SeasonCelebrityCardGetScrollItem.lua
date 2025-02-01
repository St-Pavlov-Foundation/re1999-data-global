module("modules.logic.season.view.SeasonCelebrityCardGetScrollItem", package.seeall)

slot0 = class("SeasonCelebrityCardGetScrollItem", SeasonCelebrityCardGetItem)

function slot0.onOpen(slot0)
end

function slot0.onScrollItemRefreshData(slot0, slot1)
	slot0:refreshData(slot1)
end

return slot0
