module("modules.logic.battlepass.view.BpPropView2Container", package.seeall)

slot0 = class("BpPropView2Container", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpPropView2.New()
	}
end

return slot0
