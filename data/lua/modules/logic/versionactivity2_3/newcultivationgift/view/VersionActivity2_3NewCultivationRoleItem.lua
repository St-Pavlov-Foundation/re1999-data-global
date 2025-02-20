module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationRoleItem", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationRoleItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._btnClick = gohelper.findChildButton(slot0._go, "heroicon")
	slot0._goSelected = gohelper.findChild(slot0._go, "#go_select")
	slot0._imagerare = gohelper.findChildImage(slot0._go, "rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "heroicon")

	slot0:addEvents()
end

function slot0.setClickCallBack(slot0, slot1, slot2)
	slot0._callBack = slot1
	slot0._callBackObj = slot2
end

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0.onClickSelf, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()

	slot0._callBack = nil
	slot0._callBackObj = nil
end

function slot0._onLongClickItem(slot0)
	if not slot0._config then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot0._config.heroId
	})
end

function slot0.onClickSelf(slot0)
	logNormal("onClickChoice id = " .. tostring(slot0._config.heroId))

	if slot0._callBack and slot0._callBackObj then
		slot0._callBack(slot0._callBackObj, slot0._config.heroId)
	end
end

function slot0.setData(slot0, slot1)
	slot0._config = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not HeroConfig.instance:getHeroCO(slot0._config.heroId) then
		logError("VersionActivity2_3NewCultivationRoleItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(slot0._config.id))

		return
	end

	slot0:refreshBaseInfo(slot1)
end

function slot0.refreshBaseInfo(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(slot1.skinId) then
		logError("VersionActivity2_3NewCultivationRoleItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(slot1.skinId))

		return
	end

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot2.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[slot1.rare]))
end

function slot0.refreshSelect(slot0, slot1)
	gohelper.setActive(slot0._goSelected, slot0._config.heroId == slot1)
end

function slot0.onDestroy(slot0)
	if not slot0._isDisposed then
		slot0._simageicon:UnLoadImage()
		slot0:removeEvents()

		slot0._callBack = nil
		slot0._isDisposed = true
	end
end

return slot0
