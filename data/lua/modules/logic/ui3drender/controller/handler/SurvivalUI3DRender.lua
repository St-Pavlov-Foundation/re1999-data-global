module("modules.logic.ui3drender.controller.handler.SurvivalUI3DRender", package.seeall)

local var_0_0 = class("SurvivalUI3DRender", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.texW = arg_1_1
	arg_1_0.texH = arg_1_2
	arg_1_0.pos = arg_1_3
end

function var_0_0.init(arg_2_0)
	arg_2_0._rt = UnityEngine.RenderTexture.GetTemporary(arg_2_0.texW, arg_2_0.texH, 0, UnityEngine.RenderTextureFormat.ARGB32)
	arg_2_0._modelList = {}
	arg_2_0._hangeRoots = arg_2_0:getUserDataTb_()
	arg_2_0._loader = SequenceAbLoader.New()

	arg_2_0._loader:addPath("survival/common/survivalcamera.prefab")
	arg_2_0._loader:startLoad(arg_2_0._onResLoad, arg_2_0)
	arg_2_0:initCamera()
end

function var_0_0.dispose(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._modelList) do
		gohelper.destroy(iter_3_1)
	end

	arg_3_0._modelList = {}

	if arg_3_0._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_3_0._rt)

		arg_3_0._rt = nil
	end

	if arg_3_0._loader then
		arg_3_0._loader:dispose()

		arg_3_0._loader = nil
	end

	if arg_3_0._cameraObj then
		gohelper.destroy(arg_3_0._cameraObj)

		arg_3_0._cameraObj = nil
	end

	arg_3_0:__onDispose()
end

function var_0_0.getRenderTexture(arg_4_0)
	return arg_4_0._rt
end

function var_0_0._onResLoad(arg_5_0)
	local var_5_0 = arg_5_0._loader:getFirstAssetItem():GetResource()

	arg_5_0._cameraObj = gohelper.clone(var_5_0)

	local var_5_1 = arg_5_0._cameraObj.transform

	transformhelper.setLocalPos(var_5_1, arg_5_0.pos[1], arg_5_0.pos[2], arg_5_0.pos[3])

	local var_5_2 = arg_5_0._cameraObj:GetComponentInChildren(typeof(UnityEngine.Camera))

	var_5_2.targetTexture = arg_5_0._rt

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Survival then
		var_5_2.farClipPlane = 1
		var_5_2.nearClipPlane = 0.05

		transformhelper.setLocalScale(var_5_1, 0.16, 0.16, 0.16)
	end

	arg_5_0:setHangRoot(var_5_1)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._modelList) do
		if arg_5_0._hangeRoots[iter_5_0] then
			iter_5_1.transform:SetParent(arg_5_0._hangeRoots[iter_5_0], false)
		end
	end
end

