-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftFullBonusItem.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullBonusItem", package.seeall)

local NationalGiftFullBonusItem = class("NationalGiftFullBonusItem", LuaCompBase)

function NationalGiftFullBonusItem:init(go, co)
	self.go = go
	self._config = co
	self._txtrewardnum1 = gohelper.findChildText(self.go, "group/reward1/txt_num")
	self._txtrewardnum2 = gohelper.findChildText(self.go, "group/reward2/txt_num")
	self._gounget = gohelper.findChild(self.go, "go_unget")
	self._gohasget = gohelper.findChild(self.go, "go_hasget")
	self._gocanget = gohelper.findChild(self.go, "go_canget")
	self._gonextday = gohelper.findChild(self.go, "go_nextday")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")

	self:_initItem()
end

function NationalGiftFullBonusItem:_initItem()
	local rewards = string.split(self._config.bonus, "|")

	for index, reward in ipairs(rewards) do
		local rewards = string.splitToNumber(reward, "#")

		self["_txtrewardnum" .. tostring(index)].text = rewards[3]
	end

	if self._btnClick then
		self._btnClick:AddClickListener(self._btnClickOnClick, self)
	end
end

function NationalGiftFullBonusItem:_btnClickOnClick()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if not isGiftHasBuy then
		return
	end

	local isCouldGet = NationalGiftModel.instance:isBonusCouldGet(self._config.id)

	if not isCouldGet then
		return
	end

	Activity212Rpc.instance:sendAct212ReceiveBonusRequest(VersionActivity3_1Enum.ActivityId.NationalGift, self._config.id)
end

function NationalGiftFullBonusItem:refresh()
	local isGet = NationalGiftModel.instance:isBonusGet(self._config.id)
	local isCouldGet = NationalGiftModel.instance:isBonusCouldGet(self._config.id)
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if self._gounget then
		local showUnget = self._config.id == 1 and not isGiftHasBuy

		gohelper.setActive(self._gounget, showUnget)
	end

	if self._gohasget then
		local showHasGet = isGiftHasBuy and isGet

		gohelper.setActive(self._gohasget, showHasGet)
	end

	if self._gocanget then
		local showCanGet = isGiftHasBuy and isCouldGet

		gohelper.setActive(self._gocanget, showCanGet)
	end

	if self._gonextday then
		local curDay = NationalGiftModel.instance:getCurRewardDay()
		local showNext = isGiftHasBuy and curDay + 1 == self._config.id

		gohelper.setActive(self._gonextday, showNext)
	end
end

function NationalGiftFullBonusItem:destroy()
	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

return NationalGiftFullBonusItem
