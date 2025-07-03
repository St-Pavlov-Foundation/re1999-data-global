module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameView", package.seeall)

local var_0_0 = class("LengZhou6GameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "#go_Right")
	arg_1_0._simageGrid = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Right/#simage_Grid")
	arg_1_0._goTimes = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Times")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/#go_Times/#btn_Left")
	arg_1_0._txtTimes = gohelper.findChildText(arg_1_0.viewGO, "#go_Right/#go_Times/#txt_Times")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/#go_Times/#btn_Right")
	arg_1_0._goChessBG = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_ChessBG")
	arg_1_0._gochessBoard = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_ChessBG/#go_chessBoard")
	arg_1_0._gochess = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_ChessBG/#go_chess")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/#go_ChessBG/#go_chess/#btn_click")
	arg_1_0._goChessEffect = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_ChessEffect")
	arg_1_0._goLoading = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Loading")
	arg_1_0._sliderloading = gohelper.findChildSlider(arg_1_0.viewGO, "#go_Right/#go_Loading/#slider_loading")
	arg_1_0._goContinue = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Continue")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Right/#go_Continue/#simage_Mask")
	arg_1_0._btnContinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Right/#go_Continue/#btn_Continue")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Mask")
	arg_1_0._goAssess = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Assess")
	arg_1_0._imageAssess = gohelper.findChildImage(arg_1_0.viewGO, "#go_Right/#go_Assess/#image_Assess")
	arg_1_0._goAssess2 = gohelper.findChild(arg_1_0.viewGO, "#go_Right/#go_Assess2")
	arg_1_0._imageAssess2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_Right/#go_Assess2/#image_Assess2")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Right/#go_Assess2/#txt_Num")
	arg_1_0._goEnemy = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Enemy")
	arg_1_0._txtenemySkillTitle = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Enemy/#txt_enemy_SkillTitle")
	arg_1_0._imageEnemyHeadIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/#go_Enemy/Head/#image_Enemy_HeadIcon")
	arg_1_0._txtEnemyLife = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Enemy/Life/#txt_EnemyLife")
	arg_1_0._goTarget = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Target")
	arg_1_0._simageHeadIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#go_Target/go_Head/#simage_HeadIcon")
	arg_1_0._txtendlessnum = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Target/go_Endless/#txt_endless_num")
	arg_1_0._goSelf = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self")
	arg_1_0._simagePlayerHeadIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#go_Self/Head/#simage_Player_HeadIcon")
	arg_1_0._txtSelfLife = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/Life/#txt_SelfLife")
	arg_1_0._btnskillDescClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Self/#btn_skillDescClose")
	arg_1_0._goChooseSkillTips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self/#go_ChooseSkillTips")
	arg_1_0._goUseSkillTips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self/#go_UseSkillTips")
	arg_1_0._txtSkillDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr")
	arg_1_0._txtSkillName = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_SkillName")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/#txt_Round")
	arg_1_0._btnuseSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill")
	arg_1_0._goEnemySkillTips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self/#go_EnemySkillTips")
	arg_1_0._txtEnemySkillDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr")
	arg_1_0._txtEnemySkillName = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_EnemySkillTips/image_TipsBG/#txt_Enemy_SkillDescr/#txt_Enemy_SkillName")
	arg_1_0._goEnemyBuffTips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self/#go_EnemyBuffTips")
	arg_1_0._txtEnemyBuffDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr")
	arg_1_0._txtEnemyBuffName = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_EnemyBuffTips/image_TipsBG/#txt_Enemy_BuffDescr/#txt_Enemy_BuffName")
	arg_1_0._goPlayerBuffTips = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Self/#go_PlayerBuffTips")
	arg_1_0._txtPlayerBuffDescr = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr")
	arg_1_0._txtPlayerBuffName = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_Self/#go_PlayerBuffTips/image_TipsBG/#txt_Player_BuffDescr/#txt_Player_BuffName")
	arg_1_0._goCombos = gohelper.findChild(arg_1_0.viewGO, "#go_Combos")
	arg_1_0._imageComboFire = gohelper.findChildImage(arg_1_0.viewGO, "#go_Combos/#image_ComboFire")
	arg_1_0._txtComboNum = gohelper.findChildText(arg_1_0.viewGO, "#go_Combos/#txt_ComboNum")
	arg_1_0._txtComboNum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Combos/#txt_ComboNum1")
	arg_1_0._goChangeTips = gohelper.findChild(arg_1_0.viewGO, "#go_ChangeTips")
	arg_1_0._goSkillRelease = gohelper.findChild(arg_1_0.viewGO, "#go_SkillRelease")
	arg_1_0._gorectMask = gohelper.findChild(arg_1_0.viewGO, "#go_SkillRelease/#go_rectMask")
	arg_1_0._txtskillTipDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_SkillRelease/#txt_skillTipDesc")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskillDescClose:AddClickListener(arg_2_0._btnskillDescCloseOnClick, arg_2_0)
	arg_2_0._btnuseSkill:AddClickListener(arg_2_0._btnuseSkillOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskillDescClose:RemoveClickListener()
	arg_3_0._btnuseSkill:RemoveClickListener()
end

function var_0_0._btnskillDescCloseOnClick(arg_4_0)
	arg_4_0:closeSkillTips()
	arg_4_0:closeChooseSkillTips()
	arg_4_0:closeBuffTips()
end

function var_0_0._btnuseSkillOnClick(arg_5_0)
	if arg_5_0._playerCurSkillCanUse then
		arg_5_0:releaseSkill()
	end
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goPlayerSkillParent = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Self/Scroll View/Viewport/Content")
	arg_6_0._goEnemySkillParent = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Enemy/Scroll View/Viewport/Content")
	arg_6_0._goPlayerChooseSkillParent = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Self/#go_ChooseSkillTips/Scroll View/Viewport/Content")

	local var_6_0 = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Self/#go_UseSkillTips/image_TipsBG/#txt_SkillDescr/Title/#btn_useSkill")

	arg_6_0._imageUseSkillEffectCollection = var_0_1.Get(var_6_0)
	arg_6_0._combosTr = arg_6_0._goCombos.transform
	arg_6_0._combosAnim = arg_6_0._goCombos:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._goChooseSkillTipsAnim = arg_6_0._goChooseSkillTips:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._playerDamageGo = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Self/Life/damage")
	arg_6_0._playerDamageText = gohelper.findChildText(arg_6_0.viewGO, "Left/#go_Self/Life/damage/x/txtNum")
	arg_6_0._enemyDamageGo = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Enemy/Life/damage")
	arg_6_0._enemyDamageText = gohelper.findChildText(arg_6_0.viewGO, "Left/#go_Enemy/Life/damage/x/txtNum")

	gohelper.setActive(arg_6_0._playerDamageGo, false)
	gohelper.setActive(arg_6_0._enemyDamageGo, false)

	arg_6_0._enemyBuffParent = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Enemy/Life/EnemyBuff")
	arg_6_0._playerBuffParent = gohelper.findChild(arg_6_0.viewGO, "Left/#go_Self/Life/PlayerBuff")
	arg_6_0._playerAni = arg_6_0._goSelf:GetComponent(gohelper.Type_Animator)
	arg_6_0._enemyAni = arg_6_0._goEnemy:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initView()
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateGameInfo, arg_8_0.updateGameInfo, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateEliminateDamage, arg_8_0.updateEliminateDamage, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdateEnemySkill, arg_8_0.updateEnemySkill, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UpdatePlayerSkill, arg_8_0.updatePlayerSkill, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.OnClickSkill, arg_8_0.onClickSkill, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.FinishReleaseSkill, arg_8_0.cancelPlayerSkill, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.UseEnemySkill, arg_8_0.useEnemySkill, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowCombos, arg_8_0.showCombos, arg_8_0)
	arg_8_0:addEventCb(LengZhou6EliminateController.instance, LengZhou6Event.ShowEnemyEffect, arg_8_0.showEnemyEffect, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.EnemySkillRound, arg_8_0.enemySkillRound, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.OnEndlessChangeSelectState, arg_8_0.endLessModelRefreshView, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.ShowSelectView, arg_8_0.showSelectView, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.PlayerSelectFinish, arg_8_0._playerSkillSelectFinish, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.GameReStart, arg_8_0._gameReStart, arg_8_0)
	arg_8_0:addEventCb(LengZhou6GameController.instance, LengZhou6Event.RefreshBuffItem, arg_8_0.refreshBuffItem, arg_8_0)
	arg_8_0:addEventCb(LengZhou6Controller.instance, LengZhou6Event.OnClickBuff, arg_8_0.onClickBuff, arg_8_0)
