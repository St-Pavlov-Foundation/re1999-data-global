module("modules.logic.explore.view.ExploreBonusSceneView", package.seeall)

local var_0_0 = class("ExploreBonusSceneView", BaseView)

function var_0_0.onClose(arg_1_0)
	GameUtil.onDestroyViewMember(arg_1_0, "_hasIconDialogItem")
	GameUtil.onDestroyViewMemberList(arg_1_0, "_tmpMarkTopTextList")
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._tmpMarkTopTextList = {}
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._btnfullscreen = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "#btn_fullscreen")
	arg_3_0._gochoicelist = gohelper.findChild(arg_3_0.viewGO, "#go_choicelist")
	arg_3_0._gochoiceitem = gohelper.findChild(arg_3_0.viewGO, "#go_choicelist/#go_choiceitem")
	arg_3_0._txttalkinfo = gohelper.findChildText(arg_3_0.viewGO, "#txt_talkinfo")
	arg_3_0._txttalker = gohelper.findChildText(arg_3_0.viewGO, "#txt_talker")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	NavigateMgr.instance:addSpace(ViewName.ExploreBonusSceneView, arg_4_0.onClickFull, arg_4_0)
	arg_4_0._btnfullscreen:AddClickListener(arg_4_0.onClickFull, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	NavigateMgr.instance:removeSpace(ViewName.ExploreBonusSceneView)
	arg_5_0._btnfullscreen:RemoveClickListener()
end

function var_0_0.onClickFull(arg_6_0)
	if arg_6_0._hasIconDialogItem and arg_6_0._hasIconDialogItem:isPlaying() then
		arg_6_0._hasIconDialogItem:conFinished()

		return
	end

	if not arg_6_0._btnDatas[1] then
		arg_6_0._curStep = arg_6_0._curStep + 1

		if arg_6_0.config[arg_6_0._curStep] then
			table.insert(arg_6_0.options, -1)
			arg_6_0:onStep()
		else
			if arg_6_0.viewParam.callBack then
				arg_6_0.viewParam.callBack(arg_6_0.viewParam.callBackObj, arg_6_0.options)
			end

			arg_6_0:closeThis()
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)

	arg_7_0.unit = arg_7_0.viewParam.unit
	arg_7_0.config = ExploreConfig.instance:getDialogueConfig(arg_7_0.viewParam.id)

	if not arg_7_0.config then
		logError("对话配置不存在，id：" .. tostring(arg_7_0.viewParam.id))
		arg_7_0:closeThis()

		return
	end

	arg_7_0.options = {}
	arg_7_0._curStep = 1

	arg_7_0:onStep()
end

function var_0_0.onStep(arg_8_0)
	local var_8_0 = arg_8_0.config[arg_8_0._curStep]
	local var_8_1 = string.gsub(var_8_0.desc, " ", " ")

	if LangSettings.instance:isEn() then
		var_8_1 = var_8_0.desc
	end

	if not arg_8_0._hasIconDialogItem then
		arg_8_0._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(arg_8_0.viewGO, TMPFadeIn)

		arg_8_0._hasIconDialogItem:setTopOffset(0, -2.4)
		arg_8_0._hasIconDialogItem:setLineSpacing(26)
	end

	arg_8_0._hasIconDialogItem:playNormalText(var_8_1)

	arg_8_0._txttalker.text = var_8_0.speaker

	local var_8_2 = {}

	if not string.nilorempty(var_8_0.bonusButton) then
		var_8_2 = string.split(var_8_0.bonusButton, "|")
	end

	gohelper.CreateObjList(arg_8_0, arg_8_0._createItem, var_8_2, arg_8_0._gochoicelist, arg_8_0._gochoiceitem)

	arg_8_0._btnDatas = var_8_2
end

function var_0_0._createItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildText(arg_9_1, "info")
	local var_9_1 = arg_9_0._tmpMarkTopTextList[arg_9_3]

	if not var_9_1 then
		var_9_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_0.gameObject, TMPMarkTopText)

		var_9_1:setTopOffset(0, -2.6)
		var_9_1:setLineSpacing(5)

		arg_9_0._tmpMarkTopTextList[arg_9_3] = var_9_1
	else
		var_9_1:reInitByCmp(var_9_0)
	end

	var_9_1:setData(arg_9_2)

	local var_9_2 = gohelper.findChildButtonWithAudio(arg_9_1, "click")

	arg_9_0:removeClickCb(var_9_2)
	arg_9_0:addClickCb(var_9_2, arg_9_0.onBtnClick, arg_9_0, arg_9_3)
end

function var_0_0.onBtnClick(arg_10_0, arg_10_1)
	table.insert(arg_10_0.options, arg_10_1)

	local var_10_0 = arg_10_0.config[arg_10_0._curStep]

	GameSceneMgr.instance:getCurScene().stat:onTriggerEggs(string.format("%d_%d", var_10_0.id, var_10_0.stepid), arg_10_0._btnDatas[arg_10_1])

	arg_10_0._btnDatas = {}

	arg_10_0:onClickFull()
end

return var_0_0
