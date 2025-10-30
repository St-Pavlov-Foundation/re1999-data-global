module("modules.logic.character.view.CharacterTalentLevelUpView", package.seeall)

local var_0_0 = class("CharacterTalentLevelUpView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._gotalent = gohelper.findChild(arg_1_0.viewGO, "#go_talent")
	arg_1_0._gocaneasycombinetip = gohelper.findChild(arg_1_0.viewGO, "#go_talent/txt_onceCombine")
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
		if arg_4_0._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(arg_4_0.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(arg_4_0._easyCombineTable, arg_4_0._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, arg_4_0._onEasyCombineFinished, arg_4_0)

			return
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_4_2, var_4_0)

			return
		end
	end

	HeroRpc.instance:sendHeroTalentUpRequest(arg_4_0.hero_id)
end

function var_0_0._onEasyCombineFinished(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	PopupCacheModel.instance:setViewIgnoreGetPropView(arg_5_0.viewName, false)

	if arg_5_2 ~= 0 then
		return
	end

	arg_5_0:_btntalentOnClick()
end

function var_0_0._btnpreviewOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpPreview, arg_6_0.hero_mo_data)
end

function var_0_0._btnloadOnClick(arg_7_0)
	arg_7_0.viewContainer._head_close_ani1 = "2_3"
	arg_7_0.viewContainer._head_close_ani2 = "ani_2_3"

	arg_7_0:closeThis()
	CharacterController.instance:openCharacterTalentChessView({
		aniPlayIn2 = true,
		hero_id = arg_7_0.hero_id
	})
end

function var_0_0._detectLevelUp(arg_8_0)
	if not arg_8_0.hero_mo_data then
		return false
	end

	if arg_8_0.hero_mo_data.rank < arg_8_0.next_config.requirement then
		return false
	end

	local var_8_0, var_8_1, var_8_2 = ItemModel.instance:hasEnoughItemsByCellData(arg_8_0.item_list)

	if not var_8_1 then
		return false
	end

	return true
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.bg_ani = gohelper.findChildComponent(arg_9_0.viewGO, "", typeof(UnityEngine.Animator))
	arg_9_0._godetails = gohelper.findChild(arg_9_0.viewGO, "#go_details")
	arg_9_0._txtdecitem = gohelper.findChild(arg_9_0.viewGO, "#go_details/#txt_decitem")

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_open)
end

