module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsView", package.seeall)

local var_0_0 = class("RoleStoryDispatchTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.goLeft = gohelper.findChild(arg_1_0.viewGO, "Layout/left")

	gohelper.setActive(arg_1_0.goLeft, true)

	arg_1_0.goRight = gohelper.findChild(arg_1_0.viewGO, "Layout/right")
	arg_1_0.animLeft = arg_1_0.goLeft:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.canvasGroupLeft = arg_1_0.goLeft:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.animRight = arg_1_0.goRight:GetComponent(typeof(UnityEngine.Animator))

	arg_1_0:initLeft()
	arg_1_0:initRight()

	arg_1_0.goreward = gohelper.findChild(arg_1_0.viewGO, "#btn_scorereward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.initLeft(arg_2_0)
	arg_2_0.txtLeftLable = gohelper.findChildTextMesh(arg_2_0.goLeft, "#go_herocontainer/header/label")
	arg_2_0.btnLeftClose = gohelper.findChildButtonWithAudio(arg_2_0.goLeft, "#go_herocontainer/header/#btn_close")
	arg_2_0.goLeftHeroContent = gohelper.findChild(arg_2_0.goLeft, "#go_herocontainer/Mask/#scroll_hero/Viewport/Content")
	arg_2_0.goHeroItem = gohelper.findChild(arg_2_0.goLeftHeroContent, "#go_heroitem")

	gohelper.setActive(arg_2_0.goHeroItem, false)

	arg_2_0.leftViewShow = false

	arg_2_0.animLeft:Play("close", 0, 1)

	arg_2_0.canvasGroupLeft.blocksRaycasts = false
end

function var_0_0.initRight(arg_3_0)
	arg_3_0.txtTitle = gohelper.findChildTextMesh(arg_3_0.goRight, "#txt_title")
	arg_3_0.goDescNode = gohelper.findChild(arg_3_0.goRight, "descNode")
	arg_3_0.goTalk = gohelper.findChild(arg_3_0.goDescNode, "#go_Talk")
	arg_3_0.animTalk = arg_3_0.goTalk:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0.goUnDispatch = gohelper.findChild(arg_3_0.goDescNode, "#go_UnDispatch")
	arg_3_0.goDispatching = gohelper.findChild(arg_3_0.goDescNode, "#go_Dispatching")
	arg_3_0.goDispatched = gohelper.findChild(arg_3_0.goDescNode, "#go_Dispatched")
	arg_3_0.talkList = {}
	arg_3_0.talkTween = RoleStoryDispatchTalkTween.New()
	arg_3_0.goContent = gohelper.findChild(arg_3_0.goTalk, "Scroll DecView/Viewport/Content")
	arg_3_0.goChatItem = gohelper.findChild(arg_3_0.goContent, "#go_chatitem")

	gohelper.setActive(arg_3_0.goChatItem, false)

	arg_3_0.goArrow = gohelper.findChild(arg_3_0.goTalk, "Scroll DecView/Viewport/arrow")
	arg_3_0.btnArrow = gohelper.getClickWithAudio(arg_3_0.goArrow)
	arg_3_0.goHeroContainer = gohelper.findChild(arg_3_0.goRight, "#go_Herocontainer")
	arg_3_0.txtLabel = gohelper.findChildTextMesh(arg_3_0.goHeroContainer, "label")
	arg_3_0.rightHeroItems = {}
	arg_3_0.goBottom = gohelper.findChild(arg_3_0.goRight, "Bottom")
	arg_3_0.animBottom = arg_3_0.goBottom:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0.goReward = gohelper.findChild(arg_3_0.goBottom, "Reward")
	arg_3_0.txtRewardScore = gohelper.findChildTextMesh(arg_3_0.goReward, "txt/#txt_score")
	arg_3_0.goBtn = gohelper.findChild(arg_3_0.goBottom, "Btn")
	arg_3_0.goDispatch = gohelper.findChild(arg_3_0.goBtn, "#go_dispatch")
	arg_3_0.txtCostTime = gohelper.findChildTextMesh(arg_3_0.goDispatch, "#txt_costtime")
	arg_3_0.txtGreenCostTime = gohelper.findChildTextMesh(arg_3_0.goDispatch, "#txt_costtime_green")
	arg_3_0.btnDispatch = gohelper.findChildButtonWithAudio(arg_3_0.goDispatch, "#btn_dispatch")
	arg_3_0.txtCostNum = gohelper.findChildTextMesh(arg_3_0.goDispatch, "#btn_dispatch/#txt_num")
	arg_3_0.btnCanget = gohelper.findChildButtonWithAudio(arg_3_0.goDispatch, "#btn_finished")
	arg_3_0.goReturn = gohelper.findChild(arg_3_0.goBtn, "#go_return")
	arg_3_0.txtReturnCostTime = gohelper.findChildTextMesh(arg_3_0.goReturn, "#txt_costtime")
	arg_3_0.goReturnUpIcon = gohelper.findChild(arg_3_0.goReturn, "#txt_costtime/upicon")
	arg_3_0.goReturnNormalIcon = gohelper.findChild(arg_3_0.goReturn, "#txt_costtime/normalicon")
	arg_3_0.btnReturn = gohelper.findChildButtonWithAudio(arg_3_0.goReturn, "#btn_return")
	arg_3_0.goFinish = gohelper.findChild(arg_3_0.goBottom, "Finish")
	arg_3_0.txtFinish = gohelper.findChildTextMesh(arg_3_0.goFinish, "#txt_finished")
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnClose, arg_4_0.onClickBtnClose, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnDispatch, arg_4_0.onClickBtnDispatch, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnReturn, arg_4_0.onClickBtnReturn, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnCanget, arg_4_0.onClickBtnCanget, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnLeftClose, arg_4_0.onClickBtnLeftClose, arg_4_0)
	arg_4_0:addClickCb(arg_4_0.btnArrow, arg_4_0.onClickBtnArrow, arg_4_0)
	arg_4_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ClickRightHero, arg_4_0._onClickRightHero, arg_4_0)
	arg_4_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeSelectedHero, arg_4_0._onChangeSelectedHero, arg_4_0)
	arg_4_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, arg_4_0._onDispatchSuccess, arg_4_0)
	arg_4_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, arg_4_0._onDispatchReset, arg_4_0)
	arg_4_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, arg_4_0._onDispatchFinish, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	return
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._onDispatchSuccess(arg_7_0)
	arg_7_0._playTalkTween = false

	arg_7_0:activeLeftView(false)
	arg_7_0:refreshView()
