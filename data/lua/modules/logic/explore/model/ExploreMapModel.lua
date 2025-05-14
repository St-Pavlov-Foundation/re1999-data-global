module("modules.logic.explore.model.ExploreMapModel", package.seeall)

local var_0_0 = class("ExploreMapModel", BaseModel)
local var_0_1 = {}

function var_0_0.createUnitMO(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = arg_1_1[2]

	if not var_0_1[var_1_1] then
		if ExploreEnum.ItemTypeToName[var_1_1] then
			var_1_0 = _G[string.format("Explore%sUnitMO", ExploreEnum.ItemTypeToName[var_1_1])] or _G[string.format("Explore%sMO", ExploreEnum.ItemTypeToName[var_1_1])]
		end

		var_1_0 = var_1_0 or ExploreBaseUnitMO
		var_0_1[var_1_1] = var_1_0
	else
		var_1_0 = var_0_1[var_1_1]
	end

	local var_1_2 = var_1_0.New()

	var_1_2:init(arg_1_1)

	return var_1_2
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.updatHeroPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.posx = arg_4_1
	arg_4_0.posy = arg_4_2
	arg_4_0.dir = arg_4_3
end

function var_0_0.getHeroPos(arg_5_0)
	return arg_5_0.posx or 0, arg_5_0.posy or 0
end

function var_0_0.getHeroDir(arg_6_0)
	return arg_6_0.dir or 0
end

function var_0_0.initMapData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._lightNodeDic = {}
	arg_7_0._lightNodeShowDic = {}
	arg_7_0._boundNodeShowDic = {}
	arg_7_0._nodeDic = {}
	arg_7_0._mapAreaDic = {}
	arg_7_0._unitDic = {}
	arg_7_0._areaUnitDic = {}
	arg_7_0._mapIconDict = {}
	arg_7_0._mapIconDictById = {}
	arg_7_0.outLineCount = 0
	arg_7_0.nowMapRotate = 0
	arg_7_0._isShowReset = false

	local var_7_0
	local var_7_1
	local var_7_2
	local var_7_3

	for iter_7_0, iter_7_1 in ipairs(arg_7_1[1]) do
		local var_7_4 = ExploreNode.New(iter_7_1)

		var_7_0 = var_7_0 and math.min(var_7_0, iter_7_1[1]) or iter_7_1[1]
		var_7_1 = var_7_1 and math.max(var_7_1, iter_7_1[1]) or iter_7_1[1]
		var_7_2 = var_7_2 and math.min(var_7_2, iter_7_1[2]) or iter_7_1[2]
		var_7_3 = var_7_3 and math.max(var_7_3, iter_7_1[2]) or iter_7_1[2]
		arg_7_0._nodeDic[var_7_4.walkableKey] = var_7_4
	end

	arg_7_0.mapBound = Vector4(var_7_0, var_7_1, var_7_2, var_7_3)

	for iter_7_2, iter_7_3 in ipairs(arg_7_1) do
		if iter_7_2 > 1 then
			local var_7_5 = ExploreMapAreaMO.New()

			var_7_5:init(iter_7_3)

			arg_7_0._mapAreaDic[var_7_5.id] = var_7_5
		end
	end

	local var_7_6 = arg_7_0.moveNodes or ""
	local var_7_7 = "(-?%d+)#(-?%d+)"

	for iter_7_4, iter_7_5 in string.gmatch(var_7_6, var_7_7) do
		iter_7_4 = tonumber(iter_7_4)
		iter_7_5 = tonumber(iter_7_5)

		arg_7_0:setNodeLightXY(iter_7_4, iter_7_5)
	end

	arg_7_0:_checkNodeBound()

	for iter_7_6, iter_7_7 in pairs(arg_7_0._mapAreaDic) do
		arg_7_0:updateAreaInfo(iter_7_7)
	end
end

function var_0_0.updateAreaInfo(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1.unitList) do
		arg_8_0:addUnitMO(iter_8_1)

		if iter_8_1.type == ExploreEnum.ItemType.Ice or iter_8_1.type == ExploreEnum.ItemType.Obstacle then
			local var_8_0 = ExploreHelper.getKey(iter_8_1.nodePos)
			local var_8_1 = arg_8_0._nodeDic[var_8_0]

			if var_8_1 then
				if iter_8_1.type == ExploreEnum.ItemType.Ice then
					var_8_1:setNodeType(ExploreEnum.NodeType.Ice)
				elseif iter_8_1.type == ExploreEnum.ItemType.Obstacle then
					var_8_1:setNodeType(ExploreEnum.NodeType.Obstacle)
				end
			end
		end
	end
end

function var_0_0.setSmallMapIconById(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0._mapIconDictById[arg_9_1] == arg_9_3 then
		return
	end

	arg_9_0._mapIconDictById[arg_9_1] = arg_9_3

	arg_9_0:setSmallMapIcon(arg_9_2, arg_9_3)
end

function var_0_0.setSmallMapIcon(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._mapIconDict[arg_10_1] == arg_10_2 then
		return
	end

	arg_10_0._mapIconDict[arg_10_1] = arg_10_2

	ExploreController.instance:dispatchEvent(ExploreEvent.UnitOutlineChange, arg_10_1)
end

function var_0_0.getSmallMapIcon(arg_11_0, arg_11_1)
	return arg_11_0._mapIconDict[arg_11_1]
end

function var_0_0.getNodeDic(arg_12_0)
	return arg_12_0._nodeDic
end

function var_0_0.getNode(arg_13_0, arg_13_1)
	if not arg_13_0._nodeDic then
		return
	end

	return arg_13_0._nodeDic[arg_13_1]
end

function var_0_0.getNodeIsShow(arg_14_0, arg_14_1)
	return arg_14_0._lightNodeShowDic[arg_14_1] and arg_14_0:getNodeIsOpen(arg_14_1)
end

function var_0_0.getNodeIsBound(arg_15_0, arg_15_1)
	return arg_15_0:getNodeBoundType(arg_15_1) and arg_15_0:getNodeIsOpen(arg_15_1)
end

function var_0_0.getNodeBoundType(arg_16_0, arg_16_1)
	return arg_16_0._boundNodeShowDic[arg_16_1]
end

function var_0_0.getNodeIsOpen(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getNode(arg_17_1)

	if var_17_0 and ExploreModel.instance:isAreaShow(var_17_0.areaId) then
		return true
	else
		return false
	end
end

function var_0_0.getNodeCanWalk(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getNode(arg_18_1)

	if var_18_0 and ExploreModel.instance:isAreaShow(var_18_0.areaId) and var_18_0:isWalkable() then
		return true
	else
		return false
	end
end

function var_0_0.setIsShowResetBtn(arg_19_0, arg_19_1)
	if arg_19_0._isShowReset ~= arg_19_1 then
		arg_19_0._isShowReset = arg_19_1

		ExploreController.instance:dispatchEvent(ExploreEvent.ShowResetChange)

		if not arg_19_1 and ExploreModel.instance.isShowingResetBoxMessage then
			ExploreModel.instance.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function var_0_0.getIsShowResetBtn(arg_20_0)
	return arg_20_0._isShowReset
end

function var_0_0.updateNodeHeight(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0:getNode(arg_21_1)

	if var_21_0 then
		var_21_0.height = arg_21_2
	end
end

function var_0_0.updateNodeOpenKey(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_0:getNode(arg_22_1)

	if var_22_0 then
		local var_22_1 = var_22_0:isWalkable()

		var_22_0:updateOpenKey(arg_22_2, arg_22_3)

		local var_22_2 = var_22_0:isWalkable()

		if arg_22_4 and var_22_1 ~= var_22_2 then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnNodeChange)
		end
	else
		logError("nodeKey not find:" .. arg_22_1)
	end
end

function var_0_0.updateNodeCanPassItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getNode(arg_23_1)

	if var_23_0 then
		var_23_0:setCanPassItem(arg_23_2)
	else
		logError("nodeKey not find:" .. arg_23_1)
	end
end

function var_0_0.getUnitDic(arg_24_0)
	return arg_24_0._unitDic
end

function var_0_0.getMapAreaDic(arg_25_0)
	return arg_25_0._mapAreaDic
end

function var_0_0.getAreaAllUnit(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getMapAreaMO(arg_26_1)

	return var_26_0 and var_26_0.unitList or {}
end

function var_0_0.getMapAreaMO(arg_27_0, arg_27_1)
	return arg_27_0._mapAreaDic[arg_27_1]
end

function var_0_0.addUnitMO(arg_28_0, arg_28_1)
	arg_28_0._unitDic[arg_28_1.id] = arg_28_1
end

function var_0_0.getUnitMO(arg_29_0, arg_29_1)
	return arg_29_0._unitDic[arg_29_1]
end

function var_0_0.removeUnit(arg_30_0, arg_30_1)
	return
end

function var_0_0.getExploreProgress(arg_31_0)
	local var_31_0 = {}
	local var_31_1 = {}
	local var_31_2 = 0
	local var_31_3 = 0

	for iter_31_0, iter_31_1 in pairs(ExploreEnum.ProgressType) do
		var_31_1[iter_31_0] = 0
		var_31_0[iter_31_0] = 0
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0._unitDic) do
		local var_31_4 = iter_31_3.type

		if ExploreEnum.ProgressType[var_31_4] then
			if iter_31_3:isInteractDone() then
				var_31_0[var_31_4] = var_31_0[var_31_4] + 1
				var_31_3 = var_31_3 + 1
			end

			var_31_1[var_31_4] = var_31_1[var_31_4] + 1
			var_31_2 = var_31_2 + 1
		end
	end

	return var_31_1, var_31_0, var_31_2, var_31_3
end

function var_0_0.setNodeLightXY(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = ExploreHelper.getKeyXY(arg_32_1, arg_32_2)

	if arg_32_0._lightNodeDic[var_32_0] then
		return
	end

	arg_32_0._lightNodeDic[var_32_0] = true

	for iter_32_0 = -4, 4 do
		for iter_32_1 = -4, 4 do
			local var_32_1 = ExploreHelper.getKeyXY(arg_32_1 + iter_32_0, arg_32_2 + iter_32_1)

			arg_32_0._boundNodeShowDic[var_32_1] = nil
			arg_32_0._lightNodeShowDic[var_32_1] = true
		end
	end

	if arg_32_3 then
		arg_32_0:_checkNodeBound()
	end
end

function var_0_0._checkNodeBound(arg_33_0)
	local var_33_0 = false

	for iter_33_0, iter_33_1 in pairs(arg_33_0._nodeDic) do
		if not arg_33_0._lightNodeShowDic[iter_33_0] then
			local var_33_1 = ExploreHelper.getKeyXY(iter_33_1.pos.x - 1, iter_33_1.pos.y)
			local var_33_2 = ExploreHelper.getKeyXY(iter_33_1.pos.x + 1, iter_33_1.pos.y)
			local var_33_3 = ExploreHelper.getKeyXY(iter_33_1.pos.x, iter_33_1.pos.y + 1)
			local var_33_4 = ExploreHelper.getKeyXY(iter_33_1.pos.x, iter_33_1.pos.y - 1)
			local var_33_5 = arg_33_0:getNodeIsShow(var_33_1)
			local var_33_6 = arg_33_0:getNodeIsShow(var_33_2)
			local var_33_7 = arg_33_0:getNodeIsShow(var_33_3)
			local var_33_8 = arg_33_0:getNodeIsShow(var_33_4)

			if var_33_5 and var_33_6 or var_33_7 and var_33_8 then
				var_33_0 = true
				arg_33_0._lightNodeShowDic[iter_33_0] = true
				arg_33_0._boundNodeShowDic[iter_33_0] = nil

				break
			elseif var_33_5 or var_33_6 or var_33_7 or var_33_8 then
				arg_33_0._boundNodeShowDic[iter_33_0] = nil

				local var_33_9 = 0

				if var_33_5 and var_33_7 then
					var_33_9 = 1
				elseif var_33_5 and var_33_8 then
					var_33_9 = 2
				elseif var_33_6 and var_33_7 then
					var_33_9 = 3
				elseif var_33_6 and var_33_8 then
					var_33_9 = 4
				elseif var_33_5 then
					var_33_9 = 5
				elseif var_33_6 then
					var_33_9 = 6
				elseif var_33_7 then
					var_33_9 = 7
				elseif var_33_8 then
					var_33_9 = 8
				end

				arg_33_0._boundNodeShowDic[iter_33_0] = var_33_9
			end
		end
	end

	if var_33_0 then
		arg_33_0:_checkNodeBound()
	end
end

function var_0_0.setNodeLight(arg_34_0, arg_34_1)
	arg_34_0:setNodeLightXY(arg_34_1.x, arg_34_1.y, true)
end

function var_0_0.changeOutlineNum(arg_35_0, arg_35_1)
	arg_35_0.outLineCount = arg_35_0.outLineCount + arg_35_1
	RenderPipelineSetting.selectedOutlineToggle = arg_35_0.outLineCount > 0
end

function var_0_0.clear(arg_36_0)
	arg_36_0._nodeDic = nil
	arg_36_0._unitDic = nil
	arg_36_0._mapAreaDic = nil
	arg_36_0._lightNodeDic = nil
	arg_36_0._lightNodeShowDic = nil
	arg_36_0._boundNodeShowDic = nil
	arg_36_0.moveNodes = nil
	arg_36_0.outLineCount = 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
