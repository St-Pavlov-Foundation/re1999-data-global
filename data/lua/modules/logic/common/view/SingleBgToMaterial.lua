module("modules.logic.common.view.SingleBgToMaterial", package.seeall)

local var_0_0 = class("SingleBgToMaterial", LuaCompBase)

function var_0_0.loadMaterial(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.materialPath = string.format("ui/materials/dynamic/%s.mat", arg_1_2)
	arg_1_0.image = arg_1_1.gameObject:GetComponent(gohelper.Type_Image)

	if string.nilorempty(arg_1_0.materialPath) then
		logError("materialPath is not exit:" .. arg_1_0.materialPath)

		return
	end

	if not arg_1_1 then
		logError("image is nil:")

		return
	end

	arg_1_0.materialLoader = MultiAbLoader.New()

	arg_1_0.materialLoader:addPath(arg_1_0.materialPath)
	arg_1_0.materialLoader:startLoad(arg_1_0.buildMaterial, arg_1_0)
end

function var_0_0.buildMaterial(arg_2_0)
	arg_2_0.material = arg_2_0.materialLoader:getAssetItem(arg_2_0.materialPath):GetResource(arg_2_0.materialPath)
	arg_2_0.materialGO = UnityEngine.Object.Instantiate(arg_2_0.material)
	arg_2_0.image.material = arg_2_0.materialGO

	arg_2_0:loadFinish()
end

function var_0_0.dispose(arg_3_0)
	if arg_3_0.materialLoader then
		arg_3_0.materialLoader:dispose()
	end
end

function var_0_0.finishLoadCallBack(arg_4_0, arg_4_1)
	arg_4_0.callback = arg_4_1
end

function var_0_0.loadFinish(arg_5_0)
	if arg_5_0.callback then
		arg_5_0.callback(arg_5_0)
	end
end

return var_0_0
