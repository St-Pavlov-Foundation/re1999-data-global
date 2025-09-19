module("modules.logic.survival.view.map.comp.SurvivalButtonUnlockPart", package.seeall)

local var_0_0 = class("SurvivalButtonUnlockPart", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unlockConditions = arg_1_1.unlockConditions
	arg_1_0.eventParams = arg_1_1.eventParams
end

function var_0_0.addEventListeners(arg_2_0)
	if arg_2_0.eventParams then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.eventParams) do
			arg_2_0:addEventCb(iter_2_1[1], iter_2_1[2], arg_2_0._onEvent, arg_2_0)
		end
	end

	arg_2_0:refreshButton()
end

function var_0_0.removeEventListeners(arg_3_0)
	if arg_3_0.eventParams then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.eventParams) do
			arg_3_0:removeEventCb(iter_3_1[1], iter_3_1[2], arg_3_0._onEvent, arg_3_0)
		end
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.go = arg_4_1

	arg_4_0:setBtnVisible(true)
end

function var_0_0._onEvent(arg_5_0)
	arg_5_0:refreshButton()
end

function var_0_0.refreshButton(arg_6_0)
	local var_6_0 = arg_6_0:isUnlock()

	arg_6_0:setBtnVisible(var_6_0)
end

function var_0_0.setBtnVisible(arg_7_0, arg_7_1)
	if arg_7_0._isVisible == arg_7_1 then
		return
	end

	arg_7_0._isVisible = arg_7_1

	gohelper.setActive(arg_7_0.go, arg_7_0._isVisible)
end

function var_0_0.isUnlock(arg_8_0)
	if not arg_8_0.unlockConditions then
		return true
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.unlockConditions) do
		if not arg_8_0:_checkCondition(iter_8_1) then
			return false
		end
	end

	return true
end

function var_0_0._checkCondition(arg_9_0, arg_9_1)
	if arg_9_1[1] == SurvivalEnum.ShelterBtnUnlockType.BuildingTypeLev then
		local var_9_0 = arg_9_1[2]
		local var_9_1 = arg_9_1[3]

		return (SurvivalShelterModel.instance:getWeekInfo():checkBuildingTypeLev(var_9_0, var_9_1))
	end

	return true
end

return var_0_0
