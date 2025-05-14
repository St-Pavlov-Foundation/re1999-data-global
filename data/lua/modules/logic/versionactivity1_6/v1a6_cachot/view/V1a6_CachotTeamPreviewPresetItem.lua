module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreviewPresetItem", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreviewPresetItem", V1a6_CachotTeamItem)

function var_0_0._getEquipMO(arg_1_0)
	if arg_1_0._mo then
		arg_1_0._equipMO = V1a6_CachotTeamPreviewPresetListModel.instance:getEquip(arg_1_0._mo)
	end
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	var_0_0.super.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0:_updateHp()
end

return var_0_0
