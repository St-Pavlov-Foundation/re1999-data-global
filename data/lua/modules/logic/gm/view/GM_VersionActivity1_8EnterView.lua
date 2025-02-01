module("modules.logic.gm.view.GM_VersionActivity1_8EnterView", package.seeall)

slot0 = class("GM_VersionActivity1_8EnterView", GM_VersionActivity_EnterView)

function slot0.register()
	uv0.VersionActivityX_XEnterView(VersionActivity1_8EnterView)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterViewTabItemBase_register(VersionActivity1_8EnterViewTabItem2)
end

function slot0.VersionActivityX_XEnterView(slot0)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterView(slot0)

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:refreshUI()

		for slot4, slot5 in ipairs(slot0.activityTabItemList or {}) do
			slot5:afterSetData()
		end
	end
end

return slot0
