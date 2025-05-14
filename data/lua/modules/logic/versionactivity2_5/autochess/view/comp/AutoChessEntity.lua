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
	arg_1_0.floatItemList = {}
	arg_1_0.floatItemCacheList = {}
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
end

function var_0_0.onDragChess(arg_2_0, arg_2_1)
	if arg_2_0.data.id == arg_2_1 and arg_2_0.data.maxExpLimit ~= 0 then
		arg_2_0.lightIndex = arg_2_0.data.exp + 1

		gohelper.setActive(arg_2_0["imageLight" .. arg_2_0.lightIndex].gameObject, true)
		arg_2_0["animStar" .. arg_2_0.lightIndex]:Play("loop", 0, 0)
	end
end

function var_0_0.onDragChessEnd(arg_3_0)
	if arg_3_0.lightIndex then
		arg_3_0["animStar" .. arg_3_0.lightIndex]:Play("idle", 0, 0)
		gohelper.setActive(arg_3_0["imageLight" .. arg_3_0.lightIndex].gameObject, false)

		arg_3_0.lightIndex = nil
	end
end

function var_0_0.onDestroy(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.delayFly, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.checkHpFloat, arg_4_0)
end

function var_0_0.setData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:initChessData(arg_5_1)

	arg_5_0.warZone = arg_5_2
	arg_5_0.index = arg_5_3
	arg_5_0.teamType = arg_5_0.data.teamType
	arg_5_0.config = lua_auto_chess.configDict[arg_5_1.id][arg_5_1.star]
	arg_5_0.skillIds = {}

	if not string.nilorempty(arg_5_0.config.skillIds) then
		arg_5_0.skillIds = string.splitToNumber(arg_5_0.config.skillIds, "#")
	end

	local var_5_0 = arg_5_0.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1

	transformhelper.setLocalScale(arg_5_0.dirTrs, var_5_0, 1, 1)
	arg_5_0.meshComp:setData(arg_5_0.config.image, arg_5_0.teamType == AutoChessEnum.TeamType.Enemy)
	arg_5_0:refreshUI()
	arg_5_0:show()
end

function var_0_0.updateIndex(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.warZone = arg_6_1
	arg_6_0.index = arg_6_2

	arg_6_0:show()
end

function var_0_0.updateLocation(arg_7_0)
	arg_7_0.pos = AutoChessGameModel.instance:getChessLocation(arg_7_0.warZone, arg_7_0.index + 1)

	recthelper.setAnchor(arg_7_0.transform, arg_7_0.pos.x, arg_7_0.pos.y)
end

function var_0_0.setScale(arg_8_0, arg_8_1)
	transformhelper.setLocalScale(arg_8_0.transform, arg_8_1, arg_8_1, arg_8_1)
end

function var_0_0.initChessData(arg_9_0, arg_9_1)
	arg_9_0.data = arg_9_1
	arg_9_0.data.battle = tonumber(arg_9_0.data.battle)
	arg_9_0.data.hp = tonumber(arg_9_0.data.hp)
end

function var_0_0.updateChessData(arg_10_0, arg_10_1)
	arg_10_0.data.id = arg_10_1.id
	arg_10_0.data.uid = arg_10_1.uid
	arg_10_0.data.star = arg_10_1.star
	arg_10_0.data.exp = arg_10_1.exp
	arg_10_0.data.maxExpLimit = arg_10_1.maxExpLimit
	arg_10_0.data.status = arg_10_1.status
	arg_10_0.data.hp = tonumber(arg_10_1.hp)
	arg_10_0.data.battle = tonumber(arg_10_1.battle)
	arg_10_0.data.skillContainer = arg_10_1.skillContainer
	arg_10_0.data.buffContainer = arg_10_1.buffContainer
end

function var_0_0.move(arg_11_0, arg_11_1)
	arg_11_1 = tonumber(arg_11_1)
	arg_11_0.pos = AutoChessGameModel.instance:getChessLocation(arg_11_0.warZone, arg_11_1 + 1)

	ZProj.TweenHelper.DOAnchorPosX(arg_11_0.transform, arg_11_0.pos.x, AutoChessEnum.ChessAniTime.Jump)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_move)
	arg_11_0.anim:Play("jump", 0, 0)
end

function var_0_0.attack(arg_12_0)
	arg_12_0.anim:Play("melee", 0, 0)
end

function var_0_0.ranged(arg_13_0, arg_13_1, arg_13_2)
	gohelper.setAsLastSibling(arg_13_0.go)
	arg_13_0.anim:Play("attack", 0, 0)
	arg_13_0.effectComp:playEffect(arg_13_2.id)
	arg_13_0.effectComp:moveEffect(arg_13_2.nameUp, arg_13_1, arg_13_2.duration)
end

function var_0_0.skillAnim(arg_14_0, arg_14_1)
	arg_14_0.anim:Play(arg_14_1, 0, 0)

	return AutoChessEnum.ChessAniTime.Jump
end

function var_0_0.resetPos(arg_15_0)
	ZProj.TweenHelper.DOAnchorPosX(arg_15_0.transform, arg_15_0.pos.x, 0.5)
