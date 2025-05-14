module("modules.logic.gm.view.GM_VersionActivity1_8EnterView", package.seeall)

local var_0_0 = class("GM_VersionActivity1_8EnterView", GM_VersionActivity_EnterView)

function var_0_0.register()
	var_0_0.VersionActivityX_XEnterView(VersionActivity1_8EnterView)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterViewTabItemBase_register(VersionActivity1_8EnterViewTabItem2)
end

function var_0_0.VersionActivityX_XEnterView(arg_2_0)
	GM_VersionActivity_EnterView.VersionActivityX_XEnterView(arg_2_0)

	function arg_2_0._gm_showAllTabIdUpdate(arg_3_0)
		arg_3_0:refreshUI()

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.activityTabItemList or {}) do
			iter_3_1:afterSetData()
		end
	end
end

return var_0_0
