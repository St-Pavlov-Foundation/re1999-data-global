module("modules.logic.seasonver.act123.view2_1.Season123_2_1PickAssistItem", package.seeall)

local var_0_0 = class("Season123_2_1PickAssistItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_0.viewGO, "heroInfo/hero")
	arg_1_0._btnHeroDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "heroInfo/tag/btn_detail")
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "playerInfo/#go_playericon")
	arg_1_0._txtplayerName = gohelper.findChildText(arg_1_0.viewGO, "playerInfo/#txt_playerName")
	arg_1_0._goFriend = gohelper.findChild(arg_1_0.viewGO, "playerInfo/#go_friends")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnHeroDetail:AddClickListener(arg_2_0._onHeroDetailClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnHeroDetail:RemoveClickListener()
end

function var_0_0._onHeroItemClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_4_0 = Season123PickAssistListModel.instance:isHeroSelected(arg_4_0._mo)

	Season123PickAssistController.instance:setHeroSelect(arg_4_0._mo, not var_4_0)
end

function var_0_0._onHeroDetailClick(arg_5_0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterController.instance:openCharacterView(arg_5_0._mo.heroMO)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_6_0._goplayericon)

	arg_6_0._playericon:setEnableClick(false)
	arg_6_0._playericon:setShowLevel(true)
	arg_6_0._playericon:setPos("_golevel", 0, -36)
	arg_6_0._playericon:setPos("_txtlevel", -25, -4)

	local var_6_0 = arg_6_0._playericon:getLevelBg()

	UISpriteSetMgr.instance:setSeason123Sprite(var_6_0, "v1a7_season_img_namebg", true)

	arg_6_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_6_0._heroGOParent)

	arg_6_0._heroItem:addClickListener(arg_6_0._onHeroItemClick, arg_6_0)
	arg_6_0:initHeroItem()
end

function var_0_0.initHeroItem(arg_7_0)
	local var_7_0 = arg_7_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	if var_7_0 then
		var_7_0.enabled = false
	end

	arg_7_0._heroItem:setStyle_SeasonPickAssist()
	arg_7_0._heroItem:_setTranScale("_rankObj", 0.2, 0.2)
	arg_7_0._heroItem:setSelect(false)
	arg_7_0._heroItem:isShowSeasonMask(true)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	local var_8_0 = arg_8_0._mo:getPlayerInfo()

	arg_8_0._playericon:onUpdateMO(var_8_0)

	arg_8_0._txtplayerName.text = var_8_0.name

	local var_8_1 = SocialModel.instance:isMyFriendByUserId(var_8_0.userId)

	gohelper.setActive(arg_8_0._goFriend, var_8_1)

	local var_8_2 = arg_8_0._mo.heroMO

	arg_8_0._heroItem:onUpdateMO(var_8_2)
	arg_8_0._heroItem:setNewShow(false)

	local var_8_3
	local var_8_4 = arg_8_0._mo.assistMO

	if var_8_4 then
		local var_8_5 = var_8_4.level
		local var_8_6 = var_8_4.balanceLevel

		if var_8_6 and var_8_5 ~= var_8_6 then
			var_8_3 = var_8_6
		end
	end

	if var_8_3 then
		arg_8_0._heroItem:setBalanceLv(var_8_3)
	end

	local var_8_7 = Season123PickAssistListModel.instance:isHeroSelected(arg_8_0._mo)

	arg_8_0:setSelected(var_8_7)
end

function var_0_0.setSelected(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0.goSelected, arg_9_1)
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0._heroItem then
		arg_10_0._heroItem:onDestroy()

		arg_10_0._heroItem = nil
	end
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

return var_0_0
