-- chunkname: @modules/logic/survival/view/shop/SurvivalShopTab.lua

module("modules.logic.survival.view.shop.SurvivalShopTab", package.seeall)

local SurvivalShopTab = class("SurvivalShopTab", SurvivalSimpleListItem)

function SurvivalShopTab:init(viewGO)
	self.btnClick = gohelper.findButtonWithAudio(viewGO)
	self.image_icon = gohelper.findChildImage(viewGO, "#image_icon")
end

function SurvivalShopTab:addEventListeners()
	self:addClickCb(self.btnClick, self.onClick, self)
end

function SurvivalShopTab:onItemShow(data)
	self.cfg = data.cfg
	self.tabId = self.cfg.id
	self.onClickFunc = data.onClickFunc
	self.context = data.context

	UISpriteSetMgr.instance:setSurvivalSprite(self.image_icon, self.cfg.tabIcon)
end

function SurvivalShopTab:onSelectChange(isSelect)
	local color = self.image_icon.color

	if isSelect then
		self.image_icon.color = Color.New(color.r, color.g, color.b, 1)
	else
		self.image_icon.color = Color.New(color.r, color.g, color.b, 0.4)
	end
end

function SurvivalShopTab:onClick()
	if self.onClickFunc then
		self.onClickFunc(self.context, self)
	end
end

return SurvivalShopTab
