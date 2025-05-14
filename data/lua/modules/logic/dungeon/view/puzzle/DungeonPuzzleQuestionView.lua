module("modules.logic.dungeon.view.puzzle.DungeonPuzzleQuestionView", package.seeall)

local var_0_0 = class("DungeonPuzzleQuestionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "#txt_titleen")
	arg_1_0._goquestionlist = gohelper.findChild(arg_1_0.viewGO, "#go_questionlist")
	arg_1_0._goquestionitem = gohelper.findChild(arg_1_0.viewGO, "#go_questionlist/#go_questionitem")
	arg_1_0._btnsubmit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_questionlist/#btn_submit")
	arg_1_0._simagepaper = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_paper")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_title1")
	arg_1_0._txtdesc1 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_desc1")
	arg_1_0._txttitleen1 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_titleen1")
	arg_1_0._txtdescen1 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_descen1")
	arg_1_0._txttitle2 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_title2")
	arg_1_0._txtdesc2 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_desc2")
	arg_1_0._txttitleen2 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_titleen2")
	arg_1_0._txtdescen2 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_descen2")
	arg_1_0._txttitle3 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_title3")
	arg_1_0._txtdesc3 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_desc3")
	arg_1_0._txttitleen3 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_titleen3")
	arg_1_0._txtdescen3 = gohelper.findChildText(arg_1_0.viewGO, "info/#txt_descen3")
	arg_1_0._gomasklist = gohelper.findChild(arg_1_0.viewGO, "#go_masklist")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsubmit:AddClickListener(arg_2_0._btnsubmitOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsubmit:RemoveClickListener()
end

function var_0_0._btnsubmitOnClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if DungeonPuzzleQuestionModel.instance:getIsReady() and not arg_4_0._isClear then
		local var_4_0 = DungeonPuzzleQuestionModel.instance:getQuestionCount()

		for iter_4_0 = 1, var_4_0 do
			local var_4_1 = arg_4_0._questionItems[iter_4_0].input:GetText()

			if not DungeonPuzzleQuestionModel.instance:getAnswers(iter_4_0)[var_4_1] then
				GameFacade.showToast(ToastEnum.DungeonMapInteractive)

				return
			end
		end

		arg_4_0._isClear = true

		arg_4_0:_disableInput()
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
		gohelper.setActive(arg_4_0._gofinish, true)
		gohelper.setActive(arg_4_0._btnsubmit.gameObject, false)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)

		local var_4_2 = DungeonPuzzleQuestionModel.instance:getElementCo()

		DungeonRpc.instance:sendPuzzleFinishRequest(var_4_2.id)
	elseif arg_4_0._isClear then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	arg_5_0._simagepaper:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_1"))

	arg_5_0._questionItems = {}
	arg_5_0._isClear = false
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:onOpen()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshUI()
end

function var_0_0._refreshUI(arg_8_0)
	for iter_8_0 = 1, DungeonPuzzleEnum.hintCount do
		local var_8_0, var_8_1, var_8_2, var_8_3 = DungeonPuzzleQuestionModel.instance:getHint(iter_8_0)

		arg_8_0["_txttitle" .. tostring(iter_8_0)].text = var_8_0
		arg_8_0["_txtdesc" .. tostring(iter_8_0)].text = var_8_2
		arg_8_0["_txttitleen" .. tostring(iter_8_0)].text = var_8_1
		arg_8_0["_txtdescen" .. tostring(iter_8_0)].text = var_8_3
	end

	local var_8_4, var_8_5 = DungeonPuzzleQuestionModel.instance:getQuestionTitle()

	arg_8_0._txttitle.text = var_8_4
	arg_8_0._txttitleen.text = var_8_5

	arg_8_0:_refreshQuestionList()
end

function var_0_0._refreshQuestionList(arg_9_0)
	local var_9_0 = DungeonPuzzleQuestionModel.instance:getQuestionCount()

	for iter_9_0 = 1, var_9_0 do
		local var_9_1 = arg_9_0._questionItems[iter_9_0] or arg_9_0:_newQuestionItem(iter_9_0)

		arg_9_0:_refreshItemUI(var_9_1, iter_9_0)
	end

	for iter_9_1 = var_9_0 + 1, #arg_9_0._questionItems do
		arg_9_0._questionItems[iter_9_1].go:SetActive(false)
	end
end

function var_0_0._newQuestionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()
	local var_10_1 = gohelper.clone(arg_10_0._goquestionitem, arg_10_0._goquestionlist, "question_" .. tostring(arg_10_1))

	var_10_0.go = var_10_1
	var_10_0.input = gohelper.findChildTextMeshInputField(var_10_1, "answer")
	var_10_0.inputTMT = var_10_0.input.gameObject:GetComponent(gohelper.Type_TMPInputField)
	var_10_0.txtQuestion = gohelper.findChildText(var_10_1, "question")
	arg_10_0._questionItems[arg_10_1] = var_10_0

	return var_10_0
end

function var_0_0._refreshItemUI(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = DungeonPuzzleQuestionModel.instance:getQuestion(arg_11_2)

	arg_11_1.txtQuestion.text = var_11_0

	arg_11_1.go:SetActive(true)
end

function var_0_0._disableInput(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._questionItems) do
		iter_12_1.inputTMT.readOnly = true
	end
end

function var_0_0._onPuzzleFinish(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_14_0 = DungeonPuzzleQuestionModel.instance:getElementCo()

	if var_14_0 and DungeonMapModel.instance:hasMapPuzzleStatus(var_14_0.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, var_14_0.id)
	end

	DungeonPuzzleQuestionModel.instance:release()
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simagebg:UnLoadImage()
	arg_15_0._simagepaper:UnLoadImage()
end

return var_0_0
