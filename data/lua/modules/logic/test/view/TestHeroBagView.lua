module("modules.logic.test.view.TestHeroBagView", package.seeall)

slot0 = class("TestHeroBagView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_card")
end

function slot0.addEvents(slot0)
end

function slot0.definePrefabUrl(slot0)
	slot0.internal_pre_url = "ui/viewres/character/characterbackpackheroview.prefab"
end

function slot0.onOpen(slot0)
	slot0._scroll_view = slot0:com_registSimpleScrollView(slot0._scrollcard.gameObject, ScrollEnum.ScrollDirV, 6)

	slot0._scroll_view:setClass(TestHeroBagItemView)
	slot0._scroll_view:setData(HeroModel.instance:getList())
end

function slot0.onClose(slot0)
end

return slot0
