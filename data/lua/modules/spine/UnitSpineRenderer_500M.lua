module("modules.spine.UnitSpineRenderer_500M", package.seeall)

local var_0_0 = class("UnitSpineRenderer_500M", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.setSpine(arg_3_0, arg_3_1)
	if not arg_3_0.centerSpineRender then
		arg_3_0.centerSpineRender = MonoHelper.addLuaComOnceToGo(arg_3_1.centerSpine:getSpineGO(), UnitSpineRenderer, arg_3_0._entity)
	end

	arg_3_0.centerSpineRender:setSpine(arg_3_1.centerSpine)

	if not arg_3_0.frontSpineRender then
		arg_3_0.frontSpineRender = MonoHelper.addLuaComOnceToGo(arg_3_1.frontSpine:getSpineGO(), UnitSpineRenderer, arg_3_0._entity)
	end

	arg_3_0.frontSpineRender:setSpine(arg_3_1.frontSpine)

	if not arg_3_0.behindSpineRender then
		arg_3_0.behindSpineRender = MonoHelper.addLuaComOnceToGo(arg_3_1.behindSpine:getSpineGO(), UnitSpineRenderer, arg_3_0._entity)
	end

	arg_3_0.behindSpineRender:setSpine(arg_3_1.behindSpine)
end

function var_0_0.getReplaceMat(arg_4_0)
	if arg_4_0.centerSpineRender then
		return arg_4_0.centerSpineRender:getReplaceMat()
	end
end

function var_0_0.getCloneOriginMat(arg_5_0)
	if arg_5_0.centerSpineRender then
		return arg_5_0.centerSpineRender:getCloneOriginMat()
	end
end

function var_0_0.getSpineRenderMat(arg_6_0)
	if arg_6_0.centerSpineRender then
		return arg_6_0.centerSpineRender:getSpineRenderMat()
	end
end

function var_0_0._setReplaceMat(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.replaceSpineMat(arg_8_0, arg_8_1)
	if arg_8_0.centerSpineRender then
		arg_8_0.centerSpineRender:replaceSpineMat(arg_8_1)
	end
end

function var_0_0.resetSpineMat(arg_9_0)
	if arg_9_0.frontSpineRender then
		arg_9_0.frontSpineRender:resetSpineMat()
	end
end

function var_0_0.setAlpha(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:callFunc("setAlpha", arg_10_1, arg_10_2)
end

function var_0_0.setColor(arg_11_0, arg_11_1)
	arg_11_0:callFunc("setColor", arg_11_1)
end

function var_0_0._frameCallback(arg_12_0, arg_12_1)
	return
end

function var_0_0._finishCallback(arg_13_0)
	return
end

function var_0_0._stopAlphaTween(arg_14_0)
	return
end

function var_0_0._setRendererEnabled(arg_15_0, arg_15_1)
	return
end

function var_0_0.onDestroy(arg_16_0)
	return
end

function var_0_0.callFunc(arg_17_0, arg_17_1, ...)
	if arg_17_0.frontSpineRender then
		local var_17_0 = arg_17_0.frontSpineRender[arg_17_1]

		if var_17_0 then
			var_17_0(arg_17_0.frontSpineRender, ...)
		else
			logError("not found func int frontSpineRender : " .. tostring(arg_17_1))
		end
	end

	if arg_17_0.behindSpineRender then
		local var_17_1 = arg_17_0.behindSpineRender[arg_17_1]

		if var_17_1 then
			var_17_1(arg_17_0.behindSpineRender, ...)
		else
			logError("not found func int behindSpineRender : " .. tostring(arg_17_1))
		end
	end

	if arg_17_0.centerSpineRender then
		local var_17_2 = arg_17_0.centerSpineRender[arg_17_1]

		if var_17_2 then
			return var_17_2(arg_17_0.centerSpineRender, ...)
		else
			logError("not found func int centerSpineRender : " .. tostring(arg_17_1))
		end
	end
end

return var_0_0
