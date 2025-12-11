module("modules.logic.tower.view.permanenttower.TowerPermanentDeepView", package.seeall)

local var_0_0 = class("TowerPermanentDeepView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_category")
	arg_1_0._godeepLayer = gohelper.findChild(arg_1_0.viewGO, "Left/#go_deepLayer")
	arg_1_0._godeepLayerReddot = gohelper.findChild(arg_1_0.viewGO, "Left/#go_deepLayer/#go_deepLayerReddot")
	arg_1_0._gobossNormal = gohelper.findChild(arg_1_0.viewGO, "#go_deep/#go_bossNormal")
	arg_1_0._gobossEndless = gohelper.findChild(arg_1_0.viewGO, "#go_deep/#go_bossEndless")
	arg_1_0._txtbestDeepRecord = gohelper.findChildText(arg_1_0.viewGO, "#go_deep/deepRecord/#txt_bestDeepRecord")
	arg_1_0._gonormalFightBg = gohelper.findChild(arg_1_0.viewGO, "#go_deep/deepFight/#go_normalFightBg")
	arg_1_0._goendlessFightBg = gohelper.findChild(arg_1_0.viewGO, "#go_deep/deepFight/#go_endlessFightBg")
	arg_1_0._gocurDeepRecord = gohelper.findChild(arg_1_0.viewGO, "#go_deep/deepFight/#go_curDeepRecord")
	arg_1_0._txtcurDeepRecord = gohelper.findChildText(arg_1_0.viewGO, "#go_deep/deepFight/#go_curDeepRecord/#txt_curDeepRecord")
	arg_1_0._txtdeepFightName = gohelper.findChildText(arg_1_0.viewGO, "#go_deep/deepFight/#txt_deepFightName")
	arg_1_0._btndeepFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_deep/deepFight/#btn_deepFight")
	arg_1_0._btnresetDeep = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_deep/deepFight/#btn_resetDeep")
	arg_1_0._btndeepTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_deep/#btn_deepTask")
	arg_1_0._godeepTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#go_deep/#btn_deepTask/#go_deepTaskReddot")
	arg_1_0._goEnterDeepGuide = gohelper.findChild(arg_1_0.viewGO, "#go_EnterDeepGuide")
	arg_1_0._goDeepSuccReward = gohelper.findChild(arg_1_0.viewGO, "#go_DeepSuccReward")
	arg_1_0._btnDeepSuccReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_DeepSuccReward/#btn_deepSuccReward")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnresetDeep:AddClickListener(arg_2_0._btnresetDeepOnClick, arg_2_0)
	arg_2_0._btndeepTask:AddClickListener(arg_2_0._btndeepTaskOnClick, arg_2_0)
	arg_2_0._btndeepFight:AddClickListener(arg_2_0._btndeepFightOnClick, arg_2_0)
	arg_2_0._btnDeepSuccReward:AddClickListener(arg_2_0._btnDeepSuccRewardOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerDeepReset, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_2_0.checkDeepSuccRewardGet, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_2_0.refreshTaskStateAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnresetDeep:RemoveClickListener()
	arg_3_0._btndeepTask:RemoveClickListener()
	arg_3_0._btndeepFight:RemoveClickListener()
	arg_3_0._btnDeepSuccReward:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerDeepReset, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_3_0.checkDeepSuccRewardGet, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, arg_3_0.refreshTaskStateAnim, arg_3_0)
end

function var_0_0._btnresetDeepOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TowerDeepReset, MsgBoxEnum.BoxType.Yes_No, arg_4_0.sendTowerDeepResetRequest, nil, nil, arg_4_0)
end

function var_0_0.sendTowerDeepResetRequest(arg_5_0)
	TowerDeepRpc.instance:sendTowerDeepResetRequest()
end

function var_0_0._btndeepTaskOnClick(arg_6_0)
	TowerController.instance:openTowerDeepTaskView()
end

function var_0_0._btndeepFightOnClick(arg_7_0)
	local var_7_0 = {
		towerType = TowerEnum.TowerType.Normal,
		towerId = TowerEnum.PermanentTowerId
	}

	var_7_0.layerId = 0
	var_7_0.episodeId = arg_7_0.curEpisodeId

	TowerController.instance:enterFight(var_7_0)
end

