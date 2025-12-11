module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Wall", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem_Wall", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._image_Piece = gohelper.findChild(arg_5_0.viewGO, "#image_Piece1")
	arg_5_0._imgCmpPiece = arg_5_0._image_Piece:GetComponent(gohelper.Type_Image)
end

function var_0_0.hideBlood(arg_6_0)
	return
end

function var_0_0.setGray_Blood(arg_7_0, arg_7_1)
	return
end

return var_0_0
