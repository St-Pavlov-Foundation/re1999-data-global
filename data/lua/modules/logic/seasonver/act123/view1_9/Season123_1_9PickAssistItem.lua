module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickAssistItem", package.seeall)

slot0 = class("Season123_1_9PickAssistItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._heroGOParent = gohelper.findChild(slot0.viewGO, "heroInfo/hero")
	slot0._btnHeroDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "heroInfo/tag/btn_detail")
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "playerInfo/#go_playericon")
	slot0._txtplayerName = gohelper.findChildText(slot0.viewGO, "playerInfo/#txt_playerName")
	slot0._goFriend = gohelper.findChild(slot0.viewGO, "playerInfo/#go_friends")
	slot0.goSelected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnHeroDetail:AddClickListener(slot0._onHeroDetailClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnHeroDetail:RemoveClickListener()
end

function slot0._onHeroItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	Season123PickAssistController.instance:setHeroSelect(slot0._mo, not Season123PickAssistListModel.instance:isHeroSelected(slot0._mo))
end

function slot0._onHeroDetailClick(slot0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterController.instance:openCharacterView(slot0._mo.heroMO)
end

function slot0._editableInitView(slot0)
	slot0._playericon = IconMgr.instance:getCommonPlayerIcon(slot0._goplayericon)

	slot0._playericon:setEnableClick(false)
	slot0._playericon:setShowLevel(true)
	slot0._playericon:setPos("_golevel", 0, -36)
	slot0._playericon:setPos("_txtlevel", -25, -4)
	UISpriteSetMgr.instance:setSeason123Sprite(slot0._playericon:getLevelBg(), "v1a7_season_img_namebg", true)

	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:addClickListener(slot0._onHeroItemClick, slot0)
	slot0:initHeroItem()
end

function slot0.initHeroItem(slot0)
	if slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator)) then
		slot1.enabled = false
	end

	slot0._heroItem:_setTxtPos("_rankObj", 2, -37)
	slot0._heroItem:_setTxtPos("_lvObj", 1.7, 178.6)
	slot0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 153.4)
	slot0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 124.3)
	slot0._heroItem:_setTxtPos("_goexskill", 1.7, -170)
	slot0._heroItem:_setTranScale("_rankObj", 0.2, 0.2)
	slot0._heroItem:setSelect(false)
	slot0._heroItem:isShowSeasonMask(true)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot0._mo:getPlayerInfo()

	slot0._playericon:onUpdateMO(slot2)

	slot0._txtplayerName.text = slot2.name

	gohelper.setActive(slot0._goFriend, SocialModel.instance:isMyFriendByUserId(slot2.userId))
	slot0._heroItem:onUpdateMO(slot0._mo.heroMO)
	slot0._heroItem:setNewShow(false)

	slot5 = nil

	if slot0._mo.assistMO then
		if slot6.balanceLevel and slot6.level ~= slot8 then
			slot5 = slot8
		end
	end

	if slot5 then
		slot0._heroItem:setBalanceLv(slot5)
	end

	slot0:setSelected(Season123PickAssistListModel.instance:isHeroSelected(slot0._mo))
end

function slot0.setSelected(slot0, slot1)
	gohelper.setActive(slot0.goSelected, slot1)
end

function slot0.onDestroy(slot0)
	if slot0._heroItem then
		slot0._heroItem:onDestroy()

		slot0._heroItem = nil
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
