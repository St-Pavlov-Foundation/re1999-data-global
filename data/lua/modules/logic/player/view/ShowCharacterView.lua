module("modules.logic.player.view.ShowCharacterView", package.seeall)

local var_0_0 = class("ShowCharacterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btnfaithrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._godmgitem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/dmgContainer/#go_dmgitem")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attritem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_confirm")
	arg_1_0._goAssistReward = gohelper.findChild(arg_1_0.viewGO, "#go_gather")
	arg_1_0._txtAssistRewardCount = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_gather/#txt_count")
	arg_1_0._btnGetAssistReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_gather/#btn_gather")
	arg_1_0._btnAssistTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_gather/#btn_tip")
	arg_1_0._goCanGetAssistReward = gohelper.findChild(arg_1_0.viewGO, "#go_gather/go_canget")
	arg_1_0._goAssistRewardTip = gohelper.findChild(arg_1_0.viewGO, "#go_gatherTip")
	arg_1_0._btnCloseAssistTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_gatherTip/#btn_closeGatherTip")
	arg_1_0._txtAssistTip = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_gatherTip/#image_tipDescBg/#txt_tipDesc")

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
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btncloseFilterViewOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnGetAssistReward:AddClickListener(arg_2_0._btnGetAssistRewardOnClick, arg_2_0)
	arg_2_0._btnAssistTip:AddClickListener(arg_2_0._btnAssistTipOnClick, arg_2_0)
	arg_2_0._btnCloseAssistTip:AddClickListener(arg_2_0._btnCloseAssistTipOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_2_0._refreshAssistRewardCount, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnfaithrank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnGetAssistReward:RemoveClickListener()
	arg_3_0._btnAssistTip:RemoveClickListener()
	arg_3_0._btnCloseAssistTip:RemoveClickListener()
	arg_3_0:removeEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_3_0._refreshAssistRewardCount, arg_3_0)
end

