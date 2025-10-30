module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawCheckObj", package.seeall)

local var_0_0 = class("KaRongDrawCheckObj", KaRongDrawBaseObj)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._gochecked = gohelper.findChild(arg_1_0.go, "#go_checked")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.go, "#go_flag")
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	var_0_0.super.onInit(arg_2_0, arg_2_1)
	arg_2_0:setCheckIconVisible(false)
	gohelper.setActive(arg_2_0._goflag, arg_2_1.objType == KaRongDrawEnum.MazeObjType.End)
end

function var_0_0.onEnter(arg_3_0)
	var_0_0.super.onEnter(arg_3_0)
	arg_3_0:setCheckIconVisible(true)
end

function var_0_0.onExit(arg_4_0)
	var_0_0.super.onExit(arg_4_0)
	arg_4_0:setCheckIconVisible(false)
end

function var_0_0.setCheckIconVisible(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._gochecked, arg_5_1)
end

function var_0_0._setIcon(arg_6_0)
	local var_6_0 = arg_6_0:_getIconUrl()

	if not string.nilorempty(var_6_0) then
		if arg_6_0.mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint and not arg_6_0.isEnter then
			var_6_0 = var_6_0 .. "_gray"
		end

		UISpriteSetMgr.instance:setV3a0KaRongSprite(arg_6_0._image, var_6_0, true)
	end
end

return var_0_0
