module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalPresetItem", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalPresetItem", V1a6_CachotTeamItem)

function var_0_0.addEvents(arg_1_0)
	var_0_0.super.addEvents(arg_1_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnClickTeamItem, arg_1_0._onClickTeamItem, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	var_0_0.super.removeEvents(arg_2_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnClickTeamItem, arg_2_0._onClickTeamItem, arg_2_0)
end

function var_0_0._onClickTeamItem(arg_3_0, arg_3_1)
	arg_3_0:setSelected(arg_3_0._mo == arg_3_1)
end

function var_0_0._getEquipMO(arg_4_0)
	if arg_4_0._mo then
		arg_4_0._equipMO = V1a6_CachotRoleRevivalPresetListModel.instance:getEquip(arg_4_0._mo)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:_updateHp()
	arg_5_0:setSelectEnable(true)
end

return var_0_0
