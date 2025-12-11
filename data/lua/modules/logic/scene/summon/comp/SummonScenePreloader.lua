module("modules.logic.scene.summon.comp.SummonScenePreloader", package.seeall)

local var_0_0 = class("SummonScenePreloader", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._isImageLoad = false
	arg_1_0._assetItemDict = {}
	arg_1_0._assetItemList = {}

	arg_1_0:_startLoadImage()
end

function var_0_0._startLoadImage(arg_2_0)
	local var_2_0 = SummonMainController.instance:pickAllUIPreloadRes()

	if #var_2_0 > 0 then
		arg_2_0._uiLoader = SequenceAbLoader.New()

		arg_2_0._uiLoader:setPathList(var_2_0)
		arg_2_0._uiLoader:setConcurrentCount(5)
		arg_2_0._uiLoader:startLoad(arg_2_0._onUIPreloadFinish, arg_2_0)
	end
end

function var_0_0._onUIPreloadFinish(arg_3_0)
	local var_3_0 = arg_3_0._uiLoader:getAssetItemDict()

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		iter_3_1:Retain()

		arg_3_0._assetItemDict[iter_3_0] = iter_3_1

		table.insert(arg_3_0._assetItemList, iter_3_1)
	end

	if arg_3_0._uiLoader then
		arg_3_0._uiLoader:dispose()

		arg_3_0._uiLoader = nil
	end

	arg_3_0._isImageLoad = true
end

function var_0_0.getAssetItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._assetItemDict[arg_4_1]

	if var_4_0 then
		return var_4_0
	end
end

function var_0_0.onSceneClose(arg_5_0)
	if arg_5_0._uiLoader then
		arg_5_0._uiLoader:dispose()

		arg_5_0._uiLoader = nil
	end

	if arg_5_0._assetItemList and #arg_5_0._assetItemList > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._assetItemList) do
			iter_5_1:Release()
		end

		arg_5_0._assetItemList = {}
		arg_5_0._assetItemDict = {}
	end
end

function var_0_0.onSceneHide(arg_6_0)
	arg_6_0:onSceneClose()
end

return var_0_0
