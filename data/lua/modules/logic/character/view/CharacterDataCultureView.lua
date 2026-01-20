-- chunkname: @modules/logic/character/view/CharacterDataCultureView.lua

module("modules.logic.character.view.CharacterDataCultureView", package.seeall)

local CharacterDataCultureView = class("CharacterDataCultureView", BaseView)

function CharacterDataCultureView:_getFormatStr_overseas(content)
	if string.nilorempty(content) then
		return "", ""
	end

	local isShowFirst = LangSettings.instance:isZh() or LangSettings.instance:isTw()

	GameUtil.setActive01(self._gofirstTran, isShowFirst)

	if isShowFirst then
		return self:_getFormatStr(content)
	else
		local tab1, tab2 = self:SwitchLangTab()
		local tab = string.rep(" ", tab1)
		local tabOffset = "\n" .. tab

		content = tab .. string.gsub(content, "\n", tabOffset)

		return "", content
	end
end

function CharacterDataCultureView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg")
	self._simagecentericon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_centericon")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_mask")
	self._gocontent = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_content")
	self._goconversation = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_conversation")
	self._gofirst = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_first")
	self._txtfirst = gohelper.findChildText(self.viewGO, "content/scrollview/viewport/content/#go_first/bg/#txt_first")
	self._txtindenthelper = gohelper.findChildText(self.viewGO, "content/scrollview/viewport/content/#txt_indenthelper")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "content/scrollview")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "content/#txt_title1")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "content/#txt_title2")
	self._txttitleen1 = gohelper.findChildText(self.viewGO, "content/#txt_titleen1")
	self._txttitleen3 = gohelper.findChildText(self.viewGO, "content/#txt_titleen3")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "content/#simage_pic")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "content/pageicon/#btn_next")
	self._btnprevious = gohelper.findChildButtonWithAudio(self.viewGO, "content/pageicon/#btn_previous")
	self._gomask = gohelper.findChild(self.viewGO, "content/#go_mask")
	self._goCustomRedIcon = gohelper.findChild(self.viewGO, "content/scrollview/viewport/content/#go_customredicon")
	self._txtCustomContent = gohelper.findChildText(self.viewGO, "content/scrollview/viewport/content/#txt_customcontent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataCultureView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
	self._btnprevious:AddClickListener(self._btnpreviousOnClick, self)
	self._scrollview:AddOnValueChanged(self._onContentScrollValueChanged, self)
end

function CharacterDataCultureView:removeEvents()
	self._btnnext:RemoveClickListener()
	self._btnprevious:RemoveClickListener()
	self._scrollview:RemoveOnValueChanged()
end

function CharacterDataCultureView:_btnnextOnClick()
	if self._selectIndex and self._selectIndex ~= 0 then
		self:_itemOnClick(math.max(1, math.min(3, self._selectIndex + 1)))
	end
end

function CharacterDataCultureView:_btnpreviousOnClick()
	if self._selectIndex and self._selectIndex ~= 0 then
		self:_itemOnClick(math.max(1, math.min(3, self._selectIndex - 1)))
	end
end

function CharacterDataCultureView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	self._scrollcontent = gohelper.findChild(self._scrollview.gameObject, "viewport/content")
	self._items = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "content/container/go_item" .. i)
		item.index = i
		item.gochapteron = gohelper.findChild(item.go, "go_chapteron")
		item.gochapteroff = gohelper.findChild(item.go, "go_chapteroff")
		item.gotreasurebox = gohelper.findChild(item.go, "go_treasurebox")
		item.gochapterunlock = gohelper.findChild(item.go, "go_chapterunlock")
		item.txtunlockconditine = gohelper.findChildText(item.go, "go_chapterunlock/txt_unlockconditine")
		item.btn = SLFramework.UGUI.UIClickListener.Get(item.go)

		item.btn:AddClickListener(self._itemOnClick, self, item.index)
		table.insert(self._items, item)
	end

	self._txtcontent = self._gocontent:GetComponent(typeof(ZProj.CustomTMP))

	self._txtcontent:SetOffset(0, -13, false, true)
	self._txtcontent:SetSize(5)
	self._txtcontent:SetAlignment(0, -2)

	self._txtconversation = self._goconversation:GetComponent(typeof(ZProj.CustomTMP))

	self._txtconversation:SetOffset(0, -13, false, true)
	self._txtconversation:SetSize(5)
	self._txtconversation:SetAlignment(0, -2)

	self._scrollHeight = recthelper.getHeight(self._scrollview.transform)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItemFail, self._unlockItemCallbackFail, self)

	self._gofirstTran = self._gofirst.transform
	self._gofirstPosX, self._gofirstPosY = recthelper.getAnchor(self._gofirstTran)

	CharacterController.instance:registerCallback(CharacterEvent.HeroDataAddUnlockItem, self._unlockItemCallback, self)
