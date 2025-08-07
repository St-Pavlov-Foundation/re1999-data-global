module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameWallItem", package.seeall)

local var_0_0 = class("AssassinStealthGameWallItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._goimg = gohelper.findChild(arg_2_0.go, "#go_img")

	arg_2_0:_checkShow()
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.initData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_1
	arg_5_0.go.name = arg_5_0.id
	arg_5_0.isHor = arg_5_2
end

function var_0_0.setMap(arg_6_0, arg_6_1)
	arg_6_0.mapId = arg_6_1

	arg_6_0:_checkShow()
end

function var_0_0._checkShow(arg_7_0)
	local var_7_0 = AssassinConfig.instance:isShowWall(arg_7_0.mapId, arg_7_0.id)

	if arg_7_0._isShow == var_7_0 then
		return
	end

	arg_7_0._isShow = var_7_0

	gohelper.setActive(arg_7_0._goimg, arg_7_0._isShow)
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
