module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpViewContainer", package.seeall)

slot0 = class("VersionActivity1_5WarmUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivity1_5WarmUpView.New(),
		VersionActivity1_5WarmUpInteract.New()
	}
end

return slot0