end

function var_0_0.initView(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_level_open)

	local var_9_0 = LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.infinite

	arg_9_0:initHeroAndEnemyIcon()
	arg_9_0:updateGameInfo()
	arg_9_0:updateEliminateDamage()
	arg_9_0:initPlayerSKillView(not var_9_0)
	arg_9_0:initEnemySKillView()
	arg_9_0:updatePlayerSkill()
	arg_9_0:enemySkillRound()
	gohelper.setActive(arg_9_0._goUseSkillTips, false)
	gohelper.setActive(arg_9_0._btnskillDescClose.gameObject, false)
	gohelper.setActive(arg_9_0._goSelected, false)
	gohelper.setActive(arg_9_0._goTarget, var_9_0)

	if var_9_0 then
		arg_9_0:initSelectView()
	end

	arg_9_0:closeChooseSkillTips()
	arg_9_0:endLessModelRefreshView(true)
end

function var_0_0.initHeroAndEnemyIcon(arg_10_0)
	local var_10_0 = LengZhou6Config.instance:getEliminateBattleCostStr(24)
	local var_10_1 = LengZhou6Config.instance:getEliminateBattleCostStr(25)

	UISpriteSetMgr.instance:setHisSaBethSprite(arg_10_0._imageEnemyHeadIcon, var_10_1)
	arg_10_0._simagePlayerHeadIcon:LoadImage(ResUrl.getHeadIconSmall(var_10_0))
