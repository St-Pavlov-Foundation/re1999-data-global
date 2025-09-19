module("modules.logic.scene.shelter.comp.SurvivalShelterSceneMapUnitComp", package.seeall)

local var_0_0 = class("SurvivalShelterSceneMapUnitComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0)
	arg_1_0._sceneGo = arg_1_0:getCurScene().level:getSceneGo()
	arg_1_0._unitRoot = gohelper.create3d(arg_1_0._sceneGo, "UnitRoot")
	arg_1_0._allUnits = {}

	for iter_1_0, iter_1_1 in pairs(SurvivalEnum.ShelterUnitType) do
		arg_1_0._allUnits[iter_1_1] = {}
	end

	arg_1_0._unitParent = {}
	arg_1_0._unitType2Cls = {
		[SurvivalEnum.ShelterUnitType.Npc] = SurvivalShelterNpcEntity,
		[SurvivalEnum.ShelterUnitType.Monster] = SurvivalShelterMonsterEntity,
		[SurvivalEnum.ShelterUnitType.Player] = SurvivalShelterPlayerEntity,
		[SurvivalEnum.ShelterUnitType.Build] = SurvivalShelterBuildingEntity
	}

	arg_1_0:addEvents()
	arg_1_0:refreshAllEntity()
end

function var_0_0.refreshAllEntity(arg_2_0)
	arg_2_0:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
	arg_2_0:refreshMonster()
	arg_2_0:refreshNpcList()
	arg_2_0:refreshBuild()
end

function var_0_0.addEvents(arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnRecruitDataUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnBuildingInfoUpdate, arg_3_0.onBuildingInfoUpdate, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnNpcPostionChange, arg_3_0.onNpcPostionChange, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnWeekInfoUpdate, arg_3_0.onWeekInfoUpdate, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.AbandonFight, arg_3_0.refreshMonster, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.BossFightSuccessShowFinish, arg_3_0.refreshMonster, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnRecruitDataUpdate, arg_4_0.onBuildingInfoUpdate, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnBuildingInfoUpdate, arg_4_0.onBuildingInfoUpdate, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnNpcPostionChange, arg_4_0.onNpcPostionChange, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnWeekInfoUpdate, arg_4_0.onWeekInfoUpdate, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.AbandonFight, arg_4_0.refreshMonster, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.BossFightSuccessShowFinish, arg_4_0.refreshMonster, arg_4_0)
end

function var_0_0.onWeekInfoUpdate(arg_5_0)
	arg_5_0:refreshAllEntity()
end

function var_0_0.onBuildingInfoUpdate(arg_6_0, arg_6_1)
	if arg_6_1 then
		local var_6_0 = arg_6_0:getEntity(SurvivalEnum.ShelterUnitType.Build, arg_6_1, true)

		if var_6_0 then
			var_6_0:showBuildEffect()
		end

		return
	end

	arg_6_0:refreshBuild()
	arg_6_0:refreshNpcList()
end

function var_0_0.onNpcPostionChange(arg_7_0)
	arg_7_0:refreshNpcList()
end

function var_0_0.getPlayer(arg_8_0)
	return arg_8_0:getEntity(SurvivalEnum.ShelterUnitType.Player, 0)
end

function var_0_0.refreshBuild(arg_9_0)
	local var_9_0 = SurvivalConfig.instance:getShelterMapCo()
	local var_9_1 = SurvivalShelterModel.instance:getWeekInfo()

	for iter_9_0, iter_9_1 in ipairs(var_9_0.allBuildings) do
		local var_9_2 = var_9_1:getBuildingInfo(iter_9_1.id)

		arg_9_0:refreshEntity(SurvivalEnum.ShelterUnitType.Build, iter_9_1.id, var_9_2 ~= nil)
	end
end

function var_0_0.getBuildEntity(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0:getEntity(SurvivalEnum.ShelterUnitType.Build, arg_10_1, arg_10_2)
end

function var_0_0.refreshNpcList(arg_11_0)
	local var_11_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_11_1 = var_11_0.npcDict

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		local var_11_2 = var_11_0:canShowNpcInShelter(iter_11_1.id)

		arg_11_0:refreshEntity(SurvivalEnum.ShelterUnitType.Npc, iter_11_1.id, var_11_2)
	end
end

function var_0_0.getNpcEntity(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0:getEntity(SurvivalEnum.ShelterUnitType.Npc, arg_12_1, arg_12_2)
end

function var_0_0.addUsedPos(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getPlayer()

	if var_13_0 then
		local var_13_1 = var_13_0:getPos()

		if var_13_1 then
			SurvivalHelper.instance:addNodeToDict(arg_13_1, var_13_1)
		end
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0._allUnits[SurvivalEnum.ShelterUnitType.Monster]) do
		if iter_13_1.ponitRange then
			for iter_13_2, iter_13_3 in pairs(iter_13_1.ponitRange) do
				for iter_13_4, iter_13_5 in pairs(iter_13_3) do
					SurvivalHelper.instance:addNodeToDict(arg_13_1, iter_13_5)
				end
			end
		end
	end

	for iter_13_6, iter_13_7 in pairs(arg_13_0._allUnits[SurvivalEnum.ShelterUnitType.Npc]) do
		local var_13_2 = iter_13_7.pos

		if var_13_2 then
			SurvivalHelper.instance:addNodeToDict(arg_13_1, var_13_2)
		end
	end
end

function var_0_0.checkClickUnit(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._allUnits) do
		if iter_14_0 ~= SurvivalEnum.ShelterUnitType.Player then
			for iter_14_2, iter_14_3 in pairs(iter_14_1) do
				if iter_14_3:checkClick(arg_14_1) then
					SurvivalMapHelper.instance:gotoUnit(iter_14_0, iter_14_2, arg_14_1)

					return true
				end
			end
		end
	end
end

function var_0_0.refreshMonster(arg_15_0)
	local var_15_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_15_0 then
		local var_15_1 = var_15_0:canShowEntity()
		local var_15_2, var_15_3 = SurvivalShelterModel.instance:getNeedShowFightSuccess()

		if var_15_1 or var_15_3 == nil then
			var_15_3 = var_15_0.fightId
		end

		if var_15_2 then
			local var_15_4 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

			gohelper.setActive(var_15_4, false)
			PopupController.instance:setPause(ViewName.SurvivalGetRewardView, true)
		end

		arg_15_0:refreshEntity(SurvivalEnum.ShelterUnitType.Monster, var_15_3, var_15_1 or var_15_2)

		if var_15_2 ~= nil and not var_15_2 then
			local var_15_5 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

			gohelper.setActive(var_15_5, true)
			PopupController.instance:setPause(ViewName.SurvivalGetRewardView, false)
			arg_15_0:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
			SurvivalController.instance:dispatchEvent(SurvivalEvent.BossPerformFinish)
			SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
		end
	end
end

function var_0_0.getMonsterEntity(arg_16_0, arg_16_1, arg_16_2)
	return arg_16_0:getEntity(SurvivalEnum.ShelterUnitType.Monster, arg_16_1, arg_16_2)
end

function var_0_0.getEntity(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._allUnits[arg_17_1][arg_17_2]

	if not var_17_0 and arg_17_3 then
		local var_17_1 = arg_17_0._unitType2Cls[arg_17_1]
		local var_17_2 = arg_17_0:getUnitParentGO(arg_17_1)

		var_17_0 = var_17_1.Create(arg_17_1, arg_17_2, var_17_2)
	end

	return var_17_0
end

function var_0_0.addEntity(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_3 then
		return
	end

	arg_18_0._allUnits[arg_18_1][arg_18_2] = arg_18_3
end

function var_0_0.delEntity(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getEntity(arg_19_1, arg_19_2)

	if not var_19_0 then
		return
	end

	gohelper.destroy(var_19_0.go)

	arg_19_0._allUnits[arg_19_1][arg_19_2] = nil
end

function var_0_0.refreshEntity(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_3 then
		arg_20_0:getEntity(arg_20_1, arg_20_2, true):updateEntity()
	else
		arg_20_0:delEntity(arg_20_1, arg_20_2)
	end
end

function var_0_0.getAllEntity(arg_21_0)
	return arg_21_0._allUnits
end

function var_0_0.getUnitParentGO(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._unitParent[arg_22_1]

	if not var_22_0 then
		var_22_0 = gohelper.create3d(arg_22_0._unitRoot, SurvivalEnum.ShelterUnitTypeToName[arg_22_1])
		arg_22_0._unitParent[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.onSceneClose(arg_23_0)
	arg_23_0:removeEvents()
	gohelper.destroy(arg_23_0._unitRoot)

	arg_23_0._unitRoot = nil
	arg_23_0._sceneGo = nil
	arg_23_0._allUnits = {}
end

return var_0_0
