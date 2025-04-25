module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessEntity", package.seeall)

slot0 = class("AutoChessEntity", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
	slot0.goEntity = gohelper.findChild(slot1, "ani/Entity")
	slot0.dirTrs = slot0.goEntity.transform
	slot0.goMesh = gohelper.findChild(slot1, "ani/Entity/Mesh")
	slot0.goBar = gohelper.findChild(slot1, "ani/ChessBar")
	slot0.goAttack = gohelper.findChild(slot0.goBar, "go_Attack")
	slot0.txtAttack = gohelper.findChildText(slot0.goBar, "go_Attack/txt_Attack")
	slot0.goHp = gohelper.findChild(slot0.goBar, "go_Hp")
	slot0.txtHp = gohelper.findChildText(slot0.goBar, "go_Hp/txt_Hp")
	slot0.imageLevel = gohelper.findChildImage(slot0.goBar, "image_Level")
	slot0.txtLevel = gohelper.findChildText(slot0.goBar, "Exp/txt_Level")
	slot0.goStar = gohelper.findChild(slot0.goBar, "Exp/go_Star")
	slot0.golvup = gohelper.findChild(slot0.goBar, "Exp/go_lvup")
	slot0.goStar1 = gohelper.findChild(slot0.goBar, "Exp/go_Star/go_Star1")
	slot0.imageLight1 = gohelper.findChildImage(slot0.goBar, "Exp/go_Star/go_Star1/image_Light1")
	slot0.goStar2 = gohelper.findChild(slot0.goBar, "Exp/go_Star/go_Star2")
	slot0.imageLight2 = gohelper.findChildImage(slot0.goBar, "Exp/go_Star/go_Star2/image_Light2")
	slot0.goStar3 = gohelper.findChild(slot0.goBar, "Exp/go_Star/go_Star3")
	slot0.imageLight3 = gohelper.findChildImage(slot0.goBar, "Exp/go_Star/go_Star3/image_Light3")
	slot0.golvup = gohelper.findChild(slot0.goBar, "Exp/go_lvup")
	slot0.anim = gohelper.findChild(slot1, "ani"):GetComponent(gohelper.Type_Animator)
	slot0.goHpFloat = gohelper.findChild(slot0.goBar, "go_HpFloat")
	slot0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goMesh, AutoChessMeshComp)
	slot0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goEntity, AutoChessEffectComp)
	slot0.floatItemList = {}
	slot0.floatItemCacheList = {}
	slot0.animStar1 = slot0.goStar1:GetComponent(gohelper.Type_Animator)
	slot0.animStar2 = slot0.goStar2:GetComponent(gohelper.Type_Animator)
	slot0.animStar3 = slot0.goStar3:GetComponent(gohelper.Type_Animator)
	slot0.goFlyStar = gohelper.findChild(slot1, "ani/go_FlyStar")
	slot0.goFlyStar1 = gohelper.findChild(slot1, "ani/go_FlyStar/star1")
	slot0.goFlyStar2 = gohelper.findChild(slot1, "ani/go_FlyStar/star2")
	slot0.goFlyStar3 = gohelper.findChild(slot1, "ani/go_FlyStar/star3")
	slot0.goFlyStar4 = gohelper.findChild(slot1, "ani/go_FlyStar/star4")
	slot0.goFlyStar5 = gohelper.findChild(slot1, "ani/go_FlyStar/star5")

	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntity, slot0.onDragChess, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, slot0.onDragChessEnd, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, slot0.onDragChess, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, slot0.onDragChessEnd, slot0)
end

function slot0.onDragChess(slot0, slot1)
	if slot0.data.id == slot1 and slot0.data.maxExpLimit ~= 0 then
		slot0.lightIndex = slot0.data.exp + 1

		gohelper.setActive(slot0["imageLight" .. slot0.lightIndex].gameObject, true)
		slot0["animStar" .. slot0.lightIndex]:Play("loop", 0, 0)
	end
end

function slot0.onDragChessEnd(slot0)
	if slot0.lightIndex then
		slot0["animStar" .. slot0.lightIndex]:Play("idle", 0, 0)
		gohelper.setActive(slot0["imageLight" .. slot0.lightIndex].gameObject, false)

		slot0.lightIndex = nil
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.delayFly, slot0)
	TaskDispatcher.cancelTask(slot0.checkHpFloat, slot0)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0:initChessData(slot1)

	slot0.warZone = slot2
	slot0.index = slot3
	slot0.teamType = slot0.data.teamType
	slot0.config = lua_auto_chess.configDict[slot1.id][slot1.star]
	slot0.skillIds = {}

	if not string.nilorempty(slot0.config.skillIds) then
		slot0.skillIds = string.splitToNumber(slot0.config.skillIds, "#")
	end

	transformhelper.setLocalScale(slot0.dirTrs, slot0.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1, 1, 1)
	slot0.meshComp:setData(slot0.config.image, slot0.teamType == AutoChessEnum.TeamType.Enemy)
	slot0:refreshUI()
	slot0:show()
