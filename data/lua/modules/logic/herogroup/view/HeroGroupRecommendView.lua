-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendView.lua

module("modules.logic.herogroup.view.HeroGroupRecommendView", package.seeall)

local HeroGroupRecommendView = class("HeroGroupRecommendView", BaseView)

function HeroGroupRecommendView:onInitView()
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "#scroll_group")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#siamge_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupRecommendView:addEvents()
	return
end

function HeroGroupRecommendView:removeEvents()
	return
end

function HeroGroupRecommendView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getHeroGroupBg("full/tuijianbeijingdi_036"))
end

function HeroGroupRecommendView:_refreshUI()
	local msg = self.viewParam

	HeroGroupRecommendCharacterListModel.instance:setCharacterList(msg.racommends)
end

function HeroGroupRecommendView:_onClickRecommendCharacter()
	self._scrollgroup.verticalNormalizedPosition = 1
end

function HeroGroupRecommendView:onOpen()
	self:_refreshUI()
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickRecommendCharacter, self._onClickRecommendCharacter, self)
end

function HeroGroupRecommendView:onClose()
	return
end

function HeroGroupRecommendView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return HeroGroupRecommendView
