module("modules.logic.versionactivity1_8.dungeon.view.dispatch.VersionActivity1_8DispatchSelectHeroItem", package.seeall)

slot0 = class("VersionActivity1_8DispatchSelectHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.index = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goHero = gohelper.findChild(slot0.go, "#go_hero")
	slot0.simageHeroIcon = gohelper.findChildSingleImage(slot0.go, "#go_hero/#simage_heroicon")
	slot0.imageCareer = gohelper.findChildImage(slot0.go, "#go_hero/#image_career")
	slot0.click = gohelper.getClick(slot0.go)

	gohelper.setActive(slot0.goHero, false)
end

function slot0.addEventListeners(slot0)
	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
	slot0:addEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.click:RemoveClickListener()
	slot0:removeEventCb(DispatchController.instance, DispatchEvent.ChangeSelectedHero, slot0.refreshUI, slot0)
end

function slot0.onClickSelf(slot0)
	if not DispatchHeroListModel.instance:canChangeHeroMo() then
		return
	end

	if slot0.mo then
		DispatchHeroListModel.instance:deselectMo(slot0.mo)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeDispatchHeroContainerEvent, true)
end

function slot0.refreshUI(slot0)
	slot0.mo = DispatchHeroListModel.instance:getSelectedMoByIndex(slot0.index)
	slot1 = slot0:isSelected()

	gohelper.setActive(slot0.goHero, slot1)

	if slot1 then
		slot0.heroCo = slot0.mo.config

		slot0.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot0.heroCo.id .. "01"))
		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, "lssx_" .. slot0.heroCo.career)
	end
end

function slot0.isSelected(slot0)
	return slot0.mo ~= nil
end

function slot0.destroy(slot0)
	slot0.simageHeroIcon:UnLoadImage()
end

return slot0
