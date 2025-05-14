module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPrepareItem", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreviewPrepareItem", V1a6_CachotTeamPrepareItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0._getEquipMO(arg_2_0)
	return
end

function var_0_0.showNone(arg_3_0)
	gohelper.setActive(arg_3_0._gorole, false)
	gohelper.setActive(arg_3_0._goheart, false)

	local var_3_0 = gohelper.findChild(arg_3_0.viewGO, "bg_normal")
	local var_3_1 = gohelper.findChild(arg_3_0.viewGO, "bg_none")

	gohelper.setActive(var_3_0, false)
	gohelper.setActive(var_3_1, true)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	var_0_0.super.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0:_updateHp()
end

return var_0_0
