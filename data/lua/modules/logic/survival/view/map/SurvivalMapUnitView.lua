module("modules.logic.survival.view.map.SurvivalMapUnitView", package.seeall)

local var_0_0 = class("SurvivalMapUnitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._sceneroot = gohelper.findChild(arg_1_0.viewGO, "#go_sceneui")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._allUI = {}
	arg_2_0._itemResPath = arg_2_0.viewContainer._viewSetting.otherRes.unititem
	arg_2_0._allLayers = arg_2_0:getUserDataTb_()

	arg_2_0:initAllUnit()
end

function var_0_0.addEvents(arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, arg_3_0._onUnitDel, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitAdd, arg_3_0._onUnitAdd, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, arg_3_0._onUnitChange, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.UpdateUnitIsShow, arg_3_0._onUnitIsShowChange, arg_3_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, arg_3_0._onFollowTaskUpdate, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, arg_4_0._onUnitDel, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitAdd, arg_4_0._onUnitAdd, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, arg_4_0._onUnitChange, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.UpdateUnitIsShow, arg_4_0._onUnitIsShowChange, arg_4_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, arg_4_0._onFollowTaskUpdate, arg_4_0)
end

function var_0_0.initAllUnit(arg_5_0)
	local var_5_0 = SurvivalMapModel.instance:getSceneMo()
	local var_5_1 = var_5_0.unitsById

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		arg_5_0:addUnitUI(iter_5_0, iter_5_1)
	end

	arg_5_0:addUnitUI(0, var_5_0.player, 99999)
	arg_5_0:_onUnitIsShowChange(0)
end

function var_0_0.addUnitUI(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._allUI[arg_6_1] then
		return
	end

	if not arg_6_3 then
		arg_6_3 = 0

		if arg_6_2.co and arg_6_2.co.priority then
			arg_6_3 = arg_6_2.co.priority
		end
	end

	if not arg_6_0._allLayers[arg_6_3] then
		arg_6_0._allLayers[arg_6_3] = gohelper.create2d(arg_6_0._sceneroot, "Layer" .. arg_6_3)

		local var_6_0 = 0

		for iter_6_0 in pairs(arg_6_0._allLayers) do
			if iter_6_0 < arg_6_3 then
				var_6_0 = var_6_0 + 1
			end
		end

		gohelper.setSibling(arg_6_0._allLayers[arg_6_3], var_6_0)
	end

	local var_6_1 = string.format("%s_%s", SurvivalEnum.UnitTypeToName[arg_6_2.unitType], arg_6_2.id)
	local var_6_2 = arg_6_0:getResInst(arg_6_0._itemResPath, arg_6_0._allLayers[arg_6_3], var_6_1)
	local var_6_3 = arg_6_0:getUnitCls(arg_6_1, arg_6_2)

	arg_6_0._allUI[arg_6_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, var_6_3, arg_6_2)
end

function var_0_0.getUnitCls(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = SurvivalUnitUIItem

	if arg_7_1 == 0 then
		var_7_0 = SurvivalPlayerUIItem
	elseif arg_7_2.unitType == SurvivalEnum.UnitType.Battle then
		var_7_0 = SurvivalFightUIItem
	end

	return var_7_0
end

function var_0_0._onUnitDel(arg_8_0, arg_8_1)
	arg_8_0:removeUnitUI(arg_8_1.id)
end

function var_0_0._onUnitAdd(arg_9_0, arg_9_1)
	arg_9_0:addUnitUI(arg_9_1.id, arg_9_1)
end

function var_0_0._onUnitChange(arg_10_0, arg_10_1)
	if arg_10_0._allUI[arg_10_1] then
		local var_10_0 = SurvivalMapModel.instance:getSceneMo().unitsById[arg_10_1]

		if not var_10_0 then
			return
		end

		if arg_10_0:getUnitCls(arg_10_1, var_10_0) == arg_10_0._allUI[arg_10_1].class then
			arg_10_0._allUI[arg_10_1]:refreshInfo()
		else
			arg_10_0:removeUnitUI(arg_10_1)
			arg_10_0:addUnitUI(arg_10_1, var_10_0)
		end
	end
end

function var_0_0.removeUnitUI(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._allUI[arg_11_1] then
		if arg_11_2 then
			arg_11_0._allUI[arg_11_1]:playCloseAnim()
		else
			arg_11_0._allUI[arg_11_1]:dispose()
		end

		arg_11_0._allUI[arg_11_1] = nil
	end
end

function var_0_0._onUnitIsShowChange(arg_12_0, arg_12_1)
	if arg_12_1 == 0 and arg_12_0._allUI[arg_12_1] then
		local var_12_0 = SurvivalMapHelper.instance:getEntity(arg_12_1)

		if not var_12_0 then
			return
		end

		arg_12_0._allUI[arg_12_1]:setIconEnable(not var_12_0.isShow)
	end
end

function var_0_0._onFollowTaskUpdate(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._allUI) do
		iter_13_1:_onFollowTaskUpdate()
	end
end

return var_0_0
