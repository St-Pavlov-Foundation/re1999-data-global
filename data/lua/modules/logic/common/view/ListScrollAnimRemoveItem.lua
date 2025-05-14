module("modules.logic.common.view.ListScrollAnimRemoveItem", package.seeall)

local var_0_0 = class("ListScrollAnimRemoveItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.goScroll = arg_1_1
	arg_1_0.rectScroll = arg_1_0.goScroll.transform
	arg_1_0.rectViewPort = gohelper.findChild(arg_1_0.goScroll, "Viewport").transform
end

function var_0_0.Get(arg_2_0)
	local var_2_0 = arg_2_0._csListScroll

	if gohelper.isNil(var_2_0) then
		logError("ListScrollView 还没初始化")

		return
	end

	local var_2_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_0.gameObject, var_0_0)

	var_2_1:setListModel(arg_2_0)

	return var_2_1
end

function var_0_0.setListModel(arg_3_0, arg_3_1)
	arg_3_0._luaListScrollView = arg_3_1
	arg_3_0._listModel = arg_3_1._model
	arg_3_0._csListScroll = arg_3_1._csListScroll
	arg_3_0._listParam = arg_3_1._param
	arg_3_0._scrollDir = arg_3_0._listParam.scrollDir
	arg_3_0._cellSizeAndSpace = 0

	if arg_3_0._scrollDir == ScrollEnum.ScrollDirH then
		arg_3_0._cellSizeAndSpace = arg_3_0._listParam.cellWidth + arg_3_0._listParam.cellSpaceH
	elseif arg_3_0._scrollDir == ScrollEnum.ScrollDirV then
		arg_3_0._cellSizeAndSpace = arg_3_0._listParam.cellHeight + arg_3_0._listParam.cellSpaceV
	end

	arg_3_0:changeGameObjectNode()
end

function var_0_0.changeGameObjectNode(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or 1

	if arg_4_0._scrollDir == ScrollEnum.ScrollDirH then
		local var_4_0 = recthelper.getWidth(arg_4_0.rectScroll)
		local var_4_1 = arg_4_0._listParam.cellWidth + arg_4_0._listParam.cellSpaceH

		recthelper.setWidth(arg_4_0.rectScroll, var_4_0 + var_4_1)

		arg_4_0.rectViewPort.offsetMax = Vector2(var_4_1 * arg_4_1, 0)
	elseif arg_4_0._scrollDir == ScrollEnum.ScrollDirV then
		local var_4_2 = recthelper.getHeight(arg_4_0.rectScroll)
		local var_4_3 = arg_4_0._listParam.cellHeight + arg_4_0._listParam.cellSpaceV

		recthelper.setHeight(arg_4_0.rectScroll, var_4_2 + var_4_3)

		arg_4_0.rectViewPort.offsetMin = Vector2(0, var_4_3 * arg_4_1)
	end
end

function var_0_0._getListModel(arg_5_0)
	return arg_5_0._listModel
end

function var_0_0.setMoveInterval(arg_6_0, arg_6_1)
	arg_6_0.moveInterval = arg_6_1
end

function var_0_0.getMoveInterval(arg_7_0)
	return arg_7_0.moveInterval or 0.05
end

function var_0_0.setMoveAnimationTime(arg_8_0, arg_8_1)
	arg_8_0.moveAnimationTime = arg_8_1
end

function var_0_0.getMoveAnimationTime(arg_9_0)
	return arg_9_0.moveAnimationTime or 0.15
end

function var_0_0.removeById(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._listModel:getById(arg_10_1)
	local var_10_1 = arg_10_0._listModel:getIndex(var_10_0)

	arg_10_0:removeByIndexs({
		var_10_1
	}, arg_10_2, arg_10_3)
end

function var_0_0.removeByIds(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = arg_11_0._listModel:getById(iter_11_1)
		local var_11_2 = arg_11_0._listModel:getIndex(var_11_1)

		table.insert(var_11_0, var_11_2)
	end

	table.sort(var_11_0, function(arg_12_0, arg_12_1)
		return arg_12_0 < arg_12_1
	end)
	arg_11_0:removeByIndexs(var_11_0, arg_11_2, arg_11_3)
end

function var_0_0.removeByIndex(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:removeByIndexs({
		arg_13_1
	}, arg_13_2, arg_13_3)
end

function var_0_0.removeByIndexs(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_0._callback = arg_14_2
	arg_14_0._callbackObj = arg_14_3

	local var_14_0 = arg_14_0._listModel:getList()

	arg_14_0.newMoList = tabletool.copy(var_14_0)

	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		var_14_1[iter_14_0] = iter_14_0
	end

	for iter_14_2 = #arg_14_1, 1, -1 do
		local var_14_2 = arg_14_1[iter_14_2]

		for iter_14_3 = var_14_2, #var_14_1 do
			var_14_1[iter_14_3] = var_14_1[iter_14_3 + 1]
		end

		table.remove(arg_14_0.newMoList, var_14_2)
	end

	arg_14_0._flow = FlowParallel.New()

	local var_14_3 = 0

	for iter_14_4 = 1, #arg_14_0.newMoList do
		local var_14_4 = iter_14_4
		local var_14_5 = var_14_1[iter_14_4]
		local var_14_6 = arg_14_0._csListScroll:IsVisual(var_14_4 - 1)

		if var_14_4 ~= var_14_5 and var_14_6 then
			local var_14_7 = arg_14_0._csListScroll:GetRenderCellRect(var_14_5 - 1)

			if gohelper.isNil(var_14_7) then
				break
			end

			local var_14_8, var_14_9 = recthelper.getAnchor(arg_14_0._csListScroll:GetRenderCellRect(var_14_4 - 1))
			local var_14_10, var_14_11 = recthelper.getAnchor(var_14_7)

			recthelper.setAnchor(var_14_7, var_14_10, var_14_11)

			local var_14_12 = TweenWork.New({
				type = "DOAnchorPos",
				tr = var_14_7,
				tox = var_14_8,
				toy = var_14_9,
				t = arg_14_0:getMoveAnimationTime(),
				ease = EaseType.Linear
			})
			local var_14_13 = FlowSequence.New()

			arg_14_0._flow:addWork(var_14_13)

			if arg_14_0:getMoveInterval() > 0 then
				var_14_13:addWork(WorkWaitSeconds.New(arg_14_0:getMoveInterval() * var_14_3))
			end

			var_14_13:addWork(var_14_12)

			var_14_3 = var_14_3 + 1
		end
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.ListScrollAnimRemoveItem)
	arg_14_0._flow:registerDoneListener(arg_14_0._onDone, arg_14_0)
	arg_14_0._flow:start()
	TaskDispatcher.runDelay(arg_14_0._delayRemoveBlock, arg_14_0, 2)
end

function var_0_0._delayRemoveBlock(arg_15_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)
end

function var_0_0._onDone(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._delayRemoveBlock, arg_16_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	arg_16_0._flow = nil
	arg_16_0.newMoList = nil

	if arg_16_0._callback then
		if arg_16_0._callbackObj then
			arg_16_0._callback(arg_16_0._callbackObj)
		else
			arg_16_0._callback()
		end

		arg_16_0._callback = nil
		arg_16_0._callbackObj = nil
	end
end

function var_0_0.onDestroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._delayRemoveBlock, arg_17_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.ListScrollAnimRemoveItem)

	arg_17_0._csListScroll = nil
	arg_17_0.newMoList = nil

	if arg_17_0._flow then
		arg_17_0._flow:destroy()

		arg_17_0._flow = nil
	end

	arg_17_0._callback = nil
	arg_17_0._callbackObj = nil
end

return var_0_0
