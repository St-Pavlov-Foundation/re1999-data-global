module("modules.logic.dungeon.view.puzzle.DungeonPuzzleQuestionView", package.seeall)

slot0 = class("DungeonPuzzleQuestionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "#txt_titleen")
	slot0._goquestionlist = gohelper.findChild(slot0.viewGO, "#go_questionlist")
	slot0._goquestionitem = gohelper.findChild(slot0.viewGO, "#go_questionlist/#go_questionitem")
	slot0._btnsubmit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_questionlist/#btn_submit")
	slot0._simagepaper = gohelper.findChildSingleImage(slot0.viewGO, "#simage_paper")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "info/#txt_title1")
	slot0._txtdesc1 = gohelper.findChildText(slot0.viewGO, "info/#txt_desc1")
	slot0._txttitleen1 = gohelper.findChildText(slot0.viewGO, "info/#txt_titleen1")
	slot0._txtdescen1 = gohelper.findChildText(slot0.viewGO, "info/#txt_descen1")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "info/#txt_title2")
	slot0._txtdesc2 = gohelper.findChildText(slot0.viewGO, "info/#txt_desc2")
	slot0._txttitleen2 = gohelper.findChildText(slot0.viewGO, "info/#txt_titleen2")
	slot0._txtdescen2 = gohelper.findChildText(slot0.viewGO, "info/#txt_descen2")
	slot0._txttitle3 = gohelper.findChildText(slot0.viewGO, "info/#txt_title3")
	slot0._txtdesc3 = gohelper.findChildText(slot0.viewGO, "info/#txt_desc3")
	slot0._txttitleen3 = gohelper.findChildText(slot0.viewGO, "info/#txt_titleen3")
	slot0._txtdescen3 = gohelper.findChildText(slot0.viewGO, "info/#txt_descen3")
	slot0._gomasklist = gohelper.findChild(slot0.viewGO, "#go_masklist")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsubmit:AddClickListener(slot0._btnsubmitOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsubmit:RemoveClickListener()
end

function slot0._btnsubmitOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if DungeonPuzzleQuestionModel.instance:getIsReady() and not slot0._isClear then
		for slot5 = 1, DungeonPuzzleQuestionModel.instance:getQuestionCount() do
			if not DungeonPuzzleQuestionModel.instance:getAnswers(slot5)[slot0._questionItems[slot5].input:GetText()] then
				GameFacade.showToast(ToastEnum.DungeonMapInteractive)

				return
			end
		end

		slot0._isClear = true

		slot0:_disableInput()
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
		gohelper.setActive(slot0._gofinish, true)
		gohelper.setActive(slot0._btnsubmit.gameObject, false)
		GameFacade.showToast(ToastEnum.DungeonPuzzle2)
		DungeonRpc.instance:sendPuzzleFinishRequest(DungeonPuzzleQuestionModel.instance:getElementCo().id)
	elseif slot0._isClear then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("full/bg_jiemi_beijigntu"))
	slot0._simagepaper:LoadImage(ResUrl.getDungeonPuzzleBg("bg_jiemi_zhizhang_1"))

	slot0._questionItems = {}
	slot0._isClear = false
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	for slot4 = 1, DungeonPuzzleEnum.hintCount do
		slot0["_txttitle" .. tostring(slot4)].text, slot0["_txttitleen" .. tostring(slot4)].text, slot0["_txtdesc" .. tostring(slot4)].text, slot0["_txtdescen" .. tostring(slot4)].text = DungeonPuzzleQuestionModel.instance:getHint(slot4)
	end

	slot0._txttitle.text, slot0._txttitleen.text = DungeonPuzzleQuestionModel.instance:getQuestionTitle()

	slot0:_refreshQuestionList()
end

function slot0._refreshQuestionList(slot0)
	for slot5 = 1, DungeonPuzzleQuestionModel.instance:getQuestionCount() do
		slot0:_refreshItemUI(slot0._questionItems[slot5] or slot0:_newQuestionItem(slot5), slot5)
	end

	for slot5 = slot1 + 1, #slot0._questionItems do
		slot0._questionItems[slot5].go:SetActive(false)
	end
end

function slot0._newQuestionItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.clone(slot0._goquestionitem, slot0._goquestionlist, "question_" .. tostring(slot1))
	slot2.go = slot3
	slot2.input = gohelper.findChildTextMeshInputField(slot3, "answer")
	slot2.inputTMT = slot2.input.gameObject:GetComponent(gohelper.Type_TMPInputField)
	slot2.txtQuestion = gohelper.findChildText(slot3, "question")
	slot0._questionItems[slot1] = slot2

	return slot2
end

function slot0._refreshItemUI(slot0, slot1, slot2)
	slot1.txtQuestion.text = DungeonPuzzleQuestionModel.instance:getQuestion(slot2)

	slot1.go:SetActive(true)
end

function slot0._disableInput(slot0)
	for slot4, slot5 in pairs(slot0._questionItems) do
		slot5.inputTMT.readOnly = true
	end
end

function slot0._onPuzzleFinish(slot0)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if DungeonPuzzleQuestionModel.instance:getElementCo() and DungeonMapModel.instance:hasMapPuzzleStatus(slot1.id) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot1.id)
	end

	DungeonPuzzleQuestionModel.instance:release()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagepaper:UnLoadImage()
end

return slot0
