module("modules.logic.survival.view.map.comp.Survival3DModelComp", package.seeall)

local var_0_0 = class("Survival3DModelComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}
	arg_1_0.width = arg_1_1.width
	arg_1_0.height = arg_1_1.height
	arg_1_0.xOffset = arg_1_1.xOffset or 5000
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._image = arg_2_1:GetComponent(gohelper.Type_RawImage)

	local var_2_0 = arg_2_0.width or recthelper.getWidth(arg_2_0._image.transform)
	local var_2_1 = arg_2_0.height or recthelper.getHeight(arg_2_0._image.transform)

	arg_2_0._rt = UnityEngine.RenderTexture.GetTemporary(var_2_0, var_2_1, 0, UnityEngine.RenderTextureFormat.ARGB32)
	arg_2_0._image.texture = arg_2_0._rt
	arg_2_0._modelList = {}
	arg_2_0._hangeRoots = arg_2_0:getUserDataTb_()
	arg_2_0._loader = SequenceAbLoader.New()

	arg_2_0._loader:addPath("survival/common/survivalcamera.prefab")
	arg_2_0._loader:startLoad(arg_2_0._onResLoad, arg_2_0)
end

function var_0_0._onResLoad(arg_3_0)
	local var_3_0 = arg_3_0._loader:getFirstAssetItem():GetResource()

	arg_3_0._cameraObj = gohelper.clone(var_3_0)

	local var_3_1 = arg_3_0._cameraObj.transform

	transformhelper.setLocalPos(var_3_1, arg_3_0.xOffset, 0, 10000)

	arg_3_0._cameraObj:GetComponentInChildren(typeof(UnityEngine.Camera)).targetTexture = arg_3_0._rt

	arg_3_0:setHangRoot(var_3_1)

	for iter_3_0, iter_3_1 in pairs(arg_3_0._modelList) do
		if arg_3_0._hangeRoots[iter_3_0] then
			iter_3_1.transform:SetParent(arg_3_0._hangeRoots[iter_3_0], false)
		end
	end
end

function var_0_0.setHangRoot(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0 = 0, arg_4_1.childCount - 1 do
		local var_4_0 = arg_4_1:GetChild(iter_4_0)
		local var_4_1 = var_4_0.name

		if arg_4_2 then
			var_4_1 = arg_4_2 .. var_4_1
		end

		arg_4_0._hangeRoots[var_4_1] = var_4_0

		arg_4_0:setHangRoot(var_4_0, var_4_1 .. "/")
	end
end

function var_0_0.addModel(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._modelList[arg_5_1] or UnityEngine.GameObject.New()
	local var_5_1 = PrefabInstantiate.Create(var_5_0)

	if var_5_1:getPath() ~= arg_5_2 then
		if arg_5_0._loaderEndCallBack and arg_5_0._loaderEndCallBack[var_5_1] then
			arg_5_0._loaderEndCallBack[var_5_1] = nil
		end

		if arg_5_0._curAnims then
			arg_5_0._curAnims[arg_5_1] = nil
		end

		var_5_1:dispose()
		var_5_1:startLoad(arg_5_2, arg_5_0._onModelLoaded, arg_5_0)
	end

	arg_5_0._modelList[arg_5_1] = var_5_0

	if arg_5_0._hangeRoots[arg_5_1] then
		var_5_0.transform:SetParent(arg_5_0._hangeRoots[arg_5_1], false)
	end

	return var_5_0
end

function var_0_0.playAnim(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._modelList[arg_6_1]

	if not var_6_0 then
		return
	end

	arg_6_0._curAnims = arg_6_0._curAnims or {}

	if arg_6_0._curAnims[arg_6_1] == arg_6_2 then
		return
	end

	arg_6_0._curAnims[arg_6_1] = arg_6_2

	local var_6_1 = PrefabInstantiate.Create(var_6_0)
	local var_6_2 = var_6_1:getInstGO()

	if not var_6_2 then
		table.insert(arg_6_0:getEndCallback(var_6_1), {
			arg_6_0.playAnim,
			arg_6_0,
			arg_6_1,
			arg_6_2
		})
	else
		local var_6_3 = gohelper.findChildAnim(var_6_2, "")

		if var_6_3 and var_6_3.isActiveAndEnabled then
			var_6_3:Play(arg_6_2, 0, 0)
		end
	end
end

function var_0_0.getEndCallback(arg_7_0, arg_7_1)
	arg_7_0._loaderEndCallBack = arg_7_0._loaderEndCallBack or {}
	arg_7_0._loaderEndCallBack[arg_7_1] = arg_7_0._loaderEndCallBack[arg_7_1] or {}

	return arg_7_0._loaderEndCallBack[arg_7_1]
end

function var_0_0.setModelPathActive(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0._modelList[arg_8_1]

	if not var_8_0 then
		return
	end

	local var_8_1 = PrefabInstantiate.Create(var_8_0)
	local var_8_2 = var_8_1:getInstGO()

	if not var_8_2 then
		table.insert(arg_8_0:getEndCallback(var_8_1), {
			arg_8_0.setModelPathActive,
			arg_8_0,
			arg_8_1,
			arg_8_2,
			arg_8_3
		})
	else
		local var_8_3 = gohelper.findChild(var_8_2, arg_8_2)

		gohelper.setActive(var_8_3, arg_8_3)
	end
end

function var_0_0._onModelLoaded(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._loaderEndCallBack and arg_9_0._loaderEndCallBack[arg_9_1]

	if var_9_0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			iter_9_1[1](iter_9_1[2], unpack(iter_9_1, 3))
		end

		arg_9_0._loaderEndCallBack[arg_9_1] = nil
	end
end

function var_0_0.onDestroy(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._modelList) do
		gohelper.destroy(iter_10_1)
	end

	arg_10_0._modelList = {}

	if arg_10_0._rt then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_10_0._rt)

		arg_10_0._rt = nil
	end

	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end

	if arg_10_0._cameraObj then
		gohelper.destroy(arg_10_0._cameraObj)

		arg_10_0._cameraObj = nil
	end
end

return var_0_0
