module("modules.logic.scene.summon.SummonSceneShell", package.seeall)

local var_0_0 = class("SummonSceneShell")
local var_0_1 = {
	Prepared = 3,
	Close = 1,
	Start = 2
}

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._curSceneId = arg_1_1
	arg_1_0._curLevelId = arg_1_2
	arg_1_0._curStep = var_0_1.Close
	arg_1_0._allComps = {}

	arg_1_0:registClz()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._allComps) do
		if iter_1_1.onInit then
			iter_1_1:onInit()
		end
	end
end

function var_0_0.registClz(arg_2_0)
	arg_2_0:_addComp("director", SummonSceneDirector)
	arg_2_0:_addComp("view", SummonSceneViewComp)
	arg_2_0:_addComp("bgm", SummonSceneBgmComp)
	arg_2_0:_addComp("cameraAnim", SummonSceneCameraComp)
	arg_2_0:_addComp("preloader", SummonScenePreloader)
	arg_2_0:_addComp("selector", SummonSceneSelector)
end

function var_0_0._addComp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.New(arg_3_0)

	arg_3_0[arg_3_1] = var_3_0

	table.insert(arg_3_0._allComps, var_3_0)
end

function var_0_0.onStart(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._curStep ~= var_0_1.Close then
		return
	end

	arg_4_0._curStep = var_0_1.Start

	logNormal("summmon start")

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._allComps) do
		if iter_4_1.onSceneStart and not iter_4_1.isOnStarted then
			iter_4_1:onSceneStart(arg_4_1, arg_4_2)
		end
	end
end

function var_0_0.onPrepared(arg_5_0)
	if arg_5_0._curStep ~= var_0_1.Start then
		return
	end

	arg_5_0._curStep = var_0_1.Prepared

	logNormal("summmon onPrepared")

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._allComps) do
		if iter_5_1.onScenePrepared then
			iter_5_1:onScenePrepared(arg_5_0._curSceneId, arg_5_0._curLevelId)
		end
	end

	SummonController.instance:dispatchEvent(SummonEvent.onSummonScenePrepared)
end

function var_0_0.onClose(arg_6_0)
	if arg_6_0._curStep == var_0_1.Close then
		return
	end

	arg_6_0._curStep = var_0_1.Close

	logNormal("summmon close")

	arg_6_0._isClosing = true

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._allComps) do
		if iter_6_1.onSceneClose then
			iter_6_1:onSceneClose()
		end
	end

	arg_6_0._isClosing = false
end

function var_0_0.onHide(arg_7_0)
	if arg_7_0._curStep == var_0_1.Close then
		return
	end

	arg_7_0._curStep = var_0_1.Close

	logNormal("summmon hide")

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._allComps) do
		if iter_7_1.onSceneHide then
			iter_7_1:onSceneHide()
		end
	end
end

function var_0_0.getSceneContainerGO(arg_8_0)
	return VirtualSummonScene.instance:getRootGO()
end

return var_0_0
