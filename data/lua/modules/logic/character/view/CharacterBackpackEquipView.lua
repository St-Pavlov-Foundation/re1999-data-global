module("modules.logic.character.view.CharacterBackpackEquipView", package.seeall)

local var_0_0 = class("CharacterBackpackEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_equip")
	arg_1_0._goequipsort = gohelper.findChild(arg_1_0.viewGO, "#go_equipsort")
	arg_1_0._btnequiplv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipsort/bg/#btn_equiplv")
	arg_1_0._btnequiprare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipsort/bg/#btn_equiprare")
	arg_1_0._btnequiptime = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipsort/bg/#btn_equiptime")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipsort/#btn_filter")
	arg_1_0._txtequipbackpacknum = gohelper.findChildText(arg_1_0.viewGO, "go_num/#txt_equipbackpacknum")
	arg_1_0._btncompose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "compose/#btn_compose")
	arg_1_0._simageheart = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_heart")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequiplv:AddClickListener(arg_2_0._btnequiplvOnClick, arg_2_0)
	arg_2_0._btnequiprare:AddClickListener(arg_2_0._btnequiprareOnClick, arg_2_0)
	arg_2_0._btnequiptime:AddClickListener(arg_2_0._btnequiptimeOnClick, arg_2_0)
	arg_2_0._btncompose:AddClickListener(arg_2_0._btncomposeOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequiplv:RemoveClickListener()
	arg_3_0._btnequiprare:RemoveClickListener()
	arg_3_0._btnequiptime:RemoveClickListener()
	arg_3_0._btncompose:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._ani = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(arg_4_0._btnequiplv.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_4_0._btnequiprare.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_4_0._btnequiptime.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(arg_4_0._btncompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	arg_4_0._simageheart:LoadImage(ResUrl.getCharacterIcon("bg_beijingwenli_xinzang"))

	arg_4_0._equipLvBtns = arg_4_0:getUserDataTb_()
	arg_4_0._equipLvArrow = arg_4_0:getUserDataTb_()
	arg_4_0._equipQualityBtns = arg_4_0:getUserDataTb_()
	arg_4_0._equipQualityArrow = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 2 do
		arg_4_0._equipLvBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnequiplv.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._equipLvArrow[iter_4_0] = gohelper.findChild(arg_4_0._equipLvBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._equipQualityBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnequiprare.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._equipQualityArrow[iter_4_0] = gohelper.findChild(arg_4_0._equipQualityBtns[iter_4_0], "txt/arrow").transform
	end

	gohelper.setActive(arg_4_0._equipLvArrow[1].gameObject, false)
	gohelper.setActive(arg_4_0._equipQualityArrow[1].gameObject, false)

	arg_4_0.goNotFilter = gohelper.findChild(arg_4_0.viewGO, "#go_equipsort/#btn_filter/#go_notfilter")
	arg_4_0.goFilter = gohelper.findChild(arg_4_0.viewGO, "#go_equipsort/#btn_filter/#go_filter")

	arg_4_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_4_0.refreshEquip, arg_4_0)
	arg_4_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_4_0.refreshEquip, arg_4_0)
	arg_4_0:addEventCb(EquipController.instance, EquipEvent.OnEquipTypeHasChange, arg_4_0.onEquipTypeHasChange, arg_4_0)
end

function var_0_0._btncomposeOnClick(arg_5_0)
	EquipController.instance:openEquipDecomposeView()
end

function var_0_0._btnequiplvOnClick(arg_6_0)
	CharacterBackpackEquipListModel.instance:sortByLevel()
	arg_6_0:_refreshEquipBtnIcon()
end

function var_0_0._btnequiprareOnClick(arg_7_0)
	CharacterBackpackEquipListModel.instance:sortByQuality()
	arg_7_0:_refreshEquipBtnIcon()
end

function var_0_0._btnequiptimeOnClick(arg_8_0)
	CharacterBackpackEquipListModel.instance:sortByTime()
	arg_8_0:_refreshEquipBtnIcon()
end

function var_0_0._btnfilterOnClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = arg_9_0.viewName
	})
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.filterMo = EquipFilterModel.instance:generateFilterMo(arg_11_0.viewName)

	arg_11_0.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Equip)

	arg_11_0._ani.enabled = #arg_11_0.tabContainer._tabAbLoaders < 2
	arg_11_0._scrollequip.verticalNormalizedPosition = 1

	arg_11_0:refreshEquip()
	arg_11_0:_refreshEquipBtnIcon()
end

function var_0_0._refreshEquipBtnIcon(arg_12_0)
	local var_12_0 = CharacterBackpackEquipListModel.instance:getBtnTag()

	gohelper.setActive(arg_12_0._equipLvBtns[1], var_12_0 ~= 1)
	gohelper.setActive(arg_12_0._equipLvBtns[2], var_12_0 == 1)
	gohelper.setActive(arg_12_0._equipQualityBtns[1], var_12_0 ~= 2)
	gohelper.setActive(arg_12_0._equipQualityBtns[2], var_12_0 == 2)

	local var_12_1, var_12_2, var_12_3 = CharacterBackpackEquipListModel.instance:getRankState()

	transformhelper.setLocalScale(arg_12_0._equipLvArrow[2], 1, var_12_1, 1)
	transformhelper.setLocalScale(arg_12_0._equipQualityArrow[2], 1, var_12_2, 1)
end

function var_0_0.refreshEquip(arg_13_0)
	local var_13_0 = EquipModel.instance:getEquips()
	local var_13_1 = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.config and arg_13_0.filterMo:checkIsIncludeTag(iter_13_1.config) then
			table.insert(var_13_1, iter_13_1)
		end
	end

	CharacterBackpackEquipListModel.instance:setEquipListNew(var_13_1)
	arg_13_0:_showEquipBackpackNum()
	arg_13_0:refreshFilterBtn()
end

function var_0_0.onEquipTypeHasChange(arg_14_0, arg_14_1)
	if arg_14_0.viewName ~= arg_14_1 then
		return
	end

	arg_14_0._scrollequip.verticalNormalizedPosition = 1

	arg_14_0:refreshEquip()
end

function var_0_0._showEquipBackpackNum(arg_15_0)
	local var_15_0 = CharacterBackpackEquipListModel.instance:getCount()

	arg_15_0._txtequipbackpacknum.text = string.format("%s ：%s/%s", luaLang("equip"), var_15_0, EquipConfig.instance:getEquipBackpackMaxCount())
end

function var_0_0.refreshFilterBtn(arg_16_0)
	local var_16_0 = arg_16_0.filterMo:isFiltering()

	gohelper.setActive(arg_16_0.goNotFilter, not var_16_0)
	gohelper.setActive(arg_16_0.goFilter, var_16_0)
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	EquipFilterModel.instance:clear(arg_18_0.viewName)
	CharacterBackpackEquipListModel.instance:clearEquipList()
	arg_18_0._simageheart:UnLoadImage()
end

return var_0_0
