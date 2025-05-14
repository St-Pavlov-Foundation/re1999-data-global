module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessView", package.seeall)

local var_0_0 = class("RougeFightSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospineContainer = gohelper.findChild(arg_1_0.viewGO, "left/#go_spineContainer")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "left/#go_spineContainer/#go_spine")
	arg_1_0._txtsayCn = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_sayCn")
	arg_1_0._txtsayEn = gohelper.findChildText(arg_1_0.viewGO, "left/SayEn/#txt_sayEn")
	arg_1_0._btndata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_data")
	arg_1_0._txtepisodeNameEn = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_episodeNameEn")
	arg_1_0._txtepisodeName = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_episodeName")
	arg_1_0._txtexp = gohelper.findChildText(arg_1_0.viewGO, "right/rouge/exp/#txt_exp")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "right/rouge/exp/#slider_progress")
	arg_1_0._txtaddexp = gohelper.findChildText(arg_1_0.viewGO, "right/rouge/exp/#slider_progress/#txt_addexp")
	arg_1_0._imageAddExp = gohelper.findChildImage(arg_1_0.viewGO, "right/rouge/exp/#slider_progress/#image_addexp")
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "right/rouge/exp/#txt_lv")
	arg_1_0._imagefaction = gohelper.findChildImage(arg_1_0.viewGO, "right/rouge/exp/faction/#image_faction")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "right/rouge/role/layout/#go_heroitem")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_0.viewGO, "right/rouge/role/layout/heroitem/#slider_hp")
	arg_1_0._simagerolehead = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/rouge/role/layout/heroitem/hero/#simage_rolehead")
	arg_1_0._godead = gohelper.findChild(arg_1_0.viewGO, "right/rouge/role/layout/heroitem/#go_dead")
	arg_1_0._txtcollectionnum = gohelper.findChildText(arg_1_0.viewGO, "right/rouge/reward/collection/#txt_collectionnum")
	arg_1_0._txtcoinnum = gohelper.findChildText(arg_1_0.viewGO, "right/rouge/reward/coin/#txt_coinnum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndata:AddClickListener(arg_2_0._btndataOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndata:RemoveClickListener()
end

function var_0_0._btndataOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.rectTrImageAddExp = arg_5_0._imageAddExp:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.sliderRectTr = arg_5_0._sliderprogress:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.sliderWidth = recthelper.getWidth(arg_5_0.sliderRectTr)
	arg_5_0.bgClick = gohelper.findChildClickWithDefaultAudio(arg_5_0.viewGO, "bg")

	arg_5_0.bgClick:AddClickListener(arg_5_0.onClickBg, arg_5_0)

	arg_5_0.spineTr = arg_5_0._gospine.transform
	arg_5_0._txtsayCn.text = ""
	arg_5_0._txtsayEn.text = ""

	gohelper.setActive(arg_5_0._goheroitem, false)
end

function var_0_0.onClickBg(arg_6_0)
	if arg_6_0.uiSpine then
		arg_6_0.uiSpine:stopVoice()
	end

	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshLeft()
	arg_8_0:refreshRight()
end

function var_0_0.refreshLeft(arg_9_0)
	arg_9_0:refreshSpine()
end

function var_0_0.refreshRight(arg_10_0)
	arg_10_0:refreshEpisodeInfo()
	arg_10_0:refreshRougeInfo()
end

function var_0_0.refreshSpine(arg_11_0)
	local var_11_0 = arg_11_0:getRandomEntityMo()

	arg_11_0.skinCO = arg_11_0:getSkinCo(var_11_0)
	arg_11_0.randomHeroId = var_11_0.modelId
	arg_11_0.randomSkinId = var_11_0.skin
	arg_11_0.spineLoaded = false
	arg_11_0.uiSpine = GuiModelAgent.Create(arg_11_0._gospine, true)

	arg_11_0.uiSpine:useRT()
	arg_11_0.uiSpine:setImgPos(0)
	arg_11_0.uiSpine:setResPath(arg_11_0.skinCO, arg_11_0.onSpineLoaded, arg_11_0)
end

function var_0_0.onSpineLoaded(arg_12_0)
	if arg_12_0.closeed then
		return
	end

	arg_12_0.spineLoaded = true

	arg_12_0.uiSpine:setUIMask(true)
	arg_12_0.uiSpine:setAllLayer(UnityLayer.UI)
	arg_12_0:playSpineVoice()
	arg_12_0:setSkinOffset()
end

function var_0_0.setSkinOffset(arg_13_0)
	local var_13_0, var_13_1 = SkinConfig.instance:getSkinOffset(arg_13_0.skinCO.fightSuccViewOffset)

	if var_13_1 then
		var_13_0, _ = SkinConfig.instance:getSkinOffset(arg_13_0.skinCO.characterViewOffset)
		var_13_0 = SkinConfig.instance:getAfterRelativeOffset(504, var_13_0)
	end

	local var_13_2 = tonumber(var_13_0[3])
	local var_13_3 = tonumber(var_13_0[1])
	local var_13_4 = tonumber(var_13_0[2])

	recthelper.setAnchor(arg_13_0.spineTr, var_13_3, var_13_4)
	transformhelper.setLocalScale(arg_13_0.spineTr, var_13_2, var_13_2, var_13_2)
end

function var_0_0.playSpineVoice(arg_14_0)
	local var_14_0 = HeroModel.instance:getVoiceConfig(arg_14_0.randomHeroId, CharacterEnum.VoiceType.FightResult, nil, arg_14_0.randomSkinId) or FightAudioMgr.instance:_getHeroVoiceCOs(arg_14_0.randomHeroId, CharacterEnum.VoiceType.FightResult, arg_14_0.randomSkinId)

	if var_14_0 and #var_14_0 > 0 then
		local var_14_1 = var_14_0[1]

		arg_14_0.uiSpine:playVoice(var_14_1, nil, arg_14_0._txtsayCn, arg_14_0._txtsayEn)
	end
end

function var_0_0.getRandomEntityMo(arg_15_0)
	local var_15_0 = FightDataHelper.entityMgr:getMyNormalList()
	local var_15_1 = FightDataHelper.entityMgr:getMySubList()
	local var_15_2 = FightDataHelper.entityMgr:getMyDeadList()
	local var_15_3 = {}

	tabletool.addValues(var_15_3, var_15_0)
	tabletool.addValues(var_15_3, var_15_1)
	tabletool.addValues(var_15_3, var_15_2)

	for iter_15_0 = #var_15_3, 1, -1 do
		local var_15_4 = var_15_3[iter_15_0]

		if not arg_15_0:getSkinCo(var_15_4) then
			table.remove(var_15_3, iter_15_0)
		end
	end

	local var_15_5 = {}

	tabletool.addValues(var_15_5, var_15_3)

	for iter_15_1 = #var_15_5, 1, -1 do
		local var_15_6 = var_15_3[iter_15_1]
		local var_15_7 = FightAudioMgr.instance:_getHeroVoiceCOs(var_15_6.modelId, CharacterEnum.VoiceType.FightResult)

		if var_15_7 and #var_15_7 > 0 then
			if var_15_6:isMonster() then
				table.remove(var_15_5, iter_15_1)
			end
		else
			table.remove(var_15_5, iter_15_1)
		end
	end

	if #var_15_5 > 0 then
		return var_15_5[math.random(#var_15_5)]
	elseif #var_15_3 > 0 then
		return var_15_3[math.random(#var_15_3)]
	else
		logError("没有角色")
	end
end

function var_0_0.getSkinCo(arg_16_0, arg_16_1)
	local var_16_0 = FightConfig.instance:getSkinCO(arg_16_1.skin)
	local var_16_1 = var_16_0 and not string.nilorempty(var_16_0.verticalDrawing)
	local var_16_2 = var_16_0 and not string.nilorempty(var_16_0.live2d)

	if var_16_1 or var_16_2 then
		return var_16_0
	end
end

function var_0_0.refreshEpisodeInfo(arg_17_0)
	local var_17_0 = FightResultModel.instance.episodeId
	local var_17_1 = DungeonConfig.instance:getEpisodeCO(var_17_0)

	arg_17_0._txtepisodeNameEn.text = var_17_1.name_En
	arg_17_0._txtepisodeName.text = var_17_1.name
end

function var_0_0.refreshRougeInfo(arg_18_0)
	arg_18_0.fightResultInfo = RougeModel.instance:getFightResultInfo()
	arg_18_0.rougeInfo = RougeModel.instance:getRougeInfo()
	arg_18_0.season = arg_18_0.rougeInfo.season

	arg_18_0:refreshStyle()
	arg_18_0:refreshLv()
	arg_18_0:refreshHero()
	arg_18_0:refreshDrop()
end

function var_0_0.refreshStyle(arg_19_0)
	local var_19_0 = arg_19_0.rougeInfo.style
	local var_19_1 = lua_rouge_style.configDict[arg_19_0.season][var_19_0]

	UISpriteSetMgr.instance:setRouge2Sprite(arg_19_0._imagefaction, string.format("%s_light", var_19_1.icon))
end

function var_0_0.refreshLv(arg_20_0)
	local var_20_0 = arg_20_0.rougeInfo.teamLevel
	local var_20_1 = arg_20_0.rougeInfo.teamExp
	local var_20_2 = arg_20_0.fightResultInfo.addExp
	local var_20_3 = lua_rouge_level.configDict[arg_20_0.season][var_20_0 + 1]

	if not var_20_3 then
		gohelper.setActive(arg_20_0._txtaddexp.gameObject, false)

		var_20_3 = lua_rouge_level.configDict[arg_20_0.season][var_20_0]

		local var_20_4 = var_20_3.exp

		arg_20_0:_refreshLv(var_20_0, var_20_4, var_20_4)
		arg_20_0._sliderprogress:SetValue(1)
		recthelper.setWidth(arg_20_0.rectTrImageAddExp, 0)

		return
	end

	gohelper.setActive(arg_20_0._txtaddexp.gameObject, true)

	local var_20_5 = var_20_3.exp

	arg_20_0:_refreshLv(var_20_0, var_20_2, var_20_5)
	arg_20_0._sliderprogress:SetValue(var_20_1 / var_20_5)
	recthelper.setWidth(arg_20_0.rectTrImageAddExp, 0)

	arg_20_0._txtaddexp.text = "+" .. var_20_2
	arg_20_0.startLv = var_20_0
	arg_20_0.curExp = var_20_1
	arg_20_0.addExp = var_20_2

	TaskDispatcher.runDelay(arg_20_0.playAnim, arg_20_0, RougeMapEnum.WaitSuccAnimDuration)
end

function var_0_0.playAnim(arg_21_0)
	local var_21_0, var_21_1, var_21_2, var_21_3, var_21_4 = arg_21_0:calculateParam(arg_21_0.startLv, arg_21_0.curExp, arg_21_0.addExp)

	arg_21_0.endLv = var_21_0
	arg_21_0.newCurExp = var_21_3
	arg_21_0.nextLvNeedExp = var_21_4
	arg_21_0.tweenId = ZProj.TweenHelper.DOTweenFloat(var_21_1, var_21_2, RougeMapEnum.ExpAddDuration, arg_21_0.onFrame, arg_21_0.doneCallback, arg_21_0)
end

function var_0_0.onFrame(arg_22_0, arg_22_1)
	local var_22_0 = Mathf.Floor(arg_22_1)
	local var_22_1 = lua_rouge_level.configDict[arg_22_0.season][var_22_0 + 1].exp
	local var_22_2 = arg_22_1 - var_22_0
	local var_22_3 = Mathf.Ceil(var_22_2 * var_22_1)

	arg_22_0:_refreshLv(var_22_0, var_22_3, var_22_1)

	if var_22_0 ~= arg_22_0.startLv then
		arg_22_0._sliderprogress:SetValue(0)
	end

	recthelper.setWidth(arg_22_0.rectTrImageAddExp, var_22_2 * arg_22_0.sliderWidth)
end

function var_0_0.doneCallback(arg_23_0)
	arg_23_0:_refreshLv(arg_23_0.endLv, arg_23_0.newCurExp, arg_23_0.nextLvNeedExp)

	local var_23_0 = arg_23_0.newCurExp / arg_23_0.nextLvNeedExp

	recthelper.setWidth(arg_23_0.rectTrImageAddExp, var_23_0 * arg_23_0.sliderWidth)

	arg_23_0.tweenId = nil
end

function var_0_0._refreshLv(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_0._txtlv.text = "Lv." .. arg_24_1
	arg_24_0._txtexp.text = string.format("%s/%s", arg_24_2, arg_24_3)
end

function var_0_0.calculateParam(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_1 + 1
	local var_25_1 = lua_rouge_level.configDict[arg_25_0.season][var_25_0]
	local var_25_2 = var_25_1.exp
	local var_25_3
	local var_25_4
	local var_25_5
	local var_25_6 = arg_25_1 + arg_25_2 / var_25_2
	local var_25_7 = arg_25_3 + arg_25_2

	if var_25_7 < var_25_2 then
		local var_25_8 = arg_25_1 + var_25_7 / var_25_2

		return arg_25_1, var_25_6, var_25_8, var_25_7, var_25_2
	end

	if var_25_7 == var_25_2 then
		local var_25_9 = lua_rouge_level.configDict[arg_25_0.season][var_25_0 + 1]

		if not var_25_9 then
			return arg_25_1 + 1, var_25_6, var_25_0 - 0.01, var_25_1.exp, var_25_1.exp
		else
			return arg_25_1 + 1, var_25_6, var_25_0, 0, var_25_9.exp
		end
	end

	arg_25_1 = arg_25_1 + 1
	arg_25_3 = arg_25_3 - (var_25_2 - arg_25_2)

	while arg_25_3 > 0 do
		local var_25_10 = lua_rouge_level.configDict[arg_25_0.season][arg_25_1 + 1]

		if not var_25_10 then
			return arg_25_1, var_25_6, arg_25_1 - 0.01, var_25_2, var_25_2
		end

		var_25_2 = var_25_10.exp

		if arg_25_3 < var_25_2 then
			return arg_25_1, var_25_6, arg_25_1 + arg_25_3 / var_25_2, arg_25_3, var_25_2
		elseif arg_25_3 == var_25_2 then
			local var_25_11 = lua_rouge_level.configDict[arg_25_0.season][arg_25_1 + 2]

			if not var_25_11 then
				return arg_25_1 + 1, var_25_6, arg_25_1 + 1 - 0.01, var_25_2, var_25_2
			else
				return arg_25_1 + 1, var_25_6, arg_25_1 + 1, 0, var_25_11.exp
			end
		else
			arg_25_3 = arg_25_3 - var_25_2
			arg_25_1 = arg_25_1 + 1
		end
	end

	logError("Something unexpected has happened")

	return arg_25_1, var_25_6, arg_25_1, arg_25_3, var_25_2
end

function var_0_0.refreshHero(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.fightResultInfo.battleHeroList) do
		if iter_26_1.heroId ~= 0 then
			local var_26_0 = gohelper.cloneInPlace(arg_26_0._goheroitem)

			MonoHelper.addNoUpdateLuaComOnceToGo(var_26_0, RougeFightSuccessHeroItem):refreshHero(iter_26_1)
		end
	end
end

function var_0_0.refreshDrop(arg_27_0)
	arg_27_0._txtcollectionnum.text = arg_27_0.fightResultInfo.dropSelectNum
	arg_27_0._txtcoinnum.text = arg_27_0.fightResultInfo.addCoin

	TaskDispatcher.runDelay(arg_27_0.playRewardAudio, arg_27_0, RougeMapEnum.WaitSuccPlayAudioDuration)
end

function var_0_0.playRewardAudio(arg_28_0)
	AudioMgr.instance:trigger(AudioEnum.UI.FightSuccReward)
end

function var_0_0.onClose(arg_29_0)
	arg_29_0.closeed = true

	TaskDispatcher.cancelTask(arg_29_0.playAnim, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.playRewardAudio, arg_29_0)

	if arg_29_0.tweenId then
		ZProj.TweenHelper.KillById(arg_29_0.tweenId)
	end

	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0.bgClick:RemoveClickListener()
end

return var_0_0
