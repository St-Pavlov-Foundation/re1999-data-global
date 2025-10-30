module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaSlotItem", package.seeall)

local var_0_0 = class("MaLiAnNaSlotItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageShieldskill = gohelper.findChildImage(arg_1_0.viewGO, "#image_Shield_skill")
	arg_1_0._imageShieldskillBG = gohelper.findChildImage(arg_1_0.viewGO, "#image_Shield_skillBG")
	arg_1_0._imageFlagenemy = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_enemy")
	arg_1_0._imageFlagenemy1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_enemy/#image_Flag_enemy1")
	arg_1_0._imageframeenemy = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_enemy/#image_frame_enemy")
	arg_1_0._imageframeenemy1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_enemy/#image_frame_enemy1")
	arg_1_0._imageFlagmiddle = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_middle")
	arg_1_0._imageframemiddle = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_middle/#image_frame_middle")
	arg_1_0._imageframemiddle1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_middle/#image_frame_middle1")
	arg_1_0._imageFlagmy = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_my")
	arg_1_0._imageFlagmy1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_my/#image_Flag_my1")
	arg_1_0._imageframemy = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_my/#image_frame_my")
	arg_1_0._imageframemy1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Flag_my/#image_frame_my1")
	arg_1_0._gowhite = gohelper.findChild(arg_1_0.viewGO, "Name/#go_white")
	arg_1_0._txtnamemy = gohelper.findChildText(arg_1_0.viewGO, "Name/#go_white/#txt_name_my")
	arg_1_0._goblue = gohelper.findChild(arg_1_0.viewGO, "Name/#go_blue")
	arg_1_0._txtnameenemy = gohelper.findChildText(arg_1_0.viewGO, "Name/#go_blue/#txt_name_enemy")
	arg_1_0._gocrossPoint = gohelper.findChild(arg_1_0.viewGO, "#go_crossPoint")
	arg_1_0._imageIcon1 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon1")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon")
	arg_1_0._imageIcon2 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon2")
	arg_1_0._imageIcon3 = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon3")
	arg_1_0._goRole = gohelper.findChild(arg_1_0.viewGO, "RoleList/#go_Role")
	arg_1_0._txthp = gohelper.findChildText(arg_1_0.viewGO, "RoleList/#go_Role/hp/#txt_hp")
	arg_1_0._goSolider = gohelper.findChild(arg_1_0.viewGO, "RoleList/#go_Solider")
	arg_1_0._imageBG = gohelper.findChildImage(arg_1_0.viewGO, "RoleList/#go_Solider/#image_BG")
	arg_1_0._txtRoleHP = gohelper.findChildText(arg_1_0.viewGO, "RoleList/#go_Solider/image_RoleHPNumBG/#txt_RoleHP")
	arg_1_0._txtaddHP = gohelper.findChildText(arg_1_0.viewGO, "RoleList/#go_Solider/#txt_addHP")
	arg_1_0._govxboom = gohelper.findChild(arg_1_0.viewGO, "vx_eff/#go_vx_boom")
	arg_1_0._govxheal = gohelper.findChild(arg_1_0.viewGO, "vx_eff/#go_vx_heal")
	arg_1_0._govxglitch = gohelper.findChild(arg_1_0.viewGO, "vx_eff/#go_vx_glitch")
	arg_1_0._govxflash = gohelper.findChild(arg_1_0.viewGO, "vx_eff/#go_vx_flash")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tr = arg_4_0.viewGO.transform
	arg_4_0._parent = arg_4_0._tr.parent
	arg_4_0._playerCanvasGroup = arg_4_0._imageFlagmy:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0._enemyCanvasGroup = arg_4_0._imageFlagenemy:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0._middleCanvasGroup = arg_4_0._imageFlagmiddle:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0._middleFrameCanvasGroup = arg_4_0._imageframemiddle:GetComponent(gohelper.Type_CanvasGroup)

	CommonDragHelper.instance:registerDragObj(arg_4_0.viewGO, arg_4_0._beginDrag, arg_4_0._onDrag, arg_4_0._endDrag, arg_4_0._checkDrag, arg_4_0, nil, true)

	arg_4_0._click = gohelper.getClickWithDefaultAudio(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0.onClick, arg_4_0)

	arg_4_0._goShieldskill = arg_4_0._imageShieldskill.gameObject

	gohelper.setActive(arg_4_0._goShieldskill, false)
	gohelper.setActive(arg_4_0._imageShieldskillBG.gameObject, false)

	arg_4_0._anim = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0._crossPointCanvasGroup = arg_4_0._gocrossPoint:GetComponent(gohelper.Type_CanvasGroup)
	arg_4_0._crossPointCanvasGroup.alpha = 0
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onClick(arg_7_0)
	if arg_7_0._slotData == nil then
		return
	end

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnClickSlot, arg_7_0._slotData:getId())
end