end

local var_0_2 = ""

function var_0_0.updateGameInfo(arg_11_0)
	local var_11_0 = LengZhou6GameModel.instance:getPlayer()
	local var_11_1 = LengZhou6GameModel.instance:getEnemy()

	arg_11_0._txtEnemyLife.text = var_11_1:getHp()
	arg_11_0._txtSelfLife.text = var_11_0:getHp()

	gohelper.setActive(arg_11_0._goCombos, false)

	local var_11_2

	var_11_2 = LengZhou6GameModel.instance:getBattleModel() == LengZhou6Enum.BattleModel.normal
	arg_11_0._txtendlessnum.text = LengZhou6GameModel.instance:getEndLessModelLayer() or LengZhou6Enum.DefaultEndLessBeginRound

	arg_11_0:refreshBuffItem()
end

function var_0_0.enemySkillRound(arg_12_0, arg_12_1)
	if arg_12_1 == nil then
		arg_12_1 = LengZhou6GameModel.instance:getEnemy():getAction():calCurResidueCd()
	end

	local var_12_0 = arg_12_1 <= 1
	local var_12_1 = math.max(arg_12_1 - 1, 0)

	if var_12_0 then
		arg_12_0._txtenemySkillTitle.text = luaLang("lengZhou6_enemy_skill_title_2")
	else
		arg_12_0._txtenemySkillTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_enemy_skill_title"), var_12_1)
	end

	if arg_12_0._enemySkillList == nil then
		return
	end

	for iter_12_0 = 1, #arg_12_0._enemySkillList do
		local var_12_2 = arg_12_0._enemySkillList[iter_12_0]

		if var_12_2 then
			var_12_2:showEnemySkillRound(var_12_0)
		end
	end
end

function var_0_0.endLessModelRefreshView(arg_13_0, arg_13_1)
	local var_13_0 = LengZhou6GameModel.instance:getBattleModel()

	gohelper.setActive(arg_13_0._goChangeTips, false)

	if var_13_0 == LengZhou6Enum.BattleModel.infinite then
		local var_13_1 = LengZhou6GameModel.instance:getEndLessBattleProgress()
		local var_13_2 = 0.1

		if arg_13_1 then
			var_13_2 = LengZhou6Enum.openViewAniTime
		end

		TaskDispatcher.runDelay(arg_13_0.showChangeTips, arg_13_0, var_13_2)

		local var_13_3 = var_13_1 == LengZhou6Enum.BattleProgress.selectFinish

		if var_13_3 then
			arg_13_0:updateGameInfo()
		end

		arg_13_0:initPlayerSKillView(var_13_3)
		arg_13_0:closeSkillTips()
		arg_13_0:cancelPlayerSkill()
		arg_13_0:updateEnemySkill(true)
		arg_13_0:enemySkillRound()
	end
end

