module("modules.logic.weekwalk_2.view.WeekWalk_2HeartResultView", package.seeall)

local var_0_0 = class("WeekWalk_2HeartResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagePanelBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG1")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG1/#simage_PanelBG2")
	arg_1_0._goPanel = gohelper.findChild(arg_1_0.viewGO, "#go_Panel")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_left")
	arg_1_0._simagemaskImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Panel/#go_left/#simage_maskImage")
	arg_1_0._goAttack = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_Attack")
	arg_1_0._txtattackNum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data1/#txt_attackNum1")
	arg_1_0._txtattackNum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data2/#txt_attackNum2")
	arg_1_0._txtattackNum3 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Attack/LayoutGroup/Data3/#txt_attackNum3")
	arg_1_0._goHealth = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_Health")
	arg_1_0._txthealthNum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data1/#txt_healthNum1")
	arg_1_0._txthealthNum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Health/LayoutGroup/Data2/#txt_healthNum2")
	arg_1_0._goDefence = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_Defence")
	arg_1_0._txtdefenceNum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data1/#txt_defenceNum1")
	arg_1_0._txtdefenceNum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_Defence/LayoutGroup/Data2/#txt_defenceNum2")
	arg_1_0._goRoleData = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_RoleData")
	arg_1_0._simageRoleattack = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Attack/skinnode/node/#simage_Roleattack")
	arg_1_0._txtNumattack1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data1/#txt_Numattack1")
	arg_1_0._txtNumattack2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data2/#txt_Numattack2")
	arg_1_0._txtNumattack3 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Attack/LayoutGroup/Data3/#txt_Numattack3")
	arg_1_0._simageRolehealth = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Health/skinnode/node/#simage_Rolehealth")
	arg_1_0._txtNumhealth1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data1/#txt_Numhealth1")
	arg_1_0._txtNumhealth2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Health/LayoutGroup/Data2/#txt_Numhealth2")
	arg_1_0._simageRoledefence = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Defence/skinnode/node/#simage_Roledefence")
	arg_1_0._txtNumdefence1 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data1/#txt_Numdefence1")
	arg_1_0._txtNumdefence2 = gohelper.findChildText(arg_1_0.viewGO, "#go_Panel/#go_RoleData/Defence/LayoutGroup/Data2/#txt_Numdefence2")
	arg_1_0._goCupData = gohelper.findChild(arg_1_0.viewGO, "#go_Panel/#go_CupData")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Panel/#btn_click")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "#btn_skip/#image_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	arg_4_0._index = WeekWalk_2Enum.ResultAnimIndex.CupData

	arg_4_0:_updateStatus()
end

function var_0_0._btnclickOnClick(arg_5_0)
	arg_5_0:_showNext()
end

function var_0_0._showNext(arg_6_0)
	arg_6_0._index = arg_6_0._index + 1

	if arg_6_0._index > #arg_6_0._showHandler then
		arg_6_0:closeThis()

		return
	end

	arg_6_0:_updateStatus()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent("Animator")
	arg_7_0._index = 1
	arg_7_0._showHandler = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = arg_7_0._showAttack,
		[WeekWalk_2Enum.ResultAnimIndex.Health] = arg_7_0._showHealth,
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = arg_7_0._showDefence,
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = arg_7_0._showRoleData,
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = arg_7_0._showCupData
	}
	arg_7_0._showStatusInfo = {}
	arg_7_0._animName = {
		[WeekWalk_2Enum.ResultAnimIndex.Attack] = "attack",
		[WeekWalk_2Enum.ResultAnimIndex.Health] = "health",
		[WeekWalk_2Enum.ResultAnimIndex.Defence] = "defence",
		[WeekWalk_2Enum.ResultAnimIndex.RoleData] = "roledata",
		[WeekWalk_2Enum.ResultAnimIndex.CupData] = "cupdata"
	}

	arg_7_0:_initSpineNodes()
end

function var_0_0._initSpineNodes(arg_8_0)
	arg_8_0._gospine = gohelper.findChild(arg_8_0._goleft, "spineContainer/spine")
	arg_8_0._uiSpine = GuiModelAgent.Create(arg_8_0._gospine, true)

	arg_8_0._uiSpine:useRT()

	arg_8_0._txtSayCn = gohelper.findChildText(arg_8_0._goleft, "txtSayCn")
	arg_8_0._txtSayEn = gohelper.findChildText(arg_8_0._goleft, "SayEn/txtSayEn")
	arg_8_0._txtSayCn.text = ""
	arg_8_0._txtSayEn.text = ""
end

