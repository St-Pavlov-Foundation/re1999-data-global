module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessEntity", package.seeall)

local var_0_0 = class("AutoChessEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.goEntity = gohelper.findChild(arg_1_1, "ani/Entity")
	arg_1_0.dirTrs = arg_1_0.goEntity.transform
	arg_1_0.goMesh = gohelper.findChild(arg_1_1, "ani/Entity/Mesh")
	arg_1_0.goBar = gohelper.findChild(arg_1_1, "ani/ChessBar")
	arg_1_0.goAttack = gohelper.findChild(arg_1_0.goBar, "go_Attack")
	arg_1_0.txtAttack = gohelper.findChildText(arg_1_0.goBar, "go_Attack/txt_Attack")
	arg_1_0.goHp = gohelper.findChild(arg_1_0.goBar, "go_Hp")
	arg_1_0.txtHp = gohelper.findChildText(arg_1_0.goBar, "go_Hp/txt_Hp")
	arg_1_0.imageLevel = gohelper.findChildImage(arg_1_0.goBar, "image_Level")
	arg_1_0.txtLevel = gohelper.findChildText(arg_1_0.goBar, "Exp/txt_Level")
	arg_1_0.goStar = gohelper.findChild(arg_1_0.goBar, "Exp/go_Star")
	arg_1_0.golvup = gohelper.findChild(arg_1_0.goBar, "Exp/go_lvup")
	arg_1_0.goStar1 = gohelper.findChild(arg_1_0.goBar, "Exp/go_Star/go_Star1")
	arg_1_0.imageLight1 = gohelper.findChildImage(arg_1_0.goBar, "Exp/go_Star/go_Star1/image_Light1")
	arg_1_0.goStar2 = gohelper.findChild(arg_1_0.goBar, "Exp/go_Star/go_Star2")
	arg_1_0.imageLight2 = gohelper.findChildImage(arg_1_0.goBar, "Exp/go_Star/go_Star2/image_Light2")
	arg_1_0.goStar3 = gohelper.findChild(arg_1_0.goBar, "Exp/go_Star/go_Star3")
	arg_1_0.imageLight3 = gohelper.findChildImage(arg_1_0.goBar, "Exp/go_Star/go_Star3/image_Light3")
	arg_1_0.golvup = gohelper.findChild(arg_1_0.goBar, "Exp/go_lvup")
	arg_1_0.anim = gohelper.findChild(arg_1_1, "ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0.goHpFloat = gohelper.findChild(arg_1_0.goBar, "go_HpFloat")
	arg_1_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goMesh, AutoChessMeshComp)
	arg_1_0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goEntity, AutoChessEffectComp)
	arg_1_0.goEffLight = gohelper.findChild(arg_1_1, "ani/go_EffLight")
	arg_1_0.animStar1 = arg_1_0.goStar1:GetComponent(gohelper.Type_Animator)
	arg_1_0.animStar2 = arg_1_0.goStar2:GetComponent(gohelper.Type_Animator)
	arg_1_0.animStar3 = arg_1_0.goStar3:GetComponent(gohelper.Type_Animator)
	arg_1_0.goFlyStar = gohelper.findChild(arg_1_1, "ani/go_FlyStar")
	arg_1_0.goFlyStar1 = gohelper.findChild(arg_1_1, "ani/go_FlyStar/star1")
	arg_1_0.goFlyStar2 = gohelper.findChild(arg_1_1, "ani/go_FlyStar/star2")
	arg_1_0.goFlyStar3 = gohelper.findChild(arg_1_1, "ani/go_FlyStar/star3")
	arg_1_0.goFlyStar4 = gohelper.findChild(arg_1_1, "ani/go_FlyStar/star4")
	arg_1_0.goFlyStar5 = gohelper.findChild(arg_1_1, "ani/go_FlyStar/star5")

	arg_1_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntity, arg_1_0.onDragChess, arg_1_0)
	arg_1_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, arg_1_0.onDragChessEnd, arg_1_0)
	arg_1_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, arg_1_0.onDragChess, arg_1_0)
	arg_1_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, arg_1_0.onDragChessEnd, arg_1_0)

	arg_1_0.goExp = gohelper.findChild(arg_1_0.goBar, "Exp")
	arg_1_0.floatItemList = {}
	arg_1_0.floatItemCacheList = {}
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(AutoChessController.instance, AutoChessEvent.UsingLeaderSkill, arg_2_0.onUsingLeaderSkill, arg_2_0)
end

