-- chunkname: @modules/logic/partygame/view/carddrop/tipview/CardDropCardTipView.lua

module("modules.logic.partygame.view.carddrop.tipview.CardDropCardTipView", package.seeall)

local CardDropCardTipView = class("CardDropCardTipView", BaseView)

function CardDropCardTipView:onInitView()
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rootRect = gohelper.findChildComponent(self.viewGO, "layout", gohelper.Type_RectTransform)
	self.txtTitle = gohelper.findChildText(self.viewGO, "layout/#txt_title")
	self.txtDesc = gohelper.findChildText(self.viewGO, "layout/#txt_desc")
	self.goCard = gohelper.findChild(self.viewGO, "layout/#go_card")
	self.closeClick = gohelper.findChildClick(self.viewGO, "close_block")

	self:addClickCb(self.closeClick, self.closeThis, self)
end

function CardDropCardTipView:onOpen()
	self:refreshCardUI()
	self:refreshPos()
end

function CardDropCardTipView:refreshCardUI()
	local cardId = self.viewParam.cardId
	local config = lua_partygame_carddrop_card.configDict[cardId]
	local typeConfig = config and lua_partygame_carddrop_cardtype.configDict[config.type]

	self.txtTitle.text = typeConfig and typeConfig.name or ""
	self.txtDesc.text = config and config.desc or ""

	local res = self.viewContainer:getSetting().otherRes.cardItem

	self.cardItemGo = self.viewContainer:getResInst(res, self.goCard)
	self.cardComp = PartyGameCommonCard.New()

	self.cardComp:init(self.cardItemGo, 1)
	self.cardComp:updateId(cardId)
end

local MaxAnchorX = 960
local MinAnchorX = -350

function CardDropCardTipView:refreshPos()
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(self.viewParam.screenPos, self.viewRect)

	anchorX = anchorX + self.viewParam.offsetX
	anchorY = anchorY + self.viewParam.offsetY
	anchorX = math.max(MinAnchorX, math.min(MaxAnchorX, anchorX))

	ZProj.UGUIHelper.RebuildLayout(self.rootRect)

	local w = recthelper.getWidth(self.rootRect)
	local h = recthelper.getHeight(self.rootRect)
	local hSW = UnityEngine.Screen.width * 0.5
	local hSH = UnityEngine.Screen.height * 0.5
	local kPadding = 10
	local range = {
		minX = -hSW + w * 0.5 + kPadding,
		maxX = hSW + w * 0.5 - kPadding,
		minY = -hSH + h + kPadding,
		maxY = hSH - h - kPadding
	}

	anchorX = GameUtil.clamp(anchorX, range.minX, range.maxX)
	anchorY = GameUtil.clamp(anchorY, range.minY, range.maxY)

	recthelper.setAnchor(self.rootRect, anchorX, anchorY)
end

return CardDropCardTipView
