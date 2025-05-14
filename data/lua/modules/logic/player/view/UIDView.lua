module("modules.logic.player.view.UIDView", package.seeall)

local var_0_0 = class("UIDView", UserDataDispose)
local var_0_1 = 1.7777777777777777
local var_0_2 = 2.25 - var_0_1
local var_0_3 = 56
local var_0_4 = 135

function var_0_0.getInstance()
	if not var_0_0.instance then
		var_0_0.instance = var_0_0.New()

		var_0_0.instance:__onInit()
	end

	return var_0_0.instance
end

function var_0_0.hidePlayerId(arg_2_0)
	if arg_2_0._txtId then
		arg_2_0._txtId.text = ""
	end
end

function var_0_0.showPlayerId(arg_3_0)
	if not arg_3_0._txtId then
		arg_3_0:loadPrefab()

		return
	end

	arg_3_0._txtId.text = "ID : " .. PlayerModel.instance:getMyUserId()
end

function var_0_0.loadPrefab(arg_4_0)
	if arg_4_0.loader then
		return
	end

	local var_4_0 = "ui/viewres/common/uid.prefab"
	local var_4_1 = gohelper.find("IDCanvas/POPUP")

	arg_4_0.loader = PrefabInstantiate.Create(var_4_1)

	arg_4_0.loader:startLoad(var_4_0, arg_4_0.loadedCallback, arg_4_0)
end

function var_0_0.loadedCallback(arg_5_0)
	arg_5_0.tr = arg_5_0.loader:getInstGO().transform
	arg_5_0._txtId = gohelper.findChildText(arg_5_0.loader:getInstGO(), "#txt_id")

	arg_5_0:showPlayerId()
	arg_5_0:setAnchorPos()
	arg_5_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_5_0.setAnchorPos, arg_5_0)
end

function var_0_0.setAnchorPos(arg_6_0)
	local var_6_0, var_6_1 = GameGlobalMgr.instance:getScreenState():getScreenSize()
	local var_6_2 = (var_6_0 / var_6_1 - var_0_1) / var_0_2
	local var_6_3 = Mathf.Lerp(var_0_3, var_0_4, var_6_2)

	recthelper.setAnchorX(arg_6_0.tr, var_6_3)
end

return var_0_0
