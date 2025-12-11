module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem_StartEnd_Impl", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)

	arg_2_0._image_Piece = gohelper.findChild(arg_2_0.viewGO, "#image_Piece1")
	arg_2_0._image_Blood1 = gohelper.findChild(arg_2_0.viewGO, "#image_Blood1")
	arg_2_0._image_Blood1_hui = gohelper.findChild(arg_2_0.viewGO, "#image_Blood1_hui")
	arg_2_0._image_Blood2 = gohelper.findChild(arg_2_0.viewGO, "#image_Blood2")
	arg_2_0._image_Blood2_hui = gohelper.findChild(arg_2_0.viewGO, "#image_Blood2_hui")
	arg_2_0._imgCmpPiece = arg_2_0._image_Piece:GetComponent(gohelper.Type_Image)

	arg_2_0:hideBlood()
end

function var_0_0.hideBlood(arg_3_0)
	gohelper.setActive(arg_3_0._image_Blood1, false)
	gohelper.setActive(arg_3_0._image_Blood1_hui, false)
	gohelper.setActive(arg_3_0._image_Blood2, false)
	gohelper.setActive(arg_3_0._image_Blood2_hui, false)
end

function var_0_0.setGray_Blood(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood1, not arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood1_hui, arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood2, not arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood2_hui, arg_4_1)
end

return var_0_0
