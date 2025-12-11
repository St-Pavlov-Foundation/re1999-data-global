module("modules.logic.scene.survival.comp.SurvivalSceneMapSpBlock", package.seeall)

local var_0_0 = class("SurvivalSceneMapSpBlock", BaseSceneComp)

var_0_0.EdgeResPath = "survival/effects/prefab/v3a1_scene_bianyuan.prefab"

function var_0_0.init(arg_1_0)
	arg_1_0.blockComp = arg_1_0:getCurScene().block

	arg_1_0:getCurScene().preloader:registerCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapSpBlockAdd, arg_1_0.onSpBlockAdd, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapSpBlockDel, arg_1_0.onSpBlockDelete, arg_1_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapDestoryPosAdd, arg_1_0.onMapDestoryPosAdd, arg_1_0)
end

function var_0_0._onPreloadFinish(arg_2_0)
	arg_2_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_2_0._onPreloadFinish, arg_2_0)

	arg_2_0._sceneGo = arg_2_0:getCurScene():getSceneContainerGO()
	arg_2_0._blockRoot = gohelper.create3d(arg_2_0._sceneGo, "SPBlockRoot")
	arg_2_0._edgeRes = SurvivalMapHelper.instance:getBlockRes(var_0_0.EdgeResPath)

	local var_2_0 = SurvivalMapModel.instance:getSceneMo()

	arg_2_0._allBlocks = {}
	arg_2_0._destroyBlocks = {}
	arg_2_0._spBlockEdge = {}
	arg_2_0._edgePool = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0.allDestroyPos) do
		arg_2_0._destroyBlocks[iter_2_0] = {}

		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			local var_2_1 = SurvivalDestoryBlockEntity.Create({
				pos = iter_2_3
			}, arg_2_0._blockRoot)

			arg_2_0._destroyBlocks[iter_2_0][iter_2_2] = var_2_1
		end
	end

	for iter_2_4, iter_2_5 in pairs(var_2_0.blocksById) do
		local var_2_2 = SurvivalSpBlockEntity.Create(iter_2_5, arg_2_0._blockRoot)

		arg_2_0._allBlocks[iter_2_4] = var_2_2

		arg_2_0:showHideBlock(iter_2_5.pos, false, true)

		for iter_2_6, iter_2_7 in ipairs(iter_2_5.exPoints) do
			arg_2_0:showHideBlock(iter_2_7, false, true)
		end

		if iter_2_5:getSubType() ~= SurvivalEnum.UnitSubType.Block then
			arg_2_0:checkEdge(iter_2_5.pos)
		end
	end

	arg_2_0:dispatchEvent(SurvivalEvent.OnSurvivalBlockLoadFinish)
end

function var_0_0.checkEdge(arg_3_0, arg_3_1)
	if not arg_3_0._edgeRes then
		return
	end

	local var_3_0 = SurvivalMapModel.instance:getCacheHexNode(1)

	var_3_0:copyFrom(arg_3_1)
	arg_3_0:checkEdge2(var_3_0)
	var_3_0:copyFrom(arg_3_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.Right])
	arg_3_0:checkEdge2(var_3_0)
	var_3_0:copyFrom(arg_3_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.BottomLeft])
	arg_3_0:checkEdge2(var_3_0)
	var_3_0:copyFrom(arg_3_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.BottomRight])
	arg_3_0:checkEdge2(var_3_0)
end

function var_0_0.checkEdge2(arg_4_0, arg_4_1)
	local var_4_0 = SurvivalMapModel.instance:getSceneMo()
	local var_4_1 = SurvivalMapModel.instance:getCacheHexNode(2)
	local var_4_2 = var_4_1:copyFrom(arg_4_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.Left])
	local var_4_3 = not arg_4_0:isBlockSame(var_4_0:getBlockTypeByPos(arg_4_1), var_4_0:getBlockTypeByPos(var_4_2))

	arg_4_0:showHideEdge(var_4_3, arg_4_1, 1)

	local var_4_4 = var_4_1:copyFrom(arg_4_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.TopLeft])
	local var_4_5 = not arg_4_0:isBlockSame(var_4_0:getBlockTypeByPos(arg_4_1), var_4_0:getBlockTypeByPos(var_4_4))

	arg_4_0:showHideEdge(var_4_5, arg_4_1, 2)

	local var_4_6 = var_4_1:copyFrom(arg_4_1):Add(SurvivalEnum.DirToPos[SurvivalEnum.Dir.TopRight])
	local var_4_7 = not arg_4_0:isBlockSame(var_4_0:getBlockTypeByPos(arg_4_1), var_4_0:getBlockTypeByPos(var_4_6))

	arg_4_0:showHideEdge(var_4_7, arg_4_1, 3)
end

