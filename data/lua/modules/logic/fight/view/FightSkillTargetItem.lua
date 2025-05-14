module("modules.logic.fight.view.FightSkillTargetItem", package.seeall)

local var_0_0 = class("FightSkillTargetItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._cardIcon = gohelper.findChildSingleImage(arg_1_1, "icon")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	local var_2_0 = FightDataHelper.entityMgr:getById(arg_2_1)
	local var_2_1 = FightConfig.instance:getSkinCO(var_2_0.skin)

	arg_2_0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(var_2_1.retangleIcon))

	if var_2_0:isMonster() then
		local var_2_2 = lua_monster.configDict[var_2_0.modelId]

		if var_2_2 and var_2_2.heartVariantId ~= 0 then
			arg_2_0._cardImage = gohelper.findChildImage(arg_2_0.go, "icon")

			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(var_2_2.heartVariantId), arg_2_0._cardImage)
		end
	end
end

function var_0_0.onDestroy(arg_3_0)
	arg_3_0._cardIcon:UnLoadImage()
end

return var_0_0
