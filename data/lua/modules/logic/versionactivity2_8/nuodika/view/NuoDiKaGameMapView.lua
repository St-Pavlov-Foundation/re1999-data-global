module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaGameMapView", package.seeall)

local var_0_0 = class("NuoDiKaGameMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._gonodeItem = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_nodeItem")
	arg_1_0._gocontenttop = gohelper.findChild(arg_1_0.viewGO, "#go_maptop")
	arg_1_0._gonodeTopItem = gohelper.findChild(arg_1_0.viewGO, "#go_maptop/#go_nodetopItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._grid = arg_4_0._gocontent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	arg_4_0._topGrid = arg_4_0._gocontenttop:GetComponentInChildren(gohelper.Type_GridLayoutGroup)

	gohelper.setActive(arg_4_0._gonodeItem, false)
	gohelper.setActive(arg_4_0._gonodeTopItem, false)
	arg_4_0:_addEvents()
end

function var_0_0._addEvents(arg_5_0)
	arg_5_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDraging, arg_5_0._onNodeUnitDraging, arg_5_0)
	arg_5_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDragEnd, arg_5_0._onNodeUnitDragEnd, arg_5_0)
	arg_5_0:addEventCb(NuoDiKaController.instance, NuoDiKaEvent.MapRefresh, arg_5_0._onRefreshMap, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	arg_6_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDraging, arg_6_0._onNodeUnitDraging, arg_6_0)
	arg_6_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.NodeUnitDragEnd, arg_6_0._onNodeUnitDragEnd, arg_6_0)
	arg_6_0:removeEventCb(NuoDiKaController.instance, NuoDiKaEvent.MapRefresh, arg_6_0._onRefreshMap, arg_6_0)
end

function var_0_0._onRefreshMap(arg_7_0)
	arg_7_0:_refreshMap()
end

function var_0_0._getTargetNodeItem(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._nodeItems) do
		local var_8_0 = CameraMgr.instance:getUICamera()
		local var_8_1 = arg_8_0.viewGO.transform.position
		local var_8_2 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_8_1, var_8_0, var_8_1)
		local var_8_3 = iter_8_1:getNodeRoot().transform
		local var_8_4 = gohelper.findChild(var_8_3.gameObject, "btn_node"):GetComponent(typeof(UnityEngine.Collider2D))

		if var_8_4 and var_8_4:OverlapPoint(var_8_2) then
			return iter_8_1
		end
	end

	return nil
end

function var_0_0._onNodeUnitDraging(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._nodeItems) do
		iter_9_1:showPlaceable(false)
		iter_9_1:showDamage(false)
	end

	if not arg_9_2 or not arg_9_2:isNodeHasItem() then
		return
	end

	local var_9_0 = NuoDiKaConfig.instance:getItemCo(arg_9_2:getEvent().eventParam)

	if var_9_0.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local var_9_1 = arg_9_0:_getTargetNodeItem(arg_9_1)
	local var_9_2 = var_9_1

	if var_9_1 then
		local var_9_3 = var_9_1:getNodeMo()

		if var_9_0.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy then
			var_9_2 = var_9_2 and var_9_2 and var_9_3:isNodeUnlock() and var_9_3:isNodeHasEnemy()
		end
	end

	if not var_9_2 then
		for iter_9_2, iter_9_3 in pairs(arg_9_0._nodeItems) do
			local var_9_4 = iter_9_3:getNodeMo()

			if var_9_0.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy then
				if var_9_4:isNodeUnlock() and var_9_4:isNodeHasEnemy() then
					iter_9_3:showPlaceable(true)
				end
			elseif var_9_0.canEmpty == NuoDiKaEnum.ItemPlaceType.AllNode then
				iter_9_3:showPlaceable(true)
			end
		end

		return
	end

	local var_9_5 = NuoDiKaConfig.instance:getItemCo(arg_9_2:getEvent().eventParam)
	local var_9_6 = NuoDiKaConfig.instance:getSkillCo(var_9_5.skillID)
	local var_9_7 = string.splitToNumber(var_9_6.scale, "#")
	local var_9_8 = var_9_7[1]

	if var_9_8 == NuoDiKaEnum.TriggerRangeType.TargetNode then
		var_9_1:showDamage(true)
	elseif var_9_8 == NuoDiKaEnum.TriggerRangeType.RhombusLength then
		local var_9_9 = var_9_7[2] or 0
		local var_9_10 = var_9_1:getNodeMo()

		for iter_9_4, iter_9_5 in pairs(arg_9_0._nodeItems) do
			local var_9_11 = iter_9_5:getNodeMo()

			if var_9_9 >= math.abs(var_9_10.y - var_9_11.y) + math.abs(var_9_10.x - var_9_11.x) then
				iter_9_5:showDamage(true)
			end
		end
	elseif var_9_8 == NuoDiKaEnum.TriggerRangeType.SquareLength then
		local var_9_12 = var_9_7[2] or 0
		local var_9_13 = var_9_1:getNodeMo()

		for iter_9_6, iter_9_7 in pairs(arg_9_0._nodeItems) do
			local var_9_14 = iter_9_7:getNodeMo()

			if var_9_12 >= math.abs(var_9_13.y - var_9_14.y) and var_9_12 >= math.abs(var_9_13.x - var_9_14.x) then
				iter_9_7:showDamage(true)
			end
		end
	elseif var_9_8 == NuoDiKaEnum.TriggerRangeType.All then
		for iter_9_8, iter_9_9 in pairs(arg_9_0._nodeItems) do
			iter_9_9:showDamage(true)
		end
	end
