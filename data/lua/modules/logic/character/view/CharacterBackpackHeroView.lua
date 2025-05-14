module("modules.logic.character.view.CharacterBackpackHeroView", package.seeall)

local var_0_0 = class("CharacterBackpackHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_card")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/#btn_rarerank")
	arg_1_0._btnfaithrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/#btn_faithrank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/#btn_exskillrank")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolesort/#btn_exskillrank/#go_exarrow")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolesort/#btn_classify")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_card/scrollcontent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnfaithrank:AddClickListener(arg_2_0._btnfaithrankOnClick, arg_2_0)
	arg_2_0._btnexskillrank:AddClickListener(arg_2_0._btnexskillrankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnfaithrank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._ani = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(arg_4_0._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_4_0._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_4_0._btnfaithrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

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

	arg_4_0._selectDmgs = {
		false,
		false
	}
	arg_4_0._selectAttrs = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	arg_4_0._selectLocations = {
		false,
		false,
		false,
		false,
		false,
		false
	}

	CharacterBackpackCardListModel.instance:updateModel()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.BackpackHero)
end

function var_0_0._btnclassifyOnClick(arg_5_0)
	local var_5_0 = {
		dmgs = LuaUtil.deepCopy(arg_5_0._selectDmgs),
		attrs = LuaUtil.deepCopy(arg_5_0._selectAttrs),
		locations = LuaUtil.deepCopy(arg_5_0._selectLocations)
	}

	CharacterController.instance:openCharacterFilterView(var_5_0)
end

function var_0_0._btnexskillrankOnClick(arg_6_0)
	local var_6_0, var_6_1 = transformhelper.getLocalPos(arg_6_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_6_0._goScrollContent.transform, var_6_0, arg_6_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.BackpackHero)
	arg_6_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_7_0)
	local var_7_0, var_7_1 = transformhelper.getLocalPos(arg_7_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_7_0._goScrollContent.transform, var_7_0, arg_7_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.BackpackHero)
	arg_7_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_8_0)
	local var_8_0, var_8_1 = transformhelper.getLocalPos(arg_8_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_8_0._goScrollContent.transform, var_8_0, arg_8_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.BackpackHero)
	arg_8_0:_refreshBtnIcon()
end

function var_0_0._btnfaithrankOnClick(arg_9_0)
	local var_9_0, var_9_1 = transformhelper.getLocalPos(arg_9_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_9_0._goScrollContent.transform, var_9_0, arg_9_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(false, CharacterEnum.FilterType.BackpackHero)
	arg_9_0:_refreshBtnIcon()
end

function var_0_0._refreshBtnIcon(arg_10_0)
	local var_10_0 = CharacterModel.instance:getRankState()
	local var_10_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.BackpackHero)

	gohelper.setActive(arg_10_0._lvBtns[1], var_10_1 ~= 1)
	gohelper.setActive(arg_10_0._lvBtns[2], var_10_1 == 1)
	gohelper.setActive(arg_10_0._rareBtns[1], var_10_1 ~= 2)
	gohelper.setActive(arg_10_0._rareBtns[2], var_10_1 == 2)
	gohelper.setActive(arg_10_0._faithBtns[1], var_10_1 ~= 3)
	gohelper.setActive(arg_10_0._faithBtns[2], var_10_1 == 3)

	local var_10_2 = false

	for iter_10_0, iter_10_1 in pairs(arg_10_0._selectDmgs) do
		if iter_10_1 then
			var_10_2 = true
		end
	end

	for iter_10_2, iter_10_3 in pairs(arg_10_0._selectAttrs) do
		if iter_10_3 then
			var_10_2 = true
		end
	end

	for iter_10_4, iter_10_5 in pairs(arg_10_0._selectLocations) do
		if iter_10_5 then
			var_10_2 = true
		end
	end

	gohelper.setActive(arg_10_0._classifyBtns[1], not var_10_2)
	gohelper.setActive(arg_10_0._classifyBtns[2], var_10_2)
	transformhelper.setLocalScale(arg_10_0._lvArrow[1], 1, var_10_0[1], 1)
	transformhelper.setLocalScale(arg_10_0._lvArrow[2], 1, var_10_0[1], 1)
	transformhelper.setLocalScale(arg_10_0._rareArrow[1], 1, var_10_0[2], 1)
	transformhelper.setLocalScale(arg_10_0._rareArrow[2], 1, var_10_0[2], 1)
	transformhelper.setLocalScale(arg_10_0._faithArrow[1], 1, var_10_0[3], 1)
	transformhelper.setLocalScale(arg_10_0._faithArrow[2], 1, var_10_0[3], 1)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._ani.enabled = #arg_12_0.tabContainer._tabAbLoaders < 2

	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_12_0._onFilterList, arg_12_0)
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_12_0._updateHeroList, arg_12_0)

	arg_12_0._scrollcard.verticalNormalizedPosition = 1

	arg_12_0:_refreshBtnIcon()
	arg_12_0:_updateHeroList()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)

	_, arg_12_0._initScrollContentPosY = transformhelper.getLocalPos(arg_12_0._goScrollContent.transform)
end

function var_0_0._onFilterList(arg_13_0, arg_13_1)
	arg_13_0._selectDmgs = arg_13_1.dmgs
	arg_13_0._selectAttrs = arg_13_1.attrs
	arg_13_0._selectLocations = arg_13_1.locations

	local var_13_0, var_13_1 = transformhelper.getLocalPos(arg_13_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_13_0._goScrollContent.transform, var_13_0, arg_13_0._initScrollContentPosY)
	arg_13_0:_refreshBtnIcon()
end

function var_0_0._updateHeroList(arg_14_0)
	local var_14_0 = {}

	for iter_14_0 = 1, 2 do
		if arg_14_0._selectDmgs[iter_14_0] then
			table.insert(var_14_0, iter_14_0)
		end
	end

	local var_14_1 = {}

	for iter_14_1 = 1, 6 do
		if arg_14_0._selectAttrs[iter_14_1] then
			table.insert(var_14_1, iter_14_1)
		end
	end

	local var_14_2 = {}

	for iter_14_2 = 1, 6 do
		if arg_14_0._selectLocations[iter_14_2] then
			table.insert(var_14_2, iter_14_2)
		end
	end

	if #var_14_0 == 0 then
		var_14_0 = {
			1,
			2
		}
	end

	if #var_14_1 == 0 then
		var_14_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_14_2 == 0 then
		var_14_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_14_3 = {
		dmgs = var_14_0,
		careers = var_14_1,
		locations = var_14_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_14_3, false, CharacterEnum.FilterType.BackpackHero)
	arg_14_0:_refreshBtnIcon()
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_15_0._updateHeroList, arg_15_0)
	arg_15_0:removeEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, arg_15_0._onFilterList, arg_15_0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