function var_0_0.showChangeTips(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.showChangeTips, arg_14_0)

	local var_14_0 = LengZhou6GameModel.instance:getEndLessBattleProgress()

	gohelper.setActive(arg_14_0._goChangeTips, var_14_0 == LengZhou6Enum.BattleProgress.selectSkill)

	local var_14_1 = LengZhou6Model.instance:getCurEpisodeId()

	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.EnterGameLevel, var_14_1)
end

function var_0_0.updateEliminateDamage(arg_15_0)
	local var_15_0 = LengZhou6GameModel.instance:getEnemy():getCurDiff()
	local var_15_1 = false

	if var_15_0 and math.abs(var_15_0) > 0 then
		arg_15_0:setCombosActive(true)

		arg_15_0._enemyDamageText.text = "-" .. math.abs(var_15_0)

		gohelper.setActive(arg_15_0._enemyDamageGo, true)
		arg_15_0._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		var_15_1 = true
	else
		arg_15_0:setCombosActive(false)
	end

	local var_15_2 = LengZhou6GameModel.instance:getPlayer():getCurDiff()

	if var_15_2 and math.abs(var_15_2) > 0 then
		arg_15_0._playerDamageText.text = "+" .. math.abs(var_15_2)

		gohelper.setActive(arg_15_0._playerDamageGo, true)

		var_15_1 = true
	end

	if var_15_1 then
		TaskDispatcher.cancelTask(arg_15_0._onMoveEnd, arg_15_0)
		TaskDispatcher.runDelay(arg_15_0._onMoveEnd, arg_15_0, EliminateEnum_2_7.UpdateDamageStepTime)
	else
		arg_15_0:_onMoveEnd()
	end
end

function var_0_0._onMoveEnd(arg_16_0)
	gohelper.setActive(arg_16_0._enemyDamageGo, false)
	gohelper.setActive(arg_16_0._playerDamageGo, false)
	TaskDispatcher.cancelTask(arg_16_0._onMoveEnd, arg_16_0)
	arg_16_0:setCombosActive(false)

	local var_16_0 = LengZhou6GameModel.instance:getEnemy()

	arg_16_0._txtEnemyLife.text = var_16_0:getHp()

	local var_16_1 = LengZhou6GameModel.instance:getPlayer()

	arg_16_0._txtSelfLife.text = var_16_1:getHp()

	arg_16_0._enemyAni:Play("idle", 0, 0)
end

function var_0_0.showCombos(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 or 0
	local var_17_1 = var_17_0 >= LengZhou6Config.instance:getComboThreshold()

	arg_17_0._txtComboNum.text = var_17_0
	arg_17_0._txtComboNum1.text = var_17_0

	if arg_17_0._comboActive then
		arg_17_0._combosAnim:Play("up", 0, 0)
	end

	arg_17_0:setCombosActive(var_17_0 > 0)
	gohelper.setActive(arg_17_0._imageComboFire.gameObject, var_17_1)
end

function var_0_0.setCombosActive(arg_18_0, arg_18_1)
	if arg_18_0._comboActive ~= nil and arg_18_0._comboActive == arg_18_1 then
		return
	end

	gohelper.setActive(arg_18_0._goCombos, arg_18_1)

	arg_18_0._comboActive = arg_18_1
end

function var_0_0.initPlayerSKillView(arg_19_0, arg_19_1)
	if arg_19_0._playerSkillList == nil then
		arg_19_0._playerSkillList = arg_19_0:getUserDataTb_()
	end

	local var_19_0 = LengZhou6GameModel.instance:getPlayer():getActiveSkills()
	local var_19_1 = LengZhou6GameModel.instance:getSelectSkillIdList()
	local var_19_2 = arg_19_0.viewContainer:getSetting().otherRes[1]

	for iter_19_0 = 1, LengZhou6Enum.PlayerSkillMaxCount do
		local var_19_3
		local var_19_4

		if arg_19_1 then
			var_19_3 = var_19_0[iter_19_0]
		else
			var_19_4 = var_19_1[iter_19_0]
		end

		local var_19_5 = arg_19_0._playerSkillList[iter_19_0]

		if var_19_5 == nil then
			local var_19_6 = arg_19_0:getResInst(var_19_2, arg_19_0._goPlayerSkillParent)

			var_19_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_6, LengZhou6SkillItem)

			gohelper.setActive(var_19_6, true)
			table.insert(arg_19_0._playerSkillList, var_19_5)
		end

		if var_19_5 ~= nil then
			var_19_5:initSkill(var_19_3, iter_19_0)

			if var_19_3 == nil then
				var_19_5:initSkillConfigId(var_19_4)
			end

			var_19_5:initCamp(LengZhou6Enum.entityCamp.player)
			var_19_5:selectIsFinish(arg_19_1)
			var_19_5:refreshState()
		end
	end
