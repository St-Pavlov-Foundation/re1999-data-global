module("modules.logic.rouge.map.map.itemcomp.RougeMapNodeItem", package.seeall)

local var_0_0 = class("RougeMapNodeItem", RougeMapBaseItem)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.init(arg_1_0)

	arg_1_0.episodeItem = arg_1_3
	arg_1_0.posType = arg_1_3.posType
	arg_1_0.parentGo = arg_1_3.go
	arg_1_0.nodeMo = arg_1_1
	arg_1_0.map = arg_1_2
	arg_1_0.nodeId = arg_1_0.nodeMo.nodeId
	arg_1_0.select = false

	arg_1_0:updateData()
	arg_1_0:setId(arg_1_0.nodeMo.nodeId)
	arg_1_0:createGo()
	arg_1_0:createNodeBg()
	arg_1_0:createIcon()
	arg_1_0:checkNodeFog()
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_1_0.onUpdateMapInfo, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectNode, arg_1_0.onSelectNode, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_1_0.onCloseViewFinish, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_1_0.onCloseFullView, arg_1_0)
end

function var_0_0.updateData(arg_2_0)
	arg_2_0.eventId = arg_2_0.nodeMo.eventId
	arg_2_0.eventCo = arg_2_0.nodeMo:getEventCo()
	arg_2_0.arriveStatus = arg_2_0.nodeMo.arriveStatus
end

function var_0_0.createGo(arg_3_0)
	arg_3_0.go = gohelper.create3d(arg_3_0.parentGo, arg_3_0.nodeId)
	arg_3_0.tr = arg_3_0.go:GetComponent(gohelper.Type_Transform)

	local var_3_0, var_3_1, var_3_2 = RougeMapHelper.getNodeLocalPos(arg_3_0.nodeMo.index, arg_3_0.posType)

	arg_3_0.nodeMo:setPos(var_3_0, var_3_1, var_3_2)
	transformhelper.setLocalPos(arg_3_0.tr, var_3_0, var_3_1, var_3_2)
end

function var_0_0.createNodeBg(arg_4_0)
	local var_4_0
	local var_4_1

	if arg_4_0.nodeMo:checkIsNormal() then
		var_4_0 = arg_4_0.map:getNodeBgPrefab(arg_4_0.eventCo, arg_4_0.arriveStatus)
		var_4_1 = RougeMapEnum.NodeBgOffset[arg_4_0.arriveStatus]
	else
		var_4_0 = arg_4_0.map.startBgPrefab
		var_4_1 = RougeMapEnum.StartBgOffset
	end

	arg_4_0.nodeBgGo = gohelper.clone(var_4_0, arg_4_0.go, "bg")
	arg_4_0.nodeBgTr = arg_4_0.nodeBgGo:GetComponent(gohelper.Type_Transform)
	arg_4_0.nodeBgAnimator = arg_4_0.nodeBgGo:GetComponent(gohelper.Type_Animator)
	arg_4_0.nodeBgAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.nodeBgGo)

	transformhelper.setLocalScale(arg_4_0.nodeBgTr, RougeMapEnum.Scale.NodeBg, RougeMapEnum.Scale.NodeBg, 1)
	transformhelper.setLocalPos(arg_4_0.nodeBgTr, var_4_1.x, var_4_1.y, arg_4_0:getBgOffsetZ())
	arg_4_0:playNodeBgAnim("open")
end

function var_0_0.createIcon(arg_5_0)
	if arg_5_0.nodeMo:checkIsNormal() then
		local var_5_0 = arg_5_0.map:getNodeIconPrefab(arg_5_0.eventCo)

		arg_5_0.iconGo = gohelper.clone(var_5_0, arg_5_0.go, "icon")
		arg_5_0.iconTr = arg_5_0.iconGo:GetComponent(gohelper.Type_Transform)
		arg_5_0.iconAnimator = arg_5_0.iconGo:GetComponent(gohelper.Type_Animator)
		arg_5_0.iconAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_5_0.iconGo)

		transformhelper.setLocalScale(arg_5_0.iconTr, RougeMapEnum.Scale.Icon, RougeMapEnum.Scale.Icon, 1)
		arg_5_0:updateIconPos()

		if arg_5_0.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			arg_5_0:playIconAnim("overdue")
		else
			arg_5_0:playIconAnim("open")
		end
	else
		arg_5_0.iconGo = nil
		arg_5_0.iconTr = nil
		arg_5_0.iconAnimator = nil
	end
