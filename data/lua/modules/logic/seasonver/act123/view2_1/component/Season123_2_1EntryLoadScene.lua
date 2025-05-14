module("modules.logic.seasonver.act123.view2_1.component.Season123_2_1EntryLoadScene", package.seeall)

local var_0_0 = class("Season123_2_1EntryLoadScene", UserDataDispose)

function var_0_0.init(arg_1_0)
	arg_1_0:__onInit()

	arg_1_0._prefabDict = {}
	arg_1_0._containerDict = arg_1_0:getUserDataTb_()
	arg_1_0._retailPrefabDict = {}
	arg_1_0._retailContainerDict = arg_1_0:getUserDataTb_()
	arg_1_0._retailPosXDict = {}
	arg_1_0._retailPosYDict = {}
	arg_1_0._animDict = arg_1_0:getUserDataTb_()
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:__onDispose()
	arg_2_0:releaseRes()
end

function var_0_0.createSceneRoot(arg_3_0)
	local var_3_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_3_1 = CameraMgr.instance:getSceneRoot()

	arg_3_0._sceneRoot = UnityEngine.GameObject.New("Season123_2_1EntryScene")

	local var_3_2, var_3_3, var_3_4 = transformhelper.getLocalPos(var_3_0)

	transformhelper.setLocalPos(arg_3_0._sceneRoot.transform, 0, var_3_3, 0)

	arg_3_0._sceneOffsetY = var_3_3

	gohelper.addChild(var_3_1, arg_3_0._sceneRoot)

	return arg_3_0._sceneRoot
end

function var_0_0.disposeSceneRoot(arg_4_0)
	if arg_4_0._sceneRoot then
		gohelper.destroy(arg_4_0._sceneRoot)

		arg_4_0._sceneRoot = nil
	end
end

var_0_0.BLOCK_LOAD_RES_KEY = "Season123_2_1EntrySceneLoadRes"

function var_0_0.loadRes(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._callback = arg_5_1
	arg_5_0._callbackObj = arg_5_2

	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_LOAD_RES_KEY)

	arg_5_0._loader = MultiAbLoader.New()

	arg_5_0._loader:addPath(arg_5_0:getSceneBackgroundUrl())
	arg_5_0._loader:startLoad(arg_5_0.onLoadResCompleted, arg_5_0)
end

function var_0_0.releaseRes(arg_6_0)
	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_LOAD_RES_KEY)

	if arg_6_0._prefabDict then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._prefabDict) do
			iter_6_1:dispose()
		end

		arg_6_0._prefabDict = nil
	end

	if arg_6_0._retailPrefabDict then
		for iter_6_2, iter_6_3 in pairs(arg_6_0._retailPrefabDict) do
			iter_6_3:dispose()
		end

		arg_6_0._retailPrefabDict = nil
	end
end

function var_0_0.getSceneBackgroundUrl(arg_7_0)
	local var_7_0 = arg_7_0:getSceneFolderPath()
	local var_7_1 = arg_7_0:getDefaultBackgroundPrefab()

	return ResUrl.getSeason123Scene(var_7_0, var_7_1)
end

function var_0_0.onLoadResCompleted(arg_8_0, arg_8_1)
	if not arg_8_0._loader then
		return
	end

	local var_8_0 = arg_8_1:getAssetItem(arg_8_0:getSceneBackgroundUrl())

	if var_8_0 then
		arg_8_0._sceneGo = gohelper.clone(var_8_0:GetResource(), arg_8_0._sceneRoot, "scene")
		arg_8_0._sceneRetailRoot = gohelper.findChild(arg_8_0._sceneGo, "root")
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_LOAD_RES_KEY)

	if arg_8_0._callback then
		if arg_8_0._callbackObj then
			arg_8_0._callback(arg_8_0._callbackObj, arg_8_0._sceneGo)
		else
			arg_8_0._callback(arg_8_0._sceneGo)
		end
	end
end

