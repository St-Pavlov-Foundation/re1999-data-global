module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameEnemyInfoView", package.seeall)

local var_0_0 = class("XugoujiGameEnemyInfoView", BaseView)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_2 = 0.35

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goEnemyInfo = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/Enemy")
	arg_1_0._txtHP = gohelper.findChildText(arg_1_0._goEnemyInfo, "Role/image_RoleHPNumBG/#txt_RoleHP")
	arg_1_0._btnIcon = gohelper.findChildButtonWithAudio(arg_1_0._goEnemyInfo, "Role/image/#simage_Role")
	arg_1_0._imageIcon = gohelper.findChildSingleImage(arg_1_0._goEnemyInfo, "Role/image/#simage_Role")
	arg_1_0._txtRemainTime = gohelper.findChildText(arg_1_0._goEnemyInfo, "Remain/#txt_RemainValue")
	arg_1_0._txtGotPairNum = gohelper.findChildText(arg_1_0._goEnemyInfo, "Pairs/#txt_PairsValue")
	arg_1_0._imageHP = gohelper.findChildImage(arg_1_0._goEnemyInfo, "Role/image_RoleHPBG/#image_RoleHPFG")
	arg_1_0._goHp = gohelper.findChild(arg_1_0._goEnemyInfo, "#go_HP")
	arg_1_0._textHpDiff = gohelper.findChildText(arg_1_0._goEnemyInfo, "#go_HP/#txt_HP")
	arg_1_0._btnBuff = gohelper.findChildButtonWithAudio(arg_1_0._goEnemyInfo, "#go_Buff")
	arg_1_0._goBuffRoot = gohelper.findChild(arg_1_0._goEnemyInfo, "#go_Buff")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0._goBuffRoot, "#go_Buff")
	arg_1_0._buffInfoRoot = gohelper.findChild(arg_1_0._goEnemyInfo, "bufftipsview")
	arg_1_0._goBuffInfoContent = gohelper.findChild(arg_1_0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	arg_1_0._goBuffInfoItem = gohelper.findChild(arg_1_0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._btnBuffInfoClose = gohelper.findChildButtonWithAudio(arg_1_0._buffInfoRoot, "#btn_buffTipsHide")
	arg_1_0._btnSkill = gohelper.findChildButtonWithAudio(arg_1_0._goEnemyInfo, "Role/#btn_Skill")
	arg_1_0._skillRoot = gohelper.findChild(arg_1_0._goEnemyInfo, "#go_ViewSkillTips")
	arg_1_0._btnSkillTipsHide = gohelper.findChildButtonWithAudio(arg_1_0._skillRoot, "#btnSkillTipsHide")
	arg_1_0._skillItemRoot = gohelper.findChild(arg_1_0._goEnemyInfo, "#go_ViewSkillTips/image_TipsBG")
	arg_1_0._skillItem = gohelper.findChild(arg_1_0._skillRoot, "image_TipsBG/#go_Item")
	arg_1_0._skillTipsAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._skillRoot)
	arg_1_0._viewAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._goDamageEffect = gohelper.findChild(arg_1_0._goEnemyInfo, "#go_damage")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnIcon:AddClickListener(arg_2_0._onIconClick, arg_2_0)
	arg_2_0._btnSkill:AddClickListener(arg_2_0._onSkillClick, arg_2_0)
	arg_2_0._btnSkillTipsHide:AddClickListener(arg_2_0._onSkillHideClick, arg_2_0)
	arg_2_0._btnBuff:AddClickListener(arg_2_0._onBuffClick, arg_2_0)
	arg_2_0._btnBuffInfoClose:AddClickListener(arg_2_0._onBuffInfoCloseClick, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, arg_2_0._onHpUpdated, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, arg_2_0._onOperateCard, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_2_0._onTurnChanged, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, arg_2_0._refreshCardPair, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, arg_2_0._onBuffsUpdated, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, arg_2_0._onGameReStart, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, arg_2_0._onShowGameTips, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, arg_2_0._autoHideSkillTips, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.NewCards, arg_2_0._onRefreshCards, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnIcon:RemoveClickListener()
	arg_3_0._btnSkill:RemoveClickListener()
	arg_3_0._btnBuff:RemoveClickListener()
	arg_3_0._btnSkillTipsHide:RemoveClickListener()
	arg_3_0._btnBuffInfoClose:RemoveClickListener()
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.HpUpdated, arg_3_0._onHpUpdated, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.OperateTimeUpdated, arg_3_0._onOperateCard, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_3_0._onTurnChanged, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, arg_3_0._refreshCardPair, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.BuffUpdated, arg_3_0._onBuffsUpdated, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, arg_3_0._onGameReStart, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoShowSkillTips, arg_3_0._onShowGameTips, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoHideSkillTips, arg_3_0._autoHideSkillTips, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.NewCards, arg_3_0._onRefreshCards, arg_3_0)
end

function var_0_0._onIconClick(arg_4_0)
	return
end

function var_0_0._onSkillClick(arg_5_0)
	if not arg_5_0._gameCfg then
		local var_5_0 = Activity188Model.instance:getCurGameId()

		arg_5_0._gameCfg = Activity188Config.instance:getGameCfg(var_0_1, var_5_0)
	end

	arg_5_0._abilityCfgList = {
		{
			title = true
		}
	}
	arg_5_0._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._abilityIdList) do
		local var_5_1 = Activity188Config.instance:getAbilityCfg(var_0_1, iter_5_1)

		arg_5_0._abilityCfgList[iter_5_0 + 1] = var_5_1
	end

	if #arg_5_0._abilityCfgList == 1 then
		return
	end

	gohelper.setActive(arg_5_0._skillRoot, true)
	arg_5_0._skillTipsAnimator:Play(UIAnimationName.Open, nil, nil)
	gohelper.setActive(arg_5_0._btnSkillTipsHide.gameObject, true)
	gohelper.CreateObjList(arg_5_0, arg_5_0._createSkillItem, arg_5_0._abilityCfgList, arg_5_0._skillItemRoot, arg_5_0._skillItem)
