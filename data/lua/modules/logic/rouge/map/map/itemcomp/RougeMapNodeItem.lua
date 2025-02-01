module("modules.logic.rouge.map.map.itemcomp.RougeMapNodeItem", package.seeall)

slot0 = class("RougeMapNodeItem", RougeMapBaseItem)

function slot0.init(slot0, slot1, slot2, slot3)
	uv0.super.init(slot0)

	slot0.episodeItem = slot3
	slot0.posType = slot3.posType
	slot0.parentGo = slot3.go
	slot0.nodeMo = slot1
	slot0.map = slot2
	slot0.nodeId = slot0.nodeMo.nodeId
	slot0.select = false

	slot0:updateData()
	slot0:setId(slot0.nodeMo.nodeId)
	slot0:createGo()
	slot0:createNodeBg()
	slot0:createIcon()
	slot0:checkNodeFog()
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0.onUpdateMapInfo, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectNode, slot0.onSelectNode, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0.onCloseFullView, slot0)
end

function slot0.updateData(slot0)
	slot0.eventId = slot0.nodeMo.eventId
	slot0.eventCo = slot0.nodeMo:getEventCo()
	slot0.arriveStatus = slot0.nodeMo.arriveStatus
end

function slot0.createGo(slot0)
	slot0.go = gohelper.create3d(slot0.parentGo, slot0.nodeId)
	slot0.tr = slot0.go:GetComponent(gohelper.Type_Transform)
	slot1, slot2, slot3 = RougeMapHelper.getNodeLocalPos(slot0.nodeMo.index, slot0.posType)

	slot0.nodeMo:setPos(slot1, slot2, slot3)
	transformhelper.setLocalPos(slot0.tr, slot1, slot2, slot3)
end

function slot0.createNodeBg(slot0)
	slot1, slot2 = nil

	if slot0.nodeMo:checkIsNormal() then
		slot1 = slot0.map:getNodeBgPrefab(slot0.eventCo, slot0.arriveStatus)
		slot2 = RougeMapEnum.NodeBgOffset[slot0.arriveStatus]
	else
		slot1 = slot0.map.startBgPrefab
		slot2 = RougeMapEnum.StartBgOffset
	end

	slot0.nodeBgGo = gohelper.clone(slot1, slot0.go, "bg")
	slot0.nodeBgTr = slot0.nodeBgGo:GetComponent(gohelper.Type_Transform)
	slot0.nodeBgAnimator = slot0.nodeBgGo:GetComponent(gohelper.Type_Animator)
	slot0.nodeBgAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.nodeBgGo)

	transformhelper.setLocalScale(slot0.nodeBgTr, RougeMapEnum.Scale.NodeBg, RougeMapEnum.Scale.NodeBg, 1)
	transformhelper.setLocalPos(slot0.nodeBgTr, slot2.x, slot2.y, slot0:getBgOffsetZ())
	slot0:playNodeBgAnim("open")
end

function slot0.createIcon(slot0)
	if slot0.nodeMo:checkIsNormal() then
		slot0.iconGo = gohelper.clone(slot0.map:getNodeIconPrefab(slot0.eventCo), slot0.go, "icon")
		slot0.iconTr = slot0.iconGo:GetComponent(gohelper.Type_Transform)
		slot0.iconAnimator = slot0.iconGo:GetComponent(gohelper.Type_Animator)
		slot0.iconAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0.iconGo)

		transformhelper.setLocalScale(slot0.iconTr, RougeMapEnum.Scale.Icon, RougeMapEnum.Scale.Icon, 1)
		slot0:updateIconPos()

		if slot0.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			slot0:playIconAnim("overdue")
		else
			slot0:playIconAnim("open")
		end
	else
		slot0.iconGo = nil
		slot0.iconTr = nil
		slot0.iconAnimator = nil
	end
end

function slot0.updateIconPos(slot0)
	if slot0.eventCo then
		slot1 = RougeMapEnum.IconOffset[slot0.arriveStatus]

		transformhelper.setLocalPos(slot0.iconTr, slot1.x, slot1.y, slot0:getIconOffsetZ())
	end
end

function slot0.getIconOffsetZ(slot0)
	return slot0:getBgOffsetZ() - RougeMapEnum.NodeIconOffsetZInterval
end

function slot0.getBgOffsetZ(slot0)
	return -(slot0.nodeMo.index - 1) * (RougeMapEnum.NodeOffsetZInterval + RougeMapEnum.NodeIconOffsetZInterval)
end

function slot0.getScenePos(slot0)
	return slot0.nodeBgTr.position
end

function slot0.getMapPos(slot0)
	slot1, slot2, slot3 = RougeMapHelper.getNodeContainerPos(slot0.nodeMo.episodeId, slot0.nodeMo:getEpisodePos())

	return slot1, slot2, slot3
end

function slot0.getActorPos(slot0)
	slot1, slot2, slot3 = slot0:getMapPos()

	return RougeMapEnum.ActorOffset.x + slot1, RougeMapEnum.ActorOffset.y + slot2, slot3
