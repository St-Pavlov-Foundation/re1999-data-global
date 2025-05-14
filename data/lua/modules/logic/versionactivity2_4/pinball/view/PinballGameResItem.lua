module("modules.logic.versionactivity2_4.pinball.view.PinballGameResItem", package.seeall)

local var_0_0 = class("PinballGameResItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "#txt_num")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "#image_icon")
	arg_1_0._imageiconbg = gohelper.findChildImage(arg_1_1, "#image_iconbg")
	arg_1_0._imageball = gohelper.findChildImage(arg_1_1, "#image_ball")
	arg_1_0._anim = gohelper.findChildAnim(arg_1_1, "")
end

function var_0_0.addEventListeners(arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.GameResChange, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, arg_3_0._refreshUI, arg_3_0)
end

local var_0_1 = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_resourcebg_1",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_resourcebg_3",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_resourcebg_2",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_resourcebg_4"
}
local var_0_2 = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_smallball_3",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_smallball_1",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_smallball_4",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_smallball_2"
}

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0._resType = arg_4_1

	arg_4_0:_refreshUI()

	local var_4_0 = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][arg_4_0._resType]

	if not var_4_0 then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(arg_4_0._imageicon, var_4_0.icon)
	UISpriteSetMgr.instance:setAct178Sprite(arg_4_0._imageiconbg, var_0_1[arg_4_0._resType])
	UISpriteSetMgr.instance:setAct178Sprite(arg_4_0._imageball, var_0_2[arg_4_0._resType])
end

function var_0_0._refreshUI(arg_5_0)
	local var_5_0 = PinballModel.instance:getGameRes(arg_5_0._resType)

	if arg_5_0._cacheNum and var_5_0 > arg_5_0._cacheNum and (not arg_5_0._playAnimDt or UnityEngine.Time.realtimeSinceStartup - arg_5_0._playAnimDt > 2) then
		arg_5_0._anim:Play("refresh", 0, 0)

		arg_5_0._playAnimDt = UnityEngine.Time.realtimeSinceStartup
	end

	arg_5_0._cacheNum = var_5_0
	arg_5_0._txtNum.text = var_5_0
end

return var_0_0
