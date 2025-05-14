module("modules.logic.explore.map.ExploreMapFOVComp", package.seeall)

local var_0_0 = class("ExploreMapFOVComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._showRange = 8
	arg_1_0._hideRange = 12
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.OnCharacterNodeChange, arg_2_0._onCharacterNodeChange, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.OnUnitNodeChange, arg_2_0._onUnitNodeChange, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.SetFovTargetPos, arg_2_0._setFovTargetPos, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.OnCharacterNodeChange, arg_3_0._onCharacterNodeChange, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.OnUnitNodeChange, arg_3_0._onUnitNodeChange, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.SetFovTargetPos, arg_3_0._setFovTargetPos, arg_3_0)
end

function var_0_0.setMap(arg_4_0, arg_4_1)
	arg_4_0._map = arg_4_1

	arg_4_0:_onCharacterNodeChange()
end

function var_0_0._onCharacterNodeChange(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:_checkFov()
end

function var_0_0._setFovTargetPos(arg_6_0, arg_6_1)
	arg_6_0._targetPos = arg_6_1

	arg_6_0:_checkFov()
end

function var_0_0._checkFov(arg_7_0)
	local var_7_0 = arg_7_0._map:getAllUnit()

	if not var_7_0 then
		return
	end

	local var_7_1 = arg_7_0._map:getHeroPos()

	if arg_7_0._targetPos then
		var_7_1 = ExploreHelper.posToTile(arg_7_0._targetPos)
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		arg_7_0:_checkUnitInFov(iter_7_1, var_7_1)
	end
end

function var_0_0._onUnitNodeChange(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._targetPos or arg_8_0._map:getHeroPos()

	arg_8_0:_checkUnitInFov(arg_8_1, var_8_0)
end

function var_0_0._checkUnitInFov(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:isInFOV()

	if ExploreModel.instance:isUseItemOrUnit(arg_9_1.id) then
		if not var_9_0 then
			arg_9_1:setInFOV(true)
		end

		return
	end

	local var_9_1 = ExploreHelper.getDistanceRound(arg_9_2, arg_9_1.nodePos)

	if var_9_0 then
		if var_9_1 >= arg_9_0._hideRange then
			arg_9_1:setInFOV(false)
		end
	elseif var_9_1 <= arg_9_0._showRange then
		arg_9_1:setInFOV(true)
	end
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._map = nil
	arg_10_0._targetPos = nil
end

return var_0_0
