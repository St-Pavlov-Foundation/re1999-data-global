module("modules.logic.explore.view.ExploreInteractView", package.seeall)

local var_0_0 = class("ExploreInteractView", BaseView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._tmpMarkTopTextList = {}
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_fullscreen")
	arg_2_0._gochoicelist = gohelper.findChild(arg_2_0.viewGO, "#go_choicelist")
	arg_2_0._gochoiceitem = gohelper.findChild(arg_2_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_2_0._txttalkinfo = gohelper.findChildText(arg_2_0.viewGO, "go_normalcontent/txt_contentcn")
	arg_2_0._txttalker = gohelper.findChildText(arg_2_0.viewGO, "#txt_talker")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	NavigateMgr.instance:addSpace(ViewName.ExploreInteractView, arg_3_0.onClickFull, arg_3_0)
	arg_3_0._btnfullscreen:AddClickListener(arg_3_0.onClickFull, arg_3_0)
	arg_3_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_3_0.OnStoryDialogSelect, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreInteractView)
	arg_4_0._btnfullscreen:RemoveClickListener()
	arg_4_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_4_0.OnStoryDialogSelect, arg_4_0)
end

function var_0_0.onClickFull(arg_5_0)
	if arg_5_0._hasIconDialogItem and arg_5_0._hasIconDialogItem:isPlaying() then
		arg_5_0._hasIconDialogItem:conFinished()

		return
	end

	if not arg_5_0._btnDatas[1] then
		arg_5_0._curStep = arg_5_0._curStep + 1

		if arg_5_0.config[arg_5_0._curStep] then
			arg_5_0:onStep()
		else
			if arg_5_0.viewParam.callBack then
				arg_5_0.viewParam.callBack(arg_5_0.viewParam.callBackObj)
			end

			arg_5_0:closeThis()
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	arg_6_0.config = ExploreConfig.instance:getDialogueConfig(arg_6_0.viewParam.id)

	if not arg_6_0.config then
		logError("对话配置不存在，id：" .. tostring(arg_6_0.viewParam.id))
		arg_6_0:closeThis()

		return
	end

	arg_6_0._curStep = 1

	arg_6_0:onStep()
end

function var_0_0.onStep(arg_7_0)
	local var_7_0 = arg_7_0.config[arg_7_0._curStep]

	if not var_7_0 or var_7_0.interrupt == 1 then
		if arg_7_0.viewParam.callBack then
			arg_7_0.viewParam.callBack(arg_7_0.viewParam.callBackObj)
		end

		arg_7_0:closeThis()

		return
	end

	local var_7_1 = string.gsub(var_7_0.desc, " ", " ")

	if LangSettings.instance:isEn() then
		var_7_1 = var_7_0.desc
	end

	if not arg_7_0._hasIconDialogItem then
		arg_7_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_7_0.viewGO, TMPFadeIn)

		arg_7_0._hasIconDialogItem:setTopOffset(0, -4.5)
		arg_7_0._hasIconDialogItem:setLineSpacing(20)
	end

	arg_7_0._hasIconDialogItem:playNormalText(var_7_1)

	if var_7_0.audio and var_7_0.audio > 0 then
		GuideAudioMgr.instance:playAudio(var_7_0.audio)
	else
		GuideAudioMgr.instance:stopAudio()
	end

	arg_7_0._txttalker.text = var_7_0.speaker

	local var_7_2 = {}

	if not string.nilorempty(var_7_0.acceptButton) then
		table.insert(var_7_2, {
			accept = true,
			text = var_7_0.acceptButton
		})
	end

	if not string.nilorempty(var_7_0.refuseButton) then
		table.insert(var_7_2, {
			accept = false,
			text = var_7_0.refuseButton
		})
	end

	if not string.nilorempty(var_7_0.selectButton) then
		local var_7_3 = GameUtil.splitString2(var_7_0.selectButton)

		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			table.insert(var_7_2, {
				jumpStep = tonumber(iter_7_1[2]),
				text = iter_7_1[1]
			})
		end
	end

	gohelper.CreateObjList(arg_7_0, arg_7_0._createItem, var_7_2, arg_7_0._gochoicelist, arg_7_0._gochoiceitem)

	arg_7_0._btnDatas = var_7_2
end

function var_0_0._createItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildText(arg_8_1, "info")
	local var_8_1 = arg_8_0._tmpMarkTopTextList[arg_8_3]

	if not var_8_1 then
		var_8_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_0.gameObject, TMPMarkTopText)

		var_8_1:setTopOffset(0, -2.6)
		var_8_1:setLineSpacing(31)

		arg_8_0._tmpMarkTopTextList[arg_8_3] = var_8_1
	else
		var_8_1:reInitByCmp(var_8_0)
	end

	var_8_1:setData(arg_8_2.text)

	local var_8_2 = gohelper.findChildButtonWithAudio(arg_8_1, "click")

	arg_8_0:removeClickCb(var_8_2)
	arg_8_0:addClickCb(var_8_2, arg_8_0.onBtnClick, arg_8_0, arg_8_2)

	local var_8_3 = gohelper.findChild(arg_8_1, "#go_pcbtn")

	if var_8_3 then
		PCInputController.instance:showkeyTips(var_8_3, nil, nil, arg_8_3)
	end
end

function var_0_0.OnStoryDialogSelect(arg_9_0, arg_9_1)
	if arg_9_1 <= #arg_9_0._btnDatas and arg_9_1 > 0 then
		arg_9_0:onBtnClick(arg_9_0._btnDatas[arg_9_1])
	end
end

function var_0_0.onBtnClick(arg_10_0, arg_10_1)
	if arg_10_1.jumpStep then
		arg_10_0._curStep = arg_10_1.jumpStep

		arg_10_0:onStep()
	else
		if arg_10_1.accept then
			if arg_10_0.viewParam.callBack then
				arg_10_0.viewParam.callBack(arg_10_0.viewParam.callBackObj)
			end
		elseif arg_10_0.viewParam.refuseCallBack then
			arg_10_0.viewParam.refuseCallBack(arg_10_0.viewParam.refuseCallBackObj)
		end

		arg_10_0:closeThis()
	end
end

function var_0_0.onClose(arg_11_0)
	GameUtil.onDestroyViewMember(arg_11_0, "_hasIconDialogItem")
	GameUtil.onDestroyViewMemberList(arg_11_0, "_tmpMarkTopTextList")
	GuideAudioMgr.instance:stopAudio()
end

return var_0_0
