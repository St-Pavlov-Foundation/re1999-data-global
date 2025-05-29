module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardItem", package.seeall)

local var_0_0 = class("XugoujiCardItem", ListScrollCellExtend)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji
local var_0_2 = "v2a6_xugouji_skillcard_selfback"
local var_0_3 = "v2a6_xugouji_skillcard_enemybackj"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#image_RoleBG")
	arg_1_0._goLock = gohelper.findChild(arg_1_0.viewGO, "#go_Locked")
	arg_1_0._goRoleBG = gohelper.findChild(arg_1_0.viewGO, "#image_RoleBG")
	arg_1_0._imageRoleBG = gohelper.findChildImage(arg_1_0.viewGO, "#image_RoleBG")
	arg_1_0._goCardIcon = gohelper.findChild(arg_1_0.viewGO, "#simage_SkillIcon")
	arg_1_0._imgCardIcon = gohelper.findChildImage(arg_1_0.viewGO, "#simage_SkillIcon")
	arg_1_0._goFlip = gohelper.findChild(arg_1_0.viewGO, "#go_Flip")
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_RoleSelected")
	arg_1_0._txtDebugLog = gohelper.findChildText(arg_1_0.viewGO, "#txt_debuglog")
	arg_1_0._animator = ZProj.ProjAnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0._goEnemyCardBackLogo = gohelper.findChild(arg_1_0.viewGO, "#image_RoleBG/enemy_logo")
	arg_1_0._enemyCardBackLogoAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goEnemyCardBackLogo)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._clickCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._clickCard(arg_4_0)
	if Activity188Model.instance:getGameState() ~= XugoujiEnum.GameStatus.Operatable then
		return
	end

	if not (arg_4_0._cardInfo.status == XugoujiEnum.CardStatus.Back) then
		return
	end

	XugoujiController.instance:selectCardItem(arg_4_0._cardInfo.uid)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._flipState = XugoujiEnum.CardStatus.Back
	arg_5_0._perspective = false
	arg_5_0._lockState = false
	arg_5_0._active = false
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, arg_6_0._onOperatedCard, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, arg_6_0._onCardStatusUpdate, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, arg_6_0._onCardPairStatusUpdated, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, arg_6_0._onGotCardPair, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_6_0._onTurnChanged, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, arg_6_0._onCardEffectStatusUpdate, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, arg_6_0._onFilpBackUnActive, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, arg_6_0.onUpdateNewCard, arg_6_0)
	arg_6_0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, arg_6_0.onGameRestart, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.OperateCard, arg_7_0._onOperatedCard, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardStatusUpdated, arg_7_0._onCardStatusUpdate, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardPairStatusUpdated, arg_7_0._onCardPairStatusUpdated, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotActiveCard, arg_7_0._onGotCardPair, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_7_0._onTurnChanged, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.CardEffectStatusUpdated, arg_7_0._onCardEffectStatusUpdate, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.FilpBackUnActiveCard, arg_7_0._onFilpBackUnActive, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GotNewCardDisplay, arg_7_0.onUpdateNewCard, arg_7_0)
	arg_7_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestartCardDisplay, arg_7_0.onGameRestart, arg_7_0)
end

function var_0_0._onOperatedCard(arg_8_0, arg_8_1)
	if arg_8_0._cardInfo.uid == arg_8_1 then
		arg_8_0._seleted = true

		gohelper.setActive(arg_8_0._goSelected, arg_8_0._seleted)
	end
end

function var_0_0._onCardStatusUpdate(arg_9_0, arg_9_1)
	if arg_9_0._cardInfo.uid == arg_9_1 then
		arg_9_0:refreshUI()
	end
end

function var_0_0._onGotCardPair(arg_10_0, arg_10_1)
	if arg_10_0._cardInfo.uid == arg_10_1[1] or arg_10_0._cardInfo.uid == arg_10_1[2] then
		arg_10_0:playCardGotPairAni()
	end
end

