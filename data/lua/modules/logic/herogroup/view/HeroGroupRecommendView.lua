module("modules.logic.herogroup.view.HeroGroupRecommendView", package.seeall)

slot0 = class("HeroGroupRecommendView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollgroup = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_group")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#siamge_bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getHeroGroupBg("full/tuijianbeijingdi_036"))
end

function slot0._refreshUI(slot0)
	HeroGroupRecommendCharacterListModel.instance:setCharacterList(slot0.viewParam.racommends)
end

function slot0._onClickRecommendCharacter(slot0)
	slot0._scrollgroup.verticalNormalizedPosition = 1
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickRecommendCharacter, slot0._onClickRecommendCharacter, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
