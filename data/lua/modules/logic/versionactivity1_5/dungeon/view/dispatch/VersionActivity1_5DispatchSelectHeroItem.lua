module("modules.logic.versionactivity1_5.dungeon.view.dispatch.VersionActivity1_5DispatchSelectHeroItem", package.seeall)

slot0 = class("VersionActivity1_5DispatchSelectHeroItem", UserDataDispose)

function slot0.createItem(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.index = slot2
	slot0.go = slot1
	slot0.goHero = gohelper.findChild(slot0.go, "#go_hero")
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot0.go, "#go_hero/#simage_heroicon")
	slot0.imageCareer = gohelper.findChildImage(slot0.go, "#go_hero/#image_career")
	slot0.click = gohelper.getClick(slot0.go)

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
	gohelper.setActive(slot0.goHero, false)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.ChangeSelectedHero, slot0.refreshUI, slot0)
end

function slot0.onClickSelf(slot0)
	if not VersionActivity1_5HeroListModel.instance:canChangeHeroMo() then
		return
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeDispatchHeroContainerEvent, true)

	if slot0.mo == nil then
		return
	end

	VersionActivity1_5HeroListModel.instance:deselectMo(slot0.mo)
end

function slot0.isSelected(slot0)
	return slot0.mo ~= nil
end

function slot0.refreshUI(slot0)
	slot0.mo = VersionActivity1_5HeroListModel.instance:getSelectedMoByIndex(slot0.index)

	gohelper.setActive(slot0.goHero, slot0:isSelected())

	if slot0:isSelected() then
		slot0.heroCo = slot0.mo.config

		slot0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot0.heroCo.id .. "01"))
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot0.heroCo.career)
	end
end

function slot0.destroy(slot0)
	slot0.simageHeroIcon:UnLoadImage()
	slot0.click:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
