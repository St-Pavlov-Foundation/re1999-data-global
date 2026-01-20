-- chunkname: @modules/logic/fight/view/FightCardDeckView.lua

module("modules.logic.fight.view.FightCardDeckView", package.seeall)

local FightCardDeckView = class("FightCardDeckView", BaseViewExtended)

function FightCardDeckView:onInitView()
	self._click = gohelper.getClick(self.viewGO)
	self._btnCardBox = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_cardbox")
	self._cardBoxSelect = gohelper.findChild(self.viewGO, "topTab/#btn_cardbox/select")
	self._cardBoxUnselect = gohelper.findChild(self.viewGO, "topTab/#btn_cardbox/unselect")
	self._btnCardPre = gohelper.findChildClickWithDefaultAudio(self.viewGO, "topTab/#btn_cardpre")
	self._cardPreSelect = gohelper.findChild(self.viewGO, "topTab/#btn_cardpre/select")
	self._cardPreUnselect = gohelper.findChild(self.viewGO, "topTab/#btn_cardpre/unselect")
	self._cardRoot = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport/Content")
	self._cardItem = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport/Content/#go_carditem")
	self._nameText = gohelper.findChildText(self.viewGO, "layout/#scroll_card/#txt_skillname")
	self._skillText = gohelper.findChildText(self.viewGO, "layout/#scroll_card/#scroll_skill/viewport/content/#txt_skilldec")
	self._cardMask = gohelper.findChild(self.viewGO, "layout/#scroll_card/Viewport").transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightCardDeckView:addEvents()
	self:addEventCb(FightController.instance, FightEvent.GetFightCardDeckInfoReply, self._onGetFightCardDeckInfoReply, self)
	self:addClickCb(self._click, self._onViewClick, self)
end

function FightCardDeckView:removeEvents()
	return
end

function FightCardDeckView:_editableInitView()
	self._nameText.text = ""
	self._skillText.text = ""
end

function FightCardDeckView:_onViewClick()
	self:closeThis()
end

FightCardDeckView.SelectType = {
	CardBox = 1,
	PreCard = 2
}

function FightCardDeckView:onOpen()
	self._cardItemDic = {}
	self._selectType = self.viewParam and self.viewParam.selectType or FightCardDeckView.SelectType.CardBox

	self:_refreshBtn()
	self:_refreshBtnState()

	local cardPath = "ui/viewres/fight/fightcarditem.prefab"

	self:com_loadAsset(cardPath, self._onCardLoadFinish)
end

function FightCardDeckView:_startRefreshUI()
	self:addClickCb(self._btnCardBox, self._onCardBoxClick, self)
	self:addClickCb(self._btnCardPre, self._onCardPreClick, self)
	self:_refreshUI()
end

function FightCardDeckView:_onCardBoxClick()
	self._selectType = FightCardDeckView.SelectType.CardBox

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckView:_onCardPreClick()
	self._selectType = FightCardDeckView.SelectType.PreCard

	self:_refreshUI()
	self:_refreshBtnState()
end

function FightCardDeckView:_onCardLoadFinish(loader)
	local tarPrefab = loader:GetResource()

	gohelper.clone(tarPrefab, gohelper.findChild(self._cardItem, "card"), "card")
	gohelper.setActive(gohelper.findChild(self._cardItem, "select"), false)
	self:_startRefreshUI()
end

function FightCardDeckView:_onGetFightCardDeckInfoReply(msg)
	self._boxList = {}

	local entityDic = {}

	for _, v in ipairs(msg.deckInfos) do
		local cardInfo = FightCardInfoData.New(v)
		local entityId = cardInfo.uid
		local tab = entityDic[entityId]

		if not tab then
			tab = {}
			entityDic[entityId] = tab
		end

		local skillId = cardInfo.skillId

		if not tab[skillId] then
			tab[skillId] = {}
			tab[skillId][1] = {}
			tab[skillId][2] = {}
		end

		if cardInfo.tempCard then
			table.insert(tab[skillId][1], cardInfo)
		else
			table.insert(tab[skillId][2], cardInfo)
		end
	end

	for entityId, v in pairs(entityDic) do
		for skillId, dic in pairs(v) do
			if #dic[1] > 0 then
				local tab = {}

				tab.skillId = skillId
				tab.tempCard = true
				tab.entityId = entityId
				tab.num = #dic[1]

				table.insert(self._boxList, tab)
			end

			if #dic[2] > 0 then
				local tab = {}

				tab.skillId = skillId
				tab.entityId = entityId
				tab.num = #dic[2]

				table.insert(self._boxList, tab)
			end
		end
	end

	if self._selectType == FightCardDeckView.SelectType.CardBox then
		self:_refreshCardBox()
	end
