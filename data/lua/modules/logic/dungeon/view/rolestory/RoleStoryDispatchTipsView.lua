module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsView", package.seeall)

slot0 = class("RoleStoryDispatchTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0.goLeft = gohelper.findChild(slot0.viewGO, "Layout/left")

	gohelper.setActive(slot0.goLeft, true)

	slot0.goRight = gohelper.findChild(slot0.viewGO, "Layout/right")
	slot0.animLeft = slot0.goLeft:GetComponent(typeof(UnityEngine.Animator))
	slot0.canvasGroupLeft = slot0.goLeft:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0.animRight = slot0.goRight:GetComponent(typeof(UnityEngine.Animator))

	slot0:initLeft()
	slot0:initRight()

	slot0.goreward = gohelper.findChild(slot0.viewGO, "#btn_scorereward")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.initLeft(slot0)
	slot0.txtLeftLable = gohelper.findChildTextMesh(slot0.goLeft, "#go_herocontainer/header/label")
	slot0.btnLeftClose = gohelper.findChildButtonWithAudio(slot0.goLeft, "#go_herocontainer/header/#btn_close")
	slot0.goLeftHeroContent = gohelper.findChild(slot0.goLeft, "#go_herocontainer/Mask/#scroll_hero/Viewport/Content")
	slot0.goHeroItem = gohelper.findChild(slot0.goLeftHeroContent, "#go_heroitem")

	gohelper.setActive(slot0.goHeroItem, false)

	slot0.leftViewShow = false

	slot0.animLeft:Play("close", 0, 1)

	slot0.canvasGroupLeft.blocksRaycasts = false
end

function slot0.initRight(slot0)
	slot0.txtTitle = gohelper.findChildTextMesh(slot0.goRight, "#txt_title")
	slot0.goDescNode = gohelper.findChild(slot0.goRight, "descNode")
	slot0.goTalk = gohelper.findChild(slot0.goDescNode, "#go_Talk")
	slot0.animTalk = slot0.goTalk:GetComponent(typeof(UnityEngine.Animator))
	slot0.goUnDispatch = gohelper.findChild(slot0.goDescNode, "#go_UnDispatch")
	slot0.goDispatching = gohelper.findChild(slot0.goDescNode, "#go_Dispatching")
	slot0.goDispatched = gohelper.findChild(slot0.goDescNode, "#go_Dispatched")
	slot0.talkList = {}
	slot0.talkTween = RoleStoryDispatchTalkTween.New()
	slot0.goContent = gohelper.findChild(slot0.goTalk, "Scroll DecView/Viewport/Content")
	slot0.goChatItem = gohelper.findChild(slot0.goContent, "#go_chatitem")

	gohelper.setActive(slot0.goChatItem, false)

	slot0.goArrow = gohelper.findChild(slot0.goTalk, "Scroll DecView/Viewport/arrow")
	slot0.btnArrow = gohelper.getClickWithAudio(slot0.goArrow)
	slot0.goHeroContainer = gohelper.findChild(slot0.goRight, "#go_Herocontainer")
	slot0.txtLabel = gohelper.findChildTextMesh(slot0.goHeroContainer, "label")
	slot0.rightHeroItems = {}
	slot0.goBottom = gohelper.findChild(slot0.goRight, "Bottom")
	slot0.animBottom = slot0.goBottom:GetComponent(typeof(UnityEngine.Animator))
	slot0.goReward = gohelper.findChild(slot0.goBottom, "Reward")
	slot0.txtRewardScore = gohelper.findChildTextMesh(slot0.goReward, "txt/#txt_score")
	slot0.goBtn = gohelper.findChild(slot0.goBottom, "Btn")
	slot0.goDispatch = gohelper.findChild(slot0.goBtn, "#go_dispatch")
	slot0.txtCostTime = gohelper.findChildTextMesh(slot0.goDispatch, "#txt_costtime")
	slot0.txtGreenCostTime = gohelper.findChildTextMesh(slot0.goDispatch, "#txt_costtime_green")
	slot0.btnDispatch = gohelper.findChildButtonWithAudio(slot0.goDispatch, "#btn_dispatch")
	slot0.txtCostNum = gohelper.findChildTextMesh(slot0.goDispatch, "#btn_dispatch/#txt_num")
	slot0.btnCanget = gohelper.findChildButtonWithAudio(slot0.goDispatch, "#btn_finished")
	slot0.goReturn = gohelper.findChild(slot0.goBtn, "#go_return")
	slot0.txtReturnCostTime = gohelper.findChildTextMesh(slot0.goReturn, "#txt_costtime")
	slot0.goReturnUpIcon = gohelper.findChild(slot0.goReturn, "#txt_costtime/upicon")
	slot0.goReturnNormalIcon = gohelper.findChild(slot0.goReturn, "#txt_costtime/normalicon")
	slot0.btnReturn = gohelper.findChildButtonWithAudio(slot0.goReturn, "#btn_return")
	slot0.goFinish = gohelper.findChild(slot0.goBottom, "Finish")
	slot0.txtFinish = gohelper.findChildTextMesh(slot0.goFinish, "#txt_finished")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addClickCb(slot0.btnDispatch, slot0.onClickBtnDispatch, slot0)
	slot0:addClickCb(slot0.btnReturn, slot0.onClickBtnReturn, slot0)
	slot0:addClickCb(slot0.btnCanget, slot0.onClickBtnCanget, slot0)
	slot0:addClickCb(slot0.btnLeftClose, slot0.onClickBtnLeftClose, slot0)
	slot0:addClickCb(slot0.btnArrow, slot0.onClickBtnArrow, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ClickRightHero, slot0._onClickRightHero, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeSelectedHero, slot0._onChangeSelectedHero, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchSuccess, slot0._onDispatchSuccess, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchReset, slot0._onDispatchReset, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.DispatchFinish, slot0._onDispatchFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._onDispatchSuccess(slot0)
	slot0._playTalkTween = false

	slot0:activeLeftView(false)
	slot0:refreshView()
end

function slot0._onDispatchReset(slot0)
	slot0._playTalkTween = false

	slot0:activeLeftView(true)
	slot0:refreshView()
end

function slot0._onDispatchFinish(slot0)
	slot0._playTalkTween = true
	slot0.dispatchState = RoleStoryEnum.DispatchState.Finish

	AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_receive)
	slot0:playRewardTween()
end

function slot0._onChangeSelectedHero(slot0)
	slot0:refreshView()
end

function slot0.getDispatchState(slot0)
	return slot0.dispatchState or slot0.dispatchMo:getDispatchState()
end

function slot0._onClickRightHero(slot0, slot1)
	if slot0:getDispatchState() == RoleStoryEnum.DispatchState.Normal then
		if not slot1 then
			slot0:activeLeftView(not slot0.leftViewShow)
		else
			RoleStoryDispatchHeroListModel.instance:clickHeroMo(slot1)
		end
	end
end

function slot0.onClickBtnArrow(slot0)
end

function slot0.onClickBtnLeftClose(slot0)
	slot0:activeLeftView(false)
end

function slot0.onClickBtnClose(slot0)
	if slot0.leftViewShow then
		slot0:activeLeftView(false)

		return
	end

	slot0:closeThis()
end

function slot0.onClickBtnDispatch(slot0)
	RoleStoryDispatchHeroListModel.instance:sendDispatch()
end

function slot0.onClickBtnReturn(slot0)
	RoleStoryDispatchHeroListModel.instance:sendReset()
end

function slot0.onClickBtnCanget(slot0)
	RoleStoryDispatchHeroListModel.instance:sendGetReward()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_open)

	slot0.dispatchId = slot0.viewParam.dispatchId
	slot0.storyId = slot0.viewParam.storyId

	slot0:refreshData()
	slot0:refreshView()
	TaskDispatcher.runDelay(slot0.talkMoveLast, slot0, 0.1)
