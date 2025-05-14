module("modules.live2d.GuiModelAgentNew", package.seeall)

local var_0_0 = class("GuiModelAgentNew", LuaCompBase)
local var_0_1 = "live2d/custom/live2d_camera_2.prefab"

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_1._isStory = arg_1_1

	return var_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
end

function var_0_0._getSpine(arg_3_0)
	if not arg_3_0._spine then
		arg_3_0._spine = LightSpine.Create(arg_3_0._go, arg_3_0._isStory)
	end

	return arg_3_0._spine
end

function var_0_0._getLive2d(arg_4_0)
	if not arg_4_0._live2d then
		arg_4_0._live2d = GuiLive2d.Create(arg_4_0._go, arg_4_0._isStory)
	end

	arg_4_0._live2d:cancelCamera()

	return arg_4_0._live2d
end

function var_0_0.setSkinCfg(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0._curModel
	local var_5_1 = arg_5_0._isLive2D

	arg_5_0.loadedCb = arg_5_2
	arg_5_0.loadedCbObj = arg_5_3

	if string.nilorempty(arg_5_1.live2d) then
		arg_5_0._isLive2D = false
		arg_5_0._curModel = arg_5_0:_getSpine()

		gohelper.setActive(arg_5_0._curModel._spineGo, true)
		arg_5_0._curModel:setResPath(ResUrl.getLightSpine(arg_5_1.verticalDrawing), arg_5_0._loadResCb, arg_5_0)
	else
		arg_5_0._isLive2D = true
		arg_5_0._curModel = arg_5_0:_getLive2d()

		gohelper.setActive(arg_5_0._curModel._spineGo, true)
		arg_5_0._curModel:setResPath(ResUrl.getLightLive2d(arg_5_1.live2d), arg_5_0._loadResCb, arg_5_0)
	end

	if var_5_0 and arg_5_0._isLive2D ~= var_5_1 then
		gohelper.setActive(var_5_0._spineGo, false)
	end
end

function var_0_0.setResPath(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0._curModel
	local var_6_1 = arg_6_0._isLive2D

	arg_6_0.loadedCb = arg_6_3
	arg_6_0.loadedCbObj = arg_6_4

	if arg_6_2 then
		arg_6_0._isLive2D = true
		arg_6_0._curModel = arg_6_0:_getLive2d()

		gohelper.setActive(arg_6_0._curModel._spineGo, true)
		arg_6_0._curModel:setResPath(arg_6_1, arg_6_0._loadResCb, arg_6_0)
	else
		arg_6_0._isLive2D = false
		arg_6_0._curModel = arg_6_0:_getSpine()

		gohelper.setActive(arg_6_0._curModel._spineGo, true)
		arg_6_0._curModel:setResPath(arg_6_1, arg_6_0._loadResCb, arg_6_0)
	end

	if var_6_0 and arg_6_0._isLive2D ~= var_6_1 then
		gohelper.setActive(var_6_0._spineGo, false)
	end
end

function var_0_0.setVerticalDrawing(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = string.split(arg_7_1, "/")
	local var_7_1 = var_7_0 and var_7_0[#var_7_0]
	local var_7_2
	local var_7_3 = arg_7_0._curModel
	local var_7_4 = arg_7_0._isLive2D

	if var_7_1 then
		local var_7_5 = string.gsub(var_7_1, ".prefab", "")

		var_7_2 = SkinConfig.instance:getLive2dSkin(var_7_5)
	end

	arg_7_0.loadedCb = arg_7_2
	arg_7_0.loadedCbObj = arg_7_3

	if not var_7_2 then
		arg_7_0._isLive2D = false
		arg_7_0._curModel = arg_7_0:_getSpine()

		arg_7_0._curModel:showModel()
		arg_7_0._curModel:setResPath(arg_7_1, arg_7_0._loadResCb, arg_7_0)
	else
		arg_7_0._isLive2D = true
		arg_7_0._curModel = arg_7_0:_getLive2d()

		arg_7_0._curModel:showModel()
		arg_7_0._curModel:cancelCamera()
		arg_7_0._curModel:setResPath(ResUrl.getLightLive2d(var_7_2), arg_7_0._loadResCb, arg_7_0)
	end

	if arg_7_0._isLive2D ~= var_7_4 then
		var_7_3:hideModel()
	end
end

function var_0_0._loadResCb(arg_8_0)
	local var_8_0 = arg_8_0._curModel:getSpineGo()
	local var_8_1 = var_8_0
	local var_8_2
	local var_8_3

	if arg_8_0._isLive2D then
		var_8_1 = gohelper.findChild(var_8_0, "Drawables").transform:GetChild(0).gameObject
	end

	local var_8_4 = gohelper.findChild(var_8_1, "roleeffect_for_ui")

	if var_8_4 == nil then
		var_8_4 = gohelper.create2d(var_8_1, "roleeffect_for_ui")
	end

	gohelper.onceAddComponent(var_8_1, typeof(UrpCustom.PPEffectMask)).useLocalBloom = true

	gohelper.setActive(var_8_4, false)

	if arg_8_0._curModel.setLocalScale then
		arg_8_0._curModel:setLocalScale(1)
	else
		transformhelper.setLocalScale(var_8_0.transform, 1, 1, 1)
	end

	gohelper.onceAddComponent(var_8_4, typeof(ZProj.RoleEffectCtrl)).forUI = true

	gohelper.setActive(var_8_4, true)

	if arg_8_0.loadedCb then
		arg_8_0.loadedCb(arg_8_0.loadedCbObj)
	end
end

function var_0_0.setModelVisible(arg_9_0, arg_9_1)
	if not arg_9_0._curModel then
		return
	end

	gohelper.setActive(arg_9_0._go, arg_9_1)
end

function var_0_0.processModelEffect(arg_10_0)
	if arg_10_0:isLive2D() then
		arg_10_0._curModel:processModelEffect()
	end
end

function var_0_0.hideModelEffect(arg_11_0)
	if arg_11_0:isLive2D() then
		arg_11_0._curModel:hideModelEffect()
	end
end

function var_0_0.getSpineGo(arg_12_0)
	if arg_12_0._curModel then
		return arg_12_0._curModel:getSpineGo()
	end
end

function var_0_0.setSortingOrder(arg_13_0, arg_13_1)
	if arg_13_0._curModel and arg_13_0._curModel.setSortingOrder then
		return arg_13_0._curModel:setSortingOrder(arg_13_1)
	end
end

function var_0_0.setAlpha(arg_14_0, arg_14_1)
	if arg_14_0._curModel and arg_14_0:isLive2D() then
		arg_14_0._curModel:setAlpha(arg_14_1)
	end
end

function var_0_0.isLive2D(arg_15_0)
	return arg_15_0._isLive2D == true
end

function var_0_0.isSpine(arg_16_0)
	return arg_16_0._isLive2D ~= true
end

function var_0_0.getSpineVoice(arg_17_0)
	if arg_17_0._curModel then
		return arg_17_0._curModel:getSpineVoice()
	end
end

function var_0_0.isPlayingVoice(arg_18_0)
	if arg_18_0._curModel then
		return arg_18_0._curModel:isPlayingVoice()
	end
end

function var_0_0.playVoice(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	if arg_19_0._curModel then
		arg_19_0._curModel:playVoice(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	end
end

function var_0_0.stopVoice(arg_20_0)
	if arg_20_0._curModel then
		arg_20_0._curModel:stopVoice()
	end
end

function var_0_0.setSwitch(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0._curModel then
		arg_21_0._curModel:setSwitch(arg_21_1, arg_21_2)
	end
end

return var_0_0