function var_0_0._beginDrag(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragBeginSlot, arg_8_0._slotData:getId(), var_8_0.x, var_8_0.y)
end

function var_0_0._onDrag(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragSlot, arg_9_0._slotData:getId(), var_9_0.x, var_9_0.y)
end

function var_0_0._endDrag(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragEndSlot, arg_10_0._slotData:getId(), var_10_0.x, var_10_0.y)
end

function var_0_0._checkDrag(arg_11_0)
	if arg_11_0._slotData == nil then
		return true
	end

	return arg_11_0._slotData:getSlotCamp() ~= Activity201MaLiAnNaEnum.CampType.Player or not not Activity201MaLiAnNaGameController.instance:getPause()
end

function var_0_0.initData(arg_12_0, arg_12_1)
	arg_12_0._slotData = arg_12_1
	arg_12_0._lastCamp = nil
	arg_12_0._soliderCount = nil
	arg_12_0._heroCount = nil

	local var_12_0 = arg_12_0._slotData:getConfig().picture

	UISpriteSetMgr.instance:setMaliAnNaSprite(arg_12_0._imageIcon, var_12_0)

	local var_12_1 = string.gsub(var_12_0, "_0", "_1")

	UISpriteSetMgr.instance:setMaliAnNaSprite(arg_12_0._imageIcon1, var_12_1)
	UISpriteSetMgr.instance:setMaliAnNaSprite(arg_12_0._imageIcon2, var_12_1)
	UISpriteSetMgr.instance:setMaliAnNaSprite(arg_12_0._imageIcon3, var_12_1)

	local var_12_2, var_12_3 = arg_12_0._slotData:getPosXY()

	arg_12_0:initPos(var_12_2, var_12_3)

	if arg_12_0._goSoliderItem == nil then
		arg_12_0._goSoliderItem = arg_12_0:getSoliderItemClone()
	end

	if arg_12_0._heroItemList == nil then
		arg_12_0._heroItemList = arg_12_0:getUserDataTb_()
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0._heroItemList) do
		iter_12_1.canvasGroup.alpha = 0
	end

	arg_12_0:_initSkill()

	local var_12_4 = arg_12_0._slotData:getConfig()
	local var_12_5 = Activity201MaLiAnNaGameModel.instance:isMyCampBase(var_12_4.baseId)
	local var_12_6 = Activity201MaLiAnNaGameModel.instance:isEnemyBase(var_12_4.baseId)

	gohelper.setActive(arg_12_0._gowhite, var_12_5)
	gohelper.setActive(arg_12_0._goblue, var_12_6)
end

function var_0_0.getCamp(arg_13_0)
	return arg_13_0._slotData:getSlotCamp()
end