end

function var_0_0.initBuffEffect(arg_16_0)
	arg_16_0.effectComp:hideAll()

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.data.buffContainer.buffs) do
		local var_16_0 = lua_auto_chess_buff.configDict[iter_16_1.id].buffeffectID

		if var_16_0 ~= 0 then
			local var_16_1 = lua_auto_chess_effect.configDict[var_16_0]

			if var_16_1.loop == 1 then
				arg_16_0.effectComp:playEffect(var_16_1.id)
			end
		end
	end

	local var_16_2 = arg_16_0.config.tag

	if not string.nilorempty(var_16_2) then
		arg_16_0.effectComp:playEffect(AutoChessStrEnum.Tag2EffectId[var_16_2])
	end
end

function var_0_0.addBuffEffect(arg_17_0, arg_17_1)
	local var_17_0 = lua_auto_chess_buff.configDict[arg_17_1]

	if var_17_0.buffeffectID ~= 0 then
		arg_17_0.effectComp:playEffect(var_17_0.buffeffectID)
	end
end

function var_0_0.addBuff(arg_18_0, arg_18_1)
	arg_18_0:addBuffEffect(arg_18_1.id)
	table.insert(arg_18_0.data.buffContainer.buffs, arg_18_1)
end

function var_0_0.updateBuff(arg_19_0, arg_19_1)
	arg_19_0:addBuffEffect(arg_19_1.id)

	local var_19_0 = arg_19_0.data.buffContainer.buffs

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.uid == arg_19_1.uid then
			var_19_0[iter_19_0] = arg_19_1

			break
		end
	end
end

