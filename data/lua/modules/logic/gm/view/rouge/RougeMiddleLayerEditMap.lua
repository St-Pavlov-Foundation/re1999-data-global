module("modules.logic.gm.view.rouge.RougeMiddleLayerEditMap", package.seeall)

local var_0_0 = class("RougeMiddleLayerEditMap", RougeBaseMap)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.tempVector1 = Vector3.New(0, 0, 0)
	arg_1_0.tempVector2 = Vector3.New(0, 0, 0)

	arg_1_0:initReflection()
end

function var_0_0.initReflection(arg_2_0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_2_0 = tolua.findtype("UnityEngine.LineRenderer")
	local var_2_1 = tolua.getproperty(var_2_0, "positionCount")

	arg_2_0.lineCompMethod, arg_2_0.lineCompProperty = tolua.getmethod(var_2_0, "SetPosition", typeof("System.Int32"), typeof(Vector3)), var_2_1
end

function var_0_0.initMap(arg_3_0)
	var_0_0.super.initMap(arg_3_0)

	local var_3_0 = RougeMapModel.instance:getMapSize()

	RougeMapModel.instance:setCameraSize(var_3_0.y / 2)
	transformhelper.setLocalPos(arg_3_0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
end

function var_0_0.createMapNodeContainer(arg_4_0)
	arg_4_0.layerPointContainer = gohelper.create3d(arg_4_0.mapGo, "layerPointContainer")
	arg_4_0.goLayerLinePathContainer = gohelper.create3d(arg_4_0.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(arg_4_0.layerPointContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(arg_4_0.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)
	var_0_0.super.createMapNodeContainer(arg_4_0)
end

function var_0_0.handleOtherRes(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getAssetItem(RougeMapEnum.RedNodeResPath):GetResource()
	local var_5_1 = arg_5_1:getAssetItem(RougeMapEnum.GreenNodeResPath):GetResource()
	local var_5_2

	arg_5_0.linePrefab, var_5_2 = arg_5_1:getAssetItem(RougeMapEnum.LineResPath):GetResource(), arg_5_1:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
	arg_5_0.pointPrefab = var_5_0
	arg_5_0.pathPointPrefab = var_5_1
	arg_5_0.leavePrefab = var_5_2
end

function var_0_0.createMap(arg_6_0)
	arg_6_0:initPoints()
	arg_6_0:initPathPoints()
	arg_6_0:initLeavePoint()
	arg_6_0:initLines()
	arg_6_0:initMapLine()
end

function var_0_0.initPoints(arg_7_0)
	arg_7_0.pointItemDict = {}

	local var_7_0 = RougeMapEditModel.instance:getPointsDict()

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		arg_7_0:createPoint(iter_7_0, iter_7_1, RougeMapEnum.MiddleLayerPointType.Pieces)
	end
end

function var_0_0.initPathPoints(arg_8_0)
	arg_8_0.pathPointItemDict = {}

	local var_8_0 = RougeMapEditModel.instance:getPathPointsDict()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		arg_8_0:createPoint(iter_8_0, iter_8_1, RougeMapEnum.MiddleLayerPointType.Path)
	end
end

function var_0_0.initLeavePoint(arg_9_0)
	local var_9_0 = RougeMapEditModel.instance:getLeavePos()

	if not var_9_0 then
		return
	end

	arg_9_0:createLeavePoint(var_9_0)
end

function var_0_0.initLines(arg_10_0)
	arg_10_0.lineList = {}

	local var_10_0 = RougeMapEditModel.instance:getLineList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:createLine(RougeMapEnum.MiddleLayerPointType.Path, iter_10_1.startId, RougeMapEnum.MiddleLayerPointType.Path, iter_10_1.endId, "path")

		table.insert(arg_10_0.lineList, var_10_1)
	end
end

function var_0_0.initMapLine(arg_11_0)
	arg_11_0.mapLineList = {}

	local var_11_0 = RougeMapEditModel.instance:getMapLineList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = RougeMapEnum.MiddleLayerPointType.Pieces

		if iter_11_1.startId == RougeMapEnum.LeaveId then
			var_11_1 = RougeMapEnum.MiddleLayerPointType.Leave
		end

		local var_11_2 = arg_11_0:createLine(var_11_1, iter_11_1.startId, RougeMapEnum.MiddleLayerPointType.Path, iter_11_1.endId, "map")

		table.insert(arg_11_0.mapLineList, var_11_2)
	end
end

function var_0_0.createLeavePoint(arg_12_0, arg_12_1)
	arg_12_0.goLeave = arg_12_0.goLeave or gohelper.clone(arg_12_0.leavePrefab, arg_12_0.layerPointContainer)
	arg_12_0.trLeave = arg_12_0.goLeave.transform

	gohelper.setActive(arg_12_0.goLeave, true)
	transformhelper.setLocalPos(arg_12_0.trLeave, arg_12_1.x, arg_12_1.y, 0)
	transformhelper.setLocalScale(arg_12_0.trLeave, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function var_0_0.createPoint(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getUserDataTb_()

	if arg_13_3 == RougeMapEnum.MiddleLayerPointType.Pieces then
		var_13_0.go = gohelper.clone(arg_13_0.pointPrefab, arg_13_0.layerPointContainer)
		arg_13_0.pointItemDict[arg_13_1] = var_13_0
	else
		var_13_0.go = gohelper.clone(arg_13_0.pathPointPrefab, arg_13_0.layerPointContainer)
		arg_13_0.pathPointItemDict[arg_13_1] = var_13_0
	end

	gohelper.setActive(var_13_0.go, true)

	local var_13_1 = string.format("%s_%s", arg_13_3, arg_13_1)

	var_13_0.go.name = var_13_1
	var_13_0.scenePos = arg_13_2
	var_13_0.transform = var_13_0.go.transform
	var_13_0.id = arg_13_1

	transformhelper.setLocalPos(var_13_0.transform, arg_13_2.x, arg_13_2.y, 0)
	transformhelper.setLocalScale(var_13_0.transform, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function var_0_0.createLine(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = arg_14_0:getUserDataTb_()
	local var_14_1 = string.format("%s___%s_%s", arg_14_5, arg_14_2, arg_14_4)
	local var_14_2 = gohelper.clone(arg_14_0.linePrefab, arg_14_0.goLayerLinePathContainer, var_14_1)

	gohelper.setActive(var_14_2, true)

	var_14_0.lineGo = var_14_2
	var_14_0.startId = arg_14_2
	var_14_0.endId = arg_14_4

	arg_14_0:drawLineById(var_14_0.lineGo, arg_14_1, arg_14_2, arg_14_3, arg_14_4)

	return var_14_0
end

function var_0_0.drawLineById(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0 = arg_15_0:getPointPos(arg_15_2, arg_15_3)
	local var_15_1 = arg_15_0:getPointPos(arg_15_4, arg_15_5)

	arg_15_0:drawLine(arg_15_1, var_15_0, var_15_1)
end

function var_0_0.drawLine(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.tempVector1:Set(arg_16_2.x, arg_16_2.y, arg_16_2.z)
	arg_16_0.tempVector2:Set(arg_16_3.x, arg_16_3.y, arg_16_3.z)

	local var_16_0 = arg_16_1:GetComponent("LineRenderer")

	arg_16_0.lineCompProperty:Set(var_16_0, 2, nil)
	arg_16_0.lineCompMethod:Call(var_16_0, 0, arg_16_0.tempVector1)
	arg_16_0.lineCompMethod:Call(var_16_0, 1, arg_16_0.tempVector2)
end

function var_0_0.getPointPos(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif arg_17_1 == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(arg_17_2)
	elseif arg_17_1 == RougeMapEnum.MiddleLayerPointType.Path then
		return RougeMapEditModel.instance:getPathPointPos(arg_17_2)
	end
end

function var_0_0.addPoint(arg_18_0, arg_18_1)
	arg_18_1.z = 0

	local var_18_0 = RougeMapEditModel.instance:addPoint(arg_18_1)

	arg_18_0:createPoint(var_18_0, arg_18_1, RougeMapEnum.MiddleLayerPointType.Pieces)
end

function var_0_0.addPathPoint(arg_19_0, arg_19_1)
	arg_19_1.z = 0

	local var_19_0 = RougeMapEditModel.instance:addPathPoint(arg_19_1)

	arg_19_0:createPoint(var_19_0, arg_19_1, RougeMapEnum.MiddleLayerPointType.Path)
end

function var_0_0.addLeavePoint(arg_20_0, arg_20_1)
	if RougeMapEditModel.instance:getLeavePos() then
		GameFacade.showToastString("离开点只能有一个。")

		return
	end

	arg_20_1.z = 0

	RougeMapEditModel.instance:setLeavePoint(arg_20_1)
	arg_20_0:createLeavePoint(arg_20_1)
end

function var_0_0.deletePoint(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == RougeMapEnum.MiddleLayerPointType.Leave then
		RougeMapEditModel.instance:deleteLeavePoint()
		gohelper.setActive(arg_21_0.goLeave, false)

		for iter_21_0 = #arg_21_0.mapLineList, 1, -1 do
			local var_21_0 = arg_21_0.mapLineList[iter_21_0]

			if var_21_0.startId == arg_21_2 then
				RougeMapEditModel.instance:removeMapLine(iter_21_0)
				table.remove(arg_21_0.mapLineList, iter_21_0)
				gohelper.destroy(var_21_0.lineGo)
			end
		end

		return
	end

	local var_21_1

	if arg_21_1 == RougeMapEnum.MiddleLayerPointType.Pieces then
		var_21_1 = arg_21_0.pointItemDict
	else
		var_21_1 = arg_21_0.pathPointItemDict
	end

	local var_21_2 = var_21_1[arg_21_2]

	if not var_21_2 then
		return
	end

	RougeMapEditModel.instance:deletePoint(arg_21_2, arg_21_1)

	var_21_1[arg_21_2] = nil

	gohelper.destroy(var_21_2.go)

	if arg_21_1 == RougeMapEnum.MiddleLayerPointType.Pieces then
		for iter_21_1 = #arg_21_0.mapLineList, 1, -1 do
			local var_21_3 = arg_21_0.mapLineList[iter_21_1]

			if var_21_3.startId == arg_21_2 then
				RougeMapEditModel.instance:removeMapLine(iter_21_1)
				table.remove(arg_21_0.mapLineList, iter_21_1)
				gohelper.destroy(var_21_3.lineGo)
			end
		end
	else
		for iter_21_2 = #arg_21_0.lineList, 1, -1 do
			local var_21_4 = arg_21_0.lineList[iter_21_2]

			if var_21_4.startId == arg_21_2 or var_21_4.endId == arg_21_2 then
				RougeMapEditModel.instance:removeLine(iter_21_2)
				table.remove(arg_21_0.lineList, iter_21_2)
				gohelper.destroy(var_21_4.lineGo)
			end
		end

		for iter_21_3 = #arg_21_0.mapLineList, 1, -1 do
			local var_21_5 = arg_21_0.mapLineList[iter_21_3]

			if var_21_5.endId == arg_21_2 then
				RougeMapEditModel.instance:removeMapLine(iter_21_3)
				table.remove(arg_21_0.mapLineList, iter_21_3)
				gohelper.destroy(var_21_5.lineGo)
			end
		end
	end
end

function var_0_0.setPointPos(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0

	if arg_22_2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		var_22_0 = arg_22_0.pointItemDict[arg_22_1]
	else
		var_22_0 = arg_22_0.pathPointItemDict[arg_22_1]
	end

	if not var_22_0 then
		return
	end

	transformhelper.setLocalPos(var_22_0.transform, arg_22_3, arg_22_4, 0)
	var_22_0.scenePos:Set(arg_22_3, arg_22_4)

	if arg_22_2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.mapLineList) do
			if iter_22_1.startId == arg_22_1 then
				arg_22_0:drawLineById(iter_22_1.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, iter_22_1.startId, RougeMapEnum.MiddleLayerPointType.Path, iter_22_1.endId)
			end
		end
	else
		for iter_22_2, iter_22_3 in ipairs(arg_22_0.mapLineList) do
			if iter_22_3.endId == arg_22_1 then
				arg_22_0:drawLineById(iter_22_3.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, iter_22_3.startId, RougeMapEnum.MiddleLayerPointType.Path, iter_22_3.endId)
			end
		end

		for iter_22_4, iter_22_5 in ipairs(arg_22_0.lineList) do
			if iter_22_5.startId == arg_22_1 or iter_22_5.endId == arg_22_1 then
				arg_22_0:drawLineById(iter_22_5.lineGo, RougeMapEnum.MiddleLayerPointType.Path, iter_22_5.startId, RougeMapEnum.MiddleLayerPointType.Path, iter_22_5.endId)
			end
		end
	end
end

function var_0_0.createEditingLine(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = string.format("%s_%s_edit", arg_23_2, arg_23_1)

	arg_23_0.editLineGo = gohelper.clone(arg_23_0.linePrefab, arg_23_0.goLayerLinePathContainer, var_23_0)

	gohelper.setActive(arg_23_0.editLineGo, true)

	arg_23_0.startPos = arg_23_0:getPos(arg_23_1, arg_23_2)
end

function var_0_0.getPos(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif arg_24_2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(arg_24_1)
	else
		return RougeMapEditModel.instance:getPathPointPos(arg_24_1)
	end
end

function var_0_0.exitEditLine(arg_25_0)
	gohelper.destroy(arg_25_0.editLineGo)

	arg_25_0.editLineGo = nil
	arg_25_0.startPos = nil
end

function var_0_0.addLine(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	arg_26_1, arg_26_2, arg_26_3, arg_26_4 = RougeMapHelper.formatLineParam(arg_26_1, arg_26_2, arg_26_3, arg_26_4)

	RougeMapEditModel.instance:addLine(arg_26_1, arg_26_2, arg_26_3, arg_26_4)

	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.lineGo = arg_26_0.editLineGo
	var_26_0.startId = arg_26_2
	var_26_0.endId = arg_26_4

	local var_26_1

	if arg_26_1 == RougeMapEnum.MiddleLayerPointType.Pieces or arg_26_1 == RougeMapEnum.MiddleLayerPointType.Leave then
		table.insert(arg_26_0.mapLineList, var_26_0)

		var_26_1 = "map"
	else
		table.insert(arg_26_0.lineList, var_26_0)

		var_26_1 = "path"
	end

	local var_26_2 = string.format("%s___%s_%s", var_26_1, arg_26_2, arg_26_4)

	arg_26_0.editLineGo.name = var_26_2

	arg_26_0:drawLineById(arg_26_0.editLineGo, arg_26_1, arg_26_2, arg_26_3, arg_26_4)

	arg_26_0.editLineGo = nil
end

function var_0_0.updateDrawingLine(arg_27_0, arg_27_1)
	if not arg_27_0.editLineGo then
		return
	end

	arg_27_1.z = 0

	arg_27_0:drawLine(arg_27_0.editLineGo, arg_27_0.startPos, arg_27_1)
end

return var_0_0
