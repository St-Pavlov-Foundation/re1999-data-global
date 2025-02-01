module("modules.logic.character.view.CharacterTalentLevelUpView", package.seeall)

slot0 = class("CharacterTalentLevelUpView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")
	slot0._gotalent = gohelper.findChild(slot0.viewGO, "#go_talent")
	slot0._btntalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_talent/#btn_talent")
	slot0._txtbtntalentcn = gohelper.findChildText(slot0.viewGO, "#go_talent/#btn_talent/cn")
	slot0._gorequest = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_request")
	slot0._goinsight = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_insight")
	slot0._goinsighticon1 = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_insight/#go_insighticon1")
	slot0._txtinsightlevel = gohelper.findChildText(slot0.viewGO, "#go_talent/items/#go_insight/#txt_insightlevel")
	slot0._goinsighticon2 = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_insight/#go_insighticon2")
	slot0._goinsighticon3 = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_insight/#go_insighticon3")
	slot0._goframe = gohelper.findChild(slot0.viewGO, "#go_talent/items/#go_frame")
	slot0._txtcurlevel = gohelper.findChildText(slot0.viewGO, "#go_talent/info/#txt_curlevel")
	slot0._txtnextlevel = gohelper.findChildText(slot0.viewGO, "#go_talent/info/#txt_nextlevel")
	slot0._gomaxtalent = gohelper.findChild(slot0.viewGO, "#go_maxtalent")
	slot0._golevelupbeffect = gohelper.findChild(slot0.viewGO, "#go_talent/#btn_talent/#go_levelupbeffect")
	slot0._txttalentresult = gohelper.findChildText(slot0.viewGO, "#go_maxtalent/#txt_talentresult")
	slot0._btnpreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_talent/info/#btn_preview")
	slot0._btnload = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_load")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntalent:AddClickListener(slot0._btntalentOnClick, slot0)
	slot0._btnpreview:AddClickListener(slot0._btnpreviewOnClick, slot0)
	slot0._btnload:AddClickListener(slot0._btnloadOnClick, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._onSuccessHeroTalentUp, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.RefreshTalentLevelUpView, slot0.onOpen, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0.onOpen, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onOpen, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.playTalentLevelUpViewInAni, slot0._onPlayTalentLevelUpViewInAni, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntalent:RemoveClickListener()
	slot0._btnpreview:RemoveClickListener()
	slot0._btnload:RemoveClickListener()
end

function slot0._btntalentOnClick(slot0)
	if not slot0.hero_mo_data then
		return
	end

	if slot0.hero_mo_data.rank < slot0.next_config.requirement then
		GameFacade.showToast(ToastEnum.CharacterTalentLevelUp)

		return
	end

	slot1, slot2, slot3 = ItemModel.instance:hasEnoughItemsByCellData(slot0.item_list)

	if not slot2 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot3, slot1)

		return
	end

	HeroRpc.instance:sendHeroTalentUpRequest(slot0.hero_id)
end

function slot0._btnpreviewOnClick(slot0)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpPreview, slot0.hero_mo_data)
end

function slot0._btnloadOnClick(slot0)
	slot0.viewContainer._head_close_ani1 = "2_3"
	slot0.viewContainer._head_close_ani2 = "ani_2_3"

	slot0:closeThis()
	CharacterController.instance:openCharacterTalentChessView({
		aniPlayIn2 = true,
		hero_id = slot0.hero_id
	})
end

function slot0._detectLevelUp(slot0)
	if not slot0.hero_mo_data then
		return false
	end

	if slot0.hero_mo_data.rank < slot0.next_config.requirement then
		return false
	end

	slot1, slot2, slot3 = ItemModel.instance:hasEnoughItemsByCellData(slot0.item_list)

	if not slot2 then
		return false
	end

	return true
end

