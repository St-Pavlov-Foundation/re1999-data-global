module("modules.logic.bossrush.view.V1a4_BossRushLevelDetail_Spine", package.seeall)

local var_0_0 = class("V1a4_BossRushLevelDetail_Spine", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gospine = gohelper.findChild(arg_1_1, "#go_spine")
	arg_1_0._gospineTran = arg_1_0._gospine.transform
	arg_1_0._gospineX, arg_1_0._gospineY = recthelper.getAnchor(arg_1_0._gospineTran)
	arg_1_0._uiSpine = GuiSpine.Create(arg_1_0._gospine, false)
end

function var_0_0.setData(arg_2_0, arg_2_1)
	local var_2_0 = FightConfig.instance:getSkinCO(arg_2_1)

	if var_2_0 then
		local var_2_1 = ResUrl.getSpineUIPrefab(var_2_0.spine)

		arg_2_0._uiSpine:showModel()
		arg_2_0._uiSpine:setResPath(var_2_1, arg_2_0._onSpineLoaded, arg_2_0, true)
	else
		arg_2_0._uiSpine:hideModel()
	end
end

function var_0_0.setOffsetXY(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0._gospineX + (arg_3_1 or 0)
	local var_3_1 = arg_3_0._gospineY + (arg_3_2 or 0)

	recthelper.setAnchor(arg_3_0._gospineTran, var_3_0, var_3_1)
end

function var_0_0.setScale(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	transformhelper.setLocalScale(arg_4_0._gospineTran, arg_4_1, arg_4_1, arg_4_1)
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:doClear()
	end

	arg_5_0._uiSpine = nil
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0:onDestroy()
end

return var_0_0
