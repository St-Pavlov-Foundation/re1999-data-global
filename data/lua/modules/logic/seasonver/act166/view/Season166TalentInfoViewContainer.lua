module("modules.logic.seasonver.act166.view.Season166TalentInfoViewContainer", package.seeall)

slot0 = class("Season166TalentInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season166TalentInfoView.New())

	return slot1
end

return slot0