end

function var_0_0._onDispatchReset(arg_8_0)
	arg_8_0._playTalkTween = false

	arg_8_0:activeLeftView(true)
	arg_8_0:refreshView()
end

function var_0_0._onDispatchFinish(arg_9_0)
	arg_9_0._playTalkTween = true
	arg_9_0.dispatchState = RoleStoryEnum.DispatchState.Finish

	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive)
	arg_9_0:playRewardTween()
end

function var_0_0._onChangeSelectedHero(arg_10_0)
	arg_10_0:refreshView()
end

function var_0_0.getDispatchState(arg_11_0)
	return arg_11_0.dispatchState or arg_11_0.dispatchMo:getDispatchState()
end

function var_0_0._onClickRightHero(arg_12_0, arg_12_1)
	if arg_12_0:getDispatchState() == RoleStoryEnum.DispatchState.Normal then
		if not arg_12_1 then
			arg_12_0:activeLeftView(not arg_12_0.leftViewShow)
		else
			RoleStoryDispatchHeroListModel.instance:clickHeroMo(arg_12_1)
		end
	end
end

function var_0_0.onClickBtnArrow(arg_13_0)
	return
end

function var_0_0.onClickBtnLeftClose(arg_14_0)
	arg_14_0:activeLeftView(false)
end

function var_0_0.onClickBtnClose(arg_15_0)
	if arg_15_0.leftViewShow then
		arg_15_0:activeLeftView(false)

		return
	end

	arg_15_0:closeThis()
end

function var_0_0.onClickBtnDispatch(arg_16_0)
	RoleStoryDispatchHeroListModel.instance:sendDispatch()
