module("modules.logic.rouge.view.RougeTalentViewContainer", package.seeall)

slot0 = class("RougeTalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeTalentView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		slot0.navigateView:setHelpId(HelpEnum.HelpId.RougeTalentViewHelp)

		return {
			slot0.navigateView
		}
	end
end

return slot0
