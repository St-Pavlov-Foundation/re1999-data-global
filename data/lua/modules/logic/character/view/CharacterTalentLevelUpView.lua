module("modules.logic.character.view.CharacterTalentLevelUpView", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0.viewGO, "#go_talent")
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talent/#btn_talent")
	arg_1_0._txtbtntalentcn = gohelper.findChildText(arg_1_0.viewGO, "#go_talent/#btn_talent/cn")
	arg_1_0._gorequest = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_request")
	arg_1_0._goinsight = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_insight")
	arg_1_0._goinsighticon1 = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_insight/#go_insighticon1")
	arg_1_0._txtinsightlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_talent/items/#go_insight/#txt_insightlevel")
	arg_1_0._goinsighticon2 = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_insight/#go_insighticon2")
	arg_1_0._goinsighticon3 = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_insight/#go_insighticon3")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "#go_talent/items/#go_frame")
	arg_1_0._txtcurlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_talent/info/#txt_curlevel")
	arg_1_0._txtnextlevel = gohelper.findChildText(arg_1_0.viewGO, "#go_talent/info/#txt_nextlevel")
	arg_1_0._gomaxtalent = gohelper.findChild(arg_1_0.viewGO, "#go_maxtalent")
	arg_1_0._golevelupbeffect = gohelper.findChild(arg_1_0.viewGO, "#go_talent/#btn_talent/#go_levelupbeffect")
	arg_1_0._txttalentresult = gohelper.findChildText(arg_1_0.viewGO, "#go_maxtalent/#txt_talentresult")
	arg_1_0._btnpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_talent/info/#btn_preview")
	arg_1_0._btnload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_load")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._btntalentOnClick, arg_2_0)
	arg_2_0._btnpreview:AddClickListener(arg_2_0._btnpreviewOnClick, arg_2_0)
	arg_2_0._btnload:AddClickListener(arg_2_0._btnloadOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_2_0._onSuccessHeroTalentUp, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.RefreshTalentLevelUpView, arg_2_0.onOpen, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0.onOpen, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.onOpen, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.playTalentLevelUpViewInAni, arg_2_0._onPlayTalentLevelUpViewInAni, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntalent:RemoveClickListener()
	arg_3_0._btnpreview:RemoveClickListener()
	arg_3_0._btnload:RemoveClickListener()
end

function var_0_0._btntalentOnClick(arg_4_0)
	if not arg_4_0.hero_mo_data then
		return
	end

	if arg_4_0.hero_mo_data.rank < arg_4_0.next_config.requirement then
		GameFacade.showToast(ToastEnum.CharacterTalentLevelUp)

		return
	end

	local var_4_0, var_4_1, var_4_2 = ItemModel.instance:hasEnoughItemsByCellData(arg_4_0.item_list)

	if not var_4_1 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_4_2, var_4_0)

		return
	end

	HeroRpc.instance:sendHeroTalentUpRequest(arg_4_0.hero_id)
end

function var_0_0._btnpreviewOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpPreview, arg_5_0.hero_mo_data)
end

function var_0_0._btnloadOnClick(arg_6_0)
	arg_6_0.viewContainer._head_close_ani1 = "2_3"
	arg_6_0.viewContainer._head_close_ani2 = "ani_2_3"

	arg_6_0:closeThis()
	CharacterController.instance:openCharacterTalentChessView({
		aniPlayIn2 = true,
		hero_id = arg_6_0.hero_id
	})
end

function var_0_0._detectLevelUp(arg_7_0)
	if not arg_7_0.hero_mo_data then
		return false
	end

	if arg_7_0.hero_mo_data.rank < arg_7_0.next_config.requirement then
		return false
	end

	local var_7_0, var_7_1, var_7_2 = ItemModel.instance:hasEnoughItemsByCellData(arg_7_0.item_list)

	if not var_7_1 then
		return false
	end

	return true
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.bg_ani = gohelper.findChildComponent(arg_8_0.viewGO, "", typeof(UnityEngine.Animator))
	arg_8_0._godetails = gohelper.findChild(arg_8_0.viewGO, "#go_details")
	arg_8_0._txtdecitem = gohelper.findChild(arg_8_0.viewGO, "#go_details/#txt_decitem")

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_open)
end

