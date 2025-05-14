module("modules.logic.gm.view.rouge.RougeMapEditModel", package.seeall)

local var_0_0 = class("RougeMapEditModel")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.middleLayerId = arg_1_1
	arg_1_0.middleLayerCo = RougeMapConfig.instance:getMiddleLayerCo(arg_1_0.middleLayerId)
	arg_1_0.idCounter = 0
	arg_1_0.pathPointIdCounter = 0

	arg_1_0:loadLayerCo()
end

function var_0_0.getMiddleLayerId(arg_2_0)
	return arg_2_0.middleLayerId
end

function var_0_0.loadLayerCo(arg_3_0)
	arg_3_0:loadPoints()
	arg_3_0:loadPathPoints()
	arg_3_0:loadPath()
	arg_3_0:loadLeavePoint()
end

function var_0_0.getPointId(arg_4_0)
	arg_4_0.idCounter = arg_4_0.idCounter + 1

	return arg_4_0.idCounter
end

function var_0_0.getPathPointId(arg_5_0)
	arg_5_0.pathPointIdCounter = arg_5_0.pathPointIdCounter + 1

	return arg_5_0.pathPointIdCounter
end

function var_0_0.loadPoints(arg_6_0)
	local var_6_0 = arg_6_0.middleLayerCo.pointPos

	arg_6_0.pointDict = {}
	arg_6_0.pointList = {}
	arg_6_0.pointId2PathIdDict = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = Vector3.New(iter_6_1.x, iter_6_1.y, 0)
		local var_6_2 = arg_6_0:getPointId()

		arg_6_0.pointDict[var_6_2] = var_6_1

		table.insert(arg_6_0.pointList, {
			id = var_6_2,
			pos = var_6_1
		})

		arg_6_0.pointId2PathIdDict[var_6_2] = iter_6_1.z
	end

	table.sort(arg_6_0.pointList, function(arg_7_0, arg_7_1)
		return arg_7_0.id < arg_7_1.id
	end)
end

function var_0_0.loadPathPoints(arg_8_0)
	local var_8_0 = arg_8_0.middleLayerCo.pathPointPos

	arg_8_0.pathPointDict = {}
	arg_8_0.pathPointList = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = Vector3.New(iter_8_1.x, iter_8_1.y, 0)
		local var_8_2 = arg_8_0:getPathPointId()

		arg_8_0.pathPointDict[var_8_2] = var_8_1

		table.insert(arg_8_0.pathPointList, {
			id = var_8_2,
			pos = var_8_1
		})
	end

	table.sort(arg_8_0.pathPointList, function(arg_9_0, arg_9_1)
		return arg_9_0.id < arg_9_1.id
	end)
end

function var_0_0.loadPath(arg_10_0)
	local var_10_0 = arg_10_0.middleLayerCo.path

	arg_10_0.lineList = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(arg_10_0.lineList, {
			startId = iter_10_1.x,
			endId = iter_10_1.y
		})
	end

	arg_10_0.point2PathMapLineList = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_0.pointId2PathIdDict) do
		table.insert(arg_10_0.point2PathMapLineList, {
			startId = iter_10_2,
			endId = iter_10_3
		})
	end
end

function var_0_0.loadLeavePoint(arg_11_0)
	local var_11_0 = arg_11_0.middleLayerCo.leavePos

	if not var_11_0 then
		arg_11_0:setLeavePoint(nil)

		return
	end

	local var_11_1 = Vector2(var_11_0.x, var_11_0.y)
	local var_11_2 = var_11_0.z

	arg_11_0:setLeavePoint(var_11_1)

	if not arg_11_0.pathPointDict[var_11_2] then
		return
	end

	table.insert(arg_11_0.point2PathMapLineList, {
		startId = RougeMapEnum.LeaveId,
		endId = var_11_2
	})

	arg_11_0.pointId2PathIdDict[RougeMapEnum.LeaveId] = var_11_2
end