end

function var_0_0.updatePlayerSkill(arg_20_0)
	if arg_20_0._playerSkillList ~= nil then
		for iter_20_0 = 1, #arg_20_0._playerSkillList do
			local var_20_0 = arg_20_0._playerSkillList[iter_20_0]

			if var_20_0 then
				var_20_0:updateSkillInfo()
			end
		end
	end
end

function var_0_0.initEnemySKillView(arg_21_0)
	if arg_21_0._enemySkillList == nil then
		arg_21_0._enemySkillList = arg_21_0:getUserDataTb_()
	end

	local var_21_0 = LengZhou6GameModel.instance:getEnemy():getCurSkillList()
	local var_21_1 = arg_21_0.viewContainer:getSetting().otherRes[1]

	for iter_21_0 = 1, 3 do
		local var_21_2 = var_21_0 and var_21_0[iter_21_0]
		local var_21_3 = arg_21_0._enemySkillList[iter_21_0]

		if var_21_3 == nil then
			local var_21_4 = arg_21_0:getResInst(var_21_1, arg_21_0._goEnemySkillParent)

			var_21_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_4, LengZhou6SkillItem)

			gohelper.setActive(var_21_4, true)
		end

		var_21_3:initSkill(var_21_2)
		var_21_3:initCamp(LengZhou6Enum.entityCamp.enemy)
		var_21_3:refreshState()
		table.insert(arg_21_0._enemySkillList, var_21_3)
	end
end

function var_0_0.updateEnemySkill(arg_22_0, arg_22_1)
	local var_22_0 = LengZhou6GameModel.instance:getEnemy():getCurSkillList()

	for iter_22_0 = 1, 3 do
		local var_22_1 = var_22_0 and var_22_0[iter_22_0] or nil
		local var_22_2 = arg_22_0._enemySkillList[iter_22_0]

		var_22_2:initSkill(var_22_1)
		var_22_2:refreshState()

		if var_22_1 ~= nil and not arg_22_1 then
			AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_refresh)
		end
	end
end

function var_0_0.useEnemySkill(arg_23_0, arg_23_1)
	for iter_23_0 = 1, #arg_23_0._enemySkillList do
		arg_23_0._enemySkillList[iter_23_0]:useSkill(arg_23_1)
	end
end

function var_0_0.onClickSkill(arg_24_0, arg_24_1)
	if arg_24_1 == nil then
		return
	end

	if arg_24_1:getSkillType() == LengZhou6Enum.SkillType.enemyActive then
		arg_24_0:_showEnemySkillDesc(arg_24_1)
	else
		arg_24_0:_showPlayerSkillDesc(arg_24_1)
	end

	gohelper.setActive(arg_24_0._btnskillDescClose.gameObject, true)
end

function var_0_0._showEnemySkillDesc(arg_25_0, arg_25_1)
	if arg_25_1 == nil then
		return
	end

	arg_25_0._txtEnemySkillDescr.text = arg_25_1:getSkillDesc()
	arg_25_0._txtEnemySkillName.text = arg_25_1:getConfig().name

	gohelper.setActive(arg_25_0._goEnemySkillTips, true)
end

function var_0_0._showPlayerSkillDesc(arg_26_0, arg_26_1)
	arg_26_0._playerCurSkill = arg_26_1

	local var_26_0 = arg_26_1:getConfig()

	arg_26_0._txtSkillDescr.text = var_26_0.desc

	local var_26_1 = arg_26_1:getCd()
	local var_26_2 = var_26_0.type == LengZhou6Enum.SkillType.active

	if var_26_2 then
		arg_26_0._txtRound.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), arg_26_1:getConfig().cd)
	else
		arg_26_0._txtRound.text = luaLang("lengZhou6_skill_round_end")
	end

	arg_26_0._txtSkillName.text = var_26_0.name
	arg_26_0._playerCurSkillCanUse = var_26_1 == 0 and var_26_2

	if arg_26_0._imageUseSkillEffectCollection ~= nil then
		arg_26_0._imageUseSkillEffectCollection:SetGray(not arg_26_0._playerCurSkillCanUse)
	end

	gohelper.setActive(arg_26_0._btnuseSkill.gameObject, var_26_2)
	gohelper.setActive(arg_26_0._goUseSkillTips, true)
