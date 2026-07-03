-- chunkname: @modules/logic/rouge2/record/view/Rouge2_FightRecordItem.lua

module("modules.logic.rouge2.record.view.Rouge2_FightRecordItem", package.seeall)

local Rouge2_FightRecordItem = class("Rouge2_FightRecordItem", ListScrollCellExtend)

function Rouge2_FightRecordItem:onInitView()
	self._gohas = gohelper.findChild(self.viewGO, "#go_has")
	self._gotime = gohelper.findChild(self.viewGO, "#go_has/#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_has/#go_time/#txt_time")
	self._godifficulty = gohelper.findChild(self.viewGO, "#go_has/#go_difficulty")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "#go_has/#go_difficulty/#txt_difficulty")
	self._gofaction = gohelper.findChild(self.viewGO, "#go_has/#go_faction")
	self._gosuccessbg = gohelper.findChild(self.viewGO, "#go_has/#go_faction/image_NameBG/#go_successbg")
	self._gofailbg = gohelper.findChild(self.viewGO, "#go_has/#go_faction/image_NameBG/#go_failbg")
	self._txtTypeName = gohelper.findChildText(self.viewGO, "#go_has/#go_faction/image_NameBG/#txt_TypeName")
	self._gobaseitem = gohelper.findChild(self.viewGO, "#go_has/#go_faction/base/#go_baseitem")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#go_has/#go_faction/base/#go_baseitem/#image_Icon")
	self._txtValue = gohelper.findChildText(self.viewGO, "#go_has/#go_faction/base/#go_baseitem/#txt_Value")
	self._goherogroup = gohelper.findChild(self.viewGO, "#go_has/#go_herogroup")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_has/#go_herogroup/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_has/#go_herogroup/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_has/#go_herogroup/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_has/#go_herogroup/#go_item4")
	self._godec = gohelper.findChild(self.viewGO, "#go_has/#go_dec")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_has/#go_dec/#txt_dec")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/#btn_details")
	self._btnreplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_has/#btn_replace")
	self._scrollskill = gohelper.findChild(self.viewGO, "#go_has/#scroll_skill")
	self._goskillcontent = gohelper.findChild(self.viewGO, "#go_has/#scroll_skill/Viewport/Content")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_has/#scroll_skill/Viewport/Content/#go_skillitem")
	self._goemptyskill = gohelper.findChild(self.viewGO, "#go_has/#go_emptyskill")
	self._goempty = gohelper.findChild(self.viewGO, "#go_empty")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_empty/#btn_add")
	self._goDetail = gohelper.findChild(self.viewGO, "#go_Detail")
	self._detailComp = Rouge2_FightRecordDetailItem.Get(self._goDetail)

	self._detailComp:show(false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_FightRecordItem:addEvents()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnreplace:AddClickListener(self._btnreplaceOnClick, self)
end

function Rouge2_FightRecordItem:removeEvents()
	self._btndetails:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnreplace:RemoveClickListener()
end

function Rouge2_FightRecordItem:_btndetailsOnClick()
	local isShow = self._detailComp:isShow()

	self._detailComp:show(not isShow)
end

function Rouge2_FightRecordItem:_btnaddOnClick()
	local viewType = Rouge2_FightRecordListModel.instance:getViewType()

	if viewType == Rouge2_Enum.RecordViewType.Show then
		return
	end

	Rouge2_FightRecordController.instance:replaceNewRecord(self._index)
end

function Rouge2_FightRecordItem:_btnreplaceOnClick()
	local viewType = Rouge2_FightRecordListModel.instance:getViewType()

	if viewType == Rouge2_Enum.RecordViewType.Show then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.Rouge2ReplaceRecord, MsgBoxEnum.BoxType.Yes_No, self._replaceRecord, nil, nil, self)
end

function Rouge2_FightRecordItem:_replaceRecord()
	Rouge2_FightRecordController.instance:replaceNewRecord(self._index)
end

function Rouge2_FightRecordItem:_editableInitView()
	self._difficultyBgList = self:getUserDataTb_()

	local parentGo = gohelper.findChild(self.viewGO, "#go_has/#go_difficulty/bg").transform
	local childCount = parentGo.childCount

	for i = 1, childCount do
		local childGo = parentGo:GetChild(i - 1).gameObject

		table.insert(self._difficultyBgList, childGo)
	end

	self._heroItemParentGoList = self:getUserDataTb_()

	local heroItemParent = self._goherogroup.transform
	local heroChildCount = heroItemParent.childCount

	for i = 1, heroChildCount do
		local childGo = heroItemParent:GetChild(i - 1).gameObject

		table.insert(self._heroItemParentGoList, childGo)
	end

	self._heroItemList = {}
	self._goAttributeContent = gohelper.findChild(self.viewGO, "#go_has/#go_faction/base")
	self._goFailBg2 = gohelper.findChild(self.viewGO, "bg/simage_fail")
	self._goSuccessBg2 = gohelper.findChild(self.viewGO, "bg/simage_success")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._simageSkillTab = self:getUserDataTb_()
end

function Rouge2_FightRecordItem:_editableAddEvents()
	return
end

function Rouge2_FightRecordItem:_editableRemoveEvents()
	return
end

function Rouge2_FightRecordItem:onUpdateMO(mo)
	self.mo = mo
	self.hasRecord = self.mo ~= nil

	self._detailComp:onUpdateMO(self.mo)
	self:refreshUI()
