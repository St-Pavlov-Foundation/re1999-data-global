module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle4", package.seeall)

local var_0_0 = class("FairyLandPuzzle4", FairyLandPuzzleBase)
local var_0_1 = "0123456789%+%-%*%/%.１２３４５６７８９０×"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._shapeGO = gohelper.findChild(arg_1_0.viewGO, "main/#go_Shape/4")
	arg_1_0.goPuzzle = gohelper.findChild(arg_1_0._shapeGO, "#go_NumPuzzleBG")
	arg_1_0.txtQuestion = gohelper.findChildTextMesh(arg_1_0.goPuzzle, "#txt_Equation")
	arg_1_0.goInput = gohelper.findChild(arg_1_0._shapeGO, "#go_Input")
	arg_1_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.goInput, "#go_SelectFrame/#go_Confirm")
	arg_1_0.goInputNum = gohelper.findChild(arg_1_0.goInput, "#inputNum")
	arg_1_0.inputNum = gohelper.findChildTextMeshInputField(arg_1_0.goInput, "#inputNum")

	arg_1_0.inputNum:AddOnValueChanged(arg_1_0.onAddOnValueChanged, arg_1_0)

	arg_1_0.inputTxtGO = gohelper.findChild(arg_1_0.goInput, "#inputNum/Text Area/Text")
	arg_1_0.animInput = SLFramework.AnimatorPlayer.Get(arg_1_0.inputTxtGO)
	arg_1_0.numComp = FairyLandFullScreenNumber.New()

	local var_1_0 = {
		viewGO = arg_1_0.viewGO
	}

	arg_1_0.numComp:init(var_1_0)
	arg_1_0:addClickCb(arg_1_0.btnConfirm, arg_1_0.onClickBtnConfirm, arg_1_0)
	gohelper.setActive(arg_1_0.btnConfirm, false)

	local var_1_1 = string.gsub(var_0_1, "[%-%[%]%^]", "%%%1")

	arg_1_0.pattern = string.format("^[%s]*$", var_1_1)
	arg_1_0.clearPattern = string.format("[^%s]", var_1_1)
end

function var_0_0.onAddOnValueChanged(arg_2_0, arg_2_1)
	if not string.match(arg_2_1, arg_2_0.pattern) then
		local var_2_0 = string.gsub(arg_2_1, arg_2_0.clearPattern, "")

		arg_2_0.inputNum:SetText(var_2_0)

		return
	end

	local var_2_1 = arg_2_0.inputNum:GetText()

	gohelper.setActive(arg_2_0.btnConfirm, not string.nilorempty(var_2_1))
end

function var_0_0.onClickBtnConfirm(arg_3_0)
	local var_3_0 = arg_3_0.inputNum:GetText()
	local var_3_1 = {
		"１",
		"２",
		"３",
		"４",
		"５",
		"６",
		"７",
		"８",
		"９",
		"０"
	}
	local var_3_2 = {
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"0"
	}

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		var_3_0 = string.gsub(var_3_0, iter_3_1, var_3_2[iter_3_0])
	end

	if var_3_0 == arg_3_0.config.answer then
		gohelper.setActive(arg_3_0.btnConfirm, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_right)
		arg_3_0.animInput:Play("correct", arg_3_0.onCorrectAnimEnd, arg_3_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_mistake)
		arg_3_0.animInput:Play("error", arg_3_0.onErrorAnimEnd, arg_3_0)
	end
end

function var_0_0.onCorrectAnimEnd(arg_4_0)
	arg_4_0.inputNum:SetText("")
	arg_4_0.animInput:Play("idle", arg_4_0.onAnimEnd, arg_4_0)
	arg_4_0:finished()
end

function var_0_0.onErrorAnimEnd(arg_5_0)
	arg_5_0.inputNum:SetText("")
	arg_5_0.animInput:Play("idle", arg_5_0.onAnimEnd, arg_5_0)
	arg_5_0:playErrorTalk()
	arg_5_0:startCheckTips()
end

function var_0_0.onAnimEnd(arg_6_0)
	return
end

