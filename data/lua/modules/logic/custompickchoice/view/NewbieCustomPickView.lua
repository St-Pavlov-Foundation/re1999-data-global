module("modules.logic.custompickchoice.view.NewbieCustomPickView", package.seeall)

local var_0_0 = class("NewbieCustomPickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "mask")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "bg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "TitleBG/Title")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "Tips2")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_cancel")
	arg_1_0._goChar1Root = gohelper.findChild(arg_1_0.viewGO, "Hero/#go_Hero1")
	arg_1_0._goChar2Root = gohelper.findChild(arg_1_0.viewGO, "Hero/#go_Hero2")
	arg_1_0._goChar3Root = gohelper.findChild(arg_1_0.viewGO, "Hero/#go_Hero3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickListChanged, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(CustomPickChoiceController.instance, CustomPickChoiceEvent.onCustomPickComplete, arg_3_0.closeThis, arg_3_0)
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	CustomPickChoiceController.instance:tryChoice(arg_4_0.viewParam)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._HeroItems = {}
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	CustomPickChoiceController.instance:onOpenView()

	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.styleId
	local var_6_1 = var_6_0 and CustomPickChoiceEnum.FixedText[var_6_0]

	if var_6_1 then
		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			if arg_6_0[iter_6_0] then
				arg_6_0[iter_6_0].text = luaLang(iter_6_1)
			end
		end
	end

	local var_6_2 = var_6_0 and CustomPickChoiceEnum.ComponentVisible[var_6_0]

	if var_6_2 then
		for iter_6_2, iter_6_3 in pairs(var_6_2) do
			if arg_6_0[iter_6_2] then
				gohelper.setActive(arg_6_0[iter_6_2], iter_6_3)
			end
		end
	end
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:refreshSelectCount()
	arg_7_0:refreshList()
end

function var_0_0.refreshSelectCount(arg_8_0)
	local var_8_0 = CustomPickChoiceListModel.instance:getSelectCount()
	local var_8_1 = CustomPickChoiceListModel.instance:getMaxSelectCount()

	ZProj.UGUIHelper.SetGrayscale(arg_8_0._btnconfirm.gameObject, var_8_0 ~= var_8_1)
end

function var_0_0.refreshList(arg_9_0)
	arg_9_0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[1], 1, arg_9_0._HeroItems, arg_9_0._goChar1Root)
	arg_9_0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[2], 2, arg_9_0._HeroItems, arg_9_0._goChar2Root)
	arg_9_0:updateCharItem(CustomPickChoiceListModel.instance.allHeroList[3], 3, arg_9_0._HeroItems, arg_9_0._goChar3Root)
end

function var_0_0.updateCharItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_0:getOrCreateItem(arg_10_2, arg_10_3, arg_10_4)
	local var_10_1 = arg_10_1.id
	local var_10_2

	if var_10_1 and var_10_1 ~= 0 then
		var_10_2 = HeroConfig.instance:getHeroCO(var_10_1)
	end

	local var_10_3 = HeroModel.instance:getByHeroId(var_10_1)
	local var_10_4 = 0
	local var_10_5 = 0

	if var_10_3 then
		var_10_5 = var_10_3.exSkillLevel
		var_10_4 = var_10_5 + 1
	end

	local var_10_6 = HeroMo.New()

	var_10_6:initFromConfig(var_10_2)

	var_10_6.rank = arg_10_1.rank
	var_10_6.exSkillLevel = var_10_5

	local var_10_7 = CustomPickChoiceListModel.instance:isHeroIdSelected(var_10_1)

	var_10_0:setSelect(var_10_7)
	var_10_0:onUpdateMO(var_10_6)

	local var_10_8 = gohelper.findChild(arg_10_4, "#go_Have")
	local var_10_9 = gohelper.findChild(arg_10_4, "#go_NoHave")
	local var_10_10 = var_10_4 > 0

	gohelper.setActive(var_10_8, var_10_10)
	gohelper.setActive(var_10_9, not var_10_10)
end

function var_0_0.getOrCreateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_2[arg_11_1] then
		local var_11_0 = IconMgr.instance:getCommonHeroItem(arg_11_3)

		var_11_0:addClickListener(arg_11_0._onItemClick, arg_11_0)
		var_11_0:setStyle_CharacterBackpack()
		var_11_0:setLevelContentShow(false)
		var_11_0:setExSkillActive(true)

		var_11_0.btnLongPress = SLFramework.UGUI.UILongPressListener.Get(var_11_0.go)

		var_11_0.btnLongPress:SetLongPressTime({
			0.5,
			99999
		})
		var_11_0.btnLongPress:AddLongPressListener(arg_11_0._onLongClickItem, arg_11_0, arg_11_1)

		arg_11_2[arg_11_1] = var_11_0
	end

	return arg_11_2[arg_11_1]
end

function var_0_0._onItemClick(arg_12_0, arg_12_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CustomPickChoiceController.instance:setSelect(arg_12_1.heroId)
end

function var_0_0._onLongClickItem(arg_13_0, arg_13_1)
	local var_13_0 = CustomPickChoiceListModel.instance.allHeroList[arg_13_1]

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rolesopen)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = var_13_0.id
	})
end

function var_0_0.onClose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._HeroItems) do
		iter_14_1.btnLongPress:RemoveLongPressListener()
	end
end

function var_0_0.onDestroyView(arg_15_0)
	CustomPickChoiceController.instance:onCloseView()
end

return var_0_0
