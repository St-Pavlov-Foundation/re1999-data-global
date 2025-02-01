module("modules.logic.settings.view.SettingsRoleVoiceSearchFilterView", package.seeall)

slot0 = class("SettingsRoleVoiceSearchFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._dropfilterTemplateTrans = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/Template").transform
	slot0._gosearchfilter = gohelper.findChild(slot0.viewGO, "#go_searchfilter")
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	slot0._goclassifyUnSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn1")
	slot0._goclassifySelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify/btn2")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_ok")
	slot0._dropfilter = gohelper.findChildDropdown(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang")
	slot0._transArrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_lang/go_arrow").transform
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._btntrustrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank")
	slot0._golvrankUnSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn1")
	slot0._golvrankSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/btn2")
	slot0._gotrustrankUnSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn1")
	slot0._gotrustrankSelected = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_trustrank/btn2")
	slot0._transrareArrow = gohelper.findChild(slot0._golvrankSelected, "txt/arrow").transform
	slot0._transfaithArrow = gohelper.findChild(slot0._gotrustrankSelected, "txt/arrow").transform

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btnclosefilterviewOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btntrustrank:AddClickListener(slot0._btntrustrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._dropfilter:AddOnValueChanged(slot0._onDropFilterValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btntrustrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._dropfilter:RemoveOnValueChanged()
end

function slot0._btnresetOnClick(slot0)
	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
		slot0._selectCharTypes[slot4] = false
	end

	slot0:_refreshView()
end

function slot0._btnconfirmOnClick(slot0)
	slot1 = {}

	for slot5 = 1, 6 do
		if slot0._selectAttrs[slot5] then
			table.insert(slot1, slot5)
		end
	end

	if #slot1 == 0 then
		slot1 = {
			1,
			2,
			3,
			4,
			5,
			6
		} or slot1
	end

	slot2 = {}

	for slot6 = 1, 6 do
		if slot0._selectCharTypes[slot6] then
			slot2[#slot2 + 1] = slot6
		end
	end

	if #slot2 == 0 then
		slot2 = {
			1,
			2,
			3,
			4,
			5,
			6
		} or slot2
	end

	CharacterModel.instance:filterCardListByCareerAndCharType({
		careers = slot1,
		charTypes = slot2,
		charLang = slot0._filterLang
	}, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
	slot0:_refreshClassifyBtnStateView(false)
end

function slot0._btntrustrankOnClick(slot0)
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, false, true)
	slot0:_refreshRankMode()
end

function slot0._btnlvrankOnClick(slot0)
	CharacterModel.instance:setCardListByLangType(CharacterEnum.FilterType.CharVoiceSetting, true, false)
	slot0:_refreshRankMode()
end

function slot0._btnclosefilterviewOnClick(slot0)
	slot0._selectAttrs = LuaUtil.deepCopy(slot0._attrsCopy)
	slot0._selectCharTypes = LuaUtil.deepCopy(slot0._charTypesCopy)

	slot0:_refreshClassifyBtnStateView(false)
end

function slot0._btnclassifyOnClick(slot0)
	slot0._attrsCopy = LuaUtil.deepCopy(slot0._selectAttrs)
	slot0._charTypesCopy = LuaUtil.deepCopy(slot0._selectCharTypes)

	slot0:_refreshClassifyBtnStateView(true)
	slot0:_refreshView()
end

function slot0._onDropFilterValueChanged(slot0, slot1)
	slot0._filterLang = slot0._languageOptions[slot1 + 1] and slot0._languageOptions[slot1 + 1] or 0
	slot2 = {}

	for slot6 = 1, 6 do
		if slot0._selectAttrs[slot6] then
			table.insert(slot2, slot6)
		end
	end

	if #slot2 == 0 then
		slot2 = {
			1,
			2,
			3,
			4,
			5,
			6
		} or slot2
	end

	slot3 = {}

	for slot7 = 1, 6 do
		if slot0._selectCharTypes[slot7] then
			slot3[#slot3 + 1] = slot7
		end
	end

	if #slot3 == 0 then
		slot3 = {
			1,
			2,
			3,
			4,
			5,
			6
		} or slot3
	end

	CharacterModel.instance:filterCardListByCareerAndCharType({
		careers = slot2,
		charTypes = slot3,
		charLang = slot0._filterLang
	}, false, CharacterEnum.FilterType.CharVoiceSetting)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleFiltered)
end

function slot0.onFilterDropShow(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = true

	slot0:refreshFilterDropDownArrow()

	for slot6, slot7 in ipairs(slot0._languageOptions) do
		if slot7 == slot0._filterLang then
			gohelper.findChildText(gohelper.findChild(slot0._dropfilter.gameObject, "Dropdown List/Viewport/Content").transform:GetChild(slot6).gameObject, "Text").text = string.format("<color=#efb785ff>%s</color>", slot0._optionsName[slot6])
		else
			slot9.text = string.format("<color=#c3beb6ff>%s</color>", slot0._optionsName[slot6])
		end
	end
end

function slot0.onFilterDropHide(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	slot0._isPopUpFilterList = false

	slot0:refreshFilterDropDownArrow()
end

function slot0.refreshFilterDropDownArrow(slot0)
	transformhelper.setLocalScale(slot0._transArrow, 1, slot0._isPopUpFilterList and -1 or 1, 1)
end

function slot0._editableInitView(slot0)
	slot0._attrSelects = slot0:getUserDataTb_()
	slot0._attrUnselects = slot0:getUserDataTb_()
	slot0._attrBtnClicks = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot0._attrUnselects[slot4] = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/unselected")
		slot0._attrSelects[slot4] = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/selected")
		slot0._attrBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/click")

		slot0._attrBtnClicks[slot4]:AddClickListener(slot0._attrBtnOnClick, slot0, slot4)
	end

	slot0._charTypeSelects = slot0:getUserDataTb_()
	slot0._charTypeUnselects = slot0:getUserDataTb_()
	slot0._charTypeBtnClicks = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot0._charTypeUnselects[slot4] = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/unselected")
		slot0._charTypeSelects[slot4] = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/selected")
		slot0._charTypeBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/click")

		slot0._charTypeBtnClicks[slot4]:AddClickListener(slot0._charTypeBtnOnClick, slot0, slot4)
	end

	slot0._filterLang = 0
end

function slot0._attrBtnOnClick(slot0, slot1)
	slot0._selectAttrs[slot1] = not slot0._selectAttrs[slot1]

	slot0:_refreshView()
end

function slot0._charTypeBtnOnClick(slot0, slot1)
	slot0._selectCharTypes[slot1] = not slot0._selectCharTypes[slot1]

	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot4 = SettingsEvent.OnCharVoiceTypeChanged

	slot0:addEventCb(SettingsRoleVoiceController.instance, slot4, slot0._onCharVoiceTypeChanged, slot0)

	slot0._selectAttrs = {}
	slot0._selectCharTypes = {}

	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
		slot0._selectCharTypes[slot4] = false
	end

	slot0.filterDropExtend = DropDownExtend.Get(slot0._dropfilter.gameObject)

	slot0.filterDropExtend:init(slot0.onFilterDropShow, slot0.onFilterDropHide, slot0)
	slot0:initOptions()
	slot0:_refreshView()
	slot0:_refreshClassifyBtnStateView(false)
	CharacterBackpackCardListModel.instance:updateModel()
	slot0:_updateHeroList()
	slot0:_refreshRankMode()
end

function slot0.onClose(slot0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._attrBtnClicks do
		slot0._attrBtnClicks[slot4]:RemoveClickListener()
		slot0._charTypeBtnClicks[slot4]:RemoveClickListener()
	end
end

function slot0._onCharVoiceTypeChanged(slot0)
end

function slot0._refreshView(slot0, slot1, slot2)
	slot1 = slot1 or slot0._selectAttrs
	slot2 = slot2 or slot0._selectCharTypes

	for slot6 = 1, 6 do
		gohelper.setActive(slot0._attrUnselects[slot6], not slot1[slot6])
		gohelper.setActive(slot0._attrSelects[slot6], slot1[slot6])
	end

	for slot6 = 1, 6 do
		gohelper.setActive(slot0._charTypeUnselects[slot6], not slot2[slot6])
		gohelper.setActive(slot0._charTypeSelects[slot6], slot2[slot6])
	end
end

function slot0._refreshRankMode(slot0)
	slot1 = CharacterModel.instance:getRankState()
	slot4 = 3

	gohelper.setActive(slot0._golvrankSelected, CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.CharVoiceSetting) == 2)
	gohelper.setActive(slot0._golvrankUnSelected, slot2 ~= slot3)
	gohelper.setActive(slot0._gotrustrankSelected, slot2 == slot4)
	gohelper.setActive(slot0._gotrustrankUnSelected, slot2 ~= slot4)
	transformhelper.setLocalScale(slot0._transrareArrow, 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._transfaithArrow, 1, slot1[3], 1)
end

function slot0._refreshClassifyBtnStateView(slot0, slot1)
	slot2 = slot0:_checkHasFilter()

	gohelper.setActive(slot0._goclassifyUnSelected, not slot2)
	gohelper.setActive(slot0._goclassifySelected, slot2)
	gohelper.setActive(slot0._gosearchfilter, slot1)
end

function slot0._updateHeroList(slot0)
	slot1 = {}

	for slot5 = 1, 6 do
		if slot0._selectAttrs[slot5] then
			slot1[#slot1 + 1] = slot5
		end
	end

	slot2 = {}

	for slot6 = 1, 6 do
		if slot0._selectCharTypes[slot6] then
			slot2[#slot2 + 1] = slot6
		end
	end

	if #slot1 == 0 then
		slot1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #slot2 == 0 then
		slot2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	CharacterModel.instance:filterCardListByCareerAndCharType({
		careers = slot1,
		charTypes = slot2,
		charLang = slot0._filterLang
	}, false, CharacterEnum.FilterType.CharVoiceSetting)
end

function slot0.initOptions(slot0)
	slot0._languageOptions = {
		0,
		LangSettings.en,
		LangSettings.zh,
		LangSettings.kr,
		LangSettings.jp
	}

	recthelper.setHeight(slot0._dropfilterTemplateTrans, #slot0._languageOptions * 70)

	slot0._optionsName = {}

	for slot4, slot5 in ipairs(slot0._languageOptions) do
		slot0._optionsName[#slot0._optionsName + 1] = luaLang(slot5 == 0 and "all_language_filter_option" or LangSettings.shortcutTab[slot5])
	end

	slot0._dropfilter:ClearOptions()
	slot0._dropfilter:AddOptions(slot0._optionsName)
	gohelper.setActive(slot0._goarrowup, false)
end

function slot0._checkHasFilter(slot0)
	slot1 = {}

	for slot5 = 1, 6 do
		if slot0._selectAttrs[slot5] then
			slot1[#slot1 + 1] = slot5
		end
	end

	slot2 = {}

	for slot6 = 1, 6 do
		if slot0._selectCharTypes[slot6] then
			slot2[#slot2 + 1] = slot6
		end
	end

	return #slot1 ~= 0 or #slot2 ~= 0
end

return slot0
