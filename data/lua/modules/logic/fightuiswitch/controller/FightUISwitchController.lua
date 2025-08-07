module("modules.logic.fightuiswitch.controller.FightUISwitchController", package.seeall)

local var_0_0 = class("FightUISwitchController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.openSceneView(arg_5_0, arg_5_1)
	local var_5_0 = FightUISwitchModel.instance:getStyleMoByItemId(arg_5_1)

	ViewMgr.instance:openView(ViewName.FightUISwitchSceneView, {
		mo = var_5_0
	})
end

function var_0_0.openEquipView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.FightUISwitchEquipView, {
		mo = arg_6_1
	})
end

function var_0_0._onLoadStyleRes(arg_7_0, arg_7_1)
	if string.nilorempty(arg_7_1) then
		return
	end

	if not arg_7_0._showResPath then
		arg_7_0._showResPath = {}
	end

	table.insert(arg_7_0._showResPath, arg_7_1)

	local var_7_0 = arg_7_0:_getResPath(arg_7_1)

	arg_7_0._loader = arg_7_0._loader or MultiAbLoader.New()

	arg_7_0._loader:addPath(var_7_0)
	arg_7_0._loader:startLoad(arg_7_0._onLoadedCallBack, arg_7_0)
end

function var_0_0._getResPath(arg_8_0, arg_8_1)
	return (string.format(FightUISwitchEnum.SceneRes, arg_8_1))
end

function var_0_0._onLoadedCallBack(arg_9_0, arg_9_1)
	if arg_9_0._showResPath then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._showResPath) do
			local var_9_0 = arg_9_0:_getResPath(iter_9_1)
			local var_9_1 = arg_9_1:getAssetItem(var_9_0)

			if var_9_1 then
				local var_9_2 = var_9_1:GetResource()

				arg_9_0._showResPrefab[iter_9_1] = var_9_2
			end
		end
	end

	arg_9_0:_finishLoadRes()
end

function var_0_0._finishLoadRes(arg_10_0)
	var_0_0.instance:dispatchEvent(FightUISwitchEvent.LoadFinish, arg_10_0._viewName)
end

function var_0_0.loadRes(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = FightUISwitchConfig.instance:getFightUIStyleCoById(arg_11_1)

	arg_11_0._viewName = arg_11_2

	if not arg_11_0._showResPrefab then
		arg_11_0._showResPrefab = {}
	end

	local var_11_1 = FightUISwitchModel.instance:getSceneRes(var_11_0, arg_11_2)

	if arg_11_0._showResPrefab[var_11_1] then
		arg_11_0:_finishLoadRes()

		return
	end

	arg_11_0:_onLoadStyleRes(var_11_1)
end

function var_0_0.getRes(arg_12_0, arg_12_1)
	return arg_12_0._showResPrefab[arg_12_1]
end

function var_0_0.dispose(arg_13_0)
	if arg_13_0._loader then
		arg_13_0._loader:dispose()

		arg_13_0._loader = nil
	end

	arg_13_0._showResPrefab = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
