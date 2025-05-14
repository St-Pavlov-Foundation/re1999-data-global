module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessLeaderEntity", package.seeall)

local var_0_0 = class("AutoChessLeaderEntity", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.goEntity = gohelper.findChild(arg_1_1, "ani/Entity")
	arg_1_0.dirTrs = arg_1_0.goEntity.transform
	arg_1_0.goMesh = gohelper.findChild(arg_1_1, "ani/Entity/Mesh")

	local var_1_0 = gohelper.findChild(arg_1_1, "ani/Bar")

	arg_1_0.goHp = gohelper.findChild(var_1_0, "Hp")
	arg_1_0.txtHp = gohelper.findChildText(var_1_0, "Hp/txt_Hp")
	arg_1_0.anim = gohelper.findChild(arg_1_1, "ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0.hpChangeAnim = gohelper.findChild(var_1_0, "HpChange"):GetComponent(gohelper.Type_Animator)
	arg_1_0.txtHpAdd = gohelper.findChildText(var_1_0, "HpChange/txt_HpAdd")
	arg_1_0.txtHpSub = gohelper.findChildText(var_1_0, "HpChange/txt_HpSub")
	arg_1_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goMesh, AutoChessMeshComp)
	arg_1_0.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.goEntity, AutoChessEffectComp)
	arg_1_0.goEnergyL = gohelper.findChild(arg_1_1, "ani/go_EnergyL")
	arg_1_0.txtEnergyL = gohelper.findChildText(arg_1_1, "ani/go_EnergyL/txt_EnergyL")
	arg_1_0.goEnergyR = gohelper.findChild(arg_1_1, "ani/go_EnergyR")
	arg_1_0.txtEnergyR = gohelper.findChildText(arg_1_1, "ani/go_EnergyR/txt_EnergyR")
end

function var_0_0.onDestroy(arg_2_0)
	return
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1
	arg_3_0.data.hp = tonumber(arg_3_1.hp)
	arg_3_0.config = lua_auto_chess_master.configDict[arg_3_0.data.id]

	local var_3_0 = arg_3_0.data.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1

	transformhelper.setLocalScale(arg_3_0.dirTrs, var_3_0, 1, 1)

	arg_3_0.isEnemey = arg_3_0.data.teamType == AutoChessEnum.TeamType.Enemy

	if arg_3_0.isEnemey then
		recthelper.setAnchorX(arg_3_0.goHp.transform, 130)
	end

	arg_3_0.meshComp:setData(arg_3_0.config.image, arg_3_0.isEnemey, true)
	arg_3_0:updateHp(0)
	arg_3_0:show()
end

function var_0_0.attack(arg_4_0)
	arg_4_0.anim:Play("attack", 0, 0)
end

function var_0_0.skillAnim(arg_5_0, arg_5_1)
	arg_5_0.anim:Play(arg_5_1, 0, 0)

	return 0.44
end

function var_0_0.ranged(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = lua_auto_chess_effect.configDict[arg_6_2]

	gohelper.setAsLastSibling(arg_6_0.go)
	arg_6_0.anim:Play("attack", 0, 0)
	arg_6_0.effectComp:playEffect(arg_6_2)
	arg_6_0.effectComp:moveEffect(var_6_0.nameUp, arg_6_1, var_6_0.duration)

	return var_6_0.duration
end

function var_0_0.updateHp(arg_7_0, arg_7_1)
	arg_7_1 = tonumber(arg_7_1)
	arg_7_0.data.hp = arg_7_0.data.hp + arg_7_1
	arg_7_0.txtHp.text = arg_7_0.data.hp
end

function var_0_0.floatHp(arg_8_0, arg_8_1)
	arg_8_1 = tonumber(arg_8_1)

	if arg_8_1 > 0 then
		arg_8_0.txtHpAdd.text = "+" .. arg_8_1

		arg_8_0.hpChangeAnim:Play("hpadd", 0, 0)
	else
		arg_8_0.txtHpSub.text = arg_8_1

		arg_8_0.hpChangeAnim:Play("hpsub", 0, 0)
		arg_8_0.effectComp:playEffect(20001)
	end
end

function var_0_0.addBuff(arg_9_0, arg_9_1)
	table.insert(arg_9_0.data.buffContainer.buffs, arg_9_1)

	if arg_9_1.id == 1004 or arg_9_1.id == 1005 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
		arg_9_0:refreshEnergy()
	end
end

function var_0_0.updateBuff(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.data.buffContainer.buffs

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.uid == arg_10_1.uid then
			var_10_0[iter_10_0] = arg_10_1

			break
		end
	end

	if arg_10_1.id == 1004 or arg_10_1.id == 1005 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
		arg_10_0:refreshEnergy()
	end
end

function var_0_0.delBuff(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.data.buffContainer.buffs
	local var_11_1

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.uid == arg_11_1 then
			var_11_1 = iter_11_0

			if iter_11_1.id == 1004 or iter_11_1.id == 1005 then
				AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateLeaderEnergy)
				arg_11_0:refreshEnergy()
			end

			break
		end
	end

	if var_11_1 then
		table.remove(var_11_0, var_11_1)
	else
		logError(string.format("异常:移除了不存在的棋子UID%s", arg_11_1))
	end
end

function var_0_0.hide(arg_12_0)
	gohelper.setActive(arg_12_0.go, false)
end

function var_0_0.show(arg_13_0)
	arg_13_0.pos = AutoChessGameModel.instance:getLeaderLocation(arg_13_0.data.teamType)

	if arg_13_0.pos then
		recthelper.setAnchor(arg_13_0.transform, arg_13_0.pos.x, arg_13_0.pos.y)
		gohelper.setActive(arg_13_0.go, true)
	end
end

function var_0_0.showEnergy(arg_14_0)
	arg_14_0.needShowEnergy = true

	arg_14_0:refreshEnergy()
end

function var_0_0.refreshEnergy(arg_15_0)
	if not arg_15_0.needShowEnergy then
		return
	end

	local var_15_0 = AutoChessHelper.getBuffEnergy(arg_15_0.data.buffContainer.buffs)

	if var_15_0 == 0 then
		gohelper.setActive(arg_15_0.goEnergyL, false)
		gohelper.setActive(arg_15_0.goEnergyR, false)

		return
	end

	if arg_15_0.isEnemey then
		arg_15_0.txtEnergyR.text = var_15_0

		gohelper.setActive(arg_15_0.goEnergyR, true)
	else
		arg_15_0.txtEnergyL.text = var_15_0

		gohelper.setActive(arg_15_0.goEnergyL, true)
	end
end

return var_0_0
