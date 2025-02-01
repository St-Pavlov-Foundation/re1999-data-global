module("modules.logic.summon.view.SummonHeroDetailViewContainer", package.seeall)

slot0 = class("SummonHeroDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonHeroDetailView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = true

		if slot0.viewParam and slot0.viewParam.showHome ~= nil then
			slot2 = slot0.viewParam.showHome
		end

		return {
			NavigateButtonsView.New({
				true,
				slot2,
				false
			})
		}
	end
end

return slot0