function var_0_0.showHideEdge(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._spBlockEdge[arg_5_2.q] = arg_5_0._spBlockEdge[arg_5_2.q] or {}
	arg_5_0._spBlockEdge[arg_5_2.q][arg_5_2.r] = arg_5_0._spBlockEdge[arg_5_2.q][arg_5_2.r] or {}

	local var_5_0 = arg_5_0._spBlockEdge[arg_5_2.q][arg_5_2.r][arg_5_3]

	if arg_5_1 and not var_5_0 then
		var_5_0 = table.remove(arg_5_0._edgePool)

		local var_5_1

		if not var_5_0 then
			var_5_0 = gohelper.clone(arg_5_0._edgeRes, arg_5_0._blockRoot, "edge")
		else
			gohelper.setActive(var_5_0, true)
		end

		local var_5_2 = var_5_0.transform

		if arg_5_3 == 1 then
			local var_5_3, var_5_4, var_5_5 = SurvivalHelper.instance:hexPointToWorldPoint(arg_5_2.q - 0.5, arg_5_2.r)

			transformhelper.setLocalRotation(var_5_2, 0, 180, 0)
			transformhelper.setLocalPos(var_5_2, var_5_3, var_5_4, var_5_5)
		elseif arg_5_3 == 2 then
			local var_5_6, var_5_7, var_5_8 = SurvivalHelper.instance:hexPointToWorldPoint(arg_5_2.q, arg_5_2.r - 0.5)

			transformhelper.setLocalRotation(var_5_2, 0, -120, 0)
			transformhelper.setLocalPos(var_5_2, var_5_6, var_5_7, var_5_8)
		elseif arg_5_3 == 3 then
			local var_5_9, var_5_10, var_5_11 = SurvivalHelper.instance:hexPointToWorldPoint(arg_5_2.q + 0.5, arg_5_2.r - 0.5)

			transformhelper.setLocalRotation(var_5_2, 0, -60, 0)
			transformhelper.setLocalPos(var_5_2, var_5_9, var_5_10, var_5_11)
		end

		arg_5_0._spBlockEdge[arg_5_2.q][arg_5_2.r][arg_5_3] = var_5_0
	elseif not arg_5_1 and var_5_0 then
		if arg_5_0._edgePool[20] then
			gohelper.destroy(var_5_0)
		else
			gohelper.setActive(var_5_0, false)
			table.insert(arg_5_0._edgePool, var_5_0)
		end

		arg_5_0._spBlockEdge[arg_5_2.q][arg_5_2.r][arg_5_3] = nil
	end
end

function var_0_0.isBlockSame(arg_6_0, arg_6_1, arg_6_2)
	return (arg_6_1 ~= -1 and arg_6_1 ~= SurvivalEnum.UnitSubType.Block) == (arg_6_2 ~= -1 and arg_6_2 ~= SurvivalEnum.UnitSubType.Block)
end

function var_0_0.onMapDestoryPosAdd(arg_7_0, arg_7_1)
	arg_7_0:showHideBlock(arg_7_1.pos, true, true)

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.exPoints) do
		arg_7_0:showHideBlock(iter_7_1, true, true)
	end
end

function var_0_0.showHideBlock(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = SurvivalHelper.instance:getValueFromDict(arg_8_0._destroyBlocks, arg_8_1)

	if var_8_0 then
		gohelper.setActive(var_8_0.go, arg_8_2)

		if arg_8_2 then
			arg_8_0.blockComp:setBlockActive(arg_8_1, false)
		end
	elseif arg_8_3 then
		if arg_8_2 then
			arg_8_0._destroyBlocks[arg_8_1.q] = arg_8_0._destroyBlocks[arg_8_1.q] or {}

			local var_8_1 = SurvivalDestoryBlockEntity.Create({
				pos = arg_8_1
			}, arg_8_0._blockRoot)

			arg_8_0._destroyBlocks[arg_8_1.q][arg_8_1.r] = var_8_1

			arg_8_0.blockComp:setBlockActive(arg_8_1, false)
		end
	else
		arg_8_0.blockComp:setBlockActive(arg_8_1, arg_8_2)
	end
end

function var_0_0.onSpBlockAdd(arg_9_0, arg_9_1)
	local var_9_0 = SurvivalSpBlockEntity.Create(arg_9_1, arg_9_0._blockRoot)

	arg_9_0._allBlocks[arg_9_1.id] = var_9_0

	arg_9_0:showHideBlock(arg_9_1.pos, false, false)

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.exPoints) do
		arg_9_0:showHideBlock(iter_9_1, false, false)
	end

	if arg_9_1:getSubType() ~= SurvivalEnum.UnitSubType.Block then
		arg_9_0:checkEdge(arg_9_1.pos)
	end
end

function var_0_0.onSpBlockDelete(arg_10_0, arg_10_1)
	if arg_10_0._allBlocks[arg_10_1.id] then
		arg_10_0:showHideBlock(arg_10_1.pos, true, false)

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.exPoints) do
			arg_10_0:showHideBlock(iter_10_1, true, false)
		end

		arg_10_0._allBlocks[arg_10_1.id]:tryDestory()

		arg_10_0._allBlocks[arg_10_1.id] = nil
	end

	if arg_10_1:getSubType() ~= SurvivalEnum.UnitSubType.Block then
		arg_10_0:checkEdge(arg_10_1.pos)
	end
end

function var_0_0.onSceneClose(arg_11_0)
	arg_11_0:getCurScene().preloader:unregisterCallback(SurvivalEvent.OnSurvivalPreloadFinish, arg_11_0._onPreloadFinish, arg_11_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapSpBlockAdd, arg_11_0.onSpBlockAdd, arg_11_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapSpBlockDel, arg_11_0.onSpBlockDelete, arg_11_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapDestoryPosAdd, arg_11_0.onMapDestoryPosAdd, arg_11_0)
	gohelper.destroy(arg_11_0._blockRoot)

	arg_11_0._blockRoot = nil
	arg_11_0._sceneGo = nil
	arg_11_0._allBlocks = {}
	arg_11_0._destroyBlocks = {}
	arg_11_0._edgeRes = nil
	arg_11_0._spBlockEdge = {}
	arg_11_0._edgePool = {}
end

return var_0_0