function var_0_0._onCardPairStatusUpdated(arg_11_0, arg_11_1)
	if arg_11_0._cardInfo.uid == arg_11_1 then
		arg_11_0:playCardGotPairAni()
		arg_11_0:hideCard()
	end
end

function var_0_0._onTurnChanged(arg_12_0)
	arg_12_0._seleted = false

	gohelper.setActive(arg_12_0._goSelected, false)
	gohelper.setActive(arg_12_0._goEnemyCardBackLogo, true)

	local var_12_0 = Activity188Model.instance:isMyTurn()

	arg_12_0._enemyCardBackLogoAnimator:Play(var_12_0 and UIAnimationName.Out or UIAnimationName.In, nil, nil)

	local var_12_1 = arg_12_0._cardInfo.status

	if not arg_12_0._active and var_12_1 == XugoujiEnum.CardStatus.Disappear then
		arg_12_0:playActiveAni()
	end

	if arg_12_0._active or arg_12_0._lockState then
		return
	end

	arg_12_0:refreshUI()
end

function var_0_0._onCardEffectStatusUpdate(arg_13_0, arg_13_1)
	if arg_13_0._cardInfo.uid == arg_13_1 then
		arg_13_0:refreshUI()
	end
end

function var_0_0._onFilpBackUnActive(arg_14_0)
	if arg_14_0._flipState == XugoujiEnum.CardStatus.Back then
		return
	end

	local var_14_0 = arg_14_0._cardInfo.status
	local var_14_1 = arg_14_0._flipState
	local var_14_2 = Activity188Model.instance:isMyTurn()

	gohelper.setActive(arg_14_0._goEnemyCardBackLogo, var_14_2)
	arg_14_0._enemyCardBackLogoAnimator:Play(var_14_2 and UIAnimationName.Idle or "idle1", nil, nil)

	if var_14_0 == XugoujiEnum.CardStatus.Back and var_14_1 ~= var_14_0 then
		arg_14_0:refreshUI()
	end
end

function var_0_0.onUpdateNewCard(arg_15_0)
	arg_15_0._animator:Play(UIAnimationName.Close, nil, nil)

	local var_15_0 = Activity188Model.instance:isMyTurn()

	gohelper.setActive(arg_15_0._goEnemyCardBackLogo, not var_15_0)

	arg_15_0._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(arg_15_0._cardInfo.uid, arg_15_0._flipState)
end

function var_0_0.onGameRestart(arg_16_0)
	arg_16_0._animator:Play(UIAnimationName.Close, nil, nil)
	gohelper.setActive(arg_16_0._goEnemyCardBackLogo, false)

	arg_16_0._flipState = XugoujiEnum.CardStatus.Back
end

function var_0_0.onUpdateData(arg_17_0, arg_17_1)
	arg_17_0._cardInfo = arg_17_1
	arg_17_0._seleted = false
	arg_17_0._hide = false
	arg_17_0._lockState = false
	arg_17_0._perspective = false
	arg_17_0._active = false
	arg_17_0._flipState = XugoujiEnum.CardStatus.Back

	Activity188Model.instance:setCardItemStatue(arg_17_0._cardInfo.uid, arg_17_0._flipState)
end

function var_0_0.refreshUI(arg_18_0)
	if not arg_18_0._cardInfo then
		return
	end

	if arg_18_0._active then
		return
	end

	gohelper.setActive(arg_18_0._goSelected, arg_18_0._seleted)
	arg_18_0:refreshCardAniShow(arg_18_0._cardInfo)

	arg_18_0._flipState = arg_18_0._cardInfo.status

	Activity188Model.instance:setCardItemStatue(arg_18_0._cardInfo.uid, arg_18_0._flipState)

	local var_18_0 = arg_18_0._cardInfo.status == XugoujiEnum.CardStatus.Front
	local var_18_1 = arg_18_0._cardInfo.status == XugoujiEnum.CardStatus.Back
	local var_18_2 = arg_18_0._cardInfo.status == XugoujiEnum.CardStatus.Disappear

	if var_18_1 and arg_18_0._seleted then
		gohelper.setActive(arg_18_0._goSelected, false)
	end

	local var_18_3 = Activity188Model.instance:getCardEffect(arg_18_0._cardInfo.uid)

	gohelper.setActive(arg_18_0._goCardIcon, var_18_0 or var_18_2 or var_18_3 and var_18_3[XugoujiEnum.CardEffectStatus.Perspective])

	local var_18_4 = XugoujiController.instance:isDebugMode()

	gohelper.setActive(arg_18_0._txtDebugLog.gameObject, XugoujiController.instance:isDebugMode())

	if var_18_4 then
		local var_18_5 = arg_18_0._cardInfo.id
		local var_18_6 = Activity188Config.instance:getCardCfg(var_0_1, arg_18_0._cardInfo.id)

		arg_18_0._txtDebugLog.text = var_18_5
	end
