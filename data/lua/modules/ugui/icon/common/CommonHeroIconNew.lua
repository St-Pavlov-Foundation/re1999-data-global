module("modules.ugui.icon.common.CommonHeroIconNew", package.seeall)

slot0 = class("CommonHeroIconNew", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._goEmpty = gohelper.findChild(slot0.go, "#go_empty")
	slot0._goHero = gohelper.findChild(slot0.go, "#go_hero")
	slot0._goBgFrame = gohelper.findChild(slot0.go, "#go_hero/bgframe")
	slot0._heroIcon = gohelper.findChildSingleImage(slot0.go, "#go_hero/heroicon")
	slot0._careerIcon = gohelper.findChildImage(slot0.go, "#go_hero/career")
	slot0._goLevel = gohelper.findChild(slot0.go, "#go_hero/#go_level")
	slot0._rankIcon = gohelper.findChildImage(slot0.go, "#go_hero/#go_level/layout/#image_insight")
	slot0._txtLvHead = gohelper.findChildText(slot0.go, "#go_hero/#go_level/layout/#txt_lvHead")
	slot0._txtLevel = gohelper.findChildText(slot0.go, "#go_hero/#go_level/layout/#txt_level")
	slot0._rareIcon = gohelper.findChildImage(slot0.go, "#go_hero/rare")
	slot0._clickCb = nil
	slot0._clickCbObj = nil
	slot0._btnClick = nil

	slot0:isShowEmptyWhenNoneHero(true)
	slot0:updateIsEmpty()
end

function slot0.addClickListener(slot0, slot1, slot2)
	slot0._clickCb = slot1
	slot0._clickCbObj = slot2

	if not slot0._btnClick then
		slot0._btnClick = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	end

	slot0._btnClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0._onItemClick(slot0)
	if slot0._clickCb then
		if slot0._clickCbObj then
			slot0._clickCb(slot0._clickCbObj, slot0._mo)
		else
			slot0._clickCb(slot0._mo)
		end
	end
end

function slot0.removeClickListener(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end

	slot0._clickCb = nil
	slot0._clickCbObj = nil
end

function slot0.getIsHasHero(slot0)
	slot1 = slot0._mo and slot0._mo.config
	slot2 = slot1 and slot1.id

	return slot2 and slot2 ~= 0
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.trans, slot1, slot1, slot1)
end

function slot0.setAnchor(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.trans, slot1, slot2)
end

function slot0.setIsBalance(slot0, slot1)
	slot2 = slot1 and "#81abe5" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(slot0._rankIcon, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLvHead, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtLevel, slot2)
end

function slot0.isShowEmptyWhenNoneHero(slot0, slot1)
	slot0._isShowEmptyWhenNoneHero = slot1

	if not slot0:getIsHasHero() then
		gohelper.setActive(slot0._goEmpty, slot1)
	else
		gohelper.setActive(slot0._goEmpty, false)
	end
end

function slot0.isShowBgFrame(slot0, slot1)
	gohelper.setActive(slot0._goBgFrame, slot1)
end

function slot0.isShowLevel(slot0, slot1)
	gohelper.setActive(slot0._goLevel, slot1)
end

function slot0.isShowRare(slot0, slot1)
	gohelper.setActive(slot0._rareIcon.gameObject, slot1)
end

function slot0.isShowCareer(slot0, slot1)
	gohelper.setActive(slot0._careerIcon.gameObject, slot1)
end

function slot0.onUpdateHeroId(slot0, slot1, slot2)
	if not HeroConfig.instance:getHeroCO(slot1) then
		return
	end

	slot4 = HeroMo.New()

	slot4:init({
		heroId = slot1,
		skin = slot2 or slot3.skinId
	}, slot3)
	slot0:onUpdateMO(slot4)
end

function slot0.onUpdateMO(slot0, slot1)
	if not (slot1 and slot1.config) then
		slot0:updateIsEmpty()

		return
	end

	slot0._mo = slot1

	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot2.career))

	if not SkinConfig.instance:getSkinCo(slot0._mo.skin) then
		logError(string.format("CommonHeroIconNew:onUpdateMO error, skinConfig is nil, skinId: %s", slot4))

		return
	end

	slot0._heroIcon:LoadImage(ResUrl.getRoomHeadIcon(slot5.headIcon))

	slot7, slot8 = HeroConfig.instance:getShowLevel(slot0._mo.level)

	if slot8 and slot8 > 1 then
		UISpriteSetMgr.instance:setCommonSprite(slot0._rankIcon, "dongxi_xiao_" .. slot8 - 1)
	else
		gohelper.setActive(slot0._rankIcon.gameObject, false)
	end

	slot0._txtLevel.text = slot7

	UISpriteSetMgr.instance:setCommonSprite(slot0._rareIcon, "equipbar" .. CharacterEnum.Color[slot2.rare])
	slot0:updateIsEmpty()
end

function slot0.updateIsEmpty(slot0)
	if slot0:getIsHasHero() then
		gohelper.setActive(slot0._goHero, true)
		gohelper.setActive(slot0._goEmpty, false)
	else
		gohelper.setActive(slot0._goHero, false)
		gohelper.setActive(slot0._goEmpty, slot0._isShowEmptyWhenNoneHero)
	end
end

function slot0.onDestroy(slot0)
	slot0._heroIcon:UnLoadImage()
	slot0:isShowEmptyWhenNoneHero(true)
end

return slot0
