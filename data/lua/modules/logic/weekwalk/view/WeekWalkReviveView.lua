module("modules.logic.weekwalk.view.WeekWalkReviveView", package.seeall)

slot0 = class("WeekWalkReviveView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtruledesc = gohelper.findChildText(slot0.viewGO, "#txt_ruledesc")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottomLeft/#btn_detail")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_ok")
	slot0._gocardlist = gohelper.findChild(slot0.viewGO, "#go_cardlist")
	slot0._gotemplate = gohelper.findChild(slot0.viewGO, "#go_cardlist/#go_template")
	slot0._gorecommendAttr = gohelper.findChild(slot0.viewGO, "#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/attrlist/#go_attritem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
end

function slot0._btndetailOnClick(slot0)
	EnemyInfoController.instance:openWeekWalkEnemyInfoView(slot0._mapInfo.id)
end

function slot0._btnokOnClick(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._heroItemList) do
		if slot6._isSelected then
			table.insert(slot1, slot6._mo.heroId)
		end
	end

	if #slot1 <= 0 then
		return
	end

	WeekwalkRpc.instance:sendSelectNotCdHeroRequest(slot1)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnSelectNotCdHeroReply, slot0.closeThis, slot0)
	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/bg_beijigntu.png"))
	gohelper.addUIClickAudio(slot0._btnok.gameObject, AudioEnum.WeekWalk.play_artificial_ui_commonchoose)
	gohelper.addUIClickAudio(slot0._btndetail.gameObject, AudioEnum.UI.play_ui_action_explore)
end

function slot0.onUpdateParam(slot0)
end

function slot0._recommendCareer(slot0)
	if not slot0._mapInfo:getNoStarBattleInfo() then
		gohelper.setActive(slot0._gorecommendAttr, false)

		return
	end

	slot5, slot6 = FightHelper.getAttributeCounter(string.splitToNumber(lua_battle.configDict[slot1.battleId].monsterGroupIds, "#"))

	gohelper.setActive(slot0._gorecommendAttr, #slot5 > 0)

	if slot7 > 0 then
		for slot11, slot12 in ipairs(slot5) do
			slot14 = gohelper.cloneInPlace(slot0._goattritem)

			gohelper.setActive(slot14, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot14, "icon"), "career_" .. slot12)
		end
	end
end

function slot0.onOpen(slot0)
	slot0._mapInfo = WeekWalkModel.instance:getCurMapInfo()
	slot0._mapConfig = WeekWalkModel.instance:getCurMapConfig()
	slot0._heroItemList = {}
	slot0._txtruledesc.text = formatLuaLang("weekwalkreviveview_ruledesc", slot0._mapConfig.notCdHeroCount)

	slot0:_showHeroList()
	slot0:_updateBtn()
	slot0:_recommendCareer()

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		slot0:_playBgm(AudioEnum.WeekWalk.play_artificial_layer_type_1)
	end
end

function slot0._playBgm(slot0, slot1)
	slot0._bgmId = slot1

	AudioMgr.instance:trigger(slot0._bgmId)
end

function slot0._stopBgm(slot0)
	if slot0._bgmId then
		AudioMgr.instance:trigger(AudioEnum.WeekWalk.stop_sleepwalkingaudio)

		slot0._bgmId = nil
	end
end

function slot0._showHeroList(slot0)
	for slot5, slot6 in ipairs(slot0._mapInfo:getHeroInfoList()) do
		slot0:_addHeroItem(slot6)
	end
end

function slot0._addHeroItem(slot0, slot1)
	slot2 = gohelper.cloneInPlace(slot0._gotemplate)

	gohelper.setActive(slot2, true)

	slot3 = gohelper.findChild(slot2, "go_retain")

	gohelper.setActive(slot3, false)

	slot5 = IconMgr.instance:getCommonHeroItem(gohelper.findChild(slot2, "hero"))
	slot7 = HeroModel.instance:getByHeroId(slot1.heroId)

	slot5:onUpdateMO(slot7)
	slot5:addClickListener(slot0._heroItemClick, slot0)
	slot5:setDamage(true)
	slot5:setNewShow(false)
	slot5:setEffectVisible(false)
	slot5:setInjuryTxtVisible(false)

	slot8 = slot0:getUserDataTb_()
	slot8._mo = slot7
	slot8._isSelected = false
	slot8._heroItem = slot5
	slot8._retainGo = slot3
	slot0._heroItemList[slot7] = slot8
end

function slot0._heroItemClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_fight_choosecard)

	if not slot0._heroItemList[slot1]._isSelected and slot0._canRevive then
		GameFacade.showToast(ToastEnum.WeekWalkRevive)

		return
	end

	slot2._isSelected = not slot2._isSelected

	slot0:_updateBtn()
end

function slot0._updateBtn(slot0)
	for slot6, slot7 in pairs(slot0._heroItemList) do
		slot2 = 0 + 1

		if slot7._isSelected then
			slot1 = 0 + 1
		end
	end

	slot0._canRevive = math.min(slot2, slot0._mapConfig.notCdHeroCount) <= slot1
	slot0._btnok.button.interactable = slot0._canRevive

	for slot7, slot8 in pairs(slot0._heroItemList) do
		slot8._heroItem:setSelect(false)

		if slot8._isSelected then
			gohelper.setActive(slot8._retainGo, true)
			slot8._heroItem:setDamage(false)
			slot8._heroItem:setInjuryTxtVisible(false)
			slot8._heroItem:setSelect(true)
		else
			gohelper.setActive(slot8._retainGo, false)
			slot8._heroItem:setDamage(true)
			slot8._heroItem:setInjuryTxtVisible(false)
		end
	end
end

function slot0.onClose(slot0)
	slot0:_stopBgm()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