function var_0_0._hideSpine(arg_9_0)
	if arg_9_0._uiSpine then
		arg_9_0._uiSpine:stopVoice()
	end

	gohelper.setActive(arg_9_0._goleft, false)
end

function var_0_0._showSpine(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goleft, true)

	if arg_10_0._uiSpine then
		arg_10_0._uiSpine:stopVoice()
	end

	local var_10_0 = HeroModel.instance:getByHeroId(arg_10_1)
	local var_10_1 = var_10_0 and lua_skin.configDict[var_10_0.skin]

	if not var_10_1 then
		return
	end

	arg_10_0._heorId = arg_10_1
	arg_10_0._skinId = var_10_1.id

	arg_10_0._uiSpine:setImgPos(0)
	arg_10_0._uiSpine:setResPath(var_10_1, function()
		arg_10_0._spineLoaded = true
	end, arg_10_0)

	local var_10_2, var_10_3 = SkinConfig.instance:getSkinOffset(var_10_1.fightSuccViewOffset)

	if var_10_3 then
		var_10_2, _ = SkinConfig.instance:getSkinOffset(var_10_1.characterViewOffset)
		var_10_2 = SkinConfig.instance:getAfterRelativeOffset(504, var_10_2)
	end

	local var_10_4 = tonumber(var_10_2[3])
	local var_10_5 = tonumber(var_10_2[1])
	local var_10_6 = tonumber(var_10_2[2])

	recthelper.setAnchor(arg_10_0._gospine.transform, var_10_5, var_10_6)
	transformhelper.setLocalScale(arg_10_0._gospine.transform, var_10_4, var_10_4, var_10_4)
end

function var_0_0._playSpineVoice(arg_12_0)
	local var_12_0 = HeroModel.instance:getVoiceConfig(arg_12_0._heorId, CharacterEnum.VoiceType.FightResult, nil, arg_12_0._skinId) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_12_0._heorId, CharacterEnum.VoiceType.FightResult, arg_12_0._skinId)

	if var_12_0 and #var_12_0 > 0 then
		local var_12_1 = var_12_0[1]

		arg_12_0._uiSpine:playVoice(var_12_1, nil, arg_12_0._txtSayCn, arg_12_0._txtSayEn)
	end
end

function var_0_0._updateStatus(arg_13_0)
	gohelper.setActive(arg_13_0._goAttack, true)
	gohelper.setActive(arg_13_0._goHealth, true)
	gohelper.setActive(arg_13_0._goDefence, true)
	gohelper.setActive(arg_13_0._goRoleData, true)
	gohelper.setActive(arg_13_0._goCupData, true)
	gohelper.setActive(arg_13_0._btnskip, arg_13_0._index ~= WeekWalk_2Enum.ResultAnimIndex.CupData)

	local var_13_0 = arg_13_0._showHandler[arg_13_0._index](arg_13_0)

	arg_13_0._showStatusInfo[arg_13_0._index] = var_13_0

	if not var_13_0 then
		if arg_13_0._index ~= WeekWalk_2Enum.ResultAnimIndex.Attack then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
		end

		if arg_13_0._index == WeekWalk_2Enum.ResultAnimIndex.Defence and arg_13_0._showStatusInfo[WeekWalk_2Enum.ResultAnimIndex.Health] then
			arg_13_0._animator:Play("go_" .. arg_13_0._animName[arg_13_0._index] .. "2", 0, 0)

			return
		end

		if arg_13_0._index == WeekWalk_2Enum.ResultAnimIndex.CupData and arg_13_0._prevIndex ~= WeekWalk_2Enum.ResultAnimIndex.RoleData then
			arg_13_0._animator:Play("cupdata2", 0, 0)

			return
		end

		arg_13_0._animator:Play("go_" .. arg_13_0._animName[arg_13_0._index], 0, 0)

		arg_13_0._prevIndex = arg_13_0._index
	else
		arg_13_0:_showNext()
	end
end

function var_0_0._showAttack(arg_14_0)
	gohelper.setActive(arg_14_0._goAttack, true)

	local var_14_0 = arg_14_0._info.harmHero

	arg_14_0._txtattackNum1.text = var_14_0.battleNum
	arg_14_0._txtattackNum2.text = var_14_0.allHarm
	arg_14_0._txtattackNum3.text = var_14_0.singleHighHarm

	arg_14_0:_showSpine(var_14_0.heroId)
end

local var_0_1 = 0.2

