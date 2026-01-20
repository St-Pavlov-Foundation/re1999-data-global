-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultFinalView.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultFinalView", package.seeall)

local Rouge2_ResultFinalView = class("Rouge2_ResultFinalView", BaseView)

function Rouge2_ResultFinalView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._godifficulty = gohelper.findChild(self.viewGO, "Title/#go_difficulty")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "Title/image_title/#txt_difficulty")
	self._txtend = gohelper.findChildText(self.viewGO, "Title/#txt_end")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocareer = gohelper.findChild(self.viewGO, "Left/#go_career")
	self._gomainCareer = gohelper.findChild(self.viewGO, "Left/#go_career/#go_mainCareer")
	self._gosubCareer = gohelper.findChild(self.viewGO, "Left/#go_career/#go_subCareer")
	self._gobase = gohelper.findChild(self.viewGO, "Left/#go_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "Left/#go_base/#go_baseitem")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "Left/#go_base/#go_baseitem/#image_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "Left/#go_base/#go_baseitem/#txt_Name")
	self._txtValue = gohelper.findChildText(self.viewGO, "Left/#go_base/#go_baseitem/#txt_Value")
	self._scrollherogroup = gohelper.findChildScrollRect(self.viewGO, "Left/#scroll_herogroup")
	self._godrag = gohelper.findChild(self.viewGO, "Left/#go_drag")
	self._simagedrag = gohelper.findChildSingleImage(self.viewGO, "Left/#go_drag/has/#image_drag")
	self._gocollection = gohelper.findChild(self.viewGO, "Left/#go_collection")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "Left/#go_collection/#txt_collectionnum")
	self._gocoin = gohelper.findChild(self.viewGO, "Left/#go_coin")
	self._txtcoinnum = gohelper.findChildText(self.viewGO, "Left/#go_coin/#txt_coinnum")
	self._goplayinfo = gohelper.findChild(self.viewGO, "Left/#go_playinfo")
	self._txtplayername = gohelper.findChildText(self.viewGO, "Left/#go_playinfo/#txt_playername")
	self._txttime = gohelper.findChildText(self.viewGO, "Left/#go_playinfo/#txt_time")
	self._simageplayericon = gohelper.findChildSingleImage(self.viewGO, "Left/#go_playinfo/#simage_playericon")
	self._scrollcollection = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "Right/#scroll_collection/Viewport/Content/#go_collectionitem")
	self._imagebg = gohelper.findChildImage(self.viewGO, "Right/#scroll_collection/Viewport/Content/#go_collectionitem/has/#image_bg")
	self._imagecollection = gohelper.findChildImage(self.viewGO, "Right/#scroll_collection/Viewport/Content/#go_collectionitem/has/#image_collection")
	self._gohide = gohelper.findChild(self.viewGO, "#go_hide")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "#go_hide/#btn_hide")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultFinalView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnShow:AddClickListener(self._btnShowOnClick, self)
end

function Rouge2_ResultFinalView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnShow:RemoveClickListener()
end

function Rouge2_ResultFinalView:_btncloseOnClick()
	self:closeThis()
end

function Rouge2_ResultFinalView:_btnhideOnClick()
	self:setBtnActive(false)
end

function Rouge2_ResultFinalView:_btnShowOnClick()
	self:setBtnActive(true)
end

function Rouge2_ResultFinalView:checkNewUnlock()
	local isOpen = Rouge2_OutsideController.instance:checkNewPass()

	if not isOpen then
		Rouge2_OutsideController.instance:checkNewUnlock()
	end
end

function Rouge2_ResultFinalView:setBtnActive(active)
	gohelper.setActive(self._btnhide, active)
	gohelper.setActive(self._gotopleft, active and self.type == Rouge2_OutsideEnum.ResultFinalDisplayType.Review)
	gohelper.setActive(self._btnShow, not active)
end

function Rouge2_ResultFinalView:_editableInitView()
	self._mainCareerItem = self:_createCareerItem(self._gomainCareer)
	self._curCareerItem = self:_createCareerItem(self._gosubCareer)
	self._attributeItemList = {}

	gohelper.setActive(self._gobaseitem, false)

	self._heroItemList = {}
	self._goHeroItem = gohelper.findChild(self.viewGO, "Left/#scroll_herogroup/Viewport/Content/go_heroitem")

	gohelper.setActive(self._goHeroItem, false)

	self._goDragHas = gohelper.findChild(self._godrag, "has")
	self._goDragEmpty = gohelper.findChild(self._godrag, "empty")
	self._difficultyBgList = self:getUserDataTb_()

	local parentGo = self._godifficulty.transform
	local childCount = parentGo.childCount

	for i = 1, childCount do
		local childGo = parentGo:GetChild(i - 1).gameObject

		table.insert(self._difficultyBgList, childGo)
	end

	self._goCollectionEmpty = gohelper.findChild(self.viewGO, "Right/empty")
	self._btnShow = gohelper.findChildButton(self.viewGO, "#btn_show")
	self.showCanvas = gohelper.findChildComponent(self._gohide, "", gohelper.Type_CanvasGroup)

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function Rouge2_ResultFinalView:_onShowClick()
	self:setBtnActive(true)