end

function slot0.onUpdateParam(slot0)
	slot0.dispatchId = slot0.viewParam.dispatchId
	slot0.storyId = slot0.viewParam.storyId

	slot0:refreshData()
	slot0:refreshView()
end

function slot0.refreshData(slot0)
	slot0.storyMo = RoleStoryModel.instance:getById(slot0.storyId)
	slot0.dispatchMo = slot0.storyMo:getDispatchMo(slot0.dispatchId)
	slot0.config = slot0.dispatchMo.config

	RoleStoryDispatchHeroListModel.instance:onOpenDispatchView(slot0.storyMo, slot0.dispatchMo)
	RoleStoryDispatchHeroListModel.instance:initSelectedHeroList(slot0.dispatchMo.heroIds)
end

function slot0.refreshView(slot0)
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)
	TaskDispatcher.cancelTask(slot0.playFinishTween, slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	if not slot0.leftViewShow then
		return
	end

	RoleStoryDispatchHeroListModel.instance:refreshHero()

	slot0.txtLeftLable.text = formatLuaLang("rolestorydispatchcounttips", slot0.config.count)
end

function slot0.refreshRight(slot0)
	slot0.txtTitle.text = slot0.config.name

	slot0:refreshDesc()
	slot0:refreshTalk(slot0._playTalkTween)

	slot0._playTalkTween = false

	slot0:refreshRightHeroContainer()
	slot0:refreshRightBottom()
end

function slot0.refreshDesc(slot0)
	recthelper.setHeight(slot0.goTalk.transform, recthelper.getHeight(slot0.goDescNode.transform))
end

function slot0.refreshRightBottom(slot0)
	slot2 = slot0:getDispatchState() == RoleStoryEnum.DispatchState.Finish

	gohelper.setActive(slot0.goFinish, slot2)
	gohelper.setActive(slot0.goReward, not slot2)
	gohelper.setActive(slot0.goBtn, not slot2)

	slot0.txtFinish.text = slot0.config.completeDesc

	if not slot2 then
		slot4 = {}

		for slot8, slot9 in ipairs(RoleStoryDispatchHeroListModel.instance:getDispatchHeros()) do
			table.insert(slot4, slot9.heroId)
		end

		slot6 = slot0.dispatchMo:getEffectAddRewardCount()

		if slot0.dispatchMo:checkHerosMeetEffectCondition(slot4) and slot6 > 0 then
			slot0.txtRewardScore.text = string.format("%s<#C66030>(+%s)</color>", slot0.config.scoreReward, slot6)
		else
			slot0.txtRewardScore.text = slot7
		end

		slot8 = slot1 == RoleStoryEnum.DispatchState.Dispatching
		slot9 = slot1 == RoleStoryEnum.DispatchState.Normal
		slot10 = slot1 == RoleStoryEnum.DispatchState.Canget

		gohelper.setActive(slot0.goReturn, slot8)
		gohelper.setActive(slot0.goDispatch, slot9 or slot10)
		gohelper.setActive(slot0.btnCanget, slot10)
		gohelper.setActive(slot0.btnDispatch, slot9)

		if slot8 then
			gohelper.setActive(slot0.goReturnUpIcon, slot5)
			gohelper.setActive(slot0.goReturnNormalIcon, not slot5)

			slot0.dispatchEndTime = slot0.dispatchMo.endTime

			slot0:updateDispatchTime()
			TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)
			TaskDispatcher.runRepeat(slot0.updateDispatchTime, slot0, 1)
		end

		if slot9 then
			slot11 = string.splitToNumber(slot0.config.consume, "#")
			slot0.txtCostNum.text = slot11[3] <= ItemModel.instance:getItemQuantity(slot11[1], slot11[2]) and string.format("-%s", slot12) or string.format("<color=#BF2E11>-%s</color>", slot12)
			slot16 = slot5 and slot0.dispatchMo:getEffectDelTimeCount() > 0

			gohelper.setActive(slot0.txtGreenCostTime, slot16)
			gohelper.setActive(slot0.txtCostTime, not slot16)

			if slot16 then
				slot0.txtGreenCostTime.text = TimeUtil.second2TimeString(slot0.config.time - slot15, true)
			else
				slot0.txtCostTime.text = TimeUtil.second2TimeString(slot17, true)
			end

			ZProj.UGUIHelper.SetGrayscale(slot0.btnDispatch.gameObject, not RoleStoryDispatchHeroListModel.instance:isEnoughHeroCount())
		end

		if slot10 then
			gohelper.setActive(slot0.txtCostTime, false)
			gohelper.setActive(slot0.txtGreenCostTime, false)
		end
	end
