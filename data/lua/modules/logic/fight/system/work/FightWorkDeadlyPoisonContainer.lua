module("modules.logic.fight.system.work.FightWorkDeadlyPoisonContainer", package.seeall)

local var_0_0 = class("FightWorkDeadlyPoisonContainer", FightStepEffectFlow)

var_0_0.existWrapDict = {}
var_0_0.targetDict = {}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:getEffectType()
	local var_1_1 = arg_1_0._fightStepMO.actEffectMOs

	arg_1_0.targetDict = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if not iter_1_1:isDone() and var_1_0 == iter_1_1.effectType then
			arg_1_0:addEffectMo(iter_1_1)
		end
	end

	tabletool.clear(var_0_0.existWrapDict)

	for iter_1_2, iter_1_3 in pairs(arg_1_0.targetDict) do
		local var_1_2 = FightHelper.getEntity(iter_1_2)

		if var_1_2 then
			local var_1_3 = var_1_2:isMySide()

			for iter_1_4, iter_1_5 in pairs(iter_1_3) do
				local var_1_4 = iter_1_5[1]

				if var_1_4 > 0 then
					local var_1_5 = var_1_3 and -var_1_4 or var_1_4

					FightFloatMgr.instance:float(iter_1_2, arg_1_0:getFloatType(), var_1_5)

					if var_1_2.nameUI then
						var_1_2.nameUI:addHp(-var_1_4)
					end

					FightController.instance:dispatchEvent(FightEvent.OnHpChange, var_1_2, -var_1_4)

					if iter_1_5[2] and not var_0_0.existWrapDict[iter_1_2] then
						local var_1_6 = var_1_2.effect:addHangEffect("v2a3_ddg/ddg_innate_02", ModuleEnum.SpineHangPointRoot, nil, 1)

						FightRenderOrderMgr.instance:onAddEffectWrap(iter_1_2, var_1_6)
						var_1_6:setLocalPos(0, 0, 0)

						var_0_0.existWrapDict[iter_1_2] = true
					end
				end
			end
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0.addEffectMo(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.targetId
	local var_2_1 = arg_2_0.targetDict[var_2_0]

	if not var_2_1 then
		var_2_1 = {}
		arg_2_0.targetDict[var_2_0] = var_2_1
	end

	local var_2_2 = tonumber(arg_2_1.reserveId)
	local var_2_3 = not string.nilorempty(arg_2_1.reserveStr)
	local var_2_4 = var_2_1[var_2_2]

	if not var_2_4 then
		var_2_4 = {
			arg_2_1.effectNum,
			var_2_3
		}
		var_2_1[var_2_2] = var_2_4
	else
		var_2_4[1] = var_2_4[1] + arg_2_1.effectNum
	end

	arg_2_1:setDone()
end

function var_0_0.getEffectType(arg_3_0)
	return FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE
end

function var_0_0.getFloatType(arg_4_0)
	return FightEnum.FloatType.damage_origin
end

return var_0_0