function var_0_0._btnDeepSuccRewardOnClick(arg_8_0)
	if TowerDeepTaskModel.instance:isTaskCanGet(arg_8_0.succDeepTaskMo) then
		TaskRpc.instance:sendFinishTaskRequest(arg_8_0.succDeepTaskMo.id)
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.rectScrollCategory = arg_9_0._scrollcategory:GetComponent(gohelper.Type_RectTransform)
	arg_9_0.normalDeepEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.NormalDeepEpisodeId)
	arg_9_0.endlessDeepEpisodeId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.EndlessDeepEpisodeId)
	arg_9_0.deepFightAnim = gohelper.findChildComponent(arg_9_0.viewGO, "#go_deep/deepFight", gohelper.Type_Animation)
	arg_9_0.enterDeepGuideAnim = arg_9_0._goEnterDeepGuide:GetComponent(gohelper.Type_Animator)
	arg_9_0.deepSuccRewardAnim = arg_9_0._goDeepSuccReward:GetComponent(gohelper.Type_Animator)
	arg_9_0.deepTaskAnim = gohelper.findChildComponent(arg_9_0.viewGO, "#go_deep/#btn_deepTask/ani", gohelper.Type_Animator)
	arg_9_0.deepRecordLineAnim = gohelper.findChildComponent(arg_9_0.viewGO, "#go_deep/deepRecord/ani_line", gohelper.Type_Animation)
	arg_9_0.deepRecordSwitchAnim = gohelper.findChildComponent(arg_9_0.viewGO, "#go_deep/deepRecord/#ani_switch", gohelper.Type_Animation)

	gohelper.setActive(arg_9_0._goEnterDeepGuide, false)
	gohelper.setActive(arg_9_0._goDeepSuccReward, false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	RedDotController.instance:addRedDot(arg_11_0._godeepLayerReddot, RedDotEnum.DotNode.TowerDeepTask)
	RedDotController.instance:addRedDot(arg_11_0._godeepTaskReddot, RedDotEnum.DotNode.TowerDeepTask)

	arg_11_0.jumpParam = arg_11_0.viewParam or {}

	arg_11_0:refreshCategory()
	arg_11_0:refreshUI()
	arg_11_0:checkDeepSuccRewardGet()
	arg_11_0:refreshTaskStateAnim()

	if not arg_11_0.hasSuccReward then
		TaskDispatcher.runDelay(arg_11_0.showDeepRecordChange, arg_11_0, 1.5)
	end

	arg_11_0.curTaskRewardHasGet = TowerDeepTaskModel.instance:isSuccRewardHasGet()
end

function var_0_0.refreshCategory(arg_12_0)
	arg_12_0.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

	recthelper.setHeight(arg_12_0.rectScrollCategory, arg_12_0.isDeepLayerUnlock and TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH)

	if arg_12_0.jumpParam and arg_12_0.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		gohelper.setActive(arg_12_0._godeepLayer, false)
	else
		gohelper.setActive(arg_12_0._godeepLayer, arg_12_0.isDeepLayerUnlock)
	end
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0.maxDeepHigh = TowerPermanentDeepModel.instance:getLastMaxDeepHigh()
	arg_13_0._txtbestDeepRecord.text = string.format("%dM", arg_13_0.maxDeepHigh)
	arg_13_0.isOpenEndless = TowerPermanentDeepModel.instance.isOpenEndless

	gohelper.setActive(arg_13_0._gonormalFightBg, not arg_13_0.isOpenEndless)
	gohelper.setActive(arg_13_0._goendlessFightBg, arg_13_0.isOpenEndless)
	gohelper.setActive(arg_13_0._gobossNormal, not arg_13_0.isOpenEndless)
	gohelper.setActive(arg_13_0._gobossEndless, arg_13_0.isOpenEndless)

	arg_13_0.curDeepHigh = TowerPermanentDeepModel.instance:getCurDeepHigh()
	arg_13_0._txtcurDeepRecord.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("TowerDeep_curDeepHigh"), arg_13_0.curDeepHigh)
	arg_13_0.curDeepGroupMo = TowerPermanentDeepModel.instance:getCurDeepGroupMo()

	local var_13_0 = arg_13_0.curDeepGroupMo and arg_13_0.curDeepGroupMo:checkHasTeamData()

	if arg_13_0.isOpenEndless then
		arg_13_0._txtdeepFightName.text = var_13_0 and luaLang("TowerDeep_endlessFight") or luaLang("TowerDeep_endlessNotFight")
	else
		arg_13_0._txtdeepFightName.text = var_13_0 and luaLang("TowerDeep_normalFight") or luaLang("TowerDeep_normalNotFight")
	end

	gohelper.setActive(arg_13_0._btnresetDeep.gameObject, var_13_0)
	gohelper.setActive(arg_13_0._gocurDeepRecord, var_13_0)

	arg_13_0.curEpisodeId = arg_13_0.isOpenEndless and arg_13_0.endlessDeepEpisodeId or arg_13_0.normalDeepEpisodeId
end

