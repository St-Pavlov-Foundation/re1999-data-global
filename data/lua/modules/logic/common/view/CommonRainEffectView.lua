module("modules.logic.common.view.CommonRainEffectView", package.seeall)

local var_0_0 = class("CommonRainEffectView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._containerPath = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goglowcontainer = gohelper.findChild(arg_2_0.viewGO, arg_2_0._containerPath)

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	local var_5_0 = "ui/viewres/effect/ui_character_rain.prefab"

	arg_5_0._effectLoader = MultiAbLoader.New()

	arg_5_0._effectLoader:addPath(var_5_0)
	arg_5_0._effectLoader:startLoad(function(arg_6_0)
		local var_6_0 = arg_5_0._effectLoader:getAssetItem(var_5_0):GetResource(var_5_0)

		gohelper.clone(var_6_0, arg_5_0._goglowcontainer)
	end)
end

function var_0_0.onOpen(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._effectLoader then
		arg_10_0._effectLoader:dispose()

		arg_10_0._effectLoader = nil
	end
end

return var_0_0
