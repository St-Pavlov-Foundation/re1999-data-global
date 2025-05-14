module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPrepareItem", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPrepareItem", V1a6_CachotTeamItem)

function var_0_0.showNone(arg_1_0)
	gohelper.setActive(arg_1_0._gorole, false)
	gohelper.setActive(arg_1_0._goheart, false)

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "bg_normal")
	local var_1_1 = gohelper.findChild(arg_1_0.viewGO, "bg_none")

	gohelper.setActive(var_1_0, false)
	gohelper.setActive(var_1_1, true)
end

return var_0_0