end

function var_0_0._onNodeUnitDragEnd(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._nodeItems) do
		iter_10_1:showPlaceable(false)
		iter_10_1:showDamage(false)
	end

	if not arg_10_2 or not arg_10_2:isNodeHasItem() then
		return
	end

	local var_10_0 = NuoDiKaConfig.instance:getItemCo(arg_10_2:getEvent().eventParam)

	if var_10_0.canMove ~= NuoDiKaEnum.ItemDragType.CanMove then
		return
	end

	local var_10_1 = arg_10_0:_getTargetNodeItem(arg_10_1)

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1:getNodeMo()

	if var_10_0.canEmpty == NuoDiKaEnum.ItemPlaceType.AllEnemy and (not var_10_2:isNodeUnlock() or not var_10_2:isNodeHasEnemy()) then
		return
	end

	if arg_10_2.x == var_10_2.x and arg_10_2.y == var_10_2.y then
		return
	end

	local var_10_3 = arg_10_2:getEvent()

	if var_10_3 and var_10_3.eventParam == 2005 then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ShowItemScan, var_10_2)
	end

	local var_10_4 = NuoDiKaConfig.instance:getItemCo(var_10_3.eventParam).skillID
	local var_10_5 = NuoDiKaConfig.instance:getSkillCo(var_10_4)

	if tonumber(var_10_5.trigger) == NuoDiKaEnum.TriggerTimingType.Interact and (var_10_5.effect == NuoDiKaEnum.SkillType.AttackSelected or var_10_5.effect == NuoDiKaEnum.SkillType.AttackRandom or var_10_5.effect == NuoDiKaEnum.SkillType.AttackAll) then
		NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.StartInteract)
	end

	NuoDiKaMapModel.instance:setCurSelectNode(var_10_2.id)
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.ItemStartSkill, var_10_2, arg_10_2)
end

function var_0_0._checkMapSuccess(arg_11_0)
	if arg_11_0._mapMo.passType == NuoDiKaEnum.MapPassType.ClearEnemy then
		if NuoDiKaMapModel.instance:isAllEnemyDead(arg_11_0._mapId) then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameSuccess)
		end
	elseif arg_11_0._mapMo.passType == NuoDiKaEnum.MapPassType.UnlockItem then
		local var_11_0 = NuoDiKaMapModel.instance:isSpEventUnlock(arg_11_0._mapId)

		if var_11_0 then
			NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.GameItemUnlockSuccess, var_11_0)
		end
	end
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._actId = VersionActivity2_8Enum.ActivityId.NuoDiKa
	arg_12_0._mapId = NuoDiKaConfig.instance:getEpisodeCo(arg_12_0._actId, arg_12_0.viewParam.episodeId).mapId
	arg_12_0._mapMo = NuoDiKaMapModel.instance:getMap(arg_12_0._mapId)

	local var_12_0 = NuoDiKaMapModel.instance:getStartNodes(arg_12_0._mapId)

	NuoDiKaMapModel.instance:setCurSelectNode(var_12_0[1].id)

	arg_12_0._nodeItems = {}

	arg_12_0:_refreshMap()
end

function var_0_0._refreshMap(arg_13_0)
	arg_13_0:_refreshNodes()
	arg_13_0:_checkMapSuccess()
end

function var_0_0._refreshNodes(arg_14_0)
	local var_14_0 = NuoDiKaMapModel.instance:getMapRowCount(arg_14_0._mapId)
	local var_14_1 = NuoDiKaMapModel.instance:getMapLineCount(arg_14_0._mapId)
	local var_14_2 = NuoDiKaMapModel.instance:getMapNodes(arg_14_0._mapId)

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		if not arg_14_0._nodeItems[iter_14_1.id] then
			arg_14_0._nodeItems[iter_14_1.id] = NuoDiKaGameMapNodeItem.New()

			local var_14_3 = gohelper.cloneInPlace(arg_14_0._gonodeItem)
			local var_14_4 = gohelper.cloneInPlace(arg_14_0._gonodeTopItem)

			arg_14_0._nodeItems[iter_14_1.id]:init(var_14_3, var_14_4)
		end

		local var_14_5 = (iter_14_1.y - 0.5 * (var_14_1 + 1)) * NuoDiKaEnum.OnLineOffsetX
		local var_14_6 = (iter_14_1.y - 0.5 * (var_14_1 + 1)) * NuoDiKaEnum.OnLineOffsetY

		arg_14_0._nodeItems[iter_14_1.id]:setNodeOffset(var_14_5, var_14_6)
		arg_14_0._nodeItems[iter_14_1.id]:setItem(iter_14_1)
	end

	arg_14_0._grid.constraintCount = var_14_0
	arg_14_0._topGrid.constraintCount = var_14_0
end

function var_0_0.onClose(arg_15_0)
	NuoDiKaMapModel.instance:resetNode(arg_15_0._mapId)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0:_removeEvents()

	for iter_16_0, iter_16_1 in pairs(arg_16_0._nodeItems) do
		iter_16_1:destroy()
	end
end

return var_0_0
