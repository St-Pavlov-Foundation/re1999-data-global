-- chunkname: @modules/logic/player/view/ShowCharacterView.lua

module("modules.logic.player.view.ShowCharacterView", package.seeall)

local ShowCharacterView = class("ShowCharacterView", BaseView)

function ShowCharacterView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnfaithrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_faithrank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._simagebgimg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bgimg")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._godmgitem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/dmgContainer/#go_dmgitem")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attritem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_confirm")
	self._goAssistReward = gohelper.findChild(self.viewGO, "#go_gather")
	self._txtAssistRewardCount = gohelper.findChildTextMesh(self.viewGO, "#go_gather/#txt_count")
	self._btnGetAssistReward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gather/#btn_gather")
	self._btnAssistTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gather/#btn_tip")
	self._goCanGetAssistReward = gohelper.findChild(self.viewGO, "#go_gather/go_canget")
	self._goAssistRewardTip = gohelper.findChild(self.viewGO, "#go_gatherTip")
	self._btnCloseAssistTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gatherTip/#btn_closeGatherTip")
	self._txtAssistTip = gohelper.findChildTextMesh(self.viewGO, "#go_gatherTip/#image_tipDescBg/#txt_tipDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShowCharacterView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfaithrank:AddClickListener(self._btnfaithrankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btnclosefilterview:AddClickListener(self._btncloseFilterViewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnGetAssistReward:AddClickListener(self._btnGetAssistRewardOnClick, self)
	self._btnAssistTip:AddClickListener(self._btnAssistTipOnClick, self)
	self._btnCloseAssistTip:AddClickListener(self._btnCloseAssistTipOnClick, self)
	self:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshAssistRewardCount, self)
end

function ShowCharacterView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnfaithrank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnGetAssistReward:RemoveClickListener()
	self._btnAssistTip:RemoveClickListener()
	self._btnCloseAssistTip:RemoveClickListener()
	self:removeEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshAssistRewardCount, self)
end

function ShowCharacterView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnfaithrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByFaith(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_btncloseFilterViewOnClick()
	self._selectDmgs = LuaUtil.deepCopy(self._curDmgs)
	self._selectAttrs = LuaUtil.deepCopy(self._curAttrs)
	self._selectLocations = LuaUtil.deepCopy(self._curLocations)

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	self:_refreshBtnIcon()
	gohelper.setActive(self._gosearchfilter, false)
end

function ShowCharacterView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
	self:_refreshFilterView()
end

function ShowCharacterView:_btnresetOnClick()
	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshBtnIcon()
	self:_refreshFilterView()
end

function ShowCharacterView:_btnconfirmOnClick()
	gohelper.setActive(self._gosearchfilter, false)

	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, true, CharacterEnum.FilterType.ShowCharacter)

	self._curDmgs = LuaUtil.deepCopy(self._selectDmgs)
	self._curAttrs = LuaUtil.deepCopy(self._selectAttrs)
	self._curLocations = LuaUtil.deepCopy(self._selectLocations)

	self:_refreshBtnIcon()
end

function ShowCharacterView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.ShowCharacter)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)
	gohelper.setActive(self._faithBtns[1], tag ~= 3)
	gohelper.setActive(self._faithBtns[2], tag == 3)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectLocations) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
	transformhelper.setLocalScale(self._faithArrow[1], 1, state[3], 1)
	transformhelper.setLocalScale(self._faithArrow[2], 1, state[3], 1)
end

function ShowCharacterView:_btnGetAssistRewardOnClick()
	PlayerController.instance:getAssistReward()
end

function ShowCharacterView:_btnAssistTipOnClick()
	gohelper.setActive(self._goAssistRewardTip, true)
end

function ShowCharacterView:_btnCloseAssistTipOnClick()
	gohelper.setActive(self._goAssistRewardTip, false)
end

function ShowCharacterView:_refreshAssistRewardCount()
	local isFriendUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)

	if not isFriendUnlock then
		gohelper.setActive(self._goAssistReward, false)

		return
	end

	gohelper.setActive(self._goAssistReward, true)

	local isReachingLimit = PlayerModel.instance:isGetAssistRewardReachingLimit()

	if isReachingLimit then
		self._txtAssistRewardCount.text = luaLang("reachUpperLimit")

		gohelper.setActive(self._goCanGetAssistReward, false)
	else
		local assistRewardCount = PlayerModel.instance:getAssistRewardCount()

		self._txtAssistRewardCount.text = assistRewardCount

		local isHasAssistReward = PlayerModel.instance:isHasAssistReward()

		gohelper.setActive(self._goCanGetAssistReward, isHasAssistReward)
	end

	local hasReceivedAssistRewardCount = PlayerModel.instance:getHasReceiveAssistBonus()
	local maxAssistRewardCount = PlayerModel.instance:getMaxAssistRewardCount()
	local langStr = GameUtil.getSubPlaceholderLuaLang(luaLang("player_assist_reward_tips"), {
		hasReceivedAssistRewardCount,
		maxAssistRewardCount
	})

	self._txtAssistTip.text = langStr
end

function ShowCharacterView:_updateHeroList()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, true, CharacterEnum.FilterType.ShowCharacter)
	self:_refreshBtnIcon()
end

function ShowCharacterView:_editableInitView()
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnfaithrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	self._simagebgimg:LoadImage(ResUrl.getCommonViewBg("full/juesebeibao_005"))
	CharacterModel.instance:setCardListByCareerIndex(0)

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._faithBtns = self:getUserDataTb_()
	self._faithArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()
	self._selectDmgs = {}
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._selectAttrs = {}
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._selectLocations = {}
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()
	self._curDmgs = {}
	self._curAttrs = {}
	self._curLocations = {}

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._faithBtns[i] = gohelper.findChild(self._btnfaithrank.gameObject, "btn" .. tostring(i))
		self._faithArrow[i] = gohelper.findChild(self._faithBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
		self._dmgUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")
		self._selectDmgs[i] = false

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")
		self._selectAttrs[i] = false

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")
		self._selectLocations[i] = false

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
	end

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)

	self:_btnCloseAssistTipOnClick()
end

function ShowCharacterView:_refreshFilterView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function ShowCharacterView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshFilterView()
end

function ShowCharacterView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshFilterView()
end

function ShowCharacterView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshFilterView()
end

function ShowCharacterView:onUpdateParam()
	return
end

function ShowCharacterView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	CharacterModel.instance:setCharacterList(true, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()
	self:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	self:updateAssistReward()

	local notRepeatUpdateAssistReward = self.viewParam and self.viewParam.notRepeatUpdateAssistReward

	if not notRepeatUpdateAssistReward then
		local updateFrequency = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency)

		TaskDispatcher.cancelTask(self.updateAssistReward, self)
		TaskDispatcher.runRepeat(self.updateAssistReward, self, updateFrequency)
	end
end

function ShowCharacterView:updateAssistReward()
	local isFriendUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)

	gohelper.setActive(self._goAssistReward, isFriendUnlock)
	PlayerController.instance:updateAssistRewardCount()
end

function ShowCharacterView:onClose()
	self:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, self._updateHeroList, self)
	TaskDispatcher.cancelTask(self.updateAssistReward, self)
end

function ShowCharacterView:_onQuitAdventure()
	self:closeThis()
end

function ShowCharacterView:onDestroyView()
	self._simagebgimg:UnLoadImage()

	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

return ShowCharacterView
