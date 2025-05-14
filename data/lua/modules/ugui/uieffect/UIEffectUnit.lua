module("modules.ugui.uieffect.UIEffectUnit", package.seeall)

local var_0_0 = class("UIEffectUnit", LuaCompBase)
local var_0_1 = SLFramework.EffectPhotographerPool.Instance

function var_0_0.Refresh(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	if arg_1_0._rawImage == nil then
		local var_1_0 = gohelper.onceAddComponent(arg_1_1, gohelper.Type_RawImage)

		var_1_0.raycastTarget = false
		arg_1_0._rawImage = var_1_0
	end

	local var_1_1 = arg_1_1.transform

	recthelper.setSize(var_1_1, arg_1_5 or arg_1_3, arg_1_6 or arg_1_4)

	if arg_1_0._effectPath and arg_1_0._effectPath == arg_1_2 and arg_1_0._width == arg_1_3 and arg_1_0._height == arg_1_4 then
		return
	end

	arg_1_0:_releaseEffect()

	arg_1_0._effectPath = arg_1_2
	arg_1_0._width = arg_1_3
	arg_1_0._height = arg_1_4

	UIEffectManager.instance:_getEffect(arg_1_2, arg_1_3, arg_1_4, arg_1_0._rawImage)
end

function var_0_0.onDestroy(arg_2_0)
	arg_2_0:_releaseEffect()
end

function var_0_0._releaseEffect(arg_3_0)
	if arg_3_0._effectPath then
		UIEffectManager.instance:_putEffect(arg_3_0._effectPath, arg_3_0._width, arg_3_0._height)

		arg_3_0._effectPath = nil
	end
end

return var_0_0