function var_0_0.onStart(arg_7_0)
	arg_7_0.txtQuestion.text = arg_7_0:getQuestion()

	arg_7_0.inputNum:SetText("")

	local var_7_0 = arg_7_0:isEndPuzzle()

	gohelper.setActive(arg_7_0.goPuzzle, not var_7_0)

	if var_7_0 then
		recthelper.setAnchor(arg_7_0.goInput.transform, 0, 180)
	else
		arg_7_0:layoutContent()
		TaskDispatcher.runDelay(arg_7_0.layoutContent, arg_7_0, 0.1)
	end

	local var_7_1 = FairyLandModel.instance:isPassPuzzle(arg_7_0.config.id)

	gohelper.setActive(arg_7_0._shapeGO, false)
	gohelper.setActive(arg_7_0._shapeGO, not var_7_1 or not var_7_0)
	gohelper.setActive(arg_7_0.goInputNum, not var_7_1)

	if var_7_0 and not var_7_1 then
		arg_7_0:showNumberText()
	end

	arg_7_0:startCheckTips()
end

function var_0_0.onRefreshView(arg_8_0)
	arg_8_0.txtQuestion.text = arg_8_0:getQuestion()

	local var_8_0 = arg_8_0:isEndPuzzle()
	local var_8_1 = FairyLandModel.instance:isPassPuzzle(arg_8_0.config.id)

	gohelper.setActive(arg_8_0._shapeGO, false)
	gohelper.setActive(arg_8_0._shapeGO, not var_8_1 or not var_8_0)
	gohelper.setActive(arg_8_0.goInputNum, not var_8_1)

	if not var_8_1 then
		gohelper.setActive(arg_8_0.goPuzzle, not var_8_0)

		if var_8_0 then
			arg_8_0.tweenId = ZProj.TweenHelper.DOAnchorPos(arg_8_0.goInput.transform, 0, 180, 1)

			arg_8_0:showNumberText()
		else
			arg_8_0:layoutContent()
		end
	end

	arg_8_0:startCheckTips()
end

function var_0_0.layoutContent(arg_9_0)
	local var_9_0 = arg_9_0.txtQuestion.preferredWidth
	local var_9_1 = 346
	local var_9_2 = -var_9_1 * 0.5
	local var_9_3 = var_9_0 * 0.5

	recthelper.setAnchor(arg_9_0.txtQuestion.transform, var_9_2, 0)
	recthelper.setAnchor(arg_9_0.goInput.transform, var_9_3, 350)
end

function var_0_0.isEndPuzzle(arg_10_0)
	return arg_10_0.config.id == 10
end

function var_0_0.getQuestion(arg_11_0)
	local var_11_0 = arg_11_0.config.id

	if var_11_0 == 4 then
		return "1+2+3=1×2×3="
	end

	if var_11_0 == 5 then
		return "1+2+3=1+2+3=6"
	end

	if var_11_0 == 6 then
		return "111÷3="
	end

	if var_11_0 == 7 then
		return "111÷3=37"
	end

	if var_11_0 == 8 then
		return "2×3×5×7="
	end

	if var_11_0 == 9 then
		return "2×3×5×7=210"
	end

	return ""
end

function var_0_0.finished(arg_12_0)
	arg_12_0:stopCheckTips()
	gohelper.setActive(arg_12_0.goInputNum, false)
	FairyLandController.instance:closeDialogView()

	if arg_12_0:isEndPuzzle() then
		arg_12_0:showZeroText()
	else
		arg_12_0:playSuccessTalk()
	end
end

function var_0_0.playSuccessTalk(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.playTipsTalk, arg_13_0)

	if not FairyLandModel.instance:isPassPuzzle(arg_13_0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(arg_13_0.config.id, arg_13_0.config.answer)
	end

	arg_13_0:playTalk(arg_13_0.config.successTalkId, arg_13_0.onSuccessTalkCallback, arg_13_0)
end

function var_0_0.onSuccessTalkCallback(arg_14_0)
	if arg_14_0:isEndPuzzle() then
		gohelper.setActive(arg_14_0._shapeGO, false)
		arg_14_0:clearNumTween()
		arg_14_0:openCompleteView()
	end
end

function var_0_0.showNumberText(arg_15_0)
	if arg_15_0.numComp then
		arg_15_0.numComp:playShowTween()
	end
end

function var_0_0.showZeroText(arg_16_0)
	if arg_16_0.numComp then
		arg_16_0.numComp:playZeroTween(arg_16_0.playSuccessTalk, arg_16_0)
	end
end

function var_0_0.clearNumTween(arg_17_0)
	if arg_17_0.numComp then
		arg_17_0.numComp:clear()
	end
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.inputNum:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_18_0.layoutContent, arg_18_0)
	gohelper.setActive(arg_18_0._shapeGO, false)

	if arg_18_0.numComp then
		arg_18_0.numComp:destory()
	end
end

return var_0_0
