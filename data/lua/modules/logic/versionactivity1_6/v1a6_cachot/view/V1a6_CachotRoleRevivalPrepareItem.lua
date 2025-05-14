module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalPrepareItem", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalPrepareItem", V1a6_CachotTeamPrepareItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, arg_2_0._onClickTeamItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, arg_3_0._onClickTeamItem, arg_3_0)
end

function var_0_0._onClickTeamItem(arg_4_0, arg_4_1)
	arg_4_0:setSelected(arg_4_0._mo == arg_4_1)
end

function var_0_0._getEquipMO(arg_5_0)
	return
end

function var_0_0.showNone(arg_6_0)
	gohelper.setActive(arg_6_0._gorole, false)
	gohelper.setActive(arg_6_0._goheart, false)

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "bg_normal")
	local var_6_1 = gohelper.findChild(arg_6_0.viewGO, "bg_none")

	gohelper.setActive(var_6_0, false)
	gohelper.setActive(var_6_1, true)
end

function var_0_0.hideDeadStatus(arg_7_0, arg_7_1)
	arg_7_0._hideDeadStatus = arg_7_1
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	var_0_0.super.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0:_updateHp()
	arg_8_0:setSelectEnable(true)
end

function var_0_0._showDeadStatus(arg_9_0, arg_9_1)
	if arg_9_0._hideDeadStatus then
		return
	end

	var_0_0.super._showDeadStatus(arg_9_0, arg_9_1)
end

return var_0_0
