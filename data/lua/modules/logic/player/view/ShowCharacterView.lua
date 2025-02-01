module("modules.logic.player.view.ShowCharacterView", package.seeall)

slot0 = class("ShowCharacterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_card")
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._btnfaithrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	slot0._btnexskillrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	slot0._goexarrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgimg")
	slot0._gosearchfilter = gohelper.findChild(slot0.viewGO, "#go_searchfilter")
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._godmgitem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/dmgContainer/#go_dmgitem")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attritem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_confirm")
	slot0._goAssistReward = gohelper.findChild(slot0.viewGO, "#go_gather")
	slot0._txtAssistRewardCount = gohelper.findChildTextMesh(slot0.viewGO, "#go_gather/#txt_count")
	slot0._btnGetAssistReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_gather/#btn_gather")
	slot0._btnAssistTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_gather/#btn_tip")
	slot0._goCanGetAssistReward = gohelper.findChild(slot0.viewGO, "#go_gather/go_canget")
	slot0._goAssistRewardTip = gohelper.findChild(slot0.viewGO, "#go_gatherTip")
	slot0._btnCloseAssistTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_gatherTip/#btn_closeGatherTip")
	slot0._txtAssistTip = gohelper.findChildTextMesh(slot0.viewGO, "#go_gatherTip/#image_tipDescBg/#txt_tipDesc")

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
	slot0._btnclosefilterview:AddClickListener(slot0._btncloseFilterViewOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnGetAssistReward:AddClickListener(slot0._btnGetAssistRewardOnClick, slot0)
	slot0._btnAssistTip:AddClickListener(slot0._btnAssistTipOnClick, slot0)
	slot0._btnCloseAssistTip:AddClickListener(slot0._btnCloseAssistTipOnClick, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0._refreshAssistRewardCount, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnfaithrank:RemoveClickListener()
	slot0._btnexskillrank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnGetAssistReward:RemoveClickListener()
	slot0._btnAssistTip:RemoveClickListener()
	slot0._btnCloseAssistTip:RemoveClickListener()
	slot0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0._refreshAssistRewardCount, slot0)
end

function slot0._btnlvrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(true, CharacterEnum.FilterType.ShowCharacter)
	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(true, CharacterEnum.FilterType.ShowCharacter)
	slot0:_refreshBtnIcon()
end

function slot0._btnfaithrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(true, CharacterEnum.FilterType.ShowCharacter)
	slot0:_refreshBtnIcon()
end

function slot0._btnexskillrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(true, CharacterEnum.FilterType.ShowCharacter)
	slot0:_refreshBtnIcon()
end

function slot0._btncloseFilterViewOnClick(slot0)
	slot0._selectDmgs = LuaUtil.deepCopy(slot0._curDmgs)
	slot0._selectAttrs = LuaUtil.deepCopy(slot0._curAttrs)
	slot0._selectLocations = LuaUtil.deepCopy(slot0._curLocations)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	slot0:_refreshBtnIcon()
	gohelper.setActive(slot0._gosearchfilter, false)
end

function slot0._btnclassifyOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, true)
	slot0:_refreshFilterView()
end

function slot0._btnresetOnClick(slot0)
	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end

	slot0:_refreshBtnIcon()
	slot0:_refreshFilterView()
end

function slot0._btnconfirmOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)

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

	slot4, slot5 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot4, slot0._initScrollContentPosY)
	CharacterModel.instance:filterCardListByDmgAndCareer({
		dmgs = slot1,
		careers = slot2,
		locations = slot3
	}, true, CharacterEnum.FilterType.ShowCharacter)

	slot0._curDmgs = LuaUtil.deepCopy(slot0._selectDmgs)
	slot0._curAttrs = LuaUtil.deepCopy(slot0._selectAttrs)
	slot0._curLocations = LuaUtil.deepCopy(slot0._selectLocations)

	slot0:_refreshBtnIcon()
end

function slot0._refreshBtnIcon(slot0)
	slot1 = CharacterModel.instance:getRankState()

	gohelper.setActive(slot0._lvBtns[1], CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.ShowCharacter) ~= 1)
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

function slot0._btnGetAssistRewardOnClick(slot0)
	PlayerController.instance:getAssistReward()
end

function slot0._btnAssistTipOnClick(slot0)
	gohelper.setActive(slot0._goAssistRewardTip, true)
end

function slot0._btnCloseAssistTipOnClick(slot0)
	gohelper.setActive(slot0._goAssistRewardTip, false)
end

