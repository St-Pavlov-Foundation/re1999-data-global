module("modules.logic.survival.view.shelter.ShelterHeroWareHouseView", package.seeall)

local var_0_0 = class("ShelterHeroWareHouseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_card")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/root/#btn_lvrank", AudioEnum.UI.UI_transverse_tabs_click)
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/root/#btn_rarerank", AudioEnum.UI.UI_transverse_tabs_click)
	arg_1_0._btnfaithrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/root/#btn_faithrank", AudioEnum.UI.UI_transverse_tabs_click)
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/root/#btn_exskillrank")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolesort/root/#btn_exskillrank/#go_exarrow")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/root/#btn_classify")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_card/viewport/scrollcontent")
	arg_1_0.filterType = CharacterEnum.FilterType.Survival

	arg_1_0:initBtnArrow()

	arg_1_0._selectDmgs = {
		false,
		false
	}
	arg_1_0._selectAttrs = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	arg_1_0._selectLocations = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	arg_1_0._scrollcard.verticalNormalizedPosition = 1
	_, arg_1_0._initScrollContentPosY = transformhelper.getLocalPos(arg_1_0._goScrollContent.transform)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_2_0._onFilterList, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_2_0._updateHeroList, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnlvrank, arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnrarerank, arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnfaithrank, arg_2_0._btnfaithrankOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnexskillrank, arg_2_0._btnexskillrankOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnclassify, arg_2_0._btnclassifyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_3_0._onFilterList, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0._btnlvrank)
	arg_3_0:removeClickCb(arg_3_0._btnrarerank)
	arg_3_0:removeClickCb(arg_3_0._btnfaithrank)
	arg_3_0:removeClickCb(arg_3_0._btnexskillrank)
	arg_3_0:removeClickCb(arg_3_0._btnclassify)
end

function var_0_0.initBtnArrow(arg_4_0)
	arg_4_0._lvBtns = arg_4_0:getUserDataTb_()
	arg_4_0._lvArrow = arg_4_0:getUserDataTb_()
	arg_4_0._rareBtns = arg_4_0:getUserDataTb_()
	arg_4_0._rareArrow = arg_4_0:getUserDataTb_()
	arg_4_0._faithBtns = arg_4_0:getUserDataTb_()
	arg_4_0._faithArrow = arg_4_0:getUserDataTb_()
	arg_4_0._classifyBtns = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 2 do
		arg_4_0._lvBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnlvrank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._lvArrow[iter_4_0] = gohelper.findChild(arg_4_0._lvBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._rareBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnrarerank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._rareArrow[iter_4_0] = gohelper.findChild(arg_4_0._rareBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._faithBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnfaithrank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._faithArrow[iter_4_0] = gohelper.findChild(arg_4_0._faithBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._classifyBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnclassify.gameObject, "btn" .. tostring(iter_4_0))
	end
end

function var_0_0._onFilterList(arg_5_0, arg_5_1)
	arg_5_0._selectDmgs = arg_5_1.dmgs
	arg_5_0._selectAttrs = arg_5_1.attrs
	arg_5_0._selectLocations = arg_5_1.locations

	local var_5_0, var_5_1 = transformhelper.getLocalPos(arg_5_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_5_0._goScrollContent.transform, var_5_0, arg_5_0._initScrollContentPosY)
	arg_5_0:_refreshBtnIcon()
end

function var_0_0._btnclassifyOnClick(arg_6_0)
	local var_6_0 = {
		dmgs = LuaUtil.deepCopy(arg_6_0._selectDmgs),
		attrs = LuaUtil.deepCopy(arg_6_0._selectAttrs),
		locations = LuaUtil.deepCopy(arg_6_0._selectLocations),
		filterType = arg_6_0.filterType
	}

	CharacterController.instance:openCharacterFilterView(var_6_0)
end

function var_0_0._btnexskillrankOnClick(arg_7_0)
	local var_7_0, var_7_1 = transformhelper.getLocalPos(arg_7_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_7_0._goScrollContent.transform, var_7_0, arg_7_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, arg_7_0.filterType)
	arg_7_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_8_0)
	local var_8_0, var_8_1 = transformhelper.getLocalPos(arg_8_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_8_0._goScrollContent.transform, var_8_0, arg_8_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, arg_8_0.filterType)
	arg_8_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_9_0)
	local var_9_0, var_9_1 = transformhelper.getLocalPos(arg_9_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_9_0._goScrollContent.transform, var_9_0, arg_9_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, arg_9_0.filterType)
	arg_9_0:_refreshBtnIcon()