end

function var_0_0.onClickBtnReturn(arg_17_0)
	RoleStoryDispatchHeroListModel.instance:sendReset()
end

function var_0_0.onClickBtnCanget(arg_18_0)
	RoleStoryDispatchHeroListModel.instance:sendGetReward()
end

function var_0_0.onOpen(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_open)

	arg_19_0.dispatchId = arg_19_0.viewParam.dispatchId
	arg_19_0.storyId = arg_19_0.viewParam.storyId

	arg_19_0:refreshData()
	arg_19_0:refreshView()
	TaskDispatcher.runDelay(arg_19_0.talkMoveLast, arg_19_0, 0.1)
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0.dispatchId = arg_20_0.viewParam.dispatchId
	arg_20_0.storyId = arg_20_0.viewParam.storyId

	arg_20_0:refreshData()
	arg_20_0:refreshView()
end

function var_0_0.refreshData(arg_21_0)
	arg_21_0.storyMo = RoleStoryModel.instance:getById(arg_21_0.storyId)
	arg_21_0.dispatchMo = arg_21_0.storyMo:getDispatchMo(arg_21_0.dispatchId)
	arg_21_0.config = arg_21_0.dispatchMo.config

	RoleStoryDispatchHeroListModel.instance:onOpenDispatchView(arg_21_0.storyMo, arg_21_0.dispatchMo)
	RoleStoryDispatchHeroListModel.instance:initSelectedHeroList(arg_21_0.dispatchMo.heroIds)
end

function var_0_0.refreshView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.updateDispatchTime, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.playFinishTween, arg_22_0)
	arg_22_0:refreshLeft()
	arg_22_0:refreshRight()
end

function var_0_0.refreshLeft(arg_23_0)
	if not arg_23_0.leftViewShow then
		return
	end

	RoleStoryDispatchHeroListModel.instance:refreshHero()

	arg_23_0.txtLeftLable.text = formatLuaLang("rolestorydispatchcounttips", arg_23_0.config.count)
end

function var_0_0.refreshRight(arg_24_0)
	arg_24_0.txtTitle.text = arg_24_0.config.name

	arg_24_0:refreshDesc()
	arg_24_0:refreshTalk(arg_24_0._playTalkTween)

	arg_24_0._playTalkTween = false

	arg_24_0:refreshRightHeroContainer()
	arg_24_0:refreshRightBottom()
end

function var_0_0.refreshDesc(arg_25_0)
	local var_25_0 = recthelper.getHeight(arg_25_0.goDescNode.transform)

	recthelper.setHeight(arg_25_0.goTalk.transform, var_25_0)
end