function slot0._refreshAssistRewardCount(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		gohelper.setActive(slot0._goAssistReward, false)

		return
	end

	gohelper.setActive(slot0._goAssistReward, true)

	if PlayerModel.instance:isGetAssistRewardReachingLimit() then
		slot0._txtAssistRewardCount.text = luaLang("reachUpperLimit")

		gohelper.setActive(slot0._goCanGetAssistReward, false)
	else
		slot0._txtAssistRewardCount.text = PlayerModel.instance:getAssistRewardCount()

		gohelper.setActive(slot0._goCanGetAssistReward, PlayerModel.instance:isHasAssistReward())
	end

	slot0._txtAssistTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("player_assist_reward_tips"), {
		PlayerModel.instance:getHasReceiveAssistBonus(),
		PlayerModel.instance:getMaxAssistRewardCount()
	})
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
	}, true, CharacterEnum.FilterType.ShowCharacter)
	slot0:_refreshBtnIcon()
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnfaithrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)

	slot4 = "full/juesebeibao_005"

	slot0._simagebgimg:LoadImage(ResUrl.getCommonViewBg(slot4))
	CharacterModel.instance:setCardListByCareerIndex(0)

	slot0._lvBtns = slot0:getUserDataTb_()
	slot0._lvArrow = slot0:getUserDataTb_()
	slot0._rareBtns = slot0:getUserDataTb_()
	slot0._rareArrow = slot0:getUserDataTb_()
	slot0._faithBtns = slot0:getUserDataTb_()
	slot0._faithArrow = slot0:getUserDataTb_()
	slot0._classifyBtns = slot0:getUserDataTb_()
	slot0._selectDmgs = {}
	slot0._dmgSelects = slot0:getUserDataTb_()
	slot0._dmgUnselects = slot0:getUserDataTb_()
	slot0._dmgBtnClicks = slot0:getUserDataTb_()
	slot0._selectAttrs = {}
	slot0._attrSelects = slot0:getUserDataTb_()
	slot0._attrUnselects = slot0:getUserDataTb_()
	slot0._attrBtnClicks = slot0:getUserDataTb_()
	slot0._selectLocations = {}
	slot0._locationSelects = slot0:getUserDataTb_()
	slot0._locationUnselects = slot0:getUserDataTb_()
	slot0._locationBtnClicks = slot0:getUserDataTb_()
	slot0._curDmgs = {}
	slot0._curAttrs = {}
	slot0._curLocations = {}

	for slot4 = 1, 2 do
		slot0._lvBtns[slot4] = gohelper.findChild(slot0._btnlvrank.gameObject, "btn" .. tostring(slot4))
		slot0._lvArrow[slot4] = gohelper.findChild(slot0._lvBtns[slot4], "txt/arrow").transform
		slot0._rareBtns[slot4] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot4))
		slot0._rareArrow[slot4] = gohelper.findChild(slot0._rareBtns[slot4], "txt/arrow").transform
		slot0._faithBtns[slot4] = gohelper.findChild(slot0._btnfaithrank.gameObject, "btn" .. tostring(slot4))
		slot0._faithArrow[slot4] = gohelper.findChild(slot0._faithBtns[slot4], "txt/arrow").transform
		slot0._classifyBtns[slot4] = gohelper.findChild(slot0._btnclassify.gameObject, "btn" .. tostring(slot4))
		slot0._dmgUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/unselected")
		slot0._dmgSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/selected")
		slot0._dmgBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/click")
		slot0._selectDmgs[slot4] = false

		slot0._dmgBtnClicks[slot4]:AddClickListener(slot0._dmgBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._attrUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/unselected")
		slot0._attrSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/selected")
		slot0._attrBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/click")
		slot0._selectAttrs[slot4] = false

		slot0._attrBtnClicks[slot4]:AddClickListener(slot0._attrBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._locationUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/unselected")
		slot0._locationSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/selected")
		slot0._locationBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/click")
		slot0._selectLocations[slot4] = false

		slot0._locationBtnClicks[slot4]:AddClickListener(slot0._locationBtnOnClick, slot0, slot4)
	end

	_, slot0._initScrollContentPosY = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	slot0:_btnCloseAssistTipOnClick()
end

function slot0._refreshFilterView(slot0)
	for slot4 = 1, 2 do
		gohelper.setActive(slot0._dmgUnselects[slot4], not slot0._selectDmgs[slot4])
		gohelper.setActive(slot0._dmgSelects[slot4], slot0._selectDmgs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._attrUnselects[slot4], not slot0._selectAttrs[slot4])
		gohelper.setActive(slot0._attrSelects[slot4], slot0._selectAttrs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._locationUnselects[slot4], not slot0._selectLocations[slot4])
		gohelper.setActive(slot0._locationSelects[slot4], slot0._selectLocations[slot4])
	end
end

function slot0._dmgBtnOnClick(slot0, slot1)
	if not slot0._selectDmgs[slot1] then
		slot0._selectDmgs[3 - slot1] = slot0._selectDmgs[slot1]
	end

	slot0._selectDmgs[slot1] = not slot0._selectDmgs[slot1]

	slot0:_refreshFilterView()
end

function slot0._attrBtnOnClick(slot0, slot1)
	slot0._selectAttrs[slot1] = not slot0._selectAttrs[slot1]

	slot0:_refreshFilterView()
end

function slot0._locationBtnOnClick(slot0, slot1)
	slot0._selectLocations[slot1] = not slot0._selectLocations[slot1]

	slot0:_refreshFilterView()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	CharacterModel.instance:setCharacterList(true, CharacterEnum.FilterType.HeroGroup)
	slot0:_refreshBtnIcon()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._updateHeroList, slot0)
	slot0:updateAssistReward()

	if not (slot0.viewParam and slot0.viewParam.notRepeatUpdateAssistReward) then
		TaskDispatcher.cancelTask(slot0.updateAssistReward, slot0)
		TaskDispatcher.runRepeat(slot0.updateAssistReward, slot0, CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency))
	end
end

function slot0.updateAssistReward(slot0)
	gohelper.setActive(slot0._goAssistReward, OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend))
	PlayerController.instance:updateAssistRewardCount()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._updateHeroList, slot0)
	TaskDispatcher.cancelTask(slot0.updateAssistReward, slot0)
end

function slot0._onQuitAdventure(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._simagebgimg:UnLoadImage()

	for slot4 = 1, 2 do
		slot0._dmgBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._attrBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._locationBtnClicks[slot4]:RemoveClickListener()
	end
end

return slot0