function var_0_0.addPoint(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getPointId()

	arg_12_0.pointDict[var_12_0] = arg_12_1

	table.insert(arg_12_0.pointList, {
		id = var_12_0,
		pos = arg_12_1
	})
	table.sort(arg_12_0.pointList, function(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end)

	return var_12_0
end

function var_0_0.addPathPoint(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getPathPointId()

	arg_14_0.pathPointDict[var_14_0] = arg_14_1

	table.insert(arg_14_0.pathPointList, {
		id = var_14_0,
		pos = arg_14_1
	})
	table.sort(arg_14_0.pathPointList, function(arg_15_0, arg_15_1)
		return arg_15_0.id < arg_15_1.id
	end)

	return var_14_0
end

function var_0_0.setLeavePoint(arg_16_0, arg_16_1)
	arg_16_0.leavePos = arg_16_1
end

function var_0_0.getLeavePos(arg_17_0)
	return arg_17_0.leavePos
end

function var_0_0.deleteLeavePoint(arg_18_0)
	arg_18_0.leavePos = nil
	arg_18_0.pointId2PathIdDict[RougeMapEnum.LeaveId] = nil
end

function var_0_0.deletePoint(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		arg_19_0.pointDict[arg_19_1] = nil

		local var_19_0 = arg_19_0:getPointIndex(arg_19_1)

		if var_19_0 then
			table.remove(arg_19_0.pointList, var_19_0)
			table.sort(arg_19_0.pointList, function(arg_20_0, arg_20_1)
				return arg_20_0.id < arg_20_1.id
			end)
		end

		arg_19_0.pointId2PathIdDict[arg_19_1] = nil

		return
	end

	arg_19_0.pathPointDict[arg_19_1] = nil

	local var_19_1 = arg_19_0:getPathPointIndex(arg_19_1)

	if var_19_1 then
		table.remove(arg_19_0.pathPointList, var_19_1)
		table.sort(arg_19_0.pathPointList, function(arg_21_0, arg_21_1)
			return arg_21_0.id < arg_21_1.id
		end)

		for iter_19_0, iter_19_1 in pairs(arg_19_0.pointId2PathIdDict) do
			if iter_19_1 == arg_19_1 then
				arg_19_0.pointId2PathIdDict[iter_19_0] = nil
			end
		end
	end
end

function var_0_0.addLine(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_1 == RougeMapEnum.MiddleLayerPointType.Pieces or arg_22_1 == RougeMapEnum.MiddleLayerPointType.Leave then
		arg_22_0.pointId2PathIdDict[arg_22_2] = arg_22_4

		table.insert(arg_22_0.point2PathMapLineList, {
			startId = arg_22_2,
			endId = arg_22_4
		})

		return
	end

	table.insert(arg_22_0.lineList, {
		startId = arg_22_2,
		endId = arg_22_4
	})
end

function var_0_0.removeLine(arg_23_0, arg_23_1)
	table.remove(arg_23_0.lineList, arg_23_1)
end

function var_0_0.removeMapLine(arg_24_0, arg_24_1)
	table.remove(arg_24_0.point2PathMapLineList, arg_24_1)
end

function var_0_0.checkNeedRemoveMap(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_3.startType
	local var_25_1 = arg_25_3.startId
	local var_25_2 = arg_25_3.endType
	local var_25_3 = arg_25_3.endId

	if var_25_0 == RougeMapEnum.MiddleLayerPointType.Pieces and var_25_1 == arg_25_1 then
		return true
	end

	if var_25_0 == RougeMapEnum.MiddleLayerPointType.Path and var_25_1 == arg_25_2 then
		return true
	end

	if var_25_2 == RougeMapEnum.MiddleLayerPointType.Pieces and var_25_3 == arg_25_1 then
		return true
	end

	if var_25_2 == RougeMapEnum.MiddleLayerPointType.Path and var_25_3 == arg_25_2 then
		return true
	end
end

function var_0_0.getPointsDict(arg_26_0)
	return arg_26_0.pointDict
end

function var_0_0.getPointList(arg_27_0)
	return arg_27_0.pointList
end

function var_0_0.getPointMap(arg_28_0)
	return arg_28_0.pointId2PathIdDict
end

function var_0_0.getPathPointsDict(arg_29_0)
	return arg_29_0.pathPointDict
end

function var_0_0.getPathPointList(arg_30_0)
	return arg_30_0.pathPointList
end

function var_0_0.getLineList(arg_31_0)
	return arg_31_0.lineList
end

function var_0_0.getMapLineList(arg_32_0)
	return arg_32_0.point2PathMapLineList
end

function var_0_0.getPointPos(arg_33_0, arg_33_1)
	return arg_33_0.pointDict[arg_33_1]
end

function var_0_0.getPathPointPos(arg_34_0, arg_34_1)
	return arg_34_0.pathPointDict[arg_34_1]
end

var_0_0.PointTypeCanAddLineDict = {
	[RougeMapEnum.MiddleLayerPointType.Pieces] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"两个元件位置之间不能添加路径"
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false,
			"元件点和离开点不能添加路径"
		}
	},
	[RougeMapEnum.MiddleLayerPointType.Path] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false
		}
	},
	[RougeMapEnum.MiddleLayerPointType.Leave] = {
		[RougeMapEnum.MiddleLayerPointType.Pieces] = {
			false,
			"元件点和离开点不能添加路径"
		},
		[RougeMapEnum.MiddleLayerPointType.Path] = {
			true
		},
		[RougeMapEnum.MiddleLayerPointType.Leave] = {
			false,
			"两个离开点之间不能添加路径"
		}
	}
}

function var_0_0.checkCanAddLine(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = var_0_0.PointTypeCanAddLineDict

	if not var_35_0[1] then
		GameFacade.showToastString(var_35_0[1])

		return false
	end

	if arg_35_1 == RougeMapEnum.MiddleLayerPointType.Leave or arg_35_4 == RougeMapEnum.MiddleLayerPointType.Leave then
		if arg_35_0.pointId2PathIdDict[RougeMapEnum.LeaveId] then
			GameFacade.showToastString("一个离开点只能映射一个路径点")

			return false
		end

		return false
	end

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.lineList) do
		if arg_35_1 == iter_35_1.startType and arg_35_2 == iter_35_1.startId and arg_35_3 == iter_35_1.endType and arg_35_4 == iter_35_1.endId or arg_35_1 == iter_35_1.endType and arg_35_2 == iter_35_1.endId and arg_35_3 == iter_35_1.startType and arg_35_4 == iter_35_1.startId then
			if arg_35_1 == arg_35_3 then
				GameFacade.showToastString("已添加路径")
			else
				GameFacade.showToastString("已添加映射")
			end

			return false
		end
	end

	arg_35_1, arg_35_2, arg_35_3, arg_35_4 = RougeMapHelper.formatLineParam(arg_35_1, arg_35_2, arg_35_3, arg_35_4)

	if arg_35_1 ~= arg_35_3 and arg_35_0.pointId2PathIdDict[arg_35_2] then
		GameFacade.showToastString("一个元件只能映射一个路径点")

		return
	end

	return true
end

var_0_0.Radius = 1

function var_0_0.getPointByPos(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.pointDict) do
		if Vector2.Distance(iter_36_1, arg_36_1) <= var_0_0.Radius then
			return iter_36_0, RougeMapEnum.MiddleLayerPointType.Pieces
		end
	end

	for iter_36_2, iter_36_3 in pairs(arg_36_0.pathPointDict) do
		if Vector2.Distance(iter_36_3, arg_36_1) <= var_0_0.Radius then
			return iter_36_2, RougeMapEnum.MiddleLayerPointType.Path
		end
	end

	if arg_36_0.leavePos and Vector2.Distance(arg_36_0.leavePos, arg_36_1) <= var_0_0.Radius then
		return RougeMapEnum.LeaveId, RougeMapEnum.MiddleLayerPointType.Leave
	end
end

function var_0_0.generateNodeConfig(arg_37_0)
	local var_37_0 = arg_37_0.pointList

	if #var_37_0 < 1 then
		GameFacade.showToastString("没有添加任何节点")

		return
	end

	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_2 = iter_37_1.pos
		local var_37_3 = arg_37_0.pointId2PathIdDict[iter_37_1.id]
		local var_37_4 = arg_37_0:getPathPointIndex(var_37_3)

		if var_37_4 == nil then
			local var_37_5 = string.format("节点id : %s 没有添加路径节点映射", iter_37_1.id)

			GameFacade.showToastString(var_37_5)
			logError(var_37_5)

			return
		end

		table.insert(var_37_1, string.format("%s#%s#%s", var_37_2.x, var_37_2.y, var_37_4))
	end

	if not arg_37_0:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(var_37_1, "|"))
	GameFacade.showToastString("生成节点配置成功")
end

function var_0_0.generatePathNodeConfig(arg_38_0)
	local var_38_0 = arg_38_0.pathPointList

	if #var_38_0 < 1 then
		GameFacade.showToastString("没有添加任何路径节点")

		return
	end

	if not arg_38_0:checkNavigation() then
		return
	end

	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_2 = iter_38_1.pos

		table.insert(var_38_1, string.format("%s#%s", var_38_2.x, var_38_2.y))
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(var_38_1, "|"))
	GameFacade.showToastString("生成路径节点配置成功")
