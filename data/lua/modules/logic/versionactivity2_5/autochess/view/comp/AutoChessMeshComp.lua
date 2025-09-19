module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessMeshComp", package.seeall)

local var_0_0 = class("AutoChessMeshComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.uiMesh = gohelper.findChildUIMesh(arg_1_1, "")
	arg_1_0.simageRole = gohelper.findChildSingleImage(arg_1_1, "role")
	arg_1_0.imageRole = gohelper.findChildImage(arg_1_1, "role")
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.simageRole:LoadImage(ResUrl.getAutoChessIcon(arg_2_1), arg_2_0.loadImageCallback, arg_2_0)

	arg_2_0.materialUrl = AutoChessHelper.getMaterialUrl(arg_2_2, arg_2_3)
	arg_2_0.meshUrl = AutoChessHelper.getMeshUrl(arg_2_1)

	arg_2_0:loadMesh()
end

function var_0_0.loadImageCallback(arg_3_0)
	if arg_3_0.imageRole then
		arg_3_0.imageRole:SetNativeSize()
	end
end

function var_0_0.loadMesh(arg_4_0)
	if arg_4_0.loader then
		arg_4_0.loader:dispose()

		arg_4_0.loader = nil
	end

	arg_4_0.loader = MultiAbLoader.New()

	arg_4_0.loader:addPath(arg_4_0.materialUrl)
	arg_4_0.loader:addPath(arg_4_0.meshUrl)
	arg_4_0.loader:startLoad(arg_4_0.loadResFinish, arg_4_0)
end

function var_0_0.loadResFinish(arg_5_0)
	local var_5_0 = arg_5_0.loader:getAssetItem(arg_5_0.meshUrl)

	if var_5_0 then
		local var_5_1 = var_5_0:GetResource(arg_5_0.meshUrl)

		arg_5_0.uiMesh.mesh = var_5_1

		arg_5_0.uiMesh:SetVerticesDirty()
	end

	local var_5_2 = arg_5_0.loader:getAssetItem(arg_5_0.materialUrl)

	if var_5_2 then
		local var_5_3 = var_5_2:GetResource(arg_5_0.materialUrl)

		arg_5_0.uiMesh.material = var_5_3

		arg_5_0.uiMesh:SetMaterialDirty()
	end

	gohelper.setActive(arg_5_0.uiMesh, true)
end

function var_0_0.onDestroy(arg_6_0)
	if arg_6_0.loader then
		arg_6_0.loader:dispose()

		arg_6_0.loader = nil
	end
end

return var_0_0
