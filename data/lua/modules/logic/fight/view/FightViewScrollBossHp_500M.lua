module("modules.logic.fight.view.FightViewScrollBossHp_500M", package.seeall)

local var_0_0 = class("FightViewScrollBossHp_500M", FightViewSurvivalBossHp)
local var_0_1 = "ui/viewres/fight/fighttower/fighttowerbosshplock.prefab"

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0.hpPointList = {}
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp")
	arg_1_0.loader = PrefabInstantiate.Create(arg_1_0.root)

	arg_1_0.loader:startLoad(var_0_1, arg_1_0.onLoadFinish, arg_1_0)
	arg_1_0:initPlayedPoSuiAnimPoint()
end

function var_0_0.initPlayedPoSuiAnimPoint(arg_2_0)
	arg_2_0.playedPoSuiAnimPointDict = {}

	local var_2_0 = arg_2_0:_getBossEntityMO()

	if var_2_0 then
		local var_2_1 = var_2_0.attrMO:getCurMultiHpIndex()

		for iter_2_0 = 1, var_2_1 do
			arg_2_0.playedPoSuiAnimPointDict[iter_2_0] = true
		end
	end
end

function var_0_0.onLoadFinish(arg_3_0)
	arg_3_0.lockLifeGo = arg_3_0.loader:getInstGO()
	arg_3_0.goHpLock = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpLock")
	arg_3_0.lockHpAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_3_0.goHpLock)
	arg_3_0.goPointItem = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpPoint/#image_point")
	arg_3_0.goHpPoint = gohelper.findChild(arg_3_0.lockLifeGo, "go_hpPoint")

	gohelper.setActive(arg_3_0.goHpLock, false)
	gohelper.setActive(arg_3_0.goPointItem, false)
	arg_3_0:_detectBossMultiHp()
end

local var_0_2 = 102310003

function var_0_0._onBuffUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	var_0_0.super._onBuffUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)

	if arg_4_3 ~= var_0_2 then
		return
	end

	arg_4_0:_detectBossMultiHp()
end

function var_0_0._detectBossMultiHp(arg_5_0)
	gohelper.setActive(arg_5_0._multiHpRoot, false)

	arg_5_0.hasLockHpBuff = false

	local var_5_0 = FightDataHelper.entityMgr:getAllEntityMO()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = iter_5_1:getBuffDic()

		for iter_5_2, iter_5_3 in pairs(var_5_1) do
			if iter_5_3.buffId == var_0_2 then
				arg_5_0.hasLockHpBuff = true

				break
			end
		end

		if arg_5_0.hasLockHpBuff then
			break
		end
	end

	arg_5_0:refreshPoint_500M()
	arg_5_0:refreshLockHp_500M()
end

function var_0_0.refreshPoint_500M(arg_6_0)
	local var_6_0 = arg_6_0._bossEntityMO

	if not var_6_0 then
		gohelper.setActive(arg_6_0.goHpPoint, false)

		return
	end

	local var_6_1 = var_6_0.attrMO.multiHpNum

	if var_6_1 <= 1 then
		gohelper.setActive(arg_6_0.goHpPoint, false)

		return
	end

	gohelper.setActive(arg_6_0.goHpPoint, true)

	local var_6_2 = var_6_0.attrMO:getCurMultiHpIndex()

	for iter_6_0 = 1, var_6_1 do
		local var_6_3 = arg_6_0.hpPointList[iter_6_0]

		if not var_6_3 then
			var_6_3 = arg_6_0:getUserDataTb_()
			var_6_3.go = gohelper.cloneInPlace(arg_6_0.goPointItem)
			var_6_3.image = var_6_3.go:GetComponent(gohelper.Type_Image)
			arg_6_0.hpPointList[iter_6_0] = var_6_3

			gohelper.setAsFirstSibling(var_6_3.go)
		end

		gohelper.setActive(var_6_3.go, true)

		if var_6_2 < iter_6_0 then
			local var_6_4 = lua_fight_tower_500m_boss_behaviour.configDict[iter_6_0]
			local var_6_5 = var_6_4 and var_6_4.param1

			if var_6_5 then
				UISpriteSetMgr.instance:setFightTowerSprite(var_6_3.image, var_6_5)
			end
		else
			UISpriteSetMgr.instance:setFightTowerSprite(var_6_3.image, "fight_tower_hp_0")

			if not arg_6_0.playedPoSuiAnimPointDict[iter_6_0] then
				arg_6_0.playedPoSuiAnimPointDict[iter_6_0] = true

				local var_6_6 = gohelper.findChild(var_6_3.go, "ani_posui")

				gohelper.setActive(var_6_6, true)
				var_6_6:GetComponent(gohelper.Type_Animation):Play()
			end
		end
	end

	for iter_6_1 = var_6_1 + 1, #arg_6_0.hpPointList do
		local var_6_7 = arg_6_0.hpPointList[iter_6_1]

		if var_6_7 then
			gohelper.setActive(var_6_7.go, false)
		end
	end