end

function slot0.updateIndex(slot0, slot1, slot2)
	slot0.warZone = slot1
	slot0.index = slot2

	slot0:show()
end

function slot0.updateLocation(slot0)
	slot0.pos = AutoChessGameModel.instance:getChessLocation(slot0.warZone, slot0.index + 1)

	recthelper.setAnchor(slot0.transform, slot0.pos.x, slot0.pos.y)
end

function slot0.setScale(slot0, slot1)
	transformhelper.setLocalScale(slot0.transform, slot1, slot1, slot1)
end

function slot0.initChessData(slot0, slot1)
	slot0.data = slot1
	slot0.data.battle = tonumber(slot0.data.battle)
	slot0.data.hp = tonumber(slot0.data.hp)
end

function slot0.updateChessData(slot0, slot1)
	slot0.data.id = slot1.id
	slot0.data.uid = slot1.uid
	slot0.data.star = slot1.star
	slot0.data.exp = slot1.exp
	slot0.data.maxExpLimit = slot1.maxExpLimit
	slot0.data.status = slot1.status
	slot0.data.hp = tonumber(slot1.hp)
	slot0.data.battle = tonumber(slot1.battle)
	slot0.data.skillContainer = slot1.skillContainer
	slot0.data.buffContainer = slot1.buffContainer
end

function slot0.move(slot0, slot1)
	slot0.pos = AutoChessGameModel.instance:getChessLocation(slot0.warZone, tonumber(slot1) + 1)

	ZProj.TweenHelper.DOAnchorPosX(slot0.transform, slot0.pos.x, AutoChessEnum.ChessAniTime.Jump)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_move)
	slot0.anim:Play("jump", 0, 0)
end

function slot0.attack(slot0)
	slot0.anim:Play("melee", 0, 0)
end

function slot0.ranged(slot0, slot1, slot2)
	gohelper.setAsLastSibling(slot0.go)
	slot0.anim:Play("attack", 0, 0)
	slot0.effectComp:playEffect(slot2.id)
	slot0.effectComp:moveEffect(slot2.nameUp, slot1, slot2.duration)
end

function slot0.skillAnim(slot0, slot1)
	slot0.anim:Play(slot1, 0, 0)

	return AutoChessEnum.ChessAniTime.Jump
end

function slot0.resetPos(slot0)
	ZProj.TweenHelper.DOAnchorPosX(slot0.transform, slot0.pos.x, 0.5)
end

function slot0.initBuffEffect(slot0)
	slot0.effectComp:hideAll()

	for slot4, slot5 in ipairs(slot0.data.buffContainer.buffs) do
		if lua_auto_chess_buff.configDict[slot5.id].buffeffectID ~= 0 and lua_auto_chess_effect.configDict[slot6].loop == 1 then
			slot0.effectComp:playEffect(slot7.id)
		end
	end

	if not string.nilorempty(slot0.config.tag) then
		slot0.effectComp:playEffect(AutoChessStrEnum.Tag2EffectId[slot1])
	end
end

function slot0.addBuffEffect(slot0, slot1)
	if lua_auto_chess_buff.configDict[slot1].buffeffectID ~= 0 then
		slot0.effectComp:playEffect(slot2.buffeffectID)
	end
end

function slot0.addBuff(slot0, slot1)
	slot0:addBuffEffect(slot1.id)
	table.insert(slot0.data.buffContainer.buffs, slot1)
end

function slot0.updateBuff(slot0, slot1)
	slot0:addBuffEffect(slot1.id)

	for slot6, slot7 in ipairs(slot0.data.buffContainer.buffs) do
		if slot7.uid == slot1.uid then
			slot2[slot6] = slot1

			break
		end
	end
end

function slot0.delBuff(slot0, slot1)
	slot3 = nil

	for slot7, slot8 in ipairs(slot0.data.buffContainer.buffs) do
		if slot8.uid == slot1 then
			slot3 = slot7

			break
		end
	end

	if slot3 then
		if lua_auto_chess_buff.configDict[slot2[slot3].id].buffeffectID ~= 0 then
			slot0.effectComp:removeEffect(slot5.buffeffectID)
		end

		table.remove(slot2, slot3)
	else
		logError(string.format("异常:未找到buffUid%s", slot1))
	end
end

function slot0.die(slot0, slot1)
	slot0.anim:Play("die", 0, 0)

	if slot1 and #slot0.skillIds ~= 0 and lua_auto_chess_skill.configDict[slot0.skillIds[1]].tag == "Die" and slot2.useeffect ~= 0 then
		slot0.effectComp:playEffect(slot2.useeffect)

		return slot2.useeffect
	end
end

function slot0.activeExpStar(slot0, slot1)
	gohelper.setActive(slot0.goStar, slot1)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.show(slot0)
	slot0:updateLocation()
	gohelper.setActive(slot0.go, true)