function var_0_0.showStageRes(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Season123EntryModel.instance.activityId
	local var_9_1 = Season123Config.instance:getStageCo(var_9_0, arg_9_1)

	if not var_9_1 then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0._containerDict) do
		gohelper.setActive(iter_9_1, iter_9_0 == arg_9_1)
	end

	if not arg_9_0._containerDict[arg_9_1] then
		arg_9_0:createPrefabInst(arg_9_1, var_9_1, arg_9_2)
	elseif arg_9_2 then
		arg_9_0:playAnim(arg_9_1, Activity123Enum.StageSceneAnim.Open)
	end
end

function var_0_0.hideAllStage(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._containerDict) do
		gohelper.setActive(iter_10_1, false)
	end
end

function var_0_0.showRetailRes(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = Season123EntryModel.getRandomRetailRes(arg_11_1)

	for iter_11_0, iter_11_1 in pairs(arg_11_0._retailContainerDict) do
		gohelper.setActive(iter_11_1, iter_11_0 == var_11_0)
	end

	if not arg_11_0._retailContainerDict[var_11_0] then
		arg_11_0:createRetailPrefabInst(arg_11_1)
	end
end

function var_0_0.hideAllRetail(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._retailContainerDict) do
		gohelper.setActive(iter_12_1, false)
	end
end

function var_0_0.createPrefabInst(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if string.nilorempty(arg_13_2.res) then
		return
	end

	local var_13_0 = UnityEngine.GameObject.New("stage_" .. tostring(arg_13_1))

	gohelper.addChild(arg_13_0._sceneRoot, var_13_0)

	arg_13_0._containerDict[arg_13_1] = var_13_0

	local var_13_1 = arg_13_2.initPos

	if not string.nilorempty(var_13_1) then
		local var_13_2 = string.splitToNumber(var_13_1, "#")

		transformhelper.setLocalPos(var_13_0.transform, var_13_2[1], var_13_2[2], 0)
	else
		transformhelper.setLocalPos(var_13_0.transform, 0, 0, 0)
	end

	local var_13_3 = arg_13_2.initScale

	if not string.nilorempty(var_13_3) then
		local var_13_4 = string.splitToNumber(var_13_3, "#")

		transformhelper.setLocalScale(var_13_0.transform, var_13_4[1], var_13_4[2], 1)
	else
		transformhelper.setLocalScale(var_13_0.transform, 1, 1, 1)
	end

	local var_13_5 = PrefabInstantiate.Create(var_13_0)

	arg_13_0._prefabDict[arg_13_1] = var_13_5
	arg_13_0.tempStage = arg_13_1
	arg_13_0.isOpen = arg_13_3

	var_13_5:startLoad(ResUrl.getSeason123Scene(arg_13_0:getSceneFolderPath(), arg_13_2.res), arg_13_0.loadCallback, arg_13_0)
end

function var_0_0.loadCallback(arg_14_0, arg_14_1)
	if arg_14_0.tempStage then
		local var_14_0 = arg_14_1:getInstGO()

		arg_14_0._animDict[arg_14_0.tempStage] = var_14_0:GetComponent(gohelper.Type_Animator)

		if arg_14_0.isOpen then
			arg_14_0:playAnim(arg_14_0.tempStage, Activity123Enum.StageSceneAnim.Open)

			arg_14_0.isOpen = nil
		end

		arg_14_0.tempStage = nil
	end
end

local var_0_1 = {
	"v1a7_s15_yisuoerde_a",
	"v1a7_s15_makusi_a",
	"v1a7_s15_kakaniya_a"
}

function var_0_0.createRetailPrefabInst(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = Season123EntryModel.getRandomRetailRes(arg_15_1)
	local var_15_2 = string.format("%s%s", Activity123Enum.SeasonResourcePrefix[Season123EntryModel.instance.activityId], var_15_1)
	local var_15_3 = UnityEngine.GameObject.New("retail_" .. tostring(var_15_0))

	gohelper.addChild(arg_15_0._sceneRetailRoot, var_15_3)
	transformhelper.setLocalPos(var_15_3.transform, 0, 0, 0)
	transformhelper.setLocalScale(var_15_3.transform, 1, 1, 1)

	local var_15_4 = PrefabInstantiate.Create(var_15_3)

	arg_15_0._retailContainerDict[var_15_0] = var_15_3
	arg_15_0._retailPrefabDict[var_15_0] = var_15_4

	var_15_4:startLoad(ResUrl.getSeason123RetailPrefab(arg_15_0:getSceneFolderPath(), var_15_2), arg_15_0.onLoadRetailCompleted, arg_15_0)
end

function var_0_0.onLoadRetailCompleted(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getIndexByRetailInst(arg_16_1)

	if var_16_0 then
		local var_16_1 = arg_16_1:getInstGO()

		if var_16_1 then
			local var_16_2 = var_16_1.transform:GetChild(0)

			if var_16_2 then
				local var_16_3, var_16_4 = transformhelper.getLocalPos(var_16_2)

				arg_16_0._retailPosXDict[var_16_0] = -var_16_3
				arg_16_0._retailPosYDict[var_16_0] = -var_16_4

				Season123EntryController.instance:dispatchEvent(Season123Event.RetailObjLoaded, var_16_0)
			end
		end
	end
end

function var_0_0.getIndexByRetailInst(arg_17_0, arg_17_1)
	if not arg_17_0._retailPrefabDict then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0._retailPrefabDict) do
		if iter_17_1 == arg_17_1 then
			return iter_17_0
		end
	end
end

function var_0_0.getRetailPosByIndex(arg_18_0, arg_18_1)
	return arg_18_0._retailPosXDict[arg_18_1], arg_18_0._retailPosYDict[arg_18_1]
end

function var_0_0.playAnim(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0._animDict[arg_19_1] then
		return
	end

	arg_19_0._animDict[arg_19_1]:Play(arg_19_2, 0, 0)
end

function var_0_0.tweenStage(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0._containerDict[arg_20_1] then
		logError("gameObject is empty:stage" .. arg_20_1)

		return
	end

	local var_20_0 = arg_20_0._containerDict[arg_20_1].transform
	local var_20_1 = Season123Config.instance:getStageCo(Season123EntryModel.instance.activityId, arg_20_1)
	local var_20_2
	local var_20_3

	if arg_20_2 then
		var_20_2 = var_20_1.finalPos
		var_20_3 = var_20_1.finalScale
	else
		var_20_2 = var_20_1.initPos
		var_20_3 = var_20_1.initScale
	end

	AudioMgr.instance:trigger(AudioEnum.UI.season123_map_scale)

	local var_20_4 = string.splitToNumber(var_20_2, "#")

	ZProj.TweenHelper.DOLocalMove(var_20_0, var_20_4[1], var_20_4[2], 0, 0.7)

	local var_20_5 = string.splitToNumber(var_20_3, "#")

	ZProj.TweenHelper.DOScale(var_20_0, var_20_5[1], var_20_5[2], 1, 0.7)
end

function var_0_0.getSceneFolderPath(arg_21_0)
	local var_21_0 = Season123EntryModel.instance.activityId or Season123Model.instance:getCurSeasonId()
	local var_21_1 = Activity123Enum.SeasonResourcePrefix[var_21_0]

	return (string.format("%s%s", var_21_1, Activity123Enum.SceneFolderPath))
end

function var_0_0.getDefaultBackgroundPrefab(arg_22_0)
	local var_22_0 = Season123EntryModel.instance.activityId or Season123Model.instance:getCurSeasonId()
	local var_22_1 = Activity123Enum.SeasonResourcePrefix[var_22_0]

	return (string.format("%s%s", var_22_1, Activity123Enum.DefaultBackgroundPrefab))
end

return var_0_0