function var_0_0._showHealth(arg_15_0)
	gohelper.setActive(arg_15_0._goHealth, true)

	local var_15_0 = arg_15_0._info.healHero

	if tonumber(var_15_0.allHeal) <= 0 then
		return true
	end

	arg_15_0._txthealthNum1.text = var_15_0.battleNum
	arg_15_0._txthealthNum2.text = var_15_0.allHeal
	arg_15_0._spineHeroId = var_15_0.heroId

	TaskDispatcher.cancelTask(arg_15_0._delayShowSpine, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._delayShowSpine, arg_15_0, var_0_1)
end

function var_0_0._showDefence(arg_16_0)
	gohelper.setActive(arg_16_0._goDefence, true)

	local var_16_0 = arg_16_0._info.hurtHero

	arg_16_0._txtdefenceNum1.text = var_16_0.battleNum
	arg_16_0._txtdefenceNum2.text = var_16_0.allHurt
	arg_16_0._spineHeroId = var_16_0.heroId

	TaskDispatcher.cancelTask(arg_16_0._delayShowSpine, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0._delayShowSpine, arg_16_0, var_0_1)
end

function var_0_0._delayShowSpine(arg_17_0)
	if arg_17_0._uiSpine then
		local var_17_0 = arg_17_0._uiSpine:getSpineGo()

		gohelper.setActive(var_17_0, false)
	end

	arg_17_0:_showSpine(arg_17_0._spineHeroId)
end

function var_0_0._showRoleData(arg_18_0)
	arg_18_0:_hideSpine()
	gohelper.setActive(arg_18_0._goRoleData, true)

	local var_18_0 = arg_18_0._info.harmHero
	local var_18_1 = arg_18_0._info.healHero
	local var_18_2 = arg_18_0._info.hurtHero

	arg_18_0._txtNumattack1.text = var_18_0.battleNum
	arg_18_0._txtNumattack2.text = var_18_0.allHarm
	arg_18_0._txtNumattack3.text = var_18_0.singleHighHarm
	arg_18_0._txtNumhealth1.text = var_18_1.battleNum
	arg_18_0._txtNumhealth2.text = var_18_1.allHeal

	if tonumber(var_18_1.allHeal) <= 0 then
		local var_18_3 = gohelper.findChild(arg_18_0.viewGO, "#go_Panel/#go_RoleData/Health")

		gohelper.setActive(var_18_3, false)

		local var_18_4 = gohelper.findChild(arg_18_0.viewGO, "#go_Panel/#go_RoleData/Attack")
		local var_18_5 = gohelper.findChild(arg_18_0.viewGO, "#go_Panel/#go_RoleData/Defence")
		local var_18_6 = gohelper.findChild(arg_18_0.viewGO, "#go_Panel/#go_RoleData/2/Attack")
		local var_18_7 = gohelper.findChild(arg_18_0.viewGO, "#go_Panel/#go_RoleData/2/Defence")

		gohelper.addChild(var_18_6, var_18_4)
		gohelper.addChild(var_18_7, var_18_5)
		recthelper.setAnchor(var_18_4.transform, 0, 0)
		recthelper.setAnchor(var_18_5.transform, 0, 0)
	end

	arg_18_0._txtNumdefence1.text = var_18_2.battleNum
	arg_18_0._txtNumdefence2.text = var_18_2.allHurt

	local var_18_8 = HeroModel.instance:getByHeroId(var_18_0.heroId)

	if var_18_8 then
		arg_18_0:_loadRoleImage(arg_18_0._simageRoleattack, var_18_8.skin)
	end

	gohelper.setActive(arg_18_0._simageRoleattack, var_18_8 ~= nil)

	local var_18_9 = HeroModel.instance:getByHeroId(var_18_1.heroId)

	if var_18_9 then
		arg_18_0:_loadRoleImage(arg_18_0._simageRolehealth, var_18_9.skin)
	end

	gohelper.setActive(arg_18_0._simageRolehealth, var_18_9 ~= nil)

	local var_18_10 = HeroModel.instance:getByHeroId(var_18_2.heroId)

	if var_18_10 then
		arg_18_0:_loadRoleImage(arg_18_0._simageRoledefence, var_18_10.skin)
	end

	gohelper.setActive(arg_18_0._simageRoledefence, var_18_10 ~= nil)
end