end

function CharacterDataCultureView:_itemOnClick(index)
	if self._selectIndex == index then
		return
	end

	local config = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, index)

	if self._items[index]._lock then
		local unlockitems = string.splitToNumber(config.unlockConditine, "#")
		local tag = ""

		if unlockitems[1] == CharacterDataConfig.unlockConditionEpisodeID then
			tag = DungeonConfig.instance:getEpisodeCO(unlockitems[2]).name
		elseif unlockitems[1] == CharacterDataConfig.unlockConditionRankID then
			tag = {
				unlockitems[2] - 1
			}
		else
			tag = unlockitems[2]
		end

		GameFacade.showToast(config.lockText, tag)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Ui_Role_Story_Switch)
		self:_refreshSelect(index)
		self:_refreshDesc(index)

		self._selectIndex = index
	end
end

function CharacterDataCultureView:onUpdateParam()
	self:_refreshUI()
end

function CharacterDataCultureView:onOpen()
	gohelper.setActive(self.viewGO, true)
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function CharacterDataCultureView:_unlockItemCallback(heroId, itemId)
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if itemId >= 5 then
		self:_refreshSelect(self._selectIndex)
	end
end

function CharacterDataCultureView:_unlockItemCallbackFail()
	UIBlockMgr.instance:endBlock("playRewardsAnimtion")
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function CharacterDataCultureView:_refreshUI()
	if self._heroId and self._heroId == CharacterDataModel.instance:getCurHeroId() then
		self:_statEnd()
		self:_statStart()

		return
	end

	self._heroId = CharacterDataModel.instance:getCurHeroId()
	self.heroMo = HeroModel.instance:getByHeroId(self._heroId)

	self:_initInfo()
end

function CharacterDataCultureView:_initInfo()
	self._selectIndex = 0

	for i = 1, 3 do
		local config = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, i)
		local lock = CharacterDataConfig.instance:checkLockCondition(config)

		gohelper.setActive(self._items[i].golock, lock)

		self._items[i]._lock = lock

		if lock then
			local unlockitems = string.splitToNumber(config.unlockConditine, "#")
			local tag = {}

			if unlockitems[1] == CharacterDataConfig.unlockConditionEpisodeID then
				tag = {
					DungeonConfig.instance:getEpisodeCO(unlockitems[2]).name
				}
			elseif unlockitems[1] == CharacterDataConfig.unlockConditionRankID then
				tag = {
					unlockitems[2] - 1
				}
			else
				tag = {
					unlockitems[2]
				}
			end

			local tip = ToastConfig.instance:getToastCO(config.lockText).tips

			tip = GameUtil.getSubPlaceholderLuaLang(tip, tag)
			self._items[i].txtunlockconditine.text = tip
		elseif self._selectIndex == 0 then
			self._selectIndex = i
		end
	end

	gohelper.setActive(self._btnnext.gameObject, self._selectIndex and self._selectIndex ~= 3)
	gohelper.setActive(self._btnprevious.gameObject, self._selectIndex and self._selectIndex ~= 1)
	self:_refreshSelect(self._selectIndex)
	self:_refreshDesc(self._selectIndex)
end