end

function var_0_0.updateIconPos(arg_6_0)
	if arg_6_0.eventCo then
		local var_6_0 = RougeMapEnum.IconOffset[arg_6_0.arriveStatus]

		transformhelper.setLocalPos(arg_6_0.iconTr, var_6_0.x, var_6_0.y, arg_6_0:getIconOffsetZ())
	end
end

function var_0_0.getIconOffsetZ(arg_7_0)
	return arg_7_0:getBgOffsetZ() - RougeMapEnum.NodeIconOffsetZInterval
end

function var_0_0.getBgOffsetZ(arg_8_0)
	return -(arg_8_0.nodeMo.index - 1) * (RougeMapEnum.NodeOffsetZInterval + RougeMapEnum.NodeIconOffsetZInterval)
end

function var_0_0.getScenePos(arg_9_0)
	return arg_9_0.nodeBgTr.position
end

function var_0_0.getMapPos(arg_10_0)
	local var_10_0, var_10_1, var_10_2 = RougeMapHelper.getNodeContainerPos(arg_10_0.nodeMo.episodeId, arg_10_0.nodeMo:getEpisodePos())

	return var_10_0, var_10_1, var_10_2
end

function var_0_0.getActorPos(arg_11_0)
	local var_11_0, var_11_1, var_11_2 = arg_11_0:getMapPos()

	return RougeMapEnum.ActorOffset.x + var_11_0, RougeMapEnum.ActorOffset.y + var_11_1, var_11_2
end

function var_0_0.getClickArea(arg_12_0)
	if not arg_12_0.nodeMo:checkIsNormal() then
		return RougeMapEnum.StartClickArea
	end

	return RougeMapEnum.ClickArea[arg_12_0.arriveStatus]
end

function var_0_0.onClick(arg_13_0)
	logNormal(string.format("on click node id : %s, arrive status : %s", arg_13_0.nodeId, arg_13_0.arriveStatus))

	if arg_13_0.arriveStatus == RougeMapEnum.Arrive.CantArrive or arg_13_0.arriveStatus == RougeMapEnum.Arrive.NotArrive or arg_13_0.arriveStatus == RougeMapEnum.Arrive.ArrivingFinish or arg_13_0.arriveStatus == RougeMapEnum.Arrive.Arrived then
		return
	end

	if not arg_13_0.eventCo then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, arg_13_0.nodeMo)
end

function var_0_0.updateNode(arg_14_0)
	arg_14_0.arriveStatus = arg_14_0:getArriveStatus()

	arg_14_0:checkNodeFog()

	if arg_14_0.fog then
		return
	end

	if arg_14_0.nodeBgAnimator then
		arg_14_0:playNodeBgAnim("close", arg_14_0._updateNodeBg)
	else
		arg_14_0:_updateNodeBg()
	end

	if arg_14_0.iconAnimator then
		arg_14_0:playIconAnim("close", arg_14_0._updateIcon)
	else
		arg_14_0:_updateIcon()
	end
end

function var_0_0._updateNodeBg(arg_15_0)
	gohelper.destroy(arg_15_0.nodeBgGo)
	arg_15_0:createNodeBg()
end

function var_0_0._updateIcon(arg_16_0)
	gohelper.destroy(arg_16_0.iconGo)
	arg_16_0:createIcon()
end

