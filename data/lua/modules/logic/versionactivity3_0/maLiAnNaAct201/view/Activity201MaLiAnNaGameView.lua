module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameView", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocameraMain = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain")
	arg_1_0._simageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/#simage_BG")
	arg_1_0._goRoads = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Roads")
	arg_1_0._goroad = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Roads/#go_road")
	arg_1_0._goSlots = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Slots")
	arg_1_0._goEntitys = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Entitys")
	arg_1_0._goEffects = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects")
	arg_1_0._goarrowLines = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines")
	arg_1_0._goarrowenemy = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines/#go_arrow_enemy")
	arg_1_0._goarrowplayer = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_arrowLines/#go_arrow_player")
	arg_1_0._goFinger = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_Effects/#go_Finger")
	arg_1_0._gobattleEffects = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects")
	arg_1_0._gobattleEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects/#go_battleEffect")
	arg_1_0._govxboom = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#go_battleEffects/#go_vx_boom")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips/#txt_Tips")
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips/#txt_Tips/#go_Icon")
	arg_1_0._goTips2 = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips2")
	arg_1_0._txtTips2 = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/#go_Tips2/#txt_Tips2")
	arg_1_0._scrollTargetList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList/viewport/#go_target")
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/Target/#scroll_TargetList/viewport/#go_target/#txt_Target")
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips")
	arg_1_0._txtRoleName = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_RoleName")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_dec")
	arg_1_0._txtRoleHP = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_tips/#txt_RoleHP")
	arg_1_0._txtreduceHP = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#txt_reduceHP")
	arg_1_0._goSelf = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Self")
	arg_1_0._goEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Enemy")
	arg_1_0._simageRole = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image/#simage_Role")
	arg_1_0._txtRoleHP2 = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image_RoleHPNumBG/#txt_RoleHP_2")
	arg_1_0._txtRoleHP3 = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/image_RoleHPNumBG/#txt_RoleHP_3")
	arg_1_0._goDead = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#go_Dead")
	arg_1_0._btnrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Left/RoleList/#go_Role/#btn_role")
	arg_1_0._goSwitch = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Switch")
	arg_1_0._gosolider = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Switch/#go_solider")
	arg_1_0._simageswitchsolider = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Switch/#go_solider/Head/image/#simage_switch_solider")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Switch/#go_hero")
	arg_1_0._simageswitchhero = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Switch/#go_hero/Head/image/#simage_switch_hero")
	arg_1_0._goskillList = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/#go_skillList")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#go_skillList/#btn_cancel")
	arg_1_0._goskillItem = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/#go_skillList/#go_skillItem")
	arg_1_0._imageskill = gohelper.findChildImage(arg_1_0.viewGO, "#go_cameraMain/Right/#go_skillList/#go_skillItem/#image_skill")
	arg_1_0._btnPause = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_Pause")
	arg_1_0._gopause = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Right/#go_pause")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#go_pause/#btn_close")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_Reset")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrole:AddClickListener(arg_2_0._btnroleOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnPause:AddClickListener(arg_2_0._btnPauseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrole:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnPause:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
end

function var_0_0._btnPauseOnClick(arg_4_0)
	Activity201MaLiAnNaGameController.instance:setPause(true)
	gohelper.setActive(arg_4_0._gopause, true)
end

function var_0_0._btncloseOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gopause, false)
	Activity201MaLiAnNaGameController.instance:setPause(false)
end

function var_0_0._btncancelOnClick(arg_6_0)
	arg_6_0:_onSelectActiveSkill(nil)
end

function var_0_0._btnroleOnClick(arg_7_0)
	return
end

