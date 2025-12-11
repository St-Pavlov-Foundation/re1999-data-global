module("modules.logic.survival.model.shelter.SurvivalShelterModel", package.seeall)

local var_0_0 = class("SurvivalShelterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._weekInfo = nil
	arg_1_0._bossFightId = nil
	arg_1_0._needShowDestroy = nil
	arg_1_0._needShowBossInvade = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.setWeekData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0._weekInfo then
		arg_3_0._weekInfo = SurvivalShelterWeekMo.New()
	end

	arg_3_0._weekInfo:init(arg_3_1, arg_3_3)

	if not arg_3_0._playerMo then
		arg_3_0._playerMo = SurvivalShelterPlayerMo.New()
	end

	arg_3_0._playerMo:init(arg_3_1.shelterMapId, arg_3_2)
	SurvivalEquipRedDotHelper.instance:checkRed()
end

function var_0_0.getWeekInfo(arg_4_0)
	return arg_4_0._weekInfo
end

function var_0_0.getPlayerMo(arg_5_0)
	return arg_5_0._playerMo
end

function var_0_0.addExRule(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or {}

	local var_6_0 = arg_6_0:getWeekInfo()

	if var_6_0 then
		local var_6_1 = var_6_0:getAttr(SurvivalEnum.AttrType.WorldLevel)
		local var_6_2 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.FightExRule)

		if not string.nilorempty(var_6_2) then
			local var_6_3 = GameUtil.splitString2(var_6_2, true)

			for iter_6_0, iter_6_1 in ipairs(var_6_3) do
				if iter_6_1[1] == var_6_1 then
					table.insert(arg_6_1, {
						iter_6_1[2],
						iter_6_1[3]
					})
				end
			end
		end
	end

	return arg_6_1
end

function var_0_0.haveBoss(arg_7_0)
	if arg_7_0._weekInfo then
		return arg_7_0._weekInfo:getMonsterFight():isFighting()
	else
		return true
	end

	return false
end

function var_0_0.setNeedShowFightSuccess(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._needShowDestroy = arg_8_1

	if arg_8_2 ~= nil then
		arg_8_0._bossFightId = arg_8_2
	end
end

function var_0_0.getNeedShowFightSuccess(arg_9_0)
	return arg_9_0._needShowDestroy, arg_9_0._bossFightId
end

function var_0_0.setNeedShowBossInvade(arg_10_0, arg_10_1)
	arg_10_0._needShowBossInvade = arg_10_1
end

function var_0_0.getNeedShowBossInvade(arg_11_0)
	return arg_11_0._needShowBossInvade
end

var_0_0.instance = var_0_0.New()

return var_0_0
