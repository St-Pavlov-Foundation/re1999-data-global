module("modules.logic.gm.view.GM_VersionActivity1_6EnterView", package.seeall)

slot0 = class("GM_VersionActivity1_6EnterView", GM_VersionActivity_EnterView)

function slot0.register()
	GM_VersionActivity_EnterView.VersionActivityX_XEnterView(VersionActivity1_6EnterView)
	GM_VersionActivity_EnterView.VersionActivityEnterViewTabItem_register(VersionActivityEnterViewTabItem)
end

return slot0
