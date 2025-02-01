module("modules.ugui.icon.common.CommonHeroIcon", package.seeall)

slot0 = class("CommonHeroIcon", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._btnClick = nil
	slot0._lvTxt = gohelper.findChildText(slot1, "lvltxt")
	slot0._starObj = gohelper.findChild(slot1, "starobj")
	slot0._maskObj = gohelper.findChild(slot1, "mask")
	slot0._breakObj = gohelper.findChild(slot1, "breakobj")
	slot0._rareObj = gohelper.findChild(slot1, "rareobj")
	slot0._cardIcon = gohelper.findChildSingleImage(slot1, "charactericon")
	slot0._careerIcon = gohelper.findChildImage(slot1, "career")
	slot0._careerFrame = gohelper.findChildImage(slot1, "frame")
	slot0._rareIcon = gohelper.findChildImage(slot1, "cardrare")
	slot0._isShowStar = true
	slot0._isShowBreak = true
	slot0._isShowRate = true

	slot0:_initObj()
end

function slot0.setLvVisible(slot0, slot1)
	gohelper.setActive(slot0._lvTxt.gameObject, slot1)
end

function slot0.setMaskVisible(slot0, slot1)
	gohelper.setActive(slot0._maskObj, slot1)
end

function slot0.isShowStar(slot0, slot1)
	slot0._isShowStar = slot1

	gohelper.setActive(slot0._starObj, slot1)
end

function slot0.isShowBreak(slot0, slot1)
	slot0._isShowBreak = slot1

	gohelper.setActive(slot0._breakObj, slot1)
end

function slot0.isShowRare(slot0, slot1)
	slot0._isShowRare = slot1

	gohelper.setActive(slot0._rareObj, slot1)
end

function slot0.isShowRareIcon(slot0, slot1)
	slot0._isShowRareIcon = slot1

	gohelper.setActive(slot0._rareIcon.gameObject, slot1)
end

function slot0.isShowCareerIcon(slot0, slot1)
	slot0._isShowCareer = slot1

	gohelper.setActive(slot0._careerIcon.gameObject, slot1)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.tr, slot1, slot1, slot1)
end

function slot0.setAnchor(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.tr, slot1, slot2)
end

function slot0._initObj(slot0)
	slot0._rareGos = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot0._rareGos[slot4] = gohelper.findChild(slot0._rareObj, "rare" .. tostring(slot4))
	end

	slot0._starImgs = slot0:getUserDataTb_()

	for slot4 = 1, 5 do
		slot0._starImgs[slot4] = gohelper.findChildImage(slot0._starObj, "star" .. tostring(slot4))
	end

	slot0._breakImgs = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot0._breakImgs[slot4] = gohelper.findChildImage(slot0._breakObj, "break" .. tostring(slot4))
	end
end

function slot0.addClickListener(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2

	if not slot0._btnClick then
		slot0._btnClick = SLFramework.UGUI.UIClickListener.Get(slot0.go)
	end

	slot0._btnClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeClickListener(slot0)
	slot0._callback = nil
	slot0._callbackObj = nil

	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end
end

function slot0.onUpdateHeroId(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot1)

	slot0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot2.skinId).retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot2.career))
	slot0:_fillRareContent(CharacterEnum.Star[slot2.rare])
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._lvTxt.text = HeroConfig.instance:getShowLevel(slot1.level)

	slot0:_fillRareContent(CharacterEnum.Star[slot1.config.rare])
	slot0:_fillBreakContent(slot1.exSkillLevel)
	slot0:_fillStarContent(slot1.rank)
	slot0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(HeroModel.instance:getByHeroId(slot1.heroId).skin).retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot1.config.career))
end

function slot0.updateMonster(slot0, slot1)
	slot0._monsterConfig = slot1
	slot0._lvTxt.text = HeroConfig.instance:getShowLevel(slot1.level)

	slot0:_fillRareContent(1)
	gohelper.setActive(slot0._breakObj, false)
	gohelper.setActive(slot0._starObj, false)
	slot0._cardIcon:LoadImage(ResUrl.getHeadIconSmall(FightConfig.instance:getSkinCO(slot1.skinId).retangleIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._careerIcon, "lssx_" .. tostring(slot1.career))
end

function slot0._fillRareContent(slot0, slot1)
	if slot0._rareObj then
		UISpriteSetMgr.instance:setCommonSprite(slot0._rareIcon, "bp_quality_0" .. tostring(slot1 and math.max(slot1, 1) or 1))

		if slot0._isShowRare then
			for slot5 = 1, 6 do
				gohelper.setActive(slot0._rareGos[slot5], slot5 <= slot1)
			end
		end

		gohelper.setActive(slot0._rareObj, slot0._isShowRare)
	end
end

function slot0._fillBreakContent(slot0, slot1)
	slot1 = slot1 and math.max(slot1, 1) or 1

	if slot0._breakObj then
		if slot0._isShowBreak then
			for slot5 = 1, 6 do
				if slot5 <= slot1 then
					SLFramework.UGUI.GuiHelper.SetColor(slot0._breakImgs[slot5], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(slot0._breakImgs[slot5], "#626467")
				end
			end
		end

		gohelper.setActive(slot0._breakObj, slot0._isShowBreak)
	end
end

function slot0._fillStarContent(slot0, slot1)
	slot1 = slot1 and math.max(slot1, 1) or 1

	if slot0._starObj then
		if slot0._isShowStar then
			for slot5 = 1, 5 do
				if slot5 <= slot1 then
					SLFramework.UGUI.GuiHelper.SetColor(slot0._starImgs[slot5], "#d7a93d")
				else
					SLFramework.UGUI.GuiHelper.SetColor(slot0._starImgs[slot5], "#626467")
				end
			end
		end

		gohelper.setActive(slot0._starObj, slot0._isShowStar)
	end
end

function slot0._onItemClick(slot0)
	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot0._mo)
		else
			slot0._callback(slot0._mo)
		end
	end
end

function slot0.onDestroy(slot0)
	slot0._cardIcon:UnLoadImage()
end

return slot0