function var_0_0._onPlayTalentLevelUpViewInAni(arg_9_0)
	arg_9_0:onOpen()
	arg_9_0.bg_ani:Play("charactertalentlevelup_in", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "4_2", true, "ani_4_2", false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0._onSuccessHeroTalentUp(arg_11_0)
	arg_11_0.bg_ani:Play("charactertalentlevelup_out", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "2_4", true, "ani_2_4", false)
	CharacterController.instance:openCharacterTalentLevelUpResultView(arg_11_0.hero_id)
	gohelper.setActive(arg_11_0._godetails, false)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._exitCurrency = false
	arg_12_0.hero_id = arg_12_0.viewParam[1]
	arg_12_0.hero_mo_data = HeroModel.instance:getByHeroId(arg_12_0.hero_id)

	local var_12_0 = luaLang("talent_charactertalentlevelup_leveltxt" .. CharacterEnum.TalentTxtByHeroType[arg_12_0.hero_mo_data.config.heroType])

	if LangSettings.instance:isEn() then
		var_12_0 = var_12_0 .. " "
	end

	local var_12_1 = HeroResonanceConfig.instance:getTalentConfig(arg_12_0.hero_mo_data.heroId, arg_12_0.hero_mo_data.talent)

	if not var_12_1 then
		logError("共鸣表找不到,英雄id：", arg_12_0.hero_mo_data.heroId, "共鸣等级：", arg_12_0.hero_mo_data.talent)
	end

	arg_12_0.next_config = HeroResonanceConfig.instance:getTalentConfig(arg_12_0.hero_mo_data.heroId, arg_12_0.hero_mo_data.talent + 1)

	gohelper.setActive(arg_12_0._gotalent, arg_12_0.next_config ~= nil)
	gohelper.setActive(arg_12_0._gomaxtalent, arg_12_0.next_config == nil)

	if not arg_12_0.next_config then
		arg_12_0._txttalentresult.text = string.format("%s<size=18>Lv</size>.%s", var_12_0, HeroResonanceConfig.instance:getTalentConfig(arg_12_0.hero_id, arg_12_0.hero_mo_data.talent + 1) and arg_12_0.hero_mo_data.talent or luaLang("character_max_overseas"))
	else
		for iter_12_0 = 1, 3 do
			gohelper.setActive(arg_12_0["_goinsighticon" .. iter_12_0], arg_12_0.next_config.requirement == iter_12_0 + 1)
		end

		if LangSettings.instance:isEn() then
			arg_12_0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. " " .. tostring(arg_12_0.next_config.requirement - 1)
		else
			arg_12_0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. GameUtil.getNum2Chinese(arg_12_0.next_config.requirement - 1)
		end

		arg_12_0.old_color = arg_12_0.old_color or arg_12_0._txtinsightlevel.color

		if arg_12_0.hero_mo_data.rank < arg_12_0.next_config.requirement then
			arg_12_0._txtinsightlevel.color = Color.New(0.749, 0.1803, 0.0666, 1)
		else
			arg_12_0._txtinsightlevel.color = arg_12_0.old_color
		end

		arg_12_0._txtcurlevel.text = var_12_0 .. "<size=18>Lv</size>." .. arg_12_0.hero_mo_data.talent
		arg_12_0._txtnextlevel.text = var_12_0 .. "<size=18>Lv</size>." .. arg_12_0.hero_mo_data.talent + 1

		local var_12_2 = ItemModel.instance:getItemDataListByConfigStr(arg_12_0.next_config.consume)

		arg_12_0.item_list = var_12_2

		IconMgr.instance:getCommonPropItemIconList(arg_12_0, arg_12_0._onCostItemShow, var_12_2, arg_12_0._gorequest)
		recthelper.setWidth(arg_12_0._goframe.transform, 350.5 + #arg_12_0.item_list * 77.5)

		if var_12_1.requirement ~= arg_12_0.next_config.requirement then
			gohelper.setActive(arg_12_0._goinsight, true)
			recthelper.setAnchor(arg_12_0._gorequest.transform, -50.95, -234.6)
		else
			gohelper.setActive(arg_12_0._goinsight, false)
			recthelper.setAnchor(arg_12_0._gorequest.transform, -174, -234.6)
		end

		gohelper.setActive(arg_12_0._golevelupbeffect, arg_12_0:_detectLevelUp())
	end

	arg_12_0._txtbtntalentcn.text = luaLang("talent_charactertalentlevelup_btntalent" .. CharacterEnum.TalentTxtByHeroType[arg_12_0.hero_mo_data.config.heroType])

	arg_12_0:_checkTalentStyle()
end

function var_0_0._onCostItemShow(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	transformhelper.setLocalScale(arg_13_1.viewGO.transform, 0.59, 0.59, 1)
	arg_13_1:onUpdateMO(arg_13_2)
	arg_13_1:setConsume(true)
	arg_13_1:showStackableNum2()
	arg_13_1:isShowEffect(true)
	arg_13_1:setAutoPlay(true)
	arg_13_1:setCountFontSize(48)
	arg_13_1:setCountText(ItemModel.instance:getItemIsEnoughText(arg_13_2))
	arg_13_1:setOnBeforeClickCallback(arg_13_0.onBeforeClickItem, arg_13_0)
	arg_13_1:setRecordFarmItem({
		type = arg_13_2.materilType,
		id = arg_13_2.materilId,
		quantity = arg_13_2.quantity
	})

	if arg_13_2.materilType == MaterialEnum.MaterialType.Currency then
		arg_13_0._exitCurrency = true
	end

	gohelper.setActive(arg_13_0._gorighttop, arg_13_0._exitCurrency)
end

function var_0_0.onBeforeClickItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = JumpController.instance:getCurrentOpenedView(arg_14_0.viewName)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.viewName == ViewName.CharacterTalentView then
			iter_14_1.viewParam.isBack = true

			break
		end
	end

	arg_14_2:setRecordFarmItem({
		type = arg_14_2._itemType,
		id = arg_14_2._itemId,
		quantity = arg_14_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_14_0
	})
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0._checkTalentStyle(arg_17_0)
	local var_17_0 = arg_17_0.hero_mo_data.talent
	local var_17_1 = arg_17_0.hero_mo_data.talent + 1
	local var_17_2 = HeroResonanceConfig.instance:getTalentModelConfig(arg_17_0.hero_mo_data.heroId, var_17_1)
	local var_17_3 = HeroResonanceConfig.instance:getTalentModelConfig(arg_17_0.hero_mo_data.heroId, var_17_0) or {}
	local var_17_4 = HeroResonanceConfig.instance:getTalentConfig(arg_17_0.hero_mo_data.heroId, var_17_1)
	local var_17_5 = HeroResonanceConfig.instance:getTalentConfig(arg_17_0.hero_mo_data.heroId, var_17_0) or {}

	if not var_17_2 then
		gohelper.setActive(arg_17_0._godetails, false)

		return
	end

	gohelper.setActive(arg_17_0._godetails, true)

	local var_17_6 = {}

	if TalentStyleModel.instance:getLevelUnlockStyle(arg_17_0.hero_mo_data.talentCubeInfos.own_main_cube_id, var_17_1) then
		local var_17_7 = luaLang("talent_style_title_cn_" .. CharacterEnum.TalentTxtByHeroType[arg_17_0.hero_mo_data.config.heroType])
		local var_17_8 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", var_17_7)

		table.insert(var_17_6, {
			sort = 1,
			info = var_17_8
		})
	end

	if var_17_3.allShape ~= var_17_2.allShape then
		local var_17_9 = string.gsub(var_17_3.allShape, ",", luaLang("multiple"))
		local var_17_10 = string.gsub(var_17_2.allShape, ",", luaLang("multiple"))
		local var_17_11 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("talent_levelup_upcapacity"), var_17_9)

		table.insert(var_17_6, {
			sort = 2,
			info = var_17_11,
			nextValue = var_17_10
		})
	end

	local var_17_12 = false
	local var_17_13 = false
	local var_17_14 = false

	for iter_17_0 = 10, 20 do
		local var_17_15 = "type" .. iter_17_0
		local var_17_16 = var_17_3[var_17_15]
		local var_17_17 = var_17_2[var_17_15]
		local var_17_18 = {}
		local var_17_19 = string.splitToNumber(var_17_16, "#") or {}
		local var_17_20 = string.splitToNumber(var_17_17, "#") or {}

		for iter_17_1, iter_17_2 in ipairs(var_17_20) do
			if iter_17_2 ~= var_17_19[iter_17_1] then
				var_17_18[iter_17_1] = iter_17_2 - (var_17_19[iter_17_1] or 0)
			end
		end

		if var_17_16 ~= var_17_17 and not string.nilorempty(var_17_17) then
			if #var_17_16 == 0 and not var_17_12 then
				local var_17_21 = luaLang("talent_levelup_newdebris")

				table.insert(var_17_6, {
					sort = 3,
					info = var_17_21
				})

				var_17_12 = true
			end

			if #var_17_16 > 0 and var_17_18[2] ~= nil and not var_17_14 then
				local var_17_22 = luaLang("talent_levelup_debrislevel")

				table.insert(var_17_6, {
					sort = 4,
					info = var_17_22
				})

				var_17_14 = true
			end

			if var_17_18[1] ~= nil and var_17_18[2] == nil and not var_17_13 then
				local var_17_23 = luaLang("talent_levelup_debriscount")

				table.insert(var_17_6, {
					sort = 5,
					info = var_17_23
				})

				var_17_13 = true
			end
		elseif (not string.nilorempty(var_17_4.exclusive) and var_17_4.exclusive ~= var_17_5.exclusive or var_17_18[2] ~= nil) and not var_17_14 then
			local var_17_24 = luaLang("talent_levelup_debrislevel")

			table.insert(var_17_6, {
				sort = 4,
				info = var_17_24
			})

			var_17_14 = true
		end
	end

	table.sort(var_17_6, arg_17_0.sortTip)
	gohelper.CreateObjList(arg_17_0, arg_17_0._onItemShow, var_17_6, arg_17_0._godetails, arg_17_0._txtdecitem)
end

function var_0_0.sortTip(arg_18_0, arg_18_1)
	return arg_18_0.sort < arg_18_1.sort
end

function var_0_0._onItemShow(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_1:GetComponent(gohelper.Type_TextMesh)
	local var_19_1 = arg_19_1.transform:Find("nextvalue")
	local var_19_2 = arg_19_1.transform:Find("nextvalue/addvalue"):GetComponent(gohelper.Type_TextMesh)

	var_19_0.text = arg_19_2.info

	if arg_19_2.nextValue then
		var_19_2.text = arg_19_2.nextValue

		gohelper.setActive(var_19_1, true)
	else
		gohelper.setActive(var_19_1, false)
	end
end

return var_0_0