end

function slot0.updateDispatchTime(slot0)
	if slot0.dispatchEndTime * 0.001 - ServerTime.now() < 0 then
		slot0:refreshView()

		return
	end

	slot0.txtReturnCostTime.text = TimeUtil.second2TimeString(slot1, true)
end

function slot0.refreshRightHeroContainer(slot0)
	slot0.txtLabel.text = slot0.config.effectDesc

	for slot5 = 1, 4 do
		slot0:refreshRightHeroItem(slot0.rightHeroItems[slot5], RoleStoryDispatchHeroListModel.instance:getDispatchHeros()[slot5], slot5)
	end
end

function slot0.refreshRightHeroItem(slot0, slot1, slot2, slot3)
	(slot1 or slot0:createRightHeroItem(slot3)):onUpdateMO(slot2, slot3, slot0.config.count)
end

function slot0.createRightHeroItem(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.goHeroContainer, string.format("herocontainer/go_selectheroitem%s", slot1)), RoleStoryDispatchRightHeroItem)
	slot0.rightHeroItems[slot1] = slot3

	return slot3
end

function slot0.refreshTalk(slot0, slot1)
	gohelper.setActive(slot0.goUnDispatch, slot0:getDispatchState() == RoleStoryEnum.DispatchState.Normal)
	gohelper.setActive(slot0.goDispatching, slot2 == RoleStoryEnum.DispatchState.Dispatching)
	gohelper.setActive(slot0.goDispatched, slot2 == RoleStoryEnum.DispatchState.Canget)
	gohelper.setActive(slot0.goTalk, slot2 == RoleStoryEnum.DispatchState.Finish)

	if slot2 ~= RoleStoryEnum.DispatchState.Finish then
		for slot6, slot7 in ipairs(slot0.talkList) do
			slot7:onUpdateMO()
		end

		slot0.talkTween:clearTween()

		return
	end

	slot0:refreshTalkList(string.splitToNumber(slot0.config.talkIds, "#"), slot1)

	if slot1 then
		slot0.animTalk:Play("open")
		slot0.talkTween:playTalkTween(slot0.talkList)
	else
		slot0.talkTween:clearTween()
	end