function var_0_0._btnlvrankOnClick(arg_4_0)
	local var_4_0, var_4_1 = transformhelper.getLocalPos(arg_4_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_4_0._goScrollContent.transform, var_4_0, arg_4_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(true, CharacterEnum.FilterType.ShowCharacter)
	arg_4_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_5_0)
	local var_5_0, var_5_1 = transformhelper.getLocalPos(arg_5_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_5_0._goScrollContent.transform, var_5_0, arg_5_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(true, CharacterEnum.FilterType.ShowCharacter)
	arg_5_0:_refreshBtnIcon()
end

function var_0_0._btnfaithrankOnClick(arg_6_0)
	local var_6_0, var_6_1 = transformhelper.getLocalPos(arg_6_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_6_0._goScrollContent.transform, var_6_0, arg_6_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(true, CharacterEnum.FilterType.ShowCharacter)
	arg_6_0:_refreshBtnIcon()
end

function var_0_0._btnexskillrankOnClick(arg_7_0)
	local var_7_0, var_7_1 = transformhelper.getLocalPos(arg_7_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_7_0._goScrollContent.transform, var_7_0, arg_7_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(true, CharacterEnum.FilterType.ShowCharacter)
	arg_7_0:_refreshBtnIcon()
end

function var_0_0._btncloseFilterViewOnClick(arg_8_0)
	arg_8_0._selectDmgs = LuaUtil.deepCopy(arg_8_0._curDmgs)
	arg_8_0._selectAttrs = LuaUtil.deepCopy(arg_8_0._curAttrs)
	arg_8_0._selectLocations = LuaUtil.deepCopy(arg_8_0._curLocations)

	local var_8_0, var_8_1 = transformhelper.getLocalPos(arg_8_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_8_0._goScrollContent.transform, var_8_0, arg_8_0._initScrollContentPosY)
	arg_8_0:_refreshBtnIcon()
	gohelper.setActive(arg_8_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._gosearchfilter, true)
	arg_9_0:_refreshFilterView()
end

function var_0_0._btnresetOnClick(arg_10_0)
	for iter_10_0 = 1, 2 do
		arg_10_0._selectDmgs[iter_10_0] = false
	end

	for iter_10_1 = 1, 6 do
		arg_10_0._selectAttrs[iter_10_1] = false
	end

	for iter_10_2 = 1, 6 do
		arg_10_0._selectLocations[iter_10_2] = false
	end

	arg_10_0:_refreshBtnIcon()
	arg_10_0:_refreshFilterView()
end

function var_0_0._btnconfirmOnClick(arg_11_0)
	gohelper.setActive(arg_11_0._gosearchfilter, false)

	local var_11_0 = {}

	for iter_11_0 = 1, 2 do
		if arg_11_0._selectDmgs[iter_11_0] then
			table.insert(var_11_0, iter_11_0)
		end
	end

	local var_11_1 = {}

	for iter_11_1 = 1, 6 do
		if arg_11_0._selectAttrs[iter_11_1] then
			table.insert(var_11_1, iter_11_1)
		end
	end

	local var_11_2 = {}

	for iter_11_2 = 1, 6 do
		if arg_11_0._selectLocations[iter_11_2] then
			table.insert(var_11_2, iter_11_2)
		end
	end

	if #var_11_0 == 0 then
		var_11_0 = {
			1,
			2
		}
	end

	if #var_11_1 == 0 then
		var_11_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_11_2 == 0 then
		var_11_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_11_3, var_11_4 = transformhelper.getLocalPos(arg_11_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_11_0._goScrollContent.transform, var_11_3, arg_11_0._initScrollContentPosY)

	local var_11_5 = {
		dmgs = var_11_0,
		careers = var_11_1,
		locations = var_11_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_11_5, true, CharacterEnum.FilterType.ShowCharacter)

	arg_11_0._curDmgs = LuaUtil.deepCopy(arg_11_0._selectDmgs)
	arg_11_0._curAttrs = LuaUtil.deepCopy(arg_11_0._selectAttrs)
	arg_11_0._curLocations = LuaUtil.deepCopy(arg_11_0._selectLocations)

	arg_11_0:_refreshBtnIcon()
end

function var_0_0._refreshBtnIcon(arg_12_0)
	local var_12_0 = CharacterModel.instance:getRankState()
	local var_12_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.ShowCharacter)

	gohelper.setActive(arg_12_0._lvBtns[1], var_12_1 ~= 1)
	gohelper.setActive(arg_12_0._lvBtns[2], var_12_1 == 1)
	gohelper.setActive(arg_12_0._rareBtns[1], var_12_1 ~= 2)
	gohelper.setActive(arg_12_0._rareBtns[2], var_12_1 == 2)
	gohelper.setActive(arg_12_0._faithBtns[1], var_12_1 ~= 3)
	gohelper.setActive(arg_12_0._faithBtns[2], var_12_1 == 3)

	local var_12_2 = false

	for iter_12_0, iter_12_1 in pairs(arg_12_0._selectDmgs) do
		if iter_12_1 then
			var_12_2 = true
		end
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._selectAttrs) do
		if iter_12_3 then
			var_12_2 = true
		end
	end

	for iter_12_4, iter_12_5 in pairs(arg_12_0._selectLocations) do
		if iter_12_5 then
			var_12_2 = true
		end
	end

	gohelper.setActive(arg_12_0._classifyBtns[1], not var_12_2)
	gohelper.setActive(arg_12_0._classifyBtns[2], var_12_2)
	transformhelper.setLocalScale(arg_12_0._lvArrow[1], 1, var_12_0[1], 1)
	transformhelper.setLocalScale(arg_12_0._lvArrow[2], 1, var_12_0[1], 1)
	transformhelper.setLocalScale(arg_12_0._rareArrow[1], 1, var_12_0[2], 1)
	transformhelper.setLocalScale(arg_12_0._rareArrow[2], 1, var_12_0[2], 1)
	transformhelper.setLocalScale(arg_12_0._faithArrow[1], 1, var_12_0[3], 1)
	transformhelper.setLocalScale(arg_12_0._faithArrow[2], 1, var_12_0[3], 1)
end

function var_0_0._btnGetAssistRewardOnClick(arg_13_0)
	PlayerController.instance:getAssistReward()
end

function var_0_0._btnAssistTipOnClick(arg_14_0)
	gohelper.setActive(arg_14_0._goAssistRewardTip, true)
end

function var_0_0._btnCloseAssistTipOnClick(arg_15_0)
	gohelper.setActive(arg_15_0._goAssistRewardTip, false)
end

function var_0_0._refreshAssistRewardCount(arg_16_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		gohelper.setActive(arg_16_0._goAssistReward, false)

		return
	end

	gohelper.setActive(arg_16_0._goAssistReward, true)

	if PlayerModel.instance:isGetAssistRewardReachingLimit() then
		arg_16_0._txtAssistRewardCount.text = luaLang("reachUpperLimit")

		gohelper.setActive(arg_16_0._goCanGetAssistReward, false)
	else
		local var_16_0 = PlayerModel.instance:getAssistRewardCount()

		arg_16_0._txtAssistRewardCount.text = var_16_0

		local var_16_1 = PlayerModel.instance:isHasAssistReward()

		gohelper.setActive(arg_16_0._goCanGetAssistReward, var_16_1)
	end

	local var_16_2 = PlayerModel.instance:getHasReceiveAssistBonus()
	local var_16_3 = PlayerModel.instance:getMaxAssistRewardCount()
	local var_16_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("player_assist_reward_tips"), {
		var_16_2,
		var_16_3
	})

	arg_16_0._txtAssistTip.text = var_16_4
end

function var_0_0._updateHeroList(arg_17_0)
	local var_17_0 = {}

	for iter_17_0 = 1, 2 do
		if arg_17_0._selectDmgs[iter_17_0] then
			table.insert(var_17_0, iter_17_0)
		end
	end

	local var_17_1 = {}

	for iter_17_1 = 1, 6 do
		if arg_17_0._selectAttrs[iter_17_1] then
			table.insert(var_17_1, iter_17_1)
		end
	end

	local var_17_2 = {}

	for iter_17_2 = 1, 6 do
		if arg_17_0._selectLocations[iter_17_2] then
			table.insert(var_17_2, iter_17_2)
		end
	end

	if #var_17_0 == 0 then
		var_17_0 = {
			1,
			2
		}
	end

	if #var_17_1 == 0 then
		var_17_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_17_2 == 0 then
		var_17_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_17_3 = {
		dmgs = var_17_0,
		careers = var_17_1,
		locations = var_17_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_17_3, true, CharacterEnum.FilterType.ShowCharacter)
	arg_17_0:_refreshBtnIcon()
end

function var_0_0._editableInitView(arg_18_0)
	gohelper.addUIClickAudio(arg_18_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_18_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_18_0._btnfaithrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_18_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	arg_18_0._simagebgimg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	CharacterModel.instance:setCardListByCareerIndex(0)

	arg_18_0._lvBtns = arg_18_0:getUserDataTb_()
	arg_18_0._lvArrow = arg_18_0:getUserDataTb_()
	arg_18_0._rareBtns = arg_18_0:getUserDataTb_()
	arg_18_0._rareArrow = arg_18_0:getUserDataTb_()
	arg_18_0._faithBtns = arg_18_0:getUserDataTb_()
	arg_18_0._faithArrow = arg_18_0:getUserDataTb_()
	arg_18_0._classifyBtns = arg_18_0:getUserDataTb_()
	arg_18_0._selectDmgs = {}
	arg_18_0._dmgSelects = arg_18_0:getUserDataTb_()
	arg_18_0._dmgUnselects = arg_18_0:getUserDataTb_()
	arg_18_0._dmgBtnClicks = arg_18_0:getUserDataTb_()
	arg_18_0._selectAttrs = {}
	arg_18_0._attrSelects = arg_18_0:getUserDataTb_()
	arg_18_0._attrUnselects = arg_18_0:getUserDataTb_()
	arg_18_0._attrBtnClicks = arg_18_0:getUserDataTb_()
	arg_18_0._selectLocations = {}
	arg_18_0._locationSelects = arg_18_0:getUserDataTb_()
	arg_18_0._locationUnselects = arg_18_0:getUserDataTb_()
	arg_18_0._locationBtnClicks = arg_18_0:getUserDataTb_()
	arg_18_0._curDmgs = {}
	arg_18_0._curAttrs = {}
	arg_18_0._curLocations = {}

	for iter_18_0 = 1, 2 do
		arg_18_0._lvBtns[iter_18_0] = gohelper.findChild(arg_18_0._btnlvrank.gameObject, "btn" .. tostring(iter_18_0))
		arg_18_0._lvArrow[iter_18_0] = gohelper.findChild(arg_18_0._lvBtns[iter_18_0], "txt/arrow").transform
		arg_18_0._rareBtns[iter_18_0] = gohelper.findChild(arg_18_0._btnrarerank.gameObject, "btn" .. tostring(iter_18_0))
		arg_18_0._rareArrow[iter_18_0] = gohelper.findChild(arg_18_0._rareBtns[iter_18_0], "txt/arrow").transform
		arg_18_0._faithBtns[iter_18_0] = gohelper.findChild(arg_18_0._btnfaithrank.gameObject, "btn" .. tostring(iter_18_0))
		arg_18_0._faithArrow[iter_18_0] = gohelper.findChild(arg_18_0._faithBtns[iter_18_0], "txt/arrow").transform
		arg_18_0._classifyBtns[iter_18_0] = gohelper.findChild(arg_18_0._btnclassify.gameObject, "btn" .. tostring(iter_18_0))
		arg_18_0._dmgUnselects[iter_18_0] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_18_0 .. "/unselected")
		arg_18_0._dmgSelects[iter_18_0] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_18_0 .. "/selected")
		arg_18_0._dmgBtnClicks[iter_18_0] = gohelper.findChildButtonWithAudio(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_18_0 .. "/click")
		arg_18_0._selectDmgs[iter_18_0] = false

		arg_18_0._dmgBtnClicks[iter_18_0]:AddClickListener(arg_18_0._dmgBtnOnClick, arg_18_0, iter_18_0)
	end

	for iter_18_1 = 1, 6 do
		arg_18_0._attrUnselects[iter_18_1] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_18_1 .. "/unselected")
		arg_18_0._attrSelects[iter_18_1] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_18_1 .. "/selected")
		arg_18_0._attrBtnClicks[iter_18_1] = gohelper.findChildButtonWithAudio(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_18_1 .. "/click")
		arg_18_0._selectAttrs[iter_18_1] = false

		arg_18_0._attrBtnClicks[iter_18_1]:AddClickListener(arg_18_0._attrBtnOnClick, arg_18_0, iter_18_1)
	end

	for iter_18_2 = 1, 6 do
		arg_18_0._locationUnselects[iter_18_2] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_18_2 .. "/unselected")
		arg_18_0._locationSelects[iter_18_2] = gohelper.findChild(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_18_2 .. "/selected")
		arg_18_0._locationBtnClicks[iter_18_2] = gohelper.findChildButtonWithAudio(arg_18_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_18_2 .. "/click")
		arg_18_0._selectLocations[iter_18_2] = false

		arg_18_0._locationBtnClicks[iter_18_2]:AddClickListener(arg_18_0._locationBtnOnClick, arg_18_0, iter_18_2)
	end

	_, arg_18_0._initScrollContentPosY = transformhelper.getLocalPos(arg_18_0._goScrollContent.transform)

	arg_18_0:_btnCloseAssistTipOnClick()
