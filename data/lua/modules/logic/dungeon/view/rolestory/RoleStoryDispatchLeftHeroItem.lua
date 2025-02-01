module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchLeftHeroItem", package.seeall)

slot0 = class("RoleStoryDispatchLeftHeroItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goHero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0.imageCareer = gohelper.findChildImage(slot0.viewGO, "#image_career")
	slot0.goDispatched = gohelper.findChild(slot0.viewGO, "#go_dispatched")
	slot0.goSelected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0.txtIndex = gohelper.findChildTextMesh(slot0.viewGO, "#go_selected/#txt_index")
	slot0.goUp = gohelper.findChild(slot0.viewGO, "upicon")
	slot0.btnClick = gohelper.findButtonWithAudio(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClick, slot0.onClickBtnClick, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.refreshItem(slot0)
	slot0.config = slot0.mo.config

	slot0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot0.config.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot0.config.career)

	slot3 = RoleStoryDispatchHeroListModel.instance:getSelectedIndex(slot0.mo.heroId) ~= nil

	gohelper.setActive(slot0.goDispatched, slot0.mo:isDispatched())
	gohelper.setActive(slot0.goSelected, slot3)

	if slot3 then
		slot0.txtIndex.text = slot2
	end

	gohelper.setActive(slot0.goUp, slot0.mo:isEffectHero())
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	slot0:refreshItem()
end

function slot0.onClickBtnClick(slot0)
	RoleStoryDispatchHeroListModel.instance:clickHeroMo(slot0.mo)
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.simageHeroIcon then
		slot0.simageHeroIcon:UnLoadImage()

		slot0.simageHeroIcon = nil
	end
end

return slot0