function CharacterDataCultureView:_refreshDesc(index)
	self:_statEnd()
	self:_statStart()

	if index == 0 then
		gohelper.setActive(self._scrollview.gameObject, false)
		gohelper.setActive(self._txttitle1.gameObject, false)
		gohelper.setActive(self._txttitle2.gameObject, false)
		gohelper.setActive(self._txttitleen1.gameObject, false)
		gohelper.setActive(self._txttitleen3.gameObject, false)
		gohelper.setActive(self._txttitleen4.gameObject, false)
		gohelper.setActive(self._simagepic.gameObject, false)

		return
	end

	if self._items[index]._lock then
		return
	end

	self._config = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, self.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, index)

	local titles = self._config.title
	local titleList = not string.nilorempty(titles) and string.split(titles, "\n") or {}

	self._txttitle1.text = titleList[1] or ""
	self._txttitle2.text = titleList[2] or ""

	gohelper.setActive(self._txttitleen1.gameObject, index ~= 3 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.CN)
	gohelper.setActive(self._txttitleen3.gameObject, index == 3)

	if index == 3 then
		local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)

		self._txttitleen3.text = "[UTTU" .. luaLang("multiple") .. tostring(heroConfig.name) .. "]"
	else
		self._txttitleen1.text = self._config.titleEn
	end

	local title1Pos = titleList[2] and {
		-282.6,
		-134.5
	} or {
		-320,
		-151.3
	}

	recthelper.setAnchor(self._txttitle1.transform, title1Pos[1], title1Pos[2])
	recthelper.setAnchorY(self._txttitleen1.transform, titleList[2] and -216.5 or -181.5)
	gohelper.setActive(self._gocontent, index ~= 3 and self._config.isCustom ~= 1)
	gohelper.setActive(self._gofirst, index ~= 3 and self._config.isCustom ~= 1)
	gohelper.setActive(self._txtCustomContent.gameObject, self._config.isCustom == 1)
	gohelper.setActive(self._goconversation, index == 3 and self._config.isCustom ~= 1)
	gohelper.setActive(self._goCustomRedIcon, false)

	local content = self._config.text

	if index == 3 then
		local afterContent = self:_getAfterContent(content)
		local markText = GameUtil.getMarkText(afterContent)
		local markIndexList = GameUtil.getMarkIndexList(afterContent)

		self._txtconversation:SetText(markText, markIndexList)
	elseif self._config.isCustom == 1 then
		self._txtCustomContent.text = content

		TaskDispatcher.runDelay(self._setCustomRedIconPos, self, 0.01)
	else
		local first, remain = self:_getFormatStr_overseas(content)
		local markText = GameUtil.getMarkText(remain)
		local markIndexList = GameUtil.getMarkIndexList(remain)
		local firstOffset = self:_getFirstOffsetByLang()

		recthelper.setAnchor(self._gofirstTran, self._gofirstPosX + firstOffset.x, self._gofirstPosY + firstOffset.y)

		self._txtfirst.text = first

		self._txtfirst:ForceMeshUpdate(true, true)
		self._txtfirst:GetRenderedValues()
		self._txtcontent:SetText(markText, markIndexList)
	end

	self._scrollview.verticalNormalizedPosition = 1

	if index == 1 then
		self._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu1.png"))
	elseif index == 2 then
		self._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu2.png"))
	else
		self._simagepic:LoadImage(ResUrl.getCharacterDataIcon("tu3.png"))
	end

	gohelper.setActive(self._scrollview.gameObject, true)
	gohelper.setActive(self._txttitle1.gameObject, true)
	gohelper.setActive(self._txttitle2.gameObject, true)
	gohelper.setActive(self._simagepic.gameObject, true)
	ZProj.UGUIHelper.RebuildLayout(self._scrollcontent.transform)

	local contentHeight = recthelper.getHeight(self._scrollcontent.transform)

	self._couldScroll = contentHeight > self._scrollHeight and true or false

	gohelper.setActive(self._gomask, self._couldScroll)
end