function var_0_0.refreshTaskStateAnim(arg_14_0)
	local var_14_0 = TowerDeepTaskModel.instance:getAllCanGetList()

	arg_14_0.deepTaskAnim:Play(#var_14_0 > 0 and "loop" or "idle", 0, 0)
	arg_14_0.deepTaskAnim:Update(0)
end

function var_0_0.showDeepRecordChange(arg_15_0)
	local var_15_0 = TowerPermanentDeepModel.instance:getLastMaxDeepHigh()

	arg_15_0.curMaxDeepHigh = TowerPermanentDeepModel.instance:getCurMaxDeepHigh()

	if var_15_0 == arg_15_0.curMaxDeepHigh then
		return
	end

	arg_15_0.deepRecordLineAnim:Play()
	arg_15_0.deepRecordSwitchAnim:Play()

	arg_15_0.deepRecordTweenId = ZProj.TweenHelper.DOTweenFloat(var_15_0, arg_15_0.curMaxDeepHigh, 0.5, arg_15_0.onDeepRecordFrameCallback, arg_15_0.onDeepRecordTweenDone, arg_15_0, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_role_cover_open_2)
end

function var_0_0.onDeepRecordFrameCallback(arg_16_0, arg_16_1)
	arg_16_0._txtbestDeepRecord.text = string.format("%dM", arg_16_1)
end

function var_0_0.onDeepRecordTweenDone(arg_17_0)
	arg_17_0._txtbestDeepRecord.text = string.format("%dM", arg_17_0.curMaxDeepHigh)

	if arg_17_0.deepRecordTweenId then
		ZProj.TweenHelper.KillById(arg_17_0.deepRecordTweenId)

		arg_17_0.deepRecordTweenId = nil
	end

	TowerPermanentDeepModel.instance:setLastMaxDeepHigh()
end

function var_0_0.selectDeepLayer(arg_18_0)
	arg_18_0:_btndeepLayerOnClick()
end

function var_0_0.checkDeepSuccRewardGet(arg_19_0)
	arg_19_0.succDeepTaskMo = TowerDeepTaskModel.instance:getSuccRewardTaskMo()
	arg_19_0.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
	arg_19_0.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()
	arg_19_0.isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()
	arg_19_0.canShowDeep = arg_19_0.isDeepLayerUnlock and arg_19_0.isEnterDeepGuideFinish and arg_19_0.isInDeepLayer
	arg_19_0.hasSuccReward = arg_19_0.succDeepTaskMo and TowerDeepTaskModel.instance:isTaskCanGet(arg_19_0.succDeepTaskMo)

	if arg_19_0.hasSuccReward and arg_19_0.canShowDeep then
		gohelper.setActive(arg_19_0._goEnterDeepGuide, true)
		gohelper.setActive(arg_19_0._goDeepSuccReward, true)
		TaskDispatcher.runDelay(arg_19_0.sendOnDeepSuccRewardGuide, arg_19_0, 0.2)
	end
end

function var_0_0.sendOnDeepSuccRewardGuide(arg_20_0)
	TowerController.instance:dispatchEvent(TowerEvent.OnEnterDeepSuccRewardGuide)
end

function var_0_0._onCloseViewFinish(arg_21_0, arg_21_1)
	if TowerDeepTaskModel.instance:isSuccRewardHasGet() == arg_21_0.curTaskRewardHasGet then
		return
	end

	if arg_21_1 == ViewName.CommonPropView then
		arg_21_0.enterDeepGuideAnim:Play("close", 0, 0)
		arg_21_0.enterDeepGuideAnim:Update(0)
		arg_21_0.deepSuccRewardAnim:Play("close", 0, 0)
		arg_21_0.deepSuccRewardAnim:Update(0)
		TaskDispatcher.runDelay(arg_21_0.hideDeepSuccReward, arg_21_0, 0.5)

		arg_21_0.curTaskRewardHasGet = true
	end
end

function var_0_0.hideDeepSuccReward(arg_22_0)
	gohelper.setActive(arg_22_0._goEnterDeepGuide, false)
	gohelper.setActive(arg_22_0._goDeepSuccReward, false)
	arg_22_0:showDeepRecordChange()
	arg_22_0.deepFightAnim:Play()
	TowerController.instance:dispatchEvent(TowerEvent.OnSuccRewardGetFinish)
end

function var_0_0.onClose(arg_23_0)
	TowerPermanentDeepModel.instance:initData()
	TaskDispatcher.cancelTask(arg_23_0.sendOnDeepSuccRewardGuide, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.hideDeepSuccReward, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.showDeepRecordChange, arg_23_0)

	if arg_23_0.deepRecordTweenId then
		ZProj.TweenHelper.KillById(arg_23_0.deepRecordTweenId)

		arg_23_0.deepRecordTweenId = nil
	end

	TowerPermanentDeepModel.instance:setLastMaxDeepHigh()
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