function var_0_0._initSkill(arg_14_0)
	local var_14_0 = arg_14_0._slotData:getSkill()

	if var_14_0 ~= nil and isTypeOf(var_14_0, MaLiAnNaSlotShieldPassiveSkill) and var_14_0:getAngleAndRange() ~= nil then
		gohelper.setActive(arg_14_0._goShieldskill, true)

		local var_14_1, var_14_2 = var_14_0:getAngleAndRange()

		transformhelper.setLocalRotation(arg_14_0._goShieldskill.transform, 0, 0, var_14_1)

		arg_14_0._imageShieldskill.fillAmount = var_14_2 / 360
	end

	if var_14_0 and isTypeOf(var_14_0, MaLiAnNaSlotKillSoliderPassiveSkill) then
		gohelper.setActive(arg_14_0._imageShieldskillBG.gameObject, true)

		local var_14_3 = var_14_0:getEffect()[2]

		if var_14_3 then
			local var_14_4 = var_14_3 / 178

			transformhelper.setLocalScale(arg_14_0._imageShieldskillBG.transform, var_14_4, var_14_4, var_14_4)
		end
	end
end

function var_0_0.getRoleItemClone(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = gohelper.cloneInPlace(arg_15_0._goRole, "soliderItem")

	gohelper.setActive(var_15_1, true)

	var_15_0.go = var_15_1
	var_15_0.tr = var_15_1.transform
	var_15_0.goSelf = gohelper.findChild(var_15_1, "go_Self")
	var_15_0.goEnemy = gohelper.findChild(var_15_1, "go_Enemy")
	var_15_0.goDead = gohelper.findChild(var_15_1, "go_Dead")
	var_15_0.goHp = gohelper.findChild(var_15_1, "hp")
	var_15_0.txtHp = gohelper.findChildText(var_15_1, "hp/#txt_hp")
	var_15_0.simage = gohelper.findChildSingleImage(var_15_1, "image/simage_Role")

	return var_15_0
end

function var_0_0.getSoliderItemClone(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = gohelper.cloneInPlace(arg_16_0._goSolider, "soliderItem")

	var_16_0.go = var_16_1
	var_16_0.goAddHp = gohelper.findChild(var_16_1, "#txt_addHP")
	var_16_0.txtAddHp = gohelper.findChildText(var_16_1, "#txt_addHP")
	var_16_0.canvasGroup = var_16_1:GetComponent(gohelper.Type_CanvasGroup)
	var_16_0.txtNum = gohelper.findChildText(var_16_1, "image_RoleHPNumBG/#txt_RoleHP")
	var_16_0.imageBg = gohelper.findChildImage(var_16_1, "#image_BG")
	var_16_0.goDead = gohelper.findChild(var_16_1, "go_Dead")
	var_16_0.simage = gohelper.findChildSingleImage(var_16_1, "image/simage_solider")

	gohelper.setActive(var_16_0.goAddHp, false)
	gohelper.setActive(var_16_1, true)

	return var_16_0
end

function var_0_0.updateInfo(arg_17_0, arg_17_1)
	arg_17_0._slotData = arg_17_1

	local var_17_0 = arg_17_0._slotData:getSlotCamp()
	local var_17_1, var_17_2 = arg_17_0._slotData:getSoliderCount()
	local var_17_3 = false
	local var_17_4 = false

	if arg_17_0._lastCamp == nil or var_17_0 ~= arg_17_0._lastCamp then
		var_17_3 = true
		arg_17_0._lastCamp = var_17_0

		arg_17_0:_updateCamp()
		arg_17_0:reset()
	end

	if arg_17_0._soliderCount == nil or var_17_1 ~= arg_17_0._soliderCount then
		local var_17_5 = true

		arg_17_0._soliderCount = var_17_1

		arg_17_0:_updateSoliderItem()
	end

	arg_17_0._heroCount = var_17_2

	arg_17_0:_updateSoliderHeroItem()

	if var_17_3 then
		local var_17_6 = ""

		if arg_17_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy then
			var_17_6 = Activity201MaLiAnNaEnum.slotAnimName.enemy
		end

		if arg_17_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Player then
			var_17_6 = Activity201MaLiAnNaEnum.slotAnimName.my
		end

		if arg_17_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Middle then
			var_17_6 = Activity201MaLiAnNaEnum.slotAnimName.middle
		end

		arg_17_0:playAnim(var_17_6)
		arg_17_0:_updateSoliderItem()
	end
end

function var_0_0._updateCamp(arg_18_0)
	local var_18_0 = arg_18_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Player
	local var_18_1 = arg_18_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy
	local var_18_2 = arg_18_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Middle

	arg_18_0._enemyCanvasGroup.alpha = var_18_1 and 1 or 0
	arg_18_0._playerCanvasGroup.alpha = var_18_0 and 1 or 0
	arg_18_0._middleCanvasGroup.alpha = var_18_2 and 1 or 0
	arg_18_0._middleFrameCanvasGroup.alpha = var_18_2 and 1 or 0

	if arg_18_0._goSoliderItem then
		UISpriteSetMgr.instance:setMaliAnNaSprite(arg_18_0._goSoliderItem.imageBg, Activity201MaLiAnNaEnum.CampImageName[arg_18_0._lastCamp])
	end
end

function var_0_0._updateSoliderItem(arg_19_0)
	if arg_19_0._goSoliderItem then
		arg_19_0._goSoliderItem.canvasGroup.alpha = arg_19_0._soliderCount > 0 and 1 or 0
		arg_19_0._goSoliderItem.txtNum.text = arg_19_0._soliderCount

		gohelper.setActive(arg_19_0._goSoliderItem.goDead, false)

		local var_19_0 = arg_19_0._slotData:getNormalSolider()

		if var_19_0 then
			local var_19_1 = var_19_0:getConfig().icon

			if arg_19_0._goSoliderItem.sImageIcon == nil or arg_19_0._goSoliderItem.sImageIcon ~= var_19_1 then
				arg_19_0._goSoliderItem.simage:LoadImage(var_19_0:getSmallIcon())

				arg_19_0._goSoliderItem.sImageIcon = var_19_1
			end
		end
	end
end

function var_0_0._updateSoliderHeroItem(arg_20_0)
	local var_20_0 = arg_20_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Player
	local var_20_1 = arg_20_0._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy

	if arg_20_0._heroItemList then
		local var_20_2 = math.max(arg_20_0._heroCount, tabletool.len(arg_20_0._heroItemList))
		local var_20_3 = arg_20_0._slotData:getHeroSoliderList()

		for iter_20_0 = 1, var_20_2 do
			local var_20_4 = arg_20_0._heroItemList[iter_20_0]

			if var_20_4 == nil then
				var_20_4 = arg_20_0:getRoleItemClone()
				arg_20_0._heroItemList[iter_20_0] = var_20_4
			end

			local var_20_5 = iter_20_0 <= arg_20_0._heroCount

			if var_20_5 and not var_20_4.go.activeSelf then
				gohelper.setActive(var_20_4.go, true)
			end

			if not var_20_5 and var_20_4.go.activeSelf then
				gohelper.setActive(var_20_4.go, false)
			end

			if var_20_5 then
				gohelper.setActive(var_20_4.goSelf, var_20_0)
				gohelper.setActive(var_20_4.goEnemy, var_20_1)
				gohelper.setActive(var_20_4.goDead, false)

				local var_20_6 = var_20_3[iter_20_0]
				local var_20_7 = var_20_6:getConfig().icon

				if var_20_4.sImageIcon == nil or var_20_4.sImageIcon ~= var_20_7 then
					var_20_4.simage:LoadImage(var_20_6:getSmallIcon())

					var_20_4.sImageIcon = var_20_7
				end

				local var_20_8 = var_20_6:getHp()

				if var_20_4.hp == nil or var_20_4.hp ~= var_20_8 then
					gohelper.setActive(var_20_4.goHp, var_20_8 > 0)

					var_20_4.txtHp.text = var_20_8
					var_20_4.hp = var_20_8
				end

				local var_20_9, var_20_10 = transformhelper.getPos(var_20_4.tr)

				if var_20_4.x == nil or var_20_4.y == nil or var_20_4.x ~= var_20_9 or var_20_4.y ~= var_20_10 then
					local var_20_11 = arg_20_0._parent:InverseTransformPoint(var_20_4.tr.position)

					var_20_6:setCurViewPos(var_20_11.x, var_20_11.y)

					var_20_4.x = var_20_9
					var_20_4.y = var_20_10
				end
			end
		end
	end
end

function var_0_0.playAnim(arg_21_0, arg_21_1)
	if arg_21_0._anim and not string.nilorempty(arg_21_1) and arg_21_0._curAnimName ~= arg_21_1 then
		arg_21_0._anim:Play(arg_21_1, 0, 0)

		arg_21_0._curAnimName = arg_21_1
	end
end

function var_0_0.getAnimName(arg_22_0)
	return arg_22_0._curAnimName
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0:_hideAdd()
	TaskDispatcher.cancelTask(arg_23_0._hideAdd, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._playVx, arg_23_0)
	CommonDragHelper.instance:unregisterDragObj(arg_23_0.viewGO)

	if arg_23_0._click then
		arg_23_0._click:RemoveClickListener()

		arg_23_0._click = nil
	end
end

function var_0_0.initPos(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._localPosX = arg_24_1
	arg_24_0._localPosY = arg_24_2

	transformhelper.setLocalPosXY(arg_24_0._tr, arg_24_1, arg_24_2)
end

function var_0_0.showVxBySkill(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._needPlayGo = nil
	arg_25_0._needPlayAudioId = nil

	if arg_25_1 == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider then
		arg_25_0._needPlayGo = arg_25_0._govxheal
		arg_25_0._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_lushang_reinforce
	end

	if arg_25_1 == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		arg_25_0._needPlayGo = arg_25_0._govxboom
		arg_25_0._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_youyu_attack_3
	end

	if arg_25_1 == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		arg_25_0._needPlayGo = arg_25_0._govxflash
		arg_25_0._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_youyu_front_buff
	end

	if arg_25_1 == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider then
		arg_25_0._needPlayGo = arg_25_0._govxglitch
		arg_25_0._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_lushang_interference
	end

	if arg_25_2 == nil or arg_25_2 == 0 then
		arg_25_0:_playVx()
	else
		TaskDispatcher.runDelay(arg_25_0._playVx, arg_25_0, arg_25_2)
	end
end

function var_0_0._playVx(arg_26_0)
	if arg_26_0._needPlayGo ~= nil then
		if arg_26_0._needPlayGo.activeSelf then
			gohelper.setActive(arg_26_0._needPlayGo, false)
		end

		if arg_26_0._needPlayAudioId ~= nil then
			AudioMgr.instance:trigger(arg_26_0._needPlayAudioId)
		end

		gohelper.setActive(arg_26_0._needPlayGo, true)

		arg_26_0._needPlayGo = nil
	end
end

function var_0_0.reset(arg_27_0)
	arg_27_0._needPlayGo = nil
	arg_27_0._needPlayAudioId = nil

	gohelper.setActive(arg_27_0._govxheal, false)
	gohelper.setActive(arg_27_0._govxflash, false)
	gohelper.setActive(arg_27_0._govxglitch, false)

	if arg_27_0._heroItemList then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._heroItemList) do
			iter_27_1.x = nil
			iter_27_1.y = nil
			iter_27_1.hp = nil
		end
	end
end

function var_0_0.setMiddlePointActive(arg_28_0, arg_28_1)
	arg_28_0._crossPointCanvasGroup.alpha = arg_28_1 and 1 or 0
end

function var_0_0.showAddSolider(arg_29_0, arg_29_1)
	if arg_29_0._goSoliderItem == nil then
		return
	end

	if arg_29_0._goSoliderItem == nil or arg_29_0._goSoliderItem.goAddHp.activeSelf then
		gohelper.setActive(arg_29_0._goSoliderItem.goAddHp, false)
	end

	arg_29_0._goSoliderItem.txtAddHp.text = "+" .. arg_29_1

	gohelper.setActive(arg_29_0._goSoliderItem.goAddHp, true)
	TaskDispatcher.runDelay(arg_29_0._hideAdd, arg_29_0, 1)
end

function var_0_0._hideAdd(arg_30_0)
	if arg_30_0._goSoliderItem == nil then
		return
	end

	gohelper.setActive(arg_30_0._goSoliderItem.goAddHp, false)
end

return var_0_0