end

function slot0.talkMoveLast(slot0)
	if slot0:getDispatchState() == RoleStoryEnum.DispatchState.Normal then
		return
	end

	slot2 = slot0.goContent.transform

	recthelper.setAnchorY(slot2, math.max(recthelper.getHeight(slot2) - recthelper.getHeight(slot2.parent), 0))
end

function slot0.refreshTalkList(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if RoleStoryDispatchHeroListModel.instance:canShowTalk(RoleStoryConfig.instance:getTalkConfig(slot8)) then
			table.insert(slot3, slot9)
		end
	end

	slot7 = #slot0.talkList

	for slot7 = 1, math.max(#slot3, slot7) do
		slot0:refreshTalkItem(slot0.talkList[slot7], slot3[slot7], slot7)
	end
end

function slot0.refreshTalkItem(slot0, slot1, slot2, slot3)
	(slot1 or slot0:createTalkItem(slot3)):onUpdateMO(slot2, slot3)
end

function slot0.createTalkItem(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0.goChatItem, slot0.goContent, string.format("go%s", slot1)), RoleStoryDispatchTalkItem)
	slot0.talkList[slot1] = slot3

	return slot3
end

function slot0.activeLeftView(slot0, slot1)
	if slot0.leftViewShow == slot1 then
		return
	end

	slot0.leftViewShow = slot1
	slot0.canvasGroupLeft.blocksRaycasts = slot1

	if slot1 then
		slot0.animLeft:Play("open")
		slot0.animRight:Play("switch1")
		slot0:refreshLeft()
	else
		slot0.animLeft:Play("close")
		slot0.animRight:Play("switch2")
	end
end

function slot0.playRewardTween(slot0)
	slot0.animBottom:Play("reward")
	gohelper.setActive(slot0.goreward, false)
	gohelper.setActive(slot0.goreward, true)
	TaskDispatcher.runDelay(slot0.playFinishTween, slot0, 1.66)
end

function slot0.playFinishTween(slot0)
	gohelper.setActive(slot0.goFinish, true)
	slot0.animBottom:Play("finish")
	TaskDispatcher.runDelay(slot0.refreshView, slot0, 0.23)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.talkMoveLast, slot0)
	RoleStoryDispatchHeroListModel.instance:onCloseDispatchView()
	TaskDispatcher.cancelTask(slot0.updateDispatchTime, slot0)
	TaskDispatcher.cancelTask(slot0.playFinishTween, slot0)
	TaskDispatcher.cancelTask(slot0.refreshView, slot0)

	if slot0.talkTween then
		slot0.talkTween:destroy()
	end
end

return slot0