end

function var_0_0.closeSkillTips(arg_27_0)
	gohelper.setActive(arg_27_0._goUseSkillTips, false)
	gohelper.setActive(arg_27_0._btnskillDescClose.gameObject, false)
	gohelper.setActive(arg_27_0._goEnemySkillTips, false)
end

function var_0_0.releaseSkill(arg_28_0)
	if arg_28_0._playerCurSkill ~= nil then
		if arg_28_0._playerCurSkill:paramIsFull() then
			arg_28_0._playerCurSkill:execute()

			arg_28_0._playerCurSkill = nil
		else
			arg_28_0:initCharacterSkill()
			LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ReleaseSkill, arg_28_0._playerCurSkill)
		end
	end

	arg_28_0:closeSkillTips()
end

function var_0_0.cancelPlayerSkill(arg_29_0)
	arg_29_0._playerCurSkill = nil

	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.CancelSkill)
	arg_29_0:hideSkillRelease()
end

function var_0_0.hideSkillRelease(arg_30_0)
	if arg_30_0._skillReleaseView ~= nil then
		gohelper.setActive(arg_30_0._goSkillRelease, false)
	end
end

function var_0_0.initCharacterSkill(arg_31_0)
	if arg_31_0._skillReleaseView == nil then
		arg_31_0._skillReleaseView = MonoHelper.addNoUpdateLuaComOnceToGo(arg_31_0._goSkillRelease, LengZhou6EliminatePlayerSkill)
	end

	local var_31_0 = arg_31_0._goChessBG.transform
	local var_31_1 = recthelper.getWidth(var_31_0)
	local var_31_2 = recthelper.getHeight(var_31_0)

	arg_31_0._skillReleaseView:setTargetTrAndHoleSize(var_31_0, var_31_1, var_31_2, -56, 325)
	arg_31_0._skillReleaseView:setClickCb(arg_31_0.cancelPlayerSkill, arg_31_0)
	gohelper.setActive(arg_31_0._goSkillRelease, true)
end

function var_0_0.initSelectView(arg_32_0)
	if arg_32_0._allSelectSkillItemList == nil then
		arg_32_0._allSelectSkillItemList = arg_32_0:getUserDataTb_()
	end

	local var_32_0 = LengZhou6Config.instance:getPlayerAllSkillId()
	local var_32_1 = arg_32_0.viewContainer:getSetting().otherRes[2]

	for iter_32_0 = 1, #var_32_0 do
		local var_32_2 = var_32_0[iter_32_0]
		local var_32_3 = arg_32_0._allSelectSkillItemList[iter_32_0]

		if var_32_3 == nil then
			local var_32_4 = arg_32_0:getResInst(var_32_1, arg_32_0._goPlayerChooseSkillParent, var_32_2)

			var_32_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_32_4, LengZhou6PlayerSelectSkillItem)

			table.insert(arg_32_0._allSelectSkillItemList, var_32_3)
			gohelper.setActive(var_32_4, true)
		end

		var_32_3:initSkill(var_32_2)
	end
end

function var_0_0.showSelectView(arg_33_0, arg_33_1)
	if arg_33_0._allSelectSkillItemList == nil or tabletool.len(arg_33_0._allSelectSkillItemList) == 0 then
		return
	end

	local var_33_0 = LengZhou6Config.instance:getPlayerAllSkillId()

	for iter_33_0 = 1, #arg_33_0._allSelectSkillItemList do
		arg_33_0._allSelectSkillItemList[iter_33_0]:initSelectIndex(arg_33_1)
	end

	table.sort(var_33_0, function(arg_34_0, arg_34_1)
		local var_34_0 = LengZhou6GameModel.instance:isSelectSkill(arg_34_0)
		local var_34_1 = LengZhou6GameModel.instance:isSelectSkill(arg_34_1)

		if var_34_0 and not var_34_1 then
			return false
		elseif not var_34_0 and var_34_1 then
			return true
		else
			return arg_34_0 < arg_34_1
		end
	end)

	for iter_33_1 = 1, #var_33_0 do
		local var_33_1 = var_33_0[iter_33_1]

		arg_33_0._allSelectSkillItemList[iter_33_1]:initSkill(var_33_1)
	end

	arg_33_0:setChooseSkillActive(true)
	gohelper.setActive(arg_33_0._btnskillDescClose.gameObject, true)
