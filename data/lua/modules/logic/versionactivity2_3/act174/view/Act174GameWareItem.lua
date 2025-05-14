module("modules.logic.versionactivity2_3.act174.view.Act174GameWareItem", package.seeall)

local var_0_0 = class("Act174GameWareItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.wareHouseView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goRole = gohelper.findChild(arg_2_1, "role")
	arg_2_0.heroRare = gohelper.findChildImage(arg_2_1, "role/rare")
	arg_2_0.heroIcon = gohelper.findChildSingleImage(arg_2_1, "role/heroicon")
	arg_2_0.heroCareer = gohelper.findChildImage(arg_2_1, "role/career")
	arg_2_0.txtName = gohelper.findChildText(arg_2_1, "role/name")
	arg_2_0.goNewRole = gohelper.findChild(arg_2_1, "role/#new")
	arg_2_0.goCollection = gohelper.findChild(arg_2_1, "collection")
	arg_2_0.collectionRare = gohelper.findChildImage(arg_2_1, "collection/rare")
	arg_2_0.collectionIcon = gohelper.findChildSingleImage(arg_2_1, "collection/collectionicon")
	arg_2_0.goNewCollection = gohelper.findChild(arg_2_1, "collection/#new")
	arg_2_0.goSelect = gohelper.findChild(arg_2_1, "go_select")
	arg_2_0.goHeroTip = gohelper.findChild(arg_2_1, "go_select/txt_equiprole")
	arg_2_0.goCollectionTip = gohelper.findChild(arg_2_1, "go_select/txt_equipcollection")
	arg_2_0.goNew = gohelper.findChild(arg_2_1, "go_new")
	arg_2_0.click = gohelper.findChildClickWithAudio(arg_2_1, "btn_click", AudioEnum.Act174.play_artificial_ui_carddisappear)

	local var_2_0 = gohelper.findChild(arg_2_1, "btn_click")

	arg_2_0.longClick = SLFramework.UGUI.UILongPressListener.Get(var_2_0)

	arg_2_0.longClick:SetLongPressTime({
		0.5,
		99999
	})
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.click:AddClickListener(arg_3_0.clickItem, arg_3_0)
	arg_3_0.click:AddClickDownListener(arg_3_0.onClickDown, arg_3_0)
	arg_3_0.longClick:AddLongPressListener(arg_3_0.onLongPress, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0.click:RemoveClickListener()
	arg_4_0.click:RemoveClickDownListener()
	arg_4_0.longClick:RemoveLongPressListener()
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0.heroIcon:UnLoadImage()
	arg_5_0.collectionIcon:UnLoadImage()
	TaskDispatcher.cancelTask(arg_5_0.newAnimEnd, arg_5_0)
end

function var_0_0.setIndex(arg_6_0, arg_6_1)
	arg_6_0.index = arg_6_1
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_1 then
		gohelper.setActive(arg_7_0.go, false)

		return
	end

	arg_7_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	arg_7_0.wareData = arg_7_1
	arg_7_0.wareType = arg_7_2

	local var_7_0 = arg_7_1.id

	if arg_7_0.wareType == Activity174Enum.WareType.Hero then
		arg_7_0.config = lua_activity174_role.configDict[var_7_0]

		arg_7_0.heroIcon:LoadImage(ResUrl.getHeadIconSmall(arg_7_0.config.skinId))
		UISpriteSetMgr.instance:setCommonSprite(arg_7_0.heroRare, "bgequip" .. tostring(CharacterEnum.Color[arg_7_0.config.rare]))
		UISpriteSetMgr.instance:setCommonSprite(arg_7_0.heroCareer, "lssx_" .. arg_7_0.config.career)

		arg_7_0.txtName.text = arg_7_0.config.name
	elseif arg_7_0.wareType == Activity174Enum.WareType.Collection then
		arg_7_0.config = lua_activity174_collection.configDict[var_7_0]

		arg_7_0.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(arg_7_0.config.icon))
		UISpriteSetMgr.instance:setAct174Sprite(arg_7_0.collectionRare, "act174_propitembg_" .. arg_7_0.config.rare)
	end

	gohelper.setActive(arg_7_0.goRole, arg_7_0.wareType == Activity174Enum.WareType.Hero)
	gohelper.setActive(arg_7_0.goCollection, arg_7_0.wareType == Activity174Enum.WareType.Collection)
	arg_7_0:refreshSelect()
	gohelper.setActive(arg_7_0.go, true)
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.SwitchShopTeam, arg_7_0.refreshSelect, arg_7_0)
	arg_7_0:setNew(false)
end

function var_0_0.refreshSelect(arg_8_0)
	if arg_8_0.wareHouseView._goEditTeam.activeInHierarchy then
		gohelper.setActive(arg_8_0.goSelect, arg_8_0.wareData.isEquip == 1)
		gohelper.setActive(arg_8_0.goHeroTip, arg_8_0.wareType == Activity174Enum.WareType.Hero)
		gohelper.setActive(arg_8_0.goCollectionTip, arg_8_0.wareType == Activity174Enum.WareType.Collection)
	else
		gohelper.setActive(arg_8_0.goSelect, false)
	end
end

function var_0_0.setNew(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.goNew, arg_9_1)
end

function var_0_0.playNew(arg_10_0)
	if arg_10_0.wareType == Activity174Enum.WareType.Hero then
		gohelper.setActive(arg_10_0.goNewRole, true)
	else
		gohelper.setActive(arg_10_0.goNewCollection, true)
	end

	TaskDispatcher.runDelay(arg_10_0.newAnimEnd, arg_10_0, 0.5)
end

function var_0_0.newAnimEnd(arg_11_0)
	gohelper.setActive(arg_11_0.goNewRole, false)
	gohelper.setActive(arg_11_0.goNewCollection, false)
end

function var_0_0.clickItem(arg_12_0)
	if arg_12_0.wareHouseView._goEditTeam.activeInHierarchy then
		arg_12_0:deleteNewSign()

		if arg_12_0.wareData.isEquip == 0 then
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemInstall, arg_12_0.wareData.id)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemRemove, arg_12_0.wareData.id)
		end
	end
end

function var_0_0.onClickDown(arg_13_0)
	if arg_13_0.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	arg_13_0:deleteNewSign()

	local var_13_0 = {
		type = arg_13_0.wareType,
		co = arg_13_0.config,
		pos = Vector2.New(-300, 0)
	}

	var_13_0.showMask = true

	Activity174Controller.instance:openItemTipView(var_13_0)
	AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_ui_carddisappear)
end

function var_0_0.onLongPress(arg_14_0)
	if not arg_14_0.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	arg_14_0:deleteNewSign()

	local var_14_0 = {
		type = arg_14_0.wareType,
		co = arg_14_0.config,
		pos = Vector2.New(-300, 0)
	}

	var_14_0.showMask = true

	Activity174Controller.instance:openItemTipView(var_14_0)
end

function var_0_0.deleteNewSign(arg_15_0)
	if arg_15_0.goNew.activeInHierarchy then
		arg_15_0:setNew(false)
		arg_15_0.wareHouseView.wareHouseMo:deleteNewSign(arg_15_0.wareType, arg_15_0.wareData.id)
	end
end

return var_0_0
