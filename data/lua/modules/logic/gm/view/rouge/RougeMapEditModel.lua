module("modules.logic.gm.view.rouge.RougeMapEditModel", package.seeall)

slot0 = class("RougeMapEditModel")

function slot0.init(slot0, slot1)
	slot0.middleLayerId = slot1
	slot0.middleLayerCo = RougeMapConfig.instance:getMiddleLayerCo(slot0.middleLayerId)
	slot0.idCounter = 0
	slot0.pathPointIdCounter = 0

	slot0:loadLayerCo()
end

function slot0.getMiddleLayerId(slot0)
	return slot0.middleLayerId
end

function slot0.loadLayerCo(slot0)
	slot0:loadPoints()
	slot0:loadPathPoints()
	slot0:loadPath()
	slot0:loadLeavePoint()
end

function slot0.getPointId(slot0)
	slot0.idCounter = slot0.idCounter + 1

	return slot0.idCounter
end

function slot0.getPathPointId(slot0)
	slot0.pathPointIdCounter = slot0.pathPointIdCounter + 1

	return slot0.pathPointIdCounter
end

function slot0.loadPoints(slot0)
	slot0.pointDict = {}
	slot0.pointList = {}
	slot0.pointId2PathIdDict = {}

	for slot5, slot6 in ipairs(slot0.middleLayerCo.pointPos) do
		slot7 = Vector3.New(slot6.x, slot6.y, 0)
		slot8 = slot0:getPointId()
		slot0.pointDict[slot8] = slot7

		table.insert(slot0.pointList, {
			id = slot8,
			pos = slot7
		})

		slot0.pointId2PathIdDict[slot8] = slot6.z
	end

	table.sort(slot0.pointList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
end

function slot0.loadPathPoints(slot0)
	slot0.pathPointDict = {}
	slot0.pathPointList = {}

	for slot5, slot6 in ipairs(slot0.middleLayerCo.pathPointPos) do
		slot7 = Vector3.New(slot6.x, slot6.y, 0)
		slot8 = slot0:getPathPointId()
		slot0.pathPointDict[slot8] = slot7

		table.insert(slot0.pathPointList, {
			id = slot8,
			pos = slot7
		})
	end

	table.sort(slot0.pathPointList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)
end

function slot0.loadPath(slot0)
	slot0.lineList = {}

	for slot5, slot6 in ipairs(slot0.middleLayerCo.path) do
		table.insert(slot0.lineList, {
			startId = slot6.x,
			endId = slot6.y
		})
	end

	slot0.point2PathMapLineList = {}

	for slot5, slot6 in pairs(slot0.pointId2PathIdDict) do
		table.insert(slot0.point2PathMapLineList, {
			startId = slot5,
			endId = slot6
		})
	end
end

function slot0.loadLeavePoint(slot0)
	if not slot0.middleLayerCo.leavePos then
		slot0:setLeavePoint(nil)

		return
	end

	slot0:setLeavePoint(Vector2(slot1.x, slot1.y))

	if not slot0.pathPointDict[slot1.z] then
		return
	end

	table.insert(slot0.point2PathMapLineList, {
		startId = RougeMapEnum.LeaveId,
		endId = slot3
	})

	slot0.pointId2PathIdDict[RougeMapEnum.LeaveId] = slot3
end

function slot0.addPoint(slot0, slot1)
	slot2 = slot0:getPointId()
	slot0.pointDict[slot2] = slot1

	table.insert(slot0.pointList, {
		id = slot2,
		pos = slot1
	})
	table.sort(slot0.pointList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0.addPathPoint(slot0, slot1)
	slot2 = slot0:getPathPointId()
	slot0.pathPointDict[slot2] = slot1

	table.insert(slot0.pathPointList, {
		id = slot2,
		pos = slot1
	})
	table.sort(slot0.pathPointList, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0.setLeavePoint(slot0, slot1)
	slot0.leavePos = slot1
end

function slot0.getLeavePos(slot0)
	return slot0.leavePos
end

function slot0.deleteLeavePoint(slot0)
	slot0.leavePos = nil
	slot0.pointId2PathIdDict[RougeMapEnum.LeaveId] = nil
end

function slot0.deletePoint(slot0, slot1, slot2)
	if slot2 == RougeMapEnum.MiddleLayerPointType.Pieces then
		slot0.pointDict[slot1] = nil

		if slot0:getPointIndex(slot1) then
			table.remove(slot0.pointList, slot3)
			table.sort(slot0.pointList, function (slot0, slot1)
				return slot0.id < slot1.id
			end)
		end

		slot0.pointId2PathIdDict[slot1] = nil

		return
	end

	slot0.pathPointDict[slot1] = nil

	if slot0:getPathPointIndex(slot1) then
		table.remove(slot0.pathPointList, slot3)
		table.sort(slot0.pathPointList, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		for slot7, slot8 in pairs(slot0.pointId2PathIdDict) do
			if slot8 == slot1 then
				slot0.pointId2PathIdDict[slot7] = nil
			end
		end
	end
end

function slot0.addLine(slot0, slot1, slot2, slot3, slot4)
	if slot1 == RougeMapEnum.MiddleLayerPointType.Pieces or slot1 == RougeMapEnum.MiddleLayerPointType.Leave then
		slot0.pointId2PathIdDict[slot2] = slot4

		table.insert(slot0.point2PathMapLineList, {
			startId = slot2,
			endId = slot4
		})

		return
	end

	table.insert(slot0.lineList, {
		startId = slot2,
		endId = slot4
	})
end

function slot0.removeLine(slot0, slot1)
	table.remove(slot0.lineList, slot1)
end

function slot0.removeMapLine(slot0, slot1)
	table.remove(slot0.point2PathMapLineList, slot1)
end

function slot0.checkNeedRemoveMap(slot0, slot1, slot2, slot3)
	slot5 = slot3.startId
	slot6 = slot3.endType
	slot7 = slot3.endId

	if slot3.startType == RougeMapEnum.MiddleLayerPointType.Pieces and slot5 == slot1 then
		return true
	end

	if slot4 == RougeMapEnum.MiddleLayerPointType.Path and slot5 == slot2 then
		return true
	end

	if slot6 == RougeMapEnum.MiddleLayerPointType.Pieces and slot7 == slot1 then
		return true
	end

	if slot6 == RougeMapEnum.MiddleLayerPointType.Path and slot7 == slot2 then
		return true
	end
end

function slot0.getPointsDict(slot0)
	return slot0.pointDict
end

function slot0.getPointList(slot0)
	return slot0.pointList
end

function slot0.getPointMap(slot0)
	return slot0.pointId2PathIdDict
end

function slot0.getPathPointsDict(slot0)
	return slot0.pathPointDict
end

function slot0.getPathPointList(slot0)
	return slot0.pathPointList
end

function slot0.getLineList(slot0)
	return slot0.lineList
end

function slot0.getMapLineList(slot0)
	return slot0.point2PathMapLineList
end

function slot0.getPointPos(slot0, slot1)
	return slot0.pointDict[slot1]
end

function slot0.getPathPointPos(slot0, slot1)
	return slot0.pathPointDict[slot1]
end

slot0.PointTypeCanAddLineDict = {
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

function slot0.checkCanAddLine(slot0, slot1, slot2, slot3, slot4)
	if not uv0.PointTypeCanAddLineDict[1] then
		GameFacade.showToastString(slot5[1])

		return false
	end

	if slot1 == RougeMapEnum.MiddleLayerPointType.Leave or slot4 == RougeMapEnum.MiddleLayerPointType.Leave then
		if slot0.pointId2PathIdDict[RougeMapEnum.LeaveId] then
			GameFacade.showToastString("一个离开点只能映射一个路径点")

			return false
		end

		return false
	end

	for slot9, slot10 in ipairs(slot0.lineList) do
		if slot1 == slot10.startType and slot2 == slot10.startId and slot3 == slot10.endType and slot4 == slot10.endId or slot1 == slot10.endType and slot2 == slot10.endId and slot3 == slot10.startType and slot4 == slot10.startId then
			if slot1 == slot3 then
				GameFacade.showToastString("已添加路径")
			else
				GameFacade.showToastString("已添加映射")
			end

			return false
		end
	end

	slot6, slot2, slot8, slot4 = RougeMapHelper.formatLineParam(slot1, slot2, slot3, slot4)

	if slot6 ~= slot8 and slot0.pointId2PathIdDict[slot2] then
		GameFacade.showToastString("一个元件只能映射一个路径点")

		return
	end

	return true
end

slot0.Radius = 1

function slot0.getPointByPos(slot0, slot1)
	for slot5, slot6 in pairs(slot0.pointDict) do
		if Vector2.Distance(slot6, slot1) <= uv0.Radius then
			return slot5, RougeMapEnum.MiddleLayerPointType.Pieces
		end
	end

	for slot5, slot6 in pairs(slot0.pathPointDict) do
		if Vector2.Distance(slot6, slot1) <= uv0.Radius then
			return slot5, RougeMapEnum.MiddleLayerPointType.Path
		end
	end

	if slot0.leavePos and Vector2.Distance(slot0.leavePos, slot1) <= uv0.Radius then
		return RougeMapEnum.LeaveId, RougeMapEnum.MiddleLayerPointType.Leave
	end
end

function slot0.generateNodeConfig(slot0)
	if #slot0.pointList < 1 then
		GameFacade.showToastString("没有添加任何节点")

		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot7.pos

		if slot0:getPathPointIndex(slot0.pointId2PathIdDict[slot7.id]) == nil then
			slot11 = string.format("节点id : %s 没有添加路径节点映射", slot7.id)

			GameFacade.showToastString(slot11)
			logError(slot11)

			return
		end

		table.insert(slot2, string.format("%s#%s#%s", slot8.x, slot8.y, slot10))
	end

	if not slot0:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(slot2, "|"))
	GameFacade.showToastString("生成节点配置成功")
end

function slot0.generatePathNodeConfig(slot0)
	if #slot0.pathPointList < 1 then
		GameFacade.showToastString("没有添加任何路径节点")

		return
	end

	if not slot0:checkNavigation() then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot7.pos

		table.insert(slot2, string.format("%s#%s", slot8.x, slot8.y))
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(slot2, "|"))
	GameFacade.showToastString("生成路径节点配置成功")
end

function slot0.generateNodePath(slot0)
	if #slot0.lineList < 1 then
		GameFacade.showToastString("没有添加任何路径")

		return
	end

	for slot5, slot6 in ipairs(slot0.lineList) do
		table.insert({}, string.format("%s#%s", slot0:getPathPointIndex(slot6.startId), slot0:getPathPointIndex(slot6.endId)))
	end

	if not slot0:checkNavigation() then
		return
	end

	ZProj.GameHelper.SetSystemBuffer(table.concat(slot1, "|"))
	GameFacade.showToastString("生成路径配置成功")
end

function slot0.getPointIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.pointList) do
		if slot6.id == slot1 then
			return slot5
		end
	end
end

function slot0.getPathPointIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.pathPointList) do
		if slot6.id == slot1 then
			return slot5
		end
	end
end

function slot0.getLineDict(slot0)
	slot0.lineDict = {}

	for slot4, slot5 in ipairs(slot0.lineList) do
		slot0.lineDict[slot5.startId] = slot0.lineDict[slot5.startId] or {}
		slot0.lineDict[slot5.endId] = slot0.lineDict[slot5.endId] or {}
		slot0.lineDict[slot5.startId][slot5.endId] = true
		slot0.lineDict[slot5.endId][slot5.startId] = true
	end

	return slot0.lineDict
end

function slot0.checkNavigation(slot0)
	slot0:getLineDict()

	slot1 = true
	slot4 = {}

	for slot8 = 2, #slot0.pointList do
		tabletool.clear(slot4)

		if not slot0:navigationTo(slot0.pointId2PathIdDict[slot0.pointList[1].id], slot0.pointId2PathIdDict[slot0.pointList[slot8].id], 1, slot4) then
			GameFacade.showToastString(string.format("id : %s, 不可达", slot9.id))

			slot1 = false
		end
	end

	return slot1
end

function slot0.navigationTo(slot0, slot1, slot2, slot3, slot4)
	if tabletool.indexOf(slot4, slot1) then
		return
	end

	table.insert(slot4, slot1)

	if slot3 > 20 then
		GameFacade.showToastString("死循环了...")
		table.remove(slot4)

		return
	end

	if not slot0.lineDict[slot1] then
		table.remove(slot4)

		return
	end

	for slot9, slot10 in pairs(slot5) do
		if slot9 == slot2 then
			table.insert(slot4, slot2)

			return true
		end
	end

	for slot9, slot10 in pairs(slot5) do
		if slot0:navigationTo(slot9, slot2, slot3 + 1, slot4) then
			return true
		end
	end
end

function slot0.generateLeaveNodeConfig(slot0)
	if not slot0.pointId2PathIdDict[RougeMapEnum.LeaveId] then
		GameFacade.showToastString("离开点 没有添加路径节点映射")

		return
	end

	slot3 = slot0:getLeavePos()

	ZProj.GameHelper.SetSystemBuffer(string.format("%s#%s#%s", slot3.x, slot3.y, slot0:getPathPointIndex(slot1)))
	GameFacade.showToastString("生成离开点配置成功")
end

function slot0.setHook(slot0)
	slot1 = UnityEngine.Time.frameCount
	slot2 = os.clock()

	debug.sethook(function ()
		if uv0 ~= UnityEngine.Time.frameCount then
			uv0 = UnityEngine.Time.frameCount
			uv1 = os.clock()
		elseif os.clock() - uv1 > 5 then
			error("loop !!!")
		end
	end, "l")
end

slot0.instance = slot0.New()

return slot0