function var_0_0._btnResetOnClick(arg_8_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MaLiAnNaGameReset, MsgBoxEnum.BoxType.Yes_No, function()
		MaLiAnNaStatHelper.instance:sendGameExit(Activity201MaLiAnNaEnum.resultType.reset)
		Activity201MaLiAnNaGameController.instance:restartGame()
	end, nil, nil, nil, nil, nil)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._fingerTr = arg_10_0._goFinger.transform
	arg_10_0._fingerGo = arg_10_0._goFinger
	arg_10_0._effectsTr = arg_10_0._goEffects.transform
	arg_10_0._tipImage = arg_10_0._goTips:GetComponent(gohelper.Type_Image)
	arg_10_0._tipIconImage = arg_10_0._goIcon:GetComponent(gohelper.Type_Image)

	local var_10_0 = arg_10_0.viewContainer._viewSetting.otherRes[3]
	local var_10_1 = arg_10_0.viewContainer._viewSetting.otherRes[4]
	local var_10_2 = arg_10_0:getResInst(var_10_0, arg_10_0._goEntitys, "solider_temp")
	local var_10_3 = arg_10_0:getResInst(var_10_1, arg_10_0._goEntitys, "hero_temp")

	gohelper.setActive(var_10_2, false)
	gohelper.setActive(var_10_3, false)
	MaliAnNaSoliderEntityMgr.instance:init(var_10_2, var_10_3)
	MaliAnNaBulletEntityMgr.instance:init(arg_10_0._goEffects)

	arg_10_0._switchClick = gohelper.getClickWithDefaultAudio(arg_10_0._goSwitch)

	arg_10_0._switchClick:AddClickListener(arg_10_0._switchOnClick, arg_10_0)

	arg_10_0._switchAni = arg_10_0._goSwitch:GetComponent(gohelper.Type_Animator)
	arg_10_0._tipAni = arg_10_0._goTips:GetComponent(gohelper.Type_Animator)
	arg_10_0._tip2Ani = arg_10_0._goTips2:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnGameReStart, arg_12_0._onGameReStart, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnRefreshView, arg_12_0._refreshView, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragBeginSlot, arg_12_0._onDragBeginSlot, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragSlot, arg_12_0._onDragSlot, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragEndSlot, arg_12_0._onDragEndSlot, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnShowBattleEffect, arg_12_0._onShowBattleEffect, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnSelectActiveSkill, arg_12_0._onSelectActiveSkill, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnClickSlot, arg_12_0._onClickSlot, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowDisPatchPath, arg_12_0.showDispatchPathByAI, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowBattleEvent, arg_12_0.addEventInfo, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowShowVX, arg_12_0._showShowVX, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.GenerateSolider, arg_12_0._generateSolider, arg_12_0)
	arg_12_0:addEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.SoliderHpChange, arg_12_0._soliderHpChange, arg_12_0)
	gohelper.setActive(arg_12_0._goTips, false)
	arg_12_0:_refreshView(true)
	arg_12_0:_initBaseInfo()
	TaskDispatcher.runRepeat(arg_12_0._hideDispatchPathByAI, arg_12_0, 0.5)

	arg_12_0._canSwitch = true

	Activity201MaLiAnNaGameController.instance:_checkGameStart()
	AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_leimi_smalluncharted_open)
end

function var_0_0._initBaseInfo(arg_13_0)
	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(false)

	local var_13_0 = Activity201MaLiAnNaGameModel.instance:getCurGameConfig()
	local var_13_1 = var_13_0.battlePic

	if string.nilorempty(var_13_1) then
		arg_13_0._simageBG:LoadImage(var_13_1)
	end

	arg_13_0._txtTarget.text = var_13_0.targetDesc

	local var_13_2 = Activity201MaLiAnNaConfig.instance:getSoldierById(11001)

	if var_13_2 and var_13_2.icon then
		arg_13_0._simageswitchhero:LoadImage(ResUrl.getHeadIconSmall(var_13_2.icon))
	end

	local var_13_3 = Activity201MaLiAnNaConfig.instance:getSoldierById(1001)

	if var_13_3 and var_13_3.icon then
		arg_13_0._simageswitchsolider:LoadImage(ResUrl.monsterHeadIcon(var_13_3.icon))
	end
end

function var_0_0._onGameReStart(arg_14_0)
	arg_14_0._canSwitch = true

	gohelper.setActive(arg_14_0._gopause, false)
	gohelper.setActive(arg_14_0._goTips, false)
	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(false)
	MaliAnNaSoliderEntityMgr.instance:clear()
	MaliAnNaBulletEntityMgr.instance:clear()
	arg_14_0:_initAndUpdateHeroSolider(true)
	arg_14_0:_refreshView()
	Activity201MaLiAnNaGameController.instance:setPause(false)
	arg_14_0:_gameReset()
	arg_14_0:_onSelectActiveSkill(nil)

	arg_14_0._lastTriggerSlotId = nil
end

function var_0_0._gameReset(arg_15_0)
	if arg_15_0._slotItem then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._slotItem) do
			iter_15_1:reset()
		end
	end

	if arg_15_0._heroSoliderItem then
		for iter_15_2, iter_15_3 in pairs(arg_15_0._heroSoliderItem) do
			iter_15_3:reset()
		end
	end
end

function var_0_0._refreshView(arg_16_0, arg_16_1)
	arg_16_0._gameMo = Activity201MaLiAnNaGameModel.instance:getGameMo()

	arg_16_0:_initSlot()
	arg_16_0:_initLine()
	arg_16_0:_initSkill()
	arg_16_0:refreshDisPatchState()
	arg_16_0:_initAndUpdateHeroSolider(arg_16_1)
end

