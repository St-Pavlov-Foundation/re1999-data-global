module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_PieceBase", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem_PieceBase", RougeSimpleItemBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)
end

function var_0_0.hideBlood(arg_3_0)
	gohelper.setActive(arg_3_0._image_Blood, false)
	gohelper.setActive(arg_3_0._image_Blood_hui, false)
end

function var_0_0.setGray_Blood(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood, not arg_4_1)
	gohelper.setActive(arg_4_0._image_Blood_hui, arg_4_1)
end

function var_0_0.resetRotate(arg_5_0)
	arg_5_0:localRotateZ(0)
end

function var_0_0.getPieceSprite(arg_6_0)
	return arg_6_0._imgCmpPiece.sprite
end

function var_0_0.index(arg_7_0)
	return arg_7_0:parent():index()
end

return var_0_0
