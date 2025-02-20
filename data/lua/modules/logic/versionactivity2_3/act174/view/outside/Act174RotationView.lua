module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationView", package.seeall)

slot0 = class("Act174RotationView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroleitem = gohelper.findChild(slot0.viewGO, "right/scroll_rule/Viewport/go_content/role/#go_roleitem")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "right/scroll_rule/Viewport/go_content/collection/#go_collectionitem")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "right/scroll_rule/Viewport/go_content/buff/#go_buffitem")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.anim = gohelper.findChild(slot0.viewGO, "right"):GetComponent(gohelper.Type_Animator)
	slot0._txtRule2 = gohelper.findChildText(slot0.viewGO, "right/simage_rightbg/txt_rule2")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.actInfo = Activity174Model.instance:getActInfo()

	slot0:refreshSeason()
	slot0:initCharacterItem()
	slot0:initCollectionItem()
	slot0:initBuffItem()
end

function slot0.refreshSeason(slot0)
	for slot5, slot6 in ipairs(lua_activity174_season.configList) do
		if slot6.activityId == slot0.actId then
			-- Nothing
		end
	end

	if ({
		[slot6.season] = slot6
	})[slot0.actInfo.season + 1] and not string.nilorempty(slot3.openTime) then
		slot0._txtRule2.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_rotation_rule2"), GameUtil.getNum2Chinese(TimeUtil.secondsToDDHHMMSS(TimeUtil.stringToTimestamp(slot3.openTime) + ServerTime.clientToServerOffset() - ServerTime.now())))
	end

	gohelper.setActive(slot0._txtRule2, slot1[slot2 + 1])
end

function slot0.onClose(slot0)
	slot0:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.characterItemList) do
		slot5.heroIcon:UnLoadImage()
	end

	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5.collectionIcon:UnLoadImage()
	end

	for slot4, slot5 in ipairs(slot0.buffItemList) do
		slot5.buffIcon:UnLoadImage()
	end
end

function slot0.initCharacterItem(slot0)
	slot0.characterItemList = {}
	slot1 = slot0.actInfo:getRuleHeroCoList()
	slot5 = Activity174Helper.sortActivity174RoleCo

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0:getUserDataTb_()
		slot7.config = slot6
		slot8 = gohelper.cloneInPlace(slot0._goroleitem)

		slot0:addClickCb(gohelper.findButtonWithAudio(slot8), slot0.clickCharacterItem, slot0, slot5)

		slot7.heroIcon = gohelper.findChildSingleImage(slot8, "heroicon")
		slot7.goSelect = gohelper.findChild(slot8, "go_select")

		slot7.heroIcon:LoadImage(ResUrl.getHeadIconSmall(slot6.skinId))
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot8, "rare"), "bgequip" .. tostring(CharacterEnum.Color[slot6.rare]))

		slot0.characterItemList[slot5] = slot7
	end

	gohelper.setActive(slot0._goroleitem, false)
end

function slot0.clickCharacterItem(slot0, slot1)
	if slot0.characterItemList[slot1] == slot0.selectItem then
		slot0:closeTipView()
		slot0:refreshSelect()
	else
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Character,
			co = slot2.config,
			pos = Vector2.New(-470, 0)
		})
		slot0:refreshSelect(slot2)
	end
end

function slot0.initCollectionItem(slot0)
	slot0.collectionItemList = {}

	for slot5, slot6 in ipairs(slot0.actInfo:getRuleCollectionCoList()) do
		slot7 = slot0:getUserDataTb_()
		slot7.config = slot6
		slot8 = gohelper.cloneInPlace(slot0._gocollectionitem)

		slot0:addClickCb(gohelper.findButtonWithAudio(slot8), slot0.clickCollectionItem, slot0, slot5)

		slot7.collectionIcon = gohelper.findChildSingleImage(slot8, "collectionicon")
		slot7.goSelect = gohelper.findChild(slot8, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot8, "rare"), "act174_propitembg_" .. slot6.rare)
		slot7.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(slot6.icon))

		slot0.collectionItemList[slot5] = slot7
	end

	gohelper.setActive(slot0._gocollectionitem, false)
end

function slot0.clickCollectionItem(slot0, slot1)
	if slot0.collectionItemList[slot1] == slot0.selectItem then
		slot0:closeTipView()
		slot0:refreshSelect()
	else
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Collection,
			co = slot2.config,
			pos = Vector2.New(-300, 0)
		})
		slot0:refreshSelect(slot2)
	end
end

function slot0.initBuffItem(slot0)
	slot0.buffItemList = {}

	for slot5, slot6 in ipairs(slot0.actInfo:getRuleBuffCoList()) do
		slot7 = slot0:getUserDataTb_()
		slot7.config = slot6
		slot8 = gohelper.cloneInPlace(slot0._gobuffitem)

		slot0:addClickCb(gohelper.findButtonWithAudio(slot8), slot0.clickBuffItem, slot0, slot5)

		slot7.buffIcon = gohelper.findChildSingleImage(slot8, "bufficon")

		slot7.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(slot6.icon))

		slot7.goSelect = gohelper.findChild(slot8, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot8, "rare"), "act174_propitembg_3")

		slot0.buffItemList[slot5] = slot7
	end

	gohelper.setActive(slot0._gobuffitem, false)
end

function slot0.clickBuffItem(slot0, slot1)
	if slot0.buffItemList[slot1] == slot0.selectItem then
		slot0:closeTipView()
		slot0:refreshSelect()
	else
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Buff,
			co = slot2.config,
			pos = Vector2.New(-300, 0)
		})
		slot0:refreshSelect(slot2)
	end
end

function slot0.refreshSelect(slot0, slot1)
	if slot0.selectItem then
		gohelper.setActive(slot0.selectItem.goSelect, false)
	end

	if slot1 then
		gohelper.setActive(slot1.goSelect, true)
	end

	slot0.selectItem = slot1
end

function slot0.closeTipView(slot0)
	if ViewMgr.instance:isOpen(ViewName.Act174ItemTipView) then
		ViewMgr.instance:closeView(ViewName.Act174ItemTipView, false, true)
	end
end

return slot0