function var_0_0.refreshRightBottom(arg_26_0)
	local var_26_0 = arg_26_0:getDispatchState()
	local var_26_1 = var_26_0 == RoleStoryEnum.DispatchState.Finish

	gohelper.setActive(arg_26_0.goFinish, var_26_1)
	gohelper.setActive(arg_26_0.goReward, not var_26_1)
	gohelper.setActive(arg_26_0.goBtn, not var_26_1)

	arg_26_0.txtFinish.text = arg_26_0.config.completeDesc

	if not var_26_1 then
		local var_26_2 = RoleStoryDispatchHeroListModel.instance:getDispatchHeros()
		local var_26_3 = {}

		for iter_26_0, iter_26_1 in ipairs(var_26_2) do
			table.insert(var_26_3, iter_26_1.heroId)
		end

		local var_26_4 = arg_26_0.dispatchMo:checkHerosMeetEffectCondition(var_26_3)
		local var_26_5 = arg_26_0.dispatchMo:getEffectAddRewardCount()
		local var_26_6 = arg_26_0.config.scoreReward

		if var_26_4 and var_26_5 > 0 then
			arg_26_0.txtRewardScore.text = string.format("%s<#C66030>(+%s)</color>", var_26_6, var_26_5)
		else
			arg_26_0.txtRewardScore.text = var_26_6
		end

		local var_26_7 = var_26_0 == RoleStoryEnum.DispatchState.Dispatching
		local var_26_8 = var_26_0 == RoleStoryEnum.DispatchState.Normal
		local var_26_9 = var_26_0 == RoleStoryEnum.DispatchState.Canget

		gohelper.setActive(arg_26_0.goReturn, var_26_7)
		gohelper.setActive(arg_26_0.goDispatch, var_26_8 or var_26_9)
		gohelper.setActive(arg_26_0.btnCanget, var_26_9)
		gohelper.setActive(arg_26_0.btnDispatch, var_26_8)

		if var_26_7 then
			gohelper.setActive(arg_26_0.goReturnUpIcon, var_26_4)
			gohelper.setActive(arg_26_0.goReturnNormalIcon, not var_26_4)

			arg_26_0.dispatchEndTime = arg_26_0.dispatchMo.endTime

			arg_26_0:updateDispatchTime()
			TaskDispatcher.cancelTask(arg_26_0.updateDispatchTime, arg_26_0)
			TaskDispatcher.runRepeat(arg_26_0.updateDispatchTime, arg_26_0, 1)
		end

		if var_26_8 then
			local var_26_10 = string.splitToNumber(arg_26_0.config.consume, "#")
			local var_26_11 = var_26_10[3]
			local var_26_12 = var_26_11 <= ItemModel.instance:getItemQuantity(var_26_10[1], var_26_10[2])

			arg_26_0.txtCostNum.text = var_26_12 and string.format("-%s", var_26_11) or string.format("<color=#BF2E11>-%s</color>", var_26_11)

			local var_26_13 = arg_26_0.dispatchMo:getEffectDelTimeCount()
			local var_26_14 = var_26_4 and var_26_13 > 0
			local var_26_15 = arg_26_0.config.time

			gohelper.setActive(arg_26_0.txtGreenCostTime, var_26_14)
			gohelper.setActive(arg_26_0.txtCostTime, not var_26_14)

			if var_26_14 then
				arg_26_0.txtGreenCostTime.text = TimeUtil.second2TimeString(var_26_15 - var_26_13, true)
			else
				arg_26_0.txtCostTime.text = TimeUtil.second2TimeString(var_26_15, true)
			end

			local var_26_16 = RoleStoryDispatchHeroListModel.instance:isEnoughHeroCount()

			ZProj.UGUIHelper.SetGrayscale(arg_26_0.btnDispatch.gameObject, not var_26_16)
		end

		if var_26_9 then
			gohelper.setActive(arg_26_0.txtCostTime, false)
			gohelper.setActive(arg_26_0.txtGreenCostTime, false)
		end
	end
end

function var_0_0.updateDispatchTime(arg_27_0)
	local var_27_0 = arg_27_0.dispatchEndTime * 0.001 - ServerTime.now()

	if var_27_0 < 0 then
		arg_27_0:refreshView()

		return
	end

	arg_27_0.txtReturnCostTime.text = TimeUtil.second2TimeString(var_27_0, true)
end

function var_0_0.refreshRightHeroContainer(arg_28_0)
	arg_28_0.txtLabel.text = arg_28_0.config.effectDesc

	local var_28_0 = RoleStoryDispatchHeroListModel.instance:getDispatchHeros()

	for iter_28_0 = 1, 4 do
		arg_28_0:refreshRightHeroItem(arg_28_0.rightHeroItems[iter_28_0], var_28_0[iter_28_0], iter_28_0)
	end
end

function var_0_0.refreshRightHeroItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_1 = arg_29_1 or arg_29_0:createRightHeroItem(arg_29_3)

	arg_29_1:onUpdateMO(arg_29_2, arg_29_3, arg_29_0.config.count)
end

function var_0_0.createRightHeroItem(arg_30_0, arg_30_1)
	local var_30_0 = gohelper.findChild(arg_30_0.goHeroContainer, string.format("herocontainer/go_selectheroitem%s", arg_30_1))
	local var_30_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_30_0, RoleStoryDispatchRightHeroItem)

	arg_30_0.rightHeroItems[arg_30_1] = var_30_1

	return var_30_1
end

