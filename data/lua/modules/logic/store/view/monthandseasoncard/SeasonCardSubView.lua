-- chunkname: @modules/logic/store/view/monthandseasoncard/SeasonCardSubView.lua

module("modules.logic.store.view.monthandseasoncard.SeasonCardSubView", package.seeall)

local SeasonCardSubView = class("SeasonCardSubView", StoreSeasonCardView)

function SeasonCardSubView:_btnbuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_pause)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(self.config and self.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = self.config and self.config.name or "StoreSeasonCardView",
		[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()
	})

	local goodId = StoreEnum.SeasonCardGoodsId
	local packageMo = StoreModel.instance:getGoodsMO(goodId)

	if not packageMo or packageMo:isSoldOut() then
		GameFacade.showToast(ToastEnum.SeasonCardSoldOutTip)

		return
	end

	StoreController.instance:openPackageStoreGoodsView(packageMo)
end

function SeasonCardSubView:getTabIndex(id)
	if self.viewContainer and self.viewContainer.getMonthAndSeasonTabIndex and (self.config or id) then
		return self.viewContainer:getMonthAndSeasonTabIndex(id or self.config.id)
	end

	return 1
end

return SeasonCardSubView
