module("modules.logic.versionactivity2_3.act174.view.Act174HeroItem", package.seeall)

slot0 = class("Act174HeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._teamView = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goHero = gohelper.findChild(slot1, "go_Hero")
	slot0._heroIcon = gohelper.findChildSingleImage(slot1, "go_Hero/image_Hero")
	slot0._heroQuality = gohelper.findChildImage(slot1, "go_Hero/image_quality")
	slot0._heroCareer = gohelper.findChildImage(slot1, "go_Hero/image_Career")
	slot0._goEquip = gohelper.findChild(slot1, "go_Equip")
	slot0._skillIcon = gohelper.findChildSingleImage(slot1, "go_Equip/skill/image_Skill")
	slot0._collectionIcon = gohelper.findChildSingleImage(slot1, "go_Equip/collection/image_Collection")
	slot0._goEmptyCollection = gohelper.findChild(slot1, "go_Equip/collection/empty")
	slot0._goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0._txtNum = gohelper.findChildText(slot1, "Index/txt_Num")
	slot0._goLock = gohelper.findChild(slot1, "go_Lock")
	slot0.btnClick = gohelper.findButtonWithAudio(slot1)

	CommonDragHelper.instance:registerDragObj(slot1, slot0.beginDrag, nil, slot0.endDrag, slot0.checkDrag, slot0)
	gohelper.setActive(slot0._goEmpty, true)
	gohelper.setActive(slot0._goHero, false)
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0._heroIcon:UnLoadImage()
	slot0._skillIcon:UnLoadImage()
	slot0._collectionIcon:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(slot0._go)
end

function slot0.onClick(slot0)
	if slot0.tweenId or slot0.isDraging then
		return
	end

	slot0._teamView:clickHero(slot0._index)
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
	slot2, slot0._txtNum.text = Activity174Helper.CalculateRowColumn(slot1)

	gohelper.setActive(slot0._goLock, slot0._teamView.unLockTeamCnt < slot2)
	gohelper.setActive(slot0._goEquip, slot2 <= slot4)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0._heroId = slot1
	slot0._itemId = slot2
	slot0._skillIndex = slot3

	if slot1 then
		slot4 = Activity174Config.instance:getRoleCo(slot1)

		slot0._heroIcon:LoadImage(ResUrl.getHeadIconMiddle(slot4.skinId))
		UISpriteSetMgr.instance:setAct174Sprite(slot0._heroQuality, "act174_ready_rolebg_" .. slot4.rare)
		UISpriteSetMgr.instance:setCommonSprite(slot0._heroCareer, "lssx_" .. slot4.career)
	end

	if slot2 then
		slot0._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(lua_activity174_collection.configDict[slot2].icon))
	end

	if slot3 then
		slot0._skillIcon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[Activity174Config.instance:getHeroSkillIdDic(slot0._heroId, true)[slot3]].icon))
	end

	gohelper.setActive(slot0._goHero, slot1)
	gohelper.setActive(slot0._collectionIcon, slot2)
	gohelper.setActive(slot0._goEmptyCollection, not slot2)
	gohelper.setActive(slot0._skillIcon, slot3)
	gohelper.setActive(slot0._goEmpty, not slot1 and not slot2)
end

function slot0.activeEquip(slot0, slot1)
	gohelper.setActive(slot0._goEquip, slot1)
end

function slot0.beginDrag(slot0)
	gohelper.setAsLastSibling(slot0._go)

	slot0.isDraging = true
end

function slot0.endDrag(slot0, slot1, slot2)
	slot0.isDraging = false

	if not slot0:findTarget(slot2.position) then
		slot6, slot7 = recthelper.getAnchor(slot0._teamView.frameTrList[slot0._index])

		slot0:setToPos(slot0._go.transform, Vector2(slot6, slot7), true, slot0.tweenCallback, slot0)
		slot0._teamView:UnInstallHero(slot0._index)
	else
		slot6, slot7 = recthelper.getAnchor(slot0._teamView.frameTrList[slot4._index])

		slot0:setToPos(slot0._go.transform, Vector2(slot6, slot7), true, slot0.tweenCallback, slot0)

		if slot4 ~= slot0 then
			slot9, slot10 = recthelper.getAnchor(slot0._teamView.frameTrList[slot0._index])

			slot0:setToPos(slot4._go.transform, Vector2(slot9, slot10), true, function ()
				uv0._teamView:exchangeHeroItem(uv0._index, uv1._index)
			end, slot0)
		end
	end
end

function slot0.checkDrag(slot0)
	if slot0._heroId and slot0._heroId ~= 0 then
		return false
	end

	return true
end

function slot0.findTarget(slot0, slot1)
	for slot5 = 1, slot0._teamView.unLockTeamCnt * 4 do
		slot6 = slot0._teamView.frameTrList[slot5]
		slot8, slot9 = recthelper.getAnchor(slot6)

		if math.abs(recthelper.screenPosToAnchorPos(slot1, slot6.parent).x - slot8) * 2 < recthelper.getWidth(slot6) and math.abs(slot11.y - slot9) * 2 < recthelper.getHeight(slot6) then
			return slot0._teamView.heroItemList[slot5] or nil
		end
	end

	return nil
end

function slot0.setToPos(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot3 then
		CommonDragHelper.instance:setGlobalEnabled(false)

		slot0.tweenId = ZProj.TweenHelper.DOAnchorPos(slot1, slot2.x, slot2.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1, slot2.x, slot2.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0.tweenCallback(slot0)
	slot0.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return slot0
