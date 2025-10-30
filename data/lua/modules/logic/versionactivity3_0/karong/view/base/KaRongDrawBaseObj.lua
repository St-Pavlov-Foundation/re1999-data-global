module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseObj", package.seeall)

local var_0_0 = class("KaRongDrawBaseObj", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0._image = gohelper.findChildImage(arg_1_0.go, "#image_content")
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0.mo = arg_2_1
	arg_2_0.isEnter = false

	gohelper.setActive(arg_2_0.go, true)
	arg_2_0:_setPosition()
	arg_2_0:_setIcon()
end

function var_0_0.onEnter(arg_3_0)
	arg_3_0.isEnter = true

	arg_3_0:_setIcon()
end

function var_0_0.onExit(arg_4_0)
	arg_4_0.isEnter = false

	arg_4_0:_setIcon()
end

function var_0_0._setPosition(arg_5_0)
	local var_5_0
	local var_5_1

	if arg_5_0.mo.positionType == KaRongDrawEnum.PositionType.Point then
		var_5_0, var_5_1 = KaRongDrawModel.instance:getObjectAnchor(arg_5_0.mo.x, arg_5_0.mo.y)
	else
		var_5_0, var_5_1 = KaRongDrawModel.instance:getLineObjectAnchor(arg_5_0.mo.x1, arg_5_0.mo.y1, arg_5_0.mo.x2, arg_5_0.mo.y2)
	end

	recthelper.setAnchor(arg_5_0.go.transform, var_5_0, var_5_1)
end

function var_0_0._setIcon(arg_6_0)
	local var_6_0 = arg_6_0:_getIconUrl()

	if not string.nilorempty(var_6_0) then
		UISpriteSetMgr.instance:setV3a0KaRongSprite(arg_6_0._image, var_6_0, true)
	end
end

function var_0_0._getIconUrl(arg_7_0)
	if arg_7_0.mo and arg_7_0.mo.iconUrl then
		return arg_7_0.mo.iconUrl
	end
end

function var_0_0.destroy(arg_8_0)
	gohelper.destroy(arg_8_0.go)

	arg_8_0.isEnter = false

	arg_8_0:__onDispose()
end

return var_0_0
