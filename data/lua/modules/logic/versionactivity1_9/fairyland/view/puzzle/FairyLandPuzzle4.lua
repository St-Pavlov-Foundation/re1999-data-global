module("modules.logic.versionactivity1_9.fairyland.view.puzzle.FairyLandPuzzle4", package.seeall)

slot0 = class("FairyLandPuzzle4", FairyLandPuzzleBase)
slot1 = "0123456789%+%-%*%/%.１２３４５６７８９０×"

function slot0.onInitView(slot0)
	slot0._shapeGO = gohelper.findChild(slot0.viewGO, "main/#go_Shape/4")
	slot0.goPuzzle = gohelper.findChild(slot0._shapeGO, "#go_NumPuzzleBG")
	slot0.txtQuestion = gohelper.findChildTextMesh(slot0.goPuzzle, "#txt_Equation")
	slot0.goInput = gohelper.findChild(slot0._shapeGO, "#go_Input")
	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.goInput, "#go_SelectFrame/#go_Confirm")
	slot0.goInputNum = gohelper.findChild(slot0.goInput, "#inputNum")
	slot0.inputNum = gohelper.findChildTextMeshInputField(slot0.goInput, "#inputNum")

	slot0.inputNum:AddOnValueChanged(slot0.onAddOnValueChanged, slot0)

	slot0.inputTxtGO = gohelper.findChild(slot0.goInput, "#inputNum/Text Area/Text")
	slot0.animInput = SLFramework.AnimatorPlayer.Get(slot0.inputTxtGO)
	slot0.numComp = FairyLandFullScreenNumber.New()

	slot0.numComp:init({
		viewGO = slot0.viewGO
	})
	slot0:addClickCb(slot0.btnConfirm, slot0.onClickBtnConfirm, slot0)
	gohelper.setActive(slot0.btnConfirm, false)

	slot2 = string.gsub(uv0, "[%-%[%]%^]", "%%%1")
	slot0.pattern = string.format("^[%s]*$", slot2)
	slot0.clearPattern = string.format("[^%s]", slot2)
end

function slot0.onAddOnValueChanged(slot0, slot1)
	if not string.match(slot1, slot0.pattern) then
		slot0.inputNum:SetText(string.gsub(slot1, slot0.clearPattern, ""))

		return
	end

	gohelper.setActive(slot0.btnConfirm, not string.nilorempty(slot0.inputNum:GetText()))
end

function slot0.onClickBtnConfirm(slot0)
	for slot7, slot8 in ipairs({
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
	}) do
		slot1 = string.gsub(slot0.inputNum:GetText(), slot8, ({
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
		})[slot7])
	end

	if slot1 == slot0.config.answer then
		gohelper.setActive(slot0.btnConfirm, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_right)
		slot0.animInput:Play("correct", slot0.onCorrectAnimEnd, slot0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_input_mistake)
		slot0.animInput:Play("error", slot0.onErrorAnimEnd, slot0)
	end
end

function slot0.onCorrectAnimEnd(slot0)
	slot0.inputNum:SetText("")
	slot0.animInput:Play("idle", slot0.onAnimEnd, slot0)
	slot0:finished()
end

function slot0.onErrorAnimEnd(slot0)
	slot0.inputNum:SetText("")
	slot0.animInput:Play("idle", slot0.onAnimEnd, slot0)
	slot0:playErrorTalk()
	slot0:startCheckTips()
end

function slot0.onAnimEnd(slot0)
end

function slot0.onStart(slot0)
	slot0.txtQuestion.text = slot0:getQuestion()

	slot0.inputNum:SetText("")

	slot1 = slot0:isEndPuzzle()

	gohelper.setActive(slot0.goPuzzle, not slot1)

	if slot1 then
		recthelper.setAnchor(slot0.goInput.transform, 0, 180)
	else
		slot0:layoutContent()
		TaskDispatcher.runDelay(slot0.layoutContent, slot0, 0.1)
	end

	gohelper.setActive(slot0._shapeGO, false)
	gohelper.setActive(slot0._shapeGO, not FairyLandModel.instance:isPassPuzzle(slot0.config.id) or not slot1)
	gohelper.setActive(slot0.goInputNum, not slot2)

	if slot1 and not slot2 then
		slot0:showNumberText()
	end

	slot0:startCheckTips()
end

function slot0.onRefreshView(slot0)
	slot0.txtQuestion.text = slot0:getQuestion()

	gohelper.setActive(slot0._shapeGO, false)
	gohelper.setActive(slot0._shapeGO, not FairyLandModel.instance:isPassPuzzle(slot0.config.id) or not slot0:isEndPuzzle())
	gohelper.setActive(slot0.goInputNum, not slot2)

	if not slot2 then
		gohelper.setActive(slot0.goPuzzle, not slot1)

		if slot1 then
			slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot0.goInput.transform, 0, 180, 1)

			slot0:showNumberText()
		else
			slot0:layoutContent()
		end
	end

	slot0:startCheckTips()
end

function slot0.layoutContent(slot0)
	recthelper.setAnchor(slot0.txtQuestion.transform, -346 * 0.5, 0)
	recthelper.setAnchor(slot0.goInput.transform, slot0.txtQuestion.preferredWidth * 0.5, 350)
end

function slot0.isEndPuzzle(slot0)
	return slot0.config.id == 10
end

function slot0.getQuestion(slot0)
	if slot0.config.id == 4 then
		return "1+2+3=1×2×3="
	end

	if slot1 == 5 then
		return "1+2+3=1+2+3=6"
	end

	if slot1 == 6 then
		return "111÷3="
	end

	if slot1 == 7 then
		return "111÷3=37"
	end

	if slot1 == 8 then
		return "2×3×5×7="
	end

	if slot1 == 9 then
		return "2×3×5×7=210"
	end

	return ""
end

function slot0.finished(slot0)
	slot0:stopCheckTips()
	gohelper.setActive(slot0.goInputNum, false)
	FairyLandController.instance:closeDialogView()

	if slot0:isEndPuzzle() then
		slot0:showZeroText()
	else
		slot0:playSuccessTalk()
	end
end

function slot0.playSuccessTalk(slot0)
	TaskDispatcher.cancelTask(slot0.playTipsTalk, slot0)

	if not FairyLandModel.instance:isPassPuzzle(slot0.config.id) then
		FairyLandRpc.instance:sendResolvePuzzleRequest(slot0.config.id, slot0.config.answer)
	end

	slot0:playTalk(slot0.config.successTalkId, slot0.onSuccessTalkCallback, slot0)
end

function slot0.onSuccessTalkCallback(slot0)
	if slot0:isEndPuzzle() then
		gohelper.setActive(slot0._shapeGO, false)
		slot0:clearNumTween()
		slot0:openCompleteView()
	end
end

function slot0.showNumberText(slot0)
	if slot0.numComp then
		slot0.numComp:playShowTween()
	end
end

function slot0.showZeroText(slot0)
	if slot0.numComp then
		slot0.numComp:playZeroTween(slot0.playSuccessTalk, slot0)
	end
end

function slot0.clearNumTween(slot0)
	if slot0.numComp then
		slot0.numComp:clear()
	end
end

function slot0.onDestroyView(slot0)
	slot0.inputNum:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0.layoutContent, slot0)
	gohelper.setActive(slot0._shapeGO, false)

	if slot0.numComp then
		slot0.numComp:destory()
	end
end

return slot0
