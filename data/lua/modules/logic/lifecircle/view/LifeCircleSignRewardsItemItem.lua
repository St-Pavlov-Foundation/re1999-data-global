-- chunkname: @modules/logic/lifecircle/view/LifeCircleSignRewardsItemItem.lua

module("modules.logic.lifecircle.view.LifeCircleSignRewardsItemItem", package.seeall)

local LifeCircleSignRewardsItemItem = class("LifeCircleSignRewardsItemItem", RougeSimpleItemBase)

function LifeCircleSignRewardsItemItem:onInitView()
	self._imagebg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self._simageReward = gohelper.findChildSingleImage(self.viewGO, "#simage_Reward")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_hasget")
	self._txtrewardcount = gohelper.findChildText(self.viewGO, "#txt_rewardcount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCircleSignRewardsItemItem:addEvents()
	return
end

function LifeCircleSignRewardsItemItem:removeEvents()
	return
end

local COLOR_REWARD_GOT = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT = Color.New(0.5, 0.5, 0.5, 1)
local COLOR_BG_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_COUNT_GOT = Color.New(0.227451, 0.227451, 0.227451, 1)
local COLOR_COUNT_NORMAL = Color.New(0.227451, 0.227451, 0.227451, 1)

function LifeCircleSignRewardsItemItem:ctor(...)
	self:__onInit()
	LifeCircleSignRewardsItemItem.super.ctor(self, ...)
end

function LifeCircleSignRewardsItemItem:_editableInitView()
	LifeCircleSignRewardsItemItem.super._editableInitView(self)

	self._simageRewardGo = self._simageReward.gameObject
	self._simageRewardImg = self._simageReward:GetComponent(gohelper.Type_Image)
	self._imagebgGo = self._imagebg.gameObject
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._simageRewardGo)
end

function LifeCircleSignRewardsItemItem:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_itemIcon")
	LifeCircleSignRewardsItemItem.super.onDestroyView(self)
	self:__onDispose()
end

function LifeCircleSignRewardsItemItem:_isClaimed()
	local p = self:parent()

	return p:isClaimed()
end

function LifeCircleSignRewardsItemItem:_logindaysid()
	local p = self:parent()

	return p:logindaysid()
end

function LifeCircleSignRewardsItemItem:_setData_Normal(mo)
	local itemType = mo[1]
	local itemId = mo[2]
	local itemCount = mo[3]
	local itemCO, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	self._itemIcon:setMOValue(itemType, itemId, itemCount)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowEquipAndItemCount(false)
	self._itemIcon:customOnClickCallback(self._onItemClick, self)

	if self._itemIcon:isEquipIcon() then
		self._itemIcon:setScale(0.7)
	else
		self._itemIcon:setScale(0.8)
	end

	self:_setBg(itemCO.rare)

	self._txtrewardcount.text = itemCount and luaLang("multiple") .. itemCount or ""
end

function LifeCircleSignRewardsItemItem:_setBg(itemRare)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_" .. tostring(itemRare or 0))
end

function LifeCircleSignRewardsItemItem:_setData_LastOne()
	self._txtrewardcount.text = ""

	gohelper.setActive(self._imagebgGo, true)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_0")
	self:_setBg(0)
end

function LifeCircleSignRewardsItemItem:setData(mo)
	LifeCircleSignRewardsItemItem.super.setData(self, mo)

	local isClaimed = self:_isClaimed()
	local rewardColor = isClaimed and COLOR_REWARD_GOT or COLOR_REWARD_NORMAL
	local bgColor = isClaimed and COLOR_BG_GOT or COLOR_BG_NORMAL
	local countColor = isClaimed and COLOR_COUNT_GOT or COLOR_COUNT_NORMAL

	gohelper.setActive(self._simageRewardGo, mo and true or false)

	local isShowCommonPropItemIcon = mo and true or false

	self:_setActive_itemIcon(isShowCommonPropItemIcon)

	self._simageRewardImg.enabled = not isShowCommonPropItemIcon

	if not mo then
		self:_setData_LastOne()
	else
		self:_setData_Normal(mo)
	end

	self._simageRewardImg.color = rewardColor
	self._imagebg.color = bgColor
	self._txtrewardcount.color = countColor

	gohelper.setActive(self._gohasget, isClaimed)
end

function LifeCircleSignRewardsItemItem:_onItemClick()
	local p = self:parent()

	if not p:onItemClick() then
		return
	end

	local mo = self._mo

	if not mo then
		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function LifeCircleSignRewardsItemItem:_setActive_itemIcon(isActive)
	if isActive then
		self._itemIcon:setPropItemScale(1)
	else
		self._itemIcon:setPropItemScale(0)
	end
end

return LifeCircleSignRewardsItemItem