end

function Rouge2_FightRecordItem:refreshUI()
	gohelper.setActive(self._gohas, self.hasRecord)
	gohelper.setActive(self._goempty, not self.hasRecord)

	if not self.hasRecord then
		return
	end

	self:refreshBaseInfo()
	self:refreshAttributeInfo()
	self:refreshHeroInfo()
	self:refreshSkillInfo()
end

function Rouge2_FightRecordItem:getAnimator()
	return self._animator
end

Rouge2_FightRecordItem.MaxShowHeroCount = 4

function Rouge2_FightRecordItem:refreshHeroInfo()
	local heroInfoList = self.mo.endHeroId

	for i = 1, Rouge2_FightRecordItem.MaxShowHeroCount do
		local info = heroInfoList[i]
		local item = self:_getHeroItem(i)

		self:setHeroInfo(item, info)
		gohelper.setActive(item.go, true)
	end
end

function Rouge2_FightRecordItem:_getHeroItem(index)
	local item

	if not self._heroItemList[index] then
		item = self:_createHeroItem(index)

		table.insert(self._heroItemList, item)
	else
		item = self._heroItemList[index]
	end

	return item
end

function Rouge2_FightRecordItem:setHeroInfo(item, heroId)
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

function Rouge2_FightRecordItem:_createHeroItem(index)
	local url = self._view.viewContainer._viewSetting.otherRes[2]
	local parentGo = self._heroItemParentGoList[index]
	local go = self._view:getResInst(url, parentGo)
	local item = self:getUserDataTb_()

	item.go = go
	item.simagerolehead = gohelper.findChildSingleImage(go, "#go_heroitem/#image_rolehead")
	item.frame = gohelper.findChild(go, "#go_heroitem/frame")
	item.empty = gohelper.findChild(go, "#go_heroitem/empty")

	return item
end

function Rouge2_FightRecordItem:refreshSkillInfo()
	local skillList = {
		300004,
		300005
	}
	local hasSkill = skillList and #skillList > 0

	gohelper.setActive(self._goemptyskill, not hasSkill)
	gohelper.setActive(self._scrollskill.gameObject, hasSkill)
	gohelper.CreateObjList(self, self._refreshSkillItem, skillList, self._goskillcontent, self._goskillitem)
end

function Rouge2_FightRecordItem:_refreshSkillItem(obj, skillId, index)
	local simageskill = self._simageSkillTab[index]

	simageskill = simageskill or gohelper.findChildSingleImage(obj, "image_skillicon")

	Rouge2_IconHelper.setActiveSkillIcon(skillId, simageskill)
end

function Rouge2_FightRecordItem:refreshAttributeInfo()
	local attributeList = self.mo.leaderAttrInfo

	gohelper.CreateObjList(self, self.onAttributeShow, attributeList, self._goAttributeContent, self._gobaseitem, Rouge2_ResultAttributeItem)
end

function Rouge2_FightRecordItem:onAttributeShow(item, data, index)
	item:setInfo(data)
end

function Rouge2_FightRecordItem:refreshBaseInfo()
	local info = self.mo
	local secondTime = math.floor(info.finishTime / TimeUtil.OneSecondMilliSecond)
	local finishTime = ServerTime.timeInLocal(secondTime)

	self._txttime.text = TimeUtil.timestampToString(finishTime)

	local difficultyConfig = Rouge2_Config.instance:getDifficultyCoById(info.difficulty)
	local constConfig = Rouge2_Config.instance:getConstCoById(Rouge2_Enum.ConstId.DifficultyIndexDuration)
	local duration = tonumber(constConfig.value)
	local bgIndex = math.floor(difficultyConfig.difficulty / duration) + 1 or 1

	self._txtdifficulty.text = difficultyConfig.title

	for index, bg in ipairs(self._difficultyBgList) do
		gohelper.setActive(bg, index == bgIndex)
	end

	local desc = Rouge2_SettlementTriggerHelper.refreshEndingDesc(self.mo)
	local isSuccess = info:isSucceed()
	local colorStr = isSuccess and Rouge2_OutsideEnum.EndDescColor.Success or Rouge2_OutsideEnum.EndDescColor.Fail

	self._txtdec.text = string.format("<color=%s>%s</color>", colorStr, desc)

	gohelper.setActive(self._gosuccessbg, isSuccess)
	gohelper.setActive(self._gofailbg, not isSuccess)
	gohelper.setActive(self._goSuccessBg2, isSuccess)
	gohelper.setActive(self._goFailBg2, not isSuccess)

	local isMainCareer = info.curCareer == info.mainCareer

	if isMainCareer then
		local config = Rouge2_CareerConfig.instance:getCareerConfig(info.mainCareer)

		self._txtTypeName.text = config.name
	else
		local config = Rouge2_CareerConfig.instance:getCareerConfig(info.mainCareer)

		self._txtTypeName.text = config.name
	end

	local viewType = Rouge2_FightRecordListModel.instance:getViewType()

	gohelper.setActive(self._btnreplace.gameObject, self.hasRecord and viewType == Rouge2_Enum.RecordViewType.Edit)
end

function Rouge2_FightRecordItem:onSelect(isSelect)
	return
end

function Rouge2_FightRecordItem:onDestroyView()
	if self._simageSkillTab then
		for _, simageicon in pairs(self._simageSkillTab) do
			simageicon:UnLoadImage()
		end
	end
end

return Rouge2_FightRecordItem
