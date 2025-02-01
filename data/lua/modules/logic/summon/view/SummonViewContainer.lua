module("modules.logic.summon.view.SummonViewContainer", package.seeall)

slot0 = class("SummonViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_content"))
	table.insert(slot1, SummonView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			MultiView.New({
				SummonCharView.New()
			}),
			MultiView.New({
				SummonEquipView.New(),
				SummonEquipFloatView.New()
			})
		}
	end
end

return slot0