function var_0_0.onUpdateMapInfo(arg_17_0)
	if not RougeMapHelper.checkMapViewOnTop() then
		arg_17_0.waitUpdate = true

		return
	end

	arg_17_0.waitUpdate = nil

	if arg_17_0.eventId ~= arg_17_0.nodeMo.eventId then
		arg_17_0.eventId = arg_17_0.nodeMo.eventId
		arg_17_0.eventCo = arg_17_0.nodeMo:getEventCo()

		arg_17_0:updateNode()

		return
	end

	if arg_17_0.arriveStatus ~= arg_17_0:getArriveStatus() then
		arg_17_0:updateNode()

		return
	end

	if arg_17_0.fog ~= arg_17_0.nodeMo.fog then
		arg_17_0:updateNode()

		return
	end
end

function var_0_0.getArriveStatus(arg_18_0)
	if arg_18_0.select then
		return RougeMapEnum.NodeSelectArriveStatus
	end

	return arg_18_0.nodeMo.arriveStatus
end

function var_0_0.checkNodeFog(arg_19_0)
	arg_19_0.fog = arg_19_0.nodeMo.fog

	gohelper.setActive(arg_19_0.go, not arg_19_0.fog)
end

function var_0_0.onSelectNode(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1 == arg_20_0.nodeMo

	if arg_20_0.select == var_20_0 then
		return
	end

	arg_20_0.select = var_20_0

	if arg_20_0.arriveStatus ~= arg_20_0:getArriveStatus() then
		arg_20_0:updateNode()
	end

	if arg_20_0.select then
		AudioMgr.instance:trigger(AudioEnum.UI.SelectNode)
	end
end

function var_0_0.onCloseViewFinish(arg_21_0, arg_21_1)
	if arg_21_0.waitUpdate then
		arg_21_0:onUpdateMapInfo()
		arg_21_0:checkNodeFog()
	end
end

function var_0_0.onCloseFullView(arg_22_0)
	if not arg_22_0.playingBgAnim and arg_22_0.nodeBgAnimator then
		arg_22_0.nodeBgAnimator:Play("idle", 0, 1)
	end

	if not arg_22_0.playingIconAnim and arg_22_0.iconAnimator then
		if arg_22_0.arriveStatus == RougeMapEnum.Arrive.CantArrive then
			arg_22_0.iconAnimator:Play("overdue", 0, 1)
		else
			arg_22_0.iconAnimator:Play("idle", 0, 1)
		end
	end
end

function var_0_0.setLineItem(arg_23_0, arg_23_1)
	arg_23_0.lineItem = arg_23_1
end

function var_0_0.getLineItem(arg_24_0)
	return arg_24_0.lineItem
end

function var_0_0.playNodeBgAnim(arg_25_0, arg_25_1, arg_25_2)
	if not arg_25_0.nodeBgAnimator then
		return
	end

	arg_25_0.playingBgAnim = true

	arg_25_0.nodeBgAnimatorPlayer:Play(arg_25_1, arg_25_2 or arg_25_0.disableNodeBgAnimator, arg_25_0)
end

function var_0_0.playIconAnim(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0.iconAnimator then
		return
	end

	arg_26_0.playingIconAnim = true

	arg_26_0.iconAnimatorPlayer:Play(arg_26_1, arg_26_2 or arg_26_0.disableIconAnimator, arg_26_0)
end

function var_0_0.disableNodeBgAnimator(arg_27_0)
	if arg_27_0.nodeBgAnimator then
		arg_27_0.playingBgAnim = false
	end
end

function var_0_0.disableIconAnimator(arg_28_0)
	if arg_28_0.iconAnimator then
		arg_28_0.playingIconAnim = false
	end
end

function var_0_0.destroy(arg_29_0)
	if arg_29_0.nodeBgAnimatorPlayer then
		arg_29_0.nodeBgAnimatorPlayer:Stop()
	end

	if arg_29_0.iconAnimatorPlayer then
		arg_29_0.iconAnimatorPlayer:Stop()
	end

	var_0_0.super.destroy(arg_29_0)
end

return var_0_0