function var_0_0.onUsingLeaderSkill(arg_3_0, arg_3_1)
	if arg_3_1 then
		local var_3_0 = AutoChessGameModel.instance.targetTypes

		if tabletool.indexOf(var_3_0, arg_3_0.config.type) then
			gohelper.setActive(arg_3_0.goEffLight, true)

			return
		end
	end

	gohelper.setActive(arg_3_0.goEffLight, false)
end

function var_0_0.onDragChess(arg_4_0, arg_4_1)
	if arg_4_0.data.id == arg_4_1.id and arg_4_0.data.maxExpLimit ~= 0 then
		arg_4_0.lightIndex = arg_4_0.data.exp + 1

		gohelper.setActive(arg_4_0["imageLight" .. arg_4_0.lightIndex].gameObject, true)
		arg_4_0["animStar" .. arg_4_0.lightIndex]:Play("loop", 0, 0)
	end
end

function var_0_0.onDragChessEnd(arg_5_0)
	if arg_5_0.lightIndex then
		arg_5_0["animStar" .. arg_5_0.lightIndex]:Play("idle", 0, 0)
		gohelper.setActive(arg_5_0["imageLight" .. arg_5_0.lightIndex].gameObject, false)

		arg_5_0.lightIndex = nil
	end
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.delayFly, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.checkHpFloat, arg_6_0)
end

function var_0_0.setData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:initChessData(arg_7_1)

	arg_7_0.warZone = arg_7_2
	arg_7_0.index = arg_7_3
	arg_7_0.teamType = arg_7_0.data.teamType
	arg_7_0.config = AutoChessConfig.instance:getChessCfgById(arg_7_0.data.id, arg_7_0.data.star)
	arg_7_0.skillIds = {}

	if not string.nilorempty(arg_7_0.config.skillIds) then
		arg_7_0.skillIds = string.splitToNumber(arg_7_0.config.skillIds, "#")
	end

	local var_7_0 = arg_7_0.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1

	transformhelper.setLocalScale(arg_7_0.dirTrs, var_7_0, 1, 1)
	arg_7_0.meshComp:setData(arg_7_0.config.image, arg_7_0.teamType == AutoChessEnum.TeamType.Enemy)
	arg_7_0:refreshUI()
	arg_7_0:show()

	if arg_7_0.config.type == AutoChessStrEnum.ChessType.Incubate and arg_7_0.data.cd == 0 then
		arg_7_0.anim:Play("box_loop", 0, 0)
	end
end

function var_0_0.updateIndex(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.warZone = arg_8_1
	arg_8_0.index = arg_8_2

	arg_8_0:show()
end

function var_0_0.updateLocation(arg_9_0)
	arg_9_0.pos = AutoChessGameModel.instance:getChessLocation(arg_9_0.warZone, arg_9_0.index + 1)

	recthelper.setAnchor(arg_9_0.transform, arg_9_0.pos.x, arg_9_0.pos.y)
end

function var_0_0.setScale(arg_10_0, arg_10_1)
	transformhelper.setLocalScale(arg_10_0.transform, arg_10_1, arg_10_1, arg_10_1)
end

function var_0_0.initChessData(arg_11_0, arg_11_1)
	arg_11_0.data = arg_11_1
	arg_11_0.data.battle = tonumber(arg_11_0.data.battle)
	arg_11_0.data.hp = tonumber(arg_11_0.data.hp)
end

function var_0_0.updateChessData(arg_12_0, arg_12_1)
	arg_12_0.data.id = arg_12_1.id
	arg_12_0.data.uid = arg_12_1.uid
	arg_12_0.data.star = arg_12_1.star
	arg_12_0.data.exp = arg_12_1.exp
	arg_12_0.data.maxExpLimit = arg_12_1.maxExpLimit
	arg_12_0.data.status = arg_12_1.status
	arg_12_0.data.hp = tonumber(arg_12_1.hp)
	arg_12_0.data.battle = tonumber(arg_12_1.battle)
	arg_12_0.data.skillContainer = arg_12_1.skillContainer
	arg_12_0.data.buffContainer = arg_12_1.buffContainer
end

function var_0_0.move(arg_13_0, arg_13_1)
	arg_13_0.index = tonumber(arg_13_1)
	arg_13_0.pos = AutoChessGameModel.instance:getChessLocation(arg_13_0.warZone, arg_13_0.index + 1)

	ZProj.TweenHelper.DOAnchorPosX(arg_13_0.transform, arg_13_0.pos.x, AutoChessEnum.ChessAniTime.Jump)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_move)
	arg_13_0.anim:Play("jump", 0, 0)