end

function var_0_0.hideCard(arg_19_0)
	arg_19_0._hide = true
	arg_19_0._seleted = false
end

function var_0_0.refreshCardIcon(arg_20_0)
	if not arg_20_0._cardInfo then
		return
	end

	local var_20_0 = Activity188Config.instance:getCardCfg(var_0_1, arg_20_0._cardInfo.id).resource

	if not var_20_0 or var_20_0 == "" then
		return
	end

	UISpriteSetMgr.instance:setXugoujiSprite(arg_20_0._imgCardIcon, var_20_0)
	UISpriteSetMgr.instance:setXugoujiSprite(arg_20_0._imageRoleBG, var_0_2)
end

function var_0_0.refreshCardAniShow(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._cardInfo.status

	if arg_21_0._flipState == XugoujiEnum.CardStatus.Back and var_21_0 == XugoujiEnum.CardStatus.Front then
		arg_21_0._perspective = false
		arg_21_0._lockState = false

		arg_21_0._animator:Play(UIAnimationName.Open, nil, nil)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardFilp)

		return
	elseif arg_21_0._flipState == XugoujiEnum.CardStatus.Front and var_21_0 == XugoujiEnum.CardStatus.Back then
		arg_21_0._animator:Play(UIAnimationName.Close, nil, nil)
		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardClose)

		return
	end

	local var_21_1 = Activity188Model.instance:getCardEffect(arg_21_0._cardInfo.uid)

	if not arg_21_0._perspective and var_21_1 and var_21_1[XugoujiEnum.CardEffectStatus.Perspective] and not arg_21_0._perspective then
		arg_21_0._perspective = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspective)
		arg_21_0._animator:Play("perspective_in", nil, nil)
	elseif arg_21_0._perspective and var_21_1 and not var_21_1[XugoujiEnum.CardEffectStatus.Perspective] then
		arg_21_0._perspective = false

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardPerspectiveEnd)
		arg_21_0._animator:Play("perspective_out", nil, nil)
	elseif not arg_21_0._lockState and var_21_1 and var_21_1[XugoujiEnum.CardEffectStatus.Lock] then
		arg_21_0._lockState = true

		AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardLock)
		arg_21_0._animator:Play("lock_in", nil, nil)
	elseif arg_21_0._lockState and var_21_1 and not var_21_1[XugoujiEnum.CardEffectStatus.Lock] then
		arg_21_0._lockState = false

		arg_21_0._animator:Play("lock_out", nil, nil)
	end
end

function var_0_0.playCardGotPairAni(arg_22_0)
	arg_22_0._animator:Play(UIAnimationName.Finish, nil, nil)
end

function var_0_0.playActiveAni(arg_23_0)
	if arg_23_0._active then
		return
	end

	arg_23_0._active = true

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardDisappear)
	arg_23_0._animator:Play("active_in", nil, nil)
end

function var_0_0.clearCardEffect(arg_24_0)
	if not arg_24_0._cardInfo then
		return
	end

	local var_24_0 = arg_24_0._cardInfo.status == XugoujiEnum.CardStatus.Front
	local var_24_1 = arg_24_0._cardInfo.status == XugoujiEnum.CardStatus.Disappear

	gohelper.setActive(arg_24_0._goCardIcon, var_24_0 or var_24_1)
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