end

function var_0_0.setChooseSkillActive(arg_35_0, arg_35_1)
	if arg_35_0._lastChooseActive ~= nil and arg_35_0._lastActive == arg_35_1 then
		return
	end

	if arg_35_1 then
		gohelper.setActive(arg_35_0._goChooseSkillTips, true)
		arg_35_0._goChooseSkillTipsAnim:Play("open", 0, 0)

		arg_35_0._lastChooseActive = arg_35_1
	else
		arg_35_0._goChooseSkillTipsAnim:Play("close", 0, 0)
		TaskDispatcher.runDelay(arg_35_0._setChooseSkillTipsFalse, arg_35_0, 0.167)
	end
end

function var_0_0._setChooseSkillTipsFalse(arg_36_0)
	gohelper.setActive(arg_36_0._goChooseSkillTips, false)

	arg_36_0._lastChooseActive = false
end

function var_0_0._playerSkillSelectFinish(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0:closeChooseSkillTips()

	if arg_37_0._playerSkillList ~= nil then
		local var_37_0 = arg_37_0._playerSkillList[arg_37_1]

		if var_37_0 ~= nil then
			var_37_0:initSkillConfigId(arg_37_2)
			var_37_0:initCamp(LengZhou6Enum.entityCamp.player)
			var_37_0:refreshState()
		end
	end
end

function var_0_0.closeChooseSkillTips(arg_38_0)
	arg_38_0:setChooseSkillActive(false)
	gohelper.setActive(arg_38_0._btnskillDescClose.gameObject, false)
end

function var_0_0.showEnemyEffect(arg_39_0, arg_39_1)
	if arg_39_1 == LengZhou6Enum.SkillEffect.DealsDamage then
		local var_39_0 = LengZhou6GameModel.instance:getPlayer():getCurDiff()

		arg_39_0._playerDamageText.text = var_39_0

		gohelper.setActive(arg_39_0._playerDamageGo, true)
		arg_39_0._playerAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)
		TaskDispatcher.cancelTask(arg_39_0._showPlayerEffectEnd, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._showPlayerEffectEnd, arg_39_0, LengZhou6Enum.EnemySkillTime)
	end

	if arg_39_1 == LengZhou6Enum.SkillEffect.Heal then
		local var_39_1 = LengZhou6GameModel.instance:getEnemy():getCurDiff()

		arg_39_0._enemyDamageText.text = var_39_1 > 0 and string.format("+%s", var_39_1)

		gohelper.setActive(arg_39_0._enemyDamageGo, true)
		TaskDispatcher.cancelTask(arg_39_0._showEnemyEffectEnd, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._showEnemyEffectEnd, arg_39_0, LengZhou6Enum.EnemySkillTime)
	end

	if arg_39_1 == LengZhou6Enum.BuffEffect.poison then
		local var_39_2 = LengZhou6GameModel.instance:getEnemy():getCurDiff()

		arg_39_0._enemyDamageText.text = var_39_2 > 0 and string.format("+%s", var_39_2) or var_39_2

		gohelper.setActive(arg_39_0._enemyDamageGo, true)
		arg_39_0._enemyAni:Play("damage", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_hp)

		local var_39_3 = LengZhou6GameModel.instance:getEnemy()

		TaskDispatcher.cancelTask(arg_39_0._showEnemyEffectEnd, arg_39_0)
		TaskDispatcher.runDelay(arg_39_0._showEnemyEffectEnd, arg_39_0, LengZhou6Enum.EnemyBuffEffectShowTime)
	end
end

function var_0_0._showPlayerEffectEnd(arg_40_0)
	gohelper.setActive(arg_40_0._playerDamageGo, false)

	local var_40_0 = LengZhou6GameModel.instance:getPlayer()

	arg_40_0._txtSelfLife.text = var_40_0:getHp()

	arg_40_0._playerAni:Play("idle", 0, 0)
end

function var_0_0._showEnemyEffectEnd(arg_41_0)
	gohelper.setActive(arg_41_0._enemyDamageGo, false)

	local var_41_0 = LengZhou6GameModel.instance:getEnemy()

	arg_41_0._txtEnemyLife.text = var_41_0:getHp()

	arg_41_0._enemyAni:Play("idle", 0, 0)