end

function var_0_0._onSkillHideClick(arg_6_0)
	gohelper.setActive(arg_6_0._btnSkillTipsHide.gameObject, false)
	arg_6_0._skillTipsAnimator:Play(UIAnimationName.Close, arg_6_0.onSkillTipsCloseAniFinish, arg_6_0)
end

function var_0_0.onSkillTipsCloseAniFinish(arg_7_0)
	gohelper.setActive(arg_7_0._skillRoot, false)
end

function var_0_0._onBuffClick(arg_8_0)
	arg_8_0._buffDataList = Activity188Model.instance:getBuffs(false)

	if not arg_8_0._buffDataList or #arg_8_0._buffDataList == 0 then
		return
	end

	local var_8_0 = {
		{
			bg = true
		}
	}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._buffDataList) do
		var_8_0[iter_8_0 + 1] = iter_8_1
	end

	gohelper.setActive(arg_8_0._buffInfoRoot, true)
	gohelper.CreateObjList(arg_8_0, arg_8_0._createBuffInfoItem, var_8_0, arg_8_0._goBuffInfoContent, arg_8_0._goBuffInfoItem)
end

function var_0_0._onBuffInfoCloseClick(arg_9_0)
	gohelper.setActive(arg_9_0._buffInfoRoot, false)
end

