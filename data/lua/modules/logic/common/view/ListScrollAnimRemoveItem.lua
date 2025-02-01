module("modules.logic.common.view.ListScrollAnimRemoveItem", package.seeall)

slot0 = class("ListScrollAnimRemoveItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.goScroll = slot1
	slot0.rectScroll = slot0.goScroll.transform
	slot0.rectViewPort = gohelper.findChild(slot0.goScroll, "Viewport").transform
end

function slot0.Get(slot0)
	if gohelper.isNil(slot0._csListScroll) then
		logError("ListScrollView 还没初始化")

		return
	end

	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot1.gameObject, uv0)

	slot2:setListModel(slot0)

	return slot2
end

function slot0.setListModel(slot0, slot1)
	slot0._luaListScrollView = slot1
	slot0._listModel = slot1._model
	slot0._csListScroll = slot1._csListScroll
	slot0._listParam = slot1._param
	slot0._scrollDir = slot0._listParam.scrollDir
	slot0._cellSizeAndSpace = 0

	if slot0._scrollDir == ScrollEnum.ScrollDirH then
		slot0._cellSizeAndSpace = slot0._listParam.cellWidth + slot0._listParam.cellSpaceH
	elseif slot0._scrollDir == ScrollEnum.ScrollDirV then
		slot0._cellSizeAndSpace = slot0._listParam.cellHeight + slot0._listParam.cellSpaceV
	end

	slot0:changeGameObjectNode()
end

function slot0.changeGameObjectNode(slot0, slot1)
	if slot0._scrollDir == ScrollEnum.ScrollDirH then
		slot3 = slot0._listParam.cellWidth + slot0._listParam.cellSpaceH

		recthelper.setWidth(slot0.rectScroll, recthelper.getWidth(slot0.rectScroll) + slot3)

		slot0.rectViewPort.offsetMax = Vector2(slot3 * (slot1 or 1), 0)
	elseif slot0._scrollDir == ScrollEnum.ScrollDirV then
		slot3 = slot0._listParam.cellHeight + slot0._listParam.cellSpaceV

		recthelper.setHeight(slot0.rectScroll, recthelper.getHeight(slot0.rectScroll) + slot3)

		slot0.rectViewPort.offsetMin = Vector2(0, slot3 * slot1)
	end
end

function slot0._getListModel(slot0)
	return slot0._listModel
end

function slot0.setMoveInterval(slot0, slot1)
	slot0.moveInterval = slot1
end

function slot0.getMoveInterval(slot0)
	return slot0.moveInterval or 0.05
end

function slot0.setMoveAnimationTime(slot0, slot1)
	slot0.moveAnimationTime = slot1
end

function slot0.getMoveAnimationTime(slot0)
	return slot0.moveAnimationTime or 0.15
end

function slot0.removeById(slot0, slot1, slot2, slot3)
	slot0:removeByIndexs({
		slot0._listModel:getIndex(slot0._listModel:getById(slot1))
	}, slot2, slot3)
end

function slot0.removeByIds(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		table.insert(slot4, slot0._listModel:getIndex(slot0._listModel:getById(slot9)))
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0 < slot1
	end)
	slot0:removeByIndexs(slot4, slot2, slot3)
end

function slot0.removeByIndex(slot0, slot1, slot2, slot3)
	slot0:removeByIndexs({
		slot1
	}, slot2, slot3)
end

function slot0.removeByIndexs(slot0, slot1, slot2, slot3)
	slot0._callback = slot2
	slot0._callbackObj = slot3
	slot4 = slot0._listModel:getList()
	slot0.newMoList = tabletool.copy(slot4)
	slot5 = {
		[slot9] = slot9
	}

	for slot9, slot10 in ipairs(slot4) do
		-- Nothing
	end

	for slot9 = #slot1, 1, -1 do
		for slot14 = slot1[slot9], #slot5 do
			slot5[slot14] = slot5[slot14 + 1]
		end

		table.remove(slot0.newMoList, slot10)
	end

	slot0._flow = FlowParallel.New()
	slot6 = 0

	for slot10 = 1, #slot0.newMoList do
		slot11 = slot10

		if slot11 ~= slot5[slot10] and slot0._csListScroll:IsVisual(slot11 - 1) then
			if gohelper.isNil(slot0._csListScroll:GetRenderCellRect(slot12 - 1)) then
				break
			end

			slot15, slot16 = recthelper.getAnchor(slot0._csListScroll:GetRenderCellRect(slot11 - 1))
			slot17, slot18 = recthelper.getAnchor(slot14)

			recthelper.setAnchor(slot14, slot17, slot18)

			slot19 = TweenWork.New({
				type = "DOAnchorPos",
				tr = slot14,
				tox = slot15,
				toy = slot16,
				t = slot0:getMoveAnimationTime(),
				ease = EaseType.Linear
			})

			slot0._flow:addWork(FlowSequence.New())

			if slot0:getMoveInterval() > 0 then
				slot20:addWork(WorkWaitSeconds.New(slot0:getMoveInterval() * slot6))
			end

			slot20:addWork(slot19)

			slot6 = slot6 + 1
		end
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.ListScrollAnimRemoveItem)
	slot0._flow:registerDoneListener(slot0._onDone, slot0)
	slot0._flow:start()
	TaskDispatcher.runDelay(slot0._delayRemoveBlock, slot0, 2)
end

function slot0._delayRemoveBlock(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)
end

function slot0._onDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayRemoveBlock, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	slot0._flow = nil
	slot0.newMoList = nil

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj)
		else
			slot0._callback()
		end

		slot0._callback = nil
		slot0._callbackObj = nil
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayRemoveBlock, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	slot0._csListScroll = nil
	slot0.newMoList = nil

	if slot0._flow then
		slot0._flow:destroy()

		slot0._flow = nil
	end

	slot0._callback = nil
	slot0._callbackObj = nil
end

return slot0
