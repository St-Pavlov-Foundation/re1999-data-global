module("modules.logic.weekwalk.view.WeekWalkCharacterView", package.seeall)

slot0 = class("WeekWalkCharacterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_card")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._btnfaithrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	slot0._btnexskillrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	slot0._goexarrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnfaithrank:AddClickListener(slot0._btnfaithrankOnClick, slot0)
	slot0._btnexskillrank:AddClickListener(slot0._btnexskillrankOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnfaithrank:RemoveClickListener()
	slot0._btnexskillrank:RemoveClickListener()
end

function slot0._btnlvrankOnClick(slot0)
	WeekWalkCharacterModel.instance:setCardListByLevel()
	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	WeekWalkCharacterModel.instance:setCardListByRare()
	slot0:_refreshBtnIcon()
end

function slot0._btnfaithrankOnClick(slot0)
	WeekWalkCharacterModel.instance:setCardListByFaith()
	slot0:_refreshBtnIcon()
end

function slot0._btnexskillrankOnClick(slot0)
	WeekWalkCharacterModel.instance:setCardListByExSkill()
	slot0:_refreshBtnIcon()
end

function slot0._refreshBtnIcon(slot0)
	slot1 = WeekWalkCharacterModel.instance:getRankState()

	gohelper.setActive(slot0._lvBtns[1], WeekWalkCharacterModel.instance:getBtnTag() ~= 1)
	gohelper.setActive(slot0._lvBtns[2], slot2 == 1)
	gohelper.setActive(slot0._rareBtns[1], slot2 ~= 2)
	gohelper.setActive(slot0._rareBtns[2], slot2 == 2)
	gohelper.setActive(slot0._faithBtns[1], slot2 ~= 3)
	gohelper.setActive(slot0._faithBtns[2], slot2 == 3)
	transformhelper.setLocalScale(slot0._lvArrow[1], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._lvArrow[2], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._rareArrow[1], 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._rareArrow[2], 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._faithArrow[1], 1, slot1[3], 1)
	transformhelper.setLocalScale(slot0._faithArrow[2], 1, slot1[3], 1)
end

function slot0._updateHeroList(slot0)
	WeekWalkCharacterModel.instance:updateCardList()
	WeekWalkCharacterModel.instance:setCharacterList()
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))

	slot0._dropclassify = gohelper.findChildDropdown(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#drop_classify")

	WeekWalkCharacterModel.instance:setCardListByCareerIndex(0)
	slot0._dropclassify:SetValue(WeekWalkCharacterModel.instance:getRankIndex())

	slot4 = slot0

	slot0._dropclassify:AddOnValueChanged(slot0._onValueChanged, slot4)

	slot0._lvBtns = slot0:getUserDataTb_()
	slot0._lvArrow = slot0:getUserDataTb_()
	slot0._rareBtns = slot0:getUserDataTb_()
	slot0._rareArrow = slot0:getUserDataTb_()
	slot0._faithBtns = slot0:getUserDataTb_()
	slot0._faithArrow = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._lvBtns[slot4] = gohelper.findChild(slot0._btnlvrank.gameObject, "btn" .. tostring(slot4))
		slot0._lvArrow[slot4] = gohelper.findChild(slot0._lvBtns[slot4], "arrow").transform
		slot0._rareBtns[slot4] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot4))
		slot0._rareArrow[slot4] = gohelper.findChild(slot0._rareBtns[slot4], "arrow").transform
		slot0._faithBtns[slot4] = gohelper.findChild(slot0._btnfaithrank.gameObject, "btn" .. tostring(slot4))
		slot0._faithArrow[slot4] = gohelper.findChild(slot0._faithBtns[slot4], "arrow").transform
	end

	gohelper.addUIClickAudio(slot0._btnlvrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._btnfaithrank.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(slot0._dropclassify.gameObject, AudioEnum.UI.play_ui_hero_card_property)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	WeekWalkCharacterModel.instance:setCharacterList()
	slot0:_refreshBtnIcon()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._updateHeroList, slot0)
end

function slot0.onClose(slot0)
	CommonHeroHelper.instance:resetGrayState()
end

function slot0._onValueChanged(slot0, slot1)
	WeekWalkCharacterModel.instance:setCardListByCareerIndex(slot1)
	WeekWalkCharacterModel.instance:setCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function slot0.onDestroyView(slot0)
	slot0._imgBg:UnLoadImage()
	slot0._dropclassify:RemoveOnValueChanged()
end

return slot0
