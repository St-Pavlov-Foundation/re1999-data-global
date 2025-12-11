module("modules.logic.scene.survival.comp.SurvivaSceneMapUnitComp", package.seeall)

local var_0_0 = class("SurvivaSceneMapUnitComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._unitRoot = gohelper.create3d(arg_1_0._sceneGo, "UnitRoot")
	arg_1_0._allUnits = {}

	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_1_0 then
		return
	end

	arg_1_0:addEvents()

	arg_1_0._player = SurvivalPlayerEntity.Create(var_1_0.player, arg_1_0._unitRoot)

	SurvivalMapHelper.instance:addEntity(0, arg_1_0._player)

	for iter_1_0, iter_1_1 in pairs(var_1_0.unitsById) do
		arg_1_0._allUnits[iter_1_0] = SurvivalUnitEntity.Create(iter_1_1, arg_1_0._unitRoot)

		SurvivalMapHelper.instance:addEntity(iter_1_0, arg_1_0._allUnits[iter_1_0])

		local var_1_1 = iter_1_1:getWarmingRange()

		if var_1_1 then
			arg_1_0:_showEffect(iter_1_1.id, iter_1_1.pos, var_1_1)
		end
	end
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitAdd, arg_2_0._onUnitAdd, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitPosChange, arg_2_0._onUnitPosChange, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, arg_2_0._onUnitChange, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, arg_2_0._onUnitDel, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_2_0._onAttrUpdate, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapDestoryPosAdd, arg_2_0.onMapDestoryPosAdd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitAdd, arg_3_0._onUnitAdd, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitPosChange, arg_3_0._onUnitPosChange, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, arg_3_0._onUnitChange, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, arg_3_0._onUnitDel, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_3_0._onAttrUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapDestoryPosAdd, arg_3_0.onMapDestoryPosAdd, arg_3_0)
end

function var_0_0._onAttrUpdate(arg_4_0, arg_4_1)
	if arg_4_1 == SurvivalEnum.AttrType.HeroFightLevel then
		local var_4_0 = SurvivalMapModel.instance:getSceneMo()

		if not var_4_0 then
			return
		end

		for iter_4_0, iter_4_1 in pairs(var_4_0.unitsById) do
			if not iter_4_1:getWarmingRange() then
				SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(iter_4_1.id)
			end
		end
	end
end

function var_0_0.onMapDestoryPosAdd(arg_5_0)
	local var_5_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_5_0 then
		return
	end

	for iter_5_0, iter_5_1 in pairs(var_5_0.unitsById) do
		local var_5_1 = iter_5_1:getWarmingRange()

		if var_5_1 then
			arg_5_0:_showEffect(iter_5_1.id, iter_5_1.pos, var_5_1)
		end
	end
end

function var_0_0._onUnitDel(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._allUnits[arg_6_1.id] then
		if arg_6_1:getWarmingRange() then
			SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(arg_6_1.id)
		end

		arg_6_0._allUnits[arg_6_1.id]:tryRemove(arg_6_2)

		arg_6_0._allUnits[arg_6_1.id] = nil
	end
end

function var_0_0._onUnitAdd(arg_7_0, arg_7_1)
	if not arg_7_0._allUnits[arg_7_1.id] then
		local var_7_0 = arg_7_1:getWarmingRange()

		if var_7_0 then
			arg_7_0:_showEffect(arg_7_1.id, arg_7_1.pos, var_7_0)
		end

		arg_7_0._allUnits[arg_7_1.id] = SurvivalUnitEntity.Create(arg_7_1, arg_7_0._unitRoot)

		SurvivalMapHelper.instance:addEntity(arg_7_1.id, arg_7_0._allUnits[arg_7_1.id])
	end
end

function var_0_0._onUnitPosChange(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2.visionVal == 8 or arg_8_3 then
		return
	end

	local var_8_0 = arg_8_2:getWarmingRange()

	if var_8_0 then
		SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(arg_8_2.id)
		arg_8_0:_showEffect(arg_8_2.id, arg_8_2.pos, var_8_0)
	end
end

function var_0_0._onUnitChange(arg_9_0, arg_9_1)
	local var_9_0 = SurvivalMapModel.instance:getSceneMo().unitsById[arg_9_1]

	if not var_9_0 then
		return
	end

	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(arg_9_1)

	local var_9_1 = var_9_0:getWarmingRange()

	if var_9_1 and var_9_0.visionVal ~= 8 then
		arg_9_0:_showEffect(var_9_0.id, var_9_0.pos, var_9_1)
	end
end

function var_0_0._showEffect(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = SurvivalMapModel.instance:getCurMapCo().walkables

	for iter_10_0, iter_10_1 in ipairs(SurvivalHelper.instance:getAllPointsByDis(arg_10_2, arg_10_3)) do
		if SurvivalHelper.instance:getValueFromDict(var_10_0, iter_10_1) then
			SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(arg_10_1, iter_10_1.q, iter_10_1.r, 1)
		end
	end
end

function var_0_0.onSceneClose(arg_11_0)
	arg_11_0:removeEvents()
	gohelper.destroy(arg_11_0._unitRoot)

	arg_11_0._unitRoot = nil
	arg_11_0._sceneGo = nil
	arg_11_0._allUnits = {}
end

return var_0_0
