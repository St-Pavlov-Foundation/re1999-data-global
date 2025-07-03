module("modules.logic.tower.view.fight.TowerHeroGroupFightView", package.seeall)

local var_0_0 = class("TowerHeroGroupFightView", HeroGroupFightView)
local var_0_1 = 4

function var_0_0._editableInitView(arg_1_0)
	var_0_1 = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or var_0_1
	arg_1_0._multiplication = 1
	arg_1_0._goherogroupcontain = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")
	arg_1_0._goBtnContain = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain")
	arg_1_0._btnContainAnim = arg_1_0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_1_0._gomask, false)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_1_0._onOpenFullView, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_1_0._onModifyHeroGroup, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, arg_1_0._initFightGroupDrop, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_1_0._onModifySnapshot, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_1_0._onClickHeroGroupItem, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_1_0._respBeginFight, arg_1_0)
	arg_1_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_1_0.isShowHelpBtnIcon, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_1_0._onUseRecommendGroup, arg_1_0)
	arg_1_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_1_0._onCurrencyChange, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_1_0._showGuideDragEffect, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, arg_1_0._refreshTips, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_1_0._heroMoveForward, arg_1_0)
	arg_1_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_1_0.refreshDoubleDropTips, arg_1_0)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(arg_1_0._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_1_0._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_1_0._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(arg_1_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_1_0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_1_0._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(arg_1_0._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	arg_1_0._iconGO = arg_1_0:getResInst(arg_1_0.viewContainer:getSetting().otherRes[1], arg_1_0._btncloth.gameObject)

	recthelper.setAnchor(arg_1_0._iconGO.transform, -100, 1)

	arg_1_0._tweeningId = 0
	arg_1_0._replayMode = false
	arg_1_0._multSpeedItems = {}

	local var_1_0 = arg_1_0._gomultContent.transform

	for iter_1_0 = 1, var_0_1 do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)

		arg_1_0:_setMultSpeedItem(var_1_1.gameObject, var_0_1 - iter_1_0 + 1)
	end

	gohelper.setActive(arg_1_0._gomultispeed, false)
end

function var_0_0._enterFight(arg_2_0)
	if HeroGroupModel.instance.episodeId then
		arg_2_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroSingleGroup() then
			arg_2_0.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local var_2_0 = {}
			local var_2_1 = FightModel.instance:getFightParam()

			var_2_0.fightParam = var_2_1
			var_2_0.chapterId = var_2_1.chapterId
			var_2_0.episodeId = var_2_1.episodeId
			var_2_0.useRecord = arg_2_0._replayMode

			if arg_2_0._replayMode then
				var_2_1.isReplay = true
				var_2_1.multiplication = arg_2_0._multiplication
			else
				var_2_1.isReplay = false
				var_2_1.multiplication = 1
			end

			var_2_0.multiplication = var_2_1.multiplication

			TowerController.instance:startFight(var_2_0)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._initFightGroupDrop(arg_3_0)
	local var_3_0 = HeroGroupModel.instance.episodeId
	local var_3_1 = DungeonConfig.instance:getEpisodeCO(var_3_0).type
	local var_3_2 = {}

	if var_3_1 == DungeonEnum.EpisodeType.TowerBoss then
		table.insert(var_3_2, HeroGroupModel.instance:getCommonGroupName())
	else
		for iter_3_0 = 1, 4 do
			var_3_2[iter_3_0] = HeroGroupModel.instance:getCommonGroupName(iter_3_0)
		end
	end

	local var_3_3 = HeroGroupModel.instance:getHeroGroupSelectIndex()

	arg_3_0._dropherogroup:ClearOptions()
	arg_3_0._dropherogroup:AddOptions(var_3_2)
	arg_3_0._dropherogroup:SetValue(var_3_3 - 1)
	gohelper.setActive(arg_3_0._btnmodifyname, false)
end

function var_0_0._onClickHeroGroupItem(arg_4_0, arg_4_1)
	if TowerModel.instance:getRecordFightParam().isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	var_0_0.super._onClickHeroGroupItem(arg_4_0, arg_4_1)
end

function var_0_0._groupDropValueChanged(arg_5_0, arg_5_1)
	var_0_0.super._groupDropValueChanged(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._btnmodifyname, false)
end

return var_0_0
