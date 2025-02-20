module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTabItem", package.seeall)

slot0 = class("VersionActivity1_5HeroTabItem", UserDataDispose)

function slot0.createItem(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.go = slot1
	slot0.id = slot2.id
	slot0.heroTaskMo = slot2
	slot0.config = slot2.config
	slot0.isUnlock = slot0.heroTaskMo:isUnlock()
	slot0.imageheroicon = gohelper.findChildImage(slot0.go, "#image_heroicon")
	slot0.goLocked = gohelper.findChild(slot0.go, "#go_Locked")
	slot0.txtLocked = gohelper.findChildText(slot0.go, "#go_Locked/#txt_lock")
	slot0.goClickArea = gohelper.findChild(slot0.go, "#go_clickarea")
	slot0.goRedDot = gohelper.findChild(slot0.go, "redPoint")
	slot0.goRedDotRectTr = slot0.goRedDot:GetComponent(gohelper.Type_RectTransform)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.goClickArea)

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)
	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0.goRedDot, true)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, slot0.refreshHeroIcon, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.refreshRedDot, slot0)
	slot0:refreshUI()
end

function slot0.onClickSelf(slot0)
	if not slot0.isUnlock then
		GameFacade.showToast(slot0.config.toastId)

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(slot0.id)
end

function slot0.refreshUI(slot0)
	slot0:refreshLockUI()
	slot0:refreshHeroIcon()
end

function slot0.refreshLockUI(slot0)
	gohelper.setActive(slot0.goLocked, not slot0.isUnlock)

	if not slot0.isUnlock then
		slot0.txtLocked.text = luaLang("rolestoryrewardstate_1")
	end
end

function slot0.refreshHeroIcon(slot0)
	gohelper.setActive(slot0.imageheroicon.gameObject, slot0.isUnlock)

	if not slot0.isUnlock then
		return
	end

	slot1 = ""

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(slot0.imageheroicon, slot0:isExploreTask() and (slot0:isSelect() and VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect) or slot0:isSelect() and slot0.config.heroTabIcon .. "_" .. 1 or slot0.config.heroTabIcon .. "_" .. 2)
	slot0:refreshRedDot()
end

function slot0.isExploreTask(slot0)
	return slot0.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function slot0.refreshRedDot(slot0)
	if slot0:isExploreTask() then
		RedDotController.instance:addRedDot(slot0.goRedDot, RedDotEnum.DotNode.V1a5DungeonExploreTask, nil, slot0.refreshExploreRedDot, slot0)
	else
		slot0:createRedDot()
		gohelper.setActive(slot0.goRedDotIcon, slot0:getHeroTaskRedDotMo() and slot1.value > 0)
	end

	slot1 = slot0:isSelect() and VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Normal or VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Lock

	recthelper.setAnchor(slot0.goRedDotRectTr, slot1.x, slot1.y)
end

function slot0.getHeroTaskRedDotMo(slot0)
	if slot0:isExploreTask() then
		return
	end

	if not RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a5DungeonHeroTask) then
		logWarn("not found red dot group mo, id = " .. RedDotEnum.DotNode.V1a5DungeonHeroTask)

		return
	end

	for slot5, slot6 in pairs(slot1.infos) do
		if slot6.uid == slot0.id then
			return slot6
		end
	end
end

function slot0.createRedDot(slot0)
	if slot0:isExploreTask() then
		return
	end

	if slot0.goRedDotIcon then
		return
	end

	slot5 = slot0.goRedDot

	for slot5, slot6 in pairs(RedDotEnum.Style) do
		gohelper.setActive(gohelper.findChild(IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, slot5), "type" .. slot6), false)

		if slot6 == RedDotEnum.Style.Normal then
			slot0.goRedDotIcon = slot7
		end
	end
end

function slot0.refreshExploreRedDot(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.isSelect(slot0)
	return VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == slot0.id
end

function slot0.destroy(slot0)
	slot0.click:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
