-- chunkname: @modules/logic/store/view/recommend/StoreBlockPackageView.lua

module("modules.logic.store.view.recommend.StoreBlockPackageView", package.seeall)

local StoreBlockPackageView = class("StoreBlockPackageView", StoreRecommendBaseSubView)

function StoreBlockPackageView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._txtdurationTime = gohelper.findChildText(self.viewGO, "view/title/time/#txt_durationTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreBlockPackageView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreBlockPackageView:removeEvents()
	self._btnbuy:RemoveClickListener()
end

function StoreBlockPackageView:ctor(...)
	StoreBlockPackageView.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreBlockPackageView)
end

function StoreBlockPackageView:_btnbuyOnClick()
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(self.config and self.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = self.config and self.config.name or "StoreBlockPackageView",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})
	GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
end

function StoreBlockPackageView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._simagebg:LoadImage(ResUrl.getStoreBottomBgIcon("blockbg"))
end

function StoreBlockPackageView:onUpdateParam()
	return
end

function StoreBlockPackageView:onOpen()
	StoreBlockPackageView.super.onOpen(self)
	self:refreshUI()
end

function StoreBlockPackageView:refreshUI()
	self._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(self.config)
end

function StoreBlockPackageView:onClose()
	return
end

function StoreBlockPackageView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return StoreBlockPackageView
