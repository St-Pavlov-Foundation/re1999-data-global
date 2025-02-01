module("modules.logic.weekwalk.view.WeekWalkQuestionView", package.seeall)

slot0 = class("WeekWalkQuestionView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._txtquestion = gohelper.findChildText(slot0.viewGO, "anim/#txt_question")
	slot0._gooptions = gohelper.findChild(slot0.viewGO, "anim/#go_options")
	slot0._gooptionitem = gohelper.findChild(slot0.viewGO, "anim/#go_options/#go_optionitem")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_line")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._optionBtnList = slot0:getUserDataTb_()

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_huan.png"))
	slot0._simageline:LoadImage(ResUrl.getWeekWalkBg("bg_xian.png"))
	slot0:_checkShowQuestion()
end

function slot0._checkShowQuestion(slot0)
	if not slot0:_showNextQuestion() then
		if slot0._answerAll then
			return
		end

		slot0._answerAll = true

		WeekWalkController.instance:openWeekWalkView()
	end
end

function slot0._showNextQuestion(slot0)
	slot0.questionIds, slot0.selects = WeekWalkModel.instance:getInfo():getQuestionInfo()

	for slot5, slot6 in ipairs(slot0.questionIds) do
		if not slot0.selects[slot5] then
			slot0:_showQuestion(slot6)

			return true
		end
	end

	return false
end

function slot0._showQuestion(slot0, slot1)
	slot2 = WeekWalkConfig.instance:getQuestionConfig(slot1)
	slot0._txtquestion.text = slot2.text

	slot0:_addAllOptions(slot2)
end

function slot0._addAllOptions(slot0, slot1)
	for slot5, slot6 in pairs(slot0._optionBtnList) do
		gohelper.setActive(slot6[1], false)
	end

	for slot5 = 1, 3 do
		slot0:_addOption(slot5, slot1["select" .. slot5])
	end
end

function slot0._addOption(slot0, slot1, slot2)
	slot3 = slot0._optionBtnList[slot1] and slot0._optionBtnList[slot1][1] or gohelper.cloneInPlace(slot0._gooptionitem)

	gohelper.setActive(slot3, true)

	gohelper.findChildText(slot3, "txt_optionitem").text = slot2

	gohelper.findChildButtonWithAudio(slot3, "btn_optionitem", AudioEnum.WeekWalk.play_artificial_ui_answerchoose):AddClickListener(slot0._onOptionClick, slot0, {
		slot1,
		slot2
	})

	if not slot0._optionBtnList[slot1] then
		slot0._optionBtnList[slot1] = {
			slot3,
			slot5
		}
	end
end

function slot0._onOptionClick(slot0, slot1)
	WeekwalkRpc.instance:sendWeekwalkQuestionSelectRequest(slot1[1])
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnQuestionReply, slot0._OnQuestionReply, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, slot0._OnGetInfo, slot0)
end

function slot0._OnGetInfo(slot0)
	slot0:_checkExpire()
end

function slot0._checkExpire(slot0)
	if WeekWalkModel.instance:infoNeedUpdate() then
		UIBlockMgr.instance:startBlock("WeekWalkQuestionView _checkExpire")
		TaskDispatcher.runDelay(slot0._exitView, slot0, 0.5)
	end
end

function slot0._exitView(slot0)
	UIBlockMgr.instance:endBlock("WeekWalkQuestionView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function ()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView
		})
	end, nil, )
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.WeekWalkView then
		slot0:closeThis()
	end
end

function slot0._OnQuestionReply(slot0)
	slot0:_checkShowQuestion()
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._optionBtnList) do
		slot5[2]:RemoveClickListener()
	end

	if slot0._bgmId then
		slot0._bgmId = nil
	end

	TaskDispatcher.cancelTask(slot0._exitView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

return slot0