end

function var_0_0.attack(arg_14_0)
	arg_14_0.anim:Play("melee", 0, 0)
end

function var_0_0.ranged(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setAsLastSibling(arg_15_0.go)
	arg_15_0.anim:Play("attack", 0, 0)
	arg_15_0.effectComp:playEffect(arg_15_2.id)
	arg_15_0.effectComp:moveEffect(arg_15_2.nameUp, arg_15_1, arg_15_2.duration)
end

function var_0_0.skillAnim(arg_16_0, arg_16_1)
	arg_16_0.anim:Play(arg_16_1, 0, 0)

	return AutoChessEnum.ChessAniTime.Jump
end

function var_0_0.resetPos(arg_17_0)
	ZProj.TweenHelper.DOAnchorPosX(arg_17_0.transform, arg_17_0.pos.x, 0.5)
end

function var_0_0.initBuffEffect(arg_18_0)
	arg_18_0.effectComp:hideAll()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.data.buffContainer.buffs) do
		local var_18_0 = lua_auto_chess_buff.configDict[iter_18_1.id].buffeffectID

		if var_18_0 ~= 0 then
			local var_18_1 = lua_auto_chess_effect.configDict[var_18_0]

			if var_18_1.loop == 1 then
				arg_18_0.effectComp:playEffect(var_18_1.id)
			end
		end
	end

	local var_18_2 = arg_18_0.config.tag

	if not string.nilorempty(var_18_2) then
		arg_18_0.effectComp:playEffect(AutoChessEnum.Tag2EffectId[var_18_2])
	end
end

function var_0_0.addBuffEffect(arg_19_0, arg_19_1)
	local var_19_0 = lua_auto_chess_buff.configDict[arg_19_1]

	if var_19_0.buffeffectID ~= 0 then
		arg_19_0.effectComp:playEffect(var_19_0.buffeffectID)
	end
end

function var_0_0.addBuff(arg_20_0, arg_20_1)
	arg_20_0:addBuffEffect(arg_20_1.id)
	table.insert(arg_20_0.data.buffContainer.buffs, arg_20_1)
end

function var_0_0.updateBuff(arg_21_0, arg_21_1)
	arg_21_0:addBuffEffect(arg_21_1.id)

	local var_21_0 = arg_21_0.data.buffContainer.buffs

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1.uid == arg_21_1.uid then
			var_21_0[iter_21_0] = arg_21_1

			break
		end
	end
end