function var_0_0._initSlot(arg_17_0)
	if arg_17_0._slotItem == nil then
		arg_17_0._slotItem = arg_17_0:getUserDataTb_()
	end

	local var_17_0 = arg_17_0._gameMo:getAllSlot()

	if var_17_0 == nil then
		return
	end

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		local var_17_1 = arg_17_0._slotItem[iter_17_1.id]

		if var_17_1 == nil then
			local var_17_2 = arg_17_0.viewContainer._viewSetting.otherRes[1]
			local var_17_3 = arg_17_0:getResInst(var_17_2, arg_17_0._goSlots, "slot" .. iter_17_1.id .. "_" .. iter_17_1.configId)

			var_17_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_3, MaLiAnNaSlotItem)

			var_17_1:initData(iter_17_1)

			arg_17_0._slotItem[iter_17_1.id] = var_17_1
		end

		var_17_1:updateInfo(iter_17_1)
	end
end

function var_0_0._initLine(arg_18_0)
	if arg_18_0._lineItem == nil then
		arg_18_0._lineItem = arg_18_0:getUserDataTb_()

		gohelper.CreateObjList(arg_18_0, arg_18_0._roadItem, arg_18_0._gameMo:getAllRoad(), arg_18_0._goRoads, arg_18_0._goroad, MaLiAnNaLineGameComp)
	end
end