function slot0._editableInitView(slot0)
	slot0.bg_ani = gohelper.findChildComponent(slot0.viewGO, "", typeof(UnityEngine.Animator))
	slot0._godetails = gohelper.findChild(slot0.viewGO, "#go_details")
	slot0._txtdecitem = gohelper.findChild(slot0.viewGO, "#go_details/#txt_decitem")

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_open)
end

function slot0._onPlayTalentLevelUpViewInAni(slot0)
	slot0:onOpen()
	slot0.bg_ani:Play("charactertalentlevelup_in", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "4_2", true, "ani_4_2", false)
end

function slot0.onUpdateParam(slot0)
end

function slot0._onSuccessHeroTalentUp(slot0)
	slot0.bg_ani:Play("charactertalentlevelup_out", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "2_4", true, "ani_2_4", false)
	CharacterController.instance:openCharacterTalentLevelUpResultView(slot0.hero_id)
	gohelper.setActive(slot0._godetails, false)
end

function slot0.onOpen(slot0)
	slot0._exitCurrency = false
	slot0.hero_id = slot0.viewParam[1]
	slot0.hero_mo_data = HeroModel.instance:getByHeroId(slot0.hero_id)

	if LangSettings.instance:isEn() then
		slot1 = luaLang("talent_charactertalentlevelup_leveltxt" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType]) .. " "
	end

	if not HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent) then
		logError("共鸣表找不到,英雄id：", slot0.hero_mo_data.heroId, "共鸣等级：", slot0.hero_mo_data.talent)
	end

	slot0.next_config = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent + 1)

	gohelper.setActive(slot0._gotalent, slot0.next_config ~= nil)
	gohelper.setActive(slot0._gomaxtalent, slot0.next_config == nil)

	if not slot0.next_config then
		slot0._txttalentresult.text = string.format("%s<size=18>Lv</size>.%s", slot1, HeroResonanceConfig.instance:getTalentConfig(slot0.hero_id, slot0.hero_mo_data.talent + 1) and slot0.hero_mo_data.talent or luaLang("character_max_overseas"))
	else
		for slot6 = 1, 3 do
			gohelper.setActive(slot0["_goinsighticon" .. slot6], slot0.next_config.requirement == slot6 + 1)
		end

		if LangSettings.instance:isEn() then
			slot0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. " " .. tostring(slot0.next_config.requirement - 1)
		else
			slot0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. GameUtil.getNum2Chinese(slot0.next_config.requirement - 1)
		end

		slot0.old_color = slot0.old_color or slot0._txtinsightlevel.color

		if slot0.hero_mo_data.rank < slot0.next_config.requirement then
			slot0._txtinsightlevel.color = Color.New(0.749, 0.1803, 0.0666, 1)
		else
			slot0._txtinsightlevel.color = slot0.old_color
		end

		slot0._txtcurlevel.text = slot1 .. "<size=18>Lv</size>." .. slot0.hero_mo_data.talent
		slot0._txtnextlevel.text = slot1 .. "<size=18>Lv</size>." .. slot0.hero_mo_data.talent + 1
		slot3 = ItemModel.instance:getItemDataListByConfigStr(slot0.next_config.consume)
		slot0.item_list = slot3

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onCostItemShow, slot3, slot0._gorequest)
		recthelper.setWidth(slot0._goframe.transform, 350.5 + #slot0.item_list * 77.5)

		if slot2.requirement ~= slot0.next_config.requirement then
			gohelper.setActive(slot0._goinsight, true)
			recthelper.setAnchor(slot0._gorequest.transform, -50.95, -234.6)
		else
			gohelper.setActive(slot0._goinsight, false)
			recthelper.setAnchor(slot0._gorequest.transform, -174, -234.6)
		end

		gohelper.setActive(slot0._golevelupbeffect, slot0:_detectLevelUp())
	end

	slot0._txtbtntalentcn.text = luaLang("talent_charactertalentlevelup_btntalent" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])

	slot0:_checkTalentStyle()
end

