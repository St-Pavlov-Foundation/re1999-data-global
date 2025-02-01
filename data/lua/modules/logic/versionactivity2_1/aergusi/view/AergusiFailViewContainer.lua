module("modules.logic.versionactivity2_1.aergusi.view.AergusiFailViewContainer", package.seeall)

slot0 = class("AergusiFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		AergusiFailView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
