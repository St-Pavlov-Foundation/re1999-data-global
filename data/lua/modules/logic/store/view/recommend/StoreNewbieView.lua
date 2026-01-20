-- chunkname: @modules/logic/store/view/recommend/StoreNewbieView.lua

module("modules.logic.store.view.recommend.StoreNewbieView", package.seeall)

local StoreNewbieView = class("StoreNewbieView", StoreRecommendBaseSubView)

function StoreNewbieView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "recommend/#simage_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreNewbieView:addEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function StoreNewbieView:removeEvents()
	self._btn:RemoveClickListener()
end

function StoreNewbieView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("firstchargeview/bg"))

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local gotmp = gohelper.findChild(self.viewGO, "recommend")

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(gotmp)
	self._btn = gohelper.getClickWithAudio(self.viewGO)
	self._txticon = gohelper.findChildText(self.viewGO, "recommend/#simage_bg/#txt_num/#txt_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "recommend/#simage_bg/#txt_num")
	self._txticon.text = PayModel.instance:getProductOriginPriceSymbol(610002)
	self._txtnum.text = PayModel.instance:getProductOriginPriceNum(610002)
	self._txtnum = gohelper.getDynamicSizeText(self._txtnum.gameObject)
	self._txtnum.maxIteration = 3
	self._txticon.text = ""

	local symbol = PayModel.instance:getProductOriginPriceSymbol(610002)
	local _, numStr = PayModel.instance:getProductOriginPriceNum(610002)
	local symbol2 = ""

	if string.nilorempty(symbol) then
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex + 1
		symbol2 = string.sub(numStr, lastIndex + 1, string.len(numStr))
		numStr = string.sub(numStr, 1, lastIndex)
		self._txtnum.text = string.format("%s<size=100>%s</size>", numStr, symbol2)
	else
		self._txtnum.text = string.format("<size=100>%s</size>%s", symbol, numStr)
	end
end

function StoreNewbieView:onUpdateParam()
	return
end

function StoreNewbieView:_onClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = "712",
		[StatEnum.EventProperties.RecommendPageName] = "新人邀约",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
	GameFacade.jumpByAdditionParam("10170#610002")
	AudioMgr.instance:trigger(2000001)
end

function StoreNewbieView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return StoreNewbieView