function var_0_0.setHangRoot(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0 = 0, arg_6_1.childCount - 1 do
		local var_6_0 = arg_6_1:GetChild(iter_6_0)
		local var_6_1 = var_6_0.name

		if arg_6_2 then
			var_6_1 = arg_6_2 .. var_6_1
		end

		arg_6_0._hangeRoots[var_6_1] = var_6_0

		arg_6_0:setHangRoot(var_6_0, var_6_1 .. "/")
	end
end

function var_0_0.addModel(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._modelList[arg_7_1] or UnityEngine.GameObject.New()
	local var_7_1 = PrefabInstantiate.Create(var_7_0)

	if var_7_1:getPath() ~= arg_7_2 then
		if arg_7_0._loaderEndCallBack and arg_7_0._loaderEndCallBack[var_7_1] then
			arg_7_0._loaderEndCallBack[var_7_1] = nil
		end

		if arg_7_0._curAnims then
			arg_7_0._curAnims[arg_7_1] = nil
		end

		var_7_1:dispose()

		if not string.nilorempty(arg_7_2) then
			var_7_1:startLoad(arg_7_2, arg_7_0._onModelLoaded, arg_7_0)
		end
	end

	arg_7_0._modelList[arg_7_1] = var_7_0

	if arg_7_0._hangeRoots[arg_7_1] then
		var_7_0.transform:SetParent(arg_7_0._hangeRoots[arg_7_1], false)
	end

	return var_7_0
end

function var_0_0.playAnim(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._modelList[arg_8_1]

	if not var_8_0 then
		return
	end

	arg_8_0._curAnims = arg_8_0._curAnims or {}

	if arg_8_0._curAnims[arg_8_1] == arg_8_2 then
		return
	end

	arg_8_0._curAnims[arg_8_1] = arg_8_2

	local var_8_1 = PrefabInstantiate.Create(var_8_0)
	local var_8_2 = var_8_1:getInstGO()

	if not var_8_2 then
		table.insert(arg_8_0:getEndCallback(var_8_1), {
			arg_8_0.playAnim,
			arg_8_0,
			arg_8_1,
			arg_8_2
		})
	else
		local var_8_3 = gohelper.findChildAnim(var_8_2, "")

		if var_8_3 and var_8_3.isActiveAndEnabled then
			var_8_3:Play(arg_8_2, 0, 0)
		end
	end
end

function var_0_0.getEndCallback(arg_9_0, arg_9_1)
	arg_9_0._loaderEndCallBack = arg_9_0._loaderEndCallBack or {}
	arg_9_0._loaderEndCallBack[arg_9_1] = arg_9_0._loaderEndCallBack[arg_9_1] or {}

	return arg_9_0._loaderEndCallBack[arg_9_1]
end

function var_0_0.setModelPathActive(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0._modelList[arg_10_1]

	if not var_10_0 then
		return
	end

	local var_10_1 = PrefabInstantiate.Create(var_10_0)
	local var_10_2 = var_10_1:getInstGO()

	if not var_10_2 then
		table.insert(arg_10_0:getEndCallback(var_10_1), {
			arg_10_0.setModelPathActive,
			arg_10_0,
			arg_10_1,
			arg_10_2,
			arg_10_3
		})
	else
		local var_10_3 = gohelper.findChild(var_10_2, arg_10_2)

		gohelper.setActive(var_10_3, arg_10_3)
	end
end

function var_0_0._onModelLoaded(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._loaderEndCallBack and arg_11_0._loaderEndCallBack[arg_11_1]

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			iter_11_1[1](iter_11_1[2], unpack(iter_11_1, 3))
		end

		arg_11_0._loaderEndCallBack[arg_11_1] = nil
	end
end

function var_0_0.onDestroy(arg_12_0)
	return
end

local var_0_1 = {
	"node1/role",
	"node2/role",
	"node6/role"
}

function var_0_0.initCamera(arg_13_0)
	local var_13_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)

	arg_13_0._allResGo = arg_13_0:getUserDataTb_()

	for iter_13_0, iter_13_1 in ipairs(var_0_1) do
		arg_13_0._allResGo[iter_13_1] = arg_13_0:addModel(iter_13_1, var_13_0)
	end

	arg_13_0:hideOtherModel()
end

function var_0_0.setSurvival3DModelMO(arg_14_0, arg_14_1)
	arg_14_0._curHeroPath = arg_14_1.curHeroPath
	arg_14_0._curUnitPath = arg_14_1.curUnitPath
	arg_14_0.unitPath = arg_14_1.unitPath

	if arg_14_0._curUnitPath then
		arg_14_0._allResGo[arg_14_0._curUnitPath] = arg_14_0:addModel(arg_14_0._curUnitPath, arg_14_0.unitPath)
	end

	if arg_14_1.isHandleHeroPath and arg_14_0._curHeroPath then
		arg_14_0:setModelPathActive(arg_14_0._curHeroPath, "#go_effect", arg_14_1.isSearch)
		arg_14_0:playAnim(arg_14_0._curHeroPath, arg_14_1.isSearch and "search" or "idle")
	end

	arg_14_0:hideOtherModel()
end

function var_0_0.hideOtherModel(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._allResGo) do
		gohelper.setActive(iter_15_1, iter_15_0 == arg_15_0._curHeroPath or iter_15_0 == arg_15_0._curUnitPath)
	end
end

local var_0_2 = {
	[0] = "idle",
	"jump",
	"jump2",
	"down_idle"
}

function var_0_0.playNextAnim(arg_16_0, arg_16_1)
	if arg_16_0._curHeroPath then
		if var_0_2[arg_16_1] then
			arg_16_0:playAnim(arg_16_0._curHeroPath, var_0_2[arg_16_1])
		else
			logError("未处理角色动作类型" .. tostring(arg_16_1))
		end
	end
end

return var_0_0