end

function var_0_0._btnfaithrankOnClick(arg_10_0)
	local var_10_0, var_10_1 = transformhelper.getLocalPos(arg_10_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_10_0._goScrollContent.transform, var_10_0, arg_10_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(false, arg_10_0.filterType)
	arg_10_0:_refreshBtnIcon()
end

function var_0_0._refreshBtnIcon(arg_11_0)
	local var_11_0 = CharacterModel.instance:getRankState()
	local var_11_1 = CharacterModel.instance:getBtnTag(arg_11_0.filterType)

	gohelper.setActive(arg_11_0._lvBtns[1], var_11_1 ~= 1)
	gohelper.setActive(arg_11_0._lvBtns[2], var_11_1 == 1)
	gohelper.setActive(arg_11_0._rareBtns[1], var_11_1 ~= 2)
	gohelper.setActive(arg_11_0._rareBtns[2], var_11_1 == 2)
	gohelper.setActive(arg_11_0._faithBtns[1], var_11_1 ~= 3)
	gohelper.setActive(arg_11_0._faithBtns[2], var_11_1 == 3)

	local var_11_2 = false

	for iter_11_0, iter_11_1 in pairs(arg_11_0._selectDmgs) do
		if iter_11_1 then
			var_11_2 = true
		end
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_0._selectAttrs) do
		if iter_11_3 then
			var_11_2 = true
		end
	end

	for iter_11_4, iter_11_5 in pairs(arg_11_0._selectLocations) do
		if iter_11_5 then
			var_11_2 = true
		end
	end

	gohelper.setActive(arg_11_0._classifyBtns[1], not var_11_2)
	gohelper.setActive(arg_11_0._classifyBtns[2], var_11_2)
	transformhelper.setLocalScale(arg_11_0._lvArrow[1], 1, var_11_0[1], 1)
	transformhelper.setLocalScale(arg_11_0._lvArrow[2], 1, var_11_0[1], 1)
	transformhelper.setLocalScale(arg_11_0._rareArrow[1], 1, var_11_0[2], 1)
	transformhelper.setLocalScale(arg_11_0._rareArrow[2], 1, var_11_0[2], 1)
	transformhelper.setLocalScale(arg_11_0._faithArrow[1], 1, var_11_0[3], 1)
	transformhelper.setLocalScale(arg_11_0._faithArrow[2], 1, var_11_0[3], 1)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)
	arg_13_0:refreshView()
	arg_13_0.viewContainer:playCardOpenAnimation()
end

function var_0_0.refreshView(arg_14_0)
	arg_14_0:_updateHeroList()
end

function var_0_0._updateHeroList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = 1, 2 do
		if arg_15_0._selectDmgs[iter_15_0] then
			table.insert(var_15_0, iter_15_0)
		end
	end

	local var_15_1 = {}

	for iter_15_1 = 1, 6 do
		if arg_15_0._selectAttrs[iter_15_1] then
			table.insert(var_15_1, iter_15_1)
		end
	end

	local var_15_2 = {}

	for iter_15_2 = 1, 6 do
		if arg_15_0._selectLocations[iter_15_2] then
			table.insert(var_15_2, iter_15_2)
		end
	end

	if #var_15_0 == 0 then
		var_15_0 = {
			1,
			2
		}
	end

	if #var_15_1 == 0 then
		var_15_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_15_2 == 0 then
		var_15_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_15_3 = {
		dmgs = var_15_0,
		careers = var_15_1,
		locations = var_15_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_15_3, false, CharacterEnum.FilterType.BackpackHero)
	arg_15_0:_refreshBtnIcon()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