function var_0_0.delBuff(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.data.buffContainer.buffs
	local var_22_1

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.uid == arg_22_1 then
			var_22_1 = iter_22_0

			break
		end
	end

	if var_22_1 then
		local var_22_2 = var_22_0[var_22_1]
		local var_22_3 = lua_auto_chess_buff.configDict[var_22_2.id]

		if var_22_3.buffeffectID ~= 0 then
			arg_22_0.effectComp:removeEffect(var_22_3.buffeffectID)
		end

		table.remove(var_22_0, var_22_1)
	else
		logError(string.format("异常:未找到buffUid%s", arg_22_1))
	end
end

function var_0_0.die(arg_23_0, arg_23_1)
	arg_23_0.anim:Play("die", 0, 0)

	if arg_23_1 and #arg_23_0.skillIds ~= 0 then
		local var_23_0 = lua_auto_chess_skill.configDict[arg_23_0.skillIds[1]]

		if var_23_0.tag == "Die" and var_23_0.useeffect ~= 0 then
			arg_23_0.effectComp:playEffect(var_23_0.useeffect)

			return var_23_0.useeffect
		end
	end
end

function var_0_0.activeExpStar(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0.goStar, arg_24_1)
end

function var_0_0.hide(arg_25_0)
	gohelper.setActive(arg_25_0.go, false)
end

function var_0_0.show(arg_26_0)
	arg_26_0:updateLocation()
	gohelper.setActive(arg_26_0.go, true)
end

function var_0_0.updateHp(arg_27_0, arg_27_1)
	arg_27_1 = tonumber(arg_27_1)
	arg_27_0.data.hp = arg_27_0.data.hp + arg_27_1

	arg_27_0:refreshAttr()
end

function var_0_0.floatHp(arg_28_0, arg_28_1, arg_28_2)
	TaskDispatcher.cancelTask(arg_28_0.checkHpFloat, arg_28_0)
	TaskDispatcher.runRepeat(arg_28_0.checkHpFloat, arg_28_0, 0.5)

	local var_28_0
	local var_28_1 = #arg_28_0.floatItemCacheList

	if var_28_1 > 0 then
		var_28_0 = arg_28_0.floatItemCacheList[var_28_1]
		arg_28_0.floatItemCacheList[var_28_1] = nil
	else
		var_28_0 = arg_28_0:getUserDataTb_()
		var_28_0.go = gohelper.cloneInPlace(arg_28_0.goHpFloat)
		var_28_0.anim = var_28_0.go:GetComponent(gohelper.Type_Animator)
		var_28_0.txtHpAdd = gohelper.findChildText(var_28_0.go, "txt_HpAdd")
		var_28_0.txtHpSub = gohelper.findChildText(var_28_0.go, "txt_HpSub")
		var_28_0.txtHpPoison = gohelper.findChildText(var_28_0.go, "txt_HpPoison")
	end

	var_28_0.time = Time.time
	arg_28_0.floatItemList[#arg_28_0.floatItemList + 1] = var_28_0

	gohelper.setActive(var_28_0.go, true)

	arg_28_1 = tonumber(arg_28_1)

	if tonumber(arg_28_2) == AutoChessEnum.HpFloatType.Attack then
		var_28_0.txtHpSub.text = arg_28_1

		var_28_0.anim:Play("hpsub", 0, 0)
	elseif tonumber(arg_28_2) == AutoChessEnum.HpFloatType.Poison then
		var_28_0.txtHpPoison.text = arg_28_1

		var_28_0.anim:Play("hpposion", 0, 0)
	elseif tonumber(arg_28_2) == AutoChessEnum.HpFloatType.Cure then
		var_28_0.txtHpAdd.text = "+" .. arg_28_1

		var_28_0.anim:Play("hpadd", 0, 0)
	end
end

function var_0_0.updateBattle(arg_29_0, arg_29_1)
	arg_29_1 = tonumber(arg_29_1)
	arg_29_0.data.battle = arg_29_0.data.battle + arg_29_1

	arg_29_0:refreshAttr()
end

function var_0_0.updateExp(arg_30_0, arg_30_1)
	arg_30_1 = tonumber(arg_30_1)
	arg_30_0.data.exp = arg_30_1 > arg_30_0.data.maxExpLimit and arg_30_0.data.maxExpLimit or arg_30_1

	arg_30_0:refreshExp()
end

function var_0_0.updateStar(arg_31_0, arg_31_1)
	arg_31_0:initChessData(arg_31_1)
	arg_31_0:refreshUI()

	return arg_31_0.effectComp:playEffect(50001)
end

function var_0_0.refreshUI(arg_32_0)
	arg_32_0:initBuffEffect()
	arg_32_0:refreshAttr()
	arg_32_0:refreshStar()
	arg_32_0:refreshExp()
end

function var_0_0.refreshAttr(arg_33_0)
	if arg_33_0.config.type == AutoChessStrEnum.ChessType.Attack then
		arg_33_0.txtAttack.text = arg_33_0.data.battle
		arg_33_0.txtHp.text = arg_33_0.data.hp

		gohelper.setActive(arg_33_0.goAttack, true)
		gohelper.setActive(arg_33_0.goHp, true)
	else
		gohelper.setActive(arg_33_0.goAttack, false)
		gohelper.setActive(arg_33_0.goHp, false)
	end
end

function var_0_0.refreshExp(arg_34_0)
	for iter_34_0 = 1, 3 do
		local var_34_0 = arg_34_0["imageLight" .. iter_34_0]

		gohelper.setActive(var_34_0, iter_34_0 <= arg_34_0.data.exp)
	end
end

function var_0_0.refreshStar(arg_35_0)
	if arg_35_0.data.star == 0 then
		gohelper.setActive(arg_35_0.imageLevel, false)
		gohelper.setActive(arg_35_0.goExp, false)
	else
		local var_35_0 = luaLang("autochess_malllevelupview_level")

		UISpriteSetMgr.instance:setAutoChessSprite(arg_35_0.imageLevel, "v2a5_autochess_levelbg_" .. arg_35_0.data.star)

		arg_35_0.txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_35_0, arg_35_0.data.star)

		local var_35_1 = arg_35_0.data.maxExpLimit

		if var_35_1 == 0 then
			gohelper.setActive(arg_35_0.goStar, false)
		else
			for iter_35_0 = 1, 3 do
				local var_35_2 = arg_35_0["goStar" .. iter_35_0]

				gohelper.setActive(var_35_2, iter_35_0 <= var_35_1)
			end

			gohelper.setActive(arg_35_0.goStar, true)
		end
	end
end

function var_0_0.checkHpFloat(arg_36_0)
	local var_36_0 = Time.time

	for iter_36_0 = #arg_36_0.floatItemList, 1, -1 do
		local var_36_1 = arg_36_0.floatItemList[iter_36_0]

		if var_36_0 - var_36_1.time >= 1 then
			gohelper.setActive(var_36_1.go, false)

			arg_36_0.floatItemCacheList[#arg_36_0.floatItemCacheList + 1] = var_36_1

			table.remove(arg_36_0.floatItemList, iter_36_0)
		end
	end

	if #arg_36_0.floatItemList == 0 then
		TaskDispatcher.cancelTask(arg_36_0.checkHpFloat, arg_36_0)
	end
end

function var_0_0.flyStar(arg_37_0)
	local var_37_0 = arg_37_0.config.levelFromMall

	var_37_0 = var_37_0 < 5 and var_37_0 or 5

	for iter_37_0 = 1, var_37_0 do
		gohelper.setActive(arg_37_0["goFlyStar" .. iter_37_0], true)
	end

	gohelper.setActive(arg_37_0.goFlyStar, true)
	TaskDispatcher.runDelay(arg_37_0.delayFly, arg_37_0, 0.6)
end

function var_0_0.delayFly(arg_38_0)
	local var_38_0 = AutoChessModel.instance:getChessMo().lastSvrFight
	local var_38_1

	if arg_38_0.teamType == AutoChessEnum.TeamType.Player then
		var_38_1 = var_38_0.mySideMaster.uid
	else
		var_38_1 = var_38_0.enemyMaster.uid
	end

	local var_38_2 = AutoChessEntityMgr.instance:getLeaderEntity(var_38_1)

	if var_38_2 then
		local var_38_3, var_38_4, var_38_5 = transformhelper.getPos(var_38_2.go.transform)
		local var_38_6 = recthelper.rectToRelativeAnchorPos(Vector3(var_38_3, var_38_4, var_38_5), arg_38_0.goFlyStar.transform)
		local var_38_7 = arg_38_0.config.levelFromMall

		var_38_7 = var_38_7 < 5 and var_38_7 or 5

		for iter_38_0 = 1, var_38_7 do
			local var_38_8 = arg_38_0["goFlyStar" .. iter_38_0].transform

			ZProj.TweenHelper.DOAnchorPos(var_38_8, var_38_6.x, var_38_6.y, 0.5)
		end
	end
end

return var_0_0
