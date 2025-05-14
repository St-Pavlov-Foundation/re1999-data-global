module("modules.logic.explore.map.ExploreMapUnitCatchComp", package.seeall)

local var_0_0 = class("ExploreMapUnitCatchComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._mapGo = arg_1_1
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, arg_2_0._onUpdateCatchUnit, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.OnClickHero, arg_2_0._onClickHero, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.HeroResInitDone, arg_2_0._onHeroInitDone, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, arg_3_0._onUpdateCatchUnit, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.HeroResInitDone, arg_3_0._onHeroInitDone, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.OnClickHero, arg_3_0._onClickHero, arg_3_0)
end

function var_0_0.setMap(arg_4_0, arg_4_1)
	arg_4_0._map = arg_4_1
	arg_4_0._hero = arg_4_1:getHero()

	arg_4_0:_onUpdateCatchUnit()

	if arg_4_0._catchUnit then
		arg_4_0._catchUnit:setActive(false)
	end
end

function var_0_0._onHeroInitDone(arg_5_0)
	if arg_5_0._catchUnit then
		arg_5_0._catchUnit:setActive(true)
		arg_5_0._catchUnit:setupRes()
		arg_5_0._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)

		local var_5_0 = arg_5_0._hero:getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right)

		if var_5_0 then
			arg_5_0._catchUnit:setParent(var_5_0, ExploreEnum.ExplorePipePotHangType.Carry)
		end
	end
end

function var_0_0._onUpdateCatchUnit(arg_6_0, arg_6_1)
	local var_6_0 = tonumber(ExploreModel.instance:getUseItemUid())
	local var_6_1 = arg_6_0._catchUnit

	arg_6_0._catchUnit = arg_6_0._map:getUnit(var_6_0, true)

	local var_6_2 = arg_6_0._catchUnit ~= var_6_1

	if arg_6_0._catchUnit then
		arg_6_0._catchUnit:removeFromNode()
	end

	if var_6_2 and arg_6_1 then
		if arg_6_0._catchUnit ~= nil then
			if not arg_6_0._catchUnit.nodePos then
				arg_6_0._catchUnit.nodePos = arg_6_0._catchUnit.mo.nodePos
			end

			ExploreHeroCatchUnitFlow.instance:catchUnit(arg_6_0._catchUnit)
		else
			ExploreHeroCatchUnitFlow.instance:uncatchUnit(var_6_1)
		end
	end
end

function var_0_0.setCatchUnit(arg_7_0, arg_7_1)
	arg_7_0._catchUnit = arg_7_1
end

function var_0_0._onClickHero(arg_8_0)
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	if arg_8_0._hero:isMoving() then
		return
	end

	if arg_8_0._catchUnit then
		ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, arg_8_0._catchUnit.id)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._mapGo = nil
	arg_9_0._map = nil
	arg_9_0._catchUnit = nil
end

return var_0_0