end

function var_0_0._refreshFilterView(arg_19_0)
	for iter_19_0 = 1, 2 do
		gohelper.setActive(arg_19_0._dmgUnselects[iter_19_0], not arg_19_0._selectDmgs[iter_19_0])
		gohelper.setActive(arg_19_0._dmgSelects[iter_19_0], arg_19_0._selectDmgs[iter_19_0])
	end

	for iter_19_1 = 1, 6 do
		gohelper.setActive(arg_19_0._attrUnselects[iter_19_1], not arg_19_0._selectAttrs[iter_19_1])
		gohelper.setActive(arg_19_0._attrSelects[iter_19_1], arg_19_0._selectAttrs[iter_19_1])
	end

	for iter_19_2 = 1, 6 do
		gohelper.setActive(arg_19_0._locationUnselects[iter_19_2], not arg_19_0._selectLocations[iter_19_2])
		gohelper.setActive(arg_19_0._locationSelects[iter_19_2], arg_19_0._selectLocations[iter_19_2])
	end
end

function var_0_0._dmgBtnOnClick(arg_20_0, arg_20_1)
	if not arg_20_0._selectDmgs[arg_20_1] then
		arg_20_0._selectDmgs[3 - arg_20_1] = arg_20_0._selectDmgs[arg_20_1]
	end

	arg_20_0._selectDmgs[arg_20_1] = not arg_20_0._selectDmgs[arg_20_1]

	arg_20_0:_refreshFilterView()
