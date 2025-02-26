module("modules.logic.gm.view.rouge.RougeMiddleLayerEditMap", package.seeall)

slot0 = class("RougeMiddleLayerEditMap", RougeBaseMap)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.tempVector1 = Vector3.New(0, 0, 0)
	slot0.tempVector2 = Vector3.New(0, 0, 0)

	slot0:initReflection()
end

function slot0.initReflection(slot0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	slot1 = tolua.findtype("UnityEngine.LineRenderer")
	slot0.lineCompProperty = tolua.getproperty(slot1, "positionCount")
	slot0.lineCompMethod = tolua.getmethod(slot1, "SetPosition", typeof("System.Int32"), typeof(Vector3))
end

function slot0.initMap(slot0)
	uv0.super.initMap(slot0)
	RougeMapModel.instance:setCameraSize(RougeMapModel.instance:getMapSize().y / 2)
	transformhelper.setLocalPos(slot0.mapTransform, 0, 0, RougeMapEnum.OffsetZ.Map)
end

function slot0.createMapNodeContainer(slot0)
	slot0.layerPointContainer = gohelper.create3d(slot0.mapGo, "layerPointContainer")
	slot0.goLayerLinePathContainer = gohelper.create3d(slot0.mapGo, "layerLinePathContainer")

	transformhelper.setLocalPos(slot0.layerPointContainer.transform, 0, 0, RougeMapEnum.OffsetZ.NodeContainer)
	transformhelper.setLocalPos(slot0.goLayerLinePathContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PathContainer)
	uv0.super.createMapNodeContainer(slot0)
end

function slot0.handleOtherRes(slot0, slot1)
	slot0.linePrefab = slot1:getAssetItem(RougeMapEnum.LineResPath):GetResource()
	slot0.pointPrefab = slot1:getAssetItem(RougeMapEnum.RedNodeResPath):GetResource()
	slot0.pathPointPrefab = slot1:getAssetItem(RougeMapEnum.GreenNodeResPath):GetResource()
	slot0.leavePrefab = slot1:getAssetItem(RougeMapEnum.MiddleLayerLeavePath):GetResource()
end

function slot0.createMap(slot0)
	slot0:initPoints()
	slot0:initPathPoints()
	slot0:initLeavePoint()
	slot0:initLines()
	slot0:initMapLine()
end

function slot0.initPoints(slot0)
	slot0.pointItemDict = {}

	for slot5, slot6 in pairs(RougeMapEditModel.instance:getPointsDict()) do
		slot0:createPoint(slot5, slot6, RougeMapEnum.MiddleLayerPointType.Pieces)
	end
end

function slot0.initPathPoints(slot0)
	slot0.pathPointItemDict = {}

	for slot5, slot6 in pairs(RougeMapEditModel.instance:getPathPointsDict()) do
		slot0:createPoint(slot5, slot6, RougeMapEnum.MiddleLayerPointType.Path)
	end
end

function slot0.initLeavePoint(slot0)
	if not RougeMapEditModel.instance:getLeavePos() then
		return
	end

	slot0:createLeavePoint(slot1)
end

function slot0.initLines(slot0)
	slot0.lineList = {}

	for slot5, slot6 in ipairs(RougeMapEditModel.instance:getLineList()) do
		table.insert(slot0.lineList, slot0:createLine(RougeMapEnum.MiddleLayerPointType.Path, slot6.startId, RougeMapEnum.MiddleLayerPointType.Path, slot6.endId, "path"))
	end
end

function slot0.initMapLine(slot0)
	slot0.mapLineList = {}

	for slot5, slot6 in ipairs(RougeMapEditModel.instance:getMapLineList()) do
		slot7 = RougeMapEnum.MiddleLayerPointType.Pieces

		if slot6.startId == RougeMapEnum.LeaveId then
			slot7 = RougeMapEnum.MiddleLayerPointType.Leave
		end

		table.insert(slot0.mapLineList, slot0:createLine(slot7, slot6.startId, RougeMapEnum.MiddleLayerPointType.Path, slot6.endId, "map"))
	end
end

function slot0.createLeavePoint(slot0, slot1)
	slot0.goLeave = slot0.goLeave or gohelper.clone(slot0.leavePrefab, slot0.layerPointContainer)
	slot0.trLeave = slot0.goLeave.transform

	gohelper.setActive(slot0.goLeave, true)
	transformhelper.setLocalPos(slot0.trLeave, slot1.x, slot1.y, 0)
	transformhelper.setLocalScale(slot0.trLeave, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function slot0.createPoint(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()

	if slot3 == RougeMapEnum.MiddleLayerPointType.Pieces then
		slot4.go = gohelper.clone(slot0.pointPrefab, slot0.layerPointContainer)
		slot0.pointItemDict[slot1] = slot4
	else
		slot4.go = gohelper.clone(slot0.pathPointPrefab, slot0.layerPointContainer)
		slot0.pathPointItemDict[slot1] = slot4
	end

	gohelper.setActive(slot4.go, true)

	slot4.go.name = string.format("%s_%s", slot3, slot1)
	slot4.scenePos = slot2
	slot4.transform = slot4.go.transform
	slot4.id = slot1

	transformhelper.setLocalPos(slot4.transform, slot2.x, slot2.y, 0)
	transformhelper.setLocalScale(slot4.transform, RougeMapEditModel.Radius, RougeMapEditModel.Radius, RougeMapEditModel.Radius)
end

function slot0.createLine(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:getUserDataTb_()
	slot8 = gohelper.clone(slot0.linePrefab, slot0.goLayerLinePathContainer, string.format("%s___%s_%s", slot5, slot2, slot4))

	gohelper.setActive(slot8, true)

	slot6.lineGo = slot8
	slot6.startId = slot2
	slot6.endId = slot4

	slot0:drawLineById(slot6.lineGo, slot1, slot2, slot3, slot4)

	return slot6
end

function slot0.drawLineById(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:drawLine(slot1, slot0:getPointPos(slot2, slot3), slot0:getPointPos(slot4, slot5))
end

function slot0.drawLine(slot0, slot1, slot2, slot3)
	slot0.tempVector1:Set(slot2.x, slot2.y, slot2.z)
	slot0.tempVector2:Set(slot3.x, slot3.y, slot3.z)

	slot4 = slot1:GetComponent("LineRenderer")

	slot0.lineCompProperty:Set(slot4, 2, nil)
	slot0.lineCompMethod:Call(slot4, 0, slot0.tempVector1)
	slot0.lineCompMethod:Call(slot4, 1, slot0.tempVector2)
end

function slot0.getPointPos(slot0, slot1, slot2)
	if slot1 == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif slot1 == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(slot2)
	elseif slot1 == RougeMapEnum.MiddleLayerPointType.Path then
		return RougeMapEditModel.instance:getPathPointPos(slot2)
	end
end

function slot0.addPoint(slot0, slot1)
	slot1.z = 0

	slot0:createPoint(RougeMapEditModel.instance:addPoint(slot1), slot1, RougeMapEnum.MiddleLayerPointType.Pieces)
end

function slot0.addPathPoint(slot0, slot1)
	slot1.z = 0

	slot0:createPoint(RougeMapEditModel.instance:addPathPoint(slot1), slot1, RougeMapEnum.MiddleLayerPointType.Path)
end

function slot0.addLeavePoint(slot0, slot1)
	if RougeMapEditModel.instance:getLeavePos() then
		GameFacade.showToastString("离开点只能有一个。")

		return
	end

	slot1.z = 0

	RougeMapEditModel.instance:setLeavePoint(slot1)
	slot0:createLeavePoint(slot1)
end

function slot0.deletePoint(slot0, slot1, slot2)
	if slot1 == RougeMapEnum.MiddleLayerPointType.Leave then
		RougeMapEditModel.instance:deleteLeavePoint()
		gohelper.setActive(slot0.goLeave, false)

		for slot6 = #slot0.mapLineList, 1, -1 do
			if slot0.mapLineList[slot6].startId == slot2 then
				RougeMapEditModel.instance:removeMapLine(slot6)
				table.remove(slot0.mapLineList, slot6)
				gohelper.destroy(slot7.lineGo)
			end
		end

		return
	end

	slot3 = nil

	if not ((slot1 ~= RougeMapEnum.MiddleLayerPointType.Pieces or slot0.pointItemDict) and slot0.pathPointItemDict)[slot2] then
		return
	end

	RougeMapEditModel.instance:deletePoint(slot2, slot1)

	slot3[slot2] = nil

	gohelper.destroy(slot4.go)

	if slot1 == RougeMapEnum.MiddleLayerPointType.Pieces then
		for slot8 = #slot0.mapLineList, 1, -1 do
			if slot0.mapLineList[slot8].startId == slot2 then
				RougeMapEditModel.instance:removeMapLine(slot8)
				table.remove(slot0.mapLineList, slot8)
				gohelper.destroy(slot9.lineGo)
			end
		end
	else
		for slot8 = #slot0.lineList, 1, -1 do
			if slot0.lineList[slot8].startId == slot2 or slot9.endId == slot2 then
				RougeMapEditModel.instance:removeLine(slot8)
				table.remove(slot0.lineList, slot8)
				gohelper.destroy(slot9.lineGo)
			end
		end

		for slot8 = #slot0.mapLineList, 1, -1 do
			if slot0.mapLineList[slot8].endId == slot2 then
				RougeMapEditModel.instance:removeMapLine(slot8)
				table.remove(slot0.mapLineList, slot8)
				gohelper.destroy(slot9.lineGo)
			end
		end
	end
end

function slot0.setPointPos(slot0, slot1, slot2, slot3, slot4)
	slot5 = nil

	if not ((slot2 ~= RougeMapEnum.MiddleLayerPointType.Pieces or slot0.pointItemDict[slot1]) and slot0.pathPointItemDict[slot1]) then
		return
	end

	transformhelper.setLocalPos(slot5.transform, slot3, slot4, 0)
	slot5.scenePos:Set(slot3, slot4)

	if slot2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		for slot9, slot10 in ipairs(slot0.mapLineList) do
			if slot10.startId == slot1 then
				slot0:drawLineById(slot10.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, slot10.startId, RougeMapEnum.MiddleLayerPointType.Path, slot10.endId)
			end
		end
	else
		for slot9, slot10 in ipairs(slot0.mapLineList) do
			if slot10.endId == slot1 then
				slot0:drawLineById(slot10.lineGo, RougeMapEnum.MiddleLayerPointType.Pieces, slot10.startId, RougeMapEnum.MiddleLayerPointType.Path, slot10.endId)
			end
		end

		for slot9, slot10 in ipairs(slot0.lineList) do
			if slot10.startId == slot1 or slot10.endId == slot1 then
				slot0:drawLineById(slot10.lineGo, RougeMapEnum.MiddleLayerPointType.Path, slot10.startId, RougeMapEnum.MiddleLayerPointType.Path, slot10.endId)
			end
		end
	end
end

function slot0.createEditingLine(slot0, slot1, slot2)
	slot0.editLineGo = gohelper.clone(slot0.linePrefab, slot0.goLayerLinePathContainer, string.format("%s_%s_edit", slot2, slot1))

	gohelper.setActive(slot0.editLineGo, true)

	slot0.startPos = slot0:getPos(slot1, slot2)
end

function slot0.getPos(slot0, slot1, slot2)
	if slot2 == RougeMapEnum.MiddleLayerPointType.Leave then
		return RougeMapEditModel.instance:getLeavePos()
	elseif slot2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		return RougeMapEditModel.instance:getPointPos(slot1)
	else
		return RougeMapEditModel.instance:getPathPointPos(slot1)
	end
end

function slot0.exitEditLine(slot0)
	gohelper.destroy(slot0.editLineGo)

	slot0.editLineGo = nil
	slot0.startPos = nil
end

function slot0.addLine(slot0, slot1, slot2, slot3, slot4)
	slot1, slot2, slot7, slot4 = RougeMapHelper.formatLineParam(slot1, slot2, slot3, slot4)

	RougeMapEditModel.instance:addLine(slot1, slot2, slot7, slot4)

	slot5 = slot0:getUserDataTb_()
	slot5.lineGo = slot0.editLineGo
	slot5.startId = slot2
	slot5.endId = slot4
	slot6 = nil

	if slot1 == RougeMapEnum.MiddleLayerPointType.Pieces or slot1 == RougeMapEnum.MiddleLayerPointType.Leave then
		table.insert(slot0.mapLineList, slot5)

		slot6 = "map"
	else
		table.insert(slot0.lineList, slot5)

		slot6 = "path"
	end

	slot0.editLineGo.name = string.format("%s___%s_%s", slot6, slot2, slot4)

	slot0:drawLineById(slot0.editLineGo, slot1, slot2, slot3, slot4)

	slot0.editLineGo = nil
end

function slot0.updateDrawingLine(slot0, slot1)
	if not slot0.editLineGo then
		return
	end

	slot1.z = 0

	slot0:drawLine(slot0.editLineGo, slot0.startPos, slot1)
end

return slot0