function slot0._onCostItemShow(slot0, slot1, slot2, slot3)
	transformhelper.setLocalScale(slot1.viewGO.transform, 0.59, 0.59, 1)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:setCountText(ItemModel.instance:getItemIsEnoughText(slot2))
	slot1:setOnBeforeClickCallback(slot0.onBeforeClickItem, slot0)
	slot1:setRecordFarmItem({
		type = slot2.materilType,
		id = slot2.materilId,
		quantity = slot2.quantity
	})

	if slot2.materilType == MaterialEnum.MaterialType.Currency then
		slot0._exitCurrency = true
	end

	gohelper.setActive(slot0._gorighttop, slot0._exitCurrency)
end

function slot0.onBeforeClickItem(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(JumpController.instance:getCurrentOpenedView(slot0.viewName)) do
		if slot8.viewName == ViewName.CharacterTalentView then
			slot8.viewParam.isBack = true

			break
		end
	end

	slot2:setRecordFarmItem({
		type = slot2._itemType,
		id = slot2._itemId,
		quantity = slot2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = slot3
	})
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._checkTalentStyle(slot0)
	slot4 = HeroResonanceConfig.instance:getTalentModelConfig(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent) or {}
	slot5 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot2)
	slot6 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot1) or {}

	if not HeroResonanceConfig.instance:getTalentModelConfig(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent + 1) then
		gohelper.setActive(slot0._godetails, false)

		return
	end

	gohelper.setActive(slot0._godetails, true)

	if TalentStyleModel.instance:getLevelUnlockStyle(slot0.hero_mo_data.talentCubeInfos.own_main_cube_id, slot2) then
		table.insert({}, {
			sort = 1,
			info = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType]))
		})
	end

	if slot4.allShape ~= slot3.allShape then
		table.insert(slot7, {
			sort = 2,
			info = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("talent_levelup_upcapacity"), string.gsub(slot4.allShape, ",", luaLang("multiple"))),
			nextValue = string.gsub(slot3.allShape, ",", luaLang("multiple"))
		})
	end

	slot9 = false
	slot10 = false
	slot11 = false

	for slot15 = 10, 20 do
		slot16 = "type" .. slot15
		slot19 = {
			[slot25] = slot26 - (slot20[slot25] or 0)
		}
		slot20 = string.splitToNumber(slot4[slot16], "#") or {}

		for slot25, slot26 in ipairs(string.splitToNumber(slot3[slot16], "#") or {}) do
			if slot26 ~= slot20[slot25] then
				-- Nothing
			end
		end

		if slot17 ~= slot18 and not string.nilorempty(slot18) then
			if #slot17 == 0 and not slot9 then
				table.insert(slot7, {
					sort = 3,
					info = luaLang("talent_levelup_newdebris")
				})

				slot9 = true
			end

			if #slot17 > 0 and slot19[2] ~= nil and not slot11 then
				table.insert(slot7, {
					sort = 4,
					info = luaLang("talent_levelup_debrislevel")
				})

				slot11 = true
			end

			if slot19[1] ~= nil and slot19[2] == nil and not slot10 then
				table.insert(slot7, {
					sort = 5,
					info = luaLang("talent_levelup_debriscount")
				})

				slot10 = true
			end
		elseif (not string.nilorempty(slot5.exclusive) and slot5.exclusive ~= slot6.exclusive or slot19[2] ~= nil) and not slot11 then
			table.insert(slot7, {
				sort = 4,
				info = luaLang("talent_levelup_debrislevel")
			})

			slot11 = true
		end
	end

	table.sort(slot7, slot0.sortTip)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot7, slot0._godetails, slot0._txtdecitem)
end

function slot0.sortTip(slot0, slot1)
	return slot0.sort < slot1.sort
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:GetComponent(gohelper.Type_TextMesh).text = slot2.info

	if slot2.nextValue then
		slot1.transform:Find("nextvalue/addvalue"):GetComponent(gohelper.Type_TextMesh).text = slot2.nextValue

		gohelper.setActive(slot1.transform:Find("nextvalue"), true)
	else
		gohelper.setActive(slot5, false)
	end
end

return slot0