end

function var_0_0.refreshBuffItem(arg_42_0)
	arg_42_0:_refreshPlayerBuffItem()
	arg_42_0:_refreshEnemyBuffItem()
end

function var_0_0._refreshPlayerBuffItem(arg_43_0)
	if arg_43_0._playerBuffItems == nil then
		arg_43_0._playerBuffItems = arg_43_0:getUserDataTb_()
	end

	local var_43_0 = LengZhou6GameModel.instance:getPlayer():getBuffs()
	local var_43_1 = math.max(tabletool.len(var_43_0), tabletool.len(arg_43_0._playerBuffItems))

	for iter_43_0 = 1, var_43_1 do
		local var_43_2 = arg_43_0._playerBuffItems[iter_43_0]
		local var_43_3 = var_43_0[iter_43_0]

		if var_43_2 == nil then
			local var_43_4 = arg_43_0:getResInst(arg_43_0.viewContainer:getSetting().otherRes[3], arg_43_0._playerBuffParent)

			var_43_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_43_4, LengZhou6BuffItem)

			table.insert(arg_43_0._playerBuffItems, var_43_2)
		end

		if var_43_2 ~= nil then
			local var_43_5 = arg_43_0._playerBuffParent

			if var_43_3 ~= nil and var_43_3._configId == 1001 then
				var_43_5 = arg_43_0._enemyBuffParent
			end

			var_43_2:changeParent(var_43_5)
		end

		if var_43_2 ~= nil then
			var_43_2:updateBuffItem(var_43_3)
		end
	end
end

function var_0_0._refreshEnemyBuffItem(arg_44_0)
	if arg_44_0._enemyBuffItems == nil then
		arg_44_0._enemyBuffItems = arg_44_0:getUserDataTb_()
	end

	local var_44_0 = LengZhou6GameModel.instance:getEnemy():getBuffs()
	local var_44_1 = math.max(tabletool.len(var_44_0), tabletool.len(arg_44_0._enemyBuffItems))

	for iter_44_0 = 1, var_44_1 do
		local var_44_2 = arg_44_0._enemyBuffItems[iter_44_0]
		local var_44_3 = var_44_0[iter_44_0]

		if var_44_2 == nil and var_44_3 ~= nil then
			local var_44_4 = arg_44_0:getResInst(arg_44_0.viewContainer:getSetting().otherRes[3], arg_44_0._enemyBuffParent)

			var_44_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_44_4, LengZhou6BuffItem)

			gohelper.setActive(var_44_4, true)
			table.insert(arg_44_0._enemyBuffItems, var_44_2)
		end

		if var_44_2 ~= nil then
			var_44_2:updateBuffItem(var_44_3)
		end
	end
end

function var_0_0.onClickBuff(arg_45_0, arg_45_1)
	if arg_45_1 == nil then
		return
	end

	local var_45_0 = LengZhou6Config.instance:getEliminateBattleBuff(arg_45_1)

	if var_45_0 then
		if arg_45_1 == 1001 or arg_45_1 == 1002 then
			arg_45_0._txtEnemyBuffDescr.text = var_45_0.desc
			arg_45_0._txtEnemyBuffName.text = var_45_0.name

			gohelper.setActive(arg_45_0._goEnemyBuffTips, true)
		end

		if arg_45_1 == 1003 then
			arg_45_0._txtPlayerBuffDescr.text = var_45_0.desc
			arg_45_0._txtPlayerBuffName.text = var_45_0.name

			gohelper.setActive(arg_45_0._goPlayerBuffTips, true)
		end

		gohelper.setActive(arg_45_0._btnskillDescClose.gameObject, true)
	end
end

function var_0_0.closeBuffTips(arg_46_0)
	gohelper.setActive(arg_46_0._goEnemyBuffTips, false)
	gohelper.setActive(arg_46_0._goPlayerBuffTips, false)
end

function var_0_0.onClose(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._onMoveEnd, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0.showChangeTips, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._showEffectEnd, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._showPlayerEffectEnd, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._showEnemyEffectEnd, arg_47_0)
end

function var_0_0._gameReStart(arg_48_0)
	arg_48_0:initView()
end

function var_0_0.onDestroyView(arg_49_0)
	return
end

return var_0_0
