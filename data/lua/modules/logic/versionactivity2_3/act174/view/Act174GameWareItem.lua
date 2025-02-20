module("modules.logic.versionactivity2_3.act174.view.Act174GameWareItem", package.seeall)

slot0 = class("Act174GameWareItem", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.wareHouseView = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goRole = gohelper.findChild(slot1, "role")
	slot0.heroRare = gohelper.findChildImage(slot1, "role/rare")
	slot0.heroIcon = gohelper.findChildSingleImage(slot1, "role/heroicon")
	slot0.heroCareer = gohelper.findChildImage(slot1, "role/career")
	slot0.txtName = gohelper.findChildText(slot1, "role/name")
	slot0.goNewRole = gohelper.findChild(slot1, "role/#new")
	slot0.goCollection = gohelper.findChild(slot1, "collection")
	slot0.collectionRare = gohelper.findChildImage(slot1, "collection/rare")
	slot0.collectionIcon = gohelper.findChildSingleImage(slot1, "collection/collectionicon")
	slot0.goNewCollection = gohelper.findChild(slot1, "collection/#new")
	slot0.goSelect = gohelper.findChild(slot1, "go_select")
	slot0.goHeroTip = gohelper.findChild(slot1, "go_select/txt_equiprole")
	slot0.goCollectionTip = gohelper.findChild(slot1, "go_select/txt_equipcollection")
	slot0.goNew = gohelper.findChild(slot1, "go_new")
	slot0.click = gohelper.findChildClickWithAudio(slot1, "btn_click", AudioEnum.Act174.play_artificial_ui_carddisappear)
	slot0.longClick = SLFramework.UGUI.UILongPressListener.Get(gohelper.findChild(slot1, "btn_click"))

	slot0.longClick:SetLongPressTime({
		0.5,
		99999
	})
end

function slot0.addEventListeners(slot0)
	slot0.click:AddClickListener(slot0.clickItem, slot0)
	slot0.click:AddClickDownListener(slot0.onClickDown, slot0)
	slot0.longClick:AddLongPressListener(slot0.onLongPress, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0.click:RemoveClickListener()
	slot0.click:RemoveClickDownListener()
	slot0.longClick:RemoveLongPressListener()
end

function slot0.onDestroy(slot0)
	slot0.heroIcon:UnLoadImage()
	slot0.collectionIcon:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.newAnimEnd, slot0)
end

function slot0.setIndex(slot0, slot1)
	slot0.index = slot1
end

function slot0.setData(slot0, slot1, slot2)
	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.wareData = slot1
	slot0.wareType = slot2

	if slot0.wareType == Activity174Enum.WareType.Hero then
		slot0.config = lua_activity174_role.configDict[slot1.id]

		slot0.heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot0.config.skinId))
		UISpriteSetMgr.instance:setCommonSprite(slot0.heroRare, "bgequip" .. tostring(CharacterEnum.Color[slot0.config.rare]))
		UISpriteSetMgr.instance:setCommonSprite(slot0.heroCareer, "lssx_" .. slot0.config.career)

		slot0.txtName.text = slot0.config.name
	elseif slot0.wareType == Activity174Enum.WareType.Collection then
		slot0.config = lua_activity174_collection.configDict[slot3]

		slot0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot0.config.icon))
		UISpriteSetMgr.instance:setAct174Sprite(slot0.collectionRare, "act174_propitembg_" .. slot0.config.rare)
	end

	gohelper.setActive(slot0.goRole, slot0.wareType == Activity174Enum.WareType.Hero)
	gohelper.setActive(slot0.goCollection, slot0.wareType == Activity174Enum.WareType.Collection)
	slot0:refreshSelect()
	gohelper.setActive(slot0.go, true)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.SwitchShopTeam, slot0.refreshSelect, slot0)
	slot0:setNew(false)
end

function slot0.refreshSelect(slot0)
	if slot0.wareHouseView._goEditTeam.activeInHierarchy then
		gohelper.setActive(slot0.goSelect, slot0.wareData.isEquip == 1)
		gohelper.setActive(slot0.goHeroTip, slot0.wareType == Activity174Enum.WareType.Hero)
		gohelper.setActive(slot0.goCollectionTip, slot0.wareType == Activity174Enum.WareType.Collection)
	else
		gohelper.setActive(slot0.goSelect, false)
	end
end

function slot0.setNew(slot0, slot1)
	gohelper.setActive(slot0.goNew, slot1)
end

function slot0.playNew(slot0)
	if slot0.wareType == Activity174Enum.WareType.Hero then
		gohelper.setActive(slot0.goNewRole, true)
	else
		gohelper.setActive(slot0.goNewCollection, true)
	end

	TaskDispatcher.runDelay(slot0.newAnimEnd, slot0, 0.5)
end

function slot0.newAnimEnd(slot0)
	gohelper.setActive(slot0.goNewRole, false)
	gohelper.setActive(slot0.goNewCollection, false)
end

function slot0.clickItem(slot0)
	if slot0.wareHouseView._goEditTeam.activeInHierarchy then
		slot0:deleteNewSign()

		if slot0.wareData.isEquip == 0 then
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemInstall, slot0.wareData.id)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemRemove, slot0.wareData.id)
		end
	end
end

function slot0.onClickDown(slot0)
	if slot0.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	slot0:deleteNewSign()
	Activity174Controller.instance:openItemTipView({
		type = slot0.wareType,
		co = slot0.config,
		pos = Vector2.New(-300, 0),
		showMask = true
	})
	AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_ui_carddisappear)
end

function slot0.onLongPress(slot0)
	if not slot0.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	slot0:deleteNewSign()
	Activity174Controller.instance:openItemTipView({
		type = slot0.wareType,
		co = slot0.config,
		pos = Vector2.New(-300, 0),
		showMask = true
	})
end

function slot0.deleteNewSign(slot0)
	if slot0.goNew.activeInHierarchy then
		slot0:setNew(false)
		slot0.wareHouseView.wareHouseMo:deleteNewSign(slot0.wareType, slot0.wareData.id)
	end
end

return slot0
