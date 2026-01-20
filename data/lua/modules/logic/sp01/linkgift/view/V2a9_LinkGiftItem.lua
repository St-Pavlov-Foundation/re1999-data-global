-- chunkname: @modules/logic/sp01/linkgift/view/V2a9_LinkGiftItem.lua

module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftItem", package.seeall)

local V2a9_LinkGiftItem = class("V2a9_LinkGiftItem", LuaCompBase)

function V2a9_LinkGiftItem:init(go)
	self.viewGO = go
	self.go = go
	self._txtprice = gohelper.findChildText(self.viewGO, "#txt_price")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._gosoldout = gohelper.findChild(self.viewGO, "#go_soldout")
	self._gocanget = gohelper.findChild(self.viewGO, "#go_canget")

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEvents()
end

function V2a9_LinkGiftItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function V2a9_LinkGiftItem:removeEvents()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end
end

function V2a9_LinkGiftItem:_btnclickOnClick()
	if self._charageGoodsCfg and self._packageGoodsMO then
		if ViewMgr.instance:isOpen(ViewName.SummonADView) then
			StoreController.instance:openPackageStoreGoodsView(self._packageGoodsMO)
		else
			StoreController.instance:openStoreView(self._charageGoodsCfg.belongStoreId, self._charageGoodsCfg.id)
		end
	end
end

function V2a9_LinkGiftItem:_editableInitView()
	return
end

function V2a9_LinkGiftItem:onUpdateMO(charageGoodsCfg)
	self._charageGoodsCfg = charageGoodsCfg
	self._packageGoodsMO = charageGoodsCfg and StoreModel.instance:getGoodsMO(charageGoodsCfg.id)

	gohelper.setActive(self.go, charageGoodsCfg ~= nil)

	local isBuy = self._packageGoodsMO and self._packageGoodsMO.buyCount > 0
	local goodsId = self._packageGoodsMO and self._packageGoodsMO.id
	local isTaskFinsish = isBuy and StoreCharageConditionalHelper.isCharageTaskFinish(goodsId)
	local isCanGet = isBuy and StoreCharageConditionalHelper.isCharageTaskNotFinish(goodsId)

	gohelper.setActive(self._gosoldout, isTaskFinsish)
	gohelper.setActive(self._gocanget, isCanGet)

	if goodsId and self._txtprice then
		self._txtprice.text = StoreModel.instance:getCostPriceFull(goodsId)
	end

	if isBuy and goodsId then
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.V2a9_LinkGiftItemGoodsAnim .. goodsId)

		if isCanGet then
			self:_playGoAnimByKey(self._gocanget, key .. "_gocanget")
		end

		if isTaskFinsish then
			self:_playGoAnimByKey(self._gosoldout, key .. "_gosoldout")
		end
	end
end

function V2a9_LinkGiftItem:_playGoAnimByKey(go, key)
	local num = PlayerPrefsHelper.getNumber(key, 0)

	if num ~= 1 then
		PlayerPrefsHelper.setNumber(key, 1)

		if go then
			local animator = go:GetComponent(gohelper.Type_Animator)

			if animator then
				animator:Play("open", 0, 0)
			end
		end
	end
end

function V2a9_LinkGiftItem:onDestroy()
	self:removeEvents()
	self:__onDispose()
end

return V2a9_LinkGiftItem