end

function Rouge2_ResultFinalView:onUpdateParam()
	return
end

function Rouge2_ResultFinalView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.play_ui_dungeon3_2_over)

	local reviewInfo = self.viewParam and self.viewParam.reviewInfo
	local type = self.viewParam and self.viewParam.displayType or Rouge2_OutsideEnum.ResultFinalDisplayType.Review

	self.type = type

	self:refreshUI(reviewInfo)
	self:setBtnActive(true)
end

function Rouge2_ResultFinalView:refreshUI(reviewInfo)
	if not reviewInfo then
		logError("没有结算数据")

		return
	end

	local isSucc = reviewInfo:isSucceed()

	gohelper.setActive(self._gosuccess, isSucc)
	gohelper.setActive(self._gofail, not isSucc)

	self._txtend.text = Rouge2_ResultFinalView.refreshEndingDesc(reviewInfo)

	self:refreshBaseInfo(reviewInfo)
	self:refreshCareerInfo(reviewInfo)
	self:refreshAttributeInfo(reviewInfo)
	self:refreshHeroInfo(reviewInfo)
	self:refreshDrag(reviewInfo)
	self:refreshPlayerInfo(reviewInfo)
	self:refreshCollectionInfo(reviewInfo)
end

function Rouge2_ResultFinalView.refreshEndingDesc(reviewInfo)
	local isSucc = reviewInfo:isSucceed()
	local desc = ""

	if isSucc then
		local endingId = reviewInfo.endId
		local endingCfg = Rouge2_Config.instance:getEndingCO(endingId)

		desc = endingCfg and endingCfg.desc
	else
		local layerId = reviewInfo.layerId
		local middleLayerId = reviewInfo.middleLayerId
		local isInMiddleLayer = reviewInfo:isInMiddleLayer()
		local finalStepLayerName = ""

		if isInMiddleLayer then
			local middleLayerCfg = lua_rouge2_middle_layer.configDict[middleLayerId]
			local middleLayerName = middleLayerCfg and middleLayerCfg.name

			finalStepLayerName = middleLayerName
		else
			local layerCfg = lua_rouge2_layer.configDict[layerId]
			local layerName = layerCfg and layerCfg.name

			finalStepLayerName = layerName
		end

		desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("p_rougeresultreportview_txt_dec5"), finalStepLayerName)
	end

	return desc
end

function Rouge2_ResultFinalView:refreshBaseInfo(reviewInfo)
	local collectionCount = reviewInfo.collectionNum

	self._txtcollectionnum.text = tostring(collectionCount)

	local coin = reviewInfo.gainCoin

	self._txtcoinnum.text = tostring(coin)

	local difficulty = reviewInfo.difficulty
	local difficultyConfig = Rouge2_Config.instance:getDifficultyCoById(difficulty)

	self._txtdifficulty.text = difficultyConfig.title

	local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexDuration)
	local duration = tonumber(constConfig.value)
	local bgIndex = math.floor(difficultyConfig.difficulty / duration) + 1 or 1

	for index, bg in ipairs(self._difficultyBgList) do
		gohelper.setActive(bg, index == bgIndex)
	end
end

function Rouge2_ResultFinalView:refreshPlayerInfo(reviewInfo)
	local playerName = reviewInfo.playerName

	self._txtplayername.text = playerName

	local finishTime = reviewInfo.finishTime / 1000

	self._txttime.text = TimeUtil.localTime2ServerTimeString(finishTime, "%Y.%m.%d %H:%M")

	if not self._liveHeadIcon then
		local commonLiveIcon = IconMgr.instance:getCommonLiveHeadIcon(self._simageplayericon)

		self._liveHeadIcon = commonLiveIcon
	end

	self._liveHeadIcon:setLiveHead(reviewInfo.portrait)
end

function Rouge2_ResultFinalView:refreshCareerInfo(reviewInfo)
	local isChangeCareer = reviewInfo.curCareer ~= reviewInfo.mainCareer

	gohelper.setActive(self._curCareerItem.go, isChangeCareer)
	self:setSingleCareerInfo(self._mainCareerItem, reviewInfo.mainCareer)

	if isChangeCareer then
		self:setSingleCareerInfo(self._curCareerItem, reviewInfo.curCareer)
	end
end

function Rouge2_ResultFinalView:setSingleCareerInfo(careerInfoItem, careerId)
	local careerConfig = lua_rouge2_career.configDict[careerId]

	careerInfoItem.txtName.text = careerConfig.name

	Rouge2_IconHelper.setResultCareerIcon(careerId, careerInfoItem.imageIcon)
end

function Rouge2_ResultFinalView:_createCareerItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.imageIcon = gohelper.findChildImage(go, "main/#image_careerIcon")
	item.txtName = gohelper.findChildTextMesh(go, "main/image_NameBG/#txt_TypeName")

	return item