function CharacterDataCultureView:_setCustomRedIconPos()
	gohelper.setActive(self._goCustomRedIcon, true)

	local tempTextInfo = self._txtCustomContent:GetTextInfo(self._config.text)
	local characterInfoList = tempTextInfo.characterInfo
	local firstLineInfo = tempTextInfo.lineInfo[0]
	local markWord = characterInfoList[firstLineInfo.firstVisibleCharacterIndex]
	local bl = markWord.bottomLeft
	local tl = markWord.topLeft
	local br = markWord.bottomRight
	local tr = markWord.topRight
	local centerX = (bl.x + br.x) * 0.5
	local centerY = (bl.y + tl.y) * 0.5
	local redIconWorldSpace = self._txtCustomContent.transform:TransformPoint(centerX, centerY, 0)

	self._goCustomRedIcon.transform.position = redIconWorldSpace
end

function CharacterDataCultureView:_refreshSelect(index)
	for i = 1, 3 do
		gohelper.setActive(self._items[i].gochapteron, false)
		gohelper.setActive(self._items[i].gochapteroff, false)
		gohelper.setActive(self._items[i].gotreasurebox, false)
		gohelper.setActive(self._items[i].gochapterunlock, false)

		local config = CharacterDataConfig.instance:getCharacterDataCO(self._heroId, self.heroMo.skin, CharacterEnum.CharacterDataItemType.Culture, i)
		local nextnum = i == 3 and 4 + i or 5 + i
		local selected = i == index
		local lock = CharacterDataConfig.instance:checkLockCondition(config)
		local nextIsGetRewards = HeroModel.instance:checkGetRewards(self._heroId, nextnum)
		local isGetRewards = HeroModel.instance:checkGetRewards(self._heroId, 4 + i)

		if selected then
			gohelper.setActive(self._items[i].gochapteron, true)
			gohelper.setActive(self._btnnext.gameObject, index ~= 3 and nextIsGetRewards)
			gohelper.setActive(self._btnprevious.gameObject, index ~= 1)

			if not isGetRewards and not string.nilorempty(config.unlockRewards) then
				if lock then
					local unlockitems = string.splitToNumber(config.unlockConditine, "#")
					local tag = ""

					if unlockitems[1] == CharacterDataConfig.unlockConditionEpisodeID then
						tag = DungeonConfig.instance:getEpisodeCO(unlockitems[2]).name
					elseif unlockitems[1] == CharacterDataConfig.unlockConditionRankID then
						tag = unlockitems[2] - 1
					else
						tag = unlockitems[2]
					end

					GameFacade.showToast(config.lockText, tag)
				elseif not isGetRewards then
					UIBlockMgr.instance:startBlock("playRewardsAnimtion")
					UIBlockMgrExtend.setNeedCircleMv(false)
					HeroRpc.instance:sendItemUnlockRequest(self._heroId, config.id)
				end
			end
		elseif lock then
			gohelper.setActive(self._items[i].gochapterunlock, true)
		elseif isGetRewards or string.nilorempty(config.unlockRewards) then
			gohelper.setActive(self._items[i].gochapteroff, true)
		else
			gohelper.setActive(self._items[i].gotreasurebox, true)
		end
	end
end

function CharacterDataCultureView:onClose()
	gohelper.setActive(self.viewGO, false)
	self:_statEnd()
end

function CharacterDataCultureView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagecentericon:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()

	for i = 1, 3 do
		self._items[i].btn:RemoveClickListener()
	end

	self._simagepic:UnLoadImage()
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItemFail, self._unlockItemCallbackFail, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroDataAddUnlockItem, self._unlockItemCallback, self)
	TaskDispatcher.cancelTask(self._setCustomRedIconPos, self)
end

function CharacterDataCultureView:_getFormatStr(content)
	if string.nilorempty(content) then
		return "", ""
	end

	local tab1, tab2 = self.SwitchLangTab()
	local tabOffset = "\n" .. string.rep(" ", tab1)
	local newContent = content

	newContent = string.gsub(newContent, "<.->", "")
	newContent = string.trim(newContent)

	local firstEndIndex = utf8.next(newContent, 1)
	local first = newContent:sub(1, firstEndIndex - 1)
	local remain = string.gsub(content, first, "", 1)

	return first, string.format("<size=28><space=%fem></size> %s", tab2, remain)
