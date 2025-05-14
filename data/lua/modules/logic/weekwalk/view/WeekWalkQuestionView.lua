module("modules.logic.weekwalk.view.WeekWalkQuestionView", package.seeall)

local var_0_0 = class("WeekWalkQuestionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._txtquestion = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_question")
	arg_1_0._gooptions = gohelper.findChild(arg_1_0.viewGO, "anim/#go_options")
	arg_1_0._gooptionitem = gohelper.findChild(arg_1_0.viewGO, "anim/#go_options/#go_optionitem")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_line")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._optionBtnList = arg_4_0:getUserDataTb_()

	arg_4_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_huan.png"))
	arg_4_0._simageline:LoadImage(ResUrl.getWeekWalkBg("bg_xian.png"))
	arg_4_0:_checkShowQuestion()
end

function var_0_0._checkShowQuestion(arg_5_0)
	if not arg_5_0:_showNextQuestion() then
		if arg_5_0._answerAll then
			return
		end

		arg_5_0._answerAll = true

		WeekWalkController.instance:openWeekWalkView()
	end
end

function var_0_0._showNextQuestion(arg_6_0)
	arg_6_0.questionIds, arg_6_0.selects = WeekWalkModel.instance:getInfo():getQuestionInfo()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.questionIds) do
		if not arg_6_0.selects[iter_6_0] then
			arg_6_0:_showQuestion(iter_6_1)

			return true
		end
	end

	return false
end

function var_0_0._showQuestion(arg_7_0, arg_7_1)
	local var_7_0 = WeekWalkConfig.instance:getQuestionConfig(arg_7_1)

	arg_7_0._txtquestion.text = var_7_0.text

	arg_7_0:_addAllOptions(var_7_0)
end

function var_0_0._addAllOptions(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._optionBtnList) do
		gohelper.setActive(iter_8_1[1], false)
	end

	for iter_8_2 = 1, 3 do
		arg_8_0:_addOption(iter_8_2, arg_8_1["select" .. iter_8_2])
	end
end

function var_0_0._addOption(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0._optionBtnList[arg_9_1] and arg_9_0._optionBtnList[arg_9_1][1] or gohelper.cloneInPlace(arg_9_0._gooptionitem)

	gohelper.setActive(var_9_0, true)

	gohelper.findChildText(var_9_0, "txt_optionitem").text = arg_9_2

	local var_9_1 = gohelper.findChildButtonWithAudio(var_9_0, "btn_optionitem", AudioEnum.WeekWalk.play_artificial_ui_answerchoose)

	var_9_1:AddClickListener(arg_9_0._onOptionClick, arg_9_0, {
		arg_9_1,
		arg_9_2
	})

	if not arg_9_0._optionBtnList[arg_9_1] then
		arg_9_0._optionBtnList[arg_9_1] = {
			var_9_0,
			var_9_1
		}
	end
end

function var_0_0._onOptionClick(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[1]

	WeekwalkRpc.instance:sendWeekwalkQuestionSelectRequest(var_10_0)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnQuestionReply, arg_12_0._OnQuestionReply, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_12_0._onOpenViewFinish, arg_12_0)
	arg_12_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnGetInfo, arg_12_0._OnGetInfo, arg_12_0)
end

function var_0_0._OnGetInfo(arg_13_0)
	arg_13_0:_checkExpire()
end

function var_0_0._checkExpire(arg_14_0)
	if WeekWalkModel.instance:infoNeedUpdate() then
		UIBlockMgr.instance:startBlock("WeekWalkQuestionView _checkExpire")
		TaskDispatcher.runDelay(arg_14_0._exitView, arg_14_0, 0.5)
	end
end

function var_0_0._exitView(arg_15_0)
	UIBlockMgr.instance:endBlock("WeekWalkQuestionView _checkExpire")
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkExpire, MsgBoxEnum.BoxType.Yes, function()
		ViewMgr.instance:closeAllPopupViews({
			ViewName.DungeonView
		})
	end, nil, nil)
end

function var_0_0._onOpenViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.WeekWalkView then
		arg_17_0:closeThis()
	end
end

function var_0_0._OnQuestionReply(arg_18_0)
	arg_18_0:_checkShowQuestion()
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0._optionBtnList) do
		iter_19_1[2]:RemoveClickListener()
	end

	if arg_19_0._bgmId then
		arg_19_0._bgmId = nil
	end

	TaskDispatcher.cancelTask(arg_19_0._exitView, arg_19_0)
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simagebg:UnLoadImage()
	arg_20_0._simageline:UnLoadImage()
end

return var_0_0
