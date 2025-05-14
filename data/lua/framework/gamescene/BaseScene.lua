module("framework.gamescene.BaseScene", package.seeall)

local var_0_0 = class("BaseScene")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._gameObj = arg_1_1
	arg_1_0._onPreparedCb = nil
	arg_1_0._onPreparedCbObj = nil
	arg_1_0._onPreparedOneCb = nil
	arg_1_0._onPreparedOneCbObj = nil
	arg_1_0._curSceneId = 0
	arg_1_0._curLevelId = 0
	arg_1_0._isClosing = false
	arg_1_0._allComps = {}

	arg_1_0:_createAllComps()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._allComps) do
		if iter_1_1.onInit then
			iter_1_1:onInit()
		end
	end
end

function var_0_0.getSceneContainerGO(arg_2_0)
	return arg_2_0._gameObj
end

function var_0_0.getCurLevelId(arg_3_0)
	return arg_3_0._curLevelId
end

function var_0_0.setCurLevelId(arg_4_0, arg_4_1)
	arg_4_0._curLevelId = arg_4_1
end

function var_0_0.setOnPreparedCb(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._onPreparedCb = arg_5_1
	arg_5_0._onPreparedCbObj = arg_5_2
end

function var_0_0.setOnPreparedOneCb(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._onPreparedOneCb = arg_6_1
	arg_6_0._onPreparedOneCbObj = arg_6_2
end

function var_0_0.onStart(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._curSceneId = arg_7_1
	arg_7_0._curLevelId = arg_7_2

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._allComps) do
		if iter_7_1.onSceneStart and not iter_7_1.isOnStarted then
			iter_7_1:onSceneStart(arg_7_1, arg_7_2)
		end
	end
end

function var_0_0.onPrepared(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._allComps) do
		if iter_8_1.onScenePrepared then
			iter_8_1:onScenePrepared(arg_8_0._curSceneId, arg_8_0._curLevelId)
		end
	end

	if not arg_8_0._onPreparedOneCb then
		return
	end

	callWithCatch(arg_8_0._onPreparedCb, arg_8_0._onPreparedCbObj)
end

function var_0_0.onDirectorLoadedOne(arg_9_0)
	if not arg_9_0._onPreparedOneCb then
		return
	end

	callWithCatch(arg_9_0._onPreparedOneCb, arg_9_0._onPreparedOneCbObj)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0._isClosing = true

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._allComps) do
		if iter_10_1.onSceneClose then
			iter_10_1:onSceneClose()
		end
	end

	arg_10_0._isClosing = false
end

function var_0_0.isClosing(arg_11_0)
	return arg_11_0._isClosing
end

function var_0_0._addComp(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.New(arg_12_0)

	arg_12_0[arg_12_1] = var_12_0

	table.insert(arg_12_0._allComps, var_12_0)
end

function var_0_0._createAllComps(arg_13_0)
	return
end

return var_0_0