function var_0_0._onPlayTalentLevelUpViewInAni(arg_10_0)
	arg_10_0:onOpen()
	arg_10_0.bg_ani:Play("charactertalentlevelup_in", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "4_2", true, "ani_4_2", false)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._onSuccessHeroTalentUp(arg_12_0)
	arg_12_0.bg_ani:Play("charactertalentlevelup_out", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "2_4", true, "ani_2_4", false)
	CharacterController.instance:openCharacterTalentLevelUpResultView(arg_12_0.hero_id)
	gohelper.setActive(arg_12_0._godetails, false)
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0._exitCurrency = false
	arg_13_0.hero_id = arg_13_0.viewParam[1]
	arg_13_0.hero_mo_data = HeroModel.instance:getByHeroId(arg_13_0.hero_id)

	local var_13_0 = luaLang("talent_charactertalentlevelup_leveltxt" .. arg_13_0.hero_mo_data:getTalentTxtByHeroType())

	if LangSettings.instance:isEn() then
		var_13_0 = var_13_0 .. " "
	end

	local var_13_1 = HeroResonanceConfig.instance:getTalentConfig(arg_13_0.hero_mo_data.heroId, arg_13_0.hero_mo_data.talent)

	if not var_13_1 then
		logError("共鸣表找不到,英雄id：", arg_13_0.hero_mo_data.heroId, "共鸣等级：", arg_13_0.hero_mo_data.talent)
	end

	arg_13_0.next_config = HeroResonanceConfig.instance:getTalentConfig(arg_13_0.hero_mo_data.heroId, arg_13_0.hero_mo_data.talent + 1)

	gohelper.setActive(arg_13_0._gotalent, arg_13_0.next_config ~= nil)
	gohelper.setActive(arg_13_0._gomaxtalent, arg_13_0.next_config == nil)

	arg_13_0._canEasyCombine = false

	if not arg_13_0.next_config then
		arg_13_0._txttalentresult.text = string.format("%s<size=18>Lv</size>.%s", var_13_0, HeroResonanceConfig.instance:getTalentConfig(arg_13_0.hero_id, arg_13_0.hero_mo_data.talent + 1) and arg_13_0.hero_mo_data.talent or luaLang("character_max_overseas"))
	else
		for iter_13_0 = 1, 3 do
			gohelper.setActive(arg_13_0["_goinsighticon" .. iter_13_0], arg_13_0.next_config.requirement == iter_13_0 + 1)
		end

		if LangSettings.instance:isEn() then
			arg_13_0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. " " .. tostring(arg_13_0.next_config.requirement - 1)
		else
			arg_13_0._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. GameUtil.getNum2Chinese(arg_13_0.next_config.requirement - 1)
		end

		arg_13_0.old_color = arg_13_0.old_color or arg_13_0._txtinsightlevel.color

		if arg_13_0.hero_mo_data.rank < arg_13_0.next_config.requirement then
			arg_13_0._txtinsightlevel.color = Color.New(0.749, 0.1803, 0.0666, 1)
		else
			arg_13_0._txtinsightlevel.color = arg_13_0.old_color
		end

		arg_13_0._txtcurlevel.text = var_13_0 .. "<size=18>Lv</size>." .. arg_13_0.hero_mo_data.talent
		arg_13_0._txtnextlevel.text = var_13_0 .. "<size=18>Lv</size>." .. arg_13_0.hero_mo_data.talent + 1
		arg_13_0._lackedItemDataList = {}
		arg_13_0._occupyItemDic = {}

		local var_13_2 = ItemModel.instance:getItemDataListByConfigStr(arg_13_0.next_config.consume)

		arg_13_0.item_list = var_13_2

		IconMgr.instance:getCommonPropItemIconList(arg_13_0, arg_13_0._onCostItemShow, var_13_2, arg_13_0._gorequest)

		arg_13_0._canEasyCombine, arg_13_0._easyCombineTable = RoomProductionHelper.canEasyCombineItems(arg_13_0._lackedItemDataList, arg_13_0._occupyItemDic)
		arg_13_0._occupyItemDic = nil

		recthelper.setWidth(arg_13_0._goframe.transform, 350.5 + #arg_13_0.item_list * 77.5)

		if var_13_1.requirement ~= arg_13_0.next_config.requirement then
			gohelper.setActive(arg_13_0._goinsight, true)
			recthelper.setAnchor(arg_13_0._gorequest.transform, -50.95, -234.6)
		else
			gohelper.setActive(arg_13_0._goinsight, false)
			recthelper.setAnchor(arg_13_0._gorequest.transform, -174, -234.6)
		end

		gohelper.setActive(arg_13_0._golevelupbeffect, arg_13_0:_detectLevelUp())
	end

	arg_13_0._txtbtntalentcn.text = luaLang("talent_charactertalentlevelup_btntalent" .. arg_13_0.hero_mo_data:getTalentTxtByHeroType())

	gohelper.setActive(arg_13_0._gocaneasycombinetip, arg_13_0._canEasyCombine)
	arg_13_0:_checkTalentStyle()
end

function var_0_0._onCostItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	transformhelper.setLocalScale(arg_14_1.viewGO.transform, 0.59, 0.59, 1)
	arg_14_1:onUpdateMO(arg_14_2)
	arg_14_1:setConsume(true)
	arg_14_1:showStackableNum2()
	arg_14_1:isShowEffect(true)
	arg_14_1:setAutoPlay(true)
	arg_14_1:setCountFontSize(48)

	local var_14_0 = arg_14_2.materilType
	local var_14_1 = arg_14_2.materilId
	local var_14_2 = arg_14_2.quantity
	local var_14_3, var_14_4 = ItemModel.instance:getItemIsEnoughText(arg_14_2)

	if var_14_4 then
		table.insert(arg_14_0._lackedItemDataList, {
			type = var_14_0,
			id = var_14_1,
			quantity = var_14_4
		})
	else
		if not arg_14_0._occupyItemDic[var_14_0] then
			arg_14_0._occupyItemDic[var_14_0] = {}
		end

		arg_14_0._occupyItemDic[var_14_0][var_14_1] = (arg_14_0._occupyItemDic[var_14_0][var_14_1] or 0) + var_14_2
	end

	arg_14_1:setCountText(var_14_3)
	arg_14_1:setOnBeforeClickCallback(arg_14_0.onBeforeClickItem, arg_14_0)
	arg_14_1:setRecordFarmItem({
		type = var_14_0,
		id = var_14_1,
		quantity = var_14_2
	})

	if var_14_0 == MaterialEnum.MaterialType.Currency then
		arg_14_0._exitCurrency = true
	end

	gohelper.setActive(arg_14_0._gorighttop, arg_14_0._exitCurrency)
end

function var_0_0.onBeforeClickItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = JumpController.instance:getCurrentOpenedView(arg_15_0.viewName)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.viewName == ViewName.CharacterTalentView then
			iter_15_1.viewParam.isBack = true

			break
		end
	end

	arg_15_2:setRecordFarmItem({
		type = arg_15_2._itemType,
		id = arg_15_2._itemId,
		quantity = arg_15_2._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = var_15_0
	})
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

function var_0_0._checkTalentStyle(arg_18_0)
	local var_18_0 = arg_18_0.hero_mo_data.talent
	local var_18_1 = arg_18_0.hero_mo_data.talent + 1
	local var_18_2 = HeroResonanceConfig.instance:getTalentModelConfig(arg_18_0.hero_mo_data.heroId, var_18_1)
	local var_18_3 = HeroResonanceConfig.instance:getTalentModelConfig(arg_18_0.hero_mo_data.heroId, var_18_0) or {}
	local var_18_4 = HeroResonanceConfig.instance:getTalentConfig(arg_18_0.hero_mo_data.heroId, var_18_1)
	local var_18_5 = HeroResonanceConfig.instance:getTalentConfig(arg_18_0.hero_mo_data.heroId, var_18_0) or {}

	if not var_18_2 then
		gohelper.setActive(arg_18_0._godetails, false)

		return
	end

	gohelper.setActive(arg_18_0._godetails, true)

	local var_18_6 = {}

	if TalentStyleModel.instance:getLevelUnlockStyle(arg_18_0.hero_mo_data.talentCubeInfos.own_main_cube_id, var_18_1) then
		local var_18_7 = luaLang("talent_style_title_cn_" .. arg_18_0.hero_mo_data:getTalentTxtByHeroType())
		local var_18_8 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", var_18_7)

		table.insert(var_18_6, {
			sort = 1,
			info = var_18_8
		})
	end

	if var_18_3.allShape ~= var_18_2.allShape then
		local var_18_9 = string.gsub(var_18_3.allShape, ",", luaLang("multiple"))
		local var_18_10 = string.gsub(var_18_2.allShape, ",", luaLang("multiple"))
		local var_18_11 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("talent_levelup_upcapacity"), var_18_9)

		table.insert(var_18_6, {
			sort = 2,
			info = var_18_11,
			nextValue = var_18_10
		})
	end

	local var_18_12 = false
	local var_18_13 = false
	local var_18_14 = false

	for iter_18_0 = 10, 20 do
		local var_18_15 = "type" .. iter_18_0
		local var_18_16 = var_18_3[var_18_15]
		local var_18_17 = var_18_2[var_18_15]
		local var_18_18 = {}
		local var_18_19 = string.splitToNumber(var_18_16, "#") or {}
		local var_18_20 = string.splitToNumber(var_18_17, "#") or {}

		for iter_18_1, iter_18_2 in ipairs(var_18_20) do
			if iter_18_2 ~= var_18_19[iter_18_1] then
				var_18_18[iter_18_1] = iter_18_2 - (var_18_19[iter_18_1] or 0)
			end
		end

		if var_18_16 ~= var_18_17 and not string.nilorempty(var_18_17) then
			if #var_18_16 == 0 and not var_18_12 then
				local var_18_21 = luaLang("talent_levelup_newdebris")

				table.insert(var_18_6, {
					sort = 3,
					info = var_18_21
				})

				var_18_12 = true
			end

			if #var_18_16 > 0 and var_18_18[2] ~= nil and not var_18_14 then
				local var_18_22 = luaLang("talent_levelup_debrislevel")

				table.insert(var_18_6, {
					sort = 4,
					info = var_18_22
				})

				var_18_14 = true
			end

			if var_18_18[1] ~= nil and var_18_18[2] == nil and not var_18_13 then
				local var_18_23 = luaLang("talent_levelup_debriscount")

				table.insert(var_18_6, {
					sort = 5,
					info = var_18_23
				})

				var_18_13 = true
			end
		elseif (not string.nilorempty(var_18_4.exclusive) and var_18_4.exclusive ~= var_18_5.exclusive or var_18_18[2] ~= nil) and not var_18_14 then
			local var_18_24 = luaLang("talent_levelup_debrislevel")

			table.insert(var_18_6, {
				sort = 4,
				info = var_18_24
			})

			var_18_14 = true
		end
	end

	table.sort(var_18_6, arg_18_0.sortTip)
	gohelper.CreateObjList(arg_18_0, arg_18_0._onItemShow, var_18_6, arg_18_0._godetails, arg_18_0._txtdecitem)
end

function var_0_0.sortTip(arg_19_0, arg_19_1)
	return arg_19_0.sort < arg_19_1.sort
end

function var_0_0._onItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_1:GetComponent(gohelper.Type_TextMesh)
	local var_20_1 = arg_20_1.transform:Find("nextvalue")
	local var_20_2 = arg_20_1.transform:Find("nextvalue/addvalue"):GetComponent(gohelper.Type_TextMesh)

	var_20_0.text = arg_20_2.info

	if arg_20_2.nextValue then
		var_20_2.text = arg_20_2.nextValue

		gohelper.setActive(var_20_1, true)
	else
		gohelper.setActive(var_20_1, false)
	end
end

return var_0_0