end

function var_0_0._attrBtnOnClick(arg_21_0, arg_21_1)
	arg_21_0._selectAttrs[arg_21_1] = not arg_21_0._selectAttrs[arg_21_1]

	arg_21_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_22_0, arg_22_1)
	arg_22_0._selectLocations[arg_22_1] = not arg_22_0._selectLocations[arg_22_1]

	arg_22_0:_refreshFilterView()
end

function var_0_0.onUpdateParam(arg_23_0)
	return
end

function var_0_0.onOpen(arg_24_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	CharacterModel.instance:setCharacterList(true, CharacterEnum.FilterType.HeroGroup)
	arg_24_0:_refreshBtnIcon()
	arg_24_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_24_0._updateHeroList, arg_24_0)
	arg_24_0:updateAssistReward()

	if not (arg_24_0.viewParam and arg_24_0.viewParam.notRepeatUpdateAssistReward) then
		local var_24_0 = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency)

		TaskDispatcher.cancelTask(arg_24_0.updateAssistReward, arg_24_0)
		TaskDispatcher.runRepeat(arg_24_0.updateAssistReward, arg_24_0, var_24_0)
	end
end

function var_0_0.updateAssistReward(arg_25_0)
	local var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)

	gohelper.setActive(arg_25_0._goAssistReward, var_25_0)
	PlayerController.instance:updateAssistRewardCount()
end

function var_0_0.onClose(arg_26_0)
	arg_26_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_26_0._updateHeroList, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.updateAssistReward, arg_26_0)
end

function var_0_0._onQuitAdventure(arg_27_0)
	arg_27_0:closeThis()
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simagebgimg:UnLoadImage()

	for iter_28_0 = 1, 2 do
		arg_28_0._dmgBtnClicks[iter_28_0]:RemoveClickListener()
	end

	for iter_28_1 = 1, 6 do
		arg_28_0._attrBtnClicks[iter_28_1]:RemoveClickListener()
	end

	for iter_28_2 = 1, 6 do
		arg_28_0._locationBtnClicks[iter_28_2]:RemoveClickListener()
	end
end

return var_0_0