end

function FightCardDeckView:_refreshUI()
	if self._selectType == FightCardDeckView.SelectType.CardBox then
		if self._boxList then
			self:_refreshCardBox()
		else
			FightRpc.instance:sendGetFightCardDeckInfoRequest(FightRpc.DeckInfoRequestType.MySide)
		end
	else
		self:_refreshPreCard()
	end
end

function FightCardDeckView.sortCardBox(item1, item2)
	local entityMO1 = FightDataHelper.entityMgr:getById(item1.entityId)
	local entityMO2 = FightDataHelper.entityMgr:getById(item2.entityId)

	if not entityMO1 and entityMO2 then
		return true
	elseif entityMO1 and not entityMO2 then
		return false
	elseif not entityMO1 and not entityMO2 then
		return item1.skillId < item2.skillId
	else
		local position1 = entityMO1.position
		local position2 = entityMO2.position

		if position1 < position2 then
			return true
		elseif position2 < position1 then
			return false
		elseif item1.skillId == item2.skillId then
			if item1.tempCard and not item2.tempCard then
				return true
			elseif not item1.tempCard and item2.tempCard then
				return false
			else
				return item1.skillId < item2.skillId
			end
		else
			return item1.skillId < item2.skillId
		end
	end
end

function FightCardDeckView:_refreshCardBox()
	table.sort(self._boxList, FightCardDeckView.sortCardBox)
	self:com_createObjList(self._onCardItemShow, self._boxList, self._cardRoot, self._cardItem)

	if #self._boxList == 0 then
		self._nameText.text = ""
		self._skillText.text = ""
	end

	if #self._boxList > 6 then
		recthelper.setHeight(self._cardMask, 480)
	else
		recthelper.setHeight(self._cardMask, 320)
	end
end

function FightCardDeckView:_refreshPreCard()
	self:com_createObjList(self._onCardItemShow, self._preCardList, self._cardRoot, self._cardItem)

	if #self._preCardList == 0 then
		self._nameText.text = ""
		self._skillText.text = ""
	end

	if #self._preCardList > 6 then
		recthelper.setHeight(self._cardMask, 480)
	else
		recthelper.setHeight(self._cardMask, 320)
	end
end

function FightCardDeckView:_onCardItemShow(obj, data, index)
	gohelper.setActive(obj, false)
	gohelper.setActive(obj, true)

	local instanceId = obj:GetInstanceID()
	local cardItem = self._cardItemDic[instanceId]

	if not cardItem then
		cardItem = self:openSubView(FightCardDeckViewItem, obj)
		self._cardItemDic[instanceId] = cardItem

		self:addClickCb(gohelper.getClickWithDefaultAudio(gohelper.findChild(obj, "card")), self._onCardItemClick, self, instanceId)
	end

	cardItem:refreshItem(data)

	if self._selectType == FightCardDeckView.SelectType.CardBox then
		cardItem:showCount(data.num)
	end

	if index == 1 then
		self:_onCardItemClick(instanceId)
	end
end

function FightCardDeckView:_onCardItemClick(instanceId)
	local cardItem = self._cardItemDic[instanceId]

	if self._curSelectItem then
		self._curSelectItem:setSelect(false)
	end

	self._curSelectItem = cardItem

	self._curSelectItem:setSelect(true)

	local itemData = cardItem._data
	local skillId = itemData.skillId
	local entityId = itemData.entityId
	local skillConfig = lua_skill.configDict[skillId]

	self._nameText.text = skillConfig.name
	self._skillText.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(entityId, skillConfig), "#c56131", "#7c93ad")
end

function FightCardDeckView:_refreshBtnState()
	gohelper.setActive(self._cardBoxSelect, self._selectType == FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._cardBoxUnselect, self._selectType ~= FightCardDeckView.SelectType.CardBox)
	gohelper.setActive(self._cardPreSelect, self._selectType == FightCardDeckView.SelectType.PreCard)
	gohelper.setActive(self._cardPreUnselect, self._selectType ~= FightCardDeckView.SelectType.PreCard)
end

function FightCardDeckView:_refreshBtn()
	self._preCardList = FightHelper.getNextRoundGetCardList()

	gohelper.setActive(self._btnCardPre.gameObject, #self._preCardList > 0)
end

function FightCardDeckView:onClose()
	return
end

function FightCardDeckView:onDestroyView()
	return
end

return FightCardDeckView
