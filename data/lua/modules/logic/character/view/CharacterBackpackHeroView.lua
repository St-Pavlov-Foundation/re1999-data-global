module("modules.logic.character.view.CharacterBackpackHeroView", package.seeall)

slot0 = class("CharacterBackpackHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_card")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolesort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolesort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolesort/#btn_rarerank")
	slot0._btnfaithrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolesort/#btn_faithrank")
	slot0._btnexskillrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolesort/#btn_exskillrank")
	slot0._goexarrow = gohelper.findChild(slot0.viewGO, "#go_rolesort/#btn_exskillrank/#go_exarrow")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolesort/#btn_classify")
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#scroll_card/scrollcontent")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnfaithrank:AddClickListener(slot0._btnfaithrankOnClick, slot0)
	slot0._btnexskillrank:AddClickListener(slot0._btnexskillrankOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnfaithrank:RemoveClickListener()
	slot0._btnexskillrank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._ani = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(slot0._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)

	slot4 = AudioEnum.UI.UI_transverse_tabs_click

	gohelper.addUIClickAudio(slot0._btnfaithrank.gameObject, slot4)

	slot0._lvBtns = slot0:getUserDataTb_()
	slot0._lvArrow = slot0:getUserDataTb_()
	slot0._rareBtns = slot0:getUserDataTb_()
	slot0._rareArrow = slot0:getUserDataTb_()
	slot0._faithBtns = slot0:getUserDataTb_()
	slot0._faithArrow = slot0:getUserDataTb_()
	slot0._classifyBtns = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._lvBtns[slot4] = gohelper.findChild(slot0._btnlvrank.gameObject, "btn" .. tostring(slot4))
		slot0._lvArrow[slot4] = gohelper.findChild(slot0._lvBtns[slot4], "txt/arrow").transform
		slot0._rareBtns[slot4] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot4))
		slot0._rareArrow[slot4] = gohelper.findChild(slot0._rareBtns[slot4], "txt/arrow").transform
		slot0._faithBtns[slot4] = gohelper.findChild(slot0._btnfaithrank.gameObject, "btn" .. tostring(slot4))
		slot0._faithArrow[slot4] = gohelper.findChild(slot0._faithBtns[slot4], "txt/arrow").transform
		slot0._classifyBtns[slot4] = gohelper.findChild(slot0._btnclassify.gameObject, "btn" .. tostring(slot4))
	end

	slot0._selectDmgs = {
		false,
		false
	}
	slot0._selectAttrs = {
		false,
		false,
		false,
		false,
		false,
		false
	}
	slot0._selectLocations = {
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

function slot0._btnclassifyOnClick(slot0)
	CharacterController.instance:openCharacterFilterView({
		dmgs = LuaUtil.deepCopy(slot0._selectDmgs),
		attrs = LuaUtil.deepCopy(slot0._selectAttrs),
		locations = LuaUtil.deepCopy(slot0._selectLocations)
	})
end

function slot0._btnexskillrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.BackpackHero)
	slot0:_refreshBtnIcon()
end

function slot0._btnlvrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.BackpackHero)
	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.BackpackHero)
	slot0:_refreshBtnIcon()
end

function slot0._btnfaithrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(false, CharacterEnum.FilterType.BackpackHero)
	slot0:_refreshBtnIcon()
end

function slot0._refreshBtnIcon(slot0)
	slot1 = CharacterModel.instance:getRankState()

	gohelper.setActive(slot0._lvBtns[1], CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.BackpackHero) ~= 1)
	gohelper.setActive(slot0._lvBtns[2], slot2 == 1)
	gohelper.setActive(slot0._rareBtns[1], slot2 ~= 2)
	gohelper.setActive(slot0._rareBtns[2], slot2 == 2)
	gohelper.setActive(slot0._faithBtns[1], slot2 ~= 3)
	gohelper.setActive(slot0._faithBtns[2], slot2 == 3)

	slot3 = false

	for slot7, slot8 in pairs(slot0._selectDmgs) do
		if slot8 then
			slot3 = true
		end
	end

	for slot7, slot8 in pairs(slot0._selectAttrs) do
		if slot8 then
			slot3 = true
		end
	end

	for slot7, slot8 in pairs(slot0._selectLocations) do
		if slot8 then
			slot3 = true
		end
	end

	gohelper.setActive(slot0._classifyBtns[1], not slot3)
	gohelper.setActive(slot0._classifyBtns[2], slot3)
	transformhelper.setLocalScale(slot0._lvArrow[1], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._lvArrow[2], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._rareArrow[1], 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._rareArrow[2], 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._faithArrow[1], 1, slot1[3], 1)
	transformhelper.setLocalScale(slot0._faithArrow[2], 1, slot1[3], 1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._ani.enabled = #slot0.tabContainer._tabAbLoaders < 2

	slot0:addEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, slot0._onFilterList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._updateHeroList, slot0)

	slot0._scrollcard.verticalNormalizedPosition = 1

	slot0:_refreshBtnIcon()
	slot0:_updateHeroList()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Rolesopen)

	_, slot0._initScrollContentPosY = transformhelper.getLocalPos(slot0._goScrollContent.transform)
end

function slot0._onFilterList(slot0, slot1)
	slot0._selectDmgs = slot1.dmgs
	slot0._selectAttrs = slot1.attrs
	slot0._selectLocations = slot1.locations
	slot2, slot3 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot2, slot0._initScrollContentPosY)
	slot0:_refreshBtnIcon()
end

function slot0._updateHeroList(slot0)
	for slot5 = 1, 2 do
		if slot0._selectDmgs[slot5] then
			table.insert({}, slot5)
		end
	end

	for slot6 = 1, 6 do
		if slot0._selectAttrs[slot6] then
			table.insert({}, slot6)
		end
	end

	for slot7 = 1, 6 do
		if slot0._selectLocations[slot7] then
			table.insert({}, slot7)
		end
	end

	if #slot1 == 0 then
		slot1 = {
			1,
			2
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

	if #slot3 == 0 then
		slot3 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	CharacterModel.instance:filterCardListByDmgAndCareer({
		dmgs = slot1,
		careers = slot2,
		locations = slot3
	}, false, CharacterEnum.FilterType.BackpackHero)
	slot0:_refreshBtnIcon()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.FilterBackpack, slot0._onFilterList, slot0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterBackpackCardListModel.instance:setFirstShowCharacter(nil)
end

function slot0.onDestroyView(slot0)
end

return slot0