function var_0_0.refreshTalk(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getDispatchState()

	gohelper.setActive(arg_31_0.goUnDispatch, var_31_0 == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(arg_31_0.goDispatching, var_31_0 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(arg_31_0.goDispatched, var_31_0 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(arg_31_0.goTalk, var_31_0 == RoleStoryEnum.DispatchState.Finish)

	if var_31_0 ~= RoleStoryEnum.DispatchState.Finish then
		for iter_31_0, iter_31_1 in ipairs(arg_31_0.talkList) do
			iter_31_1:onUpdateMO()
		end

		arg_31_0.talkTween:clearTween()

		return
	end

	local var_31_1 = string.splitToNumber(arg_31_0.config.talkIds, "#")

	arg_31_0:refreshTalkList(var_31_1, arg_31_1)

	if arg_31_1 then
		arg_31_0.animTalk:Play("open")
		arg_31_0.talkTween:playTalkTween(arg_31_0.talkList)
	else
		arg_31_0.talkTween:clearTween()
	end
end

function var_0_0.talkMoveLast(arg_32_0)
	if arg_32_0:getDispatchState() == RoleStoryEnum.DispatchState.Normal then
		return
	end

	local var_32_0 = arg_32_0.goContent.transform
	local var_32_1 = recthelper.getHeight(var_32_0.parent)
	local var_32_2 = recthelper.getHeight(var_32_0)
	local var_32_3 = math.max(var_32_2 - var_32_1, 0)

	recthelper.setAnchorY(var_32_0, var_32_3)
end

function var_0_0.refreshTalkList(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_1 = RoleStoryConfig.instance:getTalkConfig(iter_33_1)

		if RoleStoryDispatchHeroListModel.instance:canShowTalk(var_33_1) then
			table.insert(var_33_0, var_33_1)
		end
	end

	for iter_33_2 = 1, math.max(#var_33_0, #arg_33_0.talkList) do
		arg_33_0:refreshTalkItem(arg_33_0.talkList[iter_33_2], var_33_0[iter_33_2], iter_33_2)
	end
end

function var_0_0.refreshTalkItem(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_1 = arg_34_1 or arg_34_0:createTalkItem(arg_34_3)

	arg_34_1:onUpdateMO(arg_34_2, arg_34_3)
end

function var_0_0.createTalkItem(arg_35_0, arg_35_1)
	local var_35_0 = gohelper.clone(arg_35_0.goChatItem, arg_35_0.goContent, string.format("go%s", arg_35_1))
	local var_35_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_35_0, RoleStoryDispatchTalkItem)

	arg_35_0.talkList[arg_35_1] = var_35_1

	return var_35_1
end

function var_0_0.activeLeftView(arg_36_0, arg_36_1)
	if arg_36_0.leftViewShow == arg_36_1 then
		return
	end

	arg_36_0.leftViewShow = arg_36_1
	arg_36_0.canvasGroupLeft.blocksRaycasts = arg_36_1

	if arg_36_1 then
		arg_36_0.animLeft:Play("open")
		arg_36_0.animRight:Play("switch1")
		arg_36_0:refreshLeft()
	else
		arg_36_0.animLeft:Play("close")
		arg_36_0.animRight:Play("switch2")
	end
end

function var_0_0.playRewardTween(arg_37_0)
	arg_37_0.animBottom:Play("reward")
	gohelper.setActive(arg_37_0.goreward, false)
	gohelper.setActive(arg_37_0.goreward, true)
	TaskDispatcher.runDelay(arg_37_0.playFinishTween, arg_37_0, 1.66)
end

function var_0_0.playFinishTween(arg_38_0)
	gohelper.setActive(arg_38_0.goFinish, true)
	arg_38_0.animBottom:Play("finish")
	TaskDispatcher.runDelay(arg_38_0.refreshView, arg_38_0, 0.23)
end

function var_0_0.onClose(arg_39_0)
	return
end

function var_0_0.onDestroyView(arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.talkMoveLast, arg_40_0)
	RoleStoryDispatchHeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(arg_40_0.updateDispatchTime, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.playFinishTween, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.refreshView, arg_40_0)

	if arg_40_0.talkTween then
		arg_40_0.talkTween:destroy()
	end
end

return var_0_0
