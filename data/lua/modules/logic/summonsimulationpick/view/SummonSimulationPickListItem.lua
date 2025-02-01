module("modules.logic.summonsimulationpick.view.SummonSimulationPickListItem", package.seeall)

slot0 = class("SummonSimulationPickListItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._simageHeroIcon = gohelper.findChildSingleImage(slot0.go, "heroicon/#simage_icon")
	slot0._imagecareer = gohelper.findChildImage(slot0.go, "#image_career")
	slot0._imagerare = gohelper.findChildImage(slot0.go, "#image_rare")
	slot0._txtname = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.go, "#txt_nameen")
	slot0._btnclick = gohelper.findChildButton(slot0.go, "")
	slot0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0.go)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0)
	slot0._btnclick:AddClickListener(slot0._onbtnclick, slot0)

	slot0._gonew = gohelper.findChild(slot0.go, "#go_new")
end

function slot0._onLongClickItem(slot0)
	if not slot0._heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = slot0._heroId
	})
end

function slot0._onbtnclick(slot0)
	if not slot0._selectType then
		return
	end

	SummonSimulationPickController.instance:dispatchEvent(SummonSimulationEvent.onSelectItem, slot0._selectType)
end

function slot0.removeEvent(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnLongPress:RemoveLongPressListener()
end

function slot0.removeEventListeners(slot0)
	slot0._btnLongPress:RemoveLongPressListener()
end

function slot0.setData(slot0, slot1, slot2)
	slot0._heroId = slot1
	slot0._selectType = slot2

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot2 = HeroConfig.instance:getHeroCO(slot0._heroId)

	slot0._simageHeroIcon:LoadImage(ResUrl.getHeadIconMiddle(tostring(SkinConfig.instance:getSkinCo(slot2.skinId).largeIcon)))

	slot0._txtname.text = slot2.name
	slot0._txtnameen.text = slot2.nameEng

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot2.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bg_pz00" .. tostring(CharacterEnum.Color[slot2.rare]))

	if not slot0.newDot then
		slot0.newDot = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gonew, CommonRedDotIconNoEvent)

		slot0.newDot:setShowType(RedDotEnum.Style.Green)
		slot0.newDot:setCheckShowRedDotFunc(slot0.refreshDot, slot0)
	else
		slot0.newDot:refreshRedDot()
	end

	gohelper.setActive(slot0._gonew, true)
end

function slot0.refreshDot(slot0, slot1)
	return not HeroModel.instance:getByHeroId(slot0._heroId)
end

function slot0.onDestroy(slot0)
	slot0._btnLongPress:RemoveLongPressListener()
	slot0._btnclick:RemoveClickListener()
end

return slot0
