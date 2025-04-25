module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderEntity", package.seeall)

slot0 = class("AutoChessLeaderEntity", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
	slot0.goEntity = gohelper.findChild(slot1, "ani/Entity")
	slot0.dirTrs = slot0.goEntity.transform
	slot0.goMesh = gohelper.findChild(slot1, "ani/Entity/Mesh")
	slot2 = gohelper.findChild(slot1, "ani/Bar")
	slot0.goHp = gohelper.findChild(slot2, "Hp")
	slot0.txtHp = gohelper.findChildText(slot2, "Hp/txt_Hp")
	slot0.anim = gohelper.findChild(slot1, "ani"):GetComponent(gohelper.Type_Animator)
	slot0.hpChangeAnim = gohelper.findChild(slot2, "HpChange"):GetComponent(gohelper.Type_Animator)
	slot0.txtHpAdd = gohelper.findChildText(slot2, "HpChange/txt_HpAdd")
	slot0.txtHpSub = gohelper.findChildText(slot2, "HpChange/txt_HpSub")
	slot0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goMesh, AutoChessMeshComp)
	slot0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.goEntity, AutoChessEffectComp)
	slot0.goEnergyL = gohelper.findChild(slot1, "ani/go_EnergyL")
	slot0.txtEnergyL = gohelper.findChildText(slot1, "ani/go_EnergyL/txt_EnergyL")
	slot0.goEnergyR = gohelper.findChild(slot1, "ani/go_EnergyR")
	slot0.txtEnergyR = gohelper.findChildText(slot1, "ani/go_EnergyR/txt_EnergyR")
end

function slot0.onDestroy(slot0)
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1
	slot0.data.hp = tonumber(slot1.hp)
	slot0.config = lua_auto_chess_master.configDict[slot0.data.id]

	transformhelper.setLocalScale(slot0.dirTrs, slot0.data.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1, 1, 1)

	slot0.isEnemey = slot0.data.teamType == AutoChessEnum.TeamType.Enemy

	if slot0.isEnemey then
		recthelper.setAnchorX(slot0.goHp.transform, 130)
	end

	slot0.meshComp:setData(slot0.config.image, slot0.isEnemey, true)
	slot0:updateHp(0)
	slot0:show()
end

function slot0.attack(slot0)
	slot0.anim:Play("attack", 0, 0)
end

function slot0.skillAnim(slot0, slot1)
	slot0.anim:Play(slot1, 0, 0)

	return 0.44
end

function slot0.ranged(slot0, slot1, slot2)
	slot3 = lua_auto_chess_effect.configDict[slot2]

	gohelper.setAsLastSibling(slot0.go)
	slot0.anim:Play("attack", 0, 0)
	slot0.effectComp:playEffect(slot2)
	slot0.effectComp:moveEffect(slot3.nameUp, slot1, slot3.duration)

	return slot3.duration
end

function slot0.updateHp(slot0, slot1)
	slot0.data.hp = slot0.data.hp + tonumber(slot1)
	slot0.txtHp.text = slot0.data.hp
end

function slot0.floatHp(slot0, slot1)
	if tonumber(slot1) > 0 then
		slot0.txtHpAdd.text = "+" .. slot1

		slot0.hpChangeAnim:Play("hpadd", 0, 0)
	else
		slot0.txtHpSub.text = slot1

		slot0.hpChangeAnim:Play("hpsub", 0, 0)
		slot0.effectComp:playEffect(20001)
	end
end

function slot0.addBuff(slot0, slot1)
	table.insert(slot0.data.buffContainer.buffs, slot1)

	if slot1.id == 1004 or slot1.id == 1005 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
		slot0:refreshEnergy()
	end
end

function slot0.updateBuff(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.data.buffContainer.buffs) do
		if slot7.uid == slot1.uid then
			slot2[slot6] = slot1

			break
		end
	end

	if slot1.id == 1004 or slot1.id == 1005 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
		slot0:refreshEnergy()
	end
end

function slot0.delBuff(slot0, slot1)
	slot3 = nil

	for slot7, slot8 in ipairs(slot0.data.buffContainer.buffs) do
		if slot8.uid == slot1 then
			slot3 = slot7

			if slot8.id == 1004 or slot8.id == 1005 then
				AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
				slot0:refreshEnergy()
			end

			break
		end
	end

	if slot3 then
		table.remove(slot2, slot3)
	else
		logError(string.format("异常:移除了不存在的棋子UID%s", slot1))
	end
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.show(slot0)
	slot0.pos = AutoChessGameModel.instance:getLeaderLocation(slot0.data.teamType)

	if slot0.pos then
		recthelper.setAnchor(slot0.transform, slot0.pos.x, slot0.pos.y)
		gohelper.setActive(slot0.go, true)
	end
end

function slot0.showEnergy(slot0)
	slot0.needShowEnergy = true

	slot0:refreshEnergy()
end

function slot0.refreshEnergy(slot0)
	if not slot0.needShowEnergy then
		return
	end

	if AutoChessHelper.getBuffEnergy(slot0.data.buffContainer.buffs) == 0 then
		gohelper.setActive(slot0.goEnergyL, false)
		gohelper.setActive(slot0.goEnergyR, false)

		return
	end

	if slot0.isEnemey then
		slot0.txtEnergyR.text = slot1

		gohelper.setActive(slot0.goEnergyR, true)
	else
		slot0.txtEnergyL.text = slot1

		gohelper.setActive(slot0.goEnergyL, true)
	end
end

return slot0
