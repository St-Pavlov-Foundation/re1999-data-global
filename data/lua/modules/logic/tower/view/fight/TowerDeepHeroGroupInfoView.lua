module("modules.logic.tower.view.fight.TowerDeepHeroGroupInfoView", package.seeall)

local var_0_0 = class("TowerDeepHeroGroupInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagedeepBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_deepBg")
	arg_1_0._imagedeepRare = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_depth/#image_deepRare")
	arg_1_0._txtdepth = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/#go_depth/#txt_depth")
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_power")
	arg_1_0._goroundContent = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/go_restRound/#go_roundContent")
	arg_1_0._goroundItem = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/go_restRound/#go_roundContent/#go_roundItem")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_save")
	arg_1_0._btnload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_load")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnSaveOnClick, arg_2_0)
	arg_2_0._btnload:AddClickListener(arg_2_0._btnLoadOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_2_0.playDeepInfoAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnload:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnLoadTeamSuccess, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0.playDeepInfoAnim, arg_3_0)
end

function var_0_0._btnSaveOnClick(arg_4_0)
	local var_4_0 = {
		teamOperateType = TowerDeepEnum.TeamOperateType.Save
	}

	TowerController.instance:openTowerDeepTeamSaveView(var_4_0)
end

function var_0_0._btnLoadOnClick(arg_5_0)
	local var_5_0 = {
		teamOperateType = TowerDeepEnum.TeamOperateType.Load
	}

	TowerController.instance:openTowerDeepTeamSaveView(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goassistBoss = gohelper.findChild(arg_6_0.viewGO, "herogroupcontain/assistBoss")
	arg_6_0._goassistBossEmpty = gohelper.findChild(arg_6_0.viewGO, "herogroupcontain/assistBossEmpty")
	arg_6_0._animAssistBoss = arg_6_0._goassistBoss:GetComponent(gohelper.Type_Animator)
	arg_6_0._animAssistBossEmpty = arg_6_0._goassistBossEmpty:GetComponent(gohelper.Type_Animation)
	arg_6_0._goassistBossClick = gohelper.findChild(arg_6_0.viewGO, "herogroupcontain/assistBoss/boss/click")
	arg_6_0.teamRoundNum = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.HeroGroupTeamNum)
	arg_6_0.roundItemMap = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._goroundItem, false)
	gohelper.setActive(arg_6_0._goassistBossClick, false)

	arg_6_0.isDropAssistBoss = false
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshUI()
	arg_8_0:refreshBoss()
end

function var_0_0.onOpenFinish(arg_9_0)
	TaskDispatcher.runDelay(arg_9_0.playDeepInfoAnim, arg_9_0, 0.5)
end

function var_0_0.refreshUI(arg_10_0)
	gohelper.setActive(arg_10_0._gopower, false)

	arg_10_0.curDeepHigh = TowerPermanentDeepModel.instance:getCurDeepHigh()

	local var_10_0 = TowerPermanentDeepModel.instance:getDeepRare(arg_10_0.curDeepHigh)

	arg_10_0._simagedeepBg:LoadImage(ResUrl.getFightImage(string.format("tower/fight_tower_mask_%s.png", var_10_0)))
	UISpriteSetMgr.instance:setFightTowerSprite(arg_10_0._imagedeepRare, "fight_tower_numbg_" .. var_10_0)

	arg_10_0._txtdepth.text = string.format("%sm", arg_10_0.curDeepHigh)
	arg_10_0.isFightFailNotEnd = TowerPermanentDeepModel.instance:getIsFightFailNotEndState()

	arg_10_0:createAndRefreshRound()
end

function var_0_0.createAndRefreshRound(arg_11_0)
	arg_11_0.curTeamWaveNum = TowerPermanentDeepModel.instance:getCurDeepGroupWave()

	for iter_11_0 = 1, arg_11_0.teamRoundNum do
		local var_11_0 = arg_11_0.roundItemMap[iter_11_0]

		if not var_11_0 then
			var_11_0 = {
				go = gohelper.clone(arg_11_0._goroundItem, arg_11_0._goroundContent, "roundItem" .. iter_11_0)
			}
			var_11_0.fail = gohelper.findChild(var_11_0.go, "fail")
			var_11_0.normal = gohelper.findChild(var_11_0.go, "normal")
			var_11_0.hideAnim = var_11_0.normal:GetComponent(gohelper.Type_Animator)
			var_11_0.current = gohelper.findChild(var_11_0.go, "current")
			arg_11_0.roundItemMap[iter_11_0] = var_11_0
		end

		gohelper.setActive(var_11_0.go, true)
		gohelper.setActive(var_11_0.fail, iter_11_0 < arg_11_0.curTeamWaveNum)
		gohelper.setActive(var_11_0.normal, arg_11_0.isFightFailNotEnd and iter_11_0 >= arg_11_0.curTeamWaveNum - 1 or iter_11_0 >= arg_11_0.curTeamWaveNum)
		gohelper.setActive(var_11_0.current, iter_11_0 == arg_11_0.curTeamWaveNum)
		var_11_0.hideAnim:Play("idle", 0, 0)
		var_11_0.hideAnim:Update(0)
	end

	gohelper.setActive(arg_11_0._btnsave.gameObject, arg_11_0.curTeamWaveNum > 1)
end

function var_0_0.refreshBoss(arg_12_0)
	arg_12_0.curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	arg_12_0.bossId = arg_12_0.curGroupMO:getAssistBossId()

	gohelper.setActive(arg_12_0._goassistBoss, arg_12_0.bossId > 0)
	gohelper.setActive(arg_12_0._goassistBossEmpty, arg_12_0.bossId == 0)
end

function var_0_0.playDeepInfoAnim(arg_13_0)
	arg_13_0.curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	arg_13_0.bossId = arg_13_0.curGroupMO:getAssistBossId()

	if arg_13_0.bossId > 0 then
		arg_13_0._animAssistBoss:Play("out", 0, 0)
		arg_13_0._animAssistBoss:Update(0)
		gohelper.setActive(arg_13_0._goassistBoss, not arg_13_0.isDropAssistBoss)
		TaskDispatcher.runDelay(arg_13_0.showAssistBossEmpty, arg_13_0, 0.167)
	else
		TowerController.instance:dispatchEvent(TowerEvent.OnShowAssistBossEmpty)
	end

	if arg_13_0.isFightFailNotEnd then
		local var_13_0 = Mathf.Max(arg_13_0.curTeamWaveNum - 1, 1)
		local var_13_1 = arg_13_0.roundItemMap[var_13_0]

		var_13_1.hideAnim:Play("close", 0, 0)
		var_13_1.hideAnim:Update(0)
		TowerPermanentDeepModel.instance:setIsFightFailNotEndState(false)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_passion_get)
	end
end

function var_0_0.showAssistBossEmpty(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.showAssistBossEmpty, arg_14_0)
	gohelper.setActive(arg_14_0._goassistBossEmpty, true)
	arg_14_0._animAssistBossEmpty:Play()
	TowerController.instance:dispatchEvent(TowerEvent.OnShowAssistBossEmpty)

	arg_14_0.isDropAssistBoss = true
end

function var_0_0.removeAssistBoss(arg_15_0)
	arg_15_0.curGroupMO:setAssistBossId(0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagedeepBg:UnLoadImage()
	TaskDispatcher.cancelTask(arg_16_0.playDeepInfoAnim, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.showAssistBossEmpty, arg_16_0)
	arg_16_0:removeAssistBoss()
	TowerPermanentDeepModel.instance:setIsFightFailNotEndState(false)
end

return var_0_0
