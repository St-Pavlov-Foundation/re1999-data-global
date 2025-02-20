module("modules.logic.versionactivity2_3.act174.view.Act174BattleHeroItem", package.seeall)

slot0 = class("Act174BattleHeroItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._readyItem = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goSelect = gohelper.findChild(slot1, "go_Select")
	slot0._goEmpty = gohelper.findChild(slot1, "go_Empty")
	slot0._goHero = gohelper.findChild(slot1, "go_Hero")
	slot0._imageRare = gohelper.findChildImage(slot1, "go_Hero/rare")
	slot0._heroIcon = gohelper.findChildSingleImage(slot1, "go_Hero/image_Hero")
	slot0._imageCareer = gohelper.findChildImage(slot1, "go_Hero/image_Career")
	slot0._skillIcon = gohelper.findChildSingleImage(slot1, "go_Hero/skill/image_Skill")
	slot0._collectionQuality = gohelper.findChildImage(slot1, "go_Hero/collection/image_quality")
	slot0._collectionIcon = gohelper.findChildSingleImage(slot1, "go_Hero/collection/image_Collection")
	slot0._collectionEmpty = gohelper.findChild(slot1, "go_Hero/collection/empty")
	slot0._txtIndex = gohelper.findChildText(slot1, "Index/txt_Index")
	slot0._goLock = gohelper.findChild(slot1, "go_Lock")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot1, "")

	slot0:addClickCb(slot0._btnClick, slot0.onClick, slot0)

	if slot0._readyItem then
		CommonDragHelper.instance:registerDragObj(slot1, slot0._readyItem.beginDrag, slot0._readyItem.onDrag, slot0._readyItem.endDrag, slot0._readyItem.checkDrag, slot0._readyItem, nil, true)
	end
end

function slot0.onClick(slot0)
	if slot0._readyItem and slot0._readyItem.isDraging or not slot0.info then
		return
	end

	Activity174Controller.instance:openRoleInfoView(slot0.info.heroId, slot0.itemId ~= 0 and slot0.itemId or nil)
end

function slot0.onDestroy(slot0)
	slot0._heroIcon:UnLoadImage()
	slot0._skillIcon:UnLoadImage()
	slot0._collectionIcon:UnLoadImage()

	if slot0._readyItem then
		CommonDragHelper.instance:unregisterDragObj(slot0._go)
	end
end

function slot0.setIndex(slot0, slot1)
	slot0._txtIndex.text = slot1
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.info = slot1

	if slot1 then
		slot5 = Activity174Config.instance:getRoleCo(slot1.heroId)
		slot0.itemId = slot1.itemId

		if slot0.itemId == 0 then
			slot0.itemId = Activity174Model.instance:getActInfo():getGameInfo():getTempCollectionId(slot2, slot1.index, slot3)
		end

		slot6 = lua_activity174_collection.configDict[slot0.itemId]

		if slot5 then
			UISpriteSetMgr.instance:setAct174Sprite(slot0._imageRare, "act174_ready_rolebg_" .. slot5.rare)
			UISpriteSetMgr.instance:setCommonSprite(slot0._imageCareer, "lssx_" .. slot5.career)
			slot0._heroIcon:LoadImage(ResUrl.getHeadIconMiddle(slot5.skinId))

			if lua_skill.configDict[Activity174Config.instance:getHeroSkillIdDic(slot1.heroId, true)[slot1.priorSkill]] then
				slot0._skillIcon:LoadImage(ResUrl.getSkillIcon(slot10.icon))
			end

			gohelper.setActive(slot0._skillIcon, slot10)
		end

		if slot6 then
			slot0._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot6.icon))
			UISpriteSetMgr.instance:setAct174Sprite(slot0._collectionQuality, "act174_propitembg_" .. slot6.rare)
		end

		gohelper.setActive(slot0._collectionIcon, slot6)
		gohelper.setActive(slot0._collectionEmpty, not slot6)
	end

	gohelper.setActive(slot0._goHero, slot1)
	gohelper.setActive(slot0._goEmpty, not slot1)
end

return slot0