end

function var_0_0.refreshLockHp_500M(arg_7_0)
	if arg_7_0.hasLockHpBuff then
		gohelper.setActive(arg_7_0.goHpLock, true)

		if not arg_7_0.playedLockHpAudio then
			arg_7_0.playedLockHpAudio = true

			AudioMgr.instance:trigger(310002)
		end

		return
	end

	if arg_7_0.goHpLock.activeInHierarchy then
		arg_7_0.lockHpAnimatorPlayer:Play("close", arg_7_0.onCloseCallback, arg_7_0)

		arg_7_0.playedLockHpAudio = false

		AudioMgr.instance:trigger(310003)
	end
end

function var_0_0.onCloseCallback(arg_8_0)
	gohelper.setActive(arg_8_0.goHpLock, false)
	arg_8_0:_detectBossMultiHp()
end

local var_0_3 = {
	0.2,
	0.4,
	0.6,
	0.8,
	1
}
local var_0_4 = {
	{
		"#B33E2D",
		"#6F2216"
	},
	{
		"#D9852B",
		"#693700"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	},
	{
		"#69995E",
		"#243B1E"
	}
}

function var_0_0.refreshHpColor(arg_9_0)
	if not arg_9_0._bossEntityMO then
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.hp, "#B33E2D")
		gohelper.setActive(arg_9_0.bgHpGo, false)

		return
	end

	local var_9_0 = FightHelper.getBossCurStageCo_500M(arg_9_0._bossEntityMO)

	if not var_9_0 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.hp, "#B33E2D")
		gohelper.setActive(arg_9_0.bgHpGo, false)

		return
	end

	local var_9_1 = arg_9_0.tweenHp

	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.hp, string.format("#%s", var_9_0.hpColor))

	if var_9_1 <= arg_9_0.oneMaxHp then
		local var_9_2 = var_9_0.level + 1
		local var_9_3 = lua_fight_tower_500m_boss_behaviour.configDict[var_9_2]

		if not var_9_3 then
			gohelper.setActive(arg_9_0.bgHpGo, false)
		else
			gohelper.setActive(arg_9_0.bgHpGo, true)
			SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.bgHp, string.format("#%s", var_9_3.hpBgColor))
		end
	else
		gohelper.setActive(arg_9_0.bgHpGo, true)
		SLFramework.UGUI.GuiHelper.SetColor(arg_9_0.bgHp, string.format("#%s", var_9_0.hpBgColor))
	end
end

function var_0_0.getThreshold(arg_10_0)
	return var_0_3
end

function var_0_0.getColor(arg_11_0)
	return var_0_4
end

function var_0_0.refreshImageIcon(arg_12_0)
	if not arg_12_0._bossEntityMO then
		return
	end

	local var_12_0 = arg_12_0._bossEntityMO.modelId
	local var_12_1 = lua_fight_sp_500m_model.configDict[var_12_0]
	local var_12_2 = var_12_1 and var_12_1.headIconName

	if not string.nilorempty(var_12_2) then
		gohelper.setActive(arg_12_0._imgHead.gameObject, true)
		gohelper.getSingleImage(arg_12_0._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_12_2))

		local var_12_3 = lua_monster.configDict[arg_12_0._bossEntityMO.modelId]

		if var_12_3.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(var_12_3.heartVariantId), arg_12_0._imgHeadIcon)
		end
	else
		gohelper.setActive(arg_12_0._imgHead.gameObject, false)
	end
end

return var_0_0