function var_0_0._loadRoleImage(arg_19_0, arg_19_1, arg_19_2)
	local function var_19_0()
		local var_20_0 = SkinConfig.instance:getSkinCo(arg_19_2)

		ZProj.UGUIHelper.SetImageSize(arg_19_1.gameObject)

		local var_20_1 = var_20_0.lucidescapeViewImgOffset

		if string.nilorempty(var_20_1) then
			var_20_1 = var_20_0.playercardViewImgOffset
		end

		if string.nilorempty(var_20_1) then
			var_20_1 = var_20_0.characterViewImgOffset
		end

		if not string.nilorempty(var_20_1) then
			local var_20_2 = string.splitToNumber(var_20_1, "#")

			recthelper.setAnchor(arg_19_1.transform, tonumber(var_20_2[1]), tonumber(var_20_2[2]))
			transformhelper.setLocalScale(arg_19_1.transform, tonumber(var_20_2[3]), tonumber(var_20_2[3]), tonumber(var_20_2[3]))
		end
	end

	arg_19_1:LoadImage(ResUrl.getHeadIconImg(arg_19_2), var_19_0)
end

function var_0_0._showCupData(arg_21_0)
	gohelper.setActive(arg_21_0._goCupData, true)

	local var_21_0 = arg_21_0._info.layerInfos

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		arg_21_0:_showLayerInfo(iter_21_1.config.layer, iter_21_1)
	end
end

function var_0_0._showLayerInfo(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2.config

	arg_22_0:_showLayerBattleInfo(arg_22_1, 1, arg_22_2.battleInfos[var_22_0.fightIdFront], arg_22_2)
	arg_22_0:_showLayerBattleInfo(arg_22_1, 2, arg_22_2.battleInfos[var_22_0.fightIdRear], arg_22_2)
end

function var_0_0._showLayerBattleInfo(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = gohelper.findChild(arg_23_0._goCupData, tostring(arg_23_1))
	local var_23_1 = gohelper.findChild(var_23_0, "Level/" .. tostring(arg_23_2))

	if arg_23_2 == 1 then
		gohelper.findChildText(var_23_0, "battlename").text = arg_23_4.sceneConfig.battleName
	end

	local var_23_2 = gohelper.findChild(var_23_1, "badgelayout/1")
	local var_23_3 = gohelper.cloneInPlace(var_23_2)
	local var_23_4 = gohelper.cloneInPlace(var_23_2)

	arg_23_0:_showBattleCup(var_23_2, arg_23_3.cupInfos[1])
	arg_23_0:_showBattleCup(var_23_3, arg_23_3.cupInfos[2])
	arg_23_0:_showBattleCup(var_23_4, arg_23_3.cupInfos[3])
end

function var_0_0._showBattleCup(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = (arg_24_2 and arg_24_2.result or 0) > 0
	local var_24_1 = gohelper.findChild(arg_24_1, "1")

	gohelper.setActive(var_24_1, var_24_0)

	if not var_24_0 then
		return
	end

	local var_24_2 = gohelper.findChildImage(arg_24_1, "1")

	var_24_2.enabled = false

	local var_24_3 = arg_24_0:getResInst(arg_24_0.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_24_2.gameObject)

	WeekWalk_2Helper.setCupEffect(var_24_3, arg_24_2)
end

function var_0_0.onUpdateParam(arg_25_0)
	return
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0._info = WeekWalk_2Model.instance:getSettleInfo()

	arg_26_0:_showEndingAnim()
	arg_26_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnShowSkin, arg_26_0._onShowSkin, arg_26_0)
end

function var_0_0._onShowSkin(arg_27_0, arg_27_1)
	arg_27_0:_loadRoleImage(arg_27_0._simageRoledefence, arg_27_1)
end

function var_0_0._showEndingAnim(arg_28_0)
	gohelper.setActive(arg_28_0._goweekwalkending, true)
	gohelper.setActive(arg_28_0._goPanel, false)
	gohelper.setActive(arg_28_0._goAttack, false)
	gohelper.setActive(arg_28_0._goHealth, false)
	gohelper.setActive(arg_28_0._goDefence, false)
	gohelper.setActive(arg_28_0._goRoleData, false)
	gohelper.setActive(arg_28_0._goCupData, false)
	arg_28_0:_showInfos()
end

function var_0_0._showInfos(arg_29_0)
	gohelper.setActive(arg_29_0._goweekwalkending, false)
	gohelper.setActive(arg_29_0._goPanel, true)
	arg_29_0:_updateStatus()
end

function var_0_0.onClose(arg_30_0)
	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)

	if arg_30_0._uiSpine then
		arg_30_0._uiSpine:stopVoice()
	end

	WeekWalk_2Model.instance:clearSettleInfo()
	TaskDispatcher.cancelTask(arg_30_0._delayShowSpine, arg_30_0)
end

function var_0_0.onDestroyView(arg_31_0)
	return
end

return var_0_0
