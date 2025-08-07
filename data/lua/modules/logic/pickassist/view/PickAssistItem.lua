module("modules.logic.pickassist.view.PickAssistItem", package.seeall)

local var_0_0 = class("PickAssistItem", ListScrollCellExtend)

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

	if not arg_4_0:_checkClick() then
		return
	end

	local var_4_0 = PickAssistListModel.instance:isHeroSelected(arg_4_0._mo)

	PickAssistController.instance:setHeroSelect(arg_4_0._mo, not var_4_0)
end

function var_0_0._checkClick(arg_5_0)
	return true
end

function var_0_0._onHeroDetailClick(arg_6_0)
	CharacterBackpackCardListModel.instance:clearCardList()
	CharacterController.instance:openCharacterView(arg_6_0._mo.heroMO)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_7_0._goplayericon)

	arg_7_0._playericon:setEnableClick(false)
	arg_7_0._playericon:setShowLevel(true)
	arg_7_0._playericon:setPos("_golevel", 0, -36)
	arg_7_0._playericon:setPos("_txtlevel", -25, -4)

	local var_7_0 = arg_7_0._playericon:getLevelBg()

	UISpriteSetMgr.instance:setSeason123Sprite(var_7_0, "v1a7_season_img_namebg", true)

	arg_7_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_7_0._heroGOParent)

	arg_7_0._heroItem:addClickListener(arg_7_0._onHeroItemClick, arg_7_0)
	arg_7_0:initHeroItem()
end

function var_0_0.initHeroItem(arg_8_0)
	local var_8_0 = arg_8_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	if var_8_0 then
		var_8_0.enabled = false
	end

	arg_8_0._heroItem:setStyle_RougePickAssist()
	arg_8_0._heroItem:setSelect(false)
	arg_8_0._heroItem:isShowSeasonMask(true)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	local var_9_0 = arg_9_0._mo:getPlayerInfo()

	arg_9_0._playericon:onUpdateMO(var_9_0)

	arg_9_0._txtplayerName.text = var_9_0.name

	local var_9_1 = SocialModel.instance:isMyFriendByUserId(var_9_0.userId)

	gohelper.setActive(arg_9_0._goFriend, var_9_1)

	local var_9_2 = arg_9_0._mo.heroMO

	arg_9_0._heroItem:onUpdateMO(var_9_2)
	arg_9_0._heroItem:setNewShow(false)

	local var_9_3
	local var_9_4 = arg_9_0._mo.assistMO

	if var_9_4 then
		local var_9_5 = var_9_4.level
		local var_9_6 = var_9_4.balanceLevel

		if var_9_6 and var_9_5 ~= var_9_6 then
			var_9_3 = var_9_6
		end
	end

	if var_9_3 then
		arg_9_0._heroItem:setBalanceLv(var_9_3)
	end

	local var_9_7 = PickAssistListModel.instance:isHeroSelected(arg_9_0._mo)

	arg_9_0:setSelected(var_9_7)
end

function var_0_0.setSelected(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0.goSelected, arg_10_1)
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0._heroItem then
		arg_11_0._heroItem:onDestroy()

		arg_11_0._heroItem = nil
	end
end

function var_0_0.getAnimator(arg_12_0)
	return arg_12_0._animator
end

return var_0_0
