module("modules.ugui.uieffect.UIEffectLoader", package.seeall)

local var_0_0 = class("UIEffectLoader")

function var_0_0.ctor(arg_1_0)
	return
end

local var_0_1 = SLFramework.EffectPhotographerPool.Instance

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._effectPath = arg_2_1
	arg_2_0._width = arg_2_2
	arg_2_0._height = arg_2_3
	arg_2_0._photographer = var_0_1:Get(arg_2_2, arg_2_3)
	arg_2_0._refCount = 0
end

function var_0_0.startLoad(arg_3_0)
	if arg_3_0._loader then
		return
	end

	local var_3_0 = arg_3_0._effectPath
	local var_3_1 = MultiAbLoader.New()

	arg_3_0._loader = var_3_1

	var_3_1:addPath(var_3_0)

	local var_3_2 = "ui/materials/dynamic/ui_photo_additive.mat"

	var_3_1:addPath(var_3_2)
	var_3_1:startLoad(function(arg_4_0)
		if arg_3_0:CheckDispose() then
			return
		end

		local var_4_0 = var_3_1:getAssetItem(var_3_0):GetResource(var_3_0)
		local var_4_1 = gohelper.clone(var_4_0, nil, var_3_0)

		var_4_1:SetActive(false)
		SLFramework.GameObjectHelper.SetLayer(var_4_1, var_0_1.DefaultEffectLayer, true)
		var_4_1.transform:SetParent(arg_3_0._photographer.effectRootGo.transform, false)
		var_4_1:SetActive(true)

		arg_3_0._effectGo = var_4_1

		if arg_3_0._loadcallback ~= nil then
			arg_3_0._loadcallback(arg_3_0._callbackTarget)
		end

		local var_4_2 = var_3_1:getAssetItem(var_3_2):GetResource(var_3_2)

		arg_3_0._material = var_4_2

		for iter_4_0, iter_4_1 in ipairs(arg_3_0._rawImageList) do
			iter_4_1.material = var_4_2
		end
	end)
end

function var_0_0.GetPhotographer(arg_5_0)
	arg_5_0._refCount = arg_5_0._refCount + 1

	return arg_5_0._photographer
end

function var_0_0.getEffectGo(arg_6_0)
	return arg_6_0._effectGo
end

function var_0_0.getEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_1.texture = arg_7_0:GetPhotographer().renderTexture

	if arg_7_0._material then
		arg_7_1.material = arg_7_0._material

		return
	end

	arg_7_0._rawImageList = arg_7_0._rawImageList or {}

	table.insert(arg_7_0._rawImageList, arg_7_1)

	arg_7_0._loadcallback = arg_7_2
	arg_7_0._callbackTarget = arg_7_3

	arg_7_0:startLoad()
end

function var_0_0.ReduceRef(arg_8_0)
	arg_8_0._refCount = arg_8_0._refCount - 1

	arg_8_0:CheckDispose()
end

function var_0_0.CheckDispose(arg_9_0)
	if arg_9_0._refCount <= 0 then
		if not arg_9_0._loader then
			return true
		end

		arg_9_0._loader:dispose()

		arg_9_0._loader = nil
		arg_9_0._rawImageList = nil
		arg_9_0._material = nil

		var_0_1:Put(arg_9_0._photographer)

		arg_9_0._photographer = nil

		if arg_9_0._effectGo then
			gohelper.destroy(arg_9_0._effectGo)

			arg_9_0._effectGo = nil
		end

		UIEffectManager.instance:_delEffectLoader(arg_9_0._effectPath, arg_9_0._width, arg_9_0._height)

		return true
	end
end

return var_0_0
