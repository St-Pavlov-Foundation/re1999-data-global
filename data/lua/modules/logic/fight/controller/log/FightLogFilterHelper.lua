module("modules.logic.fight.controller.log.FightLogFilterHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = {
	FightEnum.EffectType.FIGHTSTEP
}
local var_0_2 = false

function var_0_0.setFilterEffectList(arg_1_0)
	if string.nilorempty(arg_1_0) then
		var_0_2 = false

		return
	end

	var_0_0.resetEffectFilter()
	tabletool.addValues(var_0_1, string.splitToNumber(arg_1_0, ";"))

	var_0_2 = true
end

function var_0_0.resetEffectFilter()
	tabletool.clear(var_0_1)
	table.insert(var_0_1, FightEnum.EffectType.FIGHTSTEP)
end

function var_0_0.checkActEffectDataIsFilter(arg_3_0)
	if not var_0_2 then
		return false
	end

	if tabletool.indexOf(var_0_1, arg_3_0.effectType) then
		return false
	end

	return true
end

return var_0_0
