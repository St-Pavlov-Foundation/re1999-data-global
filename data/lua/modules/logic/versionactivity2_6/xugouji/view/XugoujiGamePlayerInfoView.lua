module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGamePlayerInfoView", package.seeall)

local var_0_0 = class("XugoujiGamePlayerInfoView", BaseView)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_2 = 0.35

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goPlayerInfo = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Role")
	arg_1_0._imagePlayerIcon = gohelper.findChildImage(arg_1_0._goPlayerInfo, "Role/image/#simage_Role")
	arg_1_0._txtPlayerHP = gohelper.findChildText(arg_1_0._goPlayerInfo, "Role/image_RoleHPNumBG/#txt_RoleHP")
	arg_1_0._imagePlayerHP = gohelper.findChildImage(arg_1_0._goPlayerInfo, "Role/image_RoleHPBG/#image_RoleHPFG")
	arg_1_0._goHp = gohelper.findChild(arg_1_0._goPlayerInfo, "#go_HP")
	arg_1_0._textHpDiff = gohelper.findChildText(arg_1_0._goPlayerInfo, "#go_HP/#txt_HP")
	arg_1_0._goBuffRoot = gohelper.findChild(arg_1_0._goPlayerInfo, "#go_Buff")
	arg_1_0._goBuffItem = gohelper.findChild(arg_1_0._goBuffRoot, "#go_Buff")
	arg_1_0._txtRemainTime = gohelper.findChildText(arg_1_0._goPlayerInfo, "Remain/#txt_RemainValue")
	arg_1_0._txtGotPairNum = gohelper.findChildText(arg_1_0._goPlayerInfo, "Pairs/#txt_PairsValue")
	arg_1_0._skillRoot = gohelper.findChild(arg_1_0._goPlayerInfo, "#go_ViewSkillTips")
	arg_1_0._skillItemRoot = gohelper.findChild(arg_1_0._goPlayerInfo, "#go_ViewSkillTips/image_TipsBG")
	arg_1_0._skillItem = gohelper.findChild(arg_1_0._skillRoot, "image_TipsBG/#go_Item")
	arg_1_0._btnPlayerIcon = gohelper.findChildButtonWithAudio(arg_1_0._goPlayerInfo, "Role/image/#simage_Role")
	arg_1_0._btnSkill = gohelper.findChildButtonWithAudio(arg_1_0._goPlayerInfo, "Role/#btn_Skill")
	arg_1_0._btnSkillTipsHide = gohelper.findChildButtonWithAudio(arg_1_0._skillRoot, "#btnSkillTipsHide")
	arg_1_0._skillTipsAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._skillRoot)
	arg_1_0._btnBuff = gohelper.findChildButtonWithAudio(arg_1_0._goPlayerInfo, "#go_Buff")
	arg_1_0._buffInfoRoot = gohelper.findChild(arg_1_0._goPlayerInfo, "bufftipsview")
	arg_1_0._goBuffInfoContent = gohelper.findChild(arg_1_0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	arg_1_0._goBuffInfoItem = gohelper.findChild(arg_1_0._buffInfoRoot, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._btnBuffInfoClose = gohelper.findChildButtonWithAudio(arg_1_0._buffInfoRoot, "#btn_buffTipsHide")
	arg_1_0._goDamageEffect = gohelper.findChild(arg_1_0._goPlayerInfo, "#go_damage")
	arg_1_0._viewAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayerIcon:AddClickListener(arg_2_0._onPlayerIconClick, arg_2_0)
	arg_2_0._btnSkill:AddClickListener(arg_2_0._onSkillClick, arg_2_0)
	arg_2_0._btnBuff:AddClickListener(arg_2_0._onBuffClick, arg_2_0)
	arg_2_0._btnSkillTipsHide:AddClickListener(arg_2_0._onSkillHideClick, arg_2_0)
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
	arg_3_0._btnPlayerIcon:RemoveClickListener()
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

function var_0_0._onPlayerIconClick(arg_4_0)
	local var_4_0 = XugoujiGameStepController.instance

	if var_4_0 then
		var_4_0:nextStep()
	end
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
	arg_5_0._abilityIdList = Activity188Model.instance:getPlayerAbilityIds()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._abilityIdList) do
		local var_5_1 = Activity188Config.instance:getAbilityCfg(var_0_1, iter_5_1)

		arg_5_0._abilityCfgList[iter_5_0 + 1] = var_5_1
	end

	gohelper.setActive(arg_5_0._skillRoot, true)
	gohelper.setActive(arg_5_0._btnSkillTipsHide.gameObject, true)
	arg_5_0._skillTipsAnimator:Play(UIAnimationName.Open, nil, nil)
	gohelper.CreateObjList(arg_5_0, arg_5_0._createSkillItem, arg_5_0._abilityCfgList, arg_5_0._skillItemRoot, arg_5_0._skillItem)
end

function var_0_0._onSkillHideClick(arg_6_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HideSkillTips)
	gohelper.setActive(arg_6_0._btnSkillTipsHide.gameObject, false)
	arg_6_0._skillTipsAnimator:Play(UIAnimationName.Close, arg_6_0.onSkillTipsCloseAniFinish, arg_6_0)
end

function var_0_0.onSkillTipsCloseAniFinish(arg_7_0)
	gohelper.setActive(arg_7_0._skillRoot, false)
end

function var_0_0._onBuffClick(arg_8_0)
	arg_8_0._buffDataList = Activity188Model.instance:getBuffs(true)

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
	arg_10_0:_refreshPlayerHP()
end

function var_0_0._onOperateCard(arg_11_0)
	arg_11_0:_refreshOperateLeftTime()
end

function var_0_0._onTurnChanged(arg_12_0)
	arg_12_0:_refreshOperateLeftTime()
end

function var_0_0._onGotCardPair(arg_13_0)
	arg_13_0:_refreshOperateLeftTime()
end

function var_0_0._onBuffsUpdated(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_0:_refreshBuffList()
end

function var_0_0._onGameReStart(arg_15_0)
	arg_15_0:_refreshBuffList()
	arg_15_0:_refreshOperateLeftTime()

	arg_15_0._initialHP = Activity188Model.instance:getPlayerInitialHP()

	arg_15_0:_refreshPlayerHP()
	arg_15_0:_refreshSkillBtn()
end

function var_0_0._onShowGameTips(arg_16_0)
	arg_16_0:_onSkillClick()
end

function var_0_0._autoHideSkillTips(arg_17_0)
	arg_17_0:_onSkillHideClick()
end

function var_0_0._onRefreshCards(arg_18_0)
	arg_18_0:_refreshCardPair()
end

function var_0_0._editableInitView(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:_refreshBuffList()
	arg_20_0:_refreshOperateLeftTime()

	arg_20_0._initialHP = Activity188Model.instance:getPlayerInitialHP()
	arg_20_0._txtPlayerHP.text = Activity188Model.instance:getCurHP()
	arg_20_0._imagePlayerHP.fillAmount = 1

	arg_20_0:_refreshPlayerHP()
	arg_20_0:_refreshSkillBtn()
end

function var_0_0._refreshPlayerHP(arg_21_0)
	local var_21_0 = tonumber(arg_21_0._txtPlayerHP.text)
	local var_21_1 = tonumber(Activity188Model.instance:getCurHP())

	if var_21_0 == var_21_1 then
		return
	end

	if var_21_1 < var_21_0 and not arg_21_0._showingDamage then
		arg_21_0._showingDamage = true

		TaskDispatcher.runDelay(arg_21_0._resetShowDemageEffect, arg_21_0, 2.5)
		gohelper.setActive(arg_21_0._goDamageEffect, false)
		gohelper.setActive(arg_21_0._goDamageEffect, true)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.playerDamage)
		arg_21_0._viewAnimator:Play("damage2", nil, nil)
	end

	arg_21_0._txtPlayerHP.text = var_21_1

	local var_21_2 = var_21_1 / arg_21_0._initialHP

	ZProj.TweenHelper.DOFillAmount(arg_21_0._imagePlayerHP, var_21_2, var_0_2)
	gohelper.setActive(arg_21_0._goHp, true)

	local var_21_3 = var_21_1 - var_21_0

	arg_21_0._textHpDiff.text = var_21_3 < 0 and var_21_3 or "+" .. var_21_3

	SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._textHpDiff, var_21_3 < 0 and "#E57279" or "#7AC886")
	TaskDispatcher.cancelTask(arg_21_0._delayHideHpChange, arg_21_0)
	TaskDispatcher.runDelay(arg_21_0._delayHideHpChange, arg_21_0, 1)
end

function var_0_0._resetShowDemageEffect(arg_22_0)
	arg_22_0._showingDamage = false
end

function var_0_0._delayHideHpChange(arg_23_0)
	gohelper.setActive(arg_23_0._goHp, false)
end

function var_0_0._refreshOperateLeftTime(arg_24_0)
	local var_24_0 = Activity188Model.instance:getCurTurnOperateTime()

	arg_24_0._txtRemainTime.text = var_24_0
end

function var_0_0._refreshSkillBtn(arg_25_0)
	if not arg_25_0._gameCfg then
		local var_25_0 = Activity188Model.instance:getCurGameId()

		arg_25_0._gameCfg = Activity188Config.instance:getGameCfg(var_0_1, var_25_0)
	end

	arg_25_0._abilityIdList = Activity188Model.instance:getPlayerAbilityIds()

	gohelper.setActive(arg_25_0._btnSkill.gameObject, #arg_25_0._abilityIdList > 0)
end

function var_0_0._refreshCardPair(arg_26_0)
	local var_26_0 = Activity188Model.instance:getCurPairCount()

	arg_26_0._txtGotPairNum.text = var_26_0
end

function var_0_0._refreshBuffList(arg_27_0)
	arg_27_0._buffDataList = Activity188Model.instance:getBuffs(true)

	gohelper.CreateObjList(arg_27_0, arg_27_0._createBuffItem, arg_27_0._buffDataList, arg_27_0._goBuffRoot, arg_27_0._goBuffItem)
end

function var_0_0._createBuffItem(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	gohelper.setActive(arg_28_1, true)

	local var_28_0 = gohelper.findChildImage(arg_28_1, "#image_BuffIcon")
	local var_28_1 = Activity188Config.instance:getBuffCfg(var_0_1, arg_28_2.buffId)
	local var_28_2 = var_28_1.icon

	if string.nilorempty(var_28_2) or var_28_2 == "0" then
		-- block empty
	else
		UISpriteSetMgr.instance:setBuffSprite(var_28_0, tonumber(var_28_2))
	end

	local var_28_3 = arg_28_2.layer
	local var_28_4 = gohelper.findChildText(arg_28_1, "#txt_Num")

	gohelper.setActive(var_28_4.gameObject, var_28_1.laminate == XugoujiEnum.BuffType.Round or var_28_1.laminate == XugoujiEnum.BuffType.Layer)

	var_28_4.text = var_28_3
end

function var_0_0._createSkillItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	gohelper.setActive(arg_29_1, true)

	if arg_29_2.title then
		return
	end

	local var_29_0 = gohelper.findChildText(arg_29_1, "txt_Descr")
	local var_29_1 = gohelper.findChildImage(arg_29_1, "#image_Icon")

	var_29_0.text = arg_29_2.desc
end

function var_0_0._createBuffInfoItem(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	gohelper.setActive(arg_30_1, true)

	if arg_30_2.bg then
		return
	end

	local var_30_0 = Activity188Config.instance:getBuffCfg(var_0_1, arg_30_2.buffId)
	local var_30_1 = var_30_0.icon
	local var_30_2 = gohelper.findChildText(arg_30_1, "title/txt_name")
	local var_30_3 = gohelper.findChildImage(arg_30_1, "title/simage_Icon")

	var_30_2.text = var_30_0.name

	if not string.nilorempty(var_30_1) and var_30_1 == "0" then
		UISpriteSetMgr.instance:setBuffSprite(var_30_3, tonumber(var_30_1))
	end

	gohelper.findChildText(arg_30_1, "txt_desc").text = var_30_0.desc

	local var_30_4 = gohelper.findChildText(arg_30_1, "title/txt_name/go_tag/bg/txt_tagname")
	local var_30_5 = arg_30_2.layer
	local var_30_6 = ""

	if var_30_0.laminate == XugoujiEnum.BuffType.Round then
		var_30_6 = formatLuaLang("x_round", var_30_5)
	elseif var_30_0.laminate == XugoujiEnum.BuffType.Layer then
		var_30_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("activity188_mopup_layer"), {
			var_30_5
		})
	else
		local var_30_7 = gohelper.findChild(arg_30_1, "title/txt_name/go_tag")

		gohelper.setActive(var_30_7, false)
	end

	var_30_4.text = var_30_6
end

function var_0_0.onClose(arg_31_0)
	return
end

function var_0_0.onDestroyView(arg_32_0)
	return
end

return var_0_0
