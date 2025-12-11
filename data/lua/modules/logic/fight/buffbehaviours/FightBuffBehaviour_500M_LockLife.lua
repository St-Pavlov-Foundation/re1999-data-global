module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_LockLife", package.seeall)

local var_0_0 = class("FightBuffBehaviour_500M_LockLife", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fighttowerbosshplock.prefab"

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.hpPointList = {}

	FightModel.instance:setMultiHpType(FightEnum.MultiHpType.Tower500M)

	arg_1_0.root = gohelper.findChild(arg_1_0.viewGo, "root/bossHpRoot/bossHp/Alpha/bossHp")
	arg_1_0.loader = PrefabInstantiate.Create(arg_1_0.root)

	arg_1_0.loader:startLoad(var_0_1, arg_1_0.onLoadFinish, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0.onBuffUpdate)
end

local var_0_2 = 102310003

function var_0_0.onBuffUpdate(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 ~= var_0_2 then
		return
	end

	arg_2_0:refreshUI()
end

function var_0_0.onLoadFinish(arg_3_0)
	arg_3_0.lockLifeGo = arg_3_0.loader:getInstGO()
	arg_3_0.goHpLock = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpLock")
	arg_3_0.goPointItem = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpPoint/#image_point")
	arg_3_0.goHpPoint = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpPoint")

	gohelper.setActive(arg_3_0.goHpLock, false)
	gohelper.setActive(arg_3_0.goPointItem, false)
	arg_3_0:refreshUI()
	FightController.instance:dispatchEvent(FightEvent.MultiHpTypeChange)
end

function var_0_0.refreshUI(arg_4_0)
	arg_4_0.hasLockHpBuff = false

	local var_4_0 = FightDataHelper.entityMgr:getAllEntityMO()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = iter_4_1:getBuffDic()

		for iter_4_2, iter_4_3 in pairs(var_4_1) do
			if iter_4_3.buffId == var_0_2 then
				arg_4_0.hasLockHpBuff = true
			end
		end
	end

	arg_4_0:refreshPoint()
	arg_4_0:refreshHP()
end

local var_0_3 = {
	"fight_tower_hp_0",
	"fight_tower_hp_1",
	"fight_tower_hp_2",
	"fight_tower_hp_3",
	"fight_tower_hp_4",
	"fight_tower_hp_5"
}

function var_0_0.refreshPoint(arg_5_0)
	local var_5_0 = arg_5_0:getBossMo()

	if not var_5_0 then
		gohelper.setActive(arg_5_0.goHpPoint, false)

		return
	end

	local var_5_1 = var_5_0.attrMO.multiHpNum

	if var_5_1 <= 1 then
		gohelper.setActive(arg_5_0.goHpPoint, false)

		return
	end

	if arg_5_0.hasLockHpBuff then
		gohelper.setActive(arg_5_0.goHpPoint, false)

		return
	end

	gohelper.setActive(arg_5_0.goHpPoint, true)

	local var_5_2 = var_5_0.attrMO:getCurMultiHpIndex()

	for iter_5_0 = 1, var_5_1 do
		local var_5_3 = arg_5_0.hpPointList[iter_5_0]

		if not var_5_3 then
			var_5_3 = arg_5_0:getUserDataTb_()
			var_5_3.go = gohelper.cloneInPlace(arg_5_0.goPointItem)
			var_5_3.image = var_5_3.go:GetComponent(gohelper.Type_Image)
		end

		gohelper.setActive(var_5_3.go, true)

		if iter_5_0 <= var_5_1 - var_5_2 then
			UISpriteSetMgr.instance:setFightTowerSprite(var_5_3.image, var_0_3[iter_5_0 + 1])
		else
			UISpriteSetMgr.instance:setFightTowerSprite(var_5_3.image, var_0_3[1])
		end
	end

	for iter_5_1 = var_5_1 + 1, #arg_5_0.hpPointList do
		local var_5_4 = arg_5_0.hpPointList[iter_5_1]

		if var_5_4 then
			gohelper.setActive(var_5_4.go, false)
		end
	end
end

function var_0_0.getBossMo(arg_6_0)
	local var_6_0 = FightModel.instance:getCurMonsterGroupId()
	local var_6_1 = var_6_0 and lua_monster_group.configDict[var_6_0]
	local var_6_2 = var_6_1 and not string.nilorempty(var_6_1.bossId) and var_6_1.bossId

	if not var_6_2 then
		return
	end

	local var_6_3 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_6_0, iter_6_1 in ipairs(var_6_3) do
		if FightHelper.isBossId(var_6_2, iter_6_1.modelId) then
			return iter_6_1
		end
	end
end

function var_0_0.refreshHP(arg_7_0)
	gohelper.setActive(arg_7_0.goHpLock, arg_7_0.hasLockHpBuff)
end

function var_0_0.onUpdateBuff(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	return
end

function var_0_0.onRemoveBuff(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	gohelper.destroy(arg_9_0.lockLifeGo)
	FightModel.instance:setMultiHpType(nil)
	FightController.instance:dispatchEvent(FightEvent.MultiHpTypeChange)
end

function var_0_0.onDestroy(arg_10_0)
	if arg_10_0.loader then
		arg_10_0.loader:dispose()

		arg_10_0.loader = nil
	end

	FightModel.instance:setMultiHpType(nil)
	var_0_0.super.onDestroy(arg_10_0)
end

return var_0_0
