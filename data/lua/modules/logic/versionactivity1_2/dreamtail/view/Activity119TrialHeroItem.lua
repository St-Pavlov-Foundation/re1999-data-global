module("modules.logic.versionactivity1_2.dreamtail.view.Activity119TrialHeroItem", package.seeall)

slot0 = class("Activity119TrialHeroItem")

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0.index = slot2

	slot0:onInitView()
	slot0:addEvents()
end

function slot0.onInitView(slot0)
	slot0._btn = gohelper.findButtonWithAudio(slot0.go)
	slot0._quality = gohelper.findChildImage(slot0.go, "quality")
	slot0._career = gohelper.findChildImage(slot0.go, "career")
	slot0._icon = gohelper.findChildSingleImage(slot0.go, "mask/icon")
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0.onClickHero, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0.updateMO(slot0)
	slot1 = HeroGroupTrialModel.instance:getByIndex(slot0.index)
	slot0._mo = slot1

	slot0._icon:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot1.config.skinId).headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._quality, "bgequip" .. tostring(ItemEnum.Color[slot1.config.rare]))
	UISpriteSetMgr.instance:setCommonSprite(slot0._career, "lssx_" .. tostring(slot1.config.career))
end

function slot0.onClickHero(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesgo)
	CharacterController.instance:openCharacterView(slot0._mo, HeroGroupTrialModel.instance:getList())
end

function slot0.dispose(slot0)
	slot0:removeEvents()

	slot0.go = nil
	slot0.index = nil
	slot0._quality = nil

	slot0._icon:UnLoadImage()

	slot0._icon = nil
end

return slot0
