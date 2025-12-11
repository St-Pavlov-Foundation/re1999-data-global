module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Portal", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem_Portal", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

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

local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)

	arg_4_0._isConnected = false
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._image_Piece1 = gohelper.findChild(arg_5_0.viewGO, "#image_Piece1")
	arg_5_0._image_Piece2 = gohelper.findChild(arg_5_0.viewGO, "#image_Piece2")
	arg_5_0._image_Blood = gohelper.findChild(arg_5_0.viewGO, "#image_Blood")
	arg_5_0._image_Blood_hui = gohelper.findChild(arg_5_0.viewGO, "#image_Blood_hui")
	arg_5_0._imgCmpPiece1 = arg_5_0._image_Piece1:GetComponent(gohelper.Type_Image)
	arg_5_0._imgCmpPiece2 = arg_5_0._image_Piece2:GetComponent(gohelper.Type_Image)
	arg_5_0._image_Piece1 = gohelper.findChild(arg_5_0.viewGO, "#image_Piece1")
	arg_5_0._animatorPlayer = var_0_1.Get(arg_5_0.viewGO)

	arg_5_0:hideBlood()
end

function var_0_0.getPieceSprite(arg_6_0)
	return arg_6_0._isConnected and arg_6_0._imgCmpPiece2.sprite or arg_6_0._imgCmpPiece1.sprite
end

function var_0_0.setIsConnected(arg_7_0, arg_7_1)
	if not arg_7_1 then
		arg_7_0:setIsConnectedNoAnim(false)
		arg_7_0:hideBlood()

		return
	end

	if arg_7_0._isConnected == arg_7_1 then
		return
	end

	arg_7_0._isConnected = arg_7_1

	arg_7_0:_playAnim_switch(arg_7_0._onAnimSwitchDone, arg_7_0)

	if arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum3_1.GaoSiNiao.play_ui_mingdi_gsn_send)
	end
end

function var_0_0._onAnimSwitchDone(arg_8_0)
	arg_8_0:_playAnim_Idle(arg_8_0._isConnected)

	if arg_8_0._isConnected then
		arg_8_0:setGray_Blood(true)
	end
end

function var_0_0.setIsConnectedNoAnim(arg_9_0, arg_9_1)
	if arg_9_0._isConnected == arg_9_1 then
		return
	end

	arg_9_0._isConnected = arg_9_1

	arg_9_0:_playAnim_Idle(arg_9_1)
end

function var_0_0.rotateByZoneMask(arg_10_0, arg_10_1)
	local var_10_0 = 0

	if GaoSiNiaoEnum.ZoneMask.North == arg_10_1 then
		var_10_0 = 0
	elseif GaoSiNiaoEnum.ZoneMask.South == arg_10_1 then
		var_10_0 = 180
	elseif GaoSiNiaoEnum.ZoneMask.West == arg_10_1 then
		var_10_0 = 90
	elseif GaoSiNiaoEnum.ZoneMask.East == arg_10_1 then
		var_10_0 = -90
	end

	arg_10_0:localRotateZ(var_10_0)
	arg_10_0:localRotateZ(var_10_0)
end

function var_0_0._playAnim(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._animatorPlayer:Play(arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0._playAnim_Idle(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:_playAnim(arg_12_1 and "piece2" or "piece1", arg_12_2, arg_12_3)
end

function var_0_0._playAnim_switch(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_playAnim(UIAnimationName.Switch, arg_13_1, arg_13_2)
end

return var_0_0
