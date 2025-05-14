module("modules.logic.settings.view.SettingsRoleVoiceSearchFilterView", package.seeall)

local var_0_0 = class("SettingsRoleVoiceSearchFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._dropfilterTemplateTrans = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/Template").transform
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._goclassifyUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn1")
	arg_1_0._goclassifySelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn2")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_ok")
	arg_1_0._dropfilter = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang")
	arg_1_0._transArrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/go_arrow").transform
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btntrustrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank")
	arg_1_0._golvrankUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn1")
	arg_1_0._golvrankSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn2")
	arg_1_0._gotrustrankUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn1")
	arg_1_0._gotrustrankSelected = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn2")
	arg_1_0._transrareArrow = gohelper.findChild(arg_1_0._golvrankSelected, "txt/arrow").transform
	arg_1_0._transfaithArrow = gohelper.findChild(arg_1_0._gotrustrankSelected, "txt/arrow").transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btnclosefilterviewOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btntrustrank:AddClickListener(arg_2_0._btntrustrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._dropfilter:AddOnValueChanged(arg_2_0._onDropFilterValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btntrustrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._dropfilter:RemoveOnValueChanged()
end

function var_0_0._btnresetOnClick(arg_4_0)
	for iter_4_0 = 1, 6 do
		arg_4_0._selectAttrs[iter_4_0] = false
		arg_4_0._selectCharTypes[iter_4_0] = false
	end

	arg_4_0:_refreshView()
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 1, 6 do
		if arg_5_0._selectAttrs[iter_5_0] then
			table.insert(var_5_0, iter_5_0)
		end
	end

	var_5_0 = #var_5_0 == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or var_5_0

	local var_5_1 = {}

	for iter_5_1 = 1, 6 do
		if arg_5_0._selectCharTypes[iter_5_1] then
			var_5_1[#var_5_1 + 1] = iter_5_1
		end
	end

	var_5_1 = #var_5_1 == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or var_5_1

	local var_5_2 = {
		careers = var_5_0,
		charTypes = var_5_1,
		charLang = arg_5_0._filterLang
	}

	CharacterModel.instance:filterCardListByCareerAndCharType(var_5_2, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
	arg_5_0:_refreshClassifyBtnStateView(false)
end

function var_0_0._btntrustrankOnClick(arg_6_0)
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, false, true)
	arg_6_0:_refreshRankMode()
end

function var_0_0._btnlvrankOnClick(arg_7_0)
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, true, false)
	arg_7_0:_refreshRankMode()
end

function var_0_0._btnclosefilterviewOnClick(arg_8_0)
	arg_8_0._selectAttrs = LuaUtil.deepCopy(arg_8_0._attrsCopy)
	arg_8_0._selectCharTypes = LuaUtil.deepCopy(arg_8_0._charTypesCopy)

	arg_8_0:_refreshClassifyBtnStateView(false)
end

function var_0_0._btnclassifyOnClick(arg_9_0)
	arg_9_0._attrsCopy = LuaUtil.deepCopy(arg_9_0._selectAttrs)
	arg_9_0._charTypesCopy = LuaUtil.deepCopy(arg_9_0._selectCharTypes)

	arg_9_0:_refreshClassifyBtnStateView(true)
	arg_9_0:_refreshView()
end

function var_0_0._onDropFilterValueChanged(arg_10_0, arg_10_1)
	arg_10_0._filterLang = arg_10_0._languageOptions[arg_10_1 + 1] and arg_10_0._languageOptions[arg_10_1 + 1] or 0

	local var_10_0 = {}

	for iter_10_0 = 1, 6 do
		if arg_10_0._selectAttrs[iter_10_0] then
			table.insert(var_10_0, iter_10_0)
		end
	end

	var_10_0 = #var_10_0 == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or var_10_0

	local var_10_1 = {}

	for iter_10_1 = 1, 6 do
		if arg_10_0._selectCharTypes[iter_10_1] then
			var_10_1[#var_10_1 + 1] = iter_10_1
		end
	end

	var_10_1 = #var_10_1 == 0 and {
		1,
		2,
		3,
		4,
		5,
		6
	} or var_10_1

	local var_10_2 = {
		careers = var_10_0,
		charTypes = var_10_1,
		charLang = arg_10_0._filterLang
	}

	CharacterModel.instance:filterCardListByCareerAndCharType(var_10_2, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
end

function var_0_0.onFilterDropShow(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_11_0._isPopUpFilterList = true

	arg_11_0:refreshFilterDropDownArrow()

	local var_11_0 = arg_11_0._filterLang
	local var_11_1 = gohelper.findChild(arg_11_0._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._languageOptions) do
		local var_11_2 = var_11_1:GetChild(iter_11_0)
		local var_11_3 = gohelper.findChildText(var_11_2.gameObject, "Text")

		if iter_11_1 == var_11_0 then
			var_11_3.text = string.format("<color=#efb785ff>%s</color>", arg_11_0._optionsName[iter_11_0])
		else
			var_11_3.text = string.format("<color=#c3beb6ff>%s</color>", arg_11_0._optionsName[iter_11_0])
		end
	end
end

function var_0_0.onFilterDropHide(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_12_0._isPopUpFilterList = false

	arg_12_0:refreshFilterDropDownArrow()
end

function var_0_0.refreshFilterDropDownArrow(arg_13_0)
	transformhelper.setLocalScale(arg_13_0._transArrow, 1, arg_13_0._isPopUpFilterList and -1 or 1, 1)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._attrSelects = arg_14_0:getUserDataTb_()
	arg_14_0._attrUnselects = arg_14_0:getUserDataTb_()
	arg_14_0._attrBtnClicks = arg_14_0:getUserDataTb_()

	for iter_14_0 = 1, 6 do
		arg_14_0._attrUnselects[iter_14_0] = gohelper.findChild(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_14_0 .. "/unselected")
		arg_14_0._attrSelects[iter_14_0] = gohelper.findChild(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_14_0 .. "/selected")
		arg_14_0._attrBtnClicks[iter_14_0] = gohelper.findChildButtonWithAudio(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_14_0 .. "/click")

		arg_14_0._attrBtnClicks[iter_14_0]:AddClickListener(arg_14_0._attrBtnOnClick, arg_14_0, iter_14_0)
	end

	arg_14_0._charTypeSelects = arg_14_0:getUserDataTb_()
	arg_14_0._charTypeUnselects = arg_14_0:getUserDataTb_()
	arg_14_0._charTypeBtnClicks = arg_14_0:getUserDataTb_()

	for iter_14_1 = 1, 6 do
		arg_14_0._charTypeUnselects[iter_14_1] = gohelper.findChild(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_14_1 .. "/unselected")
		arg_14_0._charTypeSelects[iter_14_1] = gohelper.findChild(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_14_1 .. "/selected")
		arg_14_0._charTypeBtnClicks[iter_14_1] = gohelper.findChildButtonWithAudio(arg_14_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_14_1 .. "/click")

		arg_14_0._charTypeBtnClicks[iter_14_1]:AddClickListener(arg_14_0._charTypeBtnOnClick, arg_14_0, iter_14_1)
	end

	arg_14_0._filterLang = 0
end

function var_0_0._attrBtnOnClick(arg_15_0, arg_15_1)
	arg_15_0._selectAttrs[arg_15_1] = not arg_15_0._selectAttrs[arg_15_1]

	arg_15_0:_refreshView()
end

function var_0_0._charTypeBtnOnClick(arg_16_0, arg_16_1)
	arg_16_0._selectCharTypes[arg_16_1] = not arg_16_0._selectCharTypes[arg_16_1]

	arg_16_0:_refreshView()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:addEventCb(SettingsRoleVoiceController.instance, SettingsEvent.OnCharVoiceTypeChanged, arg_17_0._onCharVoiceTypeChanged, arg_17_0)

	arg_17_0._selectAttrs = {}
	arg_17_0._selectCharTypes = {}

	for iter_17_0 = 1, 6 do
		arg_17_0._selectAttrs[iter_17_0] = false
		arg_17_0._selectCharTypes[iter_17_0] = false
	end

	arg_17_0.filterDropExtend = DropDownExtend.Get(arg_17_0._dropfilter.gameObject)

	arg_17_0.filterDropExtend:init(arg_17_0.onFilterDropShow, arg_17_0.onFilterDropHide, arg_17_0)
	arg_17_0:initOptions()
	arg_17_0:_refreshView()
	arg_17_0:_refreshClassifyBtnStateView(false)
	CharacterBackpackCardListModel.instance:updateModel()
	arg_17_0:_updateHeroList()
	arg_17_0:_refreshRankMode()
end

function var_0_0.onClose(arg_18_0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0 = 1, #arg_19_0._attrBtnClicks do
		arg_19_0._attrBtnClicks[iter_19_0]:RemoveClickListener()
		arg_19_0._charTypeBtnClicks[iter_19_0]:RemoveClickListener()
	end
end

function var_0_0._onCharVoiceTypeChanged(arg_20_0)
	return
end

function var_0_0._refreshView(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or arg_21_0._selectAttrs
	arg_21_2 = arg_21_2 or arg_21_0._selectCharTypes

	for iter_21_0 = 1, 6 do
		gohelper.setActive(arg_21_0._attrUnselects[iter_21_0], not arg_21_1[iter_21_0])
		gohelper.setActive(arg_21_0._attrSelects[iter_21_0], arg_21_1[iter_21_0])
	end

	for iter_21_1 = 1, 6 do
		gohelper.setActive(arg_21_0._charTypeUnselects[iter_21_1], not arg_21_2[iter_21_1])
		gohelper.setActive(arg_21_0._charTypeSelects[iter_21_1], arg_21_2[iter_21_1])
	end
end

function var_0_0._refreshRankMode(arg_22_0)
	local var_22_0 = CharacterModel.instance:getRankState()
	local var_22_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.CharVoiceSetting)
	local var_22_2 = 2
	local var_22_3 = 3

	gohelper.setActive(arg_22_0._golvrankSelected, var_22_1 == var_22_2)
	gohelper.setActive(arg_22_0._golvrankUnSelected, var_22_1 ~= var_22_2)
	gohelper.setActive(arg_22_0._gotrustrankSelected, var_22_1 == var_22_3)
	gohelper.setActive(arg_22_0._gotrustrankUnSelected, var_22_1 ~= var_22_3)
	transformhelper.setLocalScale(arg_22_0._transrareArrow, 1, var_22_0[2], 1)
	transformhelper.setLocalScale(arg_22_0._transfaithArrow, 1, var_22_0[3], 1)
end

function var_0_0._refreshClassifyBtnStateView(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_checkHasFilter()

	gohelper.setActive(arg_23_0._goclassifyUnSelected, not var_23_0)
	gohelper.setActive(arg_23_0._goclassifySelected, var_23_0)
	gohelper.setActive(arg_23_0._gosearchfilter, arg_23_1)
end

function var_0_0._updateHeroList(arg_24_0)
	local var_24_0 = {}

	for iter_24_0 = 1, 6 do
		if arg_24_0._selectAttrs[iter_24_0] then
			var_24_0[#var_24_0 + 1] = iter_24_0
		end
	end

	local var_24_1 = {}

	for iter_24_1 = 1, 6 do
		if arg_24_0._selectCharTypes[iter_24_1] then
			var_24_1[#var_24_1 + 1] = iter_24_1
		end
	end

	if #var_24_0 == 0 then
		var_24_0 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_24_1 == 0 then
		var_24_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_24_2 = {
		careers = var_24_0,
		charTypes = var_24_1,
		charLang = arg_24_0._filterLang
	}

	CharacterModel.instance:filterCardListByCareerAndCharType(var_24_2, false, CharacterEnum.FilterType.CharVoiceSetting)
end

function var_0_0.initOptions(arg_25_0)
	arg_25_0._languageOptions = {
		0,
		LangSettings.en,
		LangSettings.zh,
		LangSettings.kr,
		LangSettings.jp
	}

	recthelper.setHeight(arg_25_0._dropfilterTemplateTrans, #arg_25_0._languageOptions * 70)

	arg_25_0._optionsName = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._languageOptions) do
		local var_25_0 = luaLang(iter_25_1 == 0 and "all_language_filter_option" or LangSettings.shortcutTab[iter_25_1])

		arg_25_0._optionsName[#arg_25_0._optionsName + 1] = var_25_0
	end

	arg_25_0._dropfilter:ClearOptions()
	arg_25_0._dropfilter:AddOptions(arg_25_0._optionsName)
	gohelper.setActive(arg_25_0._goarrowup, false)
end

function var_0_0._checkHasFilter(arg_26_0)
	local var_26_0 = {}

	for iter_26_0 = 1, 6 do
		if arg_26_0._selectAttrs[iter_26_0] then
			var_26_0[#var_26_0 + 1] = iter_26_0
		end
	end

	local var_26_1 = {}

	for iter_26_1 = 1, 6 do
		if arg_26_0._selectCharTypes[iter_26_1] then
			var_26_1[#var_26_1 + 1] = iter_26_1
		end
	end

	return #var_26_0 ~= 0 or #var_26_1 ~= 0
end

return var_0_0
