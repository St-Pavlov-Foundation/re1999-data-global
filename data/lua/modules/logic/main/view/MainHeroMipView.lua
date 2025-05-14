module("modules.logic.main.view.MainHeroMipView", package.seeall)

local var_0_0 = class("MainHeroMipView", BaseView)

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(MainController.instance, MainEvent.HeroShowInScene, arg_1_0._onHeroShowInScene, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_1_0._onOpenFullView, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, arg_1_0._onCloseFullView, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(MainController.instance, MainEvent.HeroShowInScene, arg_2_0._onHeroShowInScene, arg_2_0)
	arg_2_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, arg_2_0._onOpenFullView, arg_2_0)
	arg_2_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, arg_2_0._onCloseFullView, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._showInScene = true

	arg_3_0:_enableMip(true)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0:_enableMip(false)
end

function var_0_0._onHeroShowInScene(arg_5_0, arg_5_1)
	arg_5_0._showInScene = arg_5_1

	arg_5_0:_enableMip(true)
end

function var_0_0._onOpenFullView(arg_6_0, arg_6_1)
	arg_6_0:_enableMip(false)
end

function var_0_0._onCloseFullView(arg_7_0, arg_7_1)
	local var_7_0 = false
	local var_7_1 = ViewMgr.instance:getOpenViewNameList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if ViewMgr.instance:isFull(iter_7_1) then
			var_7_0 = true

			break
		end
	end

	if not var_7_0 then
		arg_7_0:_enableMip(true)
	end
end

function var_0_0._enableMip(arg_8_0, arg_8_1)
	if arg_8_1 then
		if not arg_8_0._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_HIGH_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		end

		if arg_8_0._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		end

		logNormal(arg_8_0._showInScene and "开启Mip" or "开启HighMip")
	else
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		logNormal("关闭所有Mip")
	end
end

return var_0_0
