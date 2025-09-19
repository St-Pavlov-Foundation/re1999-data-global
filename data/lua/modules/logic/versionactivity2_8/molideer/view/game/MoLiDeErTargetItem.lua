module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTargetItem", package.seeall)

local var_0_0 = class("MoLiDeErTargetItem", MoLiDeErTargetResultItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "#txt_Target")
	arg_1_0._txtState1 = gohelper.findChildText(arg_1_0.viewGO, "#txt_Target/State1/#txt_State1")
	arg_1_0._goState1 = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/State1")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/State1/image_Line")
	arg_1_0._imageActionIcon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_Target/State1/#txt_State1/#image_ActionIcon")
	arg_1_0._txtState2 = gohelper.findChildText(arg_1_0.viewGO, "#txt_Target/State2/#txt_State2")
	arg_1_0._goState2 = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/State2")
	arg_1_0._imageActionIcon2 = gohelper.findChildImage(arg_1_0.viewGO, "#txt_Target/State2/#txt_State2/#image_ActionIcon")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_Target/#img_Icon")
	arg_1_0._sliderProgress = gohelper.findChildSlider(arg_1_0.viewGO, "#txt_Target/Slider")
	arg_1_0._goIconFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#img_Icon/#Star_ani")
	arg_1_0._goTitleFx = gohelper.findChild(arg_1_0.viewGO, "#txt_Target/#saoguang")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._sliderAnimator = gohelper.findChildComponent(arg_2_0._sliderProgress.gameObject, "", gohelper.Type_Animator)
	arg_2_0._goStateFxRed1 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_red")
	arg_2_0._goStateFxGreen1 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_green")
	arg_2_0._goStateFxYellow1 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State1/#txt_State1/#saoguang_yellow")
	arg_2_0._goStateFxRed2 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_red")
	arg_2_0._goStateFxGreen2 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_green")
	arg_2_0._goStateFxYellow2 = gohelper.findChild(arg_2_0.viewGO, "#txt_Target/State2/#txt_State2/#saoguang_yellow")
	arg_2_0._stateFx1 = {
		arg_2_0._goStateFxGreen1,
		arg_2_0._goStateFxYellow1,
		arg_2_0._goStateFxRed1
	}
	arg_2_0._stateFx2 = {
		arg_2_0._goStateFxGreen2,
		arg_2_0._goStateFxYellow2,
		arg_2_0._goStateFxRed2
	}
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.getFxTargetTran(arg_5_0)
	return arg_5_0._sliderProgress.transform
end

function var_0_0.refreshState(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_2.leftRoundEnergy
	local var_6_1 = arg_6_2.currentRound
	local var_6_2 = arg_6_2:getTargetProgress(arg_6_1)

	arg_6_0._sliderProgress:SetValue(var_6_2 * 0.01)

	local var_6_3 = MoLiDeErHelper.getTargetState(var_6_2)
	local var_6_4 = MoLiDeErConfig.instance:getProgressDescConfigById(arg_6_2.gameId, arg_6_1)
	local var_6_5, var_6_6 = MoLiDeErHelper.getRangeDesc(var_6_0, var_6_4.energyRange, var_6_4.energyDesc)
	local var_6_7 = MoLiDeErEnum.TargetTitleColor[var_6_6]

	arg_6_0._txtState1.text = string.format("<color=%s>%s</color>", var_6_7, var_6_5)

	UISpriteSetMgr.instance:setMoLiDeErSprite(arg_6_0._imageIcon, string.format("v2a8_molideer_game_targeticon_0%s_%s", arg_6_1, var_6_3))
	UIColorHelper.set(arg_6_0._imageActionIcon, var_6_7)

	if arg_6_0._previousExecutionState and arg_6_0._previousExecutionState ~= var_6_3 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._stateFx1) do
			gohelper.setActive(iter_6_1, iter_6_0 == var_6_3)
		end
	end

	arg_6_0._previousExecutionState = var_6_3

	local var_6_8 = arg_6_3 ~= nil and arg_6_3 ~= 0

	gohelper.setActive(arg_6_0._goState2, var_6_8)
	gohelper.setActive(arg_6_0._goLine, var_6_8)

	if var_6_8 then
		local var_6_9, var_6_10 = MoLiDeErHelper.getRangeDesc(math.max(0, arg_6_3 - var_6_1), var_6_4.roundRange, var_6_4.roundDesc)
		local var_6_11 = MoLiDeErEnum.TargetTitleColor[var_6_10]

		arg_6_0._txtState2.text = string.format("<color=%s>%s</color>", var_6_11, var_6_9)

		UIColorHelper.set(arg_6_0._imageActionIcon2, var_6_11)

		if arg_6_0._previousRoundState and arg_6_0._previousRoundState ~= var_6_10 then
			for iter_6_2, iter_6_3 in ipairs(arg_6_0._stateFx2) do
				gohelper.setActive(iter_6_3, iter_6_2 == var_6_10)
			end
		end

		arg_6_0._previousRoundState = var_6_10
	end

	if arg_6_4 then
		arg_6_0._sliderAnimator:Play("light", 0, 0)
	else
		arg_6_0._sliderAnimator:Play("idle", 0, 0)
	end
end

return var_0_0
