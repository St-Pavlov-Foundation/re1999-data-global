module("modules.logic.clickuiswitch.controller.ClickUISwitchController", package.seeall)

local var_0_0 = class("ClickUISwitchController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_3_0._onGetInfoFinish, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0._onGetInfoFinish(arg_5_0)
	ClickUISwitchModel.instance:initClickUI()
end

function var_0_0.openClickUISwitchInfoView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	ViewMgr.instance:openView(ViewName.ClickUISwitchInfoView, {
		SkinId = arg_6_1,
		noInfoEffect = arg_6_2,
		isPreview = arg_6_3
	})
end

function var_0_0.setCurClickUIStyle(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = lua_scene_click.configDict[arg_7_1]

	if not var_7_0 then
		return
	end

	local var_7_1

	var_7_1 = var_7_0.defaultUnlock == 1 and 0 or var_7_0.itemId

	ClickUISwitchModel.instance:setCurUseUI(arg_7_1)
	GameGlobalMgr.instance:refreshTouchEffectSkin()

	local var_7_2 = PlayerEnum.SimpleProperty.ClickUISkin

	PlayerModel.instance:forceSetSimpleProperty(var_7_2, tostring(arg_7_1))
	PlayerRpc.instance:sendSetSimplePropertyRequest(var_7_2, tostring(arg_7_1))
	var_0_0.instance:dispatchEvent(ClickUISwitchEvent.UseClickUI, arg_7_1)
	arg_7_2(arg_7_3)
end

function var_0_0.hasReddot(arg_8_0)
	return false
end

function var_0_0.closeReddot(arg_9_0)
	return
end

function var_0_0.getClickUIPrefab(arg_10_0, arg_10_1)
	if not arg_10_0._clickUIPrefab then
		arg_10_0._clickUIPrefab = {}
	end

	if not arg_10_0._clickUIPrefab[arg_10_1] then
		arg_10_0:_loadClickUIPrefab(arg_10_1)

		return
	end

	return arg_10_0._clickUIPrefab[arg_10_1]
end

function var_0_0._loadClickUIPrefab(arg_11_0, arg_11_1)
	arg_11_0._loadClickUIName = arg_11_1

	if arg_11_0._loader then
		arg_11_0._loader:dispose()
	end

	arg_11_0._loader = MultiAbLoader.New()

	local var_11_0 = string.format(ClickUISwitchEnum.ClickUIPath, arg_11_1)

	arg_11_0._loader:addPath(var_11_0)
	arg_11_0._loader:startLoad(arg_11_0._loadCallback, arg_11_0)
end

function var_0_0._loadCallback(arg_12_0)
	local var_12_0 = string.format(ClickUISwitchEnum.ClickUIPath, arg_12_0._loadClickUIName)
	local var_12_1 = arg_12_0._loader:getAssetItem(var_12_0):GetResource(var_12_0)

	arg_12_0._clickUIPrefab[arg_12_0._loadClickUIName] = var_12_1

	var_0_0.instance:dispatchEvent(ClickUISwitchEvent.LoadUIPrefabs)
end

var_0_0.instance = var_0_0.New()

return var_0_0
