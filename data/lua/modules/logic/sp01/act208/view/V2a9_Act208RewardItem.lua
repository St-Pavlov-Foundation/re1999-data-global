-- chunkname: @modules/logic/sp01/act208/view/V2a9_Act208RewardItem.lua

module("modules.logic.sp01.act208.view.V2a9_Act208RewardItem", package.seeall)

local V2a9_Act208RewardItem = class("V2a9_Act208RewardItem", LuaCompBase)

function V2a9_Act208RewardItem:_setActiveByRegion(go, expectRegions)
	local curRegion = SettingsModel.instance:getRegion()
	local isActive = false

	for _, expectRegion in ipairs(expectRegions or {}) do
		if curRegion == expectRegion then
			isActive = true

			break
		end
	end

	gohelper.setActive(go, isActive)
end

function V2a9_Act208RewardItem:init(go)
	self.go = go
	self._simageItem = gohelper.findChildSingleImage(self.go, "#simage_Item")
	self._txtNum = gohelper.findChildText(self.go, "image_NumBG/#txt_Num")
	self._imageQuality = gohelper.findChildImage(self.go, "#img_Quality")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_Act208RewardItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a9_Act208RewardItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function V2a9_Act208RewardItem:_btnclickOnClick()
	if self.state == nil then
		return
	end

	if self.state == Act208Enum.BonusState.NotGet or self.state == Act208Enum.BonusState.HaveGet then
		if self.bonusData == nil then
			logError("bonusData is nil")

			return
		end

		local itemType = self.bonusData[1]
		local itemId = self.bonusData[2]
		local num = self.bonusData[3]

		MaterialTipController.instance:showMaterialInfo(itemType, itemId, false, nil, false)

		return
	end

	Act208Controller.instance:getBonus(self.actId, self.id)
end

function V2a9_Act208RewardItem:_editableInitView()
	self._txt_tips_overseas_zh_jpGo = gohelper.findChild(self.go, "tips/txt_tips_overseas_zh_jp")
	self._txt_tips_overseas_tw_krGo = gohelper.findChild(self.go, "tips/txt_tips_overseas_tw_kr")
	self._txt_tips_overseas_globalGo = gohelper.findChild(self.go, "tips/txt_tips_overseas_global")

	self:_setActiveByRegion(self._txt_tips_overseas_zh_jpGo, {
		RegionEnum.zh,
		RegionEnum.jp
	})
	self:_setActiveByRegion(self._txt_tips_overseas_tw_krGo, {
		RegionEnum.tw,
		RegionEnum.ko
	})
	self:_setActiveByRegion(self._txt_tips_overseas_globalGo, {
		RegionEnum.en
	})

	self._goCanGet = gohelper.findChild(self.go, "go_canget")
	self._goReceive = gohelper.findChild(self.go, "go_receive")

	gohelper.setActive(self._goCanGet, false)
	gohelper.setActive(self._goReceive, false)
end

function V2a9_Act208RewardItem:setData(activityId, config)
	self.actId = activityId
	self.id = config.id
	self.config = config

	self:refreshUI()
end

function V2a9_Act208RewardItem:refreshUI()
	local config = self.config
	local bonusData = string.splitToNumber(config.bonus, "#")
	local itemType = bonusData[1]
	local itemId = bonusData[2]
	local num = bonusData[3]

	self.bonusData = bonusData

	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(itemType, itemId, true)

	if config.isAllBonus == Act208Enum.RewardType.Common then
		self._simageItem:LoadImage(icon)

		self._txtNum.text = tostring(num)

		local rare = itemConfig.rare and itemConfig.rare or 5

		UISpriteSetMgr.instance:setOptionalGiftSprite(self._imageQuality, "bg_pinjidi_" .. rare)
	elseif config.isAllBonus == Act208Enum.RewardType.Final then
		-- block empty
	end
end

function V2a9_Act208RewardItem:setState(bonusMo)
	self.state = bonusMo.status

	gohelper.setActive(self._goCanGet, bonusMo.status == Act208Enum.BonusState.CanGet)
	gohelper.setActive(self._goReceive, bonusMo.status == Act208Enum.BonusState.HaveGet)
end

function V2a9_Act208RewardItem:onDestroy()
	return
end

return V2a9_Act208RewardItem
