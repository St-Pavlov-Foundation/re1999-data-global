module("modules.logic.versionactivity2_5.liangyue.view.LiangYueMeshItem", package.seeall)

local var_0_0 = class("LiangYueMeshItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._rectTran = gohelper.findChildComponent(arg_1_0._go, "", gohelper.Type_RectTransform)
	arg_1_0._goEnableBg = gohelper.findChild(arg_1_1, "lattice")
	arg_1_0._imageEnableBg = gohelper.findChildImage(arg_1_1, "lattice")
end

function var_0_0.setActive(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._goEnableBg, arg_2_1)
end

function var_0_0.setBgColor(arg_3_0, arg_3_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_3_0._imageEnableBg, arg_3_1)
	ZProj.UGUIHelper.SetColorAlpha(arg_3_0._imageEnableBg, LiangYueEnum.MeshAlpha)
end

function var_0_0.setPos(arg_4_0, arg_4_1, arg_4_2)
	recthelper.setAnchor(arg_4_0._rectTran, arg_4_1, arg_4_2)
end

function var_0_0.onDestroy(arg_5_0)
	return
end

return var_0_0
