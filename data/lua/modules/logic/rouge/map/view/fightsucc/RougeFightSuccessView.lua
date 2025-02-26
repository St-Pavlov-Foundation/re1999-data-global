module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessView", package.seeall)

slot0 = class("RougeFightSuccessView", BaseView)

function slot0.onInitView(slot0)
	slot0._gospineContainer = gohelper.findChild(slot0.viewGO, "left/#go_spineContainer")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "left/#go_spineContainer/#go_spine")
	slot0._txtsayCn = gohelper.findChildText(slot0.viewGO, "left/#txt_sayCn")
	slot0._txtsayEn = gohelper.findChildText(slot0.viewGO, "left/SayEn/#txt_sayEn")
	slot0._btndata = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_data")
	slot0._txtepisodeNameEn = gohelper.findChildText(slot0.viewGO, "right/#txt_episodeNameEn")
	slot0._txtepisodeName = gohelper.findChildText(slot0.viewGO, "right/#txt_episodeName")
	slot0._txtexp = gohelper.findChildText(slot0.viewGO, "right/rouge/exp/#txt_exp")
	slot0._sliderprogress = gohelper.findChildSlider(slot0.viewGO, "right/rouge/exp/#slider_progress")
	slot0._txtaddexp = gohelper.findChildText(slot0.viewGO, "right/rouge/exp/#slider_progress/#txt_addexp")
	slot0._imageAddExp = gohelper.findChildImage(slot0.viewGO, "right/rouge/exp/#slider_progress/#image_addexp")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "right/rouge/exp/#txt_lv")
	slot0._imagefaction = gohelper.findChildImage(slot0.viewGO, "right/rouge/exp/faction/#image_faction")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "right/rouge/role/layout/#go_heroitem")
	slot0._sliderhp = gohelper.findChildSlider(slot0.viewGO, "right/rouge/role/layout/heroitem/#slider_hp")
	slot0._simagerolehead = gohelper.findChildSingleImage(slot0.viewGO, "right/rouge/role/layout/heroitem/hero/#simage_rolehead")
	slot0._godead = gohelper.findChild(slot0.viewGO, "right/rouge/role/layout/heroitem/#go_dead")
	slot0._txtcollectionnum = gohelper.findChildText(slot0.viewGO, "right/rouge/reward/collection/#txt_collectionnum")
	slot0._txtcoinnum = gohelper.findChildText(slot0.viewGO, "right/rouge/reward/coin/#txt_coinnum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndata:AddClickListener(slot0._btndataOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndata:RemoveClickListener()
end

function slot0._btndataOnClick(slot0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function slot0._editableInitView(slot0)
	slot0.rectTrImageAddExp = slot0._imageAddExp:GetComponent(gohelper.Type_RectTransform)
	slot0.sliderRectTr = slot0._sliderprogress:GetComponent(gohelper.Type_RectTransform)
	slot0.sliderWidth = recthelper.getWidth(slot0.sliderRectTr)
	slot0.bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "bg")

	slot0.bgClick:AddClickListener(slot0.onClickBg, slot0)

	slot0.spineTr = slot0._gospine.transform
	slot0._txtsayCn.text = ""
	slot0._txtsayEn.text = ""

	gohelper.setActive(slot0._goheroitem, false)
end

function slot0.onClickBg(slot0)
	if slot0.uiSpine then
		slot0.uiSpine:stopVoice()
	end

	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshSpine()
end

function slot0.refreshRight(slot0)
	slot0:refreshEpisodeInfo()
	slot0:refreshRougeInfo()
end

function slot0.refreshSpine(slot0)
	slot1 = slot0:getRandomEntityMo()
	slot0.skinCO = slot0:getSkinCo(slot1)
	slot0.randomHeroId = slot1.modelId
	slot0.randomSkinId = slot1.skin
	slot0.spineLoaded = false
	slot0.uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	slot0.uiSpine:useRT()
	slot0.uiSpine:setImgPos(0)
	slot0.uiSpine:setResPath(slot0.skinCO, slot0.onSpineLoaded, slot0)
end

function slot0.onSpineLoaded(slot0)
	if slot0.closeed then
		return
	end

	slot0.spineLoaded = true

	slot0.uiSpine:setUIMask(true)
	slot0.uiSpine:setAllLayer(UnityLayer.UI)
	slot0:playSpineVoice()
	slot0:setSkinOffset()
end

function slot0.setSkinOffset(slot0)
	slot1, slot2 = SkinConfig.instance:getSkinOffset(slot0.skinCO.fightSuccViewOffset)

	if slot2 then
		slot3, _ = SkinConfig.instance:getSkinOffset(slot0.skinCO.characterViewOffset)
		slot1 = SkinConfig.instance:getAfterRelativeOffset(504, slot3)
	end

	slot3 = tonumber(slot1[3])

	recthelper.setAnchor(slot0.spineTr, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0.spineTr, slot3, slot3, slot3)
end

function slot0.playSpineVoice(slot0)
	if (HeroModel.instance:getVoiceConfig(slot0.randomHeroId, CharacterEnum.VoiceType.FightResult, nil, slot0.randomSkinId) or FightAudioMgr.instance:_getHeroVoiceCOs(slot0.randomHeroId, CharacterEnum.VoiceType.FightResult, slot0.randomSkinId)) and #slot1 > 0 then
		slot0.uiSpine:playVoice(slot1[1], nil, slot0._txtsayCn, slot0._txtsayEn)
	end
end

function slot0.getRandomEntityMo(slot0)
	slot4 = {}

	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMyNormalList())
	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMySubList())
	tabletool.addValues(slot4, FightDataHelper.entityMgr:getMyDeadList())

	for slot8 = #slot4, 1, -1 do
		if not slot0:getSkinCo(slot4[slot8]) then
			table.remove(slot4, slot8)
		end
	end

	slot5 = {}

	tabletool.addValues(slot5, slot4)

	for slot9 = #slot5, 1, -1 do
		if FightAudioMgr.instance:_getHeroVoiceCOs(slot4[slot9].modelId, CharacterEnum.VoiceType.FightResult) and #slot11 > 0 then
			if slot10:isMonster() then
				table.remove(slot5, slot9)
			end
		else
			table.remove(slot5, slot9)
		end
	end

	if #slot5 > 0 then
		return slot5[math.random(#slot5)]
	elseif #slot4 > 0 then
		return slot4[math.random(#slot4)]
	else
		logError("没有角色")
	end
end

function slot0.getSkinCo(slot0, slot1)
	if FightConfig.instance:getSkinCO(slot1.skin) and not string.nilorempty(slot2.verticalDrawing) or slot2 and not string.nilorempty(slot2.live2d) then
		return slot2
	end
end

function slot0.refreshEpisodeInfo(slot0)
	slot2 = DungeonConfig.instance:getEpisodeCO(FightResultModel.instance.episodeId)
	slot0._txtepisodeNameEn.text = slot2.name_En
	slot0._txtepisodeName.text = slot2.name
end

function slot0.refreshRougeInfo(slot0)
	slot0.fightResultInfo = RougeModel.instance:getFightResultInfo()
	slot0.rougeInfo = RougeModel.instance:getRougeInfo()
	slot0.season = slot0.rougeInfo.season

	slot0:refreshStyle()
	slot0:refreshLv()
	slot0:refreshHero()
	slot0:refreshDrop()
end

function slot0.refreshStyle(slot0)
	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imagefaction, string.format("%s_light", lua_rouge_style.configDict[slot0.season][slot0.rougeInfo.style].icon))
end

function slot0.refreshLv(slot0)
	slot2 = slot0.rougeInfo.teamExp
	slot3 = slot0.fightResultInfo.addExp

	if not lua_rouge_level.configDict[slot0.season][slot0.rougeInfo.teamLevel + 1] then
		gohelper.setActive(slot0._txtaddexp.gameObject, false)

		slot5 = lua_rouge_level.configDict[slot0.season][slot1].exp

		slot0:_refreshLv(slot1, slot5, slot5)
		slot0._sliderprogress:SetValue(1)
		recthelper.setWidth(slot0.rectTrImageAddExp, 0)

		return
	end

	gohelper.setActive(slot0._txtaddexp.gameObject, true)

	slot5 = slot4.exp

	slot0:_refreshLv(slot1, slot3, slot5)
	slot0._sliderprogress:SetValue(slot2 / slot5)
	recthelper.setWidth(slot0.rectTrImageAddExp, 0)

	slot0._txtaddexp.text = "+" .. slot3
	slot0.startLv = slot1
	slot0.curExp = slot2
	slot0.addExp = slot3

	TaskDispatcher.runDelay(slot0.playAnim, slot0, RougeMapEnum.WaitSuccAnimDuration)
end

function slot0.playAnim(slot0)
	slot0.endLv, slot2, slot3, slot0.newCurExp, slot0.nextLvNeedExp = slot0:calculateParam(slot0.startLv, slot0.curExp, slot0.addExp)
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(slot2, slot3, RougeMapEnum.ExpAddDuration, slot0.onFrame, slot0.doneCallback, slot0)
end

function slot0.onFrame(slot0, slot1)
	slot2 = Mathf.Floor(slot1)
	slot4 = lua_rouge_level.configDict[slot0.season][slot2 + 1].exp

	slot0:_refreshLv(slot2, Mathf.Ceil((slot1 - slot2) * slot4), slot4)

	if slot2 ~= slot0.startLv then
		slot0._sliderprogress:SetValue(0)
	end

	recthelper.setWidth(slot0.rectTrImageAddExp, slot5 * slot0.sliderWidth)
end

function slot0.doneCallback(slot0)
	slot0:_refreshLv(slot0.endLv, slot0.newCurExp, slot0.nextLvNeedExp)
	recthelper.setWidth(slot0.rectTrImageAddExp, slot0.newCurExp / slot0.nextLvNeedExp * slot0.sliderWidth)

	slot0.tweenId = nil
end

function slot0._refreshLv(slot0, slot1, slot2, slot3)
	slot0._txtlv.text = "Lv." .. slot1
	slot0._txtexp.text = string.format("%s/%s", slot2, slot3)
end

function slot0.calculateParam(slot0, slot1, slot2, slot3)
	slot6 = lua_rouge_level.configDict[slot0.season][slot1 + 1].exp
	slot7, slot8, slot9 = nil

	if slot6 > slot3 + slot2 then
		return slot1, slot1 + slot2 / slot6, slot1 + slot9 / slot6, slot9, slot6
	end

	if slot9 == slot6 then
		if not lua_rouge_level.configDict[slot0.season][slot4 + 1] then
			return slot1 + 1, slot7, slot4 - 0.01, slot5.exp, slot5.exp
		else
			return slot1 + 1, slot7, slot4, 0, slot10.exp
		end
	end

	slot1 = slot1 + 1
	slot3 = slot3 - (slot6 - slot2)

	while slot3 > 0 do
		if not lua_rouge_level.configDict[slot0.season][slot1 + 1] then
			return slot1, slot7, slot1 - 0.01, slot6, slot6
		end

		if slot3 < slot10.exp then
			return slot1, slot7, slot1 + slot3 / slot6, slot3, slot6
		elseif slot3 == slot6 then
			if not lua_rouge_level.configDict[slot0.season][slot1 + 2] then
				return slot1 + 1, slot7, slot1 + 1 - 0.01, slot6, slot6
			else
				return slot1 + 1, slot7, slot1 + 1, 0, slot10.exp
			end
		else
			slot3 = slot3 - slot6
			slot1 = slot1 + 1
		end
	end

	logError("Something unexpected has happened")

	return slot1, slot7, slot1, slot3, slot6
end

function slot0.refreshHero(slot0)
	for slot4, slot5 in ipairs(slot0.fightResultInfo.battleHeroList) do
		if slot5.heroId ~= 0 then
			MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goheroitem), RougeFightSuccessHeroItem):refreshHero(slot5)
		end
	end
end

function slot0.refreshDrop(slot0)
	slot0._txtcollectionnum.text = slot0.fightResultInfo.dropSelectNum
	slot0._txtcoinnum.text = slot0.fightResultInfo.addCoin

	TaskDispatcher.runDelay(slot0.playRewardAudio, slot0, RougeMapEnum.WaitSuccPlayAudioDuration)
end

function slot0.playRewardAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.FightSuccReward)
end

function slot0.onClose(slot0)
	slot0.closeed = true

	TaskDispatcher.cancelTask(slot0.playAnim, slot0)
	TaskDispatcher.cancelTask(slot0.playRewardAudio, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
end

function slot0.onDestroyView(slot0)
	slot0.bgClick:RemoveClickListener()
end

return slot0
