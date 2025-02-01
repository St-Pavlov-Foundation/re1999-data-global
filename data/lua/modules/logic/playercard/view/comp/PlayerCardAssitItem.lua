module("modules.logic.playercard.view.comp.PlayerCardAssitItem", package.seeall)

slot0 = class("PlayerCardAssitItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.goEmpty = gohelper.findChild(slot1, "empty")
	slot0.goRole = gohelper.findChild(slot1, "#go_roleitem")
	slot0.simageHead = gohelper.findChildSingleImage(slot1, "#go_roleitem/rolehead")
	slot0.imageCareer = gohelper.findChildImage(slot1, "#go_roleitem/career")
	slot0.imageLevel = gohelper.findChildImage(slot1, "#go_roleitem/layout/level")
	slot0.txtLevel = gohelper.findChildTextMesh(slot1, "#go_roleitem/layout/#txt_level")
	slot0.imagQuality = gohelper.findChildImage(slot1, "#go_roleitem/quality")
	slot0.goExskill = gohelper.findChild(slot1, "#go_exskill")
	slot0.imageExskill = gohelper.findChildImage(slot1, "#go_exskill/#image_exskill")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_clickarea")
	slot0.goSelectedEff = gohelper.findChild(slot1, "selected_eff")
end

function slot0.playSelelctEffect(slot0)
	gohelper.setActive(slot0.goSelectedEff, false)
	gohelper.setActive(slot0.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.info = slot1
	slot0.isPlayerSelf = slot2
	slot0.compType = slot3

	slot0:showcharacterinfo(slot1)
end

slot1 = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function slot0.showcharacterinfo(slot0, slot1)
	slot2 = slot1 and slot1 ~= 0 and slot1.heroId and slot1.heroId ~= "0" and slot1.heroId ~= 0

	gohelper.setActive(slot0.goEmpty, slot0.isPlayerSelf and not slot2)
	gohelper.setActive(slot0.goRole, slot2)

	if slot2 then
		if slot0.isPlayerSelf then
			slot1 = HeroModel.instance:getByHeroId(slot1.heroId)
		end

		slot0.simageHead:LoadImage(ResUrl.getHeadIconSmall(SkinConfig.instance:getSkinCo(slot1.skin).retangleIcon))

		slot5, slot6 = HeroConfig.instance:getShowLevel(slot1.level)

		UISpriteSetMgr.instance:setCommonSprite(slot0.imageCareer, string.format("lssx_%s", HeroConfig.instance:getHeroCO(slot1.heroId).career), true)

		if slot6 > 1 then
			UISpriteSetMgr.instance:setCommonSprite(slot0.imageLevel, string.format("dongxi_xiao_%s", slot6 - 1), true)
			gohelper.setActive(slot0.imageLevel, true)
		else
			gohelper.setActive(slot0.imageLevel, false)
		end

		slot0.txtLevel.text = slot5
		slot7 = slot1.exSkillLevel and uv0[slot1.exSkillLevel] or 0
		slot0.imageExskill.fillAmount = slot7

		gohelper.setActive(slot0.goExskill, slot7 > 0)
		UISpriteSetMgr.instance:setRoomSprite(slot0.imagQuality, "quality_" .. CharacterEnum.Color[slot3.rare])

		slot0.heroId = slot3.id
	else
		gohelper.setActive(slot0.goExskill, false)

		slot0.heroId = nil
	end

	if slot0.notIsFirst and slot0.heroId ~= slot0.tempHeroId then
		slot0:playSelelctEffect()
	end

	slot0.tempHeroId = slot0.heroId
	slot0.notIsFirst = true
end

function slot0.btnClickOnClick(slot0)
	if slot0.isPlayerSelf and slot0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.ShowCharacterView, {
			notRepeatUpdateAssistReward = true
		})
	end
end

function slot0.addEventListeners(slot0)
	slot0.btnClick:AddClickListener(slot0.btnClickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0.onDestroy(slot0)
	slot0.simageHead:UnLoadImage()
end

return slot0