function var_0_0._onHpUpdated(arg_10_0)
	local var_10_0 = Activity188Model.instance:getEnemyHP()
	local var_10_1 = tonumber(var_10_0)

	if arg_10_0._curTextValue == var_10_1 then
		return
	elseif arg_10_0._showingDamage then
		arg_10_0._showDamageQueue = arg_10_0._showDamageQueue and arg_10_0._showDamageQueue or {}
		arg_10_0._showDamageQueue[#arg_10_0._showDamageQueue + 1] = var_10_1
	else
		arg_10_0:_refreshHP(nil)
	end
end

function var_0_0._onOperateCard(arg_11_0)
	arg_11_0:_refreshOperateLeftTime()
end

function var_0_0._onTurnChanged(arg_12_0)
	arg_12_0:_refreshOperateLeftTime()
end

function var_0_0._onBuffsUpdated(arg_13_0, arg_13_1)
	if arg_13_1 then
		return
	end

	arg_13_0:_refreshBuffList()
end

function var_0_0._onGameReStart(arg_14_0)
	arg_14_0._initialHP = Activity188Model.instance:getEnemyInitialHP()

	arg_14_0:_refreshHP()
	arg_14_0:_refreshOperateLeftTime()
	arg_14_0:_refreshIcon()
	arg_14_0:_refreshBuffList()
	arg_14_0:_refreshSkillBtn()
end

function var_0_0._onShowGameTips(arg_15_0)
	arg_15_0:_onSkillClick()
end

function var_0_0._autoHideSkillTips(arg_16_0)
	arg_16_0:_onSkillHideClick()
end

function var_0_0._onRefreshCards(arg_17_0)
	arg_17_0:_refreshCardPair()
end

function var_0_0._editableInitView(arg_18_0)
	return
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._initialHP = Activity188Model.instance:getEnemyInitialHP()
	arg_19_0._txtHP.text = Activity188Model.instance:getEnemyHP()
	arg_19_0._curTextValue = Activity188Model.instance:getEnemyHP()
	arg_19_0._imageHP.fillAmount = 1

	arg_19_0:_refreshHP()
	arg_19_0:_refreshOperateLeftTime()
	arg_19_0:_refreshIcon()
	arg_19_0:_refreshBuffList()
	arg_19_0:_refreshSkillBtn()
end

function var_0_0._refreshIcon(arg_20_0)
	local var_20_0 = Activity188Model.instance:getCurGameId()
	local var_20_1 = Activity188Config.instance:getGameCfg(var_0_1, var_20_0).portrait

	if var_20_1 or var_20_1 ~= "" then
		arg_20_0._imageIcon:LoadImage(var_20_1)
	end
end

function var_0_0._refreshSkillBtn(arg_21_0)
	if not arg_21_0._gameCfg then
		local var_21_0 = Activity188Model.instance:getCurGameId()

		arg_21_0._gameCfg = Activity188Config.instance:getGameCfg(var_0_1, var_21_0)
	end

	arg_21_0._abilityIdList = Activity188Model.instance:getEnemyAbilityIds()

	gohelper.setActive(arg_21_0._btnSkill.gameObject, #arg_21_0._abilityIdList > 0)
end

function var_0_0._refreshTurns(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._txtTurn.text = string.format("%d/%d", arg_22_1, arg_22_2)
end

function var_0_0._refreshHP(arg_23_0, arg_23_1)
	local var_23_0 = Activity188Model.instance:getEnemyHP()
	local var_23_1 = arg_23_1 and arg_23_1 or tonumber(var_23_0)
	local var_23_2 = arg_23_0._curTextValue and arg_23_0._curTextValue or 0

	if var_23_2 == var_23_1 then
		return
	end

	if var_23_1 < var_23_2 and not arg_23_0._showingDamageEffect then
		arg_23_0._showingDamageEffect = true

		TaskDispatcher.runDelay(arg_23_0._resetShowDemageEffect, arg_23_0, 2.5)
		gohelper.setActive(arg_23_0._goDamageEffect, false)
		gohelper.setActive(arg_23_0._goDamageEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.enemyDamage)
		arg_23_0._viewAnimator:Play("damage1", nil, nil)
	end

	arg_23_0._showingDamage = true

	local var_23_3 = Activity188Model.instance:getEnemyHP()

	arg_23_0._curTextValue = var_23_3
	arg_23_0._txtHP.text = var_23_3

	local var_23_4 = tonumber(var_23_3) / arg_23_0._initialHP

	ZProj.TweenHelper.DOFillAmount(arg_23_0._imageHP, var_23_4, var_0_2)
	gohelper.setActive(arg_23_0._goHp, true)

	local var_23_5 = var_23_3 - var_23_2

	arg_23_0._textHpDiff.text = var_23_5 < 0 and var_23_5 or "+" .. var_23_5

	SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._textHpDiff, var_23_5 < 0 and "#E57279" or "#7AC886")
	TaskDispatcher.cancelTask(arg_23_0._hpChangeDone, arg_23_0)
	TaskDispatcher.runDelay(arg_23_0._hpChangeDone, arg_23_0, 1)
end

function var_0_0._resetShowDemageEffect(arg_24_0)
	arg_24_0._showingDamageEffect = false
end

function var_0_0._hpChangeDone(arg_25_0)
	arg_25_0._showingDamage = false

	gohelper.setActive(arg_25_0._goHp, false)

	if arg_25_0._showDamageQueue and #arg_25_0._showDamageQueue > 0 then
		local var_25_0 = arg_25_0._showDamageQueue[1]

		table.remove(arg_25_0._showDamageQueue, 1)
		arg_25_0:_refreshHP(var_25_0)
	end
end

function var_0_0._refreshOperateLeftTime(arg_26_0)
	local var_26_0 = Activity188Model.instance:getEnemyOperateTime()

	arg_26_0._txtRemainTime.text = var_26_0
end

function var_0_0._refreshCardPair(arg_27_0)
	local var_27_0 = Activity188Model.instance:getEnemyPairCount()

	arg_27_0._txtGotPairNum.text = var_27_0
end

function var_0_0._refreshBuffList(arg_28_0)
	arg_28_0._buffDataList = Activity188Model.instance:getBuffs(false)

	gohelper.CreateObjList(arg_28_0, arg_28_0._createBuffItem, arg_28_0._buffDataList, arg_28_0._goBuffRoot, arg_28_0._goBuffItem)
end

function var_0_0._createBuffItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	gohelper.setActive(arg_29_1, true)

	local var_29_0 = gohelper.findChildImage(arg_29_1, "#image_BuffIcon")
	local var_29_1 = Activity188Config.instance:getBuffCfg(var_0_1, arg_29_2.buffId)
	local var_29_2 = var_29_1.icon

	if string.nilorempty(var_29_2) or var_29_2 == "0" then
		-- block empty
	else
		UISpriteSetMgr.instance:setBuffSprite(var_29_0, tonumber(var_29_2))
	end

	local var_29_3 = arg_29_2.layer
	local var_29_4 = gohelper.findChildText(arg_29_1, "#txt_Num")

	gohelper.setActive(var_29_4.gameObject, var_29_1.laminate == XugoujiEnum.BuffType.Round or var_29_1.laminate == XugoujiEnum.BuffType.Layer)

	var_29_4.text = var_29_3
end

function var_0_0._createSkillItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	gohelper.setActive(arg_30_1, true)

	if arg_30_2.title then
		return
	end

	local var_30_0 = gohelper.findChildText(arg_30_1, "txt_Descr")
	local var_30_1 = gohelper.findChildImage(arg_30_1, "#image_Icon")

	var_30_0.text = arg_30_2.desc
end

function var_0_0._createBuffInfoItem(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	gohelper.setActive(arg_31_1, true)

	if arg_31_2.bg then
		return
	end

	local var_31_0 = Activity188Config.instance:getBuffCfg(var_0_1, arg_31_2.buffId)
	local var_31_1 = var_31_0.icon
	local var_31_2 = gohelper.findChildText(arg_31_1, "title/txt_name")
	local var_31_3 = gohelper.findChildImage(arg_31_1, "title/simage_Icon")

	var_31_2.text = var_31_0.name

	if not string.nilorempty(var_31_1) and var_31_1 == "0" then
		UISpriteSetMgr.instance:setBuffSprite(var_31_3, tonumber(var_31_1))
	end

	gohelper.findChildText(arg_31_1, "txt_desc").text = var_31_0.desc

	local var_31_4 = gohelper.findChildText(arg_31_1, "title/txt_name/go_tag/bg/txt_tagname")
	local var_31_5 = arg_31_2.layer
	local var_31_6 = ""

	if var_31_0.laminate == XugoujiEnum.BuffType.Round then
		var_31_6 = formatLuaLang("x_round", var_31_5)
	elseif var_31_0.laminate == XugoujiEnum.BuffType.Layer then
		var_31_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("activity188_mopup_layer"), {
			var_31_5
		})
	else
		local var_31_7 = gohelper.findChild(arg_31_1, "title/txt_name/go_tag")

		gohelper.setActive(var_31_7, false)
	end

	var_31_4.text = var_31_6
end

function var_0_0._createTargetList(arg_32_0)
	gohelper.CreateObjList(arg_32_0, arg_32_0._createTargetItem, arg_32_0._targetDataList, arg_32_0._gotargetItemRoot, arg_32_0._gotargetItem)
end

function var_0_0._createTargetItem(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	gohelper.setActive(arg_33_1, true)
end

function var_0_0._storyEnd(arg_34_0)
	return
end

function var_0_0.onClose(arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._resetShowDemageEffect, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._hpChangeDone, arg_35_0)
end

function var_0_0.onDestroyView(arg_36_0)
	arg_36_0._imageIcon:UnLoadImage()
end

return var_0_0