end

function var_0_0.generateNodePath(arg_39_0)
	if #arg_39_0.lineList < 1 then
		GameFacade.showToastString("没有添加任何路径")

		return
	end

	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_0.lineList) do
		local var_39_1 = arg_39_0:getPathPointIndex(iter_39_1.startId)
		local var_39_2 = arg_39_0:getPathPointIndex(iter_39_1.endId)

		table.insert(var_39_0, string.format("%s#%s", var_39_1, var_39_2))
	end

	if not arg_39_0:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(var_39_0, "|"))
	GameFacade.showToastString("生成路径配置成功")
end

function var_0_0.getPointIndex(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0.pointList) do
		if iter_40_1.id == arg_40_1 then
			return iter_40_0
		end
	end
end

function var_0_0.getPathPointIndex(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.pathPointList) do
		if iter_41_1.id == arg_41_1 then
			return iter_41_0
		end
	end
end

function var_0_0.getLineDict(arg_42_0)
	arg_42_0.lineDict = {}

	for iter_42_0, iter_42_1 in ipairs(arg_42_0.lineList) do
		arg_42_0.lineDict[iter_42_1.startId] = arg_42_0.lineDict[iter_42_1.startId] or {}
		arg_42_0.lineDict[iter_42_1.endId] = arg_42_0.lineDict[iter_42_1.endId] or {}
		arg_42_0.lineDict[iter_42_1.startId][iter_42_1.endId] = true
		arg_42_0.lineDict[iter_42_1.endId][iter_42_1.startId] = true
	end

	return arg_42_0.lineDict
