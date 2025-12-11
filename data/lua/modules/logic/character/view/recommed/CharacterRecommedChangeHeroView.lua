module("modules.logic.character.view.recommed.CharacterRecommedChangeHeroView", package.seeall)

local var_0_0 = class("CharacterRecommedChangeHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnlv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "title/#btn_lv")
	arg_1_0._golvSelect = gohelper.findChild(arg_1_0.viewGO, "title/#btn_lv/btn2")
	arg_1_0._golvSelect = gohelper.findChild(arg_1_0.viewGO, "title/#btn_lv/btn2")
	arg_1_0._golvSelectArrow = gohelper.findChild(arg_1_0.viewGO, "title/#btn_lv/btn2/txt/arrow")
	arg_1_0._golvUnSelect = gohelper.findChild(arg_1_0.viewGO, "title/#btn_lv/btn1")
	arg_1_0._btnrare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "title/#btn_rare")
	arg_1_0._gorareSelect = gohelper.findChild(arg_1_0.viewGO, "title/#btn_rare/btn2")
	arg_1_0._gorareUnSelect = gohelper.findChild(arg_1_0.viewGO, "title/#btn_rare/btn1")
	arg_1_0._gorareSelectArrow = gohelper.findChild(arg_1_0.viewGO, "title/#btn_rare/btn2/txt/arrow")
	arg_1_0._scrollhero = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_hero")
	arg_1_0._goheroicon = gohelper.findChild(arg_1_0.viewGO, "#go_heroicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlv:AddClickListener(arg_2_0._btnlvOnClick, arg_2_0)
	arg_2_0._btnrare:AddClickListener(arg_2_0._btnrareOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, arg_2_0._refreshHero, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlv:RemoveClickListener()
	arg_3_0._btnrare:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnChangeHero, arg_3_0._refreshHero, arg_3_0)
end

function var_0_0._btnlvOnClick(arg_4_0)
	CharacterRecommedHeroListModel.instance:setSortLevel()
	arg_4_0:_refreshSortBtn(true)
end

function var_0_0._btnrareOnClick(arg_5_0)
	CharacterRecommedHeroListModel.instance:setSortByRare()
	arg_5_0:_refreshSortBtn(false)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goheroicon, false)
end

function var_0_0._refreshHero(arg_7_0, arg_7_1)
	CharacterRecommedHeroListModel.instance:selectById(arg_7_1)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_refreshHero(arg_9_0.viewParam.heroId)
	arg_9_0:_refreshSortBtn(true)
end

function var_0_0._refreshSortBtn(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = CharacterRecommedHeroListModel.instance:getSortStatus()

	if arg_10_1 then
		transformhelper.setLocalScale(arg_10_0._golvSelectArrow.transform, 1, var_10_0 and 1 or -1, 1)
	else
		transformhelper.setLocalScale(arg_10_0._gorareSelectArrow.transform, 1, var_10_1 and 1 or -1, 1)
	end

	gohelper.setActive(arg_10_0._golvSelect, arg_10_1)
	gohelper.setActive(arg_10_0._golvUnSelect, not arg_10_1)
	gohelper.setActive(arg_10_0._gorareSelect, not arg_10_1)
	gohelper.setActive(arg_10_0._gorareUnSelect, arg_10_1)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
