module("modules.logic.survival.model.shelter.SurvivalShelterTentListModel", package.seeall)

local var_0_0 = class("SurvivalShelterTentListModel", ListScrollModel)

function var_0_0.initViewParam(arg_1_0, arg_1_1)
	arg_1_0.selectBuildingId = arg_1_1 and arg_1_1.buildingId or 0
	arg_1_0.selectPos = nil
	arg_1_0.selectNpcId = 0
	arg_1_0._isQuickSelect = false
end

function var_0_0.isQuickSelect(arg_2_0)
	return arg_2_0._isQuickSelect
end

function var_0_0.changeQuickSelect(arg_3_0)
	arg_3_0._isQuickSelect = not arg_3_0._isQuickSelect
end

function var_0_0.setSelectBuildingId(arg_4_0, arg_4_1)
	if arg_4_0.selectBuildingId == arg_4_1 then
		return
	end

	arg_4_0.selectBuildingId = arg_4_1
	arg_4_0.selectPos = nil

	return true
end

function var_0_0.isSelectBuilding(arg_5_0, arg_5_1)
	return arg_5_0.selectBuildingId == arg_5_1
end

function var_0_0.getSelectBuilding(arg_6_0)
	return arg_6_0.selectBuildingId
end

function var_0_0.setSelectPos(arg_7_0, arg_7_1)
	if arg_7_0.selectPos == arg_7_1 then
		return
	end

	arg_7_0.selectPos = arg_7_1

	return true
end

function var_0_0.getSelectPos(arg_8_0)
	return arg_8_0.selectPos
end

function var_0_0.setSelectNpc(arg_9_0, arg_9_1)
	if arg_9_0.selectNpcId == arg_9_1 then
		arg_9_0.selectNpcId = 0
	else
		arg_9_0.selectNpcId = arg_9_1
	end

	return true
end

function var_0_0.getSelectNpc(arg_10_0)
	return arg_10_0.selectNpcId
end

function var_0_0.getShowList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = SurvivalShelterModel.instance:getWeekInfo().buildingDict

	if var_11_1 then
		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			if iter_11_1:isEqualType(SurvivalEnum.BuildingType.Tent) then
				table.insert(var_11_0, iter_11_1)
			end
		end
	end

	if #var_11_0 > 1 then
		table.sort(var_11_0, SurvivalShelterBuildingMo.sort)
	end

	local var_11_2 = {}

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_3 = {
			buildingInfo = iter_11_3,
			npcCount = iter_11_3:getAttr(SurvivalEnum.AttrType.BuildNpcCapNum)
		}

		var_11_3.npcNum = 0
		var_11_3.npcList = {}

		for iter_11_4 = 1, var_11_3.npcCount do
			var_11_3.npcList[iter_11_4 - 1] = 0
		end

		if iter_11_3.npcs then
			for iter_11_5, iter_11_6 in pairs(iter_11_3.npcs) do
				var_11_3.npcList[iter_11_6] = iter_11_5
				var_11_3.npcNum = var_11_3.npcNum + 1
			end
		end

		table.insert(var_11_2, var_11_3)
	end

	return var_11_2
end

function var_0_0.refreshNpcList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = SurvivalShelterModel.instance:getWeekInfo().npcDict

	if var_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if SurvivalBagSortHelper.filterNpc(arg_12_1, iter_12_1) then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	if #var_12_0 > 1 then
		table.sort(var_12_0, SurvivalShelterNpcMo.sort)
	end

	arg_12_0:setList(var_12_0)
end

function var_0_0.quickSelectNpc(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getSelectBuilding()

	if not var_13_0 then
		return
	end

	local var_13_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_13_2 = var_13_1:getBuildingInfo(var_13_0)

	if not var_13_2 then
		return
	end

	if var_13_1:getNpcPostion(arg_13_1) == var_13_0 then
		if not arg_13_0:isQuickSelect() then
			arg_13_0.selectNpcId = 0
		end

		SurvivalWeekRpc.instance:sendSurvivalNpcChangePositionRequest(arg_13_1, var_13_0, -1)

		return
	end

	local var_13_3 = var_13_2:getAttr(SurvivalEnum.AttrType.BuildNpcCapNum)
	local var_13_4 = {}

	if var_13_2.npcs then
		for iter_13_0, iter_13_1 in pairs(var_13_2.npcs) do
			var_13_4[iter_13_1] = iter_13_0
		end
	end

	for iter_13_2 = 1, var_13_3 do
		if not var_13_4[iter_13_2 - 1] then
			if not arg_13_0:isQuickSelect() then
				arg_13_0.selectNpcId = 0
			end

			SurvivalWeekRpc.instance:sendSurvivalNpcChangePositionRequest(arg_13_1, var_13_0, iter_13_2 - 1)

			return
		end
	end

	GameFacade.showToast(ToastEnum.SurvivalTentFull, var_13_2.baseCo.name)
end

var_0_0.instance = var_0_0.New()

return var_0_0