end

function var_0_0.checkNavigation(arg_43_0)
	arg_43_0:getLineDict()

	local var_43_0 = true
	local var_43_1 = #arg_43_0.pointList
	local var_43_2 = arg_43_0.pointId2PathIdDict[arg_43_0.pointList[1].id]
	local var_43_3 = {}

	for iter_43_0 = 2, var_43_1 do
		local var_43_4 = arg_43_0.pointList[iter_43_0]
		local var_43_5 = arg_43_0.pointId2PathIdDict[var_43_4.id]

		tabletool.clear(var_43_3)

		if not arg_43_0:navigationTo(var_43_2, var_43_5, 1, var_43_3) then
			local var_43_6 = string.format("id : %s, 不可达", var_43_4.id)

			GameFacade.showToastString(var_43_6)

			var_43_0 = false
		end
	end

	return var_43_0
end

function var_0_0.navigationTo(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if tabletool.indexOf(arg_44_4, arg_44_1) then
		return
	end

	table.insert(arg_44_4, arg_44_1)

	if arg_44_3 > 20 then
		GameFacade.showToastString("死循环了...")
		table.remove(arg_44_4)

		return
	end

	local var_44_0 = arg_44_0.lineDict[arg_44_1]

	if not var_44_0 then
		table.remove(arg_44_4)

		return
	end

	for iter_44_0, iter_44_1 in pairs(var_44_0) do
		if iter_44_0 == arg_44_2 then
			table.insert(arg_44_4, arg_44_2)

			return true
		end
	end

	for iter_44_2, iter_44_3 in pairs(var_44_0) do
		if arg_44_0:navigationTo(iter_44_2, arg_44_2, arg_44_3 + 1, arg_44_4) then
			return true
		end
	end
end

function var_0_0.generateLeaveNodeConfig(arg_45_0)
	local var_45_0 = arg_45_0.pointId2PathIdDict[RougeMapEnum.LeaveId]

	if not var_45_0 then
		GameFacade.showToastString("离开点 没有添加路径节点映射")

		return
	end

	local var_45_1 = arg_45_0:getPathPointIndex(var_45_0)
	local var_45_2 = arg_45_0:getLeavePos()

	ZProj.GameHelper.SetSystemBuffer(string.format("%s#%s#%s", var_45_2.x, var_45_2.y, var_45_1))
	GameFacade.showToastString("生成离开点配置成功")
end

function var_0_0.setHook(arg_46_0)
	local var_46_0 = UnityEngine.Time.frameCount
	local var_46_1 = os.clock()

	debug.sethook(function()
		if var_46_0 ~= UnityEngine.Time.frameCount then
			var_46_0 = UnityEngine.Time.frameCount
			var_46_1 = os.clock()
		elseif os.clock() - var_46_1 > 5 then
			error("loop !!!")
		end
	end, "l")
end

var_0_0.instance = var_0_0.New()

return var_0_0