end

function Rouge2_ResultFinalView:refreshAttributeInfo(reviewInfo)
	local attributeInfo = reviewInfo.leaderAttrInfo
	local infoCount = #attributeInfo

	for i = 1, infoCount do
		local info = attributeInfo[i]
		local item = self:_getAttributeItem(i)

		self:setAttributeInfo(item, info)
		gohelper.setActive(item.go, true)
	end

	local itemCount = #self._attributeItemList

	if infoCount < itemCount then
		for i = infoCount + 1, itemCount do
			local info = attributeInfo[i]
			local item = self:_getAttributeItem(i)

			gohelper.setActive(item.go, false)
		end
	end
end

function Rouge2_ResultFinalView:_getAttributeItem(index)
	local item

	if not self._attributeItemList[index] then
		item = self:_createAttributeItem()

		table.insert(self._attributeItemList, item)
	else
		item = self._attributeItemList[index]
	end

	return item
end

function Rouge2_ResultFinalView:setAttributeInfo(item, info)
	Rouge2_IconHelper.setAttributeIcon(info.id, item.imageIcon)

	item.txtNum.text = tostring(info.value)

	local attributeConfig = Rouge2_AttributeConfig.instance:getAttributeConfig(info.id)

	item.txtName.text = attributeConfig.name
end

function Rouge2_ResultFinalView:_createAttributeItem()
	local go = gohelper.cloneInPlace(self._gobaseitem)
	local item = self:getUserDataTb_()

	item.go = go
	item.txtNum = gohelper.findChildTextMesh(go, "#txt_Value")
	item.txtName = gohelper.findChildTextMesh(go, "#txt_Name")
	item.imageIcon = gohelper.findChildImage(go, "#image_Icon")

	return item
end

Rouge2_ResultFinalView.MaxShowHeroCount = 4

function Rouge2_ResultFinalView:refreshHeroInfo(reviewInfo)
	local heroInfoList = reviewInfo.endHeroId

	for i = 1, Rouge2_ResultFinalView.MaxShowHeroCount do
		local info = heroInfoList[i]
		local item = self:_getHeroItem(i)

		self:setHeroInfo(item, info)
		gohelper.setActive(item.go, true)
	end
end

function Rouge2_ResultFinalView:_getHeroItem(index)
	local item

	if not self._heroItemList[index] then
		item = self:_createHeroItem()

		table.insert(self._heroItemList, item)
	else
		item = self._heroItemList[index]
	end

	return item
end

function Rouge2_ResultFinalView:setHeroInfo(item, heroId)
	local showHero = heroId ~= nil

	gohelper.setActive(item.simagerolehead, showHero)
	gohelper.setActive(item.frame, showHero)
	gohelper.setActive(item.empty, not showHero)

	if showHero then
		local skinCfg
		local heroMO = HeroModel.instance:getByHeroId(heroId)

		if heroMO then
			skinCfg = HeroModel.instance:getCurrentSkinConfig(heroId)
		else
			local heroCfg = HeroConfig.instance:getHeroCO(heroId)
			local skinId = heroCfg and heroCfg.skinId

			skinCfg = SkinConfig.instance:getSkinCo(skinId)
		end

		local heroIcon = skinCfg and skinCfg.headIcon

		item.simagerolehead:LoadImage(ResUrl.getHeadIconSmall(heroIcon))
	end
end

function Rouge2_ResultFinalView:_createHeroItem()
	local url = self.viewContainer._viewSetting.otherRes[1]
	local go = self:getResInst(url, self._goHeroItem.transform.parent.gameObject)
	local item = self:getUserDataTb_()

	item.go = go
	item.simagerolehead = gohelper.findChildSingleImage(go, "#go_heroitem/#image_rolehead")
	item.frame = gohelper.findChild(go, "#go_heroitem/frame")
	item.empty = gohelper.findChild(go, "#go_heroitem/empty")

	return item
end

function Rouge2_ResultFinalView:refreshCollectionInfo(reviewInfo)
	local haveCollection = reviewInfo.collectionBag and reviewInfo.collectionBag.items and #reviewInfo.collectionBag.items > 0

	gohelper.setActive(self._goCollectionEmpty, not haveCollection)
	Rouge2_ResultCollectionListModel.instance:initList(reviewInfo.collectionBag)
end

function Rouge2_ResultFinalView:refreshDrag(reviewInfo)
	local useDrag = reviewInfo.drugId ~= nil and reviewInfo.drugId ~= 0

	gohelper.setActive(self._goDragHas, useDrag)
	gohelper.setActive(self._goDragEmpty, not useDrag)

	if useDrag then
		Rouge2_IconHelper.setFormulaIcon(reviewInfo.drugId, self._simagedrag)
	end
end

function Rouge2_ResultFinalView:onClose()
	if self.type == Rouge2_OutsideEnum.ResultFinalDisplayType.Result then
		self:checkNewUnlock()
	end
end

function Rouge2_ResultFinalView:onDestroyView()
	return
end

return Rouge2_ResultFinalView
