module("modules.logic.weekwalk.view.WeekWalkCharacterView", package.seeall)

local var_0_0 = class("WeekWalkCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btnfaithrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnfaithrank:AddClickListener(arg_2_0._btnfaithrankOnClick, arg_2_0)
	arg_2_0._btnexskillrank:AddClickListener(arg_2_0._btnexskillrankOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnfaithrank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
end

function var_0_0._btnlvrankOnClick(arg_4_0)
	WeekWalkCharacterModel.instance:setCardListByLevel()
	arg_4_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_5_0)
	WeekWalkCharacterModel.instance:setCardListByRare()
	arg_5_0:_refreshBtnIcon()
end

function var_0_0._btnfaithrankOnClick(arg_6_0)
	WeekWalkCharacterModel.instance:setCardListByFaith()
	arg_6_0:_refreshBtnIcon()
end

function var_0_0._btnexskillrankOnClick(arg_7_0)
	WeekWalkCharacterModel.instance:setCardListByExSkill()
	arg_7_0:_refreshBtnIcon()
end

function var_0_0._refreshBtnIcon(arg_8_0)
	local var_8_0 = WeekWalkCharacterModel.instance:getRankState()
	local var_8_1 = WeekWalkCharacterModel.instance:getBtnTag()

	gohelper.setActive(arg_8_0._lvBtns[1], var_8_1 ~= 1)
	gohelper.setActive(arg_8_0._lvBtns[2], var_8_1 == 1)
	gohelper.setActive(arg_8_0._rareBtns[1], var_8_1 ~= 2)
	gohelper.setActive(arg_8_0._rareBtns[2], var_8_1 == 2)
	gohelper.setActive(arg_8_0._faithBtns[1], var_8_1 ~= 3)
	gohelper.setActive(arg_8_0._faithBtns[2], var_8_1 == 3)
	transformhelper.setLocalScale(arg_8_0._lvArrow[1], 1, var_8_0[1], 1)
	transformhelper.setLocalScale(arg_8_0._lvArrow[2], 1, var_8_0[1], 1)
	transformhelper.setLocalScale(arg_8_0._rareArrow[1], 1, var_8_0[2], 1)
	transformhelper.setLocalScale(arg_8_0._rareArrow[2], 1, var_8_0[2], 1)
	transformhelper.setLocalScale(arg_8_0._faithArrow[1], 1, var_8_0[3], 1)
	transformhelper.setLocalScale(arg_8_0._faithArrow[2], 1, var_8_0[3], 1)
end

function var_0_0._updateHeroList(arg_9_0)
	WeekWalkCharacterModel.instance:updateCardList()
	WeekWalkCharacterModel.instance:setCharacterList()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._imgBg = gohelper.findChildSingleImage(arg_10_0.viewGO, "bg/bgimg")

	arg_10_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	arg_10_0._dropclassify = gohelper.findChildDropdown(arg_10_0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_classify")

	WeekWalkCharacterModel.instance:setCardListByCareerIndex(0)
	arg_10_0._dropclassify:SetValue(WeekWalkCharacterModel.instance:getRankIndex())
	arg_10_0._dropclassify:AddOnValueChanged(arg_10_0._onValueChanged, arg_10_0)

	arg_10_0._lvBtns = arg_10_0:getUserDataTb_()
	arg_10_0._lvArrow = arg_10_0:getUserDataTb_()
	arg_10_0._rareBtns = arg_10_0:getUserDataTb_()
	arg_10_0._rareArrow = arg_10_0:getUserDataTb_()
	arg_10_0._faithBtns = arg_10_0:getUserDataTb_()
	arg_10_0._faithArrow = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, 2 do
		arg_10_0._lvBtns[iter_10_0] = gohelper.findChild(arg_10_0._btnlvrank.gameObject, "btn" .. tostring(iter_10_0))
		arg_10_0._lvArrow[iter_10_0] = gohelper.findChild(arg_10_0._lvBtns[iter_10_0], "arrow").transform
		arg_10_0._rareBtns[iter_10_0] = gohelper.findChild(arg_10_0._btnrarerank.gameObject, "btn" .. tostring(iter_10_0))
		arg_10_0._rareArrow[iter_10_0] = gohelper.findChild(arg_10_0._rareBtns[iter_10_0], "arrow").transform
		arg_10_0._faithBtns[iter_10_0] = gohelper.findChild(arg_10_0._btnfaithrank.gameObject, "btn" .. tostring(iter_10_0))
		arg_10_0._faithArrow[iter_10_0] = gohelper.findChild(arg_10_0._faithBtns[iter_10_0], "arrow").transform
	end

	gohelper.addUIClickAudio(arg_10_0._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_10_0._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_10_0._btnfaithrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_10_0._dropclassify.gameObject, AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	WeekWalkCharacterModel.instance:setCharacterList()
	arg_12_0:_refreshBtnIcon()
	arg_12_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_12_0._updateHeroList, arg_12_0)
end

function var_0_0.onClose(arg_13_0)
	CommonHeroHelper.instance:resetGrayState()
end

function var_0_0._onValueChanged(arg_14_0, arg_14_1)
	WeekWalkCharacterModel.instance:setCardListByCareerIndex(arg_14_1)
	WeekWalkCharacterModel.instance:setCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._imgBg:UnLoadImage()
	arg_15_0._dropclassify:RemoveOnValueChanged()
end

return var_0_0
