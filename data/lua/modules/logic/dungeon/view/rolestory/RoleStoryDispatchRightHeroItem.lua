module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchRightHeroItem", package.seeall)

slot0 = class("RoleStoryDispatchRightHeroItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0.goAdd = gohelper.findChild(slot0.viewGO, "add")
	slot0.goHero = gohelper.findChild(slot0.viewGO, "#go_hero")
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot0.viewGO, "#go_hero/#simage_heroicon")
	slot0.imageCareer = gohelper.findChildImage(slot0.viewGO, "#go_hero/#image_career")
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
	if slot0.maxCount < slot0.index then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)
	gohelper.setActive(slot0.goAdd, not slot0.data)

	if not slot0.data then
		slot0:clear()
		gohelper.setActive(slot0.goHero, false)

		return
	end

	gohelper.setActive(slot0.goHero, true)

	slot1 = slot0.data.config

	slot0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot1.id .. "01"))
	UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot1.career)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0.data = slot1
	slot0.index = slot2
	slot0.maxCount = slot3

	slot0:refreshItem()
end

function slot0.onClickBtnClick(slot0)
	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ClickRightHero, slot0.data)
end

function slot0._editableInitView(slot0)
end

function slot0.clear(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clear()

	if slot0.simageHeroIcon then
		slot0.simageHeroIcon:UnLoadImage()

		slot0.simageHeroIcon = nil
	end
end

return slot0