function var_0_0._roadItem(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 and arg_19_2 then
		arg_19_1:updateInfo(arg_19_2)

		arg_19_0._lineItem[arg_19_2.id] = arg_19_1
	end
end

function var_0_0._switchOnClick(arg_20_0)
	if not arg_20_0._canSwitch then
		return
	end

	local var_20_0 = Activity201MaLiAnNaGameModel.instance:getDispatchHeroFirst()

	Activity201MaLiAnNaGameModel.instance:setDispatchHeroFirst(not var_20_0)
	arg_20_0:refreshDisPatchState()
end

function var_0_0.refreshDisPatchState(arg_21_0)
	local var_21_0 = Activity201MaLiAnNaGameModel.instance:getDispatchHeroFirst()

	if arg_21_0._lastDisPatchHeroFirst == nil or var_21_0 ~= arg_21_0._lastDisPatchHeroFirst then
		arg_21_0._canSwitch = false

		local var_21_1 = var_21_0 and "hero" or "solider"

		arg_21_0._switchAni:Play(var_21_1)
		TaskDispatcher.runDelay(function(arg_22_0)
			arg_22_0._canSwitch = true
		end, arg_21_0, 0.4)

		arg_21_0._lastDisPatchHeroFirst = var_21_0
	end
end

local var_0_1 = SLFramework.UGUI.RectTrHelper

function var_0_0._onDragBeginSlot(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	return
end

function var_0_0._onDragSlot(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if Activity201MaLiAnNaGameModel.instance:getSlotById(arg_24_1) == nil then
		return
	end

	local var_24_0, var_24_1 = var_0_1.ScreenPosXYToAnchorPosXY(arg_24_2, arg_24_3, arg_24_0._effectsTr, CameraMgr.instance:getUICamera(), nil, nil)

	recthelper.setAnchor(arg_24_0._fingerTr, var_24_0, var_24_1)

	local var_24_2, var_24_3 = transformhelper.getLocalPos(arg_24_0._fingerTr)

	Activity201MaLiAnNaGameModel.instance:checkPosAndDisPatch(var_24_2, var_24_3)

	local var_24_4 = Activity201MaLiAnNaGameModel.instance:getDisPatchSlotList()

	if var_24_4 and var_24_4[1] == arg_24_1 then
		if not arg_24_0._fingerGo.activeSelf then
			gohelper.setActive(arg_24_0._fingerGo, true)
		end

		if arg_24_0._disPatchId == nil then
			arg_24_0._disPatchId = Activity201MaLiAnNaGameModel.instance:getNextDisPatchId()
		end

		arg_24_0:showDispatch(arg_24_0._disPatchId, Activity201MaLiAnNaEnum.CampType.Player, var_24_4, true, var_24_2, var_24_3)
		arg_24_0:updateDisPatchMiddlePoint(Activity201MaLiAnNaEnum.CampType.Player, var_24_4, true)
		arg_24_0:updateCurLine(var_24_4, Activity201MaLiAnNaEnum.CampType.Player, true, var_24_2, var_24_3)

		local var_24_5, var_24_6 = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(var_24_2, var_24_3)

		if var_24_5 and var_24_6 ~= arg_24_1 then
			arg_24_0:playerDragAnim(var_24_6)

			if arg_24_0._lastTriggerSlotId == nil or arg_24_0._lastTriggerSlotId ~= var_24_6 then
				AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_link_click)

				arg_24_0._lastTriggerSlotId = var_24_6
			end
		else
			arg_24_0:playerDragAnim(nil)
		end
	end
end

function var_0_0._onDragEndSlot(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if Activity201MaLiAnNaGameModel.instance:getSlotById(arg_25_1) == nil then
		return
	end

	gohelper.setActive(arg_25_0._fingerGo, false)

	local var_25_0, var_25_1 = var_0_1.ScreenPosXYToAnchorPosXY(arg_25_2, arg_25_3, arg_25_0._effectsTr, CameraMgr.instance:getUICamera(), nil, nil)

	recthelper.setAnchor(arg_25_0._fingerTr, var_25_0, var_25_1)

	local var_25_2, var_25_3 = transformhelper.getLocalPos(arg_25_0._fingerTr)
	local var_25_4 = Activity201MaLiAnNaGameModel.instance:getDisPatchSlotList()

	if var_25_4 and var_25_4[1] == arg_25_1 then
		arg_25_0:showDispatch(arg_25_0._disPatchId, Activity201MaLiAnNaEnum.CampType.Player, var_25_4, false)
		arg_25_0:updateDisPatchMiddlePoint(Activity201MaLiAnNaEnum.CampType.Player, var_25_4, false)
		arg_25_0:updateCurLine(var_25_4, Activity201MaLiAnNaEnum.CampType.Player, false)
	end

	if Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(var_25_2, var_25_3) and arg_25_0._disPatchId ~= nil then
		Activity201MaLiAnNaGameModel.instance:disPatch(arg_25_0._disPatchId)

		arg_25_0._disPatchId = nil
	end

	Activity201MaLiAnNaGameModel.instance:clearDisPatch()

	arg_25_0._disPatchId = nil

	arg_25_0:playerDragAnim(nil)

	arg_25_0._lastTriggerSlotId = nil
end

function var_0_0.showDispatch(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_3 == nil or #arg_26_3 == 0 or arg_26_1 == nil or arg_26_2 == nil then
		return nil
	end

	if arg_26_0._lineItems == nil then
		arg_26_0._lineItems = {}
	end

	if arg_26_0._lineItems[arg_26_1] == nil then
		arg_26_0._lineItems[arg_26_1] = {}
	end

	local var_26_0 = #arg_26_3

	for iter_26_0 = 1, var_26_0 do
		local var_26_1 = arg_26_3[iter_26_0]
		local var_26_2 = arg_26_3[iter_26_0 + 1]

		if var_26_1 and var_26_2 then
			local var_26_3 = var_26_1 .. "_" .. var_26_2
			local var_26_4 = arg_26_0._lineItems[arg_26_1][var_26_3]

			if var_26_4 == nil then
				var_26_4 = arg_26_0:getLineObject(arg_26_2)
				arg_26_0._lineItems[arg_26_1][var_26_3] = var_26_4
			end

			if arg_26_4 then
				local var_26_5 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_26_1)
				local var_26_6 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_26_2)

				if var_26_5 and var_26_6 then
					local var_26_7, var_26_8 = var_26_5:getBasePosXY()
					local var_26_9, var_26_10 = var_26_6:getBasePosXY()

					arg_26_0:setLineData(var_26_4, var_26_7, var_26_8, var_26_9, var_26_10)
					gohelper.setActive(var_26_4.gameObject, true)
				end
			else
				arg_26_0:recycleLineGo(var_26_4, arg_26_2)

				arg_26_0._lineItems[arg_26_1][var_26_3] = nil
			end
		end
	end

	if not arg_26_4 then
		arg_26_0._lineItems[arg_26_1] = nil
	end
end

function var_0_0.updateDisPatchMiddlePoint(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1 ~= Activity201MaLiAnNaEnum.CampType.Player then
		return
	end

	if arg_27_2 == nil or #arg_27_2 < 2 then
		return
	end

	local var_27_0 = #arg_27_2

	for iter_27_0 = 2, var_27_0 - 1 do
		local var_27_1 = arg_27_2[iter_27_0]

		if var_27_1 and arg_27_0._slotItem[var_27_1] then
			arg_27_0._slotItem[var_27_1]:setMiddlePointActive(arg_27_3)
		end
	end
end

function var_0_0.updateCurLine(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	if not arg_28_3 and arg_28_0._curLine and arg_28_0._curLineSlotId then
		arg_28_0:recycleLineGo(arg_28_0._curLine, Activity201MaLiAnNaEnum.CampType.Player)

		arg_28_0._curLine = nil

		return
	end

	if arg_28_1 == nil or #arg_28_1 == 0 then
		return
	end

	local var_28_0 = arg_28_1[#arg_28_1]

	if arg_28_0._curLineSlotId ~= var_28_0 and arg_28_0._curLine ~= nil then
		arg_28_0:recycleLineGo(arg_28_0._curLine, arg_28_2)

		arg_28_0._curLine = nil
	end

	if var_28_0 ~= nil and arg_28_3 and arg_28_0._curLine == nil then
		arg_28_0._curLine = arg_28_0:getLineObject(arg_28_2)

		local var_28_1 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_28_0)

		if var_28_1 then
			local var_28_2, var_28_3 = var_28_1:getBasePosXY()

			arg_28_0:setLineData(arg_28_0._curLine, var_28_2, var_28_3, arg_28_4 or var_28_2, arg_28_5 or var_28_3)
			gohelper.setActive(arg_28_0._curLine.gameObject, true)
		end

		arg_28_0._curLineSlotId = var_28_0
	end

	if arg_28_0._curLine ~= nil then
		local var_28_4 = Activity201MaLiAnNaGameModel.instance:getSlotById(var_28_0)

		if var_28_4 then
			local var_28_5, var_28_6 = var_28_4:getBasePosXY()

			arg_28_0:setLineData(arg_28_0._curLine, var_28_5, var_28_6, arg_28_4 or var_28_5, arg_28_5 or var_28_6)
		end
	end
end

function var_0_0.setLineData(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = true
	local var_29_1 = true
	local var_29_2, var_29_3 = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(arg_29_2, arg_29_3)

	if var_29_2 and Activity201MaLiAnNaGameModel.instance:getSlotById(var_29_3):isInCanSelectRange(arg_29_4, arg_29_5) then
		arg_29_2, arg_29_3, arg_29_4, arg_29_5 = 0, 0, 0, 0

		local var_29_4 = false

		var_29_1 = false
	end

	local var_29_5, var_29_6 = Activity201MaLiAnNaGameModel.instance:inSlotCanSelectRange(arg_29_4, arg_29_5)
	local var_29_7 = var_29_6
	local var_29_8 = var_29_5 and true or false

	if var_29_1 or var_29_8 then
		arg_29_2, arg_29_3, arg_29_4, arg_29_5 = MathUtil.calculateVisiblePoints(arg_29_2, arg_29_3, Activity201MaLiAnNaEnum.defaultHideLineRange, arg_29_4, arg_29_5, Activity201MaLiAnNaEnum.defaultHideLineRange)
	end

	transformhelper.setLocalPosXY(arg_29_1, arg_29_2, arg_29_3)

	local var_29_9 = MathUtil.vec2_length(arg_29_2, arg_29_3, arg_29_4, arg_29_5)

	recthelper.setWidth(arg_29_1, var_29_9)

	local var_29_10 = MathUtil.calculateV2Angle(arg_29_4, arg_29_5, arg_29_2, arg_29_3)

	transformhelper.setEulerAngles(arg_29_1, 0, 0, var_29_10)
end

function var_0_0.getLineObject(arg_30_0, arg_30_1)
	if arg_30_0._lineItemPools == nil then
		arg_30_0._lineItemPools = {}
	end

	arg_30_1 = arg_30_1 or Activity201MaLiAnNaEnum.CampType.Player

	if arg_30_0._lineItemPools[arg_30_1] == nil then
		local var_30_0 = 20

		arg_30_0._lineItemPools[arg_30_1] = LuaObjPool.New(var_30_0, function()
			if arg_30_1 == Activity201MaLiAnNaEnum.CampType.Player then
				return gohelper.cloneInPlace(arg_30_0._goarrowplayer, "playerLine").transform
			end

			if arg_30_1 == Activity201MaLiAnNaEnum.CampType.Enemy then
				return gohelper.cloneInPlace(arg_30_0._goarrowenemy, "enemyLine").transform
			end
		end, function(arg_32_0)
			if arg_32_0 then
				gohelper.destroy(arg_32_0.gameObject)
			end
		end, function(arg_33_0)
			if arg_33_0 then
				gohelper.setActive(arg_33_0.gameObject, false)
			end
		end)
	end

	return (arg_30_0._lineItemPools[arg_30_1]:getObject())
end

function var_0_0.recycleLineGo(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == nil then
		return
	end

	if arg_34_0._lineItemPools ~= nil and arg_34_0._lineItemPools[arg_34_2] then
		arg_34_0._lineItemPools[arg_34_2]:putObject(arg_34_1)
	end
end

function var_0_0._onShowBattleEffect(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	if arg_35_0._goBattleEffectItem == nil then
		arg_35_0._goBattleEffectItem = arg_35_0:getUserDataTb_()
	end

	local var_35_0

	if arg_35_4 then
		var_35_0 = gohelper.cloneInPlace(arg_35_0._gobattleEffect, "battleEffect_" .. arg_35_1 .. "_" .. arg_35_2)
	else
		var_35_0 = gohelper.cloneInPlace(arg_35_0._govxboom, "effect" .. arg_35_1 .. "_" .. arg_35_2)
	end

	if var_35_0 == nil then
		return
	end

	transformhelper.setLocalPosXY(var_35_0.transform, arg_35_1, arg_35_2)
	gohelper.setActive(var_35_0, true)
	TaskDispatcher.runDelay(function()
		if var_35_0 then
			gohelper.setActive(var_35_0, false)
			gohelper.destroy(var_35_0)
		end
	end, nil, arg_35_3)
end

function var_0_0._initSkill(arg_37_0)
	if arg_37_0._skillItem == nil then
		arg_37_0._skillItem = arg_37_0:getUserDataTb_()
	end

	local var_37_0 = Activity201MaLiAnNaGameModel.instance:getAllActiveSkill()

	if var_37_0 == nil then
		return
	end

	for iter_37_0 = 1, #var_37_0 do
		local var_37_1 = arg_37_0._skillItem[iter_37_0]

		if var_37_1 == nil then
			local var_37_2 = arg_37_0.viewContainer._viewSetting.otherRes[2]
			local var_37_3 = arg_37_0:getResInst(var_37_2, arg_37_0._goskillList, "skill_" .. var_37_0[iter_37_0]._configId)

			var_37_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_37_3, MaLiAnNaSkillItem)

			var_37_1:initData(var_37_0[iter_37_0])
			table.insert(arg_37_0._skillItem, var_37_1)
		end

		var_37_1:updateInfo(var_37_0[iter_37_0])
		var_37_1:refreshSelect(arg_37_0._skillData)
	end
end

function var_0_0.refreshSkillSelect(arg_38_0)
	if arg_38_0._skillItem == nil then
		return
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0._skillItem) do
		if iter_38_1 then
			iter_38_1:refreshSelect(arg_38_0._skillData)
		end
	end
end

function var_0_0._onSelectActiveSkill(arg_39_0, arg_39_1)
	local var_39_0

	if arg_39_1 ~= nil then
		var_39_0 = arg_39_1:getSkillNeedSlotCamp()
	end

	if var_39_0 == nil and arg_39_0._skillData ~= nil then
		var_39_0 = arg_39_0._skillData:getSkillNeedSlotCamp()
	end

	if arg_39_1 == nil and arg_39_0._skillData ~= nil then
		arg_39_0._skillData:clearParams()
	end

	Activity201MaLiAnNaGameController.instance:setPause(arg_39_1 ~= nil)

	arg_39_0._skillData = arg_39_1

	arg_39_0:refreshSkillSelect()

	if arg_39_0._skillData ~= nil then
		arg_39_0:showSkillInfo(arg_39_0._skillData:getConfig().description)
	else
		arg_39_0:showSkillInfo(nil)
	end

	if arg_39_0._skillData == nil then
		arg_39_0:slotPlayAniNameByCamp(var_39_0, true)
	else
		arg_39_0:slotPlayAniNameByCamp(var_39_0, false)
	end

	gohelper.setActive(arg_39_0._btncancel.gameObject, arg_39_0._skillData ~= nil)
end

function var_0_0.releaseSkill(arg_40_0, arg_40_1)
	if arg_40_0._skillData == nil then
		return false
	end

	local var_40_0 = arg_40_0._skillData:addParams(arg_40_1)

	if var_40_0 and arg_40_0._skillData:paramIsFull() then
		MaLiAnNaStatHelper.instance:addUseSkillInfo(arg_40_0._skillData:getConfigId())
		arg_40_0._skillData:execute()
		arg_40_0:_onSelectActiveSkill(nil)
		Activity201MaLiAnNaGameController.instance:setPause(false)

		return true
	end

	return var_40_0
end

function var_0_0._onClickSlot(arg_41_0, arg_41_1)
	if arg_41_0._skillData == nil then
		return
	end

	arg_41_0:releaseSkill(arg_41_1)
end

function var_0_0._initAndUpdateHeroSolider(arg_42_0, arg_42_1)
	if arg_42_0._heroSoliderItem == nil then
		arg_42_0._heroSoliderItem = arg_42_0:getUserDataTb_()
	end

	local var_42_0 = MaLiAnNaLaSoliderMoUtil.instance:getAllHeroSolider(Activity201MaLiAnNaEnum.CampType.Player)

	if var_42_0 == nil then
		return
	end

	for iter_42_0, iter_42_1 in pairs(var_42_0) do
		local var_42_1 = arg_42_0._heroSoliderItem[iter_42_1:getId()]

		if var_42_1 == nil then
			local var_42_2 = gohelper.cloneInPlace(arg_42_0._goRole, "heroSolider_" .. iter_42_1:getId())

			gohelper.setActive(var_42_2, true)

			var_42_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_42_2, MaLiAnNaHeroSoliderItem)
			arg_42_0._heroSoliderItem[iter_42_1:getId()] = var_42_1
		end

		if arg_42_1 then
			var_42_1:initData(iter_42_1)
		end

		var_42_1:updateInfo(iter_42_1)
	end
end

function var_0_0.showDispatchPathByAI(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if arg_43_1 == nil or arg_43_2 == nil or arg_43_3 == nil then
		return
	end

	if arg_43_0._aiDisPatchInfo == nil then
		arg_43_0._aiDisPatchInfo = {}
	end

	table.insert(arg_43_0._aiDisPatchInfo, {
		disPatchId = arg_43_1,
		camp = arg_43_2,
		path = arg_43_3,
		time = os.time()
	})
	arg_43_0:showDispatch(arg_43_1, arg_43_2, arg_43_3, true)
end

function var_0_0._hideDispatchPathByAI(arg_44_0)
	if arg_44_0._aiDisPatchInfo == nil then
		return
	end

	local var_44_0 = arg_44_0._aiDisPatchInfo[1]

	if var_44_0 and os.time() - var_44_0.time >= Activity201MaLiAnNaEnum.enemyLineShowTime then
		arg_44_0:showDispatch(var_44_0.disPatchId, var_44_0.camp, var_44_0.path, false)
		table.remove(arg_44_0._aiDisPatchInfo, 1)
	end
end

function var_0_0.addEventInfo(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0:_showInfo(arg_45_1, arg_45_2)
end

function var_0_0.showInfo(arg_46_0)
	if arg_46_0._infoList == nil then
		gohelper.setActive(arg_46_0._goTips, false)

		return
	end
end

function var_0_0.showSkillInfo(arg_47_0, arg_47_1)
	if arg_47_1 ~= nil then
		arg_47_0._txtTips2.text = arg_47_1
	end

	if arg_47_1 ~= nil then
		gohelper.setActive(arg_47_0._goTips2, true)
	else
		arg_47_0:_closeSkillTip()
	end
end

function var_0_0._closeSkillTip(arg_48_0)
	if arg_48_0._tip2Ani then
		arg_48_0._tip2Ani:Play("close")
		TaskDispatcher.runDelay(function(arg_49_0)
			if arg_49_0._goTips2 then
				gohelper.setActive(arg_49_0._goTips2, false)
			end
		end, arg_48_0, 0.5)
	end
end

function var_0_0._showInfo(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_2 ~= nil then
		arg_50_0._txtTips.text = arg_50_2
	end

	local var_50_0 = Activity201MaLiAnNaEnum.tipBgByCamp[arg_50_1]

	if var_50_0 and arg_50_0._tipImage then
		UISpriteSetMgr.instance:setMaliAnNaSprite(arg_50_0._tipImage, var_50_0)
	end

	local var_50_1 = Activity201MaLiAnNaEnum.tipIconByCamp[arg_50_1]

	if var_50_1 and arg_50_0._tipIconImage then
		UISpriteSetMgr.instance:setMaliAnNaSprite(arg_50_0._tipIconImage, var_50_1)
	end

	local var_50_2 = arg_50_2 ~= nil

	if var_50_2 and arg_50_0._goTips.activeSelf then
		gohelper.setActive(arg_50_0._goTips, false)
	end

	gohelper.setActive(arg_50_0._goTips, var_50_2)
	TaskDispatcher.cancelTask(arg_50_0._closeTip, arg_50_0)
	TaskDispatcher.runDelay(arg_50_0._closeTip, arg_50_0, 1.5)
end

function var_0_0._closeTip(arg_51_0)
	if arg_51_0._tipAni then
		arg_51_0._tipAni:Play("close")
		TaskDispatcher.runDelay(function(arg_52_0)
			if arg_52_0._goTips then
				gohelper.setActive(arg_52_0._goTips, false)
			end
		end, arg_51_0, 0.5)
	end
end

function var_0_0.playerDragAnim(arg_53_0, arg_53_1)
	if arg_53_0._lastShowDragSlotId == arg_53_1 then
		return
	end

	if arg_53_0._lastShowDragSlotId ~= nil then
		arg_53_0:slotPlayAniName(arg_53_0._lastShowDragSlotId, nil, true)

		arg_53_0._lastShowDragSlotId = nil
	end

	if arg_53_1 == nil then
		return
	end

	local var_53_0 = Activity201MaLiAnNaGameModel.instance:getSlotById(arg_53_1):getSlotCamp() == Activity201MaLiAnNaEnum.CampType.Player and Activity201MaLiAnNaEnum.slotAnimName.help or Activity201MaLiAnNaEnum.slotAnimName.attack

	arg_53_0:slotPlayAniName(arg_53_1, var_53_0, false)

	arg_53_0._lastShowDragSlotId = arg_53_1
end

function var_0_0.slotPlayAniNameByCamp(arg_54_0, arg_54_1, arg_54_2)
	if arg_54_1 == nil then
		return
	end

	for iter_54_0, iter_54_1 in pairs(arg_54_0._slotItem) do
		if iter_54_1:getCamp() == arg_54_1 then
			arg_54_0:slotPlayAniName(iter_54_0, Activity201MaLiAnNaEnum.slotAnimName.skill, arg_54_2)
		end
	end
end

function var_0_0.slotPlayAniName(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if arg_55_0._cacheSlotResetAniName == nil then
		arg_55_0._cacheSlotResetAniName = {}
	end

	local var_55_0 = arg_55_0._slotItem[arg_55_1]

	if var_55_0 == nil then
		return
	end

	local var_55_1 = arg_55_2

	if arg_55_3 then
		if arg_55_0._cacheSlotResetAniName[arg_55_1] then
			if var_55_0:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
				var_55_1 = Activity201MaLiAnNaEnum.slotAnimName.myIdle
			end

			if var_55_0:getCamp() == Activity201MaLiAnNaEnum.CampType.Enemy then
				var_55_1 = Activity201MaLiAnNaEnum.slotAnimName.enemyIdle
			end

			if var_55_0:getCamp() == Activity201MaLiAnNaEnum.CampType.Middle then
				var_55_1 = Activity201MaLiAnNaEnum.slotAnimName.middle
			end
		end

		arg_55_0._cacheSlotResetAniName[arg_55_1] = nil
	else
		arg_55_0._cacheSlotResetAniName[arg_55_1] = true
	end

	if not string.nilorempty(var_55_1) then
		var_55_0:playAnim(var_55_1)
	end
end

function var_0_0._showShowVX(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	if arg_56_1 == nil or arg_56_2 == nil then
		return
	end

	local var_56_0 = arg_56_0._slotItem[arg_56_1]

	if var_56_0 ~= nil then
		var_56_0:showVxBySkill(arg_56_2, arg_56_3)
	end
end

function var_0_0._generateSolider(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_1 == nil or arg_57_2 == nil then
		return
	end

	local var_57_0 = arg_57_0._slotItem[arg_57_1]

	if var_57_0 ~= nil then
		var_57_0:showAddSolider(arg_57_2)
	end
end

function var_0_0._soliderHpChange(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_0._heroSoliderItem == nil then
		return
	end

	local var_58_0 = arg_58_0._heroSoliderItem[arg_58_1]

	if var_58_0 then
		var_58_0:showDiff(arg_58_2)
	end
end

function var_0_0.onClose(arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnGameReStart, arg_59_0._onGameReStart, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnRefreshView, arg_59_0._refreshView, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragBeginSlot, arg_59_0._onDragBeginSlot, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragSlot, arg_59_0._onDragSlot, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnDragEndSlot, arg_59_0._onDragEndSlot, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnShowBattleEffect, arg_59_0._onShowBattleEffect, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnSelectActiveSkill, arg_59_0._onSelectActiveSkill, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.OnClickSlot, arg_59_0._onClickSlot, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowDisPatchPath, arg_59_0.showDispatchPathByAI, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowBattleEvent, arg_59_0.addEventInfo, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.ShowShowVX, arg_59_0._showShowVX, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.GenerateSolider, arg_59_0._generateSolider, arg_59_0)
	arg_59_0:removeEventCb(Activity201MaLiAnNaGameController.instance, Activity201MaLiAnNaEvent.SoliderHpChange, arg_59_0._soliderHpChange, arg_59_0)

	arg_59_0._aiDisPatchInfo = nil
	arg_59_0._cacheSlotResetAniName = nil
	arg_59_0._lastShowDragSlotId = nil

	if arg_59_0._switchClick then
		arg_59_0._switchClick:RemoveClickListener()

		arg_59_0._switchClick = nil
	end

	if arg_59_0._curLine ~= nil then
		arg_59_0._curLine = nil
	end

	if arg_59_0._lineItems then
		for iter_59_0, iter_59_1 in pairs(arg_59_0._lineItems) do
			if iter_59_1 ~= nil then
				for iter_59_2, iter_59_3 in pairs(iter_59_1) do
					if iter_59_3 then
						gohelper.destroy(iter_59_3.gameObject)
					end
				end
			end
		end

		arg_59_0._lineItems = nil
	end

	if arg_59_0._lineItemPools ~= nil then
		for iter_59_4, iter_59_5 in pairs(arg_59_0._lineItemPools) do
			iter_59_5:dispose()

			iter_59_5 = nil
		end

		arg_59_0._lineItemPools = nil
	end

	TaskDispatcher.cancelTask(arg_59_0._hideDispatchPathByAI, arg_59_0)
	Activity201MaLiAnNaGameController.instance:exitGame()
end

function var_0_0.onDestroyView(arg_60_0)
	MaliAnNaSoliderEntityMgr.instance:onDestroy()
	MaliAnNaBulletEntityMgr.instance:onDestroy()
end

return var_0_0
