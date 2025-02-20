module("modules.logic.versionactivity2_3.act174.view.info.Act174RoleInfoContainer", package.seeall)

slot0 = class("Act174RoleInfoContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act174RoleInfo.New())

	return slot1
end

return slot0