end

function slot0.getClickArea(slot0)
	if not slot0.nodeMo:checkIsNormal() then
		return RougeMapEnum.StartClickArea
	end

	return RougeMapEnum.ClickArea[slot0.arriveStatus]
end

function slot0.onClick(slot0)
	logNormal(string.format("on click node id : %s, arrive status : %s", slot0.nodeId, slot0.arriveStatus))

	if slot0.arriveStatus == RougeMapEnum.Arrive.CantArrive or slot0.arriveStatus == RougeMapEnum.Arrive.NotArrive or slot0.arriveStatus == RougeMapEnum.Arrive.ArrivingFinish or slot0.arriveStatus == RougeMapEnum.Arrive.Arrived then
		return
	end

	if not slot0.eventCo then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, slot0.nodeMo)
end

function slot0.updateNode(slot0)
	slot0.arriveStatus = slot0:getArriveStatus()

	slot0:checkNodeFog()

	if slot0.fog then
		return
	end

	if slot0.nodeBgAnimator then
		slot0:playNodeBgAnim("close", slot0._updateNodeBg)
	else
		slot0:_updateNodeBg()
	end

	if slot0.iconAnimator then
		slot0:playIconAnim("close", slot0._updateIcon)
	else
		slot0:_updateIcon()
	end
end

function slot0._updateNodeBg(slot0)
	gohelper.destroy(slot0.nodeBgGo)
	slot0:createNodeBg()
end

function slot0._updateIcon(slot0)
	gohelper.destroy(slot0.iconGo)
	slot0:createIcon()
end

function slot0.onUpdateMapInfo(slot0)
	if not RougeMapHelper.checkMapViewOnTop() then
		slot0.waitUpdate = true

		return
	end

	slot0.waitUpdate = nil

	if slot0.eventId ~= slot0.nodeMo.eventId then
		slot0.eventId = slot0.nodeMo.eventId
		slot0.eventCo = slot0.nodeMo:getEventCo()

		slot0:updateNode()

		return
	end

	if slot0.arriveStatus ~= slot0:getArriveStatus() then
		slot0:updateNode()

		return
	end

	if slot0.fog ~= slot0.nodeMo.fog then
		slot0:updateNode()

		return
	end
end

function slot0.getArriveStatus(slot0)
	if slot0.select then
		return RougeMapEnum.NodeSelectArriveStatus
	end

	return slot0.nodeMo.arriveStatus
end

function slot0.checkNodeFog(slot0)
	slot0.fog = slot0.nodeMo.fog

	gohelper.setActive(slot0.go, not slot0.fog)
end

function slot0.onSelectNode(slot0, slot1)
	if slot0.select == (slot1 == slot0.nodeMo) then
		return
	end

	slot0.select = slot2

	if slot0.arriveStatus ~= slot0:getArriveStatus() then
		slot0:updateNode()
	end

	if slot0.select then
		AudioMgr.instance:trigger(AudioEnum.UI.SelectNode)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot0.waitUpdate then
		slot0:onUpdateMapInfo()
		slot0:checkNodeFog()
	end
end

function slot0.onCloseFullView(slot0)
	if not slot0.playingBgAnim and slot0.nodeBgAnimator then
		slot0.nodeBgAnimator:Play("idle", 0, 1)
	end

	if not slot0.playingIconAnim and slot0.iconAnimator then
		if slot0.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			slot0.iconAnimator:Play("overdue", 0, 1)
		else
			slot0.iconAnimator:Play("idle", 0, 1)
		end
	end
end

function slot0.setLineItem(slot0, slot1)
	slot0.lineItem = slot1
end

function slot0.getLineItem(slot0)
	return slot0.lineItem
end

function slot0.playNodeBgAnim(slot0, slot1, slot2)
	if not slot0.nodeBgAnimator then
		return
	end

	slot0.playingBgAnim = true

	slot0.nodeBgAnimatorPlayer:Play(slot1, slot2 or slot0.disableNodeBgAnimator, slot0)
end

function slot0.playIconAnim(slot0, slot1, slot2)
	if not slot0.iconAnimator then
		return
	end

	slot0.playingIconAnim = true

	slot0.iconAnimatorPlayer:Play(slot1, slot2 or slot0.disableIconAnimator, slot0)
end

function slot0.disableNodeBgAnimator(slot0)
	if slot0.nodeBgAnimator then
		slot0.playingBgAnim = false
	end
end

function slot0.disableIconAnimator(slot0)
	if slot0.iconAnimator then
		slot0.playingIconAnim = false
	end
end

function slot0.destroy(slot0)
	if slot0.nodeBgAnimatorPlayer then
		slot0.nodeBgAnimatorPlayer:Stop()
	end

	if slot0.iconAnimatorPlayer then
		slot0.iconAnimatorPlayer:Stop()
	end

	uv0.super.destroy(slot0)
end

return slot0
