module("modules.logic.survival.view.shelter.ShelterSceneUnitView", package.seeall)

local var_0_0 = class("ShelterSceneUnitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._sceneroot = gohelper.findChild(arg_1_0.viewGO, "go_ui")
	arg_1_0._sceneroot2 = gohelper.findChild(arg_1_0.viewGO, "go_ui2")
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitDel, arg_2_0._onUnitDel, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitAdd, arg_2_0._onUnitAdd, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitChange, arg_2_0._onUnitChange, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMainViewVisible, arg_2_0.onMainViewVisible, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitDel, arg_3_0._onUnitDel, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitAdd, arg_3_0._onUnitAdd, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitChange, arg_3_0._onUnitChange, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMainViewVisible, arg_3_0.onMainViewVisible, arg_3_0)
end

function var_0_0.onMainViewVisible(arg_4_0, arg_4_1)
	if not arg_4_0._allUI then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0._allUI) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			iter_4_3:playAnim(arg_4_1 and UIAnimationName.Open or UIAnimationName.Close)
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._allUI = {}
	arg_5_0._itemResPath = arg_5_0.viewContainer._viewSetting.otherRes.unititem
	arg_5_0._allLayers = arg_5_0:getUserDataTb_()

	arg_5_0:initAllUnit()
end

function var_0_0.initAllUnit(arg_6_0)
	local var_6_0 = SurvivalMapHelper.instance:getAllShelterEntity()

	if not var_6_0 then
		return
	end

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			arg_6_0:addUnitUI(iter_6_0, iter_6_2)
		end
	end
end

function var_0_0._onUnitDel(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:removeUnitUI(arg_7_1, arg_7_2)
end

function var_0_0._onUnitAdd(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:addUnitUI(arg_8_1, arg_8_2)
end

function var_0_0._onUnitChange(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:refreshUnitUI(arg_9_1, arg_9_2)
end

function var_0_0.addUnitUI(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getUnitDict(arg_10_1)
	local var_10_1 = var_10_0[arg_10_2]

	if not var_10_1 then
		local var_10_2 = SurvivalMapHelper.instance:getShelterEntity(arg_10_1, arg_10_2)

		if var_10_2 and var_10_2:needUI() then
			local var_10_3 = arg_10_1 * 100
			local var_10_4 = arg_10_0:getLayerGO(var_10_3)
			local var_10_5 = string.format("%s_%s", SurvivalEnum.ShelterUnitTypeToName[arg_10_1], arg_10_2)
			local var_10_6 = arg_10_0:getResInst(arg_10_0._itemResPath, var_10_4, var_10_5)

			var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_6, ShelterUnitUIItem, {
				unitType = arg_10_1,
				unitId = arg_10_2,
				root1 = var_10_4,
				root2 = arg_10_0._sceneroot2
			})
			var_10_0[arg_10_2] = var_10_1
		end
	end

	return var_10_1
end

function var_0_0.removeUnitUI(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getUnitDict(arg_11_1)
	local var_11_1 = var_11_0[arg_11_2]

	if var_11_1 then
		var_11_1:dispose()

		var_11_0[arg_11_2] = nil
	end
end

function var_0_0.refreshUnitUI(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getUnitDict(arg_12_1)

	if arg_12_2 then
		local var_12_1 = var_12_0[arg_12_2]

		if var_12_1 then
			var_12_1:refreshInfo()
		end
	else
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			iter_12_1:refreshInfo()
		end
	end

	if arg_12_1 == SurvivalEnum.ShelterUnitType.Player then
		arg_12_0:refreshUnitUI(SurvivalEnum.ShelterUnitType.Monster)
		arg_12_0:refreshUnitUI(SurvivalEnum.ShelterUnitType.Npc)
	end
end

function var_0_0.getUnitDict(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._allUI[arg_13_1]

	if not var_13_0 then
		var_13_0 = {}
		arg_13_0._allUI[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.getLayerGO(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or 0

	if not arg_14_0._allLayers[arg_14_1] then
		arg_14_0._allLayers[arg_14_1] = gohelper.create2d(arg_14_0._sceneroot, "Layer" .. arg_14_1)
	end

	return arg_14_0._allLayers[arg_14_1]
end

return var_0_0
