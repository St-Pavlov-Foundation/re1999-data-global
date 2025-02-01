module("modules.logic.help.view.LawDescriptionViewContainer", package.seeall)

slot0 = class("LawDescriptionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LawDescriptionView.New()
	}
end

return slot0