function var_0_0.delBuff(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.data.buffContainer.buffs
	local var_20_1

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if iter_20_1.uid == arg_20_1 then
			var_20_1 = iter_20_0

			break
		end
	end

	if var_20_1 then
		local var_20_2 = var_20_0[var_20_1]
		local var_20_3 = lua_auto_chess_buff.configDict[var_20_2.id]

		if var_20_3.buffeffectID ~= 0 then
			arg_20_0.effectComp:removeEffect(var_20_3.buffeffectID)
		end

		table.remove(var_20_0, var_20_1)
	else
		logError(string.format("异常:未找到buffUid%s", arg_20_1))
	end
end

function var_0_0.die(arg_21_0, arg_21_1)
	arg_21_0.anim:Play("die", 0, 0)

	if arg_21_1 and #arg_21_0.skillIds ~= 0 then
		local var_21_0 = lua_auto_chess_skill.configDict[arg_21_0.skillIds[1]]

		if var_21_0.tag == "Die" and var_21_0.useeffect ~= 0 then
			arg_21_0.effectComp:playEffect(var_21_0.useeffect)

			return var_21_0.useeffect
		end
	end
end

function var_0_0.activeExpStar(arg_22_0, arg_22_1)
	gohelper.setActive(arg_22_0.goStar, arg_22_1)
end

function var_0_0.hide(arg_23_0)
	gohelper.setActive(arg_23_0.go, false)
end

function var_0_0.show(arg_24_0)
	arg_24_0:updateLocation()
	gohelper.setActive(arg_24_0.go, true)
end

function var_0_0.updateHp(arg_25_0, arg_25_1)
	arg_25_1 = tonumber(arg_25_1)
	arg_25_0.data.hp = arg_25_0.data.hp + arg_25_1

	arg_25_0:refreshAttr()
end

function var_0_0.floatHp(arg_26_0, arg_26_1)
	TaskDispatcher.cancelTask(arg_26_0.checkHpFloat, arg_26_0)
	TaskDispatcher.runRepeat(arg_26_0.checkHpFloat, arg_26_0, 0.5)

	local var_26_0
	local var_26_1 = #arg_26_0.floatItemCacheList

	if var_26_1 > 0 then
		var_26_0 = arg_26_0.floatItemCacheList[var_26_1]
		arg_26_0.floatItemCacheList[var_26_1] = nil
	else
		var_26_0 = arg_26_0:getUserDataTb_()
		var_26_0.go = gohelper.cloneInPlace(arg_26_0.goHpFloat)
		var_26_0.anim = var_26_0.go:GetComponent(gohelper.Type_Animator)
		var_26_0.txtHpAdd = gohelper.findChildText(var_26_0.go, "txt_HpAdd")
		var_26_0.txtHpSub = gohelper.findChildText(var_26_0.go, "txt_HpSub")
	end

	var_26_0.time = Time.time
	arg_26_0.floatItemList[#arg_26_0.floatItemList + 1] = var_26_0

	gohelper.setActive(var_26_0.go, true)

	arg_26_1 = tonumber(arg_26_1)

	if arg_26_1 > 0 then
		var_26_0.txtHpAdd.text = "+" .. arg_26_1

		var_26_0.anim:Play("hpadd", 0, 0)
	else
		var_26_0.txtHpSub.text = arg_26_1

		var_26_0.anim:Play("hpsub", 0, 0)
	end
end

function var_0_0.updateBattle(arg_27_0, arg_27_1)
	arg_27_1 = tonumber(arg_27_1)
	arg_27_0.data.battle = arg_27_0.data.battle + arg_27_1

	arg_27_0:refreshAttr()
end

function var_0_0.updateExp(arg_28_0, arg_28_1)
	arg_28_1 = tonumber(arg_28_1)
	arg_28_0.data.exp = arg_28_1 > arg_28_0.data.maxExpLimit and arg_28_0.data.maxExpLimit or arg_28_1

	arg_28_0:refreshExp()
end

function var_0_0.updateStar(arg_29_0, arg_29_1)
	arg_29_0:initChessData(arg_29_1)
	arg_29_0:refreshUI()

	return arg_29_0.effectComp:playEffect(50001)
end

function var_0_0.refreshUI(arg_30_0)
	arg_30_0:initBuffEffect()
	arg_30_0:refreshAttr()
	arg_30_0:refreshStar()
	arg_30_0:refreshExp()
end

function var_0_0.refreshAttr(arg_31_0)
	if arg_31_0.warZone == AutoChessEnum.WarZone.Two then
		gohelper.setActive(arg_31_0.goAttack, false)
		gohelper.setActive(arg_31_0.goHp, false)
	else
		arg_31_0.txtAttack.text = arg_31_0.data.battle
		arg_31_0.txtHp.text = arg_31_0.data.hp

		gohelper.setActive(arg_31_0.goAttack, true)
		gohelper.setActive(arg_31_0.goHp, true)
	end
end

function var_0_0.refreshExp(arg_32_0)
	for iter_32_0 = 1, 3 do
		local var_32_0 = arg_32_0["imageLight" .. iter_32_0]

		gohelper.setActive(var_32_0, iter_32_0 <= arg_32_0.data.exp)
	end
end

function var_0_0.refreshStar(arg_33_0)
	local var_33_0 = luaLang("autochess_malllevelupview_level")

	UISpriteSetMgr.instance:setAutoChessSprite(arg_33_0.imageLevel, "v2a5_autochess_levelbg_" .. arg_33_0.data.star)

	arg_33_0.txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_33_0, arg_33_0.data.star)

	local var_33_1 = arg_33_0.data.maxExpLimit

	if var_33_1 == 0 then
		gohelper.setActive(arg_33_0.goStar, false)
	else
		for iter_33_0 = 1, 3 do
			local var_33_2 = arg_33_0["goStar" .. iter_33_0]

			gohelper.setActive(var_33_2, iter_33_0 <= var_33_1)
		end

		gohelper.setActive(arg_33_0.goStar, true)
	end
end

function var_0_0.checkHpFloat(arg_34_0)
	local var_34_0 = Time.time

	for iter_34_0 = #arg_34_0.floatItemList, 1, -1 do
		local var_34_1 = arg_34_0.floatItemList[iter_34_0]

		if var_34_0 - var_34_1.time >= 1 then
			gohelper.setActive(var_34_1.go, false)

			arg_34_0.floatItemCacheList[#arg_34_0.floatItemCacheList + 1] = var_34_1

			table.remove(arg_34_0.floatItemList, iter_34_0)
		end
	end

	if #arg_34_0.floatItemList == 0 then
		TaskDispatcher.cancelTask(arg_34_0.checkHpFloat, arg_34_0)
	end
end

function var_0_0.flyStar(arg_35_0)
	local var_35_0 = arg_35_0.config.levelFromMall

	var_35_0 = var_35_0 < 5 and var_35_0 or 5

	for iter_35_0 = 1, var_35_0 do
		gohelper.setActive(arg_35_0["goFlyStar" .. iter_35_0], true)
	end

	gohelper.setActive(arg_35_0.goFlyStar, true)
	TaskDispatcher.runDelay(arg_35_0.delayFly, arg_35_0, 0.6)
end

function var_0_0.delayFly(arg_36_0)
	local var_36_0 = AutoChessModel.instance:getChessMo().lastSvrFight
	local var_36_1

	if arg_36_0.teamType == AutoChessEnum.TeamType.Player then
		var_36_1 = var_36_0.mySideMaster.uid
	else
		var_36_1 = var_36_0.enemyMaster.uid
	end

	local var_36_2 = AutoChessEntityMgr.instance:getLeaderEntity(var_36_1)

	if var_36_2 then
		local var_36_3, var_36_4, var_36_5 = transformhelper.getPos(var_36_2.go.transform)
		local var_36_6 = recthelper.rectToRelativeAnchorPos(Vector3(var_36_3, var_36_4, var_36_5), arg_36_0.goFlyStar.transform)
		local var_36_7 = arg_36_0.config.levelFromMall

		var_36_7 = var_36_7 < 5 and var_36_7 or 5

		for iter_36_0 = 1, var_36_7 do
			local var_36_8 = arg_36_0["goFlyStar" .. iter_36_0].transform

			ZProj.TweenHelper.DOAnchorPos(var_36_8, var_36_6.x, var_36_6.y, 0.5)
		end
	end
end

return var_0_0