end

function CharacterDataCultureView:SwitchLangTab()
	local tab1, tab2
	local langOffset = {
		cn = function()
			tab1 = 6
			tab2 = 2.75
		end,
		en = function()
			tab1 = 6
			tab2 = 1.83
		end,
		jp = function()
			tab1 = 4
			tab2 = 1.63
		end,
		kr = function()
			tab1 = 3
			tab2 = 1.63
		end
	}
	local lang = langOffset[LangSettings.instance:getCurLangShortcut()]

	if lang then
		lang()

		return tab1, tab2
	else
		return 6, 2.75
	end
end

function CharacterDataCultureView:_getFirstOffsetByLang()
	local kFirstOffset = {
		kr = {
			x = -31,
			y = 0
		}
	}
	local offset = kFirstOffset[LangSettings.instance:getCurLangShortcut()]

	return offset or {
		x = 0,
		y = 0
	}
end

function CharacterDataCultureView:_getAfterContent(content)
	content = string.gsub(content, "：", ":")

	local nameList = {}
	local nameSplit

	for _, line in ipairs(string.split(content, "\n")) do
		nameSplit = string.split(line, ":")

		if nameSplit and #nameSplit >= 2 and not tabletool.indexOf(nameList, nameSplit[1]) then
			local roleName = nameSplit[1]

			roleName = string.gsub(roleName, "%-", "%%-")

			table.insert(nameList, roleName)
		end
	end

	local nameIndent = 0
	local indent

	for _, name in ipairs(nameList) do
		local ignoreRichColorName = string.gsub(name, "<[^<>][^<>]->", "")

		indent = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtindenthelper, ignoreRichColorName)

		if nameIndent < indent then
			nameIndent = indent
		end
	end

	local heroConfig = HeroConfig.instance:getHeroCO(self._heroId)
	local heroNameIndent = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtindenthelper, heroConfig.name)
	local tempOffest = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and 3.5 or 5

	indent = math.max(nameIndent, heroNameIndent) / 28 * tempOffest + 3

	local patternList = {}
	local replList = {}
	local charSpacing = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP and -7 or 0
	local heroName = heroConfig.name

	heroName = string.gsub(heroName, "%-", "%%-")

	table.insert(patternList, heroName .. ":")
	table.insert(replList, string.format("<indent=0%%%%><color=#943308><b><cspace=%d>%s</cspace></b></color>：</indent><indent=%d%%%%>", charSpacing, heroConfig.name, indent))

	for i, name in ipairs(nameList) do
		table.insert(patternList, name .. ":")
		table.insert(replList, string.format("<indent=0%%%%><color=#352725><b><cspace=%d>%s</cspace></b></color>:</indent><indent=%d%%%%>", charSpacing, name, indent))
	end

	for i = 1, #patternList do
		content = string.gsub(content, patternList[i], replList[i])
	end

	if GameConfig:GetCurLangType() == LangSettings.jp then
		content = string.gsub(content, ":", "")
		content = string.gsub(content, "：", "")
	elseif GameConfig:GetCurLangType() == LangSettings.en then
		content = string.gsub(content, "：", ":")
	end

	return content
end

function CharacterDataCultureView:_statStart()
	self._viewTime = ServerTime.now()
end

function CharacterDataCultureView:_statEnd()
	if not self._heroId then
		return
	end

	if self._viewTime then
		local duration = ServerTime.now() - self._viewTime
		local isHandbook = self.viewParam and type(self.viewParam) == "table" and self.viewParam.fromHandbookView

		CharacterController.instance:statCharacterData(StatEnum.EventName.ReadHeroCulture, self._heroId, self._config and self._config.id, duration, isHandbook)
	end

	self._viewTime = nil
end

function CharacterDataCultureView:_onContentScrollValueChanged(value)
	gohelper.setActive(self._gomask, self._couldScroll and not (gohelper.getRemindFourNumberFloat(self._scrollview.verticalNormalizedPosition) <= 0))
end

return CharacterDataCultureView