end

function slot0.updateHp(slot0, slot1)
	slot0.data.hp = slot0.data.hp + tonumber(slot1)

	slot0:refreshAttr()
end

function slot0.floatHp(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.checkHpFloat, slot0)
	TaskDispatcher.runRepeat(slot0.checkHpFloat, slot0, 0.5)

	slot2 = nil

	if #slot0.floatItemCacheList > 0 then
		slot2 = slot0.floatItemCacheList[slot3]
		slot0.floatItemCacheList[slot3] = nil
	else
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0.goHpFloat)
		slot2.anim = slot2.go:GetComponent(gohelper.Type_Animator)
		slot2.txtHpAdd = gohelper.findChildText(slot2.go, "txt_HpAdd")
		slot2.txtHpSub = gohelper.findChildText(slot2.go, "txt_HpSub")
	end

	slot2.time = Time.time
	slot0.floatItemList[#slot0.floatItemList + 1] = slot2

	gohelper.setActive(slot2.go, true)

	if tonumber(slot1) > 0 then
		slot2.txtHpAdd.text = "+" .. slot1

		slot2.anim:Play("hpadd", 0, 0)
	else
		slot2.txtHpSub.text = slot1

		slot2.anim:Play("hpsub", 0, 0)
	end
end

function slot0.updateBattle(slot0, slot1)
	slot0.data.battle = slot0.data.battle + tonumber(slot1)

	slot0:refreshAttr()
end

function slot0.updateExp(slot0, slot1)
	slot0.data.exp = slot0.data.maxExpLimit < tonumber(slot1) and slot0.data.maxExpLimit or slot1

	slot0:refreshExp()
end

function slot0.updateStar(slot0, slot1)
	slot0:initChessData(slot1)
	slot0:refreshUI()

	return slot0.effectComp:playEffect(50001)
end

function slot0.refreshUI(slot0)
	slot0:initBuffEffect()
	slot0:refreshAttr()
	slot0:refreshStar()
	slot0:refreshExp()
end

function slot0.refreshAttr(slot0)
	if slot0.warZone == AutoChessEnum.WarZone.Two then
		gohelper.setActive(slot0.goAttack, false)
		gohelper.setActive(slot0.goHp, false)
	else
		slot0.txtAttack.text = slot0.data.battle
		slot0.txtHp.text = slot0.data.hp

		gohelper.setActive(slot0.goAttack, true)
		gohelper.setActive(slot0.goHp, true)
	end
end

function slot0.refreshExp(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0["imageLight" .. slot4], slot4 <= slot0.data.exp)
	end
end

function slot0.refreshStar(slot0)
	UISpriteSetMgr.instance:setAutoChessSprite(slot0.imageLevel, "v2a5_autochess_levelbg_" .. slot0.data.star)

	slot0.txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_malllevelupview_level"), slot0.data.star)

	if slot0.data.maxExpLimit == 0 then
		gohelper.setActive(slot0.goStar, false)
	else
		for slot6 = 1, 3 do
			gohelper.setActive(slot0["goStar" .. slot6], slot6 <= slot2)
		end

		gohelper.setActive(slot0.goStar, true)
	end
end

function slot0.checkHpFloat(slot0)
	for slot6 = #slot0.floatItemList, 1, -1 do
		if Time.time - slot0.floatItemList[slot6].time >= 1 then
			gohelper.setActive(slot7.go, false)

			slot0.floatItemCacheList[#slot0.floatItemCacheList + 1] = slot7

			table.remove(slot0.floatItemList, slot6)
		end
	end

	if #slot0.floatItemList == 0 then
		TaskDispatcher.cancelTask(slot0.checkHpFloat, slot0)
	end
end

function slot0.flyStar(slot0)
	for slot5 = 1, slot0.config.levelFromMall < 5 and slot1 or 5 do
		gohelper.setActive(slot0["goFlyStar" .. slot5], true)
	end

	gohelper.setActive(slot0.goFlyStar, true)
	TaskDispatcher.runDelay(slot0.delayFly, slot0, 0.6)
end

function slot0.delayFly(slot0)
	slot1 = AutoChessModel.instance:getChessMo().lastSvrFight
	slot2 = nil

	if AutoChessEntityMgr.instance:getLeaderEntity((slot0.teamType ~= AutoChessEnum.TeamType.Player or slot1.mySideMaster.uid) and slot1.enemyMaster.uid) then
		slot4, slot5, slot6 = transformhelper.getPos(slot3.go.transform)
		slot7 = recthelper.rectToRelativeAnchorPos(Vector3(slot4, slot5, slot6), slot0.goFlyStar.transform)

		for slot12 = 1, slot0.config.levelFromMall < 5 and slot8 or 5 do
			ZProj.TweenHelper.DOAnchorPos(slot0["goFlyStar" .. slot12].transform, slot7.x, slot7.y, 0.5)
		end
	end
end

return slot0
